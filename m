Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454C0C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:46:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 048A22081C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IfmU4c6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048A22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46188 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVFx0-0002RE-8a
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 09:46:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hVFw2-00020O-7Z
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hVFw1-00065n-5t
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:45:06 -0400
Received: from mail-eopbgr150131.outbound.protection.outlook.com
	([40.107.15.131]:52223
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hVFw0-00064Q-F4; Mon, 27 May 2019 09:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=573ZiI97sUVj2+QjOZmknTk58wGcAgZ2nJyOvhD6gEM=;
	b=IfmU4c6PnHSadFSWBgPtuq6pmZ/LeQ8wLGH494hb/omRCoxDMh+Xu1jJpqu03vvynx71zicAmWIDbI8sSmVbr7NTOgjMK/F3Ae+T5+IQ1Z5bRW99UElDOqTysqIEXAFDW9jMlk426EmHpa+UyT5jmEzolRmEknsx2ojoXQOH604=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
	VI1PR08MB3344.eurprd08.prod.outlook.com (52.134.31.143) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.16; Mon, 27 May 2019 13:45:00 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::48f:a107:e2ac:a28f]) by VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::48f:a107:e2ac:a28f%7]) with mapi id 15.20.1922.021;
	Mon, 27 May 2019 13:45:00 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [RFC 1/3] block: Add ImageRotationalInfo
Thread-Index: AQHVElYaNeWkB4e29kOaOTWl7gcWHaZ9hPYAgAFigICAAAXOgIAABZ8AgAANLoA=
Date: Mon, 27 May 2019 13:44:59 +0000
Message-ID: <80167166-a23a-6f10-c28b-a3a905f7ca6e@virtuozzo.com>
References: <20190524172812.27308-1-mreitz@redhat.com>
	<20190524172812.27308-2-mreitz@redhat.com>
	<w51ef4ljlt7.fsf@maestria.local.igalia.com>
	<66e86c16-c30c-5363-ef94-f01da8979872@redhat.com>
	<w515zpwrs30.fsf@maestria.local.igalia.com>
	<92b7c22d-06bb-f04a-0df1-7340c11be954@redhat.com>
