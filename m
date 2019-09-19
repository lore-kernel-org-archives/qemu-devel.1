Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A93CC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D763A21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="owF8ja6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D763A21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAqIm-0001qJ-Hr
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 02:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAqGl-00007I-Cj
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAqGk-0000ea-7K
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:50:23 -0400
Received: from mail-vi1eur04on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::705]:44465
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAqGh-0000aS-8u; Thu, 19 Sep 2019 02:50:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLZdipfurvIlvQyk4YucY+JvctAlc00vhGxB6WJfXXm8miZEo7wA9iL0yWx4Dt1UJD7DoYE/QfVKfMlFcPqalXYLI043JXZ5NhGtZEYgjfFa6nG1VlPgfwh56C9oY0w1eSqCuDKBjV8TU94tm2ZEKQc8Swje6ArKdPfkjn2B1Oh+Voh9QrFnWULlvmb8LfOwfrflXPfrcDG7tjjUonwuvcXVzffkKR6ls/7HYPSyuvoGH+347RKqqDlboCNQP0grUo1zBOp97qbZE9xZ0izYOYacwU8X5lRVNcZt4SZ9ViRE5aUGliO8cqtP8WoB5H6k/j//dvi52M0EkkbBGu3npQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc51InVgKv/kSTI23+jEmRjLrB7LyYT32ji47mRFFx8=;
 b=hRORh4GPUFKrvBMeXwwcgL7wpNobOFakSo+s2ldzHuU1Sv/Ma/lz/KI14z7jnVQpi3nxIHtPp4imfHS55WMBxTOe1N4WLUS6TJptndbGy5siN9lCvruimQlCDX7Ks24jZr40LWKjv2kP7/FbSCXe9+wI7QgfycvTdlfTQRzgPL5xBS1zk1KRnglNR/0Bm78Gd30ErftAi8tfq6EzpTpmBLCtGS2PcGwkEvatfII6uf5yRGZbRrqLMfprYA37+C8X2HV0B16Wf5KfEUsQ/2VnCeNOwiDxqVnUocDYld4QvnWfZsm3nACH+t+z1OERGjGVtTO0NbX8pSgrh3g3QsGyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc51InVgKv/kSTI23+jEmRjLrB7LyYT32ji47mRFFx8=;
 b=owF8ja6UKq2+t9GAsJhOwnvYmNuYDewkYnjwPNrmyHe2OUFa13ssihIclJ4x34Ffd6piLI9uY73Q8Ych2xY0eHhtuYa0TNKaor4iHWOOWXgc6Vutv0wy1Y2zoBidKWrV2u5mFtWyGuetQNMk6ja1j3njRPy9Qga7SNAif9Zq1BM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5482.eurprd08.prod.outlook.com (52.133.241.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 06:50:16 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 06:50:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v12 1/2] block/backup: fix max_transfer
 handling for copy_range
Thread-Index: AQHVbXIGXsS3qVTuXkS042Ce+aUetqcx27qAgAC2W4A=
Date: Thu, 19 Sep 2019 06:50:16 +0000
Message-ID: <c1e597ab-5a27-c484-36f8-43734f54bc80@virtuozzo.com>
References: <20190917160731.10895-1-vsementsov@virtuozzo.com>
 <20190917160731.10895-2-vsementsov@virtuozzo.com>
 <4122264a-f7db-8b76-6930-87e2287c49b8@redhat.com>
