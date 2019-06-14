Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0D0C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19202064A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LWWBffPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19202064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53978 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqdF-0001L5-6h
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33049)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbpxS-0004eI-Hn
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbpxR-0001Tr-GH
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:25:46 -0400
Received: from mail-eopbgr130090.outbound.protection.outlook.com
 ([40.107.13.90]:2465 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbpxR-0001KW-8E
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8ZWGDt41XYKnwYXEc/g4VCyElhB56/MPFPZFZGUmEs=;
 b=LWWBffPni0dtMATBVsius08hdkQmqe/0GghSUtsFRXyHlfzLzoGPK8jyp86chuNnPEwh8VfifhTbNvqsctRMuSBOsiKqRPCJ/QvMij8Sha/RYLcaHrqKK4PPr4DnuCGu/94ai9kMZMXTBBpna0ydo0b58yQQYc36za2mhPWB+vI=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB5284.eurprd08.prod.outlook.com (20.178.117.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 14 Jun 2019 17:25:40 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 17:25:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v2] qapi: InitSocketAddress: add keepalive
 option
Thread-Index: AQHVH6cAJDibxBmsVEKOfDPINRwS6qaWeWuLgATzpAA=
Date: Fri, 14 Jun 2019 17:25:39 +0000
Message-ID: <6b598c2c-7c58-7236-0b3e-172094d6a67a@virtuozzo.com>
References: <20190610160957.46809-1-vsementsov@virtuozzo.com>
 <8736kg2py5.fsf@dusky.pond.sub.org>
In-Reply-To: <8736kg2py5.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0045.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::13) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614202538086
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 493ebf11-6166-4311-83a5-08d6f0ed523a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB5284; 
x-ms-traffictypediagnostic: AM0PR08MB5284:
x-microsoft-antispam-prvs: <AM0PR08MB528417AB3E6B1AE2A79CF653C1EE0@AM0PR08MB5284.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39850400004)(376002)(366004)(346002)(189003)(199004)(107886003)(81166006)(2906002)(68736007)(6512007)(316002)(478600001)(229853002)(71190400001)(4326008)(8936002)(26005)(53936002)(86362001)(66556008)(66946007)(71200400001)(66476007)(31696002)(5660300002)(64756008)(256004)(73956011)(14444005)(8676002)(476003)(52116002)(186003)(7736002)(6506007)(99286004)(6916009)(305945005)(66446008)(102836004)(446003)(11346002)(81156014)(486006)(2616005)(36756003)(14454004)(6116002)(6246003)(3846002)(25786009)(6486002)(31686004)(54906003)(6436002)(76176011)(66066001)(386003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5284;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m14cbJfvB20szov5NndqMOD6URdE1M7YHPYvh0/gBg6Icgmmicn9F5C7ztsh/DphRmUfhvLOAku6wi6MdtqFFFHGgwgaD+Q5YZgdLmRUFCg0BY137zKhMhQmahO9J2X+T2T0ln20qBDj1lnHYmC344Iet+8Qt+c4shEoUtfNXhwS25+tE6tw0RpzVvqPy99iE/KnLacCYrz26hHgL4XhdhfVpYbui9euwMxzblBbLkaFLZCRmb++urCZjNXW0dIrp1j1mfh5MAuZLm1r1ItGqeN0m/q/M4TA+lPXwcad81Psq1/oTX2SzOcwb5sS1CTbEq2aE28RhWba2moTE4WYWlm2VW8kOTQozi4PRn/OWbRNT11tRLT0ojfakY6nL5U0HrRNHC5PUZiVPH2tdbsZECacPYE8DJ7jJW9GX2cywGE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61E41A716B08CF439C319B16B57834E5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493ebf11-6166-4311-83a5-08d6f0ed523a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 17:25:39.9744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5284
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.90
Subject: Re: [Qemu-devel] [PATCH v2] qapi: InitSocketAddress: add keepalive
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTEuMDYuMjAxOSAxNjo0OCwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFlvdSBtaXNzcGVs
bGVkIEluZXRTb2NrZXRBZGRyZXNzIGFuZCBrZWVwLWFsaXZlIGluIHRoZSBzdWJqZWN0LiAgU3Vn
Z2VzdA0KPiANCj4gICAgICBxYXBpOiBBZGQgSW5ldFNvY2tldEFkZHJlc3MgbWVtYmVyIGtlZXAt
YWxpdmUNCg0KT2hoLCBJIGZlZWwgc3R1cGlkDQoNCj4gDQo+IFZsYWRpbWlyIFNlbWVudHNvdi1P
Z2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiANCj4+IEl0J3Mg
bmVlZGVkIHRvIHByb3ZpZGUga2VlcGFsaXZlIGZvciBuYmQgY2xpZW50IHRvIHRyYWNrIHNlcnZl
cg0KPj4gYXZhaWxhYmlsaXR5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4NCj4+
IHYyOiBbYnkgTWFya3VzJ3MgY29tbWVudHNdDQo+PiAgIC0gaW1wcm92ZSBjb21taXQgbWVzc2Fn
ZQ0KPj4gICAtIHMva2VlcGFsaXZlL2tlZXAtYWxpdmUNCj4+ICAgLSB1cGRhdGUgaW5ldF9wYXJz
ZSgpDQo+Pg0KPj4NCj4+ICAgcWFwaS9zb2NrZXRzLmpzb24gICB8ICA1ICsrKystDQo+PiAgIHV0
aWwvcWVtdS1zb2NrZXRzLmMgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDIgZmls
ZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9xYXBpL3NvY2tldHMuanNvbiBiL3FhcGkvc29ja2V0cy5qc29uDQo+PiBpbmRleCBm
YzgxZDhkNWU4Li4xM2EyNjI3ZTFkIDEwMDY0NA0KPj4gLS0tIGEvcWFwaS9zb2NrZXRzLmpzb24N
Cj4+ICsrKyBiL3FhcGkvc29ja2V0cy5qc29uDQo+PiBAQCAtNTMsNiArNTMsOCBAQA0KPj4gICAj
DQo+PiAgICMgQGlwdjY6IHdoZXRoZXIgdG8gYWNjZXB0IElQdjYgYWRkcmVzc2VzLCBkZWZhdWx0
IHRyeSBib3RoIElQdjQgYW5kIElQdjYNCj4+ICAgIw0KPj4gKyMgQGtlZXAtYWxpdmU6IGVuYWJs
ZSBrZWVwLWFsaXZlIHdoZW4gY29ubmVjdGluZyB0byB0aGlzIHNvY2tldCAoU2luY2UgNC4xKQ0K
Pj4gKyMNCj4+ICAgIyBTaW5jZTogMS4zDQo+PiAgICMjDQo+PiAgIHsgJ3N0cnVjdCc6ICdJbmV0
U29ja2V0QWRkcmVzcycsDQo+IA0KPiBQbGVhc2UgZG9jdW1lbnQgdGhhdCBAa2VlcC1hbGl2ZSBp
cyBzaWxlbnRseSBpZ25vcmVkIGZvciBwYXNzaXZlDQo+IHNvY2tldHMuDQo+IA0KPiBFdmVuIGJl
dHRlciB3b3VsZCBiZSByZWplY3RpbmcgaXQgdGhlbiwgb2YgY291cnNlLg0KDQpPaw0KDQo+IA0K
Pj4gQEAgLTYxLDcgKzYzLDggQEANCj4+ICAgICAgICcqbnVtZXJpYyc6ICAnYm9vbCcsDQo+PiAg
ICAgICAnKnRvJzogJ3VpbnQxNicsDQo+PiAgICAgICAnKmlwdjQnOiAnYm9vbCcsDQo+PiAtICAg
ICcqaXB2Nic6ICdib29sJyB9IH0NCj4+ICsgICAgJyppcHY2JzogJ2Jvb2wnLA0KPj4gKyAgICAn
KmtlZXAtYWxpdmUnOiAnYm9vbCcgfSB9DQo+PiAgIA0KPj4gICAjIw0KPj4gICAjIEBVbml4U29j
a2V0QWRkcmVzczoNCj4+IGRpZmYgLS1naXQgYS91dGlsL3FlbXUtc29ja2V0cy5jIGIvdXRpbC9x
ZW11LXNvY2tldHMuYw0KPj4gaW5kZXggODg1MGEyODBhOC4uOWM4NDJjNGE5MyAxMDA2NDQNCj4+
IC0tLSBhL3V0aWwvcWVtdS1zb2NrZXRzLmMNCj4+ICsrKyBiL3V0aWwvcWVtdS1zb2NrZXRzLmMN
Cj4+IEBAIC00NTcsNiArNDU3LDE5IEBAIGludCBpbmV0X2Nvbm5lY3Rfc2FkZHIoSW5ldFNvY2tl
dEFkZHJlc3MgKnNhZGRyLCBFcnJvciAqKmVycnApDQo+PiAgICAgICB9DQo+PiAgIA0KPj4gICAg
ICAgZnJlZWFkZHJpbmZvKHJlcyk7DQo+PiArDQo+PiArICAgIGlmIChzYWRkci0+a2VlcF9hbGl2
ZSkgew0KPj4gKyAgICAgICAgaW50IHZhbCA9IDE7DQo+PiArICAgICAgICBpbnQgcmV0ID0gcWVt
dV9zZXRzb2Nrb3B0KHNvY2ssIFNPTF9TT0NLRVQsIFNPX0tFRVBBTElWRSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJnZhbCwgc2l6ZW9mKHZhbCkpOw0KPj4gKw0KPj4g
KyAgICAgICAgaWYgKHJldCA8IDApIHsNCj4+ICsgICAgICAgICAgICBlcnJvcl9zZXRnX2Vycm5v
KGVycnAsIGVycm5vLCAiVW5hYmxlIHRvIHNldCBLRUVQQUxJVkUiKTsNCj4+ICsgICAgICAgICAg
ICBjbG9zZShzb2NrKTsNCj4+ICsgICAgICAgICAgICByZXR1cm4gLTE7DQo+PiArICAgICAgICB9
DQo+PiArICAgIH0NCj4+ICsNCj4+ICAgICAgIHJldHVybiBzb2NrOw0KPj4gICB9DQo+PiAgIA0K
Pj4gQEAgLTY1Miw2ICs2NjUsMTUgQEAgaW50IGluZXRfcGFyc2UoSW5ldFNvY2tldEFkZHJlc3Mg
KmFkZHIsIGNvbnN0IGNoYXIgKnN0ciwgRXJyb3IgKiplcnJwKQ0KPj4gICAgICAgICAgIH0NCj4+
ICAgICAgICAgICBhZGRyLT5oYXNfaXB2NiA9IHRydWU7DQo+PiAgICAgICB9DQo+PiArICAgIGJl
Z2luID0gc3Ryc3RyKG9wdHN0ciwgIixrZWVwLWFsaXZlIik7DQo+PiArICAgIGlmIChiZWdpbikg
ew0KPj4gKyAgICAgICAgaWYgKGluZXRfcGFyc2VfZmxhZygia2VlcC1hbGl2ZSIsIGJlZ2luICsg
c3RybGVuKCJrZWVwLWFsaXZlPSIpLA0KPiANCj4gU2hvdWxkbid0IHlvdSB1c2Ugc3RybGVuKCIs
a2VlcC1hbGl2ZSIpPw0KDQpIbW0geWVzLg0KDQo+IA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmYWRkci0+a2VlcF9hbGl2ZSwgZXJycCkgPCAwKQ0KPj4gKyAgICAgICAgew0KPj4g
KyAgICAgICAgICAgIHJldHVybiAtMTsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgICAgIGFkZHIt
Pmhhc19rZWVwX2FsaXZlID0gdHJ1ZTsNCj4+ICsgICAgfQ0KPj4gICAgICAgcmV0dXJuIDA7DQo+
PiAgIH0NCg0KVGhhbmtzIGZvciByZXZpZXdpbmcsIEknbGwgcmVzZW5kIHNvb24uDQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

