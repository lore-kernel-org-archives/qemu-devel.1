Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C601C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4042464E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Rh4cYwKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4042464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEKL-0004KW-Ni
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idEHb-0002M3-Ou
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idEHZ-0000it-Cs
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:08:35 -0500
Received: from mail-eopbgr40138.outbound.protection.outlook.com
 ([40.107.4.138]:52918 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1idEHX-0000eU-TI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:08:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI8qJNjOd3mmfAI7vlRHI6c84/lPq4BMFwjTklYEAl28e8DXHfa6y7GiR2jCLcHNqnGDk1kYSyqTNSyDpPlzfNlKlxaq/HYSe7m8CpvMcKQWkKf1M3pDtunFt7J/KLqn79Wca0UmTEbw//EVi5ApumofHJvgT43dawIS2rRbD4Ni731cTd8nsxaebIjSNHvNEM+AA2D3MKyNSM7eHIqONQKHh3qsAI/3zlLNFxFuBIO/K4DDg9oXyybf7pcjaiVPw36IJnAD5IoLUZvOU4WIfQfob6SwZttsI7A6mUS43nYtmnrK8e4YNAqmgLLAy5B7mBGHw09eKlSZl+YISxOVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmFDr2voTawnYdpX2iNfYtNx/eK7+NVsFYgqz3T49sg=;
 b=hVwDDR3LXrFyhfE1apNDaeTcVIGkpFcq6vSYVQILoqz/sSw0TGcnrkMRZiym2Fxw+l25PtsHevcvvlU/O49pieqbrqBABLxb6n4KQz4Yg4DDeI990Jl981OWvUiOUkIVp1j+zZ8zTUfSxMYmJXD51FQuPXYwumh/HsTw4EQg8xqAp/47vZg4SFlCqlu21sJy2CeoAU6uGWrAN42GUxzW7IMelRLC1Y51f4PcHLlRy9PWPDpSNppSrFCXcmhOM/E+DaQ0ZMiAKdti7ANjWkPOtSrLe2yYLiW97pX07dEP/Jd7+oOS7mdM8EOnfI8wJ0Lc5YpLP6+Ikto4Gye4OWnq9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmFDr2voTawnYdpX2iNfYtNx/eK7+NVsFYgqz3T49sg=;
 b=Rh4cYwKrZkXR6TNTDO9N/PR9X02bwO7dDyGr0fROguxMojM9PuoHElGp9ScjgHPZYnAj6i585O4TfLslUXSCmlksSjxhEpfSj/5LMSa25twVdIsPJtBAxJcTbOf8ub6SxaRNMIpk7lgutTmlhGG2Owi9j0oQDbwU/Iij63S9Dgg=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3301.eurprd08.prod.outlook.com (52.135.164.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Fri, 6 Dec 2019 10:53:04 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 10:53:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 10/21] hw/core: Fix latent fit_load_fdt() error handling
 bug
Thread-Topic: [PATCH 10/21] hw/core: Fix latent fit_load_fdt() error handling
 bug
Thread-Index: AQHVp7Zc+yLwnj0NqE2ZqD9/orOgMKerwU8AgAEB4/yAADQJgA==
Date: Fri, 6 Dec 2019 10:53:04 +0000
Message-ID: <cce60ff4-254d-85df-cd7a-b3b373d17173@virtuozzo.com>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-11-armbru@redhat.com>
 <b42438de-3f05-a949-9304-29c051bc4444@virtuozzo.com>
 <87tv6dnbfl.fsf@dusky.pond.sub.org>
In-Reply-To: <87tv6dnbfl.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0060.eurprd09.prod.outlook.com
 (2603:10a6:7:15::49) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191206135301882
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58bdf93a-2e19-462c-96c2-08d77a3a7846
x-ms-traffictypediagnostic: AM6PR08MB3301:
x-microsoft-antispam-prvs: <AM6PR08MB3301CA150A557DF1401B2832C15F0@AM6PR08MB3301.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:378;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(39850400004)(396003)(346002)(366004)(189003)(199004)(66946007)(66476007)(66446008)(64756008)(66556008)(8936002)(81156014)(2906002)(71200400001)(26005)(86362001)(81166006)(6916009)(31686004)(8676002)(31696002)(5660300002)(6486002)(229853002)(6512007)(4326008)(305945005)(11346002)(52116002)(76176011)(25786009)(2616005)(99286004)(316002)(186003)(6506007)(71190400001)(36756003)(102836004)(478600001)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3301;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3c0pwi4eCgwn3NM9Z5rCNHSs9gajH9PnctO3jHaOsi1D+SYC+YYk7WUu2ymTY+E5YYHCHJaw57wv1xlrQ9zw5/squlpwPTzMoviwQRWg3nwBxxWfENVHU2YyzEhua6+/0gLOtznBFcgt3bd8PCLYtCewWkvL6t99xpo3uUQlDhT1BDp4uQkOrmtZvsHTQBvnLb+3GqInvsgvidneFmIXSr7ksEWIkCiFfOKKu15Fv6NwNjtOGWmFNrcrgNBB84VKlrb1Rfx72VH0hyvngFlV6Ok1J4NDHsI6+QtgmvKEP86zE0mBfbaBxuQo/BCuVTOrlZ+Fn3SyS+M4xKA2gUTJh2q/cE9Az+LH4CNoQmKexTCuf9snJttppIeQ5Cf/M3s+3PCsfM+OmBsbvOVIAvDjq5qO0fMi5bOlGIqQnbUFaOW+xL0baqLARYe7bFmfNtCO
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F7E7DD441C965408A63ABF98094E159@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bdf93a-2e19-462c-96c2-08d77a3a7846
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 10:53:04.2617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YOPu2GygX6ZVDAnWrlq5fAg7Uz5/d6+ewR1hBGawUk8cDn1aLeqaVX6C/lbgG6Bi+2lpSh2+DHlByE8G0Irq7SYeA9rd9fZivb1NLwB4Cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3301
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.138
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMTIuMjAxOSAxMDo0NiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiAN
Cj4+IDMwLjExLjIwMTkgMjI6NDIsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPj4+IGZpdF9s
b2FkX2ZkdCgpIHJlY292ZXJzIGZyb20gZml0X2ltYWdlX2FkZHIoKSBmYWlsaW5nIHdpdGggRU5P
RU5ULg0KPj4+IEV4Y2VwdCBpdCBkb2Vzbid0IHdoZW4gaXRzIEBlcnJwIGFyZ3VtZW50IGlzICZl
cnJvcl9mYXRhbCBvcg0KPj4+ICZlcnJvcl9hYm9ydCwgYmVjYXVzZSBpdCBibGluZGx5IHBhc3Nl
cyBAZXJycCB0byBmaXRfaW1hZ2VfYWRkcigpLg0KPj4+IE1lc3NlZCB1cCBpbiBjb21taXQgM2Vi
OTllZGI0OCAibG9hZGVyLWZpdDogV2VhbiBvZmYgZXJyb3JfcHJpbnRmKCkiLg0KPj4+DQo+Pj4g
VGhlIGJ1ZyBjYW4ndCBiaXRlIGFzIG5vIGNhbGxlciBhY3R1YWxseSBwYXNzZXMgJmVycm9yX2Zh
dGFsIG9yDQo+Pj4gJmVycm9yX2Fib3J0LiAgRml4IGl0IGFueXdheS4NCj4+Pg0KPj4+IFNpZ25l
ZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4+DQo+PiBS
ZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0
dW96em8uY29tPg0KPj4NCj4+IEhtbSwgYWN0dWFsbHkgaXQgbWFrZXMgbXkNCj4+ICJbUEFUQ0gg
djcgMDEvMjFdIGh3L2NvcmUvbG9hZGVyLWZpdDogZml4IGZyZWVpbmcgZXJycCBpbiBmaXRfbG9h
ZF9mZHQiDQo+PiB1bm5lY2Vzc2FyeS4gSWYgeW91IHdhbnQgeW91IG1heSBkcm9wIG15IDAxIChh
cyBpdCBjb3ZlcnMgbGVzcyBwcm9ibGVtcyksDQo+IA0KPiBZZXMuDQo+IA0KPj4gYW5kIGluIHRo
aXMgY2FzZSB5b3UgbWF5IG5vdGUgaW4geW91ciBjb3ZlciBsZXR0ZXIsIHRoYXQNCj4+IGVycnAg
PSBOVUxMIGlzIGJyb2tlbiBoZXJlIHRvbyAobWF5IGJlIG5vYmFkeSBwYXNzIGl0PyksDQo+IA0K
PiBZb3UncmUgcmlnaHQsIG51bGwgQGVycnAgaXMgd3JvbmcsIHRvby4NCj4gDQo+PiBhbmQgbm9y
bWFsIGVycnAgaXMgaGFuZGxlZCB3cm9uZywgYXMgKmVycnAgZG9lc24ndCBzZXQgdG8gTlVMTCBh
ZnRlcg0KPj4gZXJyb3JfZnJlZSgqZXJycCkNCj4gDQo+IFllcywgdGhhdCdzIHdyb25nLCB0b28u
ICBmaXRfbG9hZF9mZHQoKSBpdHNlbGYgZG9lc24ndCB1c2UgKmVycnAgYWZ0ZXINCj4gZnJlZWlu
ZyBpdCwgYnV0IGl0IHNldHMgYSB0cmFwIGZvciBpdHMgY2FsbGVycy4NCj4gDQo+PiAgICAgICAg
ICAgICAgICAgICAgKHN0aWxsLCB0aGUgb25seSBjYWxsZXIgcmVseSBvbiByZXR1cm4gdmFsdWUg
bW9yZSB0aGFuIG9uDQo+PiBlcnIsIHNvIHRoZSBwcm9ibGVtIGNhbid0IGJlIHRyaWdnZXJlZCB3
aXRoIGN1cnJlbnQgY29kZSkNCj4gDQo+IFRydWUuDQo+IA0KPiBOZXcgY29tbWl0IG1lc3NhZ2Ug
KGJhc2VkIG9uIHYyJ3MpOg0KPiANCj4gICAgICBody9jb3JlOiBGaXggZml0X2xvYWRfZmR0KCkg
ZXJyb3IgQVBJIHZpb2xhdGlvbnMNCj4gDQo+ICAgICAgZml0X2xvYWRfZmR0KCkgcGFzc2VzIEBl
cnJwIHRvIGZpdF9pbWFnZV9hZGRyKCksIHRoZW4gcmVjb3ZlcnMgZnJvbQ0KPiAgICAgIEVOT0VO
VCBmYWlsdXJlcy4gIFBhc3NpbmcgQGVycnAgaXMgd3JvbmcsIGJlY2F1c2UgaXQgd29ya3Mgb25s
eSBhcw0KPiAgICAgIGxvbmcgYXMgQGVycnAgaXMgbmVpdGhlciBAZXJyb3JfZmF0YWwgbm9yIEBl
cnJvcl9hYm9ydC4gIEVycm9yDQo+ICAgICAgcmVjb3ZlcnkgZGVyZWZlcmVuY2VzIEBlcnJwLiAg
VGhhdCdzIGFsc28gd3Jvbmc7IHNlZSB0aGUgYmlnIGNvbW1lbnQNCj4gICAgICBpbiBlcnJvci5o
LiAgRXJyb3IgcmVjb3ZlcnkgY2FuIGxlYXZlICplcnJwIHBvaW50aW5nIHRvIGEgZnJlZWQNCj4g
ICAgICBFcnJvciBvYmplY3QuICBXcm9uZywgaXQgbXVzdCBiZSBudWxsIG9uIHN1Y2Nlc3MuICBN
ZXNzZWQgdXAgaW4NCj4gICAgICBjb21taXQgM2ViOTllZGI0OCAibG9hZGVyLWZpdDogV2VhbiBv
ZmYgZXJyb3JfcHJpbnRmKCkiLg0KPiANCj4gICAgICBObyBjYWxsZXIgYWN0dWFsbHkgcGFzc2Vz
IHN1Y2ggdmFsdWVzLCBvciB1c2VzICplcnJwIG9uIHN1Y2Nlc3MuDQo+IA0KPiAgICAgIEZpeCBh
bnl3YXk6IHNwbGljZSBpbiBhIGxvY2FsIEVycm9yICplcnIsIGFuZCBlcnJvcl9wcm9wYWdhdGUo
KS4NCj4gDQo+ICAgICAgU2lnbmVkLW9mZi1ieTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUBy
ZWRoYXQuY29tPg0KPiANCj4gT2theT8NCg0KWWVzKSBhbHNvIGFkZA0KUmV2aWV3ZWQtYnk6IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0K
DQo+IA0KPj4NCj4+PiAtLS0NCj4+PiAgICBody9jb3JlL2xvYWRlci1maXQuYyB8IDE1ICsrKysr
KysrLS0tLS0tLQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvY29yZS9sb2FkZXItZml0LmMgYi9o
dy9jb3JlL2xvYWRlci1maXQuYw0KPj4+IGluZGV4IDk1M2IxNmJjODIuLmM0NjU5MjFiOGYgMTAw
NjQ0DQo+Pj4gLS0tIGEvaHcvY29yZS9sb2FkZXItZml0LmMNCj4+PiArKysgYi9ody9jb3JlL2xv
YWRlci1maXQuYw0KPj4+IEBAIC0xNzgsMTEgKzE3OCwxMiBAQCBzdGF0aWMgaW50IGZpdF9sb2Fk
X2ZkdChjb25zdCBzdHJ1Y3QgZml0X2xvYWRlciAqbGRyLCBjb25zdCB2b2lkICppdGIsDQo+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGNmZywgdm9pZCAqb3BhcXVlLCBjb25zdCB2
b2lkICptYXRjaF9kYXRhLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBr
ZXJuZWxfZW5kLCBFcnJvciAqKmVycnApDQo+Pj4gICAgew0KPj4+ICsgICAgRXJyb3IgKmVyciA9
IE5VTEw7DQo+Pj4gICAgICAgIGNvbnN0IGNoYXIgKm5hbWU7DQo+Pj4gICAgICAgIGNvbnN0IHZv
aWQgKmRhdGE7DQo+Pj4gICAgICAgIGNvbnN0IHZvaWQgKmxvYWRfZGF0YTsNCj4+PiAgICAgICAg
aHdhZGRyIGxvYWRfYWRkcjsNCj4+PiAtICAgIGludCBpbWdfb2ZmLCBlcnI7DQo+Pj4gKyAgICBp
bnQgaW1nX29mZjsNCj4+PiAgICAgICAgc2l6ZV90IHN6Ow0KPj4+ICAgICAgICBpbnQgcmV0Ow0K
Pj4+ICAgIA0KPj4+IEBAIC0xOTcsMTMgKzE5OCwxMyBAQCBzdGF0aWMgaW50IGZpdF9sb2FkX2Zk
dChjb25zdCBzdHJ1Y3QgZml0X2xvYWRlciAqbGRyLCBjb25zdCB2b2lkICppdGIsDQo+Pj4gICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+PiAgICAgICAgfQ0KPj4+ICAgIA0KPj4+IC0gICAg
ZXJyID0gZml0X2ltYWdlX2FkZHIoaXRiLCBpbWdfb2ZmLCAibG9hZCIsICZsb2FkX2FkZHIsIGVy
cnApOw0KPj4+IC0gICAgaWYgKGVyciA9PSAtRU5PRU5UKSB7DQo+Pj4gKyAgICByZXQgPSBmaXRf
aW1hZ2VfYWRkcihpdGIsIGltZ19vZmYsICJsb2FkIiwgJmxvYWRfYWRkciwgJmVycik7DQo+Pj4g
KyAgICBpZiAocmV0ID09IC1FTk9FTlQpIHsNCj4+PiAgICAgICAgICAgIGxvYWRfYWRkciA9IFJP
VU5EX1VQKGtlcm5lbF9lbmQsIDY0ICogS2lCKSArICgxMCAqIE1pQik7DQo+Pj4gLSAgICAgICAg
ZXJyb3JfZnJlZSgqZXJycCk7DQo+Pj4gLSAgICB9IGVsc2UgaWYgKGVycikgew0KPj4+IC0gICAg
ICAgIGVycm9yX3ByZXBlbmQoZXJycCwgInVuYWJsZSB0byByZWFkIEZEVCBsb2FkIGFkZHJlc3Mg
ZnJvbSBGSVQ6ICIpOw0KPj4+IC0gICAgICAgIHJldCA9IGVycjsNCj4+PiArICAgICAgICBlcnJv
cl9mcmVlKGVycik7DQo+Pj4gKyAgICB9IGVsc2UgaWYgKHJldCkgew0KPj4+ICsgICAgICAgIGVy
cm9yX3Byb3BhZ2F0ZV9wcmVwZW5kKGVycnAsIGVyciwNCj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAidW5hYmxlIHRvIHJlYWQgRkRUIGxvYWQgYWRkcmVzcyBmcm9tIEZJVDog
Iik7DQo+Pj4gICAgICAgICAgICBnb3RvIG91dDsNCj4+PiAgICAgICAgfQ0KPj4+ICAgIA0KPj4+
DQo+Pg0KPj4gU28gbXVjaCBhdHRlbnRpb24gdG8gdGhhdCBmdW5jdGlvbiA6KQ0KPj4NCj4+IEkn
ZCBhbHNvIHByb3Bvc2UgdGhlIGZvbGxvd2luZzoNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvY29y
ZS9sb2FkZXItZml0LmMgYi9ody9jb3JlL2xvYWRlci1maXQuYw0KPj4gaW5kZXggYzQ2NTkyMWI4
Zi4uMmM5ZWZlZWY3YSAxMDA2NDQNCj4+IC0tLSBhL2h3L2NvcmUvbG9hZGVyLWZpdC5jDQo+PiAr
KysgYi9ody9jb3JlL2xvYWRlci1maXQuYw0KPj4gQEAgLTE4MCw4ICsxODAsOCBAQCBzdGF0aWMg
aW50IGZpdF9sb2FkX2ZkdChjb25zdCBzdHJ1Y3QgZml0X2xvYWRlciAqbGRyLCBjb25zdCB2b2lk
ICppdGIsDQo+PiAgICB7DQo+PiAgICAgICAgRXJyb3IgKmVyciA9IE5VTEw7DQo+PiAgICAgICAg
Y29uc3QgY2hhciAqbmFtZTsNCj4+IC0gICAgY29uc3Qgdm9pZCAqZGF0YTsNCj4+IC0gICAgY29u
c3Qgdm9pZCAqbG9hZF9kYXRhOw0KPj4gKyAgICB2b2lkICpkYXRhOw0KPj4gKyAgICB2b2lkICps
b2FkX2RhdGE7DQo+PiAgICAgICAgaHdhZGRyIGxvYWRfYWRkcjsNCj4+ICAgICAgICBpbnQgaW1n
X29mZjsNCj4+ICAgICAgICBzaXplX3Qgc3o7DQo+PiBAQCAtMjE4LDkgKzIxOCw5IEBAIHN0YXRp
YyBpbnQgZml0X2xvYWRfZmR0KGNvbnN0IHN0cnVjdCBmaXRfbG9hZGVyICpsZHIsIGNvbnN0IHZv
aWQgKml0YiwNCj4+DQo+PiAgICAgICAgcmV0ID0gMDsNCj4+ICAgIG91dDoNCj4+IC0gICAgZ19m
cmVlKCh2b2lkICopIGRhdGEpOw0KPj4gKyAgICBnX2ZyZWUoZGF0YSk7DQo+PiAgICAgICAgaWYg
KGRhdGEgIT0gbG9hZF9kYXRhKSB7DQo+PiAtICAgICAgICBnX2ZyZWUoKHZvaWQgKikgbG9hZF9k
YXRhKTsNCj4+ICsgICAgICAgIGdfZnJlZShsb2FkX2RhdGEpOw0KPj4gICAgICAgIH0NCj4+ICAg
ICAgICByZXR1cm4gcmV0Ow0KPj4gICAgfQ0KPj4NCj4+DQo+PiBPciwgZXZlbiBiZXR0ZXI6DQo+
Pg0KPj4gLS0tIGEvaHcvY29yZS9sb2FkZXItZml0LmMNCj4+ICsrKyBiL2h3L2NvcmUvbG9hZGVy
LWZpdC5jDQo+PiBAQCAtMTgwLDcgKzE4MCw4IEBAIHN0YXRpYyBpbnQgZml0X2xvYWRfZmR0KGNv
bnN0IHN0cnVjdCBmaXRfbG9hZGVyICpsZHIsIGNvbnN0IHZvaWQgKml0YiwNCj4+ICAgIHsNCj4+
ICAgICAgICBFcnJvciAqZXJyID0gTlVMTDsNCj4+ICAgICAgICBjb25zdCBjaGFyICpuYW1lOw0K
Pj4gLSAgICBjb25zdCB2b2lkICpkYXRhOw0KPj4gKyAgICBnX2F1dG9mcmVlIHZvaWQgKmRhdGEg
PSBOVUxMOw0KPj4gKyAgICBnX2F1dG9mcmVlIHZvaWQgKmZkdF9maWx0ZXJfZGF0YSA9IE5VTEw7
DQo+PiAgICAgICAgY29uc3Qgdm9pZCAqbG9hZF9kYXRhOw0KPj4gICAgICAgIGh3YWRkciBsb2Fk
X2FkZHI7DQo+PiAgICAgICAgaW50IGltZ19vZmY7DQo+PiBAQCAtMjAyLDI3ICsyMDMsMjMgQEAg
c3RhdGljIGludCBmaXRfbG9hZF9mZHQoY29uc3Qgc3RydWN0IGZpdF9sb2FkZXIgKmxkciwgY29u
c3Qgdm9pZCAqaXRiLA0KPj4gICAgICAgIGlmIChyZXQgPT0gLUVOT0VOVCkgew0KPj4gICAgICAg
ICAgICBsb2FkX2FkZHIgPSBST1VORF9VUChrZXJuZWxfZW5kLCA2NCAqIEtpQikgKyAoMTAgKiBN
aUIpOw0KPj4gICAgICAgICAgICBlcnJvcl9mcmVlKGVycik7DQo+PiArICAgICAgICByZXR1cm4g
MDsNCj4+ICAgICAgICB9IGVsc2UgaWYgKHJldCkgew0KPj4gICAgICAgICAgICBlcnJvcl9wcm9w
YWdhdGVfcHJlcGVuZChlcnJwLCBlcnIsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJ1bmFibGUgdG8gcmVhZCBGRFQgbG9hZCBhZGRyZXNzIGZyb20gRklUOiAiKTsNCj4+
IC0gICAgICAgIGdvdG8gb3V0Ow0KPj4gKyAgICAgICAgcmV0dXJuIHJldDsNCj4+ICAgICAgICB9
DQo+Pg0KPj4gICAgICAgIGlmIChsZHItPmZkdF9maWx0ZXIpIHsNCj4+IC0gICAgICAgIGxvYWRf
ZGF0YSA9IGxkci0+ZmR0X2ZpbHRlcihvcGFxdWUsIGRhdGEsIG1hdGNoX2RhdGEsICZsb2FkX2Fk
ZHIpOw0KPj4gKyAgICAgICAgbG9hZF9kYXRhID0gZmR0X2ZpbHRlcl9kYXRhID0NCj4+ICsgICAg
ICAgICAgICAgICAgbGRyLT5mZHRfZmlsdGVyKG9wYXF1ZSwgZGF0YSwgbWF0Y2hfZGF0YSwgJmxv
YWRfYWRkcik7DQo+PiAgICAgICAgfQ0KPj4NCj4+ICAgICAgICBsb2FkX2FkZHIgPSBsZHItPmFk
ZHJfdG9fcGh5cyhvcGFxdWUsIGxvYWRfYWRkcik7DQo+PiAgICAgICAgc3ogPSBmZHRfdG90YWxz
aXplKGxvYWRfZGF0YSk7DQo+PiAgICAgICAgcm9tX2FkZF9ibG9iX2ZpeGVkKG5hbWUsIGxvYWRf
ZGF0YSwgc3osIGxvYWRfYWRkcik7DQo+Pg0KPj4gLSAgICByZXQgPSAwOw0KPj4gLW91dDoNCj4+
IC0gICAgZ19mcmVlKCh2b2lkICopIGRhdGEpOw0KPj4gLSAgICBpZiAoZGF0YSAhPSBsb2FkX2Rh
dGEpIHsNCj4+IC0gICAgICAgIGdfZnJlZSgodm9pZCAqKSBsb2FkX2RhdGEpOw0KPj4gLSAgICB9
DQo+PiAtICAgIHJldHVybiByZXQ7DQo+PiArICAgIHJldHVybiAwOw0KPj4gICAgfQ0KPiANCj4g
TG9va3MgbGlrZSBhIHNlbnNpYmxlIHNlcGFyYXRlIGNsZWFudXAgcGF0Y2ggdG8gbWUuICBDYXJl
IHRvIHBvc3QgaXQ/DQo+IA0KDQpZZXMsIEknbGwgc2VuZA0KDQoNCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K

