Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB6BECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198C520679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IKfgSJdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198C520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGPv-000672-5e
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iI8tT-0008LE-V4
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 06:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iI8tS-0004YT-6u
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 06:08:31 -0400
Received: from mail-eopbgr130121.outbound.protection.outlook.com
 ([40.107.13.121]:12123 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iI8tR-0004Xk-Fu
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 06:08:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1RQccy8n7lPm+wjJTYKVJdvHpQc5Skcv/XEeaN5dmhXpWsjJIvAwo1mDRVHFoj1kKlXRnxFAWvDtKzbwFBmGH6s0//3Hfi6dJf5VxDJIBpXXuzjIGIFY+wtn8gIgTTpTz6o/VAFj4fB6hkZRlFd2ZUO+95rxg/vfGMOpR3gAw//suv+GpsRAm9k4eh8/L36S5uhc06eYX7U3p6rhQw2slERLCOMXD1LypQdQiWhHHeEc4fs6XqY93gSqQVJ0t0S4YxAKMETpMNCEaM5/842BeR0MpUrnFmpP6KOYl2k6t1arSaj5bogl2TgSmc9snJulHnhLLlDDWHyZTicE+6ddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIKwT82FJQZ1HO4Adk11ccddNEEmB2FX2n6vBbpuAV8=;
 b=EM7fgW+l2GMyGMD1gtHd4vXdk3M4gj4yYrRtUPKYu/03DyVZB52I8YdR+txyXxMi8ePN5THz+VqyYGwhrvLvQ+m78dUWUnTKzsk6zL0b+Ztxnz8wlvi1inr2o3W8aBMnYTLpWulVIty9L+F7ZvpK+oq4T7il61JUmku1zLKcVo5QfwS83faDKGRfEE3kfFOu60Cs8KMiWzB8oTwqS+7A83Ahql/2ihVNjIVHn6CkwViJ1h/pUFljQbbggbuKL3gHtIyIyRy5RDgXeTg/RmFEB/aksr5fng3LOHehjdKsZPi7mH1PDHeUateLAAbEJ7nIOeox6ujeuFtbW3mFOytTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIKwT82FJQZ1HO4Adk11ccddNEEmB2FX2n6vBbpuAV8=;
 b=IKfgSJdTh/UarcYJMDlarlNtdyVO7FIeqVCesSHacVm09l5Qseq41+ZJOPENizhe7IC5YRa2C96F38hd7NDvHo5FIGC16W9Id2YvUorpfvEASBncC+ba7Dnm7NZOAPN36r/cEPkv7QFRK+vKLksIBLcHrVTf/bbDZU/Ckp31p8Y=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4937.eurprd08.prod.outlook.com (10.255.19.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Wed, 9 Oct 2019 10:08:25 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 10:08:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 01/31] errp: rename errp to errp_in where it is
 IN-argument
Thread-Topic: [PATCH v4 01/31] errp: rename errp to errp_in where it is
 IN-argument
Thread-Index: AQHVeHBgGNp8AunJykKebkfVAuWGs6dQfy49gAAF3wCAACt6r4ABcY+A
Date: Wed, 9 Oct 2019 10:08:25 +0000
Message-ID: <155beb1a-b50f-4ee0-ec19-4a71f620de79@virtuozzo.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-2-vsementsov@virtuozzo.com>
 <878spvmwns.fsf@dusky.pond.sub.org>
 <8f936e58-988f-b5af-266d-4230a477ada4@virtuozzo.com>
 <87v9szjvcx.fsf@dusky.pond.sub.org>
In-Reply-To: <87v9szjvcx.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0052.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::41)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191009130823282
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7240016d-6da4-4c9d-6e19-08d74ca09fa1
x-ms-traffictypediagnostic: DB8PR08MB4937:
x-microsoft-antispam-prvs: <DB8PR08MB49370349FBF7CCB383701528C1950@DB8PR08MB4937.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(376002)(396003)(366004)(346002)(189003)(199004)(81166006)(8676002)(81156014)(3846002)(71190400001)(6916009)(8936002)(66066001)(2906002)(14444005)(6246003)(256004)(14454004)(6486002)(6436002)(71200400001)(4326008)(36756003)(25786009)(99286004)(229853002)(31686004)(478600001)(476003)(11346002)(446003)(6116002)(2616005)(6506007)(386003)(486006)(54906003)(102836004)(86362001)(76176011)(52116002)(66946007)(26005)(6512007)(316002)(186003)(305945005)(7736002)(66476007)(66556008)(64756008)(66446008)(31696002)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4937;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: igYPgQnSks9aiRJx/zPh6PsodHTF61pU2FcaUWSWGlwTrKp/ffMXysYF7KGmc9d5XMk2hBQ/FSbwL4nJhic3wSKLyUrWQ8SU5XQ8T31e7eON/rtCZCAQSDLcZpMkyAMGvSFEUytujtoMIvvnwu0e6tYV3iE2pe1UAQbMUBK1i7uDvjW8iSGoIVqfLpJUmMT13xaHu/y6Gdlvqa197Z+ZTTarVpCeVsdvoRCq90xWDFztdsSU7M7nbQDjbkw8D+PMFw8GzhYrnkK8LwJXF3YthSdHBYY4VVDmwaDTM1fHViIC2TzSNg+/RPBq8Jw1dITkAsSZqi3Q0z1l60Ss/WQGEnV38LpUxTeEbUF998TrGhabnqGD0NJ3UANlzRMg9k9CedCfTHLaqof5ncmWuhtC4K9N8r984HMjgXxHJW2bkT4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6898BAB048FE946847EDB5C61404617@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7240016d-6da4-4c9d-6e19-08d74ca09fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 10:08:25.3940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z5SFEsEYf1zpMP58QJWJwPdqP42C22rpKCC+OF3I6wCwIA2RdzV/wIrp/3zkOtxbw1Sa5NKTt0tSXahD2gBuVn8Q373INn7qNO6LBlPHajU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4937
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.121
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDguMTAuMjAxOSAxNTowNSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiAN
Cj4+IDA4LjEwLjIwMTkgMTI6MDgsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPj4+IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVz
Og0KPj4+DQo+Pj4+IEVycm9yICoqZXJycCBpcyBhbG1vc3QgYWx3YXlzIE9VVC1hcmd1bWVudDog
aXQncyBhc3N1bWVkIHRvIGJlIE5VTEwsIG9yDQo+Pj4+IHBvaW50ZXIgdG8gTlVMTC1pbml0aWFs
aXplZCBwb2ludGVyLCBvciBwb2ludGVyIHRvIGVycm9yX2Fib3J0IG9yDQo+Pj4+IGVycm9yX2Zh
dGFsLCBmb3IgY2FsbGVlIHRvIHJlcG9ydCBlcnJvci4NCj4+Pg0KPj4+IFllcy4NCj4+Pg0KPj4+
PiBCdXQgdmVyeSBmZXcgZnVuY3Rpb25zIGluc3RlYWQgZ2V0IEVycm9yICoqZXJycCBhcyBJTi1h
cmd1bWVudDoNCj4+Pj4gaXQncyBhc3N1bWVkIHRvIGJlIHNldCwgYW5kIGNhbGxlZSBzaG91bGQg
Y2xlYW4gaXQuDQo+Pj4NCj4+PiBXaGF0IGRvIHlvdSBtZWFuIGJ5ICJjYWxsZWUgc2hvdWxkIGNs
ZWFuIj8gIExldCdzIHNlZSBiZWxvdy4NCj4+Pg0KPj4+PiBJbiBzdWNoIGNhc2VzLCByZW5hbWUg
ZXJycCB0byBlcnJwX2luLg0KPj4+DQo+Pj4gSSBhY2tub3dsZWRnZSB0aGF0IGVycnAgYXJndW1l
bnRzIHRoYXQgZG9uJ3QgaGF2ZSB0aGUgdXN1YWwgbWVhbmluZyBjYW4NCj4+PiBiZSBjb25mdXNp
bmcuDQo+Pj4NCj4+PiBOYW1pbmcgY2FuIGhlbHAsIGNvbW1lbnRzIGNhbiBoZWxwLCBidXQgcGVy
aGFwcyB3ZSBjYW4gdHdlYWsgdGhlIGNvZGUgdG8NCj4+PiBhdm9pZCB0aGUgcHJvYmxlbSBpbnN0
ZWFkLiAgTGV0J3Mgc2VlOg0KPj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4gUmV2aWV3ZWQt
Ynk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KPiBbLi4uXQ0KPj4+IFdlIGNhbiBh
dm9pZCB0aGUgY29uZnVzaW5nIEVycm9yICoqZXJycCBpbiBhbGwgdGhyZWUgY2FzZXMgYnkgcGVl
bGluZw0KPj4+IG9mZiBhbiBpbmRpcmVjdGlvbi4gIFdoYXQgZG8geW91IHRoaW5rPw0KPj4+DQo+
Pg0KPj4gSSBsaWtlIHRoZSBpZGVhLCB0aGFua3MhIEkgdGhpbmssIEknbGwgdHJ5IHRvIG1ha2Ug
YSBwYXRjaC4NCj4+DQo+PiBCdXQgeW91IGFyZSByaWdodCwgdW5mb3J0dW5hdGVseSB0aGVyZSBt
b3JlIGNhc2VzLCBhdCBsZWFzdCwgcG9pbnRlZCBieQ0KPj4gR3JlZw0KPj4NCj4+IGVycm9yX2Fw
cGVuZF9zb2NrZXRfc29ja2ZkX2hpbnQgYW5kDQo+PiBlcnJvcl9hcHBlbmRfc2VjdXJpdHlfbW9k
ZWxfaGludA0KPj4NCj4+IFdoaWNoIGRvbid0IGZyZWUgZXJyb3IuLg0KPiANCj4gTmVpdGhlciBk
byBlcnJvcl9hcHBlbmRfaGludCgpIGFuZCBlcnJvcl9wcmVwZW5kKCkuDQo+IA0KPiBGb3IgYW55
dGhpbmcgbmFtZWQgZXJyb3JfYXBwZW5kX0ZPT19oaW50KCkgb3IgZXJyb3JfcHJlcGVuZF9GT08o
KSwNCj4gY29uZnVzaW9uIHNlZW1zIHVubGlrZWx5Lg0KPiANCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgQnV0IGlmIHRoZXkgYXBwZW5kIGhpbnQsIHRoZXkgc2hvdWxkIGFsd2F5cyBiZSBj
YWxsZWQNCj4+IG9uIHdyYXBwZWQgZXJycCwgYWNjb3JkaW5nbHkgdG8gdGhlIHByb2JsZW0gYWJv
dXQgZmF0YWxfZXJyb3IsIHNvIHRoZXkgbWF5DQo+PiBiZSBjb252ZXJ0ZWQgdG8gRXJyb3IgKmVy
ciB0b28uLiBIbW0sIEkgc2hvdWxkIHRoaW5rIGFib3V0IHRoZSBzY3JpcHQgdG8gZmluZA0KPj4g
c3VjaCBmdW5jdGlvbnMuDQo+IA0KPiBJIGZpZ3VyZSBJIGJldHRlciByZWFkIG1vcmUgb2YgeW91
ciBzZXJpZXMgYmVmb3JlIEkgY29tbWVudCBvbiB0aGlzDQo+IHRob3VnaHQuDQo+IA0KDQpNZSB0
cnlpbmcgdG8gZmluZCBtb3JlIHN1Y2ggZnVuY3Rpb25zOg0KDQpzY3JpcHQ6DQojIGNhdCAuLi91
cC1maXgtZXJyb3JfYXBwZW5kX2hpbnQvZmluZC5weQ0KIyEvdXNyL2Jpbi9lbnYgcHl0aG9uDQpp
bXBvcnQgcmUNCmltcG9ydCBzeXMNCg0KcmV0X3R5cGUgPSByJ15bXnt9OyNdKyggfFwqfFwqXCop
Jw0KbmFtZSA9IHInKD9QPG5hbWU+XHcrKScNCmFyZ3MgPSByJ1woW157fTsjXSpFcnJvciBcKlwq
ZXJycFtee307I10qXCknDQpib2R5X2JlZm9yZV9lcnJwID0gcicoKD88IWVycnApW159XXwoPzwh
Xil9KSonDQoNCmNhbGxlciA9ICcoaWYgP3xhc3NlcnR8JyBcDQogICAgICAgICAgICdlcnJvcl8o
dj9wcmVwZW5kfGdldF9wcmV0dHl8YXBwZW5kX2hpbnR8ZnJlZXxmcmVlX29yX2Fib3J0KXwnIFwN
CiAgICAgICAgICAgJyh3YXJufGVycm9yKV9yZXBvcnRmP19lcnIpJw0KDQojIE1hdGNoICdjYWxs
ZXIoZXJycCcsICdjYWxsZXIoKmVycnAnLCAnZXJycCA/Jw0KYWNjZXNzX2VycnAgPSAnKCcgKyBj
YWxsZXIgKyByJ1woXCo/ZXJycHxlcnJwIFw/KScNCg0KciA9IHJlLmNvbXBpbGUocmV0X3R5cGUg
KyBuYW1lICsgYXJncyArICdccypeXHsnICsgYm9keV9iZWZvcmVfZXJycCArIGFjY2Vzc19lcnJw
LCByZS5NKQ0KDQp3aXRoIG9wZW4oc3lzLmFyZ3ZbMV0pIGFzIGY6DQogICAgIHRleHQgPSBmLnJl
YWQoKQ0KDQpmb3IgbSBpbiByLmZpbmRpdGVyKHRleHQpOg0KICAgICBwcmludChtLmdyb3VwZGlj
dCgpWyduYW1lJ10pDQoNCg0Kc2VhcmNoOg0KIyBnaXQgbHMtZmlsZXMgfCBncmVwICdcLlwoaFx8
Y1wpJCcgfCB3aGlsZSByZWFkIGY7IGRvIC4uL3VwLWZpeC1lcnJvcl9hcHBlbmRfaGludC9maW5k
LnB5ICRmOyBkb25lDQp2bWRrX2NvX2NyZWF0ZV9vcHRzX2NiDQplcnJvcl9hcHBlbmRfc2VjdXJp
dHlfbW9kZWxfaGludA0KZXJyb3JfYXBwZW5kX3NvY2tldF9zb2NrZmRfaGludA0KcWVtdV9maWxl
X2dldF9lcnJvcl9vYmoNCmhtcF9oYW5kbGVfZXJyb3INCnFidXNfbGlzdF9idXMNCnFidXNfbGlz
dF9kZXYNCmt2bXBwY19oaW50X3NtdF9wb3NzaWJsZQ0Kdm5jX2NsaWVudF9pb19lcnJvcg0KZXJy
b3JfaGFuZGxlX2ZhdGFsDQplcnJvcl9zZXR2DQplcnJvcl9wcmVwZW5kDQplcnJvcl9zZXRnX3dp
bjMyX2ludGVybmFsDQplcnJvcl9mcmVlX29yX2Fib3J0DQoNCnZtZGtfY29fY3JlYXRlX29wdHNf
Y2IgYW5kIHFlbXVfZmlsZV9nZXRfZXJyb3Jfb2JqIGFyZSBmYWxzZSBwb3NpdGl2ZXMgSSB0aGlu
aw0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

