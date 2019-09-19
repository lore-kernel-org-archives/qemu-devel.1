Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52481C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194ED21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UDm2rWGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194ED21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsbG-0005BM-7l
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAsWW-0000kC-UM
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAsWV-0005dr-Ky
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:14:48 -0400
Received: from mail-eopbgr130092.outbound.protection.outlook.com
 ([40.107.13.92]:19170 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAsWI-0005Vp-P8; Thu, 19 Sep 2019 05:14:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deAogDA7UlNL4v7Xcx7FG1twPzKJkaM2mzCXuyufSRGwW9joP+1kFVYurNEaBJK6lX7V9hbPUJS7AziSTbIuR+gL7y+7vvL/vEVndV3IbUb0WhqoCXSPBKa9gg1UUxr3PDvEoJ/aHqg5So5vOx2dMcfqshP+fnPLwkqFCODtp613NeOa+HujmIRoroHR9LEFI9arGo30n6ulc/eNdspq9j5nUPWMMDCUrXJx9o/KxZ9YtkF9uAm+vSJnzuPqhiiNCJwRFV1Vc4/i3v5NL87MiSbNfBanQImkSooSRZ89MzLI9QxmQzhndWzmQdmWoEQJeYT1bm+na+BlTXhVMZNqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L3W77fYgN/CLyQGYSLiqLEWDYwLBGmOTBb0OR2KXCU=;
 b=J7Repnyf1F0PZ7B9PbKhSH3QZZ4LaNcO3FC17QovvsJ2aE+C+FZekah6Z+juvYfG21JWsFxV2TUBEI8ijonm6z36r5on27aDzJaqLDjJiB3HW+UjAht2XWbU0Y7hC+xOWO2lzHb5Ge8jv6ERXapCenbEyl+hW6AJ30BuTxyfp07b8wn7s8r9dF6M/wLuIWoXc/6PhKs37NNuS4Wf5qrVKslz4NX3jx6R7/r34zviiatTjQ1lK32h4x0bka2eUMFB5xyO82lBuYL+XXeUxle0twrOZNG+GqmPM6wDK5fjceWX2WZA3MHpAw80m836FTeW0fSOXGxcyAgH8xbhHGSrYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L3W77fYgN/CLyQGYSLiqLEWDYwLBGmOTBb0OR2KXCU=;
 b=UDm2rWGGXgvmG8p8zkiPMeOr4Tynm8g5/9frm9C+yPBa8ON1hYN7vTN4Xgir9uX9X2KbiJxpEAIeB4DCxpstKolyzXMeofQ/hYe7AP0EnehP2hvEaithnTY2XIygcUYKTAww7xwcfSJMemCciGtNpznIi3vf1dETNudGjtUuTsE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4954.eurprd08.prod.outlook.com (20.179.15.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 19 Sep 2019 09:14:32 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 09:14:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKcytM4AgAAENQA=
Date: Thu, 19 Sep 2019 09:14:32 +0000
Message-ID: <e0ba76d9-19cd-2894-b5d8-a19932e2d69d@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <d2a793c1-aae7-6e22-8baa-0c403c111e5c@redhat.com>
In-Reply-To: <d2a793c1-aae7-6e22-8baa-0c403c111e5c@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0147.eurprd05.prod.outlook.com
 (2603:10a6:7:28::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919121428026
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 630cc5e6-f2ea-4271-482d-08d73ce1c82c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4954; 
x-ms-traffictypediagnostic: DB8PR08MB4954:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB4954AC8FC175BBA93DA6B586C1890@DB8PR08MB4954.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(376002)(136003)(39850400004)(346002)(53754006)(189003)(199004)(386003)(53546011)(4326008)(25786009)(316002)(14454004)(6512007)(8676002)(3846002)(26005)(6306002)(6116002)(81156014)(2501003)(966005)(86362001)(81166006)(6506007)(52116002)(486006)(2906002)(31686004)(186003)(76176011)(8936002)(99286004)(66066001)(478600001)(31696002)(476003)(229853002)(66946007)(71200400001)(6436002)(5660300002)(54906003)(71190400001)(64756008)(110136005)(6486002)(6246003)(36756003)(7406005)(7736002)(102836004)(256004)(305945005)(66446008)(2616005)(11346002)(66556008)(66476007)(446003)(561944003)(7416002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4954;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xRbjB3R+MthwMOigxOmZGt91hFuxEVUZdBkrNSejqeDv4o/yUDLsaGVq5pKVfiLSFNAo+gcEBNLDac+UUKumr6ipKlgDGQOhEU1s5U524ZvxHwfh+vIt9Ff3MuRqxV7h6Y+firUaBwzqEpaxdcA3lknKel8Vuh5O81oonQuwdC2fIX/qvU2D06oF5UNQ22DHnfu8ctObwQFizuTNOyeCIli6Svfa6WK/EHzoR2DXWks8Xhhj9DGUpztSiMsXdyE4vnDT0Z7gAcLWzqxlWwMV7YQK2NBSGNEvtaRIKRnSgDxl94uXyp2uQ8MXxTpM1EJAL1KLvLHDi/tnVbYikO7dmB37mCUfaWb91qE31xSm9xiC8odUrFIquLFsfIul2aren9w1euOvdTTCyfJv7Qz0nTpNJyzE8yXb8QcfSDylhpQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <43F645C78F41164FA9F591BCD13DA9C7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630cc5e6-f2ea-4271-482d-08d73ce1c82c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 09:14:32.2409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6vRV+Mea7/ul9LXGNuKdRfV2YwXXTyhqZnNhRSZh25WjXMZbFYZaIloUPccn8o4m2DgaxhRZg13Q7KzTo6+8y3x8uCrYcForhfK8oNTCyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4954
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.92
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
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

MTkuMDkuMjAxOSAxMTo1OSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxOC4wOS4xOSAxNTowMiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhpIGFsbCENCj4+DQo+PiBI
ZXJlIGlzIGEgcHJvcG9zYWwgKHRocmVlIG9mIHRoZW0sIGFjdHVhbGx5KSBvZiBhdXRvIHByb3Bh
Z2F0aW9uIGZvcg0KPj4gbG9jYWxfZXJyLCB0byBub3QgY2FsbCBlcnJvcl9wcm9wYWdhdGUgb24g
ZXZlcnkgZXhpdCBwb2ludCwgd2hlbiB3ZQ0KPj4gZGVhbCB3aXRoIGxvY2FsX2Vyci4NCj4+DQo+
PiBJdCBhbHNvIG1heSBoZWxwIG1ha2UgR3JlZydzIHNlcmllc1sxXSBhYm91dCBlcnJvcl9hcHBl
bmRfaGludCBzbWFsbGVyLg0KPj4NCj4+IFNlZSBkZWZpbml0aW9ucyBhbmQgZXhhbXBsZXMgYmVs
b3cuDQo+Pg0KPj4gSSdtIGNjLWluZyB0byB0aGlzIFJGQyBldmVyeW9uZSBmcm9tIHNlcmllc1sx
XSBDQyBsaXN0LCBhcyBpZiB3ZSBsaWtlDQo+PiBpdCwgdGhlIGlkZWEgd2lsbCB0b3VjaCBzYW1l
IGNvZGUgKGFuZCBtYXkgYmUgbW9yZSkuDQo+Pg0KPj4gWzFdOiBodHRwczovL2xpc3RzLmdudS5v
cmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOS0wOS9tc2cwMzQ0OS5odG1sDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2
aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvcWFwaS9lcnJvci5oIHwgMTAyICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgYmxvY2suYyAg
ICAgICAgICAgICAgfCAgNjMgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4+ICAgYmxvY2sv
YmFja3VwLmMgICAgICAgfCAgIDggKysrLQ0KPj4gICBibG9jay9nbHVzdGVyLmMgICAgICB8ICAg
NyArKysNCj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxNDQgaW5zZXJ0aW9ucygrKSwgMzYgZGVsZXRp
b25zKC0pDQo+IA0KPiBJZiB0aGUgY29tYmluYXRpb24gb2Yg4oCcaWYgKGxvY2FsX2VycikgeyBl
cnJvcl9wcm9wYWdhdGUoLi4uKTsgLi4uIH3igJ0gaXMNCj4gd2hhdOKAmXMgY3VtYmVyc29tZSwg
Y2Fu4oCZdCB0aGlzIGJlIGRvbmUgc2ltcGxlciBieSBhZGRpbmcgYW4NCj4gZXJyb3JfcHJvcGFn
YXRlKCkgdmFyaWFudCB3aXRoIGEgcmV0dXJuIHZhbHVlPw0KPiANCj4gaS5lLg0KPiANCj4gYm9v
bCBoYXNfZXJyb3JfdGhlbl9wcm9wYWdhdGUoRXJyb3IgKiplcnJwLCBFcnJvciAqZXJyKQ0KPiB7
DQo+ICAgICAgaWYgKCFlcnIpIHsNCj4gICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgIH0N
Cj4gICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgZXJyKTsNCj4gICAgICByZXR1cm4gdHJ1ZTsN
Cj4gfQ0KPiANCj4gQW5kIHRoZW4gdHVybiBhbGwgaW5zdGFuY2VzIG9mDQo+IA0KPiBpZiAobG9j
YWxfZXJyKSB7DQo+ICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7DQo+ICAg
ICAgLi4uDQo+IH0NCj4gDQo+IGludG8NCj4gDQo+IGlmIChoYXNfZXJyb3JfdGhlbl9wcm9wYWdh
dGUoZXJycCwgbG9jYWxfZXJyKSkgew0KPiAgICAgIC4uLg0KPiB9DQo+IA0KPiA/DQo+IA0KPiBN
YXgNCj4gDQoNCk5vLCBvcmlnaW5hbGx5IGN1bWJlcnNvbWUgaXMgaW50cm9kdWNpbmcgbG9jYWxf
ZXJyIGluIGEgbG90IG9mIG5ldyBwbGFjZXMgYnkNCkdyZWcncyBzZXJpZXMuIE1BS0VfRVJSUF9T
QUZFIG1hY3JvIG1ha2VzIGl0IGFzIHNpbXBsZSBhcyBvbmUgbWFjcm8gY2FsbA0KaW5zdGVhZCAo
aW4gZWFjaCBmdW5jdGlvbiB3aGVyZSB3ZSBuZWVkIGxvY2FsX2VycikuDQoNCkFsc28sIGF1dG8t
cHJvcGFnYXRpb24gc2VlbXMgY29ycmVjdCB0aGluZyB0byBkbywgd2hpY2ggZml0cyBnb29kIGlu
dG8NCmdfYXV0byBjb25jZXB0LCBzbyBldmVuIHdpdGhvdXQgYW55IG1hY3JvIGl0IGp1c3QgYWxs
b3dzIHRvIGRyb3Agc2V2ZXJhbCBlcnJvcl9wcm9wYWdhdGUNCmNhbGxzIChvciBtYXkgYmUgc2V2
ZXJhbCBnb3RvIHN0YXRlbWVudHMgdG8gZG8gb25lIGVycm9yX3Byb3BhZ2F0ZSBjYWxsKSBpbnRv
DQpvbmUgZGVmaW5pdGlvbnMuIEl0J3MgdGhlIHNhbWUgc3RvcnkgbGlrZSB3aXRoIGdfYXV0b2Zy
ZWUgdnMgZ19mcmVlLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

