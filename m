Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADC4C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F4F2089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="R1/cNhDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F4F2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57074 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heFqj-0007vv-Jh
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 05:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45381)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heFoy-0006c1-Ft
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heFov-000175-Da
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:27:00 -0400
Received: from mail-db5eur03on0727.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::727]:56256
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heFou-00015L-NL; Fri, 21 Jun 2019 05:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bKYLZQcyjg1Y2uSOexBca45ucDiDRU4FytE72JX2Qg=;
 b=R1/cNhDqW93oYMEosMI7rIZj2W5zDtAA/UZv0bBsjGsSDYO0OaLuuySmcFY+HIPYY7JNVfGTQ4kb9y1NOMjAWFQLY5NsPjrsWWcQjktXAbdDuVcW4CyvRSMhJutFry8KX6OXOrAJ4wahaA5SXXdc6m4Re8A8loVPZUCjK6E7mlI=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4741.eurprd08.prod.outlook.com (10.255.79.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 21 Jun 2019 09:26:53 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 09:26:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: zhenwei pi <pizhenwei@bytedance.com>, Eric Blake <eblake@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>
Thread-Topic: [External Email] Re: [Qemu-devel] [PATCH 3/3] qapi: add block
 size histogram interface
Thread-Index: AQHVJ0XSa5259Cgqd0KdAf6WgPD6M6akkzEAgADGKYCAAH8DAA==
Date: Fri, 21 Jun 2019 09:26:53 +0000
Message-ID: <e9243587-4d4b-5939-4cd8-312ec457c1db@virtuozzo.com>
References: <1561020872-6214-1-git-send-email-pizhenwei@bytedance.com>
 <1561020872-6214-4-git-send-email-pizhenwei@bytedance.com>
 <cdb81887-5d68-9de5-e72b-3df8a45e52b4@redhat.com>
 <3e4acc6e-9439-6007-9d08-de6878ab8ee6@bytedance.com>
In-Reply-To: <3e4acc6e-9439-6007-9d08-de6878ab8ee6@bytedance.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0003.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::13) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621122650862
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 249a06e6-5e54-4613-6955-08d6f62a98a3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4741; 
x-ms-traffictypediagnostic: DBBPR08MB4741:
x-microsoft-antispam-prvs: <DBBPR08MB474149F41E9DE9829E6FD25DC1E70@DBBPR08MB4741.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(14444005)(66446008)(31696002)(2201001)(256004)(26005)(11346002)(68736007)(486006)(54906003)(4326008)(316002)(53546011)(86362001)(2616005)(31686004)(53936002)(102836004)(81156014)(71190400001)(36756003)(476003)(76176011)(386003)(6506007)(6512007)(186003)(478600001)(66476007)(446003)(81166006)(305945005)(5660300002)(110136005)(229853002)(71200400001)(52116002)(7736002)(66946007)(6116002)(6436002)(8676002)(99286004)(25786009)(14454004)(2906002)(66066001)(3846002)(2501003)(64756008)(6246003)(73956011)(66556008)(8936002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4741;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NqoaYPIpx+uqFN46biO1blnEqMG87c98q2bUCRJRjrqZaNPwyZKvMCcJdyJovVdymzeYkw70B6HUtrid68qC3yzp+huZSdmFVerY0CG88doqdJlmJqwt/6xPyqQkDLnnLDDKtmZm6L3/z7ECIKCw38BPyscvTvyf2KkfZaUR4rxUkH7MvACWrcmjV9I4mdVGv74ifuL4dL5jX9pr/3rbym2xEZq47+0xec9xx6tuFb+07Qb+84KJD3RmbpsiUEgLPZ+tH9vKW+VrGnG+W6eG5+gvGzwQ7rTPAyZ64H+GdJk21sgQJ5wNmBfp/AYxZJ5Ooi8gpmvw5h/QBbB0i+MagsCQVGOnqDtoCvz3DhYypUoDJFKz+fCwUhKrqb57Ew0UsEX0TxoUUykJXOha/xOONuCYq6z9fm3VPiWbi6+5D/s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01D45D897FA3D54A83C655AD7991150D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249a06e6-5e54-4613-6955-08d6f62a98a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 09:26:53.4896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4741
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0a::727
Subject: Re: [Qemu-devel] [External Email] Re: [PATCH 3/3] qapi: add block
 size histogram interface
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjEuMDYuMjAxOSA0OjUyLCB6aGVud2VpIHBpIHdyb3RlOg0KPiBPbiA2LzIwLzE5IDEwOjAzIFBN
LCBFcmljIEJsYWtlIHdyb3RlOg0KPiANCj4+IE9uIDYvMjAvMTkgMzo1NCBBTSwgemhlbndlaSBw
aSB3cm90ZToNCj4+PiBTZXQvQ2xlYXIgYmxvY2sgc2l6ZSBoaXN0b2dyYW1zIHRocm91Z2ggbmV3
IGNvbW1hbmQNCj4+PiB4LWJsb2NrLXNpemUtaGlzdG9ncmFtLXNldCBhbmQgc2hvdyBuZXcgc3Rh
dGlzdGljcyBpbg0KPj4+IHF1ZXJ5LWJsb2Nrc3RhdHMgcmVzdWx0cy4NCj4+Pg0KPj4gSSdtIGd1
ZXNzaW5nIHRoaXMgaXMgbW9kZWxlZCBhZnRlciB0aGUgZXhpc3RpbmcNCj4+IGJsb2NrLWxhdGVu
Y3ktaGlzdG9ncmFtLXNldCBjb21tYW5kPw0KPiANCj4gemhlbndlaTogWWVzLCBpdCBpcy4NCj4g
DQo+Pj4gU2lnbmVkLW9mZi1ieTogemhlbndlaSBwaTxwaXpoZW53ZWlAYnl0ZWRhbmNlLmNvbT4N
Cj4+PiAtLS0NCj4+PiAgIGJsb2NrL3FhcGkuYyAgICAgICAgIHwgIDI0ICsrKysrKysrKysrKw0K
Pj4+ICAgYmxvY2tkZXYuYyAgICAgICAgICAgfCAgNTYgKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+Pj4gICBxYXBpL2Jsb2NrLWNvcmUuanNvbiB8IDEwNSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4+PiAgIDMgZmlsZXMgY2hhbmdlZCwg
MTg0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+PiArKysgYi9xYXBpL2Jsb2NrLWNv
cmUuanNvbg0KPj4+IEBAIC02MzMsNiArNjMzLDEwMCBAQA0KPj4+ICAgICAgICAgICAgICAnKmJv
dW5kYXJpZXMtZmx1c2gnOiBbJ3VpbnQ2NCddIH0gfQ0KPj4+ICAgDQo+Pj4gICAjIw0KPj4+ICsj
IEBCbG9ja1NpemVIaXN0b2dyYW1JbmZvOg0KPj4+ICsjDQo+Pj4gKyMgQmxvY2sgc2l6ZSBoaXN0
b2dyYW0uDQo+Pj4gKyMNCj4+PiArIyBAYm91bmRhcmllczogbGlzdCBvZiBpbnRlcnZhbCBib3Vu
ZGFyeSB2YWx1ZXMgaW4gbmFub3NlY29uZHMsIGFsbCBncmVhdGVyDQo+Pj4gKyMgICAgICAgICAg
ICAgIHRoYW4gemVybyBhbmQgaW4gYXNjZW5kaW5nIG9yZGVyLg0KPj4+ICsjICAgICAgICAgICAg
ICBGb3IgZXhhbXBsZSwgdGhlIGxpc3QgWzgxOTMsIDMyNzY5LCAxMzEwNzNdIHByb2R1Y2VzIHRo
ZQ0KPj4+ICsjICAgICAgICAgICAgICBmb2xsb3dpbmcgaGlzdG9ncmFtIGludGVydmFsczoNCj4+
PiArIyAgICAgICAgICAgICAgWzAsIDgxOTMpLCBbODE5MywgMzI3NjkpLCBbMzI3NjksIDEzMTA3
MyksIFsxMzEwNzMsICtpbmYpLg0KPj4+ICsjDQo+Pj4gKyMgQGJpbnM6IGxpc3Qgb2YgaW8gcmVx
dWVzdCBjb3VudHMgY29ycmVzcG9uZGluZyB0byBoaXN0b2dyYW0gaW50ZXJ2YWxzLg0KPj4+ICsj
ICAgICAgICBsZW4oQGJpbnMpID0gbGVuKEBib3VuZGFyaWVzKSArIDENCj4+PiArIyAgICAgICAg
Rm9yIHRoZSBleGFtcGxlIGFib3ZlLCBAYmlucyBtYXkgYmUgc29tZXRoaW5nIGxpa2UgWzYsIDMs
IDcsIDldLA0KPj4+ICsjICAgICAgICBhbmQgY29ycmVzcG9uZGluZyBoaXN0b2dyYW0gbG9va3Mg
bGlrZToNCj4+PiArIw0KPj4+ICsjIFNpbmNlOiA0LjANCj4+IFlvdSd2ZSBtaXNzZWQgNC4wOyB0
aGUgbmV4dCByZWxlYXNlIGlzIDQuMS4NCj4gDQo+IHpoZW53ZWk6IE9LLCBJIHdpbGwgZml4IGFs
bCB0aGUgdmVyc2lvbiBpbmZvLg0KPiANCj4+PiArIyMNCj4+PiAreyAnc3RydWN0JzogJ0Jsb2Nr
U2l6ZUhpc3RvZ3JhbUluZm8nLA0KPj4+ICsgICdkYXRhJzogeydib3VuZGFyaWVzJzogWyd1aW50
NjQnXSwgJ2JpbnMnOiBbJ3VpbnQ2NCddIH0gfQ0KPj4gVGhpcyBpcyBpZGVudGljYWwgdG8gc3Ry
dWN0IEJsb2NrTGF0ZW5jeUhpc3RvZ3JhbUluZm87IGNhbiB3ZSBpbnN0ZWFkDQo+PiByZW5hbWUg
dGhlIHR5cGUgKHdoaWNoIGRvZXMgbm90IGFmZmVjdCBBUEkpIGFuZCBzaGFyZSBpdCBiZXR3ZWVu
IGJvdGgNCj4+IGltcGxlbWVudGF0aW9ucywgaW5zdGVhZCBvZiBkdXBsaWNhdGluZyBpdD8NCj4+
DQo+IHpoZW53ZWk6IEdvb2QgaWRlYS4gQnV0IEkgYW0gY29uZnVzZWQgYWJvdXQgdGhlIGNvbXBh
dGliaWxpdHkgb2YgdGhlDQo+IHN0cnVjdHVyZSBCbG9ja0xhdGVuY3lIaXN0b2dyYW1JbmZvLiBJ
ZiBJIHJlbmFtZSBCbG9ja0xhdGVuY3lIaXN0b2dyYW1JbmZvDQo+IHRvIEJsb2NrSGlzdG9ncmFt
SW5mbywgaXQgd2lsbCBiZSBjb21tb24uDQo+IA0KPj4+ICsNCj4+PiArIyMNCj4+PiArIyBAeC1i
bG9jay1zaXplLWhpc3RvZ3JhbS1zZXQ6DQo+PiBEb2VzIHRoaXMgbmVlZCB0byBiZSBleHBlcmlt
ZW50YWwgZnJvbSB0aGUgZ2V0LWdvPyBPciBjYW4gaXQgYmUgc3RhYmxlDQo+PiBieSBkcm9wcGlu
ZyAneC0nIHNpbmNlIGl0IG1hdGNoZXMgdGhlIGZhY3QgdGhhdA0KPj4gYmxvY2stbGF0ZW5jeS1o
aXN0b2dyYW0tc2V0IGlzIHN0YWJsZT8NCj4gDQo+IHpoZW53ZWk6IE9LLCBJIHdpbGwgZHJvcCAn
eC0nIHByZWZpeC4NCj4gDQo+Pj4gKyMNCj4+PiArIyBNYW5hZ2UgcmVhZCwgd3JpdGUgYW5kIGZs
dXNoIHNpemUgaGlzdG9ncmFtcyBmb3IgdGhlIGRldmljZS4NCj4+PiArIw0KPj4+ICsjIElmIG9u
bHkgQGlkIHBhcmFtZXRlciBpcyBzcGVjaWZpZWQsIHJlbW92ZSBhbGwgcHJlc2VudCBzaXplIGhp
c3RvZ3JhbXMNCj4+PiArIyBmb3IgdGhlIGRldmljZS4gT3RoZXJ3aXNlLCBhZGQvcmVzZXQgc29t
ZSBvZiAob3IgYWxsKSBzaXplIGhpc3RvZ3JhbXMuDQo+Pj4gKyMNCj4+PiArIyBAaWQ6IFRoZSBu
YW1lIG9yIFFPTSBwYXRoIG9mIHRoZSBndWVzdCBkZXZpY2UuDQo+Pj4gKyMNCj4+PiArIyBAYm91
bmRhcmllczogbGlzdCBvZiBpbnRlcnZhbCBib3VuZGFyeSB2YWx1ZXMgKHNlZSBkZXNjcmlwdGlv
biBpbg0KPj4+ICsjICAgICAgICAgICAgICBCbG9ja1NpemVIaXN0b2dyYW1JbmZvIGRlZmluaXRp
b24pLiBJZiBzcGVjaWZpZWQsIGFsbA0KPj4+ICsjICAgICAgICAgICAgICBzaXplIGhpc3RvZ3Jh
bXMgYXJlIHJlbW92ZWQsIGFuZCBlbXB0eSBvbmVzIGNyZWF0ZWQgZm9yIGFsbA0KPj4+ICsjICAg
ICAgICAgICAgICBpbyB0eXBlcyB3aXRoIGludGVydmFscyBjb3JyZXNwb25kaW5nIHRvIEBib3Vu
ZGFyaWVzIChleGNlcHQgZm9yDQo+Pj4gKyMgICAgICAgICAgICAgIGlvIHR5cGVzLCBmb3Igd2hp
Y2ggc3BlY2lmaWMgYm91bmRhcmllcyBhcmUgc2V0IHRocm91Z2ggdGhlDQo+Pj4gKyMgICAgICAg
ICAgICAgIGZvbGxvd2luZyBwYXJhbWV0ZXJzKS4NCj4+PiArIw0KPj4+ICsjIEBib3VuZGFyaWVz
LXJlYWQ6IGxpc3Qgb2YgaW50ZXJ2YWwgYm91bmRhcnkgdmFsdWVzIGZvciByZWFkIHNpemUNCj4+
PiArIyAgICAgICAgICAgICAgICAgICBoaXN0b2dyYW0uIElmIHNwZWNpZmllZCwgb2xkIHJlYWQg
c2l6ZSBoaXN0b2dyYW0gaXMNCj4+PiArIyAgICAgICAgICAgICAgICAgICByZW1vdmVkLCBhbmQg
ZW1wdHkgb25lIGNyZWF0ZWQgd2l0aCBpbnRlcnZhbHMNCj4+PiArIyAgICAgICAgICAgICAgICAg
ICBjb3JyZXNwb25kaW5nIHRvIEBib3VuZGFyaWVzLXJlYWQuIFRoZSBwYXJhbWV0ZXIgaGFzIGhp
Z2hlcg0KPj4+ICsjICAgICAgICAgICAgICAgICAgIHByaW9yaXR5IHRoZW4gQGJvdW5kYXJpZXMu
DQo+Pj4gKyMNCj4+PiArIyBAYm91bmRhcmllcy13cml0ZTogbGlzdCBvZiBpbnRlcnZhbCBib3Vu
ZGFyeSB2YWx1ZXMgZm9yIHdyaXRlIHNpemUNCj4+PiArIyAgICAgICAgICAgICAgICAgICAgaGlz
dG9ncmFtLg0KPj4+ICsjDQo+Pj4gKyMgQGJvdW5kYXJpZXMtZmx1c2g6IGxpc3Qgb2YgaW50ZXJ2
YWwgYm91bmRhcnkgdmFsdWVzIGZvciBmbHVzaCBzaXplDQo+Pj4gKyMgICAgICAgICAgICAgICAg
ICAgIGhpc3RvZ3JhbS4NCj4+PiArIw0KPj4+ICsjIFJldHVybnM6IGVycm9yIGlmIGRldmljZSBp
cyBub3QgZm91bmQgb3IgYW55IGJvdW5kYXJ5IGFycmF5cyBhcmUgaW52YWxpZC4NCj4+PiArIw0K
Pj4+ICsjIFNpbmNlOiA0LjANCj4+IDQuMQ0KPj4NCj4+PiArIw0KPj4+ICsjIEV4YW1wbGU6IHNl
dCBuZXcgaGlzdG9ncmFtcyBmb3IgYWxsIGlvIHR5cGVzIHdpdGggaW50ZXJ2YWxzDQo+Pj4gKyMg
WzAsIDgxOTMpLCBbODE5MywgMzI3NjkpLCBbMzI3NjksIDEzMTA3MyksIFsxMzEwNzMsICtpbmYp
Og0KPj4+ICsjDQo+Pj4gKyMgLT4geyAiZXhlY3V0ZSI6ICJ4LWJsb2NrLXNpemUtaGlzdG9ncmFt
LXNldCIsDQo+Pj4gKyMgICAgICAiYXJndW1lbnRzIjogeyAiaWQiOiAiZHJpdmUwIiwNCj4+PiAr
IyAgICAgICAgICAgICAgICAgICAgICJib3VuZGFyaWVzIjogWzgxOTMsIDMyNzY5LCAxMzEwNzNd
IH0gfQ0KPj4+ICsjIDwtIHsgInJldHVybiI6IHt9IH0NCj4+PiArIw0KPj4+ICsjIEV4YW1wbGU6
IHNldCBuZXcgaGlzdG9ncmFtIG9ubHkgZm9yIHdyaXRlLCBvdGhlciBoaXN0b2dyYW1zIHdpbGwg
cmVtYWluDQo+Pj4gKyMgbm90IGNoYW5nZWQgKG9yIG5vdCBjcmVhdGVkKToNCj4+PiArIw0KPj4+
ICsjIC0+IHsgImV4ZWN1dGUiOiAieC1ibG9jay1zaXplLWhpc3RvZ3JhbS1zZXQiLA0KPj4+ICsj
ICAgICAgImFyZ3VtZW50cyI6IHsgImlkIjogImRyaXZlMCIsDQo+Pj4gKyMgICAgICAgICAgICAg
ICAgICAgICAiYm91bmRhcmllcy13cml0ZSI6IFs4MTkzLCAzMjc2OSwgMTMxMDczXSB9IH0NCj4+
PiArIyA8LSB7ICJyZXR1cm4iOiB7fSB9DQo+Pj4gKyMNCj4+PiArIyBFeGFtcGxlOiBzZXQgbmV3
IGhpc3RvZ3JhbXMgd2l0aCB0aGUgZm9sbG93aW5nIGludGVydmFsczoNCj4+PiArIyAgIHJlYWQs
IGZsdXNoOiBbMCwgODE5MyksIFs4MTkzLCAzMjc2OSksIFszMjc2OSwgMTMxMDczKSwgWzEzMTA3
MywgK2luZikNCj4+PiArIyAgIHdyaXRlOiBbMCwgNDA5NyksIFs0MDk3LCA4MTkzKSwgWzgxOTMs
IDMyNzY5KSwgWzMyNzY5LCAraW5mKQ0KPj4+ICsjDQo+Pj4gKyMgLT4geyAiZXhlY3V0ZSI6ICJ4
LWJsb2NrLXNpemUtaGlzdG9ncmFtLXNldCIsDQo+Pj4gKyMgICAgICAiYXJndW1lbnRzIjogeyAi
aWQiOiAiZHJpdmUwIiwNCj4+PiArIyAgICAgICAgICAgICAgICAgICAgICJib3VuZGFyaWVzIjog
WzgxOTMsIDMyNzY5LCAxMzEwNzNdLA0KPj4+ICsjICAgICAgICAgICAgICAgICAgICAgImJvdW5k
YXJpZXMtd3JpdGUiOiBbNDA5NywgODE5MywgMzI3NjldIH0gfQ0KPj4+ICsjIDwtIHsgInJldHVy
biI6IHt9IH0NCj4+PiArIw0KPj4+ICsjIEV4YW1wbGU6IHJlbW92ZSBhbGwgc2l6ZSBoaXN0b2dy
YW1zOg0KPj4+ICsjDQo+Pj4gKyMgLT4geyAiZXhlY3V0ZSI6ICJ4LWJsb2NrLXNpemUtaGlzdG9n
cmFtLXNldCIsDQo+Pj4gKyMgICAgICAiYXJndW1lbnRzIjogeyAiaWQiOiAiZHJpdmUwIiB9IH0N
Cj4+PiArIyA8LSB7ICJyZXR1cm4iOiB7fSB9DQo+Pj4gKyMjDQo+Pj4gK3sgJ2NvbW1hbmQnOiAn
eC1ibG9jay1zaXplLWhpc3RvZ3JhbS1zZXQnLA0KPj4+ICsgICdkYXRhJzogeydpZCc6ICdzdHIn
LA0KPj4+ICsgICAgICAgICAgICcqYm91bmRhcmllcyc6IFsndWludDY0J10sDQo+Pj4gKyAgICAg
ICAgICAgJypib3VuZGFyaWVzLXJlYWQnOiBbJ3VpbnQ2NCddLA0KPj4+ICsgICAgICAgICAgICcq
Ym91bmRhcmllcy13cml0ZSc6IFsndWludDY0J10sDQo+Pj4gKyAgICAgICAgICAgJypib3VuZGFy
aWVzLWZsdXNoJzogWyd1aW50NjQnXSB9IH0NCj4+IEFnYWluLCB0aGlzIGNvcGllcyBoZWF2aWx5
IGZyb20gYmxvY2stbGF0ZW5jeS1oaXN0b2dyYW0tc2V0LiAgQnV0DQo+PiBjaGFuZ2luZyB0aGUg
Y29tbWFuZCBuYW1lIGlzIG5vdCBBUEkgY29tcGF0aWJsZS4gIFNob3VsZCB3ZSBoYXZlIGENCj4+
IHNpbmdsZSBuZXcgY29tbWFuZCAnYmxvY2staGlzdG9ncmFtLXNldCcgd2hpY2ggdGFrZXMgYW4g
ZW51bSBjaG9vc2luZw0KPj4gYmV0d2VlbiAnbGF0ZW5jeScgYW5kICdzaXplJywgYW5kIHN0YXJ0
IHRoZSBkZXByZWNhdGlvbiBjbG9jayBvbg0KPj4gJ2Jsb2NrLWxhdGVuY3ktaGlzdG9ncmFtLXNl
dCc/DQo+PiAgIChhbmQgZGVmYXVsdGluZyB0byAnbGF0ZW5jeScgZm9yIGJhY2stY29tcGF0DQo+
Pg0KPiB6aGVud2VpOiB0aGlzIGFjdHVhbGx5IGNvcGllcyBmcm9tIGJsb2NrLWxhdGVuY3ktaGlz
dG9ncmFtLXNldCwgYmVjYXVzZSB0aGUNCj4gdHdvIEFQSXMgaGF2ZSB0aGUgc2ltaWxhciBsb2dp
YyBidXQgZGlmZmVyZW50IHN0cnVjdHVyZQ0KPiBCbG9ja0xhdGVuY3lIaXN0b2dyYW1JbmZvIGFu
ZCBCbG9ja1NpemVIaXN0b2dyYW1JbmZvLg0KPiBGb3IgZnVydGhlciBleHRlbnNpb24sIGEgc2lu
Z2xlIG5ldyBjb21tYW5kICdibG9jay1oaXN0b2dyYW0tc2V0JyB3aXRoDQo+IGVudW0gb3BlcmF0
aW9uIGlzIGJldHRlci4NCj4gU28sIHNob3VsZCBJIHJlbW92ZSAnYmxvY2stbGF0ZW5jeS1oaXN0
b2dyYW0tc2V0JyBhbmQgYWRkICdibG9jay1oaXN0b2dyYW0tc2V0Jz8NCj4gDQoNCkhpIFpoZW53
ZWkhDQoNCkdsYWQgdG8gc2VlIHRoYXQgbXkgd29yayBpcyB1c2VmdWwgbm90IG9ubHkgZm9yIG15
IGNvbXBhbnkhIEFuZCBzYWQgdGhhdCB5b3UgZGlkbid0DQpwcm9wb3NlIGl0IGJlZm9yZSBkcm9w
cGluZyB4LXByZWZpeGVzLiBCdXQgdGhlIGludGVyZmFjZSBpcyB5YW5nIGFuZCBJIHRoaW5rIGl0
J3MNCmRlcHJlY2F0aW9uIHNob3VsZCBub3QgYmUgYSBwcm9ibGVtIChmb3IgdXMgYXQgbGVhc3Qs
IGlmIEknbSBub3QgbWlzdGFrZW4sIHdlIG9ubHkNCnVzZSBpdCBmb3Igc29tZXRoaW5nIG5lYXIg
dG8gaW50ZXJuYWwgcHVycG9zZXMpLi4NCg0KVGhlbiwgYWdyZWUgd2l0aCBFcmljIHRoYXQgaXQn
cyBiZXR0ZXIgdG8gbWFrZSBpdCBjb21tb24sIGF2b2lkaW5nIGR1cGxpY2F0aW9uLiBFdmVuDQpp
ZiB3ZSBrZWVwIGJvdGggY29tbWFuZHMgKGFuZCBhbnl3YXkgd2UgaGF2ZSB0bywgYXQgbGVhc3Qg
ZHVyaW5nIGRlcHJlY2F0aW9uIHBlcmlvZCkNCndlIGNhbiBwdXQgdGhlaXIgcGFyYW1ldGVycyB0
byBhIHNlcGFyYXRlIHN0cnVjdHVyZSB0byBiZSBzaGFyZWQgYmV0d2VlbiB0aGVtLCBsaWtlDQpC
bG9ja0RpcnR5Qml0bWFwIGlzIHNoYXJlZCBwYXJhbWV0ZXIgc3RydWN0dXJlIGZvciBibG9jay1k
aXJ0eS1iaXRtYXAtY2xlYXIsDQpibG9jay1kaXJ0eS1iaXRtYXAtZW5hYmxlLCBldGMuDQoNCklu
dGVyZXN0aW5nLCBjYW4gd2UgZ28gZnVydGhlciBhbmQgY3JlYXRlIHNvbWUgZ2VuZXJpYyBoaXN0
b2dyYW0gQVBJLCBub3Qgb25seSBmb3INCmJsb2NrIHN1YnN5c3RlbT8gSG1tLi4gSSBkb24ndCBz
ZWUgYSBjb21wYXRpYmxlIHNvbHV0aW9uLi4gSGlzdG9ncmFtIHBvc3NpYmxlIHNob3VsZA0KYmUg
YSBzZXBhcmF0ZSBvYmplY3Qgd2l0aCBwZXJzb25hbCBpZCwgYW5kIHRoYW4gd2UgYmluZCBpdCB0
byBvdXIgYmxvY2sgc3RhdHMsIGJ1dA0KdGhpcyBkZWZpbml0ZWx5IG1vcmUgY29tcGxpY2F0ZWQg
QVBJIHRoYW4gd2hhdCB3ZSBoYXZlLi4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

