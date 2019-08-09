Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC32AC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D0B208C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PP9dv/zE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D0B208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw6xm-0004Nz-27
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49633)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw6v9-0000Um-Ht
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw6v6-0004VR-Fv
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:35:10 -0400
Received: from mail-eopbgr50126.outbound.protection.outlook.com
 ([40.107.5.126]:55558 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hw6v5-0004UQ-Ns; Fri, 09 Aug 2019 11:35:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9m0PPnWxHazgN4b/wJKpxuydoXFS+ZbWALckwoHrk3oHw78bJzvhwIZuNp26V5YQTnj6ytW/Clsd4rmsSOiqCoqVytUr8YaEsLmVtSh0zlEIXF0KHpurOQ4DEYU4ZiwvKeNpXWZRoUtNEUMr2yl0pcvU+cGFyNDKgeb9Qvy30ecuWLjpULmXVDE0X+E2AuYIb6W8akqTwJXWLCRnguFFnQmf0MwgKoOKLTb4/KCj7JhdT8IzusFnRVypyhhbkwbvsVcIIRjBA1aeD023i5iGjMkqTOEQgFpfTY+7PFDralsFP8DssbldHYJfYrBn+cZj+rMffOpvQf1sHd83eLpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e/OAifci3KvuFigmiJ9btNuuKVg3raweRyc0ZuNwRA=;
 b=OJeW9SE0/7niPmN3/ebF7VqvsapRPe/Ws0Ohm0uHX3AulZrQzg3ho9zP3I9uXfVpx6BikA8HoC+VXErH0sRTb+/qzybwYMev+8w2ksQGxFQFNnGp4FsIfq/XbHecfJ1pDwTWVpxf3LPhHtGO9BP6lJGsnsujED9wxE4tlOfoA5WSuovYNIf/DUVf3UVlkRPESW8LXN7pIgSVY+5uogISYWC1T3yPl0VXCC5BuvvdYcj3hIivFb4Kun8cqHf8lIq5R1vYwX+5LVzKGO5P2P1rJj7YUvZG8i7YED9E87rPg+BL32nMMgv8VQ37WduiggtUrCPnazRQxOc4F6ITOYv5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e/OAifci3KvuFigmiJ9btNuuKVg3raweRyc0ZuNwRA=;
 b=PP9dv/zEfEs51IrEr+vv1IeTnoMNAXiIvR17McgG0uHrxL+Z85jOojyMZQTdaNiIeb940su7+bhjfTqWUZLCuVGsHJSM8QHRVTo3aQSIHmay+rSG+tf9g4MBUA/wNt+3MfQ035fo5/8DmARDYJzzBH+sxguCI+1sztBpsKObTfA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4123.eurprd08.prod.outlook.com (20.179.12.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Fri, 9 Aug 2019 15:35:05 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.015; Fri, 9 Aug 2019
 15:35:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 0/7] backup improvements
Thread-Index: AQHVTseh+1m++SU4LkiMt09mJD+BcKby8naA
Date: Fri, 9 Aug 2019 15:35:05 +0000
Message-ID: <09ab374d-2d67-16b5-d0ab-ff25b07171b4@virtuozzo.com>
References: <20190809153207.49288-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190809153207.49288-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0009.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::22)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190809183502973
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7a6f2b6-7c67-45c5-aee9-08d71cdf270f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4123; 
x-ms-traffictypediagnostic: DB8PR08MB4123:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB4123CD5A477C2797E04EC964C1D60@DB8PR08MB4123.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(366004)(136003)(376002)(189003)(199004)(53754006)(66946007)(5660300002)(8936002)(6116002)(8676002)(25786009)(107886003)(6246003)(81166006)(66476007)(4326008)(3846002)(81156014)(66556008)(64756008)(66446008)(66066001)(478600001)(305945005)(2906002)(7736002)(71190400001)(71200400001)(5640700003)(2616005)(6512007)(6916009)(476003)(2351001)(6436002)(486006)(6306002)(11346002)(446003)(6486002)(256004)(31696002)(86362001)(386003)(6506007)(316002)(229853002)(54906003)(2501003)(102836004)(76176011)(36756003)(99286004)(14454004)(966005)(52116002)(31686004)(53936002)(186003)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4123;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fCFhPmoYcBRPzC2XnXZXr5fHWi9DZatA2dbs/LJGFuJzCVA0xSec6SYx1/EYJT3+tqAyb4+gecyqXQ8jyBE3GW2cHwJUVvg8ZQQuW0yDfeleLFZGTjgwBQHN4SLLpwK0bRyfeaFAgrrrNNb2ta8KkMUeij7j9uulimRNBnsSEjGdgxpqoe56Sa+Dq6KdLOk48D5Fn60y1LcazypJJB9RUwSAujWAMgdbUCVZ30BZsgLoyU8At1hNTzwsDAZIGv28VIY1nmsgPIXgVWX9pfJnUHSBWagQNnSMexXkBOkHp9uJRejbNWRcYsaULKQAV06qZbQFAkQE8AeCNqLBBJkVwilsphsLsiSkaQn1XsXY5cjJ7/Y2R37O2gQ1+As2nFBWLIRulyf32smNLMsMg3Q8HfVijM87jk4loWYv/vjEo+E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <655EB7E23E971A47AA7096300C66591E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a6f2b6-7c67-45c5-aee9-08d71cdf270f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 15:35:05.6809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 27qFTIV3afuADyqzd+kdOIG6EvRYYBg56CLNj6nzpCVM27+wKiY+D0HwIgOu0xuYQotqi+7D6Pk7jl0CUzr9B8hQATWUvlFKAg/PLyKk8q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4123
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.126
Subject: Re: [Qemu-devel] [PATCH v2 0/7] backup improvements
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxODozMiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
SGkgYWxsIQ0KPiANCj4gVGhlcmUgYXJlIHNvbWUgZml4ZXMgYW5kIHJlZmFjdG9yaW5ncyBJIG5l
ZWQgb24gbXkgd2F5IHRvIHJlc2VuZA0KPiBteSBiYWNrdXAtdG9wIHNlcmllcy4gSXQncyBvYnZp
b3VzIG5vdyB0aGF0IEkgbmVlZCB0byBzaGFyZSBjb3B5aW5nDQo+IGNvZGUgYmV0d2VlbiBiYWNr
dXAgYW5kIGJhY2t1cC10b3AsIGFzIGJhY2t1cCBjb3B5aW5nIGNvZGUgYmVjb21lcw0KPiBzbWFy
dGVyIGFuZCBtb3JlIGNvbXBsaWNhdGVkLiBTbyB0aGUgZ29hbCBvZiB0aGUgc2VyaWVzIGlzIHRv
IG1ha2UgY29weWluZw0KPiBjb2RlIG1vcmUgc2hhcmUtYWJsZS4NCj4gDQo+IEl0J3MgYmFzZWQg
b24gSm9obidzIGJpdG1hcHMgYnJhbmNoLCByZWJhc2VkIG9uIG1hc3Rlci4NCg0KTm8sIGl0J3Mg
YmFzZWQgZGlyZWN0bHkgb24gSm9obidzIGJpdG1hcHMgYnJhbmNoOg0KQmFzZWQtb246IGh0dHBz
Oi8vZ2l0aHViLmNvbS9qbnNub3cvcWVtdSBiaXRtYXBzDQoNCj4gDQo+IHYyIChieSBNYXgncyBj
b21tZW50cyk6DQo+IA0KPiAwMjogQWRkIE1heCdzIHItYg0KPiAwMzogLSBzcGxpdCBvdXQgYmFj
a3VwIGNoYW5nZXMgdG8gMDMNCj4gICAgICAtIGhhbmRsZSBjb21tb24gbWF4X3RyYW5zZmVyID0g
MCBjYXNlDQo+IDA0OiBzcGxhdCBvdXQgZnJvbSAwMg0KPiAwNjogZml4IGFsbG9jYXRpb24gc2l6
ZQ0KPiAwNzogLSByZWJhc2Ugb24gMDYgY2hhbmdlcw0KPiAgICAgIC0gYWRkIE1heCdzIHItYg0K
PiANCj4gdHdvIHBhdGNoZXMgYXJlIGRyb3BwZWQgb3IgcG9zdHBvbmVkIGZvciB0aGUgbmV4dCBz
dGVwDQo+IA0KPiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5ICg3KToNCj4gICAgYmxvY2sv
YmFja3VwOiBkZWFsIHdpdGggemVybyBkZXRlY3Rpb24NCj4gICAgYmxvY2svYmFja3VwOiByZWZh
Y3RvciB3cml0ZV9mbGFncw0KPiAgICBibG9jay9pbzogaGFuZGxlIGFsaWdubWVudCBhbmQgbWF4
X3RyYW5zZmVyIGZvciBjb3B5X3JhbmdlDQo+ICAgIGJsb2NrL2JhY2t1cDogZHJvcCBoYW5kbGlu
ZyBvZiBtYXhfdHJhbnNmZXIgZm9yIGNvcHlfcmFuZ2UNCj4gICAgYmxvY2svYmFja3VwOiBmaXgg
YmFja3VwX2Nvd193aXRoX29mZmxvYWQgZm9yIGxhc3QgY2x1c3Rlcg0KPiAgICBibG9jay9iYWNr
dXA6IHRlYWNoIGJhY2t1cF9jb3dfd2l0aF9ib3VuY2VfYnVmZmVyIHRvIGNvcHkgbW9yZSBhdCBv
bmNlDQo+ICAgIGJsb2NrL2JhY2t1cDogbWVyZ2UgZHVwbGljYXRlZCBsb2dpYyBpbnRvIGJhY2t1
cF9kb19jb3cNCj4gDQo+ICAgYmxvY2svYmFja3VwLmMgfCAxMjUgKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGJsb2NrL2lvLmMgICAgIHwgIDQ4
ICsrKysrKysrKysrKysrKy0tLS0NCj4gICBibG9ja2Rldi5jICAgICB8ICAgOCArKy0tDQo+ICAg
MyBmaWxlcyBjaGFuZ2VkLCA5MSBpbnNlcnRpb25zKCspLCA5MCBkZWxldGlvbnMoLSkNCj4gDQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

