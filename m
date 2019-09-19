Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED21C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC03222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ko5yonhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC03222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAr6B-0003ai-6U
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 03:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAr55-0002uc-Iy
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAr53-0005ZB-Bu
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:42:23 -0400
Received: from mail-eopbgr40114.outbound.protection.outlook.com
 ([40.107.4.114]:12224 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAr4k-0005RO-BX; Thu, 19 Sep 2019 03:42:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8Ee7Qe4YXGWDeAapqMfVg4BvAfRyF+RL+kCRiuGPehJcnJgbhMY7ESESRFlnQr7s4wQWMGJJjsu6F/WNCT/jUn0OxiTAmOjKCorer/+xhrt3V2OqCWplCNsVZM/tauDteI/pWwPkZwNmVrah82FqZRuV/bpo1oxdpspHwAzvgxyEIAoIuGLE6EU5iMxvTDkGMzEqU9DjB29yhjQh9es0tZsSZ1cM25ID1Dd179f6WaTFgl9eEFUjnXZPvFnwa2rsfSQhrqRLqi+HDZdDfMGtwVaY3+6wcFz7B8LlL8qLA81Bze6dQwWiyniWgm+OSjI5mkOWaIZ/k56Ll2rN0FY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2f5ihVtKeFLiX/pzZKO/9HMDnO7GKbrXWE2Fq44/dE=;
 b=j17zNVln42xnodn6niLsbfHqw/0TvN8D9I99i18G+gIzaU1hGCXo616oodSjDh0bD+bhnma/YGTMKYrcwQ5E/P3AQbn+gHOsFUoAVjiTNbXPSTO/JTaq/IdmB0RUJ9sCRTmRtAyZkruGMTDyXPYM6y/Ry3gLMsp9mztqnR9IOmhFORo77nWS8QS5HIJhQeqCvyAq4p5DYGXLvpJV3IiXGOqqCmLUerhPDL9uGhx0yfq7X6wTuJZJ74L4jwTPC+olc3fpzZXF02xHQfzk13GzC64vmntqKdbF2lZjRqsNshNAuuWqDKI6NBl7RDAcMnKJ/SeVpwP4i7iuPl5n4Jw+fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2f5ihVtKeFLiX/pzZKO/9HMDnO7GKbrXWE2Fq44/dE=;
 b=Ko5yonhflkOptlKpLjekhxXlr7Azfm2XQLhp03dtYcmdMQGFahcu+jmZ+oEPCxqeatzR76rT7gemWrfZnDiHNPij7AteofgsO+DCBmZ/oWSUhuGUZTGbfzJzYZdPrHMu01y4DNgJ7PsT6/ZxCDStM6o7oGSU/lxdY6tpPQQjIqs=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5484.eurprd08.prod.outlook.com (52.133.242.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 07:41:59 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 07:41:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKcynIsAgAACmwA=
Date: Thu, 19 Sep 2019 07:41:59 +0000
Message-ID: <9d7ae167-c77c-4d8a-bbbc-c33a03a115e5@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <c4a95138-3c08-0563-d567-aa1828de7e39@redhat.com>
In-Reply-To: <c4a95138-3c08-0563-d567-aa1828de7e39@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0206.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::30) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919104154913
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a780676-387f-4f0a-a39a-08d73cd4da2b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5484; 
x-ms-traffictypediagnostic: DB8PR08MB5484:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB5484BE755274A493B40A23ACC1890@DB8PR08MB5484.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(376002)(396003)(366004)(346002)(189003)(199004)(53754006)(81156014)(478600001)(6436002)(561944003)(8676002)(4326008)(110136005)(8936002)(7736002)(7416002)(5660300002)(54906003)(6486002)(966005)(7406005)(305945005)(14454004)(6306002)(2501003)(6512007)(71200400001)(186003)(2906002)(25786009)(102836004)(31686004)(53546011)(256004)(6506007)(446003)(26005)(386003)(66066001)(66476007)(66556008)(229853002)(66946007)(81166006)(316002)(3846002)(11346002)(6116002)(66446008)(52116002)(64756008)(36756003)(6246003)(76176011)(86362001)(71190400001)(31696002)(99286004)(2616005)(476003)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5484;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FVBHXpsOY9smPaMiQtg0+C694MGKOtgHUCeJtf63Ww+ZK4L2kczoi4OfSQnM5vbN3ECt6jJes9sh9/EB6R3NApnC2pVoweeCOSOGf9Tgi6PFvZ0i0rOthTeR5s6tRHn7okdrOaWe0JkhLt39h/MEBEYQc5HTB648Jvgp99k9ZsFvd3Ti86OhES2K1/abj7qq3W70fDqEQXypxBJ7kora+C0EVuM8iPLRD6dWDy9UK1JNnwWBxgAI1ciIh77tfgSV26SYk1gddHKucC33/hkQp+OS0cGzm+caH4Yh2Fxj4r8b+lenGF8qz/TQA1SwFE0XsVHF15C5dI0V91cVi+8E/RNzs5ry2JHBsubB8hTVbaloHrOYMzrvvxZbgk8ahp7DWkT0Dkh3bwn9BF2b1jXFojfcx4qYHS0wUgJm/cZgtoA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9B78A44054FE5429D53F36F913566C7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a780676-387f-4f0a-a39a-08d73cd4da2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 07:41:59.0353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89r1Cv49HfZ+veZGTdFOjbjKDLcLZ8rYLE8GBe52LK2JERf964GLYSlaXlFNi9ayuDW356pyGdfRqbmwLWtQXv7fYizTjX0fZi7fm2qvI98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5484
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.114
Subject: Re: [Qemu-devel] [RFC] error: auto propagated local_err
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "codyprime@gmail.com" <codyprime@gmail.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDkuMjAxOSAxMDozMiwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+IE9uIDE4LjA5LjE5
IDE1OjAyLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gSGkgYWxsIQ0K
Pj4NCj4+IEhlcmUgaXMgYSBwcm9wb3NhbCAodGhyZWUgb2YgdGhlbSwgYWN0dWFsbHkpIG9mIGF1
dG8gcHJvcGFnYXRpb24gZm9yDQo+PiBsb2NhbF9lcnIsIHRvIG5vdCBjYWxsIGVycm9yX3Byb3Bh
Z2F0ZSBvbiBldmVyeSBleGl0IHBvaW50LCB3aGVuIHdlDQo+PiBkZWFsIHdpdGggbG9jYWxfZXJy
Lg0KPj4NCj4+IEl0IGFsc28gbWF5IGhlbHAgbWFrZSBHcmVnJ3Mgc2VyaWVzWzFdIGFib3V0IGVy
cm9yX2FwcGVuZF9oaW50IHNtYWxsZXIuDQo+Pg0KPj4gU2VlIGRlZmluaXRpb25zIGFuZCBleGFt
cGxlcyBiZWxvdy4NCj4+DQo+PiBJJ20gY2MtaW5nIHRvIHRoaXMgUkZDIGV2ZXJ5b25lIGZyb20g
c2VyaWVzWzFdIENDIGxpc3QsIGFzIGlmIHdlIGxpa2UNCj4+IGl0LCB0aGUgaWRlYSB3aWxsIHRv
dWNoIHNhbWUgY29kZSAoYW5kIG1heSBiZSBtb3JlKS4NCj4+DQo+PiBbMV06IGh0dHBzOi8vbGlz
dHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTA5L21zZzAzNDQ5Lmh0bWwN
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2Vt
ZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS9xYXBpL2Vycm9yLmgg
fCAxMDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBi
bG9jay5jICAgICAgICAgICAgICB8ICA2MyArKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPj4g
ICBibG9jay9iYWNrdXAuYyAgICAgICB8ICAgOCArKystDQo+PiAgIGJsb2NrL2dsdXN0ZXIuYyAg
ICAgIHwgICA3ICsrKw0KPj4gICA0IGZpbGVzIGNoYW5nZWQsIDE0NCBpbnNlcnRpb25zKCspLCAz
NiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xYXBpL2Vycm9yLmgg
Yi9pbmNsdWRlL3FhcGkvZXJyb3IuaA0KPj4gaW5kZXggM2Y5NTE0MWEwMS4uMDgzZTA2MTAxNCAx
MDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvcWFwaS9lcnJvci5oDQo+PiArKysgYi9pbmNsdWRlL3Fh
cGkvZXJyb3IuaA0KPj4gQEAgLTMyMiw2ICszMjIsMTA4IEBAIHZvaWQgZXJyb3Jfc2V0X2ludGVy
bmFsKEVycm9yICoqZXJycCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3JDbGFz
cyBlcnJfY2xhc3MsIGNvbnN0IGNoYXIgKmZtdCwgLi4uKQ0KPj4gICAgICAgR0NDX0ZNVF9BVFRS
KDYsIDcpOw0KPj4gICANCj4+ICt0eXBlZGVmIHN0cnVjdCBFcnJvclByb3BhZ2F0b3Igew0KPj4g
KyAgICBFcnJvciAqKmVycnA7DQo+PiArICAgIEVycm9yICpsb2NhbF9lcnI7DQo+PiArfSBFcnJv
clByb3BhZ2F0b3I7DQo+PiArDQo+PiArc3RhdGljIGlubGluZSB2b2lkIGVycm9yX3Byb3BhZ2F0
b3JfY2xlYW51cChFcnJvclByb3BhZ2F0b3IgKnByb3ApDQo+PiArew0KPj4gKyAgICBpZiAocHJv
cC0+bG9jYWxfZXJyKSB7DQo+PiArICAgICAgICBlcnJvcl9wcm9wYWdhdGUocHJvcC0+ZXJycCwg
cHJvcC0+bG9jYWxfZXJyKTsNCj4+ICsgICAgfQ0KPj4gK30NCj4+ICsNCj4+ICtHX0RFRklORV9B
VVRPX0NMRUFOVVBfQ0xFQVJfRlVOQyhFcnJvclByb3BhZ2F0b3IsIGVycm9yX3Byb3BhZ2F0b3Jf
Y2xlYW51cCk7DQo+PiArDQo+PiArLyoNCj4+ICsgKiBFcnJvclByb3BhZ2F0aW9uUGFpcg0KPj4g
KyAqDQo+PiArICogW0Vycm9yICpsb2NhbF9lcnIsIEVycm9yICoqZXJycF0NCj4+ICsgKg0KPj4g
KyAqIEZpcnN0IGVsZW1lbnQgaXMgbG9jYWxfZXJyLCBzZWNvbmQgaXMgb3JpZ2luYWwgZXJycCwg
d2hpY2ggaXMgcHJvcGFnYXRpb24NCj4+ICsgKiB0YXJnZXQuIFllcywgZXJycCBoYXMgYSBiaXQg
YW5vdGhlciB0eXBlLCBzbyBpdCBzaG91bGQgYmUgY29udmVydGVkLg0KPj4gKyAqDQo+PiArICog
RXJyb3JQcm9wYWdhdGlvblBhaXIgbWF5IGJlIHVzZWQgYXMgZXJycCwgd2hpY2ggcG9pbnRzIHRv
IGxvY2FsX2VyciwNCj4+ICsgKiBhcyBpdCdzIHR5cGUgaXMgY29tcGF0aWJsZS4NCj4+ICsgKi8N
Cj4+ICt0eXBlZGVmIEVycm9yICpFcnJvclByb3BhZ2F0aW9uUGFpclsyXTsNCj4+ICsNCj4+ICtz
dGF0aWMgaW5saW5lIHZvaWQgZXJyb3JfcHJvcGFnYXRpb25fcGFpcl9jbGVhbnVwKEVycm9yUHJv
cGFnYXRpb25QYWlyICphcnIpDQo+PiArew0KPj4gKyAgICBFcnJvciAqbG9jYWxfZXJyID0gKCph
cnIpWzBdOw0KPj4gKyAgICBFcnJvciAqKmVycnAgPSAoRXJyb3IgKiopKCphcnIpWzFdOw0KPj4g
Kw0KPj4gKyAgICBpZiAobG9jYWxfZXJyKSB7DQo+PiArICAgICAgICBlcnJvcl9wcm9wYWdhdGUo
ZXJycCwgbG9jYWxfZXJyKTsNCj4+ICsgICAgfQ0KPj4gK30NCj4+ICsNCj4+ICtHX0RFRklORV9B
VVRPX0NMRUFOVVBfQ0xFQVJfRlVOQyhFcnJvclByb3BhZ2F0aW9uUGFpciwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJvcl9wcm9wYWdhdGlvbl9wYWlyX2NsZWFudXAp
Ow0KPj4gKw0KPj4gKy8qDQo+PiArICogREVGX0FVVE9fRVJSUA0KPj4gKyAqDQo+PiArICogRGVm
aW5lIGF1dG9fZXJycCB2YXJpYWJsZSwgd2hpY2ggbWF5IGJlIHVzZWQgaW5zdGVhZCBvZiBlcnJw
LCBhbmQNCj4+ICsgKiAqYXV0b19lcnJwIG1heSBiZSBzYWZlbHkgY2hlY2tlZCB0byBiZSB6ZXJv
IG9yIG5vdCwgYW5kIG1heSBiZSBzYWZlbHkNCj4+ICsgKiB1c2VkIGZvciBlcnJvcl9hcHBlbmRf
aGludCgpLiBhdXRvX2VycnAgaXMgYXV0b21hdGljYWxseSBwcm9wYWdhdGVkDQo+PiArICogdG8g
ZXJycCBhdCBmdW5jdGlvbiBleGl0Lg0KPj4gKyAqLw0KPj4gKyNkZWZpbmUgREVGX0FVVE9fRVJS
UChhdXRvX2VycnAsIGVycnApIFwNCj4+ICsgICAgZ19hdXRvKEVycm9yUHJvcGFnYXRpb25QYWly
KSAoYXV0b19lcnJwKSA9IHtOVUxMLCAoRXJyb3IgKikoZXJycCl9DQo+PiArDQo+PiArDQo+PiAr
LyoNCj4+ICsgKiBBbm90aGVyIHZhcmlhbnQ6DQo+PiArICogICBQcm9zOg0KPj4gKyAqICAgICAt
IG5vcm1hbCBzdHJ1Y3R1cmUgaW5zdGVhZCBvZiBjaGVhdGluZyB3aXRoIGFycmF5DQo+PiArICog
ICAgIC0gd2UgY2FuIGRpcmVjdGx5IHVzZSBlcnJwLCBpZiBpdCdzIG5vdCBOVUxMIGFuZCBkb24n
dCBwb2ludCB0bw0KPj4gKyAqICAgICAgIGVycm9yX2Fib3J0IG9yIGVycm9yX2ZhdGFsDQo+PiAr
ICogICBDb25zOg0KPj4gKyAqICAgICAtIHdlIG5lZWQgdG8gZGVmaW5lIHR3byB2YXJpYWJsZXMg
aW5zdGVhZCBvZiBvbmUNCj4+ICsgKi8NCj4+ICt0eXBlZGVmIHN0cnVjdCBFcnJvclByb3BhZ2F0
aW9uU3RydWN0IHsNCj4+ICsgICAgRXJyb3IgKmxvY2FsX2VycjsNCj4+ICsgICAgRXJyb3IgKipl
cnJwOw0KPj4gK30gRXJyb3JQcm9wYWdhdGlvblN0cnVjdDsNCj4+ICsNCj4+ICtzdGF0aWMgaW5s
aW5lIHZvaWQgZXJyb3JfcHJvcGFnYXRpb25fc3RydWN0X2NsZWFudXAoRXJyb3JQcm9wYWdhdGlv
blN0cnVjdCAqcHJvcCkNCj4+ICt7DQo+PiArICAgIGlmIChwcm9wLT5sb2NhbF9lcnIpIHsNCj4+
ICsgICAgICAgIGVycm9yX3Byb3BhZ2F0ZShwcm9wLT5lcnJwLCBwcm9wLT5sb2NhbF9lcnIpOw0K
Pj4gKyAgICB9DQo+PiArfQ0KPj4gKw0KPj4gK0dfREVGSU5FX0FVVE9fQ0xFQU5VUF9DTEVBUl9G
VU5DKEVycm9yUHJvcGFnYXRpb25TdHJ1Y3QsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZXJyb3JfcHJvcGFnYXRpb25fc3RydWN0X2NsZWFudXApOw0KPj4gKw0KPj4gKyNk
ZWZpbmUgREVGX0FVVE9fRVJSUF9WMihhdXRvX2VycnAsIGVycnApIFwNCj4+ICsgICAgZ19hdXRv
KEVycm9yUHJvcGFnYXRpb25TdHJ1Y3QpIChfX2F1dG9fZXJycF9wcm9wKSA9IHsuZXJycCA9IChl
cnJwKX07IFwNCj4+ICsgICAgRXJyb3IgKiphdXRvX2VycnAgPSBcDQo+PiArICAgICAgICAoKGVy
cnApID09IE5VTEwgfHwgKihlcnJwKSA9PSBlcnJvcl9hYm9ydCB8fCAqKGVycnApID09IGVycm9y
X2ZhdGFsKSA/IFwNCj4+ICsgICAgICAgICZfX2F1dG9fZXJycF9wcm9wLmxvY2FsX2VyciA6IFwN
Cj4+ICsgICAgICAgIChlcnJwKTsNCj4+ICsNCj4+ICsvKg0KPj4gKyAqIFRoaXJkIHZhcmlhbnQ6
DQo+PiArICogICBQcm9zOg0KPj4gKyAqICAgICAtIHNpbXBsZXIgbW92ZW1lbnQgZm9yIGZ1bmN0
aW9ucyB3aGljaCBkb24ndCBoYXZlIGxvY2FsX2VyciB5ZXQNCj4+ICsgKiAgICAgICB0aGUgb25s
eSB0aGluZyB0byBkbyBpcyB0byBjYWxsIG9uZSBtYWNybyBhdCBmdW5jdGlvbiBzdGFydC4NCj4+
ICsgKiAgICAgICBUaGlzIGV4dHJlbWVseSBzaW1wbGlmaWVzIEdyZWcncyBzZXJpZXMNCj4+ICsg
KiAgIENvbnM6DQo+PiArICogICAgIC0gbG9va3MgbGlrZSBlcnJwIHNoYWRvd2luZy4uIFN0aWxs
IHNlZW1zIHNhZmUuDQo+PiArICogICAgIC0gbXVzdCBiZSBhZnRlciBhbGwgZGVmaW5pdGlvbnMg
b2YgbG9jYWwgdmFyaWFibGVzIGFuZCBiZWZvcmUgYW55DQo+PiArICogICAgICAgY29kZS4NCj4+
ICsgKiAgICAgLSBsaWtlIHYyLCBzZXZlcmFsIHN0YXRlbWVudHMgaW4gb25lIG9wZW4gbWFjcm8N
Cj4+ICsgKi8NCj4+ICsjZGVmaW5lIE1BS0VfRVJSUF9TQUZFKGVycnApIFwNCj4+ICtnX2F1dG8o
RXJyb3JQcm9wYWdhdGlvblN0cnVjdCkgKF9fYXV0b19lcnJwX3Byb3ApID0gey5lcnJwID0gKGVy
cnApfTsgXA0KPj4gK2lmICgoZXJycCkgPT0gTlVMTCB8fCAqKGVycnApID09IGVycm9yX2Fib3J0
IHx8ICooZXJycCkgPT0gZXJyb3JfZmF0YWwpIHsgXA0KPj4gKyAgICAoZXJycCkgPSAmX19hdXRv
X2VycnBfcHJvcC5sb2NhbF9lcnI7IFwNCj4+ICt9DQo+IA0KPiANCj4gVXNpbmcgdGhhdCBpZGVh
LCB3aGF0IGFib3V0IHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcv
czM5MHgvczM5MC12aXJ0aW8tY2N3LmMgYi9ody9zMzkweC9zMzkwLXZpcnRpby1jY3cuYw0KPiBp
bmRleCA4YmZiNjY4NGNiLi4wNDNhZDY5ZjhiIDEwMDY0NA0KPiAtLS0gYS9ody9zMzkweC9zMzkw
LXZpcnRpby1jY3cuYw0KPiArKysgYi9ody9zMzkweC9zMzkwLXZpcnRpby1jY3cuYw0KPiBAQCAt
NTgsMjIgKzU4LDQyIEBAIFMzOTBDUFUgKnMzOTBfY3B1X2FkZHIyc3RhdGUodWludDE2X3QgY3B1
X2FkZHIpDQo+ICAgICAgIHJldHVybiBTMzkwX0NQVShtcy0+cG9zc2libGVfY3B1cy0+Y3B1c1tj
cHVfYWRkcl0uY3B1KTsNCj4gICB9DQo+ICAgDQo+ICt0eXBlZGVmIHN0cnVjdCBFcnJvclByb3Bh
Z2F0b3Igew0KPiArICAgIEVycm9yICoqZXJycDsNCj4gKyAgICBFcnJvciAqbG9jYWxfZXJyOw0K
PiArfSBFcnJvclByb3BhZ2F0b3I7DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBlcnJvcl9w
cm9wYWdhdG9yX2NsZWFudXAoRXJyb3JQcm9wYWdhdG9yICpwcm9wKQ0KPiArew0KPiArICAgIGlm
IChwcm9wLT5sb2NhbF9lcnIpIHsNCj4gKyAgICAgICAgZXJyb3JfcHJvcGFnYXRlKHByb3AtPmVy
cnAsIHByb3AtPmxvY2FsX2Vycik7DQo+ICsgICAgfQ0KPiArfQ0KPiArDQo+ICtHX0RFRklORV9B
VVRPX0NMRUFOVVBfQ0xFQVJfRlVOQyhFcnJvclByb3BhZ2F0b3IsIGVycm9yX3Byb3BhZ2F0b3Jf
Y2xlYW51cCk7DQo+ICsNCj4gKyNkZWZpbmUgREVGSU5FX0xPQ0FMX0VSUlAoX2VycnApIFwNCj4g
K2dfYXV0byhFcnJvclByb3BhZ2F0b3IpIChfX2F1dG9fZXJycF9wcm9wKSA9IHsuZXJycCA9IChf
ZXJycCl9OyBcDQo+ICtFcnJvciAqKmxvY2FsX2VycnAgPSAmX19hdXRvX2VycnBfcHJvcC5sb2Nh
bF9lcnINCj4gKw0KPiAgIHN0YXRpYyBTMzkwQ1BVICpzMzkweF9uZXdfY3B1KGNvbnN0IGNoYXIg
KnR5cGVuYW1lLCB1aW50MzJfdCBjb3JlX2lkLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEVycm9yICoqZXJycCkNCj4gICB7DQo+ICsgICAgREVGSU5FX0xPQ0FMX0VSUlAoZXJy
cCk7DQo+ICAgICAgIFMzOTBDUFUgKmNwdSA9IFMzOTBfQ1BVKG9iamVjdF9uZXcodHlwZW5hbWUp
KTsNCj4gLSAgICBFcnJvciAqZXJyID0gTlVMTDsNCj4gICANCj4gLSAgICBvYmplY3RfcHJvcGVy
dHlfc2V0X2ludChPQkpFQ1QoY3B1KSwgY29yZV9pZCwgImNvcmUtaWQiLCAmZXJyKTsNCj4gLSAg
ICBpZiAoZXJyICE9IE5VTEwpIHsNCj4gKyAgICBvYmplY3RfcHJvcGVydHlfc2V0X2ludChPQkpF
Q1QoY3B1KSwgY29yZV9pZCwgImNvcmUtaWQiLCBsb2NhbF9lcnJwKTsNCj4gKyAgICBpZiAoKmxv
Y2FsX2VycnAgIT0gTlVMTCkgew0KPiAgICAgICAgICAgZ290byBvdXQ7DQo+ICAgICAgIH0NCj4g
LSAgICBvYmplY3RfcHJvcGVydHlfc2V0X2Jvb2woT0JKRUNUKGNwdSksIHRydWUsICJyZWFsaXpl
ZCIsICZlcnIpOw0KPiArICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9vbChPQkpFQ1QoY3B1KSwg
dHJ1ZSwgInJlYWxpemVkIiwgbG9jYWxfZXJycCk7DQo+ICAgDQo+ICAgb3V0Og0KPiAgICAgICBv
YmplY3RfdW5yZWYoT0JKRUNUKGNwdSkpOw0KPiAtICAgIGlmIChlcnIpIHsNCj4gLSAgICAgICAg
ZXJyb3JfcHJvcGFnYXRlKGVycnAsIGVycik7DQo+ICsgICAgaWYgKCpsb2NhbF9lcnJwKSB7DQo+
ICAgICAgICAgICBjcHUgPSBOVUxMOw0KPiAgICAgICB9DQo+ICAgICAgIHJldHVybiBjcHU7DQo+
IA0KPiANCg0KU28gaXQncyBERUZfQVVUT19FUlJQX1YyIHdpdGggZmlyc3QgcGFyYW1ldGVyIGhh
cmRjb2RlZCB0byBiZSBsb2NhbF9lcnJwLg0KSSBzdGlsbCBwcmVmZXIgTUFLRV9FUlJQX1NBRkUo
KSwgdG8gbm90IGludHJvZHVjZSBleHRyYSB2YXJpYWJsZXMuDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

