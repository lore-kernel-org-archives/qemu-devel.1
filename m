Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED969C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A822B2087E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KGD/JZ2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A822B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htaLV-0007hc-0j
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36188)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htaKz-0007Du-OO
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htaKy-0002GJ-3h
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:23:25 -0400
Received: from mail-eopbgr30097.outbound.protection.outlook.com
 ([40.107.3.97]:55426 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1htaKu-0002Dc-9Q; Fri, 02 Aug 2019 12:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRkRrQoHc8K+iqjb7rFdcq8tREbXV+xdUOkCw9Dbog2FpTrbu6JIsL3JSSHnu9TD8MZMzV/AYzfdjw9Z4Aq5N6phb7SSMvELIyejQrcdGPgX8J5W4FK8bjpor2TZzz6+J1P7XnfEedTSGF3DHsy7alaOUDZxL7qdDWyuELfgJBtoZ3HEVZAbkNYQFBra+WT972I1gwcYW6oJn8W16s9eqilHygxeiNw7QvTr7N4/4zYI5yp53lVJ7v1gYNUxSi5pQAB0ovBSwD4ArUcxY0sRlTrMvq4vcL6rfeUo/zW04tHK97gGPEd85Z8GkhvxEW19rWin0IravjMD6FaP+1IAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRvLnCZquY2QedQ5hKD77f7RRXqllhui//9neJuwBV8=;
 b=aAiJEfdwjl4Zuj1P9/7lxZOKxDoOYtPrPfHxEcBOU22Cp+tgoTXR0X6K3U/C9HdFKkwtxhf5iYmBXXdfj4bMAR0DeueAlJlRQnSIep0cT68RwW7Bu7uUnilNTOsRiSuQ7GymItj0jBVuBNjngoKQdUTqxsOFUr8Bw7ewI5CzylvN/Ak/zjKxXvRf0ci7IU0bi75Mzgws3AQRanOP72w/8d+SDcRKZhUfYVylMb5j/triRVbnmtpKw4IkS4bppMmwZORDRPnniOUopmk+4s4aJOncqKS3QyDX8hblfvczoyC5MRqBno4cuWoGOMV3lwrXcmuFGbWKrac25DTBlAt+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRvLnCZquY2QedQ5hKD77f7RRXqllhui//9neJuwBV8=;
 b=KGD/JZ2AH+Y387FEnzVRIedqzYNWBN65joClvSzmcaBtteOxAJyZQZH5HgqnxRrDSV4b5zVpDZqjarbLjgFQp2wGWhMe9Rx2rZiuJYMousja8Hmdj6K4yf2iZaGDRjSja97i6Ja1NcuaB/73iNues66YiNzULio9fJwTyvRA6KE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4187.eurprd08.prod.outlook.com (20.179.9.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Fri, 2 Aug 2019 16:23:14 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 16:23:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Thread-Topic: [PATCH v3 1/9] block: add
 .bdrv_need_rw_file_child_during_reopen_rw handler
Thread-Index: AQHVQsoEzSVYPpC2/ESD+i80Sbskiqbkq/cAgANgXQCAAAs9AA==
Date: Fri, 2 Aug 2019 16:23:13 +0000
Message-ID: <c469c74d-fa4e-b692-ff60-c41d8dcca68d@virtuozzo.com>
References: <20190725091900.30542-1-vsementsov@virtuozzo.com>
 <20190725091900.30542-2-vsementsov@virtuozzo.com>
 <2a105159-ab90-8f7c-bba9-4cec27e6144c@redhat.com>
 <20190802154256.GE6379@localhost.localdomain>
In-Reply-To: <20190802154256.GE6379@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0155.eurprd05.prod.outlook.com
 (2603:10a6:7:28::42) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190802192310585
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78d26aaf-3357-43b7-e9f5-08d71765b79a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4187; 
x-ms-traffictypediagnostic: DB8PR08MB4187:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB4187958BB6FC2D6D9FE0381BC1D90@DB8PR08MB4187.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(446003)(6512007)(66946007)(186003)(14454004)(478600001)(53936002)(66446008)(64756008)(6306002)(8936002)(66556008)(6506007)(102836004)(99286004)(386003)(66476007)(25786009)(36756003)(26005)(31696002)(53546011)(86362001)(2906002)(229853002)(68736007)(107886003)(486006)(110136005)(71200400001)(5660300002)(6436002)(3846002)(52116002)(6486002)(14444005)(81156014)(316002)(476003)(31686004)(4326008)(81166006)(966005)(6116002)(6246003)(8676002)(256004)(11346002)(2616005)(7736002)(66066001)(76176011)(305945005)(71190400001)(54906003)(142923001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4187;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VVCHrGAQ5+FKu3tdYmnNv1Zr6pHcAMezAxy2y/pGvn08TQuuSC/tXKBjwwR+2QDvLRY1uXvPs1lpvb0BEu6Tl7Wqhv/ghxGTQrCjPoBZcI/GA1P7ONrD3CUl2UpdfEM4yEQRVXko0tSQHBGu4cahRPLWqaAim6Uqhi+Vfr9qooMcQkvGWNSdjc6cEgZjFj7AO7DHaCK8ULk+KqTm583IABkDcQCP+CbidlH9D/e2OrcbFjZNI84PBEiFdB53sBq6BCs14Ekfq8WMvp4q1+l6m4zRD/89WKZigVYCjeTKXuzIF7z3nVlQznCTVETp3tWc035/DrUEocVH2b6nJbe3GrGPYPW3p82so6VntGVbIVtFQRXuOFD1m5Vz8GQNvbW5B7UGYUyVa5itt+XDStNPV3DD0I62W36vz/CAwPAy1fo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D58E99D5B9849E469C82DB4F6D801993@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d26aaf-3357-43b7-e9f5-08d71765b79a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 16:23:13.8925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4187
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.97
Subject: Re: [Qemu-devel] [PATCH v3 1/9] block: add
 .bdrv_need_rw_file_child_during_reopen_rw handler
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
Cc: "fam@euphon.net" <fam@euphon.net>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMDguMjAxOSAxODo0MiwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMzEuMDcuMjAxOSB1bSAx
NDowOSBoYXQgTWF4IFJlaXR6IGdlc2NocmllYmVuOg0KPj4gT24gMjUuMDcuMTkgMTE6MTgsIFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gT24gcmVvcGVuIHRvIHJ3IHBh
cmVudCBtYXkgbmVlZCBydyBhY2Nlc3MgdG8gY2hpbGQgaW4gLnByZXBhcmUsIGZvcg0KPj4+IGV4
YW1wbGUgcWNvdzIgbmVlZHMgdG8gd3JpdGUgSU5fVVNFIGZsYWdzIGludG8gc3RvcmVkIGJpdG1h
cHMNCj4+PiAoY3VycmVudGx5IGl0IGlzIGRvbmUgaW4gYSBoYWNreSB3YXkgYWZ0ZXIgY29tbWl0
IGFuZCBkb24ndCB3b3JrKS4NCj4+PiBTbywgbGV0J3MgaW50cm9kdWNlIHN1Y2ggbG9naWMuDQo+
Pj4NCj4+PiBUaGUgZHJhd2JhY2sgaXMgdGhhdCBpbiB3b3JzdCBjYXNlIGJkcnZfcmVvcGVuX3Nl
dF9yZWFkX29ubHkgbWF5IGZpbmlzaA0KPj4+IHdpdGggZXJyb3IgYW5kIGluIHNvbWUgaW50ZXJt
ZWRpYXRlIHN0YXRlOiBzb21lIG5vZGVzIHJlb3BlbmVkIFJXIGFuZA0KPj4+IHNvbWUgYXJlIG5v
dC4gQnV0IHRoaXMgaXMgYSB3YXkgdG8gZml4IGJ1ZyBhcm91bmQgcmVvcGVuaW5nIHFjb3cyDQo+
Pj4gYml0bWFwcyBpbiB0aGUgZm9sbG93aW5nIGNvbW1pdHMuDQo+Pg0KPj4gVGhpcyBjb21taXQg
bWVzc2FnZSBkb2VzbuKAmXQgcmVhbGx5IGV4cGxhaW4gd2hhdCB0aGlzIHBhdGNoIGRvZXMuDQo+
Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1l
bnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+PiAtLS0NCj4+PiAgIGluY2x1ZGUvYmxvY2svYmxvY2tf
aW50LmggfCAgIDIgKw0KPj4+ICAgYmxvY2suYyAgICAgICAgICAgICAgICAgICB8IDE0NCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAxMzMgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaCBiL2luY2x1ZGUvYmxvY2svYmxvY2tfaW50LmgN
Cj4+PiBpbmRleCAzYWExZTgzMmE4Li43YmQ2ZmQ2OGRkIDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1
ZGUvYmxvY2svYmxvY2tfaW50LmgNCj4+PiArKysgYi9pbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5o
DQo+Pj4gQEAgLTUzMSw2ICs1MzEsOCBAQCBzdHJ1Y3QgQmxvY2tEcml2ZXIgew0KPj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBwYXJlbnRfcGVybSwgdWludDY0X3Qg
cGFyZW50X3NoYXJlZCwNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0
X3QgKm5wZXJtLCB1aW50NjRfdCAqbnNoYXJlZCk7DQo+Pj4gICANCj4+PiArICAgICBib29sICgq
YmRydl9uZWVkX3J3X2ZpbGVfY2hpbGRfZHVyaW5nX3Jlb3Blbl9ydykoQmxvY2tEcml2ZXJTdGF0
ZSAqYnMpOw0KPj4+ICsNCj4+PiAgICAgICAvKioNCj4+PiAgICAgICAgKiBCaXRtYXBzIHNob3Vs
ZCBiZSBtYXJrZWQgYXMgJ0lOX1VTRScgaW4gdGhlIGltYWdlIG9uIHJlb3BlbmluZyBpbWFnZQ0K
Pj4+ICAgICAgICAqIGFzIHJ3LiBUaGlzIGhhbmRsZXIgc2hvdWxkIHJlYWxpemUgaXQuIEl0IGFs
c28gc2hvdWxkIHVuc2V0IHJlYWRvbmx5DQo+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrLmMgYi9ibG9j
ay5jDQo+Pj4gaW5kZXggY2JkOGRhNWYzYi4uM2M4ZTFjNTliNCAxMDA2NDQNCj4+PiAtLS0gYS9i
bG9jay5jDQo+Pj4gKysrIGIvYmxvY2suYw0KPj4+IEBAIC0xNzE1LDEwICsxNzE1LDEyIEBAIHN0
YXRpYyB2b2lkIGJkcnZfZ2V0X2N1bXVsYXRpdmVfcGVybShCbG9ja0RyaXZlclN0YXRlICpicywg
dWludDY0X3QgKnBlcm0sDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDY0X3QgKnNoYXJlZF9wZXJtKTsNCj4+PiAgIA0KPj4+ICAgdHlwZWRlZiBzdHJ1Y3Qg
QmxvY2tSZW9wZW5RdWV1ZUVudHJ5IHsNCj4+PiAtICAgICBib29sIHByZXBhcmVkOw0KPj4+IC0g
ICAgIGJvb2wgcGVybXNfY2hlY2tlZDsNCj4+PiAtICAgICBCRFJWUmVvcGVuU3RhdGUgc3RhdGU7
DQo+Pj4gLSAgICAgUVNJTVBMRVFfRU5UUlkoQmxvY2tSZW9wZW5RdWV1ZUVudHJ5KSBlbnRyeTsN
Cj4+PiArICAgIGJvb2wgcmVvcGVuZWRfZmlsZV9jaGlsZF9ydzsNCj4+PiArICAgIGJvb2wgY2hh
bmdlZF9maWxlX2NoaWxkX3Blcm1fcnc7DQo+Pj4gKyAgICBib29sIHByZXBhcmVkOw0KPj4+ICsg
ICAgYm9vbCBwZXJtc19jaGVja2VkOw0KPj4+ICsgICAgQkRSVlJlb3BlblN0YXRlIHN0YXRlOw0K
Pj4+ICsgICAgUVNJTVBMRVFfRU5UUlkoQmxvY2tSZW9wZW5RdWV1ZUVudHJ5KSBlbnRyeTsNCj4+
PiAgIH0gQmxvY2tSZW9wZW5RdWV1ZUVudHJ5Ow0KPj4+ICAgDQo+Pj4gICAvKg0KPj4+IEBAIC0z
NDIxLDYgKzM0MjMsMTA1IEBAIEJsb2NrUmVvcGVuUXVldWUgKmJkcnZfcmVvcGVuX3F1ZXVlKEJs
b2NrUmVvcGVuUXVldWUgKmJzX3F1ZXVlLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBrZWVwX29sZF9vcHRzKTsNCj4+PiAgIH0NCj4+PiAgIA0KPj4+ICtzdGF0aWMg
aW50IGJkcnZfcmVvcGVuX3NldF9yZWFkX29ubHlfZHJhaW5lZChCbG9ja0RyaXZlclN0YXRlICpi
cywNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9v
bCByZWFkX29ubHksDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEVycm9yICoqZXJycCkNCj4+PiArew0KPj4+ICsgICAgQmxvY2tSZW9wZW5RdWV1ZSAq
cXVldWU7DQo+Pj4gKyAgICBRRGljdCAqb3B0cyA9IHFkaWN0X25ldygpOw0KPj4+ICsNCj4+PiAr
ICAgIHFkaWN0X3B1dF9ib29sKG9wdHMsIEJEUlZfT1BUX1JFQURfT05MWSwgcmVhZF9vbmx5KTsN
Cj4+PiArDQo+Pj4gKyAgICBxdWV1ZSA9IGJkcnZfcmVvcGVuX3F1ZXVlKE5VTEwsIGJzLCBvcHRz
LCB0cnVlKTsNCj4+PiArDQo+Pj4gKyAgICByZXR1cm4gYmRydl9yZW9wZW5fbXVsdGlwbGUocXVl
dWUsIGVycnApOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICsvKg0KPj4+ICsgKiBoYW5kbGVfcmVjdXJz
aXZlX3Jlb3BlbnMNCj4+PiArICoNCj4+PiArICogT24gZmFpbCBpdCBuZWVkcyByb2xsYmFja19y
ZWN1cnNpdmVfcmVvcGVucyB0byBiZSBjYWxsZWQuDQo+Pg0KPj4gSXQgd291bGQgYmUgbmljZSBp
ZiB0aGlzIGRlc2NyaXB0aW9uIGFjdHVhbGx5IHNhaWQgYW55dGhpbmcgYWJvdXQgd2hhdA0KPj4g
dGhlIGZ1bmN0aW9uIGlzIHN1cHBvc2VkIHRvIGRvLg0KPj4NCj4+PiArICovDQo+Pj4gK3N0YXRp
YyBpbnQgaGFuZGxlX3JlY3Vyc2l2ZV9yZW9wZW5zKEJsb2NrUmVvcGVuUXVldWVFbnRyeSAqY3Vy
cmVudCwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKipl
cnJwKQ0KPj4+ICt7DQo+Pj4gKyAgICBpbnQgcmV0Ow0KPj4+ICsgICAgQmxvY2tEcml2ZXJTdGF0
ZSAqYnMgPSBjdXJyZW50LT5zdGF0ZS5iczsNCj4+PiArDQo+Pj4gKyAgICAvKg0KPj4+ICsgICAg
ICogV2UgdXNlIHRoZSBmYWN0IHRoYXQgaW4gcmVvcGVuLXF1ZXVlIGNoaWxkcmVuIGFyZSBhbHdh
eXMgZm9sbG93aW5nDQo+Pj4gKyAgICAgKiBwYXJlbnRzLg0KPj4+ICsgICAgICogVE9ETzogU3dp
dGNoIEJsb2NrUmVvcGVuUXVldWUgdG8gYmUgUVRBSUxRIGFuZCB1c2UNCj4+PiArICAgICAqICAg
ICAgIFFUQUlMUV9GT1JFQUNIX1JFVkVSU0UuDQo+Pg0KPj4gV2h5IGRvbuKAmXQgeW91IGRvIHRo
YXQgZmlyc3Q/ICBJdCB3b3VsZCBtYWtlIHRoZSBjb2RlIG1vcmUgb2J2aW91cyBhdA0KPj4gbGVh
c3QgdG8gbWUuDQo+Pg0KPj4+ICsgICAgICovDQo+Pj4gKyAgICBpZiAoUVNJTVBMRVFfTkVYVChj
dXJyZW50LCBlbnRyeSkpIHsNCj4+PiArICAgICAgICByZXQgPSBoYW5kbGVfcmVjdXJzaXZlX3Jl
b3BlbnMoUVNJTVBMRVFfTkVYVChjdXJyZW50LCBlbnRyeSksIGVycnApOw0KPj4+ICsgICAgICAg
IGlmIChyZXQgPCAwKSB7DQo+Pj4gKyAgICAgICAgICAgIHJldHVybiByZXQ7DQo+Pj4gKyAgICAg
ICAgfQ0KPj4+ICsgICAgfQ0KPj4+ICsNCj4+PiArICAgIGlmICgoY3VycmVudC0+c3RhdGUuZmxh
Z3MgJiBCRFJWX09fUkRXUikgJiYgYnMtPmZpbGUgJiYgYnMtPmRydiAmJg0KPj4+ICsgICAgICAg
IGJzLT5kcnYtPmJkcnZfbmVlZF9yd19maWxlX2NoaWxkX2R1cmluZ19yZW9wZW5fcncgJiYNCj4+
PiArICAgICAgICBicy0+ZHJ2LT5iZHJ2X25lZWRfcndfZmlsZV9jaGlsZF9kdXJpbmdfcmVvcGVu
X3J3KGJzKSkNCj4+PiArICAgIHsNCj4+PiArICAgICAgICBpZiAoIWJkcnZfaXNfd3JpdGFibGUo
YnMtPmZpbGUtPmJzKSkgew0KPj4+ICsgICAgICAgICAgICByZXQgPSBiZHJ2X3Jlb3Blbl9zZXRf
cmVhZF9vbmx5X2RyYWluZWQoYnMtPmZpbGUtPmJzLCBmYWxzZSwgZXJycCk7DQo+Pg0KPj4gSG0u
ICBTb3JyeSwgSSBmaW5kIHRoaXMgYWxsIGEgYml0IGhhcmQgdG8gdW5kZXJzdGFuZC4gIChObyBj
b21tZW50cyBhbmQNCj4+IGFsbC4pDQo+Pg0KPj4gSSB1bmRlcnN0YW5kIHRoYXQgdGhpcyBpcyBm
b3IgYW4gUk8gLT4gUlcgdHJhbnNpdGlvbj8gIEV2ZXJ5dGhpbmcgaXMNCj4+IHN0aWxsIFJPLCBi
dXQgdGhlIHBhcmVudCB3aWxsIG5lZWQgYW4gUlcgY2hpbGQgYmVmb3JlIGl0IHRyYW5zaXRpb25z
IHRvDQo+PiBSVyBpdHNlbGYuDQo+Pg0KPj4NCj4+IEnigJltIGdvaW5nIHRvIGJlIGhvbmVzdCB1
cCBmcm9udCwgSSBkb27igJl0IGxpa2UgdGhpcyB2ZXJ5IG11Y2guICBCdXQgSQ0KPj4gdGhpbmsg
aXQgbWF5IGJlIGEgcmVhc29uYWJsZSBzb2x1dGlvbiBmb3Igbm93Lg0KPj4NCj4+IEFzIEkgcmVt
ZW1iZXIsIHRoZSBwcm9ibGVtIHdhcyB0aGF0IHdoZW4gcmVvcGVuaW5nIGEgcWNvdzIgbm9kZSBm
cm9tIFJPDQo+PiB0byBSVywgd2UgbmVlZCB0byB3cml0ZSBzb21ldGhpbmcgaW4gLnByZXBhcmUo
KSAoYmVjYXVzZSBpdCBjYW4gZmFpbCksDQo+PiBidXQgbmF0dXJhbGx5IG5vIC5wcmVwYXJlKCkg
aXMgY2FsbGVkIGFmdGVyIGFueSAuY29tbWl0KCksIHNvIG5vIG1hdHRlcg0KPj4gdGhlIG9yZGVy
IG9mIG5vZGVzIGluIHRoZSBSZW9wZW5RdWV1ZSwgdGhlIGNoaWxkIG5vZGUgd2lsbCBuZXZlciBi
ZSBSVw0KPj4gYnkgdGhpcyBwb2ludC4NCj4+DQo+PiBIbS4gIFRvIG1lIHRoYXQgbW9zdGx5IG1l
YW5zIHRoYXQgbWFraW5nIHRoZSB3aG9sZSByZW9wZW4gcHJvY2VzcyBhDQo+PiB0cmFuc2FjdGlv
biB3YXMganVzdCBhIGRyZWFtIHRoYXQgdHVybnMgb3V0IG5vdCB0byB3b3JrLg0KPiANCj4gVGhp
cyBwYXRjaCBhbHJlYWR5IGxvb2tzIHNvbWV3aGF0IGNvbXBsaWNhdGVkIHRvIG1lLCBhbmQgd2hh
dCB5b3UncmUNCj4gcHJvcG9zaW5nIGJlbG93IHNvdW5kcyBhbm90aGVyIG9yZGVyIG9mIG1hZ25p
dHVkZSBtb3JlIGNvbXBsZXguDQoNCkFncmVlIDopIEhvd2V2ZXIsIGF0IHRoaXMgcG9pbnQgSSd2
ZSBhbG1vc3QgaW1wbGVtZW50ZWQgaXQgKGl0J3Mgbm90IGEgcmVhc29uDQp0byBjaG9zZSBtb3Jl
IGNvbXBsZXggd2F5LCBvZiBjb3Vyc2UpLg0KDQo+IA0KPiBCdXQgSSB0aGluayB0aGUgaW1wb3J0
YW50IHBvaW50IGlzIHlvdXIgbGFzdCBzZW50ZW5jZSBhYm92ZS4gT25jZSB3ZQ0KPiBhY2tub3ds
ZWRnZSB0aGF0IHdlIGNhbid0IHBvc3NpYmx5IG1haW50YWluIGZ1bGwgdHJhbnNhY3Rpb24gc2Vt
YW50aWNzLA0KPiBJJ2xsIGFzayB0aGlzIG5haXZlIHF1ZXN0aW9uOiBXaGF0IHByZXZlbnRzIHVz
IGZyb20ganVzdCBrZWVwaW5nIHRoZQ0KPiBhZGRpdGlvbmFsIHdyaXRlIGluIC5jb21taXQ/DQoN
CkhtbSwgaXQncyB3aGF0IHdlJ3ZlIHN0YXJ0ZWQgd2l0aC4gVGhlIG9ubHkgdGhpbmcgdG8gZG8g
aXMgdG8gcmV2ZXJzZSBvcmRlcg0Kb2YgY29tbWl0cywgdG8gY29tbWl0IGZpbGUgY2hpbGQgYmVm
b3JlIHBhcmVudCAoYW5kIHRoaXMgd2F5IGl0IHdvcmtzIGluDQpWaXJ0dW96em8gbm93KS4NCkFu
ZCBJIHByb3Bvc2VkIGl0IGxvbmcgYWdvOg0KaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUv
aHRtbC9xZW11LWRldmVsLzIwMTgtMDYvbXNnMDQ1MjguaHRtbA0KDQoNCj4gDQo+IEl0IGlzIGV4
cGVjdGVkIHRvIHdvcmsgaW4gdGhlIGNvbW1vbiBjYXNlLCBzbyB3ZSdyZSBvbmx5IHRhbGtpbmcg
YWJvdXQNCj4gdGhlIGJlaGF2aW91ciBpbiBlcnJvciBjYXNlcyBhbnl3YXkuIElmIHNvbWV0aGlu
ZyBmYWlscyBhbmQgd2UgY2FuJ3QgZG8NCj4gdGhpbmdzIGluIGEgdHJhbnNhY3Rpb25hYmxlIHdh
eSwgd2UgbmVlZCB0byBkZWNpZGUgd2hhdCB0aGUgc3VycHJpc2UNCj4gcmVzdWx0IHdpbGwgbG9v
ayBsaWtlLCBiZWNhdXNlIHdlIGNhbiBuZWl0aGVyIGd1YXJhbnRlZSBhIHJvbGxiYWNrIG5vcg0K
PiBzdWNjZXNzZnVsIGNvbXBsZXRpb24uDQo+IA0KPiBJZiB0aGUgd3JpdGUgZmFpbHMgdW5leHBl
Y3RlZGx5LCBhbmQgd2UgZW5kIHVwIHdpdGggYSBxY293MiBpbWFnZSB0aGF0DQo+IGlzIG9wZW5l
ZCByL3csIGJ1dCBoYXMgcmVhZC1vbmx5IGJpdG1hcHMgLSB3b3VsZG4ndCB0aGF0IGJlIGEgcmVh
c29uYWJsZQ0KPiByZXN1bHQ/IEl0IHNlZW1zIG11Y2ggZWFzaWVyIHRvIGV4cGxhaW4gdGhhbiBz
b21lIGRlcGVuZGVuY3kgc3ViY2hhaW4NCj4gYWxyZWFkeSBiZWluZyBjb21taXR0ZWQgYW5kIHRo
ZSByZXN0IHJvbGxlZCBiYWNrLg0KDQpBbmQgdGhpcyBpcyBob3cgaXQgd29ya3Mgbm93IChleGNl
cHQgaXQgZG9lc24ndCB3b3JrIGJlY2F1c2Ugb2YgY29tbWl0IG9yZGVyKS4NCkluIG91ciBsb25n
IGFnbyBjb252ZXJzYXRpb24gKGxpbmsgYWJvdmUpIHlvdSBwb2ludGVkIHRoYXQgdGhlIHByb2Js
ZW0gaGVyZQ0KaXMgdGhhdCB3ZSBkb24ndCByZXR1cm4gYW4gZXJyb3IgZnJvbSBhY3R1YWxseSBm
YWlsZWQgY29tbWl0IGFuZCBpdCBpcw0KaWdub3JlZC4uDQoNCj4gDQo+IFNvLCBJIGd1ZXNzIG15
IHF1ZXN0aW9uIGlzLCB3aGF0IGlzIHRoZSBzcGVjaWZjIHNjZW5hcmlvIHlvdSdyZSB0cnlpbmcN
Cj4gdG8gZml4IHdpdGggdGhpcyBzZXJpZXMgKHdoeSBpc24ndCB0aGUgZmluYWwgcGF0Y2ggYSB0
ZXN0IGNhc2UgdGhhdA0KPiB3b3VsZCBhbnN3ZXIgdGhpcyBxdWVzdGlvbj8pLCBhbmQgYXJlIHdl
IHN1cmUgdGhhdCB0aGUgY3VyZSBpc24ndCB3b3JzZQ0KPiB0aGFuIHRoZSBkaXNlYXNlPw0KPiAN
Cg0KVGVzdCBhcHBlYXJzIGF0IDAzIGFuZCB0ZXN0cyB3aGF0IGFscmVhZHkgd29ya3MsIGFuZCBs
YWNrcyB0ZXN0LWNhc2VzIHdoaWNoDQphcmUgYnJva2VuLCBhbmQgdGhleSBhcmUgYWRkZWQgaW4g
MDggd2hlbiBhbGwgaXMgZml4ZWQuDQoNCkFuZCBoZXJlIGFyZSB0d28gdGhpbmdzIHRvIGZpeDoN
CkZpcnN0IGlzIHRoYXQgd2UgbG9zZSBiaXRtYXBzIG9uIHJlb3BlbmluZyB0byBSTyBhbmQgaXQg
aXMgZGVzY3JpYmVkIGFuZA0KZml4ZWQgaW4gMDYuDQpTZWNvbmQgaXMgdGhhdCB3ZSBjYW50IHNl
dCBJTl9VU0UgZmxhZyB3aGVuIHJlb3BlbmluZyB0byBSVyBhbmQgaXQgaXMgZml4ZWQNCmZpbmFs
bHkgaW4gMDguDQoNCg0KPT09PT0NCg0KU28sIGlmIHdlIGRlY2lkZSB0byBrZWVwIHRoaW5ncyBz
aW1wbGUsIHdoYXQgdG8gZG8/IEp1c3QgcmVvcmRlciBjb21taXRzIHRvDQpzYXRpc2Z5IGRlcGVu
ZGVuY2llcywgaWYgYW55Pw0KDQpTaG91bGQgd2UgYWRkIHJldHVybiBjb2RlIHRvIGNvbW1pdCwg
d2hpY2ggc2hvdWxkIGFsd2F5cyBiZSAwIGV4Y2VwdCB2ZXJ5IHJhcmUNCmNhc2U/DQoNCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

