Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16935C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D347321A4C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="S1A33AcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D347321A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55669 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFfFW-00076S-2O
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 10:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFfED-0006Kx-7E
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFfEB-00034p-TY
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:03:41 -0400
Received: from mail-eopbgr30102.outbound.protection.outlook.com
 ([40.107.3.102]:3041 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFfE8-00031A-Fj; Wed, 02 Oct 2019 10:03:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqEtmyLeFD9hA+K9RyOHQC6rXHUZdN6JhqSXVcqzMYApxvEwvfengtyg1Pk5/eqiS8ceBtomXN89RAcHorUDbKTyxB2d1N0AwbBqft7X3kvlqGvBQJD6aVRd6pqm3l8OIUZTknrBbiXOgp9YVNmjIG9siDQNeGjk2u5obIyxTFab6lRveU0Yj6hkMhVAt+53UZqx2RD9BbdVObe73kK0SpdJHsqujDkHp7rRHzjJz6G001T9oZfV92KoTFKwMRJsyPr6lO91Wk8CtKvqMx7cYlIPifJsw/MfwDfsdFh9qp8SFsTketZvY5Y/gQWgmly6RSsLH/Sa738JDdMTzDoKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeF1X87uoJvQbzbAPKMo85LsUvA16l7T794HfCJ7nRg=;
 b=UNdciyZiF9gaDZxB2Wh1kIMyP/hXXtv/IfU2GHxwoR15AUZ2ss3j6HbJKPwt6vh7814XdFySxN7LTYil6mgeVaQF07bBXxEH/gXHd4KmFGfBZdymlkWjh99Z098BhokhJ0bwEd5h4YMBFfcq7ok8wnFn8jkpL594eNhs0KLOfb/jfTDOjQ33ShQNWvXRnA6nNmUPwrUQWQDRJQmJDxhVs1h3DOvluBAeN8B7avunnarEM39f1ZXRidRw3juTZ+8KN1fB940NmSFBD4PkgK1PZ7JjoFl4EHzRsXIG0bERGu7+ekO2j9piEmDsVi+KhWyULDu+plYx2+lPt1jd7C2HAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeF1X87uoJvQbzbAPKMo85LsUvA16l7T794HfCJ7nRg=;
 b=S1A33AcV474osdsSQrFERAurasIj71h92a3N34mZZas1CDzMQlnmnDvarDG2/HqubDWfpOHvnCs/xiwX0sohZNrrVCeLF5O+Lup16DHo2lEnsKRMRCKZpRlOV8F/KaCHX+rmz8SL+cS8aHEOOYsXdrpHL8iKBu9Zn+J5BHNW4QQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5276.eurprd08.prod.outlook.com (20.179.15.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 14:03:33 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 14:03:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Peter Krempa <pkrempa@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Thread-Topic: bitmap migration bug with -drive while block mirror runs
Thread-Index: AQHVd+yDiWNDoVbdB0u/++2NVEJq8qdF0TUAgAAC+ICAAB3ngIAAAtYAgAE4ZQCAAAc0gIAAKluAgAAFoIA=
Date: Wed, 2 Oct 2019 14:03:33 +0000
Message-ID: <e6fabe60-47a3-76df-d128-d68f34b5c61d@virtuozzo.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <4bc910ef-0bec-cfd6-89f6-a93d35367218@redhat.com>
 <9431d242-bfe1-b9db-17d0-6c1a280a05da@virtuozzo.com>
 <e112c85a-684f-5721-2da7-d23312c9e487@redhat.com>
 <20191002104600.GC6129@angien.pipo.sk>
 <20191002111147.GB5819@localhost.localdomain>
 <20191002134323.GE6129@angien.pipo.sk>
In-Reply-To: <20191002134323.GE6129@angien.pipo.sk>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0041.eurprd09.prod.outlook.com
 (2603:10a6:7:15::30) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191002170331128
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7dad4de-68a9-4d42-75fe-08d747414fc3
x-ms-traffictypediagnostic: DB8PR08MB5276:
x-microsoft-antispam-prvs: <DB8PR08MB52769C6FC1D2B16291E74FF0C19C0@DB8PR08MB5276.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(39850400004)(366004)(396003)(376002)(189003)(199004)(51444003)(5660300002)(186003)(66556008)(256004)(6246003)(52116002)(31696002)(86362001)(66066001)(386003)(71200400001)(6506007)(71190400001)(478600001)(11346002)(2616005)(102836004)(476003)(31686004)(446003)(486006)(64756008)(66446008)(53546011)(66476007)(26005)(66946007)(54906003)(305945005)(2906002)(110136005)(25786009)(316002)(14454004)(76176011)(6512007)(7736002)(3846002)(6116002)(6486002)(4326008)(36756003)(8676002)(6436002)(8936002)(81166006)(81156014)(229853002)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5276;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: re6Wi1L/5ue47rgBhS8JnYwNBQGBy/XeqpQdKl6jdd/Cw6bSQwe0JLiax6QgxxXmNVZyegyPDyIcFNgiOecbabWZ55e7Q90H2lYwL2ttKgGhiqqyuvPPoUzzIz6PJ0mA0bAT9ARN7QNDoT3sKEgm6y6Sd4bfDD7P2l1t68fbx4zzC/PsLXGvmwscB9ULQqBgtZqB9/idqFrAV6whnJi1qrEevB7j/4ILnR83W7I7cEQEv70G0OCRzbKHI4tXssJCqa146nu7zOW9W1I4YJi8mzKb7fnYec/PazVENWkPiultkky5k5sb5vaS5k8r5G1Zi4IMMgcFPToWxI4QSzaHuVBfNPjmoA0w9d057os4HLCMJhMxqHMMhZ0jf685F1+kMpe0MBl4jC6gGoBk2nVRnfAvG8PK8bxMfmyeqkY2xwA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <48196A4DF2919C42BAB421A035380E6F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dad4de-68a9-4d42-75fe-08d747414fc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 14:03:33.4912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0N79jktqW6ewobx52AradipmLc2Zf8X4X3nsAfP5EuB5NkfF2WYoL0PGdmkOgrAxyXP5DhsY57dJDdnQEEdvorFH48hbsoaLmTgfa35W7jM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5276
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.102
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMTAuMjAxOSAxNjo0MywgUGV0ZXIgS3JlbXBhIHdyb3RlOg0KPiBPbiBXZWQsIE9jdCAwMiwg
MjAxOSBhdCAxMzoxMTo0NyArMDIwMCwgS2V2aW4gV29sZiB3cm90ZToNCj4+IEFtIDAyLjEwLjIw
MTkgdW0gMTI6NDYgaGF0IFBldGVyIEtyZW1wYSBnZXNjaHJpZWJlbjoNCj4gDQo+IFsuLi5dDQo+
IA0KPj4+IEknZCBsaWtlIHRvIHJlLWl0ZXJhdGUgdGhhdCB0aGUgbmVjZXNzaXR5IHRvIGtlZXAg
bm9kZSBuYW1lcyBzYW1lIG9uDQo+Pj4gYm90aCBzaWRlcyBvZiBtaWdyYXRpb24gaXMgdW5leHBl
Y3RlZCwgdW5kb2N1bWVudGVkIGFuZCBpbiBzb21lIGNhc2VzDQo+Pj4gaW1wb3NzaWJsZS4NCj4+
DQo+PiBJIHRoaW5rIHRoZSAoaW1wbGljaXRseSBtYWRlKSByZXF1aXJlbWVudCBpcyBub3QgdGhh
dCBhbGwgbm9kZS1uYW1lcyBhcmUNCj4+IGtlcHQgdGhlIHNhbWUsIGJ1dCBvbmx5IHRoZSBub2Rl
LW5hbWVzIG9mIHRob3NlIG5vZGVzIGZvciB3aGljaA0KPj4gbWlncmF0aW9uIHRyYW5zZmVycyBz
b21lIHN0YXRlLg0KPiANCj4gWzFdIFRoaXMgYWxzbyBpbXBsaWVzIHRoYXQgbm9kZSBuYW1lcyBv
ZiB0aGUgbm9kZXMgd2hlcmUgbWlncmF0aW9uIHNob3VsZA0KPiBub3QgdHJhbnNmZXIgc3RhdGUg
bXVzdCBiZSB1bmlxdWUgb24gdGhlIGJvdGggc2lkZXMgc2luY2UgeW91IGNhbid0DQo+IGNvbnRy
b2wgaXQgb3RoZXJ3aXNlLg0KPiANCj4+IEl0IHNlZW1zIHRvIG1lIHRoYXQgYml0bWFwIG1pZ3Jh
dGlvbiBpcyB0aGUgZmlyc3QgY2FzZSBvZiBwdXR0aW5nDQo+PiBzb21ldGhpbmcgaW4gdGhlIG1p
Z3JhdGlvbiBzdHJlYW0gdGhhdCBpc24ndCByZWxhdGVkIHRvIGEgZnJvbnRlbmQsIGJ1dA0KPj4g
dG8gdGhlIGJhY2tlbmQsIHNvIHRoZSB1c3VhbCBkZXZpY2UgaGllcmFyY2h5IHRvIGFkZHJlc3Mg
aW5mb3JtYXRpb24NCj4+IGRvZXNuJ3Qgd29yayBoZXJlLiBBbmQgaXQgc2VlbXMgdGhlIGltcGxp
Y2F0aW9ucyBvZiB0aGlzIHdlcmVuJ3QgcmVhbGx5DQo+PiBjb25zaWRlcmVkIHN1ZmZpY2llbnRs
eSwgcmVzdWx0aW5nIGluIHRoZSBkZXNpZ24gcHJvYmxlbSB3ZSdyZQ0KPj4gZGlzY3Vzc2luZyBu
b3cuDQo+IA0KPiBUaGlzIHNob3VsZCB0aGVuIGFsc28gYmUgYSBtb21lbnQgdG8gY2FyZWZ1bGx5
IHRoaW5rIGFib3V0IHRoZQ0KPiBzZW1hbnRpY3Mgb2YgbWlncmF0aW5nIGRhdGEgZm9yIGJhY2tl
bmRzIHdoaWNoIGRvbid0IG5lZWQgdG8gYmUNCj4gaWRlbnRpY2FsIG9uIGJvdGggc2lkZXMgb2Yg
dGhlIG1pZ3JhdGlvbiBmb3IgdGhlIFZNIHRvIHdvcmsgY29ycmVjdGx5Lg0KPiANCj4gSSB0aGlu
ayB0aGF0IGFueSBmZWF0dXJlIHdoaWNoIHRvdWNoZXMgYmFja2VuZHMgc2hvdWxkIGlkZWFsbHkg
YmUgYW4NCj4gb3B0LWluLiBUaGlzIHdvdWxkIGNhbGwgZm9yIGEgZXhwbGljaXQgYWN0aW9uIHRv
IHVzZSBpdCB3aGljaCB3b3VsZCBhbHNvDQo+IGFsbG93IG1hbmFnZW1lbnQgYXBwcyB0byBjb25z
aWRlciBleHBlY3RhdGlvbnMgYW5kIGltcGxpY2F0aW9ucyBvZg0KPiBlbmFibGluZyBpdCByYXRo
ZXIgdGhhbiBkb2luZyBpdCBhdXRvbWF0aWNhbGx5LiBPbmUgcG9zc2liaWxpdHkgd291bGQgYmUN
Cj4gYWxzbyB0byBtYWtlIGl0IGludHJvc3BlY3RhYmxlIGluIHN1Y2ggYSB3YXkgdGhhdCBpdCBj
YW4gYmUgbWFkZSBvcHQtaW4NCj4gYnkgZGlzYWJsaW5nIGFsbCB1bmtub3duIGZlYXR1cmVzIHBy
b2dyYW1hdGljYWxseSBpbiB0aGUgbWdtdCBhcHAuDQoNCkN1cnJlbnRseSBiaXRtYXBzIGFyZSBt
aWdyYXRlZCBvbmx5IGlmIGJpdG1hcHMgbWlncmF0aW9uIGNhcGFiaWxpdHkgaXMgZW5hYmxlZCwN
CnNvIGl0J3Mgbm90IHNvIGJhZC4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

