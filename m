Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8CCC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F20216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MfGfBlIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F20216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49219 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRdbf-0002Zp-B0
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 10:13:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRdY8-0000b7-Om
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRdY7-00022e-OI
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:09:28 -0400
Received: from mail-eopbgr150124.outbound.protection.outlook.com
	([40.107.15.124]:9536
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hRdY4-0001sc-Ty; Fri, 17 May 2019 10:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=kFSuzQE1o2314ljW+Lkzz5xMfeBD7yr3Fx8wBRynHo4=;
	b=MfGfBlIGldZg++kTvtxfppBUBtvlKSnon1P/2mCcMXIyYQy+U3Rprh9k13O8hJeANonoKgtyFs8s91Nmn9bm7v89jXAXzdEUZlMOabLXOzfqYfitesZMl+4d8GAnSOmI6R52KkZNSFlbZYmYD8GHLjgEEQ1Gl0QRoAf+O7nUBOY=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB4310.eurprd08.prod.outlook.com (20.179.5.205) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Fri, 17 May 2019 14:09:21 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Fri, 17 May 2019 14:09:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 1/2] qapi: support external bitmaps in
	block-dirty-bitmap-merge
Thread-Index: AQHVC+K+LXslWDoYQ06qoTk12qYFn6ZueC8AgADfJoCAAAUigA==
Date: Fri, 17 May 2019 14:09:21 +0000
Message-ID: <efe6d8d3-ba5f-88f6-c8b0-d4037ba678e2@virtuozzo.com>
References: <20190516122725.132334-1-vsementsov@virtuozzo.com>
	<20190516122725.132334-2-vsementsov@virtuozzo.com>
	<04af0995-a4ef-d9cc-b4ca-1a5e837aafe1@redhat.com>
	<2f7d9ea8-765b-fad1-36d5-225f3b4b2ccc@redhat.com>
