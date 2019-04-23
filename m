Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D857BC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AF420685
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RARwzJCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AF420685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57665 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIznB-0004ZX-TE
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 14:05:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIzlj-0003qk-BE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIzlh-0001CY-91
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:03:47 -0400
Received: from mail-eopbgr140113.outbound.protection.outlook.com
	([40.107.14.113]:45638
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hIzlc-00014f-By; Tue, 23 Apr 2019 14:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ZelAeojf7ZeSjN8K3BAAqjNdLW/ieSIASmNFM+ZdxXI=;
	b=RARwzJCStnafbc62zt+raoLcmO91eDI8/JrY91sTtFo3ddLD+FiLxHIQqmSWodz4eeSF+Jl2tUZVoVeAMLg5xWwTrfX6txt/rl4XKUJfpDh5+Tg1tJgzQC8x5JKVyLTGhOLCEyptl27YfwwzIhmaKSUHDD0FNWE20jOmAe9WsHU=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3241.eurprd08.prod.outlook.com (52.134.111.15) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Tue, 23 Apr 2019 18:03:36 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1813.017;
	Tue, 23 Apr 2019 18:03:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 1/2] Makefile: add nit-picky mode to sphinx-build
Thread-Index: AQHU+Vko6le7PUXZmkeAQqTRBCSkK6ZKCwiA
Date: Tue, 23 Apr 2019 18:03:36 +0000
Message-ID: <eaa73eb3-a84f-a263-13b2-e25588f00fd7@virtuozzo.com>
References: <20190422221714.7630-1-jsnow@redhat.com>
	<20190422221714.7630-2-jsnow@redhat.com>