In-Reply-To: <4122264a-f7db-8b76-6930-87e2287c49b8@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0013.eurprd03.prod.outlook.com
 (2603:10a6:3:76::23) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919095013822
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b682cba4-ef14-477a-436b-08d73ccda0df
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5482; 
x-ms-traffictypediagnostic: DB8PR08MB5482:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB54820B1A8596B79B0C4F4F74C1890@DB8PR08MB5482.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(136003)(376002)(396003)(39840400004)(189003)(199004)(6436002)(478600001)(81156014)(4326008)(66446008)(8676002)(8936002)(110136005)(2501003)(7736002)(5660300002)(54906003)(6486002)(14454004)(305945005)(6512007)(386003)(2906002)(25786009)(102836004)(11346002)(31686004)(186003)(53546011)(256004)(6506007)(26005)(446003)(81166006)(66066001)(36756003)(66476007)(229853002)(66556008)(66946007)(64756008)(3846002)(6116002)(316002)(52116002)(6246003)(76176011)(86362001)(71200400001)(71190400001)(486006)(476003)(99286004)(107886003)(31696002)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5482;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 88WVGheA3QApQxZW1Jj2LcrKai3ntBzVUSU1gwxQR8qkDkSW68ht2suqlhR4JVCv8ATpkyaKMb6ivF+ceHFsmj986arNn5WMvhGdmKE8+NHl9497V8L252GSi6eM4s4eqQ1cuHYq5ukT63kXc4kxiDioxLDDuFHQabCqODpAJUOvo/SFq9pa2PGKnYCKBLmo7Qg6fOOl2b7qlSJkriWglB5a1p9L/XTUbF9BWJTkfURF98OZl5EbPvmUd0fZWSdi2xQF3fi8/U6VSj0yQyEyNPAlBAPAqip+F6LQMMGxlmQM/CHL9luFyz637T/5Muz9iuSKVkqBPqeMmVJSCQoBDsATrCadJ6X+MO4Tm7WGbhXwoS5mrqV6j5T+7NiMPUGamXhS7hA87pwqQcSGkVv6slCUBPAg2mrT9oIAQZtplp8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D03A5E48E281294BAA23B7958B66B765@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b682cba4-ef14-477a-436b-08d73ccda0df
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 06:50:16.2814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77YLXacP2WLHqK3ZZHNMJ63spjpVt6lhwRbYntJ67lO1hfigWfs0ztI8S580AIwCS/VK61rMWnOvaZFPEbt34TUblKREJjhx/sA9nni52T0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5482
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::705
Subject: Re: [Qemu-devel] [PATCH v12 1/2] block/backup: fix max_transfer
 handling for copy_range
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMDkuMjAxOSAyMjo1NywgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDkvMTcvMTkg
MTI6MDcgUE0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBPZiBjb3Vy
c2UsIFFFTVVfQUxJR05fVVAgaXMgYSB0eXBvLCBpdCBzaG91bGQgYmUgUUVNVV9BTElHTl9ET1dO
LCBhcyB3ZQ0KPj4gYXJlIHRyeWluZyB0byBmaW5kIGFsaWduZWQgc2l6ZSB3aGljaCBzYXRpc2Z5
IGJvdGggc291cmNlIGFuZCB0YXJnZXQuDQo+PiBBbHNvLCBkb24ndCBpZ25vcmUgdG9vIHNtYWxs
IG1heF90cmFuc2Zlci4gSW4gdGhpcyBjYXNlIHNlZW1zIHNhZmVyIHRvDQo+PiBkaXNhYmxlIGNv
cHlfcmFuZ2UuDQo+Pg0KPj4gRml4ZXM6IDlkZWQ0YTAxMTQ5NjhlDQo+PiBTaWduZWQtb2ZmLWJ5
OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+
DQo+PiAtLS0NCj4+IMKgIGJsb2NrL2JhY2t1cC5jIHwgMTIgKysrKysrKystLS0tDQo+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9ibG9jay9iYWNrdXAuYyBiL2Jsb2NrL2JhY2t1cC5jDQo+PiBpbmRleCA3NjNm
MGQ3ZmY2Li5kOGZkYmZhZGZlIDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svYmFja3VwLmMNCj4+ICsr
KyBiL2Jsb2NrL2JhY2t1cC5jDQo+PiBAQCAtNzQxLDEyICs3NDEsMTYgQEAgQmxvY2tKb2IgKmJh
Y2t1cF9qb2JfY3JlYXRlKGNvbnN0IGNoYXIgKmpvYl9pZCwgQmxvY2tEcml2ZXJTdGF0ZSAqYnMs
DQo+PiDCoMKgwqDCoMKgIGpvYi0+Y2x1c3Rlcl9zaXplID0gY2x1c3Rlcl9zaXplOw0KPj4gwqDC
oMKgwqDCoCBqb2ItPmNvcHlfYml0bWFwID0gY29weV9iaXRtYXA7DQo+PiDCoMKgwqDCoMKgIGNv
cHlfYml0bWFwID0gTlVMTDsNCj4+IC3CoMKgwqAgam9iLT51c2VfY29weV9yYW5nZSA9ICFjb21w
cmVzczsgLyogY29tcHJlc3Npb24gaXNuJ3Qgc3VwcG9ydGVkIGZvciBpdCAqLw0KPj4gwqDCoMKg
wqDCoCBqb2ItPmNvcHlfcmFuZ2Vfc2l6ZSA9IE1JTl9OT05fWkVSTyhibGtfZ2V0X21heF90cmFu
c2Zlcihqb2ItPmNvbW1vbi5ibGspLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBibGtf
Z2V0X21heF90cmFuc2Zlcihqb2ItPnRhcmdldCkpOw0KPj4gLcKgwqDCoCBqb2ItPmNvcHlfcmFu
Z2Vfc2l6ZSA9IE1BWChqb2ItPmNsdXN0ZXJfc2l6ZSwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUUVNVV9BTElHTl9VUChq
b2ItPmNvcHlfcmFuZ2Vfc2l6ZSwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGpvYi0+Y2x1c3Rlcl9zaXplKSk7DQo+PiArwqDCoMKgIGpvYi0+Y29weV9yYW5nZV9zaXplID0g
UUVNVV9BTElHTl9ET1dOKGpvYi0+Y29weV9yYW5nZV9zaXplLA0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBqb2ItPmNsdXN0ZXJfc2l6ZSk7DQo+PiArwqDCoMKgIC8qDQo+PiArwqDC
oMKgwqAgKiBDb21wcmVzc2lvbiBpcyBub3Qgc3VwcG9ydGVkIGZvciBjb3B5X3JhbmdlLiBBbHNv
LCB3ZSBkb24ndCB3YW50IHRvDQo+PiArwqDCoMKgwqAgKiBoYW5kbGUgc21hbGwgbWF4X3RyYW5z
ZmVyIGZvciBjb3B5X3JhbmdlICh3aGljaCBjdXJyZW50bHkgZG9uJ3QNCj4+ICvCoMKgwqDCoCAq
IGhhbmRsZSBtYXhfdHJhbnNmZXIgYXQgYWxsKS4NCj4+ICvCoMKgwqDCoCAqLw0KPj4gK8KgwqDC
oCBqb2ItPnVzZV9jb3B5X3JhbmdlID0gIWNvbXByZXNzICYmIGpvYi0+Y29weV9yYW5nZV9zaXpl
ID4gMDsNCj4+IMKgwqDCoMKgwqAgLyogUmVxdWlyZWQgcGVybWlzc2lvbnMgYXJlIGFscmVhZHkg
dGFrZW4gd2l0aCB0YXJnZXQncyBibGtfbmV3KCkgKi8NCj4+IMKgwqDCoMKgwqAgYmxvY2tfam9i
X2FkZF9iZHJ2KCZqb2ItPmNvbW1vbiwgInRhcmdldCIsIHRhcmdldCwgMCwgQkxLX1BFUk1fQUxM
LA0KPj4NCj4gDQo+IEknbSBjbGVhciBvbiB0aGUgYWxpZ25tZW50IGZpeCwgSSdtIG5vdCBjbGVh
ciBvbiB0aGUgY29tbWVudCBhYm91dCBtYXhfdHJhbnNmZXIgYW5kIGhvdyBpdCByZWxhdGVzIHRv
IGNvcHlfcmFuZ2Vfc2l6ZSBiZWluZyBub24temVyby4NCj4gDQo+ICJzbWFsbCBtYXggdHJhbnNm
ZXIiIC0tIHdoYXQgaGFwcGVucyB3aGVuIGl0J3MgemVybz8gd2UncmUgYXBwYXJlbnRseSBPSyB3
aXRoIGEgc2luZ2xlIGNsdXN0ZXIsIGJ1dCB3aGVuIGl0J3MgemVybywgd2hhdCBoYXBwZW5zPw0K
DQppZiBpdCB6ZXJvIGl0IG1lYW5zIHRoYXQgc291cmNlIG9yIHRhcmdldCByZXF1aXJlcyBtYXhf
dHJhbnNmZXIgbGVzcyB0aGFuIGNsdXN0ZXJfc2l6ZS4gSXQgc2VlbXMgbm90IHZhbGlkIHRvIGNh
bGwgY29weV9yYW5nZSBpbiB0aGlzIGNhc2UuDQpTdGlsbCBpdCdzIE9LIHRvIHVzZSBub3JtYWwg
cmVhZC93cml0ZSwgYXMgdGhleSBoYW5kbGUgbWF4X3RyYW5zZmVyIGludGVybmFsbHkgaW4gYSBs
b29wIChjb3B5X3JhbmdlIGRvZXNuJ3QgZG8gaXQpLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZs
YWRpbWlyDQo=

