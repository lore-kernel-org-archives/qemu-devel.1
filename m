Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE53AC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BCE20872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WzLmiwIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BCE20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD24e-0007uQ-LM
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD1zc-0004na-4s
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD1za-0008Sy-Ux
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:45:43 -0400
Received: from mail-eopbgr00114.outbound.protection.outlook.com
 ([40.107.0.114]:16247 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD1za-0008ST-Nz
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:45:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkzF4mfop9EcLZ1IT2YHimKawlKuRAfN4WDuyVY34+MV/3bVIJ1RRqBv0KlYZ04wVabqli+3L1Q3dYCKU/HMZ8mXD4fY3uOUdSCtxVAnxoTGMqA8I68JlKxaRLjxZEZTZNFOd8IfwKoOoKPqolr6NL5CY745xjvhEMCVIhLOLJn8T+6C2szYggBKS/T4a51B6o4x0b3dLztlLn0tw0EgyCDOqhU0rURXQlDMbfzAvObu2a9yJlqwcBKmGLEWE6rCqcYpOe1nnb+lyEkEi5iNL4BXJLcwtDfQOZOwvO00PR8J8rA2JGMwkQvlMZNMlEJist5isCQFRKa5PLm6yi8bpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apOvD8XuCxkQK2Bv7XJzGZOy5Buc42ryj7WD+D7WsH8=;
 b=jmj4L3J2h82boyNY29pbJ7oQmwbOddoIffIGjXbTO0eQnysdP7KUgI7RjZNy3w74XDfsJE66hpVjGDIeq+tyuQ2dVBeq97IBNgcDEgqzeRTOyMMj+swxLEeyEoxndP7hyTWVXqQ+t32MXXRNvmcY2pRJBWLC7ecwr9kb2QHYc0uNF+x4NR6jABDa/7kNFmNnOIsMQUyiwGG86rfyzJpLetSdM28x9zPwSsEs7Vj/X5CCzHDhw2974DPjPMpwO/bGCUv3D1vfeBCHSENyVtPvyVvrpVAmDq5sOQ77M6Ifolv/xCg9P3/tarTnasaBuTO+qULo9M1RYTdONMIOEfPNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apOvD8XuCxkQK2Bv7XJzGZOy5Buc42ryj7WD+D7WsH8=;
 b=WzLmiwIFbENJajhpY1kfSQPvVTeGTa/FMzwe/OHjplv0Hea1lyHoEDD1YelG4sN6mm1anxEOrz4vn0NKHKt9p4S4BN0jNLeMHXIB51ZU95+2KQdIqw1YvWymq5ELjRde2cBB8Zm3DcFwhfRfoKcc0GdXIznLLP69aWLqjlp0TyI=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4043.eurprd08.prod.outlook.com (20.179.10.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Wed, 25 Sep 2019 07:45:41 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 07:45:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 02/25] hw/core/loader-fit: fix freeing errp in
 fit_load_fdt
Thread-Topic: [PATCH v3 02/25] hw/core/loader-fit: fix freeing errp in
 fit_load_fdt
Thread-Index: AQHVcxQDdiAaxl5+Z0elAgOGbrmRYac7SgeAgAC0NQCAAAYNAA==
Date: Wed, 25 Sep 2019 07:45:40 +0000
Message-ID: <86a598fd-fa8f-9081-76a1-821c58eddb00@virtuozzo.com>
References: <20190924200902.4703-1-vsementsov@virtuozzo.com>
 <20190924200902.4703-3-vsementsov@virtuozzo.com>
 <1f007fe0-d6bb-db19-835f-9cb4043f9b66@redhat.com>
 <5a8a60aa-d394-19eb-a719-9a4068d48a7c@virtuozzo.com>
In-Reply-To: <5a8a60aa-d394-19eb-a719-9a4068d48a7c@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0013.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::26)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925104538459
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 907d78c2-da2d-45c7-d693-08d7418c5cfc
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4043; 
x-ms-traffictypediagnostic: DB8PR08MB4043:
x-microsoft-antispam-prvs: <DB8PR08MB404326D90EF07CF892B3C852C1870@DB8PR08MB4043.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(3846002)(31696002)(229853002)(6116002)(71200400001)(86362001)(71190400001)(478600001)(66556008)(64756008)(66446008)(14454004)(66946007)(8936002)(446003)(25786009)(81166006)(2616005)(8676002)(476003)(6436002)(31686004)(66476007)(11346002)(6486002)(2906002)(5660300002)(256004)(2501003)(76176011)(305945005)(102836004)(386003)(6506007)(36756003)(53546011)(54906003)(81156014)(4326008)(316002)(186003)(110136005)(486006)(66066001)(26005)(52116002)(7736002)(6512007)(6246003)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4043;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rHgTEARNNvNXkLTex9dJF3cAcQLdYQJuS3sT1Uf8kBLMDos4VUgWCChLfS5X7UECMPaQwKW1cXBPo010ne38k/HMABQ08oNcyUB58Dqw4JKlu3CX6x37EglgatBSabm2a3lhhWAKi/LJiGS+SsNwypZdL/tz420nQgAVvFWvw0viPR+ro40LrrKtERux++ep1iTDf5BEFHYFeFeRa5ra3ZtcwcNqdiDz0HeO7KhO2RXHpI9QXs9P/0wN8kS84qm9xRuoiUyX+FwHSWCo46t4pWCrYJ7pdxjzQqGSmHj3XHzNQkfYDnPCXRfXbqTgBYqC3afM7Nq0x0HEqb1PdNeLLGvW4Il0RPzXeGm+44KoymiSqecgS56C7w1lwqIfpUqGSf7IRAlMs/KtkEtMLRF3Oxa7yS2u6z7tyCF4AahbXFU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E6D2DADFE20B84681DC34F301F3E395@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907d78c2-da2d-45c7-d693-08d7418c5cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 07:45:40.9176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJpcvmoYciS2PNjONBE/gt80z/rslBEKhaGCJsqwz4Wyr0V6Quj+tdE6pQDS2S1RW3nRMo/mohwhmA2l9CONGMoZIkdfDy8d/uDNx4zFAD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4043
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.114
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Paul Burton <pburton@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjUuMDkuMjAxOSAxMDoyMywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjQuMDkuMjAxOSAyMzozOCwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9uIDkvMjQvMTkgMzowOCBQ
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+PiBmaXRfbG9hZF9mZHQg
Zm9yZ2V0IHRvIHplcm8gZXJycC4gRml4IGl0Lg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogVmxh
ZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+
IFJldmlld2VkLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCj4+PiAtLS0NCj4+
PiDCoCBody9jb3JlL2xvYWRlci1maXQuYyB8IDEgKw0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L2NvcmUvbG9hZGVyLWZpdC5j
IGIvaHcvY29yZS9sb2FkZXItZml0LmMNCj4+PiBpbmRleCA5NTNiMTZiYzgyLi4xMWU0ZmFkNTk1
IDEwMDY0NA0KPj4+IC0tLSBhL2h3L2NvcmUvbG9hZGVyLWZpdC5jDQo+Pj4gKysrIGIvaHcvY29y
ZS9sb2FkZXItZml0LmMNCj4+PiBAQCAtMjAxLDYgKzIwMSw3IEBAIHN0YXRpYyBpbnQgZml0X2xv
YWRfZmR0KGNvbnN0IHN0cnVjdCBmaXRfbG9hZGVyICpsZHIsIGNvbnN0IHZvaWQgKml0YiwNCj4+
PiDCoMKgwqDCoMKgIGlmIChlcnIgPT0gLUVOT0VOVCkgew0KPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBsb2FkX2FkZHIgPSBST1VORF9VUChrZXJuZWxfZW5kLCA2NCAqIEtpQikgKyAoMTAgKiBNaUIp
Ow0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9mcmVlKCplcnJwKTsNCj4+PiArwqDCoMKg
wqDCoMKgwqAgKmVycnAgPSBOVUxMOw0KPj4NCj4+IEFjdHVhbGx5LCBsZXQncyBkcm9wIG15IFIt
YiAtIEkgdGhpbmsgd2UgaGF2ZSBhIGJpZ2dlciBidWcgaGVyZS7CoCBXZSBhcmUNCj4+IGJsaW5k
bHkgZGVyZWZlcmVuY2luZyAqZXJycCBldmVuIGlmIHRoZSBjYWxsZXIgcGFzc2VkIGluIE5VTEwu
wqAgVGhlDQo+PiBjb3JyZWN0IHdheSB0byB3cml0ZSB0aGlzIGZ1bmN0aW9uIHJlcXVpcmVzIGVp
dGhlciB0aGUgdXNlIG9mIGxvY2FsX2Vycg0KPj4gb3IgdGhlIGFkZGl0aW9uIG9mIGF1dG8tcHJv
cGFnYXRpb24uDQo+Pg0KPj4gKEluIHYyLCB5b3Ugc3RpbGwgaGFkIHRoaXMgYnVnIC0geW91ciBh
ZGRpdGlvbiBvZiBlcnJvcl9mcmVlX2VycnAoZXJycCkNCj4+IHdvdWxkIHN0aWxsIGJsaW5kbHkg
ZGVyZWZlcmVuY2UgKmVycnAsIHVubGVzcyB5b3UgdHdlYWsgdGhlDQo+PiBpbXBsZW1lbnRhdGlv
biBvZiBlcnJvcl9mcmVlX2VycnAgdG8gdG9sZXJhdGUgYSBOVUxMIHBvaW50ZXIgaW5wdXQpDQo+
Pg0KPiANCj4gT29wcywgeW91IGFyZSByaWdodCEgU3RpbGwsIEkgdGhpbmsgaW4gdGhpcyBjYXNl
IHdlIGNhbg0KPiANCj4gaWYgKGVycnApIHsNCj4gIMKgIGVycm9yX2ZyZWUoKmVycnApOw0KPiAg
wqAgKmVycnAgPSBOVUxMOw0KPiB9DQo+IA0KDQpIbW0sIHBvc3NpYmx5LCBpdCBzaG91bGQgYmUg
Y2FsbGVkIG5vdCBlcnJvcl9mcmVlX2VycnAsIGJ1dCBqdXN0IGVycm9yX3Vuc2V0LCB0byBiZQ0K
Y29ycmVjdCBwYWlyIHRvIGVycm9yX3NldC4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K

