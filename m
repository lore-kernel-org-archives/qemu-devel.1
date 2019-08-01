Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E348FC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01C0206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="deQ3E92A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01C0206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htFB6-0007sD-Sj
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 13:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50307)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htF77-0005Fb-R8
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htF76-0000LX-BN
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:43:41 -0400
Received: from mail-he1eur01on0717.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::717]:49735
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1htF75-0000K1-F4; Thu, 01 Aug 2019 13:43:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luZ8mXDHXsZTkrn/ZzEfI3/pYmOPagQjqzewXWpoVAMyc/CEpJ6GCTfTJhv4lyosKxKJ44v7vJEwU9+e/CWSMsTkWCXemKwffA0VMLF35D5FaQArjkhfqVMaSAoSYl1EJ15qmEvMvecCwI8NxPoCWHIQdtCxl+1iIfj9l+bmjh8ff/AWE14TneIN3Fhs6MzxiubK4k95RFolHG1Jyw2FyEdlGzvjG/W5TfUiTH3AhZrXoB+B44811BwkzPI1YmkZCjM/4D8Fv3ZZPI+qyRpXNkPr9smUISgNIbJJpGsDKaiLdirjpR5z8hVli9UROd9+f6/n4puJBI0mCBwF2Zvtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RsHMrhFwwrD+vbntY+8YNayw0MpGl6Wstt1qaeXjEQ=;
 b=ZKarX3QXZfOE7SvMjO+DP+hWBFTCEDM8OQZnEDq6NdwZQdr7qxKNXgK2C71VeCyIULrUKQcuOhHc9X0HNxpwtT4CE/MAZt/OCG1q3ZbYI4lRGhT7IC+XPg4mpb29CNZUylTFEF2VVZcWJmwAh10K9wBcW2Owh4S2SQRhyBaX4n6Bone83k3HSifIMujbtpE4vuATB6fB0E/c1uksSNMdix4OOhKRw8wP5c4oGdyLNmQyqIrVkeLJmZZxPz1SA5E65evK1hctbWyKA4iSa76a0t37K+9JKhPoZbMlSxVqVASRlyh6Oz6hkSI/V5SEjHefUXOw37gk8TNz8q/eP1eMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RsHMrhFwwrD+vbntY+8YNayw0MpGl6Wstt1qaeXjEQ=;
 b=deQ3E92AK5vVfamJfHKwbJ9ZcTgVhYn6v+xB7v+5vRFhTmfaurZ86CknRS8s1aGBrXG/0s7v99GEH/gbsYVyxQhgHV5r5lcfcRoyCEEWbRPWSIEtUZSUXa3pQ8xdk8lzBigm0yRUJ3QDo76P/1WmWIaajyghpk3f12EV96pUyE0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5273.eurprd08.prod.outlook.com (10.255.18.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Thu, 1 Aug 2019 17:43:34 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 17:43:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH for-4.1 2/2] iotests: Test backup job with two guest
 writes
Thread-Index: AQHVSHuSmXijrz1GlEejh1OLI2A9XqbmdDaAgAARuACAAAVQgIAAAsSAgAACTAA=
Date: Thu, 1 Aug 2019 17:43:34 +0000
Message-ID: <fe27353b-b65f-186b-d743-700f49cc11fb@virtuozzo.com>
References: <20190801151235.8434-1-mreitz@redhat.com>
 <20190801151235.8434-3-mreitz@redhat.com>
 <68653483-e7d2-154a-75c6-2dfef235d33d@virtuozzo.com>
 <738d7105-f91e-76ad-c2e6-cd5b32b846ef@redhat.com>
 <274d65f2-1b42-8585-3c6f-1ee711c2bb09@virtuozzo.com>
 <02a05f35-cedd-65c1-aafc-01183e5ba91d@redhat.com>