In-Reply-To: <2f7d9ea8-765b-fad1-36d5-225f3b4b2ccc@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0042.eurprd02.prod.outlook.com
	(2603:10a6:3:e4::28) To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190517170919356
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d96d0c7-d40a-40b3-4a0a-08d6dad14222
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB4310; 
x-ms-traffictypediagnostic: AM6PR08MB4310:
x-microsoft-antispam-prvs: <AM6PR08MB431037C353FEDE527DFFBBE6C10B0@AM6PR08MB4310.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:299;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(136003)(39850400004)(396003)(376002)(189003)(199004)(54906003)(256004)(110136005)(71190400001)(71200400001)(229853002)(5660300002)(11346002)(446003)(2616005)(76176011)(476003)(486006)(25786009)(6246003)(2501003)(4326008)(2201001)(86362001)(52116002)(186003)(99286004)(31696002)(102836004)(14454004)(386003)(6506007)(53546011)(31686004)(81166006)(81156014)(8676002)(8936002)(2906002)(26005)(316002)(6116002)(3846002)(53936002)(478600001)(66446008)(64756008)(66556008)(66476007)(73956011)(6512007)(66946007)(6436002)(36756003)(66066001)(68736007)(305945005)(6486002)(7736002)(14143004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4310;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZjuRfGO6nww7psTKl0nmYN4p4u3nvwSe4gSYBcZnyQxD95RByfj+FFoSYzUBDf5Km7PXXAdDGS2hAUOdsGT/pqZ43wl9GnzHht8AB7UT+yAVzkaSEwHrIGnfMXN1EJ+WFt9lEoqY9+2LrC7maFs6O6uuOAW5Ri1Tsucs2hvx5zwb1yQHZNHWBwx5yxxRack+HNfXODK8z2EMPEk4ppEvtD0MMnoRWMDBVXqQ1Z2ZMim0HJZEEzf/gzYjIVGrlrA2hy50/dJ8kBiow+ZH4lU8N8RBztNlwwCVufxtJm4vrSVCN0/8aYubkfpiPk4AoEBB7W6XYZHnjcgcW8Xwn6uLkuuZqnxfhmm1mjVbLPeyuXsaxJZSNQVM5OwAkJkI7pOFLaHtB+HuZ3ix7O4C7EF/CO6Vqw4i1aMj2qqU+TXo1fQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8D043891BDAAF4692C3CCA61A600DF1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d96d0c7-d40a-40b3-4a0a-08d6dad14222
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 14:09:21.5845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4310
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.124
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: support external bitmaps in
 block-dirty-bitmap-merge
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
	"mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	"armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTcuMDUuMjAxOSAxNjo1MCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gNS8xNi8xOSA3OjMyIFBN
LCBKb2huIFNub3cgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDUvMTYvMTkgODoyNyBBTSwgVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+PiBBZGQgbmV3IG9wdGlvbmFsIHBhcmFt
ZXRlciBtYWtpbmcgcG9zc2libGUgdG8gbWVyZ2UgYml0bWFwcyBmcm9tDQo+Pj4gZGlmZmVyZW50
IG5vZGVzLiBJdCBpcyBuZWVkZWQgdG8gbWFpbnRhaW4gZXh0ZXJuYWwgc25hcHNob3RzIGR1cmlu
Zw0KPj4+IGluY3JlbWVudGFsIGJhY2t1cCBjaGFpbiBoaXN0b3J5Lg0KPj4+DQo+Pj4gU2lnbmVk
LW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96
em8uY29tPg0KPj4+IC0tLQ0KPj4+ICAgcWFwaS9ibG9jay1jb3JlLmpzb24gfCAxMyArKysrKysr
KysrLS0tDQo+Pj4gICBibG9jay9kaXJ0eS1iaXRtYXAuYyB8ICA5ICsrKysrKy0tLQ0KPj4+ICAg
YmxvY2tkZXYuYyAgICAgICAgICAgfCA0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLQ0KPj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspLCAy
MCBkZWxldGlvbnMoLSkNCj4gDQo+Pj4gLSMgQGJpdG1hcHM6IG5hbWUocykgb2YgdGhlIHNvdXJj
ZSBkaXJ0eSBiaXRtYXAocykNCj4+PiArIyBAYml0bWFwczogbmFtZShzKSBvZiB0aGUgc291cmNl
IGRpcnR5IGJpdG1hcChzKS4gVGhlIGZpZWxkIGlzIG9wdGlvbmFsDQo+Pj4gKyMgICAgICAgICAg
IHNpbmNlIDQuMS4NCj4+PiArIw0KPj4+ICsjIEBleHRlcm5hbC1iaXRtYXBzOiBhZGRpdGlvbmFs
IGxpc3Qgb2Ygc291cmNlIGRpcnR5IGJpdG1hcHMgd2l0aCBzcGVjaWZpZWQNCj4+PiArIyAgICAg
ICAgICAgICAgICAgICAgbm9kZXMsIHdoaWNoIGFsbG93cyBtZXJnaW5nIGJpdG1hcHMgYmV0d2Vl
biBkaWZmZXJlbnQNCj4+PiArIyAgICAgICAgICAgICAgICAgICAgbm9kZXMuIChTaW5jZTogNC4x
KQ0KPj4+ICAgIw0KPj4+ICAgIyBTaW5jZTogNC4wDQo+Pj4gICAjIw0KPj4+ICAgeyAnc3RydWN0
JzogJ0Jsb2NrRGlydHlCaXRtYXBNZXJnZScsDQo+Pj4gLSAgJ2RhdGEnOiB7ICdub2RlJzogJ3N0
cicsICd0YXJnZXQnOiAnc3RyJywgJ2JpdG1hcHMnOiBbJ3N0ciddIH0gfQ0KPj4+ICsgICdkYXRh
JzogeyAnbm9kZSc6ICdzdHInLCAndGFyZ2V0JzogJ3N0cicsICcqYml0bWFwcyc6IFsnc3RyJ10s
DQo+Pj4gKyAgICAgICAgICAgICcqZXh0ZXJuYWwtYml0bWFwcyc6IFsnQmxvY2tEaXJ0eUJpdG1h
cCddIH0gfQ0KPj4+ICAgDQo+Pg0KPj4gSSBndWVzcyB5b3UgY2FuIHNwZWNpZnkgb25lLCBvciBi
b3RoLCBvciBtYXliZSBuZWl0aGVyISBTZWVtcyBmaW5lLg0KPiANCj4gDQo+Pg0KPj4gSSBkb24n
dCB0aGluayBJIGxpa2UgdGhlIG5hbWUgImV4dGVybmFsLWJpdG1hcHMiIGJ1dCBJIGd1ZXNzIEkg
ZG9uJ3QNCj4+IHJlYWxseSBoYXZlIGEgYmV0dGVyIHN1Z2dlc3Rpb24uDQo+IA0KPiBJIGRvIC0g
d2UgY291bGQgdXNlIGFuIGFsdGVybmF0ZSB0eXBlIGluc3RlYWQ6DQo+IA0KPiB7ICdhbHRlcm5h
dGUnOiAnQml0bWFwU291cmNlJywNCj4gICAgJ2RhdGEnOiB7ICdsb2NhbCc6ICdzdHInLA0KPiAg
ICAgICAgICAgICAgICdleHRlcm5hbCc6ICdCbG9ja0RpcnR5Qml0bWFwJyB9IH0NCj4gDQo+IHRo
ZW4gdXNlICdiaXRtYXBzJzogWydCaXRtYXBTb3VyY2UnXQ0KPiANCj4gc28gdGhhdCB0aGUgY2Fs
bGVyIGNhbiBwYXNzOg0KPiANCj4gImJpdG1hcHMiOiBbICJiaXRtYXAxIiwgeyAibm9kZSI6ICJv
dGhlciIsICJuYW1lIiwgImJpdG1hcDIiIH0gXQ0KPiANCj4gYW5kIHdlIG9ubHkgaGF2ZSB0byBk
ZWFsIHdpdGggb25lIGFycmF5IGF0IGFsbCB0aW1lcywgYW5kIG5vdCBoYXZlIHRoZQ0KPiBuYW1l
ICdleHRlcm5hbC1iaXRtYXBzJyB0byB3b3JyeSBhYm91dC4NCj4gDQoNCk9oLCBJIHdhbnRlZCB0
byBkbyBzb21ldGhpbmcgbGlrZSB0aGlzLCBidXQgbG9va2VkIGF0IHVuaW9uIHR5cGUsICB3aGlj
aCBhbHNvIG5lZWRzIHNvbWUNCmRpc2NyaW1pbmF0b3IgZmllbGQsIGFuZCBkZWNpZGVkIHRoYXQg
aXQncyBpbXBvc3NpYmxlIHRvIG1ha2UgaXQgYmFja3dhcmQtY29tcGF0aWJsZS4NCg0KV2lsbCBy
ZXNlbmQuDQoNCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

