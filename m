Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E94C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 14:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF7120830
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 14:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mxJeMKT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF7120830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG207-0007V1-3g
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 10:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG1zE-00071B-3h
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG1zD-0001AQ-2n
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:21:44 -0400
Received: from mail-eopbgr150131.outbound.protection.outlook.com
 ([40.107.15.131]:27467 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iG1zA-000199-2K; Thu, 03 Oct 2019 10:21:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGIQgOlWoyG9+2mSnYJ2B6i/Z8brQ5vwgElsi9sVrsqQz2QkQfFx3eFc8TA073DO9frFRUdieMHgjbiY5Xrw3yRnf5EDvNFU1i5sp55nnO1ZW8Ps3jw3ZTsYKgd0+ExsKR8KVaykM8yvvG+jFFSLV/13k5KSAa6J/qn3/rcqiY+UKWCkOxUK2RsPHdAYY+QiUlKesf3y8vs/+MRjb2y8RCWF/OTipxVw25xyFMUNIbdgGkFSSAIjb5KRgxStrWPEZDMMP8Jtv4xK1kcZG1t50JSOvpwUes7kU6ibQkF5VmZl6wMq9dKL3uO7ftcHQVcZCbJhU14bwXfi3cmg+sbYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktD9S4VA0dKCXmtXd+VRN4yGlmfLHnoxrlbZ5B7Y1B0=;
 b=FT4cHFi+JEyGNuwORvaazpARzHbAuBM20j3VwlSwMuAPrWKsjLSeNlKJmz4zFBwM5OU8Sz5V+eS/8OhK8ib6Ppx7U0IOkK8GHwG0hmrdt1Omom4YV1TfOi8iWqsKOYKWkp30B/YCJ8sRaDKXHQEa9myfGaAuVBoVWby2Z0jIuu/eLsdkVIRkDMOLi7+1swNePJj3Okb/zqPocBZGBp8MMp2J1Q25Q9+7WJ6QnYjCTYuOqlB7rzd0KB547Oj/xb+cCXI/KB+u6Sp29iP4wJ1OoM1bVnSHVRk7510jmazn2S6+lOhvfAtQ5uvvcd8v6C3t2vnYQ3j59mgi7/8oVXC7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktD9S4VA0dKCXmtXd+VRN4yGlmfLHnoxrlbZ5B7Y1B0=;
 b=mxJeMKT2DDjGpMPq27WJ7WFxEHoDOKBipOtX4TEfrXMiS6NlPnhmUkIHAO3S2PHdWoJsHkQ6wuF8V79rXtuFmzRm0y6qNhJwrPqNUCEvVhw7Q/t1SI0/pjbFj7ju98BkHP6STGGntOHuFZyS6eo0LY6rBHlnHcojKYW/y0ltMTA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5515.eurprd08.prod.outlook.com (52.133.243.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Thu, 3 Oct 2019 14:21:37 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 14:21:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 2/6] tests/qemu-iotests: add case of writing compressed
 data to multiple clusters
Thread-Topic: [PATCH v2 2/6] tests/qemu-iotests: add case of writing
 compressed data to multiple clusters
Thread-Index: AQHVeSznqMsDVFXGk0i7dhDrRG9nY6dI+V+A
Date: Thu, 3 Oct 2019 14:21:37 +0000
Message-ID: <58007c37-a8b1-ecfb-7b4a-3b65ee3a32df@virtuozzo.com>
References: <1570026166-748566-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1570026166-748566-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1570026166-748566-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0050.eurprd04.prod.outlook.com
 (2603:10a6:3:19::18) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191003172135022
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 657e7d67-7912-405c-c4ad-08d7480d0042
x-ms-traffictypediagnostic: DB8PR08MB5515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5515A8AA2A8EFF69AC36EAE2C19F0@DB8PR08MB5515.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(136003)(376002)(396003)(39840400004)(199004)(189003)(386003)(6506007)(7416002)(86362001)(478600001)(256004)(76176011)(305945005)(102836004)(25786009)(14454004)(52116002)(2201001)(31686004)(316002)(7736002)(71200400001)(71190400001)(26005)(31696002)(110136005)(36756003)(99286004)(54906003)(186003)(4326008)(5660300002)(107886003)(6246003)(6512007)(66476007)(66556008)(66946007)(11346002)(229853002)(6436002)(3846002)(66446008)(64756008)(6116002)(6486002)(2616005)(8936002)(2501003)(8676002)(66066001)(476003)(81156014)(81166006)(2906002)(486006)(446003)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5515;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aud9JO7QZT+Ita+GAgUF6CSHxJNueEempj4Kl3N2kGMuLhfK99mFdcvYDwPcAVUIdgpAJI5Ii4SQxt8vkypF5Kq5LnMJkIAF2fogz2Hfh4D6rFmDVHkIWvdGKRRq0dn9OlUeZEkDvN1FOx9ilkDSKFhC5KhmO4FrnhU4brFeaFsyK97Uj/MAM8iLercQjLNcRIKOLbfyeBIGEqqCdUqeT+oylHGWlLoAzD0e/wBbKkkSl02A9OOvpa9sSIqpTGRLqob37Oh6nsIVO63P9Qbp1gOCo6t7UaCFq69+v4PoGckffHAgtchQXnJYZr0qsQoHWt9KdxXeUGz6oHX4E5Q1mJ7TliqJBddiCWl7lg3M1g0NHw2Xt6R7BTcC0SCHvFO6OMpQoHJru1m95s9X/nRF5Y3XAoVEio6v42wVXgbZj6w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E3CAFCAD6B2854CB53BF13C87EC2AF9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657e7d67-7912-405c-c4ad-08d7480d0042
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 14:21:37.3906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1vzsUHbciNatQER/+qZSJpGbuem0F+7d9z37ifse/jskVX2wTZH0S4JSeFRUqYxMbmkOdGhzxJZ/FD2PbgSdVZhsqIOwUfLDm25IBhmKyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5515
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.131
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMTAuMjAxOSAxNzoyMiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IEFkZCB0aGUgdGVz
dCBjYXNlIHRvIHRoZSBpb3Rlc3QgIzIxNCB0aGF0IGNoZWNrcyBwb3NzaWJpbGl0eSBvZiB3cml0
aW5nDQo+IGNvbXByZXNzZWQgZGF0YSB0byBtb3JlIHRoYW4gb25lIGNsdXN0ZXIuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVv
enpvLmNvbT4NCj4gLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzIxNCAgICAgfCA5ICsrKysr
KysrKw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yMTQub3V0IHwgNiArKysrKysNCj4gICAyIGZp
bGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9x
ZW11LWlvdGVzdHMvMjE0IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzIxNA0KPiBpbmRleCAyMWVjOGEy
Li41ZjQzN2U0IDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMjE0DQo+ICsrKyBi
L3Rlc3RzL3FlbXUtaW90ZXN0cy8yMTQNCj4gQEAgLTg5LDYgKzg5LDE1IEBAIF9jaGVja190ZXN0
X2ltZyAtciBhbGwNCj4gICAkUUVNVV9JTyAtYyAicmVhZCAgLVAgMHgxMSAgMCA0TSIgIiRURVNU
X0lNRyIgMj4mMSB8IF9maWx0ZXJfcWVtdV9pbyB8IF9maWx0ZXJfdGVzdGRpcg0KPiAgICRRRU1V
X0lPIC1jICJyZWFkICAtUCAweDIyIDRNIDRNIiAiJFRFU1RfSU1HIiAyPiYxIHwgX2ZpbHRlcl9x
ZW11X2lvIHwgX2ZpbHRlcl90ZXN0ZGlyDQo+ICAgDQo+ICtlY2hvDQo+ICtlY2hvICI9PT0gV3Jp
dGUgY29tcHJlc3NlZCBkYXRhIHRvIG11bHRpcGxlIGNsdXN0ZXJzID09PSINCj4gK2VjaG8NCj4g
KyMgQ3JlYXRlIGFuIGVtcHR5IGltYWdlIGFuZCBmaWxsIHRocmVlIGFuZCBoYWxmIGNsdXN0ZXJz
IHdpdGggY29tcHJlc3NlZCBkYXRhLg0KDQpIbW0sIGJ1dCB3ZSBzdXBwb3J0IG9ubHkgYWxpZ25l
ZCB0byBjbHVzdGVyIHdyaXRlcywgaXNuJ3QgaXQ/IFdpdGggdGhlIG9ubHkgZXhjZXB0aW9uIGZv
cg0KbGFzdCBjbHVzdGVyIG9mIHRoZSBpbWFnZT8NCg0KPiArX21ha2VfdGVzdF9pbWcgMk0gLW8g
Y2x1c3Rlcl9zaXplPTB4MTAwMDANCj4gK2RhdGFfc2l6ZT0zKjB4MTAwMDArMHg4MDAwDQoNCmRh
dGFfc2l6ZSBpcyB1bnVzZWQuDQoNCj4gKyRRRU1VX0lPIC1jICJ3cml0ZSAtYyAtUCAweDExIDAg
MjU2ayIgIiRURVNUX0lNRyIgXA0KPiArICAgICAgICAgMj4mMSB8IF9maWx0ZXJfcWVtdV9pbyB8
IF9maWx0ZXJfdGVzdGRpcg0KPiArDQoNCndpbGwgYmUgZ29vZCB0byBjaGVjayBpbWcgYW5kIHBy
aW50IHFlbXUgaW1nIG1hcCAob3Igc29tZXRoaW5nIGxpa2UgdGhpcykgdG8gc2VlIHRoZXNlDQpj
b21wcmVzc2VkIGNsdXN0ZXJzLg0KDQo+ICAgIyBzdWNjZXNzLCBhbGwgZG9uZQ0KPiAgIGVjaG8g
JyoqKiBkb25lJw0KPiAgIHJtIC1mICRzZXEuZnVsbA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVt
dS1pb3Rlc3RzLzIxNC5vdXQgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjE0Lm91dA0KPiBpbmRleCAw
ZmNkOGRjLi4yYjkwOGY2IDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMjE0Lm91
dA0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjE0Lm91dA0KPiBAQCAtMzIsNCArMzIsMTAg
QEAgcmVhZCA0MTk0MzA0LzQxOTQzMDQgYnl0ZXMgYXQgb2Zmc2V0IDANCj4gICA0IE1pQiwgWCBv
cHM7IFhYOlhYOlhYLlggKFhYWCBZWVkvc2VjIGFuZCBYWFggb3BzL3NlYykNCj4gICByZWFkIDQx
OTQzMDQvNDE5NDMwNCBieXRlcyBhdCBvZmZzZXQgNDE5NDMwNA0KPiAgIDQgTWlCLCBYIG9wczsg
WFg6WFg6WFguWCAoWFhYIFlZWS9zZWMgYW5kIFhYWCBvcHMvc2VjKQ0KPiArDQo+ICs9PT0gV3Jp
dGUgY29tcHJlc3NlZCBkYXRhIHRvIG11bHRpcGxlIGNsdXN0ZXJzID09PQ0KPiArDQo+ICtGb3Jt
YXR0aW5nICdURVNUX0RJUi90LklNR0ZNVCcsIGZtdD1JTUdGTVQgc2l6ZT0yMDk3MTUyDQo+ICt3
cm90ZSAyNjIxNDQvMjYyMTQ0IGJ5dGVzIGF0IG9mZnNldCAwDQo+ICsyNTYgS2lCLCBYIG9wczsg
WFg6WFg6WFguWCAoWFhYIFlZWS9zZWMgYW5kIFhYWCBvcHMvc2VjKQ0KPiAgICoqKiBkb25lDQo+
IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

