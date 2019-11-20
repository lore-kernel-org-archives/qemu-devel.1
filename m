Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC02DC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9501820714
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="weQ9Ii+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9501820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSPN-0003bH-Np
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:00:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXSNQ-00023w-EV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXSNP-0004ou-C2
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:58:44 -0500
Received: from mail-ve1eur03on072c.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::72c]:51809
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXSNM-0004nH-LR; Wed, 20 Nov 2019 10:58:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZZwX2GksfgWb+dAs5v8nDyXWbyClLQyf79O6HoAAzp1vKYchKnj2G3mj+E6YkijBDBjkaH4KluIiNM5QHWSKh4IYP7+cW/OGqtVkmCBDII0BdlzbAi5XWtUWspaBarBnC5/0TDasxGKGv/iK5H+LhVXQwDFm3sIRuXY1GNZuxoa1yt3x7yIT4RLJTWoRU4Ypp8aVMiKq8Ddu2CchiZ8Dy8hgoQJJCUI1p7oVfXAa0SYFHJ99elfGME3QLS6YEhG0o63Om4oIyGK7gxRGcZOr0izwPL5X+4cbllmVjtYdfIvvXhs4OC6GcdNFudDV1EgPX9qfSOEU9l9CUnYKYcZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6Q13rohqxLrDHBmLboX14z8XHfZIQtjZYfEc6wynXM=;
 b=DndGjYuBzS4Qu0FSh4Z9mS1mmeE62dNG5u8hWyLYbRziZBcPp1/AuPnZK6HuaPcHuJJVMuN4TolXpSYr22CQP76Xzs9xShUtPklHxak2Bg3kNmJE+isKtpK2V6FDVuZJ3hAXi5zDTIxvBT2Yc/0phs6uE/vmERTZwScjz/9CqSL6PVuU4Z22/SHHj/lZTAnGxmzBxEI6+f9ALInE9mH62uga15Y0Qh0YdUPJdrXRI8YwxQlpY7l6ETcsbyYW//K0kxQWYAXaUildZV83P9nIog8VubgxmBmIBKXAWaTs0kXGUt8K7UgUsJ/x9/IL+fXE4C5zVidFGagA9O3oh27CRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6Q13rohqxLrDHBmLboX14z8XHfZIQtjZYfEc6wynXM=;
 b=weQ9Ii+1CV6e535KW/qlY5GcraYsfw+5c7Diu8RN92JgheswRq5HNQMBemQ83i8sKOUT4Ji42PmULP3SaygPlrCRtvK5H1fhGSXG16+uAhpie/pohioUy0B50bnoW48ZUvABH77E4H57qNGmnDqW3qTHte2kzgnpaoCsfhjC1YU=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4277.eurprd08.prod.outlook.com (20.179.7.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 20 Nov 2019 15:58:38 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 15:58:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: qcow2 preallocation and backing files
Thread-Topic: qcow2 preallocation and backing files
Thread-Index: AQHVn5wABMjtyQWeikidTGAJT/kh76eT/KGAgAAvq4CAAAs2gA==
Date: Wed, 20 Nov 2019 15:58:38 +0000
Message-ID: <5b57fb5b-4480-2b39-9c60-bbd63f13f1cb@virtuozzo.com>
References: <20191120120625.GA25497@igalia.com>
 <a1575e90-3fe4-e843-518c-714db4b621bc@virtuozzo.com>
 <w517e3u8tks.fsf@maestria.local.igalia.com>
In-Reply-To: <w517e3u8tks.fsf@maestria.local.igalia.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::39) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120185835804
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05c7638d-d9c9-4285-3a9f-08d76dd2818c
x-ms-traffictypediagnostic: AM6PR08MB4277:
x-microsoft-antispam-prvs: <AM6PR08MB42779198EC748F0605525C20C14F0@AM6PR08MB4277.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(136003)(39840400004)(396003)(366004)(51444003)(199004)(189003)(2616005)(36756003)(102836004)(25786009)(386003)(478600001)(6506007)(99286004)(11346002)(316002)(52116002)(66946007)(66066001)(76176011)(446003)(3846002)(86362001)(54906003)(110136005)(256004)(8676002)(8936002)(7736002)(305945005)(81166006)(81156014)(6116002)(186003)(31696002)(26005)(2906002)(71200400001)(71190400001)(14454004)(229853002)(486006)(6512007)(6246003)(31686004)(66476007)(6436002)(4326008)(6486002)(5660300002)(476003)(66446008)(64756008)(2501003)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4277;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4RbfQS5R8OU8Jl3Ftv52pz2GlI/AevqSh7fZQO0pHj4HDIT7lBEuVASnjCwqcsL4WQA6XSW6QFClUR4+gn9VEUuqqkS0fj6OV5/85iuapKFGNoR3HWof/EtASmlGDItLFOUKFepi3JHT5eRQJ4Mz6JhaxGMf6OfUPADXjpawMZ3KjcCLOH6ehRya4f2TUMIHujjc6txsaSnbACTD9IlbIjS1ixFT5+MiP+az4GofLDGD8ctAAaEQ69VIt++NE5iNawmYN64CszFaTUm0zUlLChQLxR9cfE6NM97XDXEeDNi9DS+ksTAQAwDhpIdL2YEbR8ap+uiP5OpYK4+bcqIdD7DT408cEmcmVYDOFmj45Kbx4HeeGzwocKb+b9TxnXUeJnymbhn3UW5w9TwVBa3cdATF2ZGYeL1CyTwSDA0VKb8qVTBoSVH3KtJYzv/VpCYD
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <91C30488D7A2A44097DC6679F929B63F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c7638d-d9c9-4285-3a9f-08d76dd2818c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 15:58:38.1384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIuGNCUT2z4Sfl86CEJK5rhUtaAsOq6Zxu7jUowtb0L7BcDaU2MRIxLq4Vo/eXtsdpKXvGRcLc+KmrNmqgD05o7FLgP3BvwuzHm4xy/3omw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4277
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::72c
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMTEuMjAxOSAxODoxOCwgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IE9uIFdlZCAyMCBOb3Yg
MjAxOSAwMToyNzo1MyBQTSBDRVQsIFZsYWRpbWlyIFNlbWVlYXVzbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiANCj4+IDMuIEFsc28sIHRoZSBsYXR0ZXIgd2F5IGlzIGluY29uc2lzdGVudCB3aXRo
IGRpc2NhcmQuIERpc2NhcmRlZA0KPj4gcmVnaW9ucyByZXR1cm5zIHplcm9lcywgbm90IGNsdXN0
ZXJzIGZyb20gYmFja2luZy4gSSB0aGluayBkaXNjYXJkIGFuZA0KPj4gdHJ1bmNhdGUgc2hvdWxk
IGJlaGF2ZSBpbiB0aGUgc2FtZSBzYWZlIHplcm8gd2F5Lg0KPiANCj4gQnV0IHRoZW4gUFJFQUxM
T0NfTU9ERV9PRkYgaW1wbGllcyB0aGF0IHRoZSBMMiBtZXRhZGF0YSBzaG91bGQgYmUNCj4gcHJl
YWxsb2NhdGVkIChhbGwgY2x1c3RlcnMgc2hvdWxkIGJlIFFDT1cyX0NMVVNURVJfWkVST19QTEFJ
TiksIGF0IGxlYXN0DQo+IHdoZW4gdGhlcmUgaXMgYSBiYWNraW5nIGZpbGUuDQo+IA0KPiBPciBt
YXliZSB3ZSBqdXN0IGZvcmJpZCBQUkVBTExPQ19NT0RFX09GRiBkdXJpbmcgcmVzaXplIGlmIHRo
ZXJlIGlzIGENCj4gYmFja2luZyBmaWxlID8NCj4gDQoNCktldmluIHByb3Bvc2VkIGEgZml4IHRo
YXQgYWx0ZXJzIFBSRUFMTE9DX01PREVfT0ZGIGJlaGF2aW9yIGlmIHRoZXJlIGlzDQphIGJhY2tp
bmcgZmlsZSwgdG8gYWxsb2NhdGUgTDIgbWV0YWRhdGEgd2l0aCBaRVJPIGNsdXN0ZXJzLi4NCg0K
SSBkb24ndCB0aGluayB0aGF0IGl0J3MgdGhlIGJlc3QgdGhpbmcgdG8gZG8sIGJ1dCBpdCdzIGFs
cmVhZHkgZG9uZSwgaXQgd29ya3MNCmFuZCBzZWVtcyBhcHByb3ByaWF0ZSBmb3IgcmMzLi4NCg0K
SSBzZWUgbm93LCB0aGF0IGNoYW5nZSBQUkVBTExPQ19NT0RFX09GRiBiZWhhdmlvciBtYXkgYnJl
YWsgdGhpbmdzLCBmaXJzdCBvZg0KYWxsIHFlbXUtaW1nIGNyZWF0ZSwgd2hpY2ggY3JlYXRpbmcg
VU5BTExPQ0FURUQgcWNvdzIgYnkgZGVmYXVsdCBmb3IgeWVhcnMuDQoNClN0aWxsLCBJIHRoaW5r
IHRoYXQgaXQgd291bGQgYmUgc2FmZXIgdG8gYWx3YXlzIFpFUk8gZXhwYW5kZWQgcGFydCBvZiBx
Y293MiwNCnJlZ2FyZGxlc3Mgb2YgYmFja2luZyBmaWxlLi4NCg0KV2UgbWF5IGFkZCBQUkVBTExP
Q19NT0RFX1pFUk8sIGFuZCB1c2UgaXQgaW4gbWlycm9yLCBjb21taXQsIGFuZCBzb21lIG90aGVy
IGNhbGxzDQp0byBiZHJ2X3RydW5jYXRlLCBleGNlcHQgZm9yIHFjb3cyIGltYWdlIGNyZWF0aW9u
IG9mIGNvdXJzZS4NCg0KVGhlbiwgdG8gaW1wcm92ZSB0aGlzIG1vZGUgaGFuZGxpbmcgaW4gcWNv
dzIsIHRvIG5vdCBhbGxvY2F0ZSBhbGwgTDIgdGFibGVzLCB3ZQ0KbWF5IGFkZCAiemVybyIgYml0
IHRvIEwxIHRhYmxlIGVudHJ5Lg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

