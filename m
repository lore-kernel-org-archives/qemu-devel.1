Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E2FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F61233A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="e8ye0GHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F61233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0sFx-0003ml-Cc
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 14:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0sF4-0003JA-Py
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0sF3-0001rs-LA
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:55:26 -0400
Received: from mail-eopbgr40111.outbound.protection.outlook.com
 ([40.107.4.111]:7286 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i0sEz-0001oo-Ii; Thu, 22 Aug 2019 14:55:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npdgrncn5s9bzySAnvUANsxTVBf0MyyXJBbQCC1qLhURGKFNN2tEFwN9laQ7PBZZPOvYKJX1+AbHXMavtUWlycRzY5ywEK/n1Lys1DZIL24VkAhIo/xNkwEKDAOtR4Fxl/agGdpGKj2zAp5c5OnYQP16qrUt4nO8QPXpS2/5PG0u4wZO+I+Ik7MXCaK/CdqmsphbRrCaHqilnS1DfsjCYPTH9Y864TKYQXwOSnh8CPmvZ6PYe+cFCT990qpTub5wo9ehGo5+HPKvBmRFVtfLlOR/Wo1krvyYrHF0WLBp6Iglj0LwIp2jAM6Pn6NOoiJXk1hqdtebg2VgIPFjicgNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpFpv/UIlE3Kf0YSraavAT2KYVYTv2jdsNVTROLfkJw=;
 b=R3NwcNJJ702IejVvAs1P2jMUqP1UMOLErnTri+qItff8qFV3WPPwxC1OVsqM5/PbFq37m5Wq31mRy2cW8WI0zyu/p05sd3LYkXKQO5k//sG/UqzdIfpjBTYr/etKoD9w/0j/TbvHC/N+WrUUpjTwn9H9DrfCVtR5SY+yzzYInIlOCVMy/I0VwOWD6ffHYXcugSVySeYjmRhq8GZR3nQblofthrYhDfY+Ocvg3WkXO7lB8Z0kbhPB+bXVZPJH2eUbLBMakF+SJOOJ51McMaQ00lG4MgSqbVIRAHIhMegiPcCiZaZfhzgSQ9fSYiZvVuCE4F2APRmvLKNu7DjZ1FptNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpFpv/UIlE3Kf0YSraavAT2KYVYTv2jdsNVTROLfkJw=;
 b=e8ye0GHokFVXMulr9Jg20sFeqk5fi0ax9u/d3/eAxTw9dQZfHAoiA6yZAeZUuWVHCNMjBNZxxRZuEK8ddtkRtqCDXta2ymDKW45heJanWbLj8ZNZZUEkXg0f8UyRG1qhlJg4JGEYHamU+kTeUCeZbgPefYNnl9hR/fTUPOlwrRo=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5210.eurprd08.prod.outlook.com (10.255.17.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.19; Thu, 22 Aug 2019 18:55:19 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 18:55:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH] block: workaround for unaligned byte range in fallocate()
Thread-Index: AQHVWRfHsUNESZceUEiCeTknvwr0NacHhBSA
Date: Thu, 22 Aug 2019 18:55:18 +0000
Message-ID: <0b9bfdf5-911f-595e-b941-28ab1e6c4d5f@virtuozzo.com>
References: <1566498661-53008-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1566498661-53008-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::31) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190822215515615
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c3772b3-9aeb-4a0b-d632-08d7273246b7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5210; 
x-ms-traffictypediagnostic: DB8PR08MB5210:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB52103D276C79EDA59DD5C3D8C1A50@DB8PR08MB5210.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:227;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(26005)(107886003)(31686004)(52116002)(316002)(6486002)(102836004)(446003)(478600001)(2906002)(6436002)(110136005)(476003)(14454004)(66066001)(11346002)(305945005)(86362001)(8676002)(386003)(6506007)(81166006)(81156014)(6116002)(2201001)(256004)(3846002)(14444005)(186003)(31696002)(8936002)(2616005)(76176011)(7736002)(4326008)(6512007)(25786009)(6246003)(36756003)(53936002)(229853002)(71200400001)(71190400001)(66476007)(66946007)(54906003)(5660300002)(66556008)(99286004)(486006)(2501003)(64756008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5210;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 32F0U4o00+3yHA+pX3WtfzGgssbIJhcaTQ5eawDoMXuIkANTBvwmSDpCWxQ6UKnmSJYDttvWuLO1HY1dExTccEiasw3eR88PQxX7fi1k+kUGEmeXJ0OI4McUgcE4mcvdJlfb1QdkUzkrJ41ewZI0urIGvVCnOd30Vwa9vb4NzX7OFRSOwMWNWKDmlpG6DrKPDRkmdYKYl7vv7SrcZiY11Wn4LsVW0KJcWIbdq2/X0ebFRbsjNKwvi0RXJk4F3v4NzWYWi9NxNzAAdXWWG+pclMbzqj8E0sdxcIEPLx6RZIcc8p/0+jQ/VyPQFJnHZStmCejXpQnpN0PP/X5qAFthrChqjGN78MnhSHrkHXHIW9xkRHJ8uf3fE94DWB4d5HE6Rpv3zsTyZZdaqWhyWXG93Y0yzJTJaCvZ5aw0F0bMqmo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32BF67C598D1B3409E1693E521331EAF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3772b3-9aeb-4a0b-d632-08d7273246b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 18:55:18.9759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzfeHV0d+mA01E3oRW9p0h3zhwrdoakIr8jMhFd6gdz8SZNCUajN+XHzVKaVpQtZpHdJrbMSRJllAzhvi+/yyvSTUuQ9l62ekOWK7gGN1yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5210
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.111
Subject: Re: [Qemu-devel] [PATCH] block: workaround for unaligned byte range
 in fallocate()
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
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjIuMDguMjAxOSAyMTozMSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFJldmVydCB0aGUg
Y29tbWl0IDExOGY5OTQ0MmQgJ2Jsb2NrL2lvLmM6IGZpeCBmb3IgdGhlIGFsbG9jYXRpb24gZmFp
bHVyZScNCj4gYW5kIG1ha2UgYmV0dGVyIGVycm9yIGhhbmRsaW5nIGZvciB0aGUgZmlsZSBzeXN0
ZW1zIHRoYXQgZG8gbm90IHN1cHBvcnQNCj4gZmFsbG9jYXRlKCkgZm9yIHRoZSB1bmFsaWduZWQg
Ynl0ZSByYW5nZS4gQWxsb3cgZmFsbGluZyBiYWNrIHRvIHB3cml0ZQ0KPiBpbiBjYXNlIGZhbGxv
Y2F0ZSgpIHJldHVybnMgRUlOVkFMLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBLZXZpbiBXb2xmIDxr
d29sZkByZWRoYXQuY29tPg0KPiBTdWdnZXN0ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRo
YXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5r
ZXZpY2hAdmlydHVvenpvLmNvbT4NCj4gLS0tDQo+IERpc2N1c3NlZCBpbiBlbWFpbCB0aHJlYWQg
d2l0aCB0aGUgbWVzc2FnZSBJRA0KPiA8MTU1NDQ3NDI0NC01NTM2NjEtMS1naXQtc2VuZC1lbWFp
bC1hbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPiANCj4gICBibG9jay9maWxlLXBv
c2l4LmMgfCA3ICsrKysrKysNCj4gICBibG9jay9pby5jICAgICAgICAgfCAyICstDQo+ICAgMiBm
aWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9ibG9jay9maWxlLXBvc2l4LmMgYi9ibG9jay9maWxlLXBvc2l4LmMNCj4gaW5kZXgg
ZmJlYjAwNi4uMmMyNTRmZiAxMDA2NDQNCj4gLS0tIGEvYmxvY2svZmlsZS1wb3NpeC5jDQo+ICsr
KyBiL2Jsb2NrL2ZpbGUtcG9zaXguYw0KPiBAQCAtMTU4OCw2ICsxNTg4LDEzIEBAIHN0YXRpYyBp
bnQgaGFuZGxlX2Fpb2NiX3dyaXRlX3plcm9lcyh2b2lkICpvcGFxdWUpDQo+ICAgICAgIGlmIChz
LT5oYXNfd3JpdGVfemVyb2VzKSB7DQo+ICAgICAgICAgICBpbnQgcmV0ID0gZG9fZmFsbG9jYXRl
KHMtPmZkLCBGQUxMT0NfRkxfWkVST19SQU5HRSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYWlvY2ItPmFpb19vZmZzZXQsIGFpb2NiLT5haW9fbmJ5dGVzKTsNCj4gKyAgICAg
ICAgaWYgKHJldCA9PSAtRUlOVkFMKSB7DQo+ICsgICAgICAgICAgICAvKg0KPiArICAgICAgICAg
ICAgICogQWxsb3cgZmFsbGluZyBiYWNrIHRvIHB3cml0ZSBmb3IgZmlsZSBzeXN0ZW1zIHRoYXQN
Cj4gKyAgICAgICAgICAgICAqIGRvIG5vdCBzdXBwb3J0IGZhbGxvY2F0ZSgpIGZvciB1bmFsaWdu
ZWQgYnl0ZSByYW5nZS4NCj4gKyAgICAgICAgICAgICAqLw0KPiArICAgICAgICAgICAgcmV0dXJu
IC1FTk9UU1VQOw0KPiArICAgICAgICB9DQo+ICAgICAgICAgICBpZiAocmV0ID09IDAgfHwgcmV0
ICE9IC1FTk9UU1VQKSB7DQo+ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gICAgICAgICAg
IH0NCg0KSG1tIHN0b3AsIHlvdSd2ZSBkb25lIGV4YWN0bHkgd2hhdCBEZW4gd2FzIGFmcmFpZCBv
ZjoNCg0KdGhlIG5leHQgbGluZQ0KICAgcy0+aGFzX3dyaXRlX3plcm9lcyA9IGZhbHNlOw0KDQp3
aWxsIGRpc2FibGUgd3JpdGVfemVyb2VzIGZvcmV2ZXIuDQoNClNvbWV0aGluZyBsaWtlDQoNCi0t
LSBhL2Jsb2NrL2ZpbGUtcG9zaXguYw0KKysrIGIvYmxvY2svZmlsZS1wb3NpeC5jDQpAQCAtMTU4
OCwxMCArMTU4OCwxMiBAQCBzdGF0aWMgaW50IGhhbmRsZV9haW9jYl93cml0ZV96ZXJvZXModm9p
ZCAqb3BhcXVlKQ0KICAgICAgaWYgKHMtPmhhc193cml0ZV96ZXJvZXMpIHsNCiAgICAgICAgICBp
bnQgcmV0ID0gZG9fZmFsbG9jYXRlKHMtPmZkLCBGQUxMT0NfRkxfWkVST19SQU5HRSwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFpb2NiLT5haW9fb2Zmc2V0LCBhaW9jYi0+YWlv
X25ieXRlcyk7DQotICAgICAgICBpZiAocmV0ID09IDAgfHwgcmV0ICE9IC1FTk9UU1VQKSB7DQor
ICAgICAgICBpZiAocmV0ID09IDAgfHwgKHJldCAhPSAtRU5PVFNVUCAmJiByZXQgIT0gLUVJTlZB
TCkpIHsNCiAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCiAgICAgICAgICB9DQotICAgICAgICBz
LT5oYXNfd3JpdGVfemVyb2VzID0gZmFsc2U7DQorICAgICAgICBpZiAocmV0ID09IC1FTk9UU1VQ
KSB7DQorICAgICAgICAgICAgcy0+aGFzX3dyaXRlX3plcm9lcyA9IGZhbHNlOw0KKyAgICAgICAg
fQ0KICAgICAgfQ0KICAjZW5kaWYNCg0KDQp3aWxsIHdvcmsgYmV0dGVyLiBTbywgaGFuZGxlIEVO
T1RTVVAgYXMgImRpc2FibGUgd3JpdGVfemVyb3MgZm9yZXZlciIsIGFuZCBFSU5WQUwgYXMNCiJk
b24ndCBkaXNhYmxlLCBidXQgZmFsbGJhY2sgdG8gd3JpdGluZyB6ZXJvcyIuIEFuZCB3ZSBuZWVk
IHNhbWUgaGFuZGxpbmcgZm9yIGZvbGxvd2luZyBkb19mYWxsb2NhdGUoKSBjYWxscw0KdG9vIChv
dGhlcndpc2UgdGhleSBhZ2FpbiBmYWlscyB3aXRoIEVJTlZBTCB3aGljaCB3aWxsIGJyZWFrIHRo
ZSB3aG9sZSB0aGluZykuDQoNCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2lvLmMgYi9ibG9jay9pby5j
DQo+IGluZGV4IDU2YmJmMTkuLjU4ZjA4Y2QgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2lvLmMNCj4g
KysrIGIvYmxvY2svaW8uYw0KPiBAQCAtMTU1OCw3ICsxNTU4LDcgQEAgc3RhdGljIGludCBjb3Jv
dXRpbmVfZm4gYmRydl9jb19kb19wd3JpdGVfemVyb2VzKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0K
PiAgICAgICAgICAgICAgIGFzc2VydCghYnMtPnN1cHBvcnRlZF96ZXJvX2ZsYWdzKTsNCj4gICAg
ICAgICAgIH0NCj4gICANCj4gLSAgICAgICAgaWYgKHJldCA8IDAgJiYgIShmbGFncyAmIEJEUlZf
UkVRX05PX0ZBTExCQUNLKSkgew0KPiArICAgICAgICBpZiAocmV0ID09IC1FTk9UU1VQICYmICEo
ZmxhZ3MgJiBCRFJWX1JFUV9OT19GQUxMQkFDSykpIHsNCj4gICAgICAgICAgICAgICAvKiBGYWxs
IGJhY2sgdG8gYm91bmNlIGJ1ZmZlciBpZiB3cml0ZSB6ZXJvZXMgaXMgdW5zdXBwb3J0ZWQgKi8N
Cj4gICAgICAgICAgICAgICBCZHJ2UmVxdWVzdEZsYWdzIHdyaXRlX2ZsYWdzID0gZmxhZ3MgJiB+
QkRSVl9SRVFfWkVST19XUklURTsNCj4gICANCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K

