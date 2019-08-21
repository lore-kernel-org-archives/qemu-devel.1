Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E45C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E4722CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cIOoLfvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E4722CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0PAp-00085u-Pq
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0OzW-0003cJ-Iu
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0OzU-0006ou-Vu
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:41:26 -0400
Received: from mail-eopbgr50101.outbound.protection.outlook.com
 ([40.107.5.101]:19175 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i0OzR-0006iz-He; Wed, 21 Aug 2019 07:41:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M84TyrAIsTAqQpaTVfR2kmzDMk3l61e0ZzHsDZ2EE02Jgd+5tl7SO6yBGP7SflvIl41cv5nglPGaETjuAw5vPi7LZZSckobaA3O76tAmwZwksg50D4facgM3QLPEdhiG23+iZ0K2C0LpQh2q9odcxzzQIwlmRnNJOQdjLskLbrtoyq8Zj/LP/slH2JOUplmdm3jLTZJ8sReRJmAbPXSrYkUQxUdoDbxycB6BmNg7u48nQy5DsIl10MpgN07HXJfCipONZ+gmc1cafSpcuuTXDvfE6abjSK9iEDrGdiriro9pCx+oqVZLV40vmctTQwuho1zqLQHd/lOtnh6Vipxz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP33NpBPIWEU7TMsnnPg9+GyX7lLGM8uTfTpF8LcDQc=;
 b=cnH5JR8yqAoHokPUaLpc+MOm/tW+LHrnk7nIhQ03L1tlY4rWywvb1gVV2/3aYx2vlWN/kdMKyMR3mJJxJgfi8hkafjgCARCx6tornWHOmmd5TmaZ0UPTZVqcFpou8W8n4PDqsZXLMcmP/DyybEwxVXLpdNVeVMi5PkX5ftpe6xkwX0EIEGJS2B0/h8NJeERBuO+UlvEKMjWJVsKbDKn9HDYbvFOmtiKpZXtiQQrdOj5oGzvOq11SDDXR/wYaA/AyZnOmP/wFr1GQFiJDyE0+TTqGwH8MhF32gbHXtfO0OL/CnU27TGpVRodNJGDj0tXlGpZYGWrAsugMNoMv3q5MaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP33NpBPIWEU7TMsnnPg9+GyX7lLGM8uTfTpF8LcDQc=;
 b=cIOoLfvGAXQdt4QkI74qC7nMCoadX2kABAf61uToXa/1tm/5ksldBTucFP1jKIeexnqDppnPpXSV3KinU/9hKnEGjx44fOG0joRmv2TKLcAy63FfFg+eL+0CRziIoE72v+3ESQ89qmRsAw+X05EGUNGflrYlf+hyMWD5By6YL4o=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5483.eurprd08.prod.outlook.com (52.133.242.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 11:41:17 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 11:41:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 0/9] NBD reconnect
Thread-Index: AQHVJcsR0Ob9vQwVFUSX/gqgFfzT4KbbiEIAgCpW1AA=
Date: Wed, 21 Aug 2019 11:41:17 +0000
Message-ID: <b8b6d285-7091-484e-35db-5cec736f8314@virtuozzo.com>
References: <20190618114328.55249-1-vsementsov@virtuozzo.com>
 <e66505eb-78e1-612d-6742-4774c3167412@virtuozzo.com>
In-Reply-To: <e66505eb-78e1-612d-6742-4774c3167412@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0316.eurprd05.prod.outlook.com
 (2603:10a6:7:93::47) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190821144114276
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7b3249d-242e-46b5-745e-08d7262c7a5c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5483; 
x-ms-traffictypediagnostic: DB8PR08MB5483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB548387DFF21E6F778A11556CC1AA0@DB8PR08MB5483.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(39850400004)(376002)(346002)(396003)(53754006)(199004)(189003)(52116002)(8676002)(66066001)(36756003)(81166006)(81156014)(446003)(316002)(2906002)(11346002)(8936002)(2616005)(476003)(71200400001)(14454004)(71190400001)(25786009)(3846002)(64756008)(6116002)(66476007)(66556008)(229853002)(66446008)(6512007)(66946007)(6436002)(4326008)(6506007)(5660300002)(486006)(386003)(31696002)(6486002)(53936002)(31686004)(86362001)(186003)(99286004)(26005)(305945005)(2501003)(256004)(5024004)(7736002)(478600001)(110136005)(76176011)(102836004)(6246003)(54906003)(107886003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5483;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vYVMrgMiXFXz3Gc3Q3NLJ8elbUnaPzruISnfX//p+Uoap9C7EW9KMHVcHUJXubC0JtOt36yUTp1ErJ0ghzbmRtEG3iPF98qPROzeo/Tg4C7dqUpYqwR2gXR4zU1uP8AnXB0j0TaPu/pPrQSyL+Q212SqMVWuq1EPBHZeQkYJ6QyFnHBzM1e3M5mA2u27VCtHQZfPN2NXm/YQD4ot8ir3VxfNX2D4o2DUNh8bbdzwrZ3bYb61Xp7Jssd8bf5iJW42No2+wFVFoz6+TjvX6E3f/oeTmcVM7Pzbq6HBDP7PvR2EUxaWjw8N+hg1QundunQCEvIt74DHerohVTW1ZWd6PJSUSMFmrBHVj6TTxM+fXNdegsNBs+8DNhrPVry09UYQOcnxhyuCangaVdXi7InVIOlB6ZoyANKQr8+W8IHEk44=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78849A66F01990449B3D3AA4DA4C05D4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b3249d-242e-46b5-745e-08d7262c7a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 11:41:17.2332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcOAzs6gZtOx0KZ/5/S1fFROR55tmVXjJH5KKsTWK/CtJskgUwPL6sOgjMXKHBhoIojhPs9/AgTWfQHy6PnAB915Kacij5xz4Ilp9vcf5rE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5483
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.101
Subject: Re: [Qemu-devel] [PATCH v7 0/9] NBD reconnect
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U2hvdWxkIEkgcmVzZW5kIHdpdGggMDcgZHJvcHBlZD8NCg0KMjUuMDcuMjAxOSAxMzowNywgVmxh
ZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4gcGluZw0KPiANCj4gMTguMDYuMjAx
OSAxNDo0MywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhpIGFsbCEN
Cj4+IEhlcmUgaXMgTkJEIHJlY29ubmVjdC4gUHJldmlvdXNseSwgaWYgY29ubmVjdGlvbiBmYWls
ZWQgYWxsIGN1cnJlbnQNCj4+IGFuZCBmdXR1cmUgcmVxdWVzdHMgd2lsbCBmYWlsLiBBZnRlciB0
aGUgc2VyaWVzLCBuYmQtY2xpZW50IGRyaXZlcg0KPj4gd2lsbCB0cnkgdG8gcmVjb25uZWN0IHVu
bGltaXRlZCB0aW1lcy4gRHVyaW5nIGZpcnN0IEByZWNvbm5lY3QtZGVsYXkNCj4+IHNlY29uZHMg
b2YgcmVjb25uZWN0aW5nIGFsbCByZXF1ZXN0cyB3aWxsIHdhaXQgZm9yIHRoZSBjb25uZWN0aW9u
LA0KPj4gYW5kIGlmIGl0IGlzIGVzdGFibGlzaGVkIHJlcXVlc3RzIHdpbGwgYmUgcmVzZW50LiBB
ZnRlcg0KPj4gQHJlY29ubmVjdC1kZWxheSBwZXJpb2QgYWxsIHJlcXVlc3RzIHdpbGwgYmUgZmFp
bGVkICh1bnRpbCBzdWNjZXNzZnVsDQo+PiByZWNvbm5lY3QpLg0KPj4NCj4+IHY3Og0KPj4gYWxt
b3N0IGFsbDogcmViYXNlZCBvbiBtZXJnZWQgbmJkLmMgYW5kIG5iZC1jbGllbnQuYyAoaW5jbHVk
aW5nIHBhdGNoIHN1YmplY3QpDQo+PiAwMS0wNDogYWRkIEVyaWMncyByLWINCj4+IDA0OiB3b3Jk
aW5nDQo+PiAwNTogbmV3DQo+PiAwNjogcmV3cml0ZSB0byByZW1vdmUgdGltZXIgZWFybGllcg0K
Pj4gMDc6IG5ldw0KPj4gMDg6DQo+PiDCoCAtIHJlYmFzZSBvbiAwNSBhbmQgMDcNCj4+IMKgIC0g
ZHJvcCAiQWxsIHJpZ2h0cyByZXNlcnZlZCINCj4+IMKgIC0gaGFuZGxlIGRyYWluDQo+PiDCoCAt
IGltcHJvdmUgaGFuZGxpbmcgYWlvIGNvbnRleHQgYXR0YWNoDQo+PiAwOTogbW92ZSAyNDkgLT4g
MjU3DQo+Pg0KPj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSAoOSk6DQo+PiDCoMKgIGJs
b2NrL25iZDogc3BsaXQgY29ubmVjdGlvbl9jbyBzdGFydCBvdXQgb2YgbmJkX2NsaWVudF9jb25u
ZWN0DQo+PiDCoMKgIGJsb2NrL25iZDogdXNlIG5vbi1ibG9ja2luZyBpbyBjaGFubmVsIGZvciBu
YmQgbmVnb3RpYXRpb24NCj4+IMKgwqAgYmxvY2svbmJkOiBtb3ZlIGZyb20gcXVpdCB0byBzdGF0
ZQ0KPj4gwqDCoCBibG9jay9uYmQ6IGFkZCBjbWRsaW5lIGFuZCBxYXBpIHBhcmFtZXRlciByZWNv
bm5lY3QtZGVsYXkNCj4+IMKgwqAgYmxvY2svbmJkOiByZWZhY3RvciBuYmQgY29ubmVjdGlvbiBw
YXJhbWV0ZXJzDQo+PiDCoMKgIHFlbXUtY29yb3V0aW5lLXNsZWVwOiBpbnRyb2R1Y2UgcWVtdV9j
b19zbGVlcF93YWtlDQo+PiDCoMKgIHFlbXUvdW5pdHM6IGFkZCBTSSBkZWNpbWFsIHVuaXRzDQo+
PiDCoMKgIGJsb2NrL25iZDogbmJkIHJlY29ubmVjdA0KPj4gwqDCoCBpb3Rlc3RzOiB0ZXN0IG5i
ZCByZWNvbm5lY3QNCj4+DQo+PiDCoCBxYXBpL2Jsb2NrLWNvcmUuanNvbsKgwqDCoMKgwqDCoMKg
wqDCoCB8wqAgMTEgKy0NCj4+IMKgIGluY2x1ZGUvYmxvY2svbmJkLmjCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCAzICstDQo+PiDCoCBpbmNsdWRlL3FlbXUvY29yb3V0aW5lLmjCoMKgwqDCoMKg
IHzCoCAxNyArLQ0KPj4gwqAgaW5jbHVkZS9xZW11L3VuaXRzLmjCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqAgNyArDQo+PiDCoCBibG9jay9uYmQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IDUzMSArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+PiDCoCBi
bG9jay9udWxsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKy0N
Cj4+IMKgIGJsb2NrL3NoZWVwZG9nLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAy
ICstDQo+PiDCoCBuYmQvY2xpZW50LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAxNiArLQ0KPj4gwqAgcWVtdS1uYmQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoMKgIDIgKy0NCj4+IMKgIHRlc3RzL3Rlc3QtYmRydi1kcmFpbi5jwqDCoMKg
wqDCoMKgIHzCoMKgIDYgKy0NCj4+IMKgIHRlc3RzL3Rlc3QtYmxvY2staW90aHJlYWQuY8KgwqAg
fMKgwqAgMiArLQ0KPj4gwqAgdXRpbC9xZW11LWNvcm91dGluZS1zbGVlcC5jwqDCoCB8wqAgNDcg
KystDQo+PiDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvMjU3wqDCoMKgwqDCoMKgwqAgfMKgIDYzICsr
KysNCj4+IMKgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNTcub3V0wqDCoMKgIHzCoCAxMCArDQo+PiDC
oCB0ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPj4gwqAgdGVz
dHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkgfMKgwqAgNCArDQo+PiDCoCAxNiBmaWxlcyBjaGFu
Z2VkLCA1NTEgaW5zZXJ0aW9ucygrKSwgMTczIGRlbGV0aW9ucygtKQ0KPj4gwqAgY3JlYXRlIG1v
ZGUgMTAwNzU1IHRlc3RzL3FlbXUtaW90ZXN0cy8yNTcNCj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0ZXN0cy9xZW11LWlvdGVzdHMvMjU3Lm91dA0KPj4NCj4gDQo+IA0KDQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KVmxhZGltaXINCg==

