Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDB6C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3904A206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SREFczwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3904A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haMqf-0000mp-43
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 12:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57302)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haMjs-0003lf-2c
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haMjp-0008H9-TH
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:01:39 -0400
Received: from mail-eopbgr140104.outbound.protection.outlook.com
 ([40.107.14.104]:51079 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1haMjn-0007ue-Jn
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nz9a4pws5OjclTV9tsgl/frEPZBqlNVSDckjZCO4RSU=;
 b=SREFczwqXGiwQmIVAN+0ONIoyQ2qtJZzeqf+EhzuxbmsHt1t4BxW3KNxxPqj1hRgiaOIYJIh/aqbBvyiPssRTxFoKqu08aaLAQw9KygU8QLxDY59FUmRe447h2wie+SBlzmxosYPjof5eUdYA28QS9hKXMbRMUt/4MUsYvMrKpI=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB5235.eurprd08.prod.outlook.com (20.179.39.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 10 Jun 2019 16:01:03 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 16:01:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH] qapi: InitSocketAddress: add keepalive
 option
Thread-Index: AQHVHFDRDxz2DhKj+k6v6TBL3MsCfaaOejSAgAAEXICAAfPl94AEoE+A
Date: Mon, 10 Jun 2019 16:01:03 +0000
Message-ID: <130a582d-6c5b-3b38-977d-cfb1ce7f98ac@virtuozzo.com>
References: <20190606101533.20228-1-vsementsov@virtuozzo.com>
 <20190606111725.GH14300@redhat.com>
 <f42975be-51cf-c6b6-0148-514dfac7c2fa@virtuozzo.com>
 <87v9xh5n0j.fsf@dusky.pond.sub.org>
In-Reply-To: <87v9xh5n0j.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0083.eurprd04.prod.outlook.com
 (2603:10a6:3:19::51) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190610190101413
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 000e52ab-c3fb-4679-9e2d-08d6edbcd6bd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB5235; 
x-ms-traffictypediagnostic: AM0PR08MB5235:
x-microsoft-antispam-prvs: <AM0PR08MB5235A9CC1A02AEA90377B3A2C1130@AM0PR08MB5235.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(376002)(366004)(39850400004)(346002)(199004)(189003)(53754006)(446003)(229853002)(11346002)(99286004)(53936002)(73956011)(66476007)(66946007)(66556008)(64756008)(66446008)(6246003)(4326008)(476003)(86362001)(54906003)(6506007)(2906002)(5660300002)(386003)(31696002)(14454004)(316002)(6116002)(26005)(66066001)(76176011)(3846002)(52116002)(102836004)(305945005)(31686004)(7736002)(8936002)(36756003)(25786009)(71190400001)(71200400001)(6486002)(14444005)(81156014)(478600001)(8676002)(256004)(6512007)(68736007)(186003)(6436002)(81166006)(2616005)(486006)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5235;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3YhOjMTjjlNHrIafeZ9yZ/H8agP92rv8J19AzJQAgB+98+VRJZn3//6tW9hRKkgkq7HS0fJ3UabHNbK3X4s9lW3fCNe21KZRGnJ8751L6w+3nrw7sbGCCA2paVJEBBrK6n0kHGipiNEloZbl5BinnzMol4G7fG3WIaC0bBv4Btg0Uw9RCiXN/grKDHIvq0nkbGRCGlnWKIBDfKxV2YS3edz0XGCO4ioNZZ2paFPY1JQRcFohgUx83y01hcZWOa36GR0vpPXtaCPdhECIUxBI9SBT0U4011cWSpBWNRvIVi2JrrodqK3dmK6j+Z5imvKQ1OT4If3DbVT2LdZJNrYB6LEgMxjNOK+T3Z5CyZZ84+lAYBBr/bTI7ggAt/p+kf76tUeKhQw4oYGpJYJCwFFtT/FKQuDVCC3Eq/rpV9LYLVk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7B3AEB89B2D3D4CAF993AE6190DE333@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000e52ab-c3fb-4679-9e2d-08d6edbcd6bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 16:01:03.5527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5235
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.104
Subject: Re: [Qemu-devel] [PATCH] qapi: InitSocketAddress: add keepalive
 option
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, "kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMDYuMjAxOSAyMDoyMiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiAN
Cj4+IDA2LjA2LjIwMTkgMTQ6MTcsIERhbmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+Pj4gT24g
VGh1LCBKdW4gMDYsIDIwMTkgYXQgMDE6MTU6MzNQTSArMDMwMCwgVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+PiAtLS0NCj4+Pj4NCj4+
Pj4gSGkgYWxsIQ0KPj4+Pg0KPj4+PiBUaGlzIGlzIGEgY29udGludWF0aW9uIG9mICJbUEFUQ0gg
djIgMC8yXSBuYmQ6IGVuYWJsZSBrZWVwYWxpdmUiLCBidXQNCj4+Pj4gaXQncyBhIHRyeSBmcm9t
IGFub3RoZXIgc2lkZSwgc28gYWxtb3N0IG5vdGhpbmcgY29tbW9uIHdpdGggdjIuDQo+IA0KPiBQ
bGVhc2UgZXhwbGFpbiBpbnRlbmRlZCB1c2Ugb2YgeW91ciBuZXcgb3B0aW9uIGluIHlvdXIgY29t
bWl0IG1lc3NhZ2UuDQoNCldpbGwgZG8uIEFjdHVhbCByZWFzb24gaXMga2VlcGFsaXZlIGZvciBu
YmQtY2xpZW50Lg0KDQo+IA0KPj4+PiAgICBxYXBpL3NvY2tldHMuanNvbiAgIHwgIDUgKysrKy0N
Cj4+Pj4gICAgdXRpbC9xZW11LXNvY2tldHMuYyB8IDEzICsrKysrKysrKysrKysNCj4+Pj4gICAg
MiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+DQo+
Pj4+IGRpZmYgLS1naXQgYS9xYXBpL3NvY2tldHMuanNvbiBiL3FhcGkvc29ja2V0cy5qc29uDQo+
Pj4+IGluZGV4IGZjODFkOGQ1ZTguLmFlZmEwMjQwNTEgMTAwNjQ0DQo+Pj4+IC0tLSBhL3FhcGkv
c29ja2V0cy5qc29uDQo+Pj4+ICsrKyBiL3FhcGkvc29ja2V0cy5qc29uDQo+Pj4+IEBAIC01Myw2
ICs1Myw4IEBADQo+Pj4+ICAgICMNCj4+Pj4gICAgIyBAaXB2Njogd2hldGhlciB0byBhY2NlcHQg
SVB2NiBhZGRyZXNzZXMsIGRlZmF1bHQgdHJ5IGJvdGggSVB2NCBhbmQgSVB2Ng0KPj4+PiAgICAj
DQo+Pj4+ICsjIEBrZWVwYWxpdmU6IGVuYWJsZSBrZWVwYWxpdmUgd2hlbiBjb25uZWN0aW5nIHRv
IHRoaXMgc29ja2V0IChTaW5jZSA0LjEpDQo+Pj4+ICsjDQo+Pj4+ICAgICMgU2luY2U6IDEuMw0K
Pj4+PiAgICAjIw0KPj4+PiAgICB7ICdzdHJ1Y3QnOiAnSW5ldFNvY2tldEFkZHJlc3MnLA0KPj4+
PiBAQCAtNjEsNyArNjMsOCBAQA0KPj4+PiAgICAgICAgJypudW1lcmljJzogICdib29sJywNCj4+
Pj4gICAgICAgICcqdG8nOiAndWludDE2JywNCj4+Pj4gICAgICAgICcqaXB2NCc6ICdib29sJywN
Cj4+Pj4gLSAgICAnKmlwdjYnOiAnYm9vbCcgfSB9DQo+Pj4+ICsgICAgJyppcHY2JzogJ2Jvb2wn
LA0KPj4+PiArICAgICcqa2VlcGFsaXZlJzogJ2Jvb2wnIH0gfQ0KPiANCj4gSSBrbm93IHRoZSBD
IGlkZW50aWZpZXIgaXMgU09fS0VFUEFMSVZFLCBidXQgbGV0J3Mgc3RpY2sgdG8gcHJvcGVyDQo+
IEVuZ2xpc2ggd29yZHMgaW4gUU1QOiBrZWVwLWFsaXZlLg0KDQpPaw0KDQo+IA0KPj4+PiAgICAN
Cj4+Pj4gICAgIyMNCj4+Pj4gICAgIyBAVW5peFNvY2tldEFkZHJlc3M6DQo+Pj4+IGRpZmYgLS1n
aXQgYS91dGlsL3FlbXUtc29ja2V0cy5jIGIvdXRpbC9xZW11LXNvY2tldHMuYw0KPj4+PiBpbmRl
eCA4ODUwYTI4MGE4Li5kMmNkMmE5ZDRmIDEwMDY0NA0KPj4+PiAtLS0gYS91dGlsL3FlbXUtc29j
a2V0cy5jDQo+Pj4+ICsrKyBiL3V0aWwvcWVtdS1zb2NrZXRzLmMNCj4+Pj4gQEAgLTQ1Nyw2ICs0
NTcsMTkgQEAgaW50IGluZXRfY29ubmVjdF9zYWRkcihJbmV0U29ja2V0QWRkcmVzcyAqc2FkZHIs
IEVycm9yICoqZXJycCkNCj4+Pj4gICAgICAgIH0NCj4+Pj4gICAgDQo+Pj4+ICAgICAgICBmcmVl
YWRkcmluZm8ocmVzKTsNCj4+Pj4gKw0KPj4+PiArICAgIGlmIChzYWRkci0+a2VlcGFsaXZlKSB7
DQo+Pj4NCj4+PiBJSVVDLCBiZXN0IHByYWN0aWNlIGlzIHRvIHVzZSAnc2FkZHItPmhhc19rZWVw
YWxpdmUgJiYgc2FkZHItPmtlZXBhbGl2ZScNCj4+DQo+PiBBcyBJIHJlbWVtYmVyLCBub3cgYWxs
IG9wdGlvbmFsIGZpZWxkcyBhcmUgemVyb2VkLiBCdXQgSSdtIG5vdCBhZ2FpbnN0IHN0cmljdGVy
IGNvbmRpdGlvbi4NCj4gDQo+IEFzIGZhciBhcyBJJ20gY29uY2VybmVkLCByZWx5aW5nIG9uIHpl
cm8taW5pdGlhbGl6YXRpb24gb2Ygb3B0aW9uYWwNCj4gbWVtYmVycyBpcyBmaW5lLg0KPiANCj4+
DQo+Pj4NCj4+Pj4gKyAgICAgICAgaW50IHZhbCA9IDE7DQo+Pj4+ICsgICAgICAgIGludCByZXQg
PSBxZW11X3NldHNvY2tvcHQoc29jaywgU09MX1NPQ0tFVCwgU09fS0VFUEFMSVZFLA0KPj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2YWwsIHNpemVvZih2YWwpKTsNCj4+
Pj4gKw0KPj4+PiArICAgICAgICBpZiAocmV0IDwgMCkgew0KPj4+PiArICAgICAgICAgICAgZXJy
b3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywgIlVuYWJsZSB0byBzZXQgS0VFUEFMSVZFIik7DQo+
Pj4+ICsgICAgICAgICAgICBjbG9zZShzb2NrKTsNCj4+Pj4gKyAgICAgICAgICAgIHJldHVybiAt
MTsNCj4+Pj4gKyAgICAgICAgfQ0KPj4+PiArICAgIH0NCj4+Pj4gKw0KPj4+PiAgICAgICAgcmV0
dXJuIHNvY2s7DQo+Pj4+ICAgIH0NCj4gDQo+IFBvc3NpYmx5IGlnbm9yYW50IHF1ZXN0aW9uOiB3
aHkgb2JleSB0aGUga2VlcC1hbGl2ZSBvcHRpb24gZm9yIGFjdGl2ZQ0KPiBjb25uZWN0aW9ucyAo
bWFkZSB3aXRoIGluZXRfY29ubmVjdF9zYWRkcigpKSwgYnV0IG5vdCBwYXNzaXZlIG9uZXMgKG1h
ZGUNCj4gd2l0aCBpbmV0X2xpc3Rlbl9zYWRkcigpICsgYWNjZXB0KCkpPw0KDQpIbW0uIEl0J3Mg
YSBiaXQgdHJpY2tpZXIsIGFzIHNlZW1zIEkgY2FuJ3QgZG8gaXQgb24gc29ja2V0IGxldmVsLCBh
cyBwYXJhbWV0ZXIga2VlcC1hbGl2ZSBJDQpnZXQgZm9yIGxpc3RlbiBwYXJ0LCBidXQga2VlcC1h
bGl2ZSBzaG91bGQgYmUgZW5hYmxlZCBvbiBzb2NrZXQgZnJvbSBhY2NlcHQuIFNvIHRoaXMgc2hv
dWxkDQpiZSBpbXBsZW1lbnRlZCBvbiBxaW9fY2hhbm5lbCBsZXZlbC4uIEknZCBwcmVmZXIgbm90
IGltcGxlbWVudCBpdCBub3cuIFdlIG5vdyBvbmx5IGludGVyZXN0ZWQNCmluIGtlZXAtYWxpdmUg
Zm9yIGNsaWVudCwgYW5kIHNlZW1zIGdlbmVyYWxseSBrZWVwLWFsaXZlIGlzIG1vcmUgdXNhYmxl
IGZvciBjbGllbnQgcGFydC4NCg0KPiANCj4gRG8geW91IG5lZWQgdG8gdXBkYXRlIGluZXRfcGFy
c2UoKT8NCg0Kd2lsbCBkbywgdGhhbmsgeW91IGZvciByZXZpZXdpbmchDQoNCg0KDQotLSANCkJl
c3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