In-Reply-To: <92b7c22d-06bb-f04a-0df1-7340c11be954@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0060.eurprd07.prod.outlook.com
	(2603:10a6:3:9e::28) To VI1PR08MB4078.eurprd08.prod.outlook.com
	(2603:10a6:803:e5::28)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 726360c0-98a6-43d8-209d-08d6e2a9830e
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:VI1PR08MB3344; 
x-ms-traffictypediagnostic: VI1PR08MB3344:
x-microsoft-antispam-prvs: <VI1PR08MB3344BF8691DA454689E7D6FBF81D0@VI1PR08MB3344.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(396003)(346002)(136003)(366004)(39850400004)(189003)(199004)(52314003)(107886003)(71190400001)(66066001)(71200400001)(6506007)(6246003)(66476007)(102836004)(76176011)(14444005)(25786009)(229853002)(31686004)(52116002)(386003)(73956011)(53546011)(316002)(68736007)(256004)(66946007)(99286004)(6436002)(53936002)(14454004)(110136005)(478600001)(54906003)(4326008)(36756003)(6486002)(44832011)(6512007)(2616005)(66446008)(486006)(476003)(446003)(11346002)(2906002)(2501003)(66556008)(186003)(86362001)(7736002)(26005)(5660300002)(3846002)(6116002)(64756008)(305945005)(31696002)(81156014)(81166006)(8936002)(8676002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3344;
	H:VI1PR08MB4078.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dOK/BZrvwZr0nchLVW8637DnrWjKqkL0zNh7IlYJBPO3C2GwakRvFm8Pq3m92X3kTD3dzDQ1LC6kGiNo0tj9XfBr71qmUvn4dqxMMLlvrdnM25W+sWU+GShXIKaHErhRT/5idvTW2IHk9iUfcBrUmGUIC5wFbQW3cxcAVUSOk5jHW4HzQvhvrLgDO/NtpUnMILoQDc0lXzl87dUDW+KTBXGtuIJ9Fdwl8hPNmjf8py11A2yQ+qg42XyO5RH4fqlvebEPPlBkkNGEtxBJ4usepDD3O5d4+Zz2UV5qHfkokv1sejSynOEoj8u56RmSRDLInpql2pARE9WxL9/bgHl9lhbBKiiASVGVmtdBDhzknztZkbhxwkX5liD5GnNkpnRN4Ul3kvI+nEQmnJkcnEeIUzAC1insz+1TBBwQW+fR18U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC4F599218301C4AB9683BE63E76373A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726360c0-98a6-43d8-209d-08d6e2a9830e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 13:44:59.9043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anton.nefedov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3344
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.131
Subject: Re: [Qemu-devel] [RFC 1/3] block: Add ImageRotationalInfo
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMjcvNS8yMDE5IDM6NTcgUE0sIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMjcuMDUuMTkgMTQ6
MzcsIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPj4gT24gTW9uIDI3IE1heSAyMDE5IDAyOjE2OjUz
IFBNIENFU1QsIE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAyNi4wNS4xOSAxNzowOCwgQWxiZXJ0
byBHYXJjaWEgd3JvdGU6DQo+Pj4+IE9uIEZyaSAyNCBNYXkgMjAxOSAwNzoyODoxMCBQTSBDRVNU
LCBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPiB3cm90ZToNCj4+Pj4+ICsjIw0KPj4+Pj4g
KyMgQEltYWdlUm90YXRpb25hbEluZm86DQo+Pj4+PiArIw0KPj4+Pj4gKyMgSW5kaWNhdGVzIHdo
ZXRoZXIgYW4gaW1hZ2UgaXMgc3RvcmVkIG9uIGEgcm90YXRpbmcgZGlzayBvciBub3QuDQo+Pj4+
PiArIw0KPj4+Pj4gKyMgQHNvbGlkLXN0YXRlOiBJbWFnZSBpcyBzdG9yZWQgb24gYSBzb2xpZC1z
dGF0ZSBkcml2ZQ0KPj4+Pj4gKyMNCj4+Pj4+ICsjIEByb3RhdGluZzogICAgSW1hZ2UgaXMgc3Rv
cmVkIG9uIGEgcm90YXRpbmcgZGlzaw0KPj4+Pg0KPj4+PiBXaGF0IGhhcHBlbnMgd2hlbiB5b3Ug
Y2Fubm90IHRlbGw/IFlvdSBhc3N1bWUgaXQncyBzb2xpZC1zdGF0ZT8NCj4+Pg0KPj4+IFdoZW4g
KkkqIGNhbm5vdCB0ZWxsPyAgVGhpcyBmaWVsZCBpcyBnZW5lcmFsbHkgb3B0aW9uYWwsIHNvIGlu
IHRoYXQgY2FzZQ0KPj4+IGl0IGp1c3Qgd2lsbCBub3QgYmUgcHJlc2VudC4NCj4+Pg0KPj4+IChX
aGVuIExpbnV4IGNhbm5vdCB0ZWxsPyAgSSBkb27igJl0IGtub3cgOi0pKQ0KPj4+DQoNCkxpbnV4
IGRlZmF1bHRzIHRvIHJvdGF0aW9uYWwgPT0gMSB1bmxlc3MgdGhlIGRyaXZlciBzZXRzDQpRVUVV
RV9GTEFHX05PTlJPVC4NCg0KQnkgdGhlIHdheSBhcyBmYXIgYXMgSSBjYW4gdGVsbCwgcWVtdSBk
b2VzIG5vdCByZXBvcnQgdGhpcyBmbGFnIHVubGVzcw0KZXhwbGljaXRseSBzZXQgaW4gYSBkZXZp
Y2UgcHJvcGVydHkuDQoNCiAgICAgREVGSU5FX1BST1BfVUlOVDE2KCJyb3RhdGlvbl9yYXRlIiwg
SURFRHJpdmUsIGRldi5yb3RhdGlvbl9yYXRlLCAwKSwNCmFuZA0KICAgICBERUZJTkVfUFJPUF9V
SU5UMTYoInJvdGF0aW9uX3JhdGUiLCBTQ1NJRGlza1N0YXRlLCByb3RhdGlvbl9yYXRlLCAwKSwN
Cg0KPj4+IERvIHlvdSB0aGluayB0aGVyZSBzaG91bGQgYmUgYW4gZXhwbGljaXQgdmFsdWUgZm9y
IHRoYXQ/DQo+Pg0KPj4gSSdsbCB0cnkgdG8gcmVwaHJhc2U6DQo+Pg0KPj4gd2UgaGF2ZSBhIG5l
dyBvcHRpbWl6YXRpb24gdGhhdCBpbXByb3ZlcyBwZXJmb3JtYW5jZSBvbiBTU0RzIGJ1dCByZWR1
Y2VzDQo+PiBwZXJmb3JtYW5jZSBvbiBIRERzLCBzbyB0aGlzIHNlcmllcyB3b3VsZCBkZXRlY3Qg
d2hlcmUgYW4gaW1hZ2UgaXMNCj4+IHN0b3JlZCBpbiBvcmRlciB0byBlbmFibGUgdGhlIGZhc3Rl
ciBjb2RlIHBhdGggZm9yIGVhY2ggY2FzZS4NCj4+DQo+PiBXaGF0IGhhcHBlbnMgaWYgUUVNVSBj
YW5ub3QgZGV0ZWN0IGlmIHdlIGhhdmUgYSBzb2xpZCBkcml2ZSBvciBhDQo+PiByb3RhdGlvbmFs
IGRyaXZlPyAoZS5nLiBhIHJlbW90ZSBzdG9yYWdlIGJhY2tlbmQpLiBXaWxsIGl0IGRlZmF1bHQg
dG8NCj4+IGVuYWJsaW5nIHByZWFsbG9jYXRpb24gdXNpbmcgd3JpdGVfemVyb2VzKCk/DQo+IA0K
PiBJbiB0aGlzIHNlcmllcywgeWVzLiAgVGhhdCBpcyB0aGUgZGVmYXVsdCBJIGNob3NlLg0KPiAN
Cj4gV2UgaGF2ZSB0byBtYWtlIGEgc2VwYXJhdGUgZGVjaXNpb24gZm9yIGVhY2ggY2FzZS4gIElu
IHRoZSBjYXNlIG9mDQo+IGZpbGxpbmcgbmV3bHkgYWxsb2NhdGVkIGFyZWFzIHdpdGggemVyb2Vz
LCBJIHRoaW5rIHRoZSBwZXJmb3JtYW5jZSBnYWluDQo+IGZvciBTU0RzIGlzIG1vcmUgaW1wb3J0
YW50IHRoYW4gdGhlIHBlcmZvcm1hbmNlIGxvc3MgZm9yIEhERHMuICBUaGF0IGlzDQo+IHdoYXQg
SSB3cm90ZSBpbiBteSByZXNwb25zZSB0byBBbnRvbuKAmXMgc2VyaWVzLiAgU28gSSB0b29rIHRo
ZSBzZXJpZXMNCj4gZXZlbiB3aXRob3V0IGl0IGJlaW5nIGFibGUgdG8gZGlzdGluZ3Vpc2ggYm90
aCBjYXNlcyBhdCBhbGwuDQo+IENvbnNlcXVlbnRpYWxseSwgSSBiZWxpZXZlIGl0IGlzIHJlYXNv
bmFibGUgZm9yIHRoYXQgdG8gYmUgdGhlIGRlZmF1bHQNCj4gYmVoYXZpb3IgaWYgd2UgY2Fubm90
IHRlbGwuDQo+IA0KPiBJIHRoaW5rIGluIGdlbmVyYWwgb3B0aW1pemluZyBmb3IgU1NEcyBzaG91
bGQgcHJvYmFibHkgYmUgdGhlIGRlZmF1bHQuDQo+IEhERHMgYXJlIHNsb3cgYW55d2F5LCBzbyB3
aG9ldmVyIHVzZXMgdGhlbSBwcm9iYWJseSBkb2VzbuKAmXQgY2FyZSBhYm91dA0KPiBwZXJmb3Jt
YW5jZSB0b28gbXVjaCBhbnl3YXkuLi4/ICBXaGVyZWFzIHBlb3BsZSB1c2luZyBTU0RzIHByb2Jh
Ymx5IGRvLg0KPiAgIEJ1dCBhcyBJIHNhaWQsIHdlIGNhbiBhbmQgc2hvdWxkIGFsd2F5cyBtYWtl
IGEgc2VwYXJhdGUgZGVjaXNpb24gZm9yDQo+IGVhY2ggY2FzZS4NCj4gDQoNCk92ZXJhbGwgaXQg
bG9va3MgZ29vZCB0byBtZSBidXQgSSB3b25kZXIgaG93IGRvIHdlIGVuc3VyZSBib3RoIHZhcmlh
bnRzDQphcmUgdGVzdCBjb3ZlcmVkPyBOZWVkIGEgYmxvY2tkZXYgb3B0aW9uIHRvIGVuZm9yY2Ug
dGhlIG1vZGU/DQoNCi9BbnRvbg0K

