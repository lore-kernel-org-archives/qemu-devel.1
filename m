Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3313BC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9CF02187F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dKTyhoht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CF02187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMUk-0001KG-4B
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iSMT5-0000Sw-Aq
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iSMT3-0007vH-K3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:39:31 -0500
Received: from mail-eopbgr80107.outbound.protection.outlook.com
 ([40.107.8.107]:4261 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iSMSz-0007t4-GP; Wed, 06 Nov 2019 09:39:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f17mcwi0lGQRuzUTzdZdTUx/KQ5pgwkvzTfmCygr5uauCExsyr6//Oi1lCNN7gc2xjLOh8JHjGZ/4RTq8y52zBEvUJEZsJRvr6wdD8Sr0mJBWrvvN2UOSwrLh/L0XcxHstl8NwEJMqa/8fCSo4QolvtH5FwPEiCJAQlmwrk0pELZQc7Znuz/MfkYArBRWDoOcKqto+7FvH6pqReSjx2pr4lSfnUX6WPf22POIo8fc0nVxrL0xVTQy2E7VGdyM/8cuPOK2XVdFObbOm97PpV0fHtjKgBEJ0UNEg5Rq/9vlTwWYDQJPTIu5AfdKZaa6JTumkGg8Ccz3dIfqLDgZvjlRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nip0GMk9HmeqDX5n2QwbCa1eBMhWK8hBtvXDYHirwaw=;
 b=KEoWGq/63KUqULbKzx/uyMPw9ZNO1MVD8Fyr2VEtaPo7ozdVwIL0rTupP3AYnvIQqtEu6srYKBgMyDoknyDMo22vEc7H18j3xe2qx7YOCU0Wivs/eVW2TxhWKYlN4Qk1YXQGMQ0kscGjEWctX3yqT5+OMZRR00BAfRUY9xV9Cu6PETOuc2C0KzPgQCrgrfKbBAZB9S3ASdRVuYijAWat//9V+mU+LUkeFAhG/osz/vfiumJVXj6IuUaEGFNMekcp4GSSeMIHluxSiXjk/l4XEVsm6/PlJvMtplZLtNp9HPlsAc5oX/1nPg47GFB47qibVey2XrMBfKUCusX7tZ4W3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nip0GMk9HmeqDX5n2QwbCa1eBMhWK8hBtvXDYHirwaw=;
 b=dKTyhohtzZhKQfNTcQKmmEgGNgAsEUX7y9ap1b7tax54OOS90nIfpvxF4x7//FGgmWsb3A6OXbJMmGRCw7tFbQrAwJwQILMzHD3jYm/7mGvac02mmyziwLtjlnNMBbWeHBvSzUsEHRnIvybRZn/Kxd6Qw4KsjnyNKEdgBj7raRw=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB4514.eurprd08.prod.outlook.com (20.179.32.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 14:39:22 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946%3]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 14:39:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Dietmar Maurer <dietmar@proxmox.com>,
 Wolfgang Bumiller <w.bumiller@proxmox.com>
Subject: Re: backup_calculate_cluster_size does not consider source
Thread-Topic: backup_calculate_cluster_size does not consider source
Thread-Index: AQHVk8F1BgSk/pv/Q0S0O/H9oExXNqd90egAgAASEwCAABAkAIAAAhQAgAAJ/ACAAAFhAIAABBkAgAAZtYCAAAIoAIAABK6AgAAFBYCAAA02AA==
Date: Wed, 6 Nov 2019 14:39:22 +0000
Message-ID: <cb11704d-89b1-f0b4-f64c-9355e83a8838@virtuozzo.com>
References: <1767781109.66.1572948164492@webmail.proxmox.com>
 <20191106083222.GA189998@stefanha-x1.localdomain>
 <ac30110f-6abe-a144-2aa5-b1cc140d7e8c@redhat.com>
 <20191106103450.cafwk7m5xd5eulxo@olga.proxmox.com>
 <37f72cb7-7085-3c40-7728-e41d59137b3b@redhat.com>
 <1868807950.27.1573039080274@webmail.proxmox.com>
 <eb3a232d-6567-1816-b7fc-121770aa42b4@redhat.com>
 <6684852e-da7d-13b2-f226-1c0074e4ab3b@redhat.com>
 <396057714.35.1573045777293@webmail.proxmox.com>
 <2bd155fe-af04-05f2-0bd4-28e844564fc4@redhat.com>
 <1098165569.40.1573047245058@webmail.proxmox.com>
 <62bb451e-6b8a-d842-e07c-9f78a6971450@redhat.com>
In-Reply-To: <62bb451e-6b8a-d842-e07c-9f78a6971450@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0036.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::46) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191106173920392
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b10c5888-1742-4641-dbbc-08d762c71d34
x-ms-traffictypediagnostic: AM0PR08MB4514:
x-microsoft-antispam-prvs: <AM0PR08MB4514A147FC0D438BD4DE5574C1790@AM0PR08MB4514.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(346002)(366004)(396003)(376002)(199004)(189003)(52084003)(64756008)(6486002)(229853002)(66556008)(66446008)(14454004)(102836004)(53546011)(386003)(8936002)(31686004)(26005)(81156014)(8676002)(36756003)(52116002)(76176011)(99286004)(486006)(7736002)(66476007)(478600001)(66066001)(6512007)(476003)(11346002)(81166006)(186003)(2616005)(446003)(54906003)(110136005)(316002)(6436002)(305945005)(25786009)(6246003)(3846002)(14444005)(256004)(6116002)(2906002)(5660300002)(71190400001)(71200400001)(4326008)(86362001)(6506007)(66946007)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4514;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0A8e8BzMmC5LSa6Xy1kjhT3OV9VL1hASm5Pqa36v0R9+4RFliNAPowxWeSob6OfX6F8j0v1wCZsdA5BL0BR4izmpog/Vls8YUvKUs0AcdXuIX7abt/bWtpwirkbFVESpsoCTEbJ58xSlVr2zQvTaiCBAUmUmm4U6idyZj/cGCJ7KgM9jvCGu4w+xX0L3WZ1wdzE/9IkdZpS4b/VmgLiKz/nYwj9PHvHjVXaEUv0EmzHm9jzvWKiIhq4dIz09jq/NBqBgj//4dPML6pMA1eZxlZmZqYWndR7jwz6SL7waITNiETkNMnOnYznJzC9yyN5T93gCC7PtJjW7m9niT+SlFcXm4T6bQsv9mo4DuoTLGw9IQkx904TUZBGdgu9Ro+l8jxNfsmNwcfpcqMFB6e9fsWh4xU+YqTgnFMhBUyPE2jV6DGmD+vdiIHDsXiVKusfG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <190A6A869D44E549903E767ED0C3E4B1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10c5888-1742-4641-dbbc-08d762c71d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 14:39:22.5411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MvFiClMQG6FSUYdD46eZwWHXNmRlJA2fhQyQIcNMdg2ukeCZ4LFU1qgYytmVqCjAsEi4U04pJ0IyuQOO1aOVXqRkafz2FojWtc6Ci5rm2i0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4514
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.107
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMTEuMjAxOSAxNjo1MiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwNi4xMS4xOSAxNDozNCwg
RGlldG1hciBNYXVyZXIgd3JvdGU6DQo+Pg0KPj4+IE9uIDYgTm92ZW1iZXIgMjAxOSAxNDoxNyBN
YXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPiB3cm90ZToNCj4+Pg0KPj4+ICAgDQo+Pj4gT24g
MDYuMTEuMTkgMTQ6MDksIERpZXRtYXIgTWF1cmVyIHdyb3RlOg0KPj4+Pj4gTGV0IG1lIGVsYWJv
cmF0ZTogWWVzLCBhIGNsdXN0ZXIgc2l6ZSBnZW5lcmFsbHkgbWVhbnMgdGhhdCBpdCBpcyBtb3N0
DQo+Pj4+PiDigJxlZmZpY2llbnTigJ0gdG8gYWNjZXNzIHRoZSBzdG9yYWdlIGF0IHRoYXQgc2l6
ZS4gIEJ1dCB0aGVyZeKAmXMgYSB0cmFkZW9mZi4NCj4+Pj4+ICAgQXQgc29tZSBwb2ludCwgcmVh
ZGluZyB0aGUgZGF0YSB0YWtlcyBzdWZmaWNpZW50bHkgbG9uZyB0aGF0IHJlYWRpbmcgYQ0KPj4+
Pj4gYml0IG9mIG1ldGFkYXRhIGRvZXNu4oCZdCBtYXR0ZXIgYW55bW9yZSAodXN1YWxseSwgdGhh
dCBpcykuDQo+Pj4+DQo+Pj4+IEFueSBuZXR3b3JrIHN0b3JhZ2Ugc3VmZmVycyBmcm9tIGxvbmcg
bmV0d29yayBsYXRlbmNpZXMsIHNvIGl0IGFsd2F5cw0KPj4+PiBtYXR0ZXJzIGlmIHlvdSBkbyBt
b3JlIElPcyB0aGFuIG5lY2Vzc2FyeS4NCj4+Pg0KPj4+IFllcywgZXhhY3RseSwgdGhhdOKAmXMg
d2h5IEnigJltIHNheWluZyBpdCBtYWtlcyBzZW5zZSB0byBtZSB0byBpbmNyZWFzZSB0aGUNCj4+
PiBidWZmZXIgc2l6ZSBmcm9tIHRoZSBtZWFzbHkgNjQga0IgdGhhdCB3ZSBjdXJyZW50bHkgaGF2
ZS4gIEkganVzdCBkb27igJl0DQo+Pj4gc2VlIHRoZSBwb2ludCBvZiBpbmNyZWFzaW5nIGl0IGV4
YWN0bHkgdG8gdGhlIHNvdXJjZSBjbHVzdGVyIHNpemUuDQo+Pj4NCj4+Pj4+IFRoZXJlIGlzIGEg
Yml0IG9mIGEgcHJvYmxlbSB3aXRoIG1ha2luZyB0aGUgYmFja3VwIGNvcHkgc2l6ZSByYXRoZXIN
Cj4+Pj4+IGxhcmdlLCBhbmQgdGhhdCBpcyB0aGUgZmFjdCB0aGF0IGJhY2t1cOKAmXMgY29weS1i
ZWZvcmUtd3JpdGUgY2F1c2VzIGd1ZXN0DQo+Pj4+PiB3cml0ZXMgdG8gc3RhbGwuIFNvIGlmIHRo
ZSBndWVzdCBqdXN0IHdyaXRlcyBhIGJpdCBvZiBkYXRhLCBhIDQgTUINCj4+Pj4+IGJ1ZmZlciBz
aXplIG1heSBtZWFuIHRoYXQgaW4gdGhlIGJhY2tncm91bmQgaXQgd2lsbCBoYXZlIHRvIHdhaXQg
Zm9yIDQNCj4+Pj4+IE1CIG9mIGRhdGEgdG8gYmUgY29waWVkLlsxXQ0KPj4+Pg0KPj4+PiBXZSB1
c2UgdGhpcyBmb3Igc2V2ZXJhbCB5ZWFycyBub3cgaW4gcHJvZHVjdGlvbiwgYW5kIGl0IGlzIG5v
dCBhIHByb2JsZW0uDQo+Pj4+IChDZXBoIHN0b3JhZ2UgaXMgbW9zdGx5IG9uIDEwRyAob3IgZmFz
dGVyKSBuZXR3b3JrIGVxdWlwbWVudCkuDQo+Pj4NCj4+PiBTbyB5b3UgbWVhbiBmb3IgY2FzZXMg
d2hlcmUgYmFja3VwIGFscmVhZHkgY2hvb3NlcyBhIDQgTUIgYnVmZmVyIHNpemUNCj4+PiBiZWNh
dXNlIHRoZSB0YXJnZXQgaGFzIHRoYXQgY2x1c3RlciBzaXplPw0KPj4NCj4+IFRvIG1ha2UgaXQg
Y2xlYXIuIEJhY2t1cHMgZnJvbSBDZXBoIGFzIHNvdXJjZSBhcmUgc2xvdy4NCj4gDQo+IFllcCwg
YnV0IGlmIHRoZSB0YXJnZXQgd291bGQgYmUgYW5vdGhlciBjZXBoIGluc3RhbmNlLCB0aGUgYmFj
a3VwIGJ1ZmZlcg0KPiBzaXplIHdvdWxkIGJlIGNob3NlbiB0byBiZSA0IE1CIChBRkFJVSksIHNv
IEkgd2FzIHdvbmRlcmluZyB3aGV0aGVyIHlvdQ0KPiBhcmUgcmVmZXJyaW5nIHRvIHRoaXMgZWZm
ZWN0LCBvciB0by4uLg0KPiANCj4+IFRoYXQgaXMgd2h5IHdlIHVzZSBhIHBhdGNoZWQgcWVtdSB2
ZXJzaW9uLCB3aGljaCB1c2VzOg0KPj4NCj4+IGNsdXN0ZXJfc2l6ZSA9IE1heF9CbG9ja19TaXpl
KHNvdXJjZSwgdGFyZ2V0KQ0KPiANCj4gLi4udGhpcy4NCj4gDQo+IFRoZSBtYWluIHByb2JsZW0g
d2l0aCB0aGUgc3RhbGwgSSBtZW50aW9uZWQgaXMgdGhhdCBJIHRoaW5rIG9uZSBvZiB0aGUNCj4g
bWFpbiB1c2UgY2FzZXMgb2YgYmFja3VwIGlzIGhhdmluZyBhIGZhc3Qgc291cmNlIGFuZCBhIHNs
b3cgKG9mZi1zaXRlKQ0KPiB0YXJnZXQuICBJbiBzdWNoIGNhc2VzLCBJIHN1cHBvc2UgaXQgYmVj
b21lcyBhbm5veWluZyBpZiBzb21lIGd1ZXN0DQo+IHdyaXRlcyAod2hpY2ggd2VyZSBmYXN0IGJl
Zm9yZSB0aGUgYmFja3VwIHN0YXJ0ZWQpIHRha2UgYSBsb25nIHRpbWUNCj4gYmVjYXVzZSB0aGUg
YmFja3VwIG5lZWRzIHRvIGNvcHkgcXVpdGUgYSBiaXQgb2YgZGF0YSB0byBvZmYtc2l0ZSBzdG9y
YWdlLg0KPiANCj4gKEFuZCBibGluZGx5IHRha2luZyB0aGUgc291cmNlIGNsdXN0ZXIgc2l6ZSB3
b3VsZCBtZWFuIHRoYXQgc3VjaCB0aGluZ3MNCj4gY291bGQgaGFwcGVuIGlmIHlvdSB1c2UgbG9j
YWwgcWNvdzIgZmlsZXMgd2l0aCAyIE1CIGNsdXN0ZXJzLikNCj4gDQo+IA0KPiBTbyBJ4oCZZCBw
cmVmZXIgZGVjb3VwbGluZyB0aGUgYmFja3VwIGJ1ZmZlciBzaXplIGFuZCB0aGUgYml0bWFwDQo+
IGdyYW51bGFyaXR5LCBhbmQgdGhlbiBzZXQgdGhlIGJ1ZmZlciBzaXplIHRvIG1heWJlIHRoZSBN
QVggb2Ygc291cmNlIGFuZA0KPiB0YXJnZXQgY2x1c3RlciBzaXplcy4gIEJ1dCBJIGRvbuKAmXQg
a25vdyB3aGVuIEkgY2FuIGdldCBhcm91bmQgdG8gZG8gdGhhdC4NCg0KTm90ZSwgdGhhdCBwcm9i
bGVtIGlzIG5vdCBvbmx5IGluIGNvcHktYmVmb3JlLXdyaXRlIG9wZXJhdGlvbnM6IGlmIHdlIGhh
dmUgYmlnDQppbi1mbGlnaHQgYmFja3VwIHJlcXVlc3QgZnJvbSBiYWNrdXAgam9iIGl0c2VsZiwg
YWxsIG5ldyB1cGNvbWluZyBndWVzdCB3cml0ZXMNCnRvIHRoaXMgYXJlYSB3aWxsIGhhdmUgdG8g
d2FpdC4NCg0KPiANCj4gQW5kIHRoZW4gcHJvYmFibHkgYWxzbyBjYXAgaXQgYXQgNCBNQiBvciA4
IE1CLCBiZWNhdXNlIHRoYXQgaGFwcGVucyB0bw0KPiBiZSB3aGF0IHlvdSBuZWVkLCBidXQgSeKA
mWQgcHJlZmVyIGZvciBpdCBub3QgdG8gdXNlIHRvbnMgb2YgbWVtb3J5LiAgKFRoZQ0KPiBtaXJy
b3Igam9iIHVzZXMgMSBNQiBwZXIgcmVxdWVzdCwgZm9yIHVwIHRvIDE2IHBhcmFsbGVsIHJlcXVl
c3RzOyBhbmQNCj4gdGhlIGJhY2t1cCBjb3B5LWJlZm9yZS13cml0ZSBpbXBsZW1lbnRhdGlvbiBj
dXJyZW50bHkgKG9uIG1hc3RlcikgY29waWVzDQo+IDEgTUIgYXQgYSB0aW1lIChwZXIgY29uY3Vy
cmVudCByZXF1ZXN0KSwgYW5kIHRoZSB3aG9sZSBtZW1vcnkgdXNhZ2Ugb2YNCj4gYmFja3VwIGlz
IGxpbWl0ZWQgYXQgMTI4IE1CLikNCj4gDQo+IChPVE9ILCB0aGUgbWluaW11bSBzaG91bGQgcHJv
YmFibHkgYmUgMSBNQi4pDQo+IA0KDQpIbW1tLCBJIGFtIHByZXBhcmluZyBhIHBhdGNoIHNldCBh
Ym91dCBiYWNrdXAsIHdoaWNoIGluY2x1ZGVzIGluY3JlYXNpbmcNCm9mIGNvcGllZCBjaHVuayBz
aXplLi4gQW5kIHNvbWVob3cgaXQgbGVhZHMgdG8gcGVyZm9ybWFuY2UgZGVncmFkYXRpb24gb24g
bXkNCmhkZC4NCg0KDQo9PT0NCg0KDQpXaGF0IGFib3V0IHRoZSBmb2xsb3dpbmcgc29sdXRpb246
IGFkZCBlbXB0eSBxY293MiB3aXRoIGNsdXN0ZXJfc2l6ZSA9IDRNIChvaGgsDQoyTSBpcyBtYXhp
bXVtIHVuZm9ydHVuYXRlbHkpIGFib3ZlIGNlcGgsIGVuYWJsZSBjb3B5LW9uLXJlYWQgb24gdGhp
cyBub2RlIGFuZCBzdGFydA0KYmFja3VwIGZyb20gaXQ/IFRoZSBxY293MiBub2RlIHdpbGwgYmUg
YSBsb2NhbCBjYWNoZSwgd2hpY2ggd2lsbCBzb2x2ZSBib3RoIHByb2JsZW0NCndpdGggdW5hbGln
bmVkIHJlYWQgZnJvbSBjZXBoIGFuZCBjb3B5LWJlZm9yZS13cml0ZSB0aW1lPw0KDQotLSANCkJl
c3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

