Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA09C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345FF21D6C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UYUObnH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345FF21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwsZ-00014j-9v
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAwYd-0002R2-Lq
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAwYc-0005DQ-CP
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:33:15 -0400
Received: from mail-eopbgr140123.outbound.protection.outlook.com
 ([40.107.14.123]:16165 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAwJl-0002BR-2f; Thu, 19 Sep 2019 09:17:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd01i0Zc60Lw3VaISl6QV6sEzva3mzgazsK66gzsuH+rSIpTijQO51mqPycX+/5pc4kJEQymqeFGBQ2j0b5plUYZQ3Nh9CcjbameeM43gTtDobwjsuGD3jvab93EuVgg4HqU3NgOceEqHZ3UDMlvUFGkDSPGO1FewuAKZtp+zsNRlBLD7wQrX7iW4nOC8xg2dh+6z6TsmGM7DUiQNTtFsV2Rsh/59CbGqGnMOmF+2TT+EgienU8+8oEVz6sbE4SZeAwHG1UO0p4XrtoaqaTJsAr6GKwRVuB5H/UCHTtQXtXQMCRyUlDZR5B716pkcwJsqzwWHkmLHiIQJjwxTZ2QKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1aJHygsogBjRmxrHRbufidqQF7Zca40SzdrHPI5Wms=;
 b=E4lS+d9pTf2qLXi9u2wFWj9vzW2bNWdrWdUNqixvnuBhqjnrwAmuMW7eh9oXzWiCR40Nw5e4WRQby6cSeUIOQEzH4CvTVjEVJx17jd3ys4kQzhQ9yK9+yBKHAduDGUMA4/VH+O3KKMmDW2rboo1+GWeFdeQ2xtIll/sywOfUljHrPBaLSiCLBu+A9U+0k+gmGxBtVEVSuwuh0EoxE043kVnjuE310yb6FTih2+CYmwObQDmZBkoX+L6fJXfrXkFSSjTyDnFlcWmoHF2dq63Fxm7OZlwc0T5W/XfIei1LKnls90xzY6owwngOpKgO9SE2hlc7gSSHazRHh1qW+Zn0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1aJHygsogBjRmxrHRbufidqQF7Zca40SzdrHPI5Wms=;
 b=UYUObnH+8cdXatbHGA3iT561jdyHPg/el+XlEpqt9sA/TFMZJiKZwFkLX6r1i9vYMpleUpLkZI+9IQxtY2S1PLVMiMuF4JyoIsoSIBw9bsTZofdMRGTrgq4qIE4X/68EFitL9hfMZ+UrOlITDsAwEuv/BS8fN3jxqT/ut+auuP0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5371.eurprd08.prod.outlook.com (52.133.240.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 13:17:50 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 13:17:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKcxq6KAgAEOLgCAAC2AgIAAEaKAgAAEA4A=
Date: Thu, 19 Sep 2019 13:17:50 +0000
Message-ID: <42d0862c-b6f5-c214-1ab1-b6fd906df5fb@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
 <20190919091720.GB10163@localhost.localdomain>
 <1ee95d94-d3f9-2f56-a0bb-61d31e3ceeb7@virtuozzo.com>
 <20190919130317.GG10163@localhost.localdomain>
In-Reply-To: <20190919130317.GG10163@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0349.eurprd05.prod.outlook.com
 (2603:10a6:7:92::44) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919161739934
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c03f3fb-de85-4dbb-129b-08d73d03c55e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5371; 
x-ms-traffictypediagnostic: DB8PR08MB5371:
x-microsoft-antispam-prvs: <DB8PR08MB53719D6DE9DA1A1CDAF4BB43C1890@DB8PR08MB5371.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(136003)(376002)(39850400004)(346002)(199004)(189003)(305945005)(7736002)(25786009)(6916009)(6512007)(64756008)(2906002)(102836004)(7416002)(66946007)(53546011)(7406005)(76176011)(66476007)(66446008)(6506007)(386003)(66556008)(256004)(99286004)(14444005)(52116002)(11346002)(2616005)(31696002)(446003)(14454004)(6246003)(486006)(476003)(478600001)(86362001)(5660300002)(186003)(26005)(3846002)(6116002)(66066001)(6436002)(71190400001)(8936002)(6486002)(8676002)(36756003)(71200400001)(54906003)(81156014)(81166006)(229853002)(4326008)(31686004)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5371;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j+3jh4Tr+Gdn4Q+2vK129JBkO8wi9TKxT4E4Ge1AzQ/sNBjSN/t02c2I791UZ3sw4V8lJiP/iDsA3Pp4mR219pVQJ7k42c96/gUOWYnalgJDUgjoJkLHRbdhhVlomSYed/FUPgYxj/mVIdlcSUOKAU89vSBqkQUOMsY5P8vZdDLfuQKyhCyiTv+p3C9LojpiacMaTeExrBNmK7kIKbxGGvnywvHz39jnKve5Jg0Hqfh2QBVfd5McU0TwGrdFjGxqSnx274hjAbh74/Zn/bObaoA6hpH45s2RLiJCTRA6senS4im4lfNIvpqXvPR1W6dR2EBA9q0FWWglt0ZM7waFuofIWQXhXI8LgiA88iWRQliSw3nvR68j9tYaw6qP/oXXyhCA3P0px/A7gj5FlOaL90eM3Gc7S64phwbFmZT6LT0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <07B847D05043F74EB709E69245CF961A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c03f3fb-de85-4dbb-129b-08d73d03c55e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 13:17:50.3629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ne5Nsq0Ir4yHw+8PW39m7oyYSZZzTeRd6bHY0b5laAX7ReO/ZdQREGdtSB3dioBCsMnELqRESnBc5a3WUOf3OdgsS0nKGx6QmZPJhYGF+CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5371
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.123
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
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
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDkuMjAxOSAxNjowMywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTkuMDkuMjAxOSB1bSAx
NDowMCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDE5
LjA5LjIwMTkgMTI6MTcsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMTguMDkuMjAxOSB1bSAx
OToxMCBoYXQgRXJpYyBCbGFrZSBnZXNjaHJpZWJlbjoNCj4+Pj4gT24gOS8xOC8xOSA4OjAyIEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+Pj4gKyAqLw0KPj4+Pj4g
KyNkZWZpbmUgTUFLRV9FUlJQX1NBRkUoZXJycCkgXA0KPj4+Pj4gK2dfYXV0byhFcnJvclByb3Bh
Z2F0aW9uU3RydWN0KSAoX19hdXRvX2VycnBfcHJvcCkgPSB7LmVycnAgPSAoZXJycCl9OyBcDQo+
Pj4+PiAraWYgKChlcnJwKSA9PSBOVUxMIHx8ICooZXJycCkgPT0gZXJyb3JfYWJvcnQgfHwgKihl
cnJwKSA9PSBlcnJvcl9mYXRhbCkgeyBcDQo+Pj4+PiArICAgIChlcnJwKSA9ICZfX2F1dG9fZXJy
cF9wcm9wLmxvY2FsX2VycjsgXA0KPj4+Pj4gK30NCj4+Pj4NCj4+Pj4gTm90IHdyaXR0ZW4gdG8g
dGFrZSBhIHRyYWlsaW5nIHNlbWljb2xvbiBpbiB0aGUgY2FsbGVyLg0KPj4+Pg0KPj4+PiBZb3Ug
Y291bGQgZXZlbiBzZXQgX19hdXRvX2VycnBfcHJvcCB1bmNvbmRpdGlvbmFsbHkgcmF0aGVyIHRo
YW4gdHJ5aW5nDQo+Pj4+IHRvIHJldXNlIGluY29taW5nIGVycnAgKHRoZSBkaWZmZXJlbmNlIGJl
aW5nIHRoYXQgZXJyb3JfcHJvcGFnYXRlKCkgZ2V0cw0KPj4+PiBjYWxsZWQgbW9yZSBmcmVxdWVu
dGx5KS4NCj4+Pg0KPj4+IEkgdGhpbmsgdGhpcyBkaWZmZXJlbmNlIGlzIGFjdHVhbGx5IGEgcHJv
YmxlbS4NCj4+Pg0KPj4+IFdoZW4gZGVidWdnaW5nIHRoaW5ncywgSSBoYXRlIGVycm9yX3Byb3Bh
Z2F0ZSgpLiBJdCBtZWFucyB0aGF0IHRoZSBFcnJvcg0KPj4+IChzcGVjaWZpY2FsbHkgaXRzIGZp
ZWxkcyBzcmMvZnVuYy9saW5lKSBwb2ludHMgdG8gdGhlIG91dGVybW9zdA0KPj4+IGVycm9yX3By
b3BhZ2F0ZSgpIHJhdGhlciB0aGFuIHRoZSBwbGFjZSB3aGVyZSB0aGUgZXJyb3IgcmVhbGx5IGhh
cHBlbmVkLg0KPj4+IEl0IGFsc28gbWFrZXMgZXJyb3JfYWJvcnQgY29tcGxldGVseSB1c2VsZXNz
IGJlY2F1c2UgYXQgdGhlIHBvaW50IHdoZXJlDQo+Pj4gdGhlIHByb2Nlc3MgZ2V0cyBhYm9ydGVk
LCB0aGUgaW50ZXJlc3RpbmcgaW5mb3JtYXRpb24gaXMgYWxyZWFkeSBsb3N0Lg0KPj4+DQo+Pj4g
U28gSSdkIHJlYWxseSBsaWtlIHRvIHJlc3RyaWN0IHRoZSB1c2Ugb2YgZXJyb3JfcHJvcGFnYXRl
KCkgdG8gcGxhY2VzDQo+Pj4gd2hlcmUgaXQncyBhYnNvbHV0ZWx5IG5lY2Vzc2FyeS4gVW5sZXNz
LCBvZiBjb3Vyc2UsIHlvdSBjYW4gZml4IHRoZXNlDQo+Pj4gcHJhY3RpY2FsIHByb2JsZW1zIHRo
YXQgZXJyb3JfcHJvcGFnYXRlKCkgY2F1c2VzIGZvciBkZWJ1Z2dpbmcuDQo+Pj4NCj4+PiBJbiBm
YWN0LCBpbiB0aGUgY29udGV4dCBvZiBHcmVnJ3Mgc2VyaWVzLCBJIHRoaW5rIHdlIHJlYWxseSBv
bmx5IG5lZWQgdG8NCj4+PiBzdXBwb3J0IGhpbnRzIGZvciBlcnJvcl9mYXRhbCwgd2hpY2ggYXJl
IGNhc2VzIHRoYXQgdXNlcnMgYXJlIHN1cHBvc2VkDQo+Pj4gdG8gc2VlLiBXZSBzaG91bGQgZXhj
bHVkZSBlcnJvcl9hYm9ydCBpbiBNQUtFX0VSUlBfU0FGRSgpIGJlY2F1c2UgdGhlc2UNCj4+PiBh
cmUgdGhpbmdzIHRoYXQgYXJlIG5ldmVyIHN1cHBvc2VkIHRvIGhhcHBlbi4gQSBnb29kIHN0YWNr
IHRyYWNlIGlzIG1vcmUNCj4+PiBpbXBvcnRhbnQgdGhlcmUgdGhhbiBhZGRpbmcgYSBoaW50IHRv
IHRoZSBtZXNzYWdlLg0KPj4+DQo+Pg0KPj4gSW50ZXJlc3RpbmcsIHRoYXQgdG8gaGFuZGxlIGVy
cm9yX2FwcGVuZF9oaW50IHByb2JsZW0sIHdlIGRvbid0IG5lZWQgdG8NCj4+IGNyZWF0ZSBsb2Nh
bF9lcnIgaW4gY2FzZSBvZiBlcnJwPT1OVUxMIGVpdGhlci4uDQo+Pg0KPj4gU28sIHBvc3NpYmx5
LCB3ZSBuZWVkIHRoZSBmb2xsb3dpbmcgc3RlcHM6DQo+Pg0KPj4gMS4gaW1wbGVtZW50IE1BS0Vf
RVJSUF9TQUZFX0ZPUl9ISU5UICh3aGljaCBvbmx5IGxlYXZlICIqKGVycnApID09IGVycm9yX2Zh
dGFsIiBpbiB0aGUgaWYgY29uZGl0aW9uDQo+PiAyLiByZWJhc2UgR3JlZydzIHNlcmllcyBvbiBp
dCwgdG8gZml4IGhpbnRzIGZvciBmYXRhbCBlcnJvcnMNCj4+IDMuIGltcGxlbWVudCBNQUtFX0VS
UlBfU0FGRV9GT1JfREVSRUZFUkVOQ0UgKHdoaWNoIG9ubHkgbGVhdmUgIihlcnJwKSA9PSBOVUxM
IiBpbiB0aGUgaWYgY29uZGl0aW9uDQo+PiA0LiBjb252ZXJ0IGFsbCAoYWxtb3N0IGFsbCkgbG9j
YWxfZXJyIHVzYWdlIHRvIHVzZSBNQUtFX0VSUlBfU0FGRV9GT1JfREVSRUZFUkVOQ0UsIHdoaWNo
IHdpbGwNCj4+ICAgICAgZml4IHByb2JsZW0gd2l0aCBlcnJvcl9hYm9ydCAoYW5kIGFsc28gZHJv
cCBhIGxvdCBvZiBjYWxscyBvZiBlcnJvcl9wcm9wYWdhdGUpDQo+PiA1LiBtZXJlbHkgY29udmVy
dCAidm9pZCBmdW5jKC4uLCBlcnJwKSIgdG8gImludCBmdW5jKC4uLCBlcnJwKSIgYW5kIGRyb3Ag
TUFLRV9FUlJQX1NBRkVfRk9SX0RFUkVGRVJFTkNFKCkNCj4+ICAgICAgbWFnaWMsIHRvZ2V0aGVy
IHdpdGggZGVyZWZlcmVuY2luZy4NCj4gDQo+IExvbmcgbWFjcm8gbmFtZXMsIGJ1dCBhcyB0aGUg
cGFyYW1ldGVyIHdpbGwgYWx3YXlzIG9ubHkgYmUgImVycnAiLCBpdA0KPiBmaXRzIGVhc2lseSBv
biBhIGxpbmUsIHNvIHRoaXMgaXMgZmluZS4NCg0KWWVzLCBJIHdhbnRlZCB0byBzdHJlc3MgdGhl
aXIgbWVhbmluZyBpbiBwbGFuLi4NCg0KT3RoZXIgdmFyaWFudHMsIEkgY2FuIGltYWdpbmU6DQoN
Ck1BS0VfRVJSUF9TQUZFX0ZPUl9ERVJFRkVSRU5DRQ0KV1JBUF9FUlJQX0ZPUl9ERVJFRkVSRU5D
RQ0KV1JBUF9OVUxMX0VSUlANCg0KTUFLRV9FUlJQX1NBRkVfRk9SX0hJTlQNCldSQVBfRVJSUF9G
T1JfSElOVA0KV1JBUF9GQVRBTF9FUlJQDQoNCg0KPiANCj4gSSB0aGluayBJIGxpa2UgdGhpcyBw
bGFuLg0KPiANCj4gS2V2aW4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

