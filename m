Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D954C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B07E207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VNYMPC1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B07E207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDRRl-0008Oh-0e
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 06:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDRQR-0007WH-0R
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDRQP-0000Dx-1H
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:55:06 -0400
Received: from mail-eopbgr70103.outbound.protection.outlook.com
 ([40.107.7.103]:55665 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDRQF-0008Qi-Bo; Thu, 26 Sep 2019 06:54:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rap6gVUjgMyYkVB5WCb8qFOzCP76mHT5nn55mjjlE+QZ/224pM6zU7eSPwg+OSDq5A2intii56qWeQIcTUp7KGOQ97LOC8K2+jRKtCzovd9EKOfRTKtIPDURmEbeUgb9337/retjpRjlZMnGVY0zPZREs+h3DEsuAzvSNdvYYrPDuX0XL7MzHGLAGXs1/8CILlF97zpkNMUAKn3rLfdLaoWLJiX2gBug5Cqu0YJDdM7C6NzgqQ7SLvFft8WD2+p/016zCUMCFKmre9BczXHWj54xTXHcytRu5NK/RjaQzZUlm49ncTKszlBJrEuJNH462AQNLIaW+RJA/TVvUmNMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTixcEPM1vcFVWPKSp5wMkWSTKrP527Fq2EUvZOu9no=;
 b=TkLxydu4HRiTbCUY3WYgIiScEHGp+osMBmZvUxqaW/WskNKLDAq7WLCBN1r+zOA/P+tH8TL8TvLZx1TlZa+0l38S+qT0Iw3sxp6bCLyGq6V1nodIdAXy+6+6hJJvASyCrTu+/lk8OfmNLl0HQNaMW05nKS4nhJuCxmPL5njGkeWHi0C9FdedKfp1W6xHaQhWUIBhp7MHs8ZXnEn4TJC0NwiH9CIaqSqe1QqA4WBwvYOFF1Hw0CG18b7jAev5KI+/Pe7OCbCIn3JzLAPUXCi7v86TgTv/Fec5pdH0J/1tNxA3osGWS51AhSnratr1URm5VHQcCQBy7ukhDLVV6RcILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTixcEPM1vcFVWPKSp5wMkWSTKrP527Fq2EUvZOu9no=;
 b=VNYMPC1WvC04IrpApr6p1gH+3ucTsqCSubLEoRBKfHlAizv1W3Fds8o9ib68UIBEgOkjqVLW7rDyrmnhVXwnRzu+LmwN46eK+w+JfSrViIQS5zrZ4VbHcPnQfyaBGQA7UbrFA8f3b5ual0OQ+5jZJlfJR1yTBicMcnlYM26rvOQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5099.eurprd08.prod.outlook.com (10.255.18.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Thu, 26 Sep 2019 10:54:51 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 10:54:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PULL 1/2] util/ioc.c: try to reassure Coverity about
 qemu_iovec_init_extended
Thread-Topic: [PULL 1/2] util/ioc.c: try to reassure Coverity about
 qemu_iovec_init_extended
Thread-Index: AQHVc8jbJhHqvcPoRkyc+cS+bC5AUac9yg8A
Date: Thu, 26 Sep 2019 10:54:50 +0000
Message-ID: <b67c1d0e-772b-e3a7-a3cc-29fbf070347a@virtuozzo.com>
References: <20190925174400.8578-1-stefanha@redhat.com>
 <20190925174400.8578-2-stefanha@redhat.com>
In-Reply-To: <20190925174400.8578-2-stefanha@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::28)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190926135448916
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6069948-762e-4d40-941f-08d7426ff4a1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5099; 
x-ms-traffictypediagnostic: DB8PR08MB5099:
x-microsoft-antispam-prvs: <DB8PR08MB50997D21C52BBB8C04CD7F78C1860@DB8PR08MB5099.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(39850400004)(396003)(366004)(346002)(199004)(189003)(86362001)(256004)(6512007)(102836004)(6116002)(3846002)(66066001)(81166006)(5660300002)(66946007)(52116002)(26005)(8936002)(31686004)(66446008)(2906002)(31696002)(66556008)(64756008)(66476007)(25786009)(54906003)(110136005)(36756003)(8676002)(81156014)(229853002)(316002)(186003)(2616005)(11346002)(6246003)(486006)(2501003)(6436002)(71190400001)(71200400001)(14444005)(14454004)(386003)(6506007)(7736002)(99286004)(76176011)(476003)(4326008)(478600001)(446003)(305945005)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5099;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mfHTO7uuGDwpCZ2SoN8Ei7b3te1Jw7Cfo0Mv2ffUlMYKeGMzKkFcQGndUbx/9kh0TxlidkzwKP8QvOWDNZdU5cbvmb6ftQjpsJB2wvSRsiogsvK87ncZP2H2LHWQW1LRLfHPWeEwpwo6WrTCLHpHv7FEM+vYdRs0GAsuZloSRBIfz/69/RgSPD0NSlGuvoUI9ier2cHPOfAAz8G9Dag0Z4KGLN0u9fQTPB859A9EAqKkO3P7Lci+Z+BbNe5VKmnRCQniWGzmt8y5VRcVjcX/BEkdEJLMCfN8jDcxMkwsqsvKlsc2M52GOWcJWxIRhdai2DRY1KqBU8VfNVArJY29NWwRNLYCNMoOJFG9H/quVJEOhEHIL21B0YrqmC4vSVyOlDfsVO/3GtfVf6nHn3HglVsPn4Mf8T7NLl4zXABpEhA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2C1390CE2B1844480D721D81FF36F51@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6069948-762e-4d40-941f-08d7426ff4a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 10:54:51.0108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mZNGhR7Oo3P4GJedYly/aex0plFXmqkstkAO1JE6HupvoiXKdYmORmJZbbSWu6gKoU9hpX9vcqM3WKlEEZz6Io2I9pxR+z3vOgp88aaxzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5099
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.103
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjUuMDkuMjAxOSAyMDo0MywgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPiBGcm9tOiBWbGFkaW1p
ciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IA0KPiBN
YWtlIGl0IG1vcmUgb2J2aW91cywgdGhhdCBmaWxsaW5nIHFpb3YgY29ycmVzcG9uZHMgdG8gcWlv
diBhbGxvY2F0aW9uLA0KPiB3aGljaCBpbiB0dXJuIGNvcnJlc3BvbmRzIHRvIHRvdGFsX25pb3Yg
Y2FsY3VsYXRpb24sIGJhc2VkIG9uIG1pZF9uaW92DQo+IChub3QgbWlkX2xlbikuIFN0aWxsIGFk
ZCBhbiBhc3NlcnRpb24gdG8gc2hvdyB0aGF0IHRoZXJlIHNob3VsZCBiZSBubw0KPiBkaWZmZXJl
bmNlLg0KPiANCj4gUmVwb3J0ZWQtYnk6IENvdmVyaXR5IChDSUQgMTQwNTMwMikNCj4gU2lnbmVk
LW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96
em8uY29tPg0KPiBNZXNzYWdlLWlkOiAyMDE5MDkxMDA5MDMxMC4xNDAzMi0xLXZzZW1lbnRzb3ZA
dmlydHVvenpvLmNvbQ0KPiBTdWdnZXN0ZWQtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRl
bGxAbGluYXJvLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPiBNZXNzYWdlLUlkOiA8MjAxOTA5MTAw
OTAzMTAuMTQwMzItMS12c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgdXRpbC9p
b3YuYyB8IDMgKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3V0aWwvaW92LmMgYi91dGlsL2lvdi5jDQo+IGlu
ZGV4IDUwNTllMTA0MzEuLmE0Njg5ZmYzYzkgMTAwNjQ0DQo+IC0tLSBhL3V0aWwvaW92LmMNCj4g
KysrIGIvdXRpbC9pb3YuYw0KPiBAQCAtNDQ2LDcgKzQ0Niw4IEBAIHZvaWQgcWVtdV9pb3ZlY19p
bml0X2V4dGVuZGVkKA0KPiAgICAgICAgICAgcCsrOw0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAg
aWYgKG1pZF9sZW4pIHsNCj4gKyAgICBhc3NlcnQoIW1pZF9uaW92ID09ICFtaWRfbGVuKTsNCj4g
KyAgICBpZiAobWlkX25pb3YpIHsNCj4gICAgICAgICAgIG1lbWNweShwLCBtaWRfaW92LCBtaWRf
bmlvdiAqIHNpemVvZigqcCkpOw0KPiAgICAgICAgICAgcFswXS5pb3ZfYmFzZSA9ICh1aW50OF90
ICopcFswXS5pb3ZfYmFzZSArIG1pZF9oZWFkOw0KPiAgICAgICAgICAgcFswXS5pb3ZfbGVuIC09
IG1pZF9oZWFkOw0KPiANCg0KDQpIbW0sIHNlZW1zIHdlIGhhdmUgdG8gc3F1YXNoIGluOg0KDQot
LS0gYS91dGlsL2lvdi5jDQorKysgYi91dGlsL2lvdi5jDQpAQCAtNDIzLDcgKzQyMyw3IEBAIHZv
aWQgcWVtdV9pb3ZlY19pbml0X2V4dGVuZGVkKA0KICB7DQogICAgICBzaXplX3QgbWlkX2hlYWQs
IG1pZF90YWlsOw0KICAgICAgaW50IHRvdGFsX25pb3YsIG1pZF9uaW92ID0gMDsNCi0gICAgc3Ry
dWN0IGlvdmVjICpwLCAqbWlkX2lvdjsNCisgICAgc3RydWN0IGlvdmVjICpwLCAqbWlkX2lvdiA9
IE5VTEw7DQoNCiAgICAgIGlmIChtaWRfbGVuKSB7DQogICAgICAgICAgbWlkX2lvdiA9IHFpb3Zf
c2xpY2UobWlkX3Fpb3YsIG1pZF9vZmZzZXQsIG1pZF9sZW4sDQoNCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K