In-Reply-To: <02a05f35-cedd-65c1-aafc-01183e5ba91d@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::15) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190801204332334
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aabf2ef2-c33a-418a-1f4e-08d716a7c6ca
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5273; 
x-ms-traffictypediagnostic: DB8PR08MB5273:
x-microsoft-antispam-prvs: <DB8PR08MB5273B42FDEB676A048D3154CC1DE0@DB8PR08MB5273.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(346002)(136003)(376002)(39850400004)(189003)(199004)(6486002)(26005)(66066001)(6246003)(229853002)(54906003)(110136005)(316002)(6436002)(53936002)(186003)(71190400001)(52116002)(71200400001)(81156014)(31686004)(99286004)(305945005)(7736002)(256004)(8936002)(81166006)(102836004)(5660300002)(8676002)(476003)(3846002)(14444005)(66946007)(6116002)(6512007)(53546011)(2906002)(446003)(4326008)(76176011)(14454004)(2616005)(2501003)(36756003)(478600001)(25786009)(66446008)(386003)(31696002)(66476007)(86362001)(64756008)(68736007)(66556008)(6506007)(11346002)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5273;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 140GKw0JX4z6t2nmeYSBdIRl+0+QDiP6h1itKq7NNvtsWxSwhV4ZeBr86RNKVWE7oMb9/PYEpgWKpwdMEdN6lFZpH0TSLV7rx0faiS6m5a92ESJpd8DGfzv0pUk9t8nMqj4VV5BQNMWCn9DpGURy1J5Ailr6znGmw6Qm/zvhuJJ25bMT133fG0JKk5MdZ5bresRL8wuBXMPmSDmGjrbuLqqOfgFec3XzVRqDVelmYD0rszQh3y359usmYw2uzBsK8onAe1smXK8faoVePKQvM//a9TTd4N20bdvo8dNyJh9LEWHbcGmy3WgJlwqLdN79371wLKdO4unK+DEXQPu+KATPilK1Gi44xgy/xpa7GRzhvWCqmtX3/oZxFdz2W8byAbc9v0Zfmczc1rnJeKE7qk7lu37y+JusbLZHewMUu/w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB60E0F23622084584066C7663683933@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabf2ef2-c33a-418a-1f4e-08d716a7c6ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 17:43:34.8090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5273
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1e::717
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] iotests: Test backup job with
 two guest writes
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDguMjAxOSAyMDozNSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMS4wOC4xOSAxOToyNSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDAxLjA4LjIwMTkgMjA6MDYs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAwMS4wOC4xOSAxODowMywgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMDEuMDguMjAxOSAxODoxMiwgTWF4IFJlaXR6IHdy
b3RlOg0KPj4+Pj4gUGVyZm9ybSB0d28gZ3Vlc3Qgd3JpdGVzIHRvIG5vdCB5ZXQgYmFja2VkIHVw
IGFyZWFzIG9mIGFuIGltYWdlLCB3aGVyZQ0KPj4+Pj4gdGhlIGZvcm1lciB0b3VjaGVzIGFuIGlu
bmVyIGFyZWEgb2YgdGhlIGxhdHRlci4NCj4+Pj4+DQo+Pj4+PiBCZWZvcmUgSEVBRF4sIGNvcHkg
b2ZmbG9hZGluZyBicm9rZSB0aGlzIGluIHR3byB3YXlzOg0KPj4+Pj4gKDEpIFRoZSBvdXRwdXQg
ZGlmZmVycyBmcm9tIHRoZSByZWZlcmVuY2Ugb3V0cHV0ICh3aGF0IHRoZSBzb3VyY2Ugd2FzDQo+
Pj4+PiAgICAgICAgYmVmb3JlIHRoZSBndWVzdCB3cml0ZXMpLg0KPj4+Pj4gKDIpIEJ1dCB5b3Ug
d2lsbCBub3Qgc2VlIHRoYXQgaW4gdGhlIGZhaWxpbmcgb3V0cHV0LCBiZWNhdXNlIHRoZSBqb2IN
Cj4+Pj4+ICAgICAgICBvZmZzZXQgaXMgcmVwb3J0ZWQgYXMgYmVpbmcgZ3JlYXRlciB0aGFuIHRo
ZSBqb2IgbGVuZ3RoLiAgVGhpcyBpcw0KPj4+Pj4gICAgICAgIGJlY2F1c2Ugb25lIGNsdXN0ZXIg
aXMgY29waWVkIHR3aWNlLCBhbmQgdGh1cyBhY2NvdW50ZWQgZm9yIHR3aWNlLA0KPj4+Pj4gICAg
ICAgIGJ1dCBvZiBjb3Vyc2UgdGhlIGpvYiBsZW5ndGggZG9lcyBub3QgaW5jcmVhc2UuDQo+Pj4+
Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4+
Pj4+IC0tLQ0KPj4+Pj4gICAgIHRlc3RzL3FlbXUtaW90ZXN0cy8wNTYgICAgIHwgMzQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+Pj4gICAgIHRlc3RzL3FlbXUtaW90ZXN0
cy8wNTYub3V0IHwgIDQgKystLQ0KPj4+Pj4gICAgIDIgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvdGVzdHMv
cWVtdS1pb3Rlc3RzLzA1NiBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNTYNCj4+Pj4+IGluZGV4IGY0
MGZjMTFhMDkuLmQ3MTk4NTA3ZjUgMTAwNzU1DQo+Pj4+PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVz
dHMvMDU2DQo+Pj4+PiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDU2DQo+Pj4+PiBAQCAtMTMz
LDYgKzEzMyw3IEBAIGNsYXNzIEJhY2t1cFRlc3QoaW90ZXN0cy5RTVBUZXN0Q2FzZSk6DQo+Pj4+
PiAgICAgICAgICAgICBzZWxmLnZtID0gaW90ZXN0cy5WTSgpDQo+Pj4+PiAgICAgICAgICAgICBz
ZWxmLnRlc3RfaW1nID0gaW1nX2NyZWF0ZSgndGVzdCcpDQo+Pj4+PiAgICAgICAgICAgICBzZWxm
LmRlc3RfaW1nID0gaW1nX2NyZWF0ZSgnZGVzdCcpDQo+Pj4+PiArICAgICAgICBzZWxmLnJlZl9p
bWcgPSBpbWdfY3JlYXRlKCdyZWYnKQ0KPj4+Pj4gICAgICAgICAgICAgc2VsZi52bS5hZGRfZHJp
dmUoc2VsZi50ZXN0X2ltZykNCj4+Pj4+ICAgICAgICAgICAgIHNlbGYudm0ubGF1bmNoKCkNCj4+
Pj4+ICAgICANCj4+Pj4+IEBAIC0xNDAsNiArMTQxLDcgQEAgY2xhc3MgQmFja3VwVGVzdChpb3Rl
c3RzLlFNUFRlc3RDYXNlKToNCj4+Pj4+ICAgICAgICAgICAgIHNlbGYudm0uc2h1dGRvd24oKQ0K
Pj4+Pj4gICAgICAgICAgICAgdHJ5X3JlbW92ZShzZWxmLnRlc3RfaW1nKQ0KPj4+Pj4gICAgICAg
ICAgICAgdHJ5X3JlbW92ZShzZWxmLmRlc3RfaW1nKQ0KPj4+Pj4gKyAgICAgICAgdHJ5X3JlbW92
ZShzZWxmLnJlZl9pbWcpDQo+Pj4+PiAgICAgDQo+Pj4+PiAgICAgICAgIGRlZiBobXBfaW9fd3Jp
dGVzKHNlbGYsIGRyaXZlLCBwYXR0ZXJucyk6DQo+Pj4+PiAgICAgICAgICAgICBmb3IgcGF0dGVy
biBpbiBwYXR0ZXJuczoNCj4+Pj4+IEBAIC0xNzcsNiArMTc5LDM4IEBAIGNsYXNzIEJhY2t1cFRl
c3QoaW90ZXN0cy5RTVBUZXN0Q2FzZSk6DQo+Pj4+PiAgICAgICAgICAgICAgICAgc2VsZi5hc3Nl
cnRfcW1wKGV2ZW50LCAnZGF0YS9lcnJvcicsIHFlcnJvcikNCj4+Pj4+ICAgICAgICAgICAgICAg
ICByZXR1cm4gRmFsc2UNCj4+Pj4+ICAgICANCj4+Pj4+ICsgICAgZGVmIHRlc3Rfb3ZlcmxhcHBp
bmdfd3JpdGVzKHNlbGYpOg0KPj4+Pj4gKyAgICAgICAgIyBXcml0ZSBzb21ldGhpbmcgdG8gYmFj
ayB1cA0KPj4+Pj4gKyAgICAgICAgc2VsZi5obXBfaW9fd3JpdGVzKCdkcml2ZTAnLCBbKCc0Mics
ICcwTScsICcyTScpXSkNCj4+Pj4+ICsNCj4+Pj4+ICsgICAgICAgICMgQ3JlYXRlIGEgcmVmZXJl
bmNlIGJhY2t1cA0KPj4+Pj4gKyAgICAgICAgc2VsZi5xbXBfYmFja3VwX2FuZF93YWl0KGRldmlj
ZT0nZHJpdmUwJywgZm9ybWF0PWlvdGVzdHMuaW1nZm10LA0KPj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN5bmM9J2Z1bGwnLCB0YXJnZXQ9c2VsZi5yZWZfaW1nKQ0KPj4+
Pj4gKw0KPj4+Pj4gKyAgICAgICAgIyBOb3cgdG8gdGhlIHRlc3QgYmFja3VwOiBXZSBzaW11bGF0
ZSB0aGUgZm9sbG93aW5nIGd1ZXN0DQo+Pj4+PiArICAgICAgICAjIHdyaXRlczoNCj4+Pj4+ICsg
ICAgICAgICMgKDEpIFsxTSArIDY0aywgMU0gKyAxMjhrKTogQWZ0ZXJ3YXJkcywgZXZlcnl0aGlu
ZyBpbiB0aGF0DQo+Pj4+PiArICAgICAgICAjICAgICBhcmVhIHNob3VsZCBiZSBpbiB0aGUgdGFy
Z2V0IGltYWdlLCBhbmQgd2UgbXVzdCBub3QgY29weQ0KPj4+Pj4gKyAgICAgICAgIyAgICAgaXQg
YWdhaW4gKGJlY2F1c2UgdGhlIHNvdXJjZSBpbWFnZSBoYXMgY2hhbmdlZCBub3cpDQo+Pj4+PiAr
ICAgICAgICAjICAgICAoNjRrIGlzIHRoZSBqb2IncyBjbHVzdGVyIHNpemUpDQo+Pj4+PiArICAg
ICAgICAjICgyKSBbMU0sIDJNKTogVGhlIGJhY2t1cCBqb2IgbXVzdCBub3QgZ2V0IG92ZXJlYWdl
ci4gIEl0DQo+Pj4+PiArICAgICAgICAjICAgICBtdXN0IGNvcHkgWzFNLCAxTSArIDY0aykgYW5k
IFsxTSArIDEyOGssIDJNKSBzZXBhcmF0ZWx5LA0KPj4+Pj4gKyAgICAgICAgIyAgICAgYnV0IG5v
dCB0aGUgYXJlYSBpbiBiZXR3ZWVuLg0KPj4+Pj4gKw0KPj4+Pj4gKyAgICAgICAgc2VsZi5xbXBf
YmFja3VwKGRldmljZT0nZHJpdmUwJywgZm9ybWF0PWlvdGVzdHMuaW1nZm10LCBzeW5jPSdmdWxs
JywNCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICB0YXJnZXQ9c2VsZi5kZXN0X2ltZywg
c3BlZWQ9MSkNCj4+Pj4+ICsNCj4+Pj4+ICsgICAgICAgIHNlbGYuaG1wX2lvX3dyaXRlcygnZHJp
dmUwJywgWygnMjMnLCAnJWlrJyAlICgxMDI0ICsgNjQpLCAnNjRrJyksDQo+Pj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoJzY2JywgJzFNJywgJzFNJyldKQ0KPj4+
Pj4gKw0KPj4+Pj4gKyAgICAgICAgIyBMZXQgdGhlIGpvYiBjb21wbGV0ZQ0KPj4+Pj4gKyAgICAg
ICAgcmVzID0gc2VsZi52bS5xbXAoJ2Jsb2NrLWpvYi1zZXQtc3BlZWQnLCBkZXZpY2U9J2RyaXZl
MCcsIHNwZWVkPTApDQo+Pj4+PiArICAgICAgICBzZWxmLmFzc2VydF9xbXAocmVzLCAncmV0dXJu
Jywge30pDQo+Pj4+PiArICAgICAgICBzZWxmLnFtcF9iYWNrdXBfd2FpdCgnZHJpdmUwJykNCj4+
Pj4+ICsNCj4+Pj4+ICsgICAgICAgIHNlbGYuYXNzZXJ0VHJ1ZShpb3Rlc3RzLmNvbXBhcmVfaW1h
Z2VzKHNlbGYucmVmX2ltZywgc2VsZi5kZXN0X2ltZyksDQo+Pj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgJ3RhcmdldCBpbWFnZSBkb2VzIG5vdCBtYXRjaCByZWZlcmVuY2UgaW1hZ2UnKQ0K
Pj4+Pj4gKw0KPj4+Pj4gICAgICAgICBkZWYgdGVzdF9kaXNtaXNzX2ZhbHNlKHNlbGYpOg0KPj4+
Pj4gICAgICAgICAgICAgcmVzID0gc2VsZi52bS5xbXAoJ3F1ZXJ5LWJsb2NrLWpvYnMnKQ0KPj4+
Pj4gICAgICAgICAgICAgc2VsZi5hc3NlcnRfcW1wKHJlcywgJ3JldHVybicsIFtdKQ0KPj4+Pj4g
ZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNTYub3V0IGIvdGVzdHMvcWVtdS1pb3Rl
c3RzLzA1Ni5vdXQNCj4+Pj4+IGluZGV4IGRhZTQwNGUyNzguLjM2Mzc2YmVkODcgMTAwNjQ0DQo+
Pj4+PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMDU2Lm91dA0KPj4+Pj4gKysrIGIvdGVzdHMv
cWVtdS1pb3Rlc3RzLzA1Ni5vdXQNCj4+Pj4+IEBAIC0xLDUgKzEsNSBAQA0KPj4+Pj4gLS4uLi4u
Li4uLg0KPj4+Pj4gKy4uLi4uLi4uLi4NCj4+Pj4+ICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+PiAt
UmFuIDkgdGVzdHMNCj4+Pj4+ICtSYW4gMTAgdGVzdHMNCj4+Pj4+ICAgICANCj4+Pj4+ICAgICBP
Sw0KPj4+Pj4NCj4+Pj4NCj4+Pj4gRmFpbGVkIGZvciBtZToNCj4+Pj4gLS4uLi4uLi4uLi4NCj4+
Pj4gK3FlbXUtaW1nOiBDb3VsZCBub3Qgb3BlbiAnL3dvcmsvc3JjL3FlbXUvbWFzdGVyL3Rlc3Rz
L3FlbXUtaW90ZXN0cy9zY3JhdGNoL2Rlc3QucWNvdzInOiBGYWlsZWQgdG8gZ2V0IHNoYXJlZCAi
d3JpdGUiIGxvY2sNCj4+Pj4gK0lzIGFub3RoZXIgcHJvY2VzcyB1c2luZyB0aGUgaW1hZ2UgWy93
b3JrL3NyYy9xZW11L21hc3Rlci90ZXN0cy9xZW11LWlvdGVzdHMvc2NyYXRjaC9kZXN0LnFjb3cy
XT8NCj4+Pj4gKy4uLi4uLkYuLi4NCj4+Pj4gKz09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4+Pj4gK0ZBSUw6IHRl
c3Rfb3ZlcmxhcHBpbmdfd3JpdGVzIChfX21haW5fXy5CYWNrdXBUZXN0KQ0KPj4+PiArLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPj4+PiArVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOg0KPj4+PiAr
ICBGaWxlICIwNTYiLCBsaW5lIDIxMiwgaW4gdGVzdF9vdmVybGFwcGluZ193cml0ZXMNCj4+Pj4g
KyAgICAndGFyZ2V0IGltYWdlIGRvZXMgbm90IG1hdGNoIHJlZmVyZW5jZSBpbWFnZScpDQo+Pj4+
ICtBc3NlcnRpb25FcnJvcjogRmFsc2UgaXMgbm90IHRydWUgOiB0YXJnZXQgaW1hZ2UgZG9lcyBu
b3QgbWF0Y2ggcmVmZXJlbmNlIGltYWdlDQo+Pj4+ICsNCj4+Pj4gICAgIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+Pj4gICAgIFJhbiAxMCB0ZXN0cw0KPj4+Pg0KPj4+PiAtT0sNCj4+Pj4gK0ZBSUxFRCAoZmFp
bHVyZXM9MSkNCj4+Pg0KPj4+IEhtLiAgSSBob3BlZCBzZWVpbmcgQkxPQ0tfSk9CX0NPTVBMRVRF
RCB3b3VsZCBiZSBlbm91Z2guDQo+Pg0KPj4gVGhlIHByb2JsZW0gaXMgaGlnaGVyOiAiRmFpbGVk
IHRvIGdldCBzaGFyZWQgIndyaXRlIiBsb2NrIi4gQmVjYXVzZSBvZiB0aGlzIGlvdGVzdHMuY29t
cGFyZV9pbWFnZXMNCj4+IGNhbid0IHdvcmsuIFNvLCBiZWNhdXNlIG9mIGxvY2tpbmcsIHdlIG5l
ZWQgdG8gc2h1dGRvd24gcWVtdSBiZWZvcmUgc3RhcnRpbmcgcWVtdS1pbWcuDQo+PiBBbmQgaXQn
cyBkb25lIHNvIGluIHRlc3RfY29tcGxldGVfdG9wKCkgKEkganVzdCBsb29rZWQgYXQgaXQgYXMg
aXQncyB0aGUgb25seSBvdGhlciB1c2VyIG9mIGNvbXBhcmVfaW1hZ2VzDQo+PiBpbiAwNTYpDQo+
IA0KPiBUaGUgZGVzdGluYXRpb24gaW1hZ2Ugc2hvdWxkbuKAmXQgYmUgaW4gdXNlIGJ5IHFlbXUg
YWZ0ZXIgdGhlIGJsb2NrIGpvYiBpcw0KPiBkb25lLCB0aG91Z2guICBUaGVyZWZvcmUsIHRoZXJl
IHNob3VsZG7igJl0IGJlIGEgbG9jayBpc3N1ZS4gIFRoYXTigJlzIHdoYXQNCj4gSSBtZWFudC4N
Cj4gDQoNCkFoLCB1bmRlcnN0YW5kLiBIbW0sIHRoZW4gaXQncyBzdHJhbmdlIHRoYXQgSSBzZWUg
dGhhdCBlcnJvci4uDQoNCkNsZWFybHksIGluIGpvYl9maW5hbGl6ZV9zaW5nbGUoKSwgam9iX2Ns
ZWFuKCkgaXMgY2FsbGVkIGZpcnN0LCB3aGljaCBzaG91bGQgY2FsbCBiYWNrdXBfY2xlYW4gdG8g
dW5yZWYgdGFyZ2V0LA0KdGhlbiBqb2JfZXZlbnRfY29tcGxldGVkKCkgaXMgY2FsbGVkLi4uDQoN
Cg0KDQo+IA0KPj4+PiBTbywgd2l0aCBhcHBsaWVkDQo+Pj4+DQo+Pj4+IEBAIC0yMDcsNiArMjA3
LDcgQEAgY2xhc3MgQmFja3VwVGVzdChpb3Rlc3RzLlFNUFRlc3RDYXNlKToNCj4+Pj4gICAgICAg
ICAgICAgcmVzID0gc2VsZi52bS5xbXAoJ2Jsb2NrLWpvYi1zZXQtc3BlZWQnLCBkZXZpY2U9J2Ry
aXZlMCcsIHNwZWVkPTApDQo+Pj4+ICAgICAgICAgICAgIHNlbGYuYXNzZXJ0X3FtcChyZXMsICdy
ZXR1cm4nLCB7fSkNCj4+Pj4gICAgICAgICAgICAgc2VsZi5xbXBfYmFja3VwX3dhaXQoJ2RyaXZl
MCcpDQo+Pj4+ICsgICAgICAgIHNlbGYudm0uc2h1dGRvd24oKQ0KPj4+Pg0KPj4+PiAgICAgICAg
ICAgICBzZWxmLmFzc2VydFRydWUoaW90ZXN0cy5jb21wYXJlX2ltYWdlcyhzZWxmLnJlZl9pbWcs
IHNlbGYuZGVzdF9pbWcpLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJ3Rhcmdl
dCBpbWFnZSBkb2VzIG5vdCBtYXRjaCByZWZlcmVuY2UgaW1hZ2UnKQ0KPj4+DQo+Pj4gSeKAmWQg
cGVyc29uYWxseSBwcmVmZXIgYXV0b19kaXNtaXNzPUZhbHNlIGFuZCB0aGVuIGJsb2NrLWpvYi1k
aXNtaXNzLg0KPj4+IEFsdGhvdWdoIEkgY2Fu4oCZdCBnaXZlIGEgcmVhc29uIHdoeS4NCj4+Pg0K
Pj4+PiBSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNv
dkB2aXJ0dW96em8uY29tPg0KPj4+PiBUZXN0ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2ll
dnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+Pg0KPj4+IEluIGFueSBjYXNlLCB0
aGFua3MhDQo+Pj4NCj4+PiBNYXgNCj4+Pg0KPj4NCj4+DQo+IA0KPiANCg0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=