In-Reply-To: <20190422221714.7630-2-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0060.eurprd09.prod.outlook.com
	(2603:10a6:7:15::49) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190423210332998
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bb2f24a-2e86-4df3-d0cb-08d6c8160159
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3241; 
x-ms-traffictypediagnostic: DB7PR08MB3241:
x-microsoft-antispam-prvs: <DB7PR08MB32417958844A628033ECC37AC1230@DB7PR08MB3241.eurprd08.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(376002)(366004)(136003)(39850400004)(396003)(189003)(199004)(8936002)(76176011)(97736004)(6512007)(31686004)(14454004)(36756003)(52116002)(2906002)(7736002)(66066001)(5660300002)(8676002)(6436002)(478600001)(81156014)(25786009)(7416002)(81166006)(186003)(4326008)(102836004)(229853002)(26005)(386003)(86362001)(6506007)(347745004)(446003)(68736007)(486006)(2501003)(71190400001)(3846002)(476003)(6116002)(66556008)(2616005)(11346002)(305945005)(66446008)(66946007)(54906003)(2201001)(14444005)(316002)(73956011)(31696002)(110136005)(6486002)(6246003)(71200400001)(99286004)(66476007)(256004)(64756008)(53936002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3241;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: URFlPTBUkJuWRm7BreuT8+l3jbH7OG4YXOOIQ5FkzoNuub4F/gTOGVIBkbZ20BC0R5HOEeQYuOYLsRWJ/SOOMccX2lumWSLpQUeA5EQZYIcXSpbbrClkG7KgJ9jIs1t/EHHDt4dxdfA1BKHBdp+w0uQOPcAR7fXIMJd1JXVa0GcRTwEgS/RiYHl+Ze8rHX/CLDedxFaxb6OYRYVewe+jmBfbnoZ+6Z95NZut9O/PHz+pRPYxV9WTO7XZ/v79r/nYgGpNHysJ+6OplnZQZ2LIAoaGKonZMb6guH2GjezIuqFO6m8oA0qwmp6rrco8FaQs94JjoCKvt0gVjLOkMmkelHylNUhzGl/ApMPUSwGCeNtRW0tDw7gQ+NFZP6a0Byr5hVTzKs7IOpVJCpOqgvBN+Uy2XdYkuPIZKSsh37tyWao=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <901CD8BD2C0B1143BCDE519EE0ED55E7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb2f24a-2e86-4df3-d0cb-08d6c8160159
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 18:03:36.2396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3241
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.113
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Makefile: add nit-picky mode to
 sphinx-build
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
Cc: Fam Zheng <fam@euphon.net>, "aliang@redhat.com" <aliang@redhat.com>,
	"kchamart@redhat.com" <kchamart@redhat.com>,
	"qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"nsoffer@redhat.com" <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423180336.OO5CiX85hHK_oIUuT6SiQMhE_UKRj6IwEH3kFy8FQL0@z>

MjMuMDQuMjAxOSAxOjE3LCBKb2huIFNub3cgd3JvdGU6DQo+IElmIHdlIGFkZCByZWZlcmVuY2Vz
IHRoYXQgZG9uJ3QgcmVzb2x2ZSAob3IgYWNjaWRlbnRhbGx5IHJlbW92ZSB0aGVtKSwNCj4gaXQg
d2lsbCBiZSBoZWxwZnVsIHRvIGhhdmUgYW4gZXJyb3IgbWVzc2FnZSBhbGVydGluZyB1cyB0byB0
aGF0Lg0KDQphY2NvcmRpbmdseSB0byBkb2NzIEkndmUgZm91bmQsIG5vdCBlcnJvciBidXQgd2Fy
bmluZy4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29t
Pg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNv
dkB2aXJ0dW96em8uY29tPg0KDQo+IC0tLQ0KPiAgIE1ha2VmaWxlIHwgMiArLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL01ha2VmaWxlIGIvTWFrZWZpbGUNCj4gaW5kZXggMDRhMGQ0NTA1MC4uZmY5Y2UyZWQ0YyAx
MDA2NDQNCj4gLS0tIGEvTWFrZWZpbGUNCj4gKysrIGIvTWFrZWZpbGUNCj4gQEAgLTg5OSw3ICs4
OTksNyBAQCBkb2NzL3ZlcnNpb24udGV4aTogJChTUkNfUEFUSCkvVkVSU0lPTg0KPiAgIHNwaGlu
eGRvY3M6ICQoTUFOVUFMX0JVSUxERElSKS9kZXZlbC9pbmRleC5odG1sICQoTUFOVUFMX0JVSUxE
RElSKS9pbnRlcm9wL2luZGV4Lmh0bWwNCj4gICANCj4gICAjIENhbm5lZCBjb21tYW5kIHRvIGJ1
aWxkIGEgc2luZ2xlIG1hbnVhbA0KPiAtYnVpbGQtbWFudWFsID0gJChjYWxsIHF1aWV0LWNvbW1h
bmQsc3BoaW54LWJ1aWxkICQoaWYgJChWKSwsLXEpIC1iIGh0bWwgLUQgdmVyc2lvbj0kKFZFUlNJ
T04pIC1EIHJlbGVhc2U9IiQoRlVMTF9WRVJTSU9OKSIgLWQgLmRvY3RyZWVzLyQxICQoU1JDX1BB
VEgpL2RvY3MvJDEgJChNQU5VQUxfQlVJTERESVIpLyQxICwiU1BISU5YIiwiJChNQU5VQUxfQlVJ
TERESVIpLyQxIikNCj4gK2J1aWxkLW1hbnVhbCA9ICQoY2FsbCBxdWlldC1jb21tYW5kLHNwaGlu
eC1idWlsZCAkKGlmICQoViksLC1xKSAtbiAtYiBodG1sIC1EIHZlcnNpb249JChWRVJTSU9OKSAt
RCByZWxlYXNlPSIkKEZVTExfVkVSU0lPTikiIC1kIC5kb2N0cmVlcy8kMSAkKFNSQ19QQVRIKS9k
b2NzLyQxICQoTUFOVUFMX0JVSUxERElSKS8kMSAsIlNQSElOWCIsIiQoTUFOVUFMX0JVSUxERElS
KS8kMSIpDQo+ICAgIyBXZSBhc3N1bWUgYWxsIFJTVCBmaWxlcyBpbiB0aGUgbWFudWFsJ3MgZGly
ZWN0b3J5IGFyZSB1c2VkIGluIGl0DQo+ICAgbWFudWFsLWRlcHMgPSAkKHdpbGRjYXJkICQoU1JD
X1BBVEgpL2RvY3MvJDEvKi5yc3QpICQoU1JDX1BBVEgpL2RvY3MvJDEvY29uZi5weSAkKFNSQ19Q
QVRIKS9kb2NzL2NvbmYucHkNCj4gICANCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFk
aW1pcg0K

