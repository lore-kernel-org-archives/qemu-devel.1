Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D2AC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6A4206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LrL2m2mC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6A4206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIJB-0000w0-2I
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idICj-0001qb-HY
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idICi-0004VJ-Db
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:19:49 -0500
Received: from mail-eopbgr00090.outbound.protection.outlook.com
 ([40.107.0.90]:40519 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1idICe-00049p-ER; Fri, 06 Dec 2019 13:19:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4S5HGssWte+fBaQz9j5gicSD0YoAFGsUACf1QolZhVK4sj0TsA5zD65VSAnvMFo999T96GFm+4Bhbrtl24DECv/QDS5QmEqu+dxDN79w6MjWw+dr8xIcxTamiIOpVe7AidSDPpRAfjH1LJxylLeqlSpegNfJ1BLZSArlcauCNCGHnEHSvdxaCy+3TIenPAOjSVBvD5mnOlDxCpCZ6GibueJougiN6lLvBWiJw5ZgKzpoEhOHq5vKIhmfVJljLX4nxxTV6K/rPOLCkqoey8gluiLR9aN1WcPS5ob4/9mqfWHFqKPxVsDKOsGljVfISdDtqKAu0JFW4fRMEGR5w0IZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp/sE/amAVs4QOWn0J8g9D4MNlI7XOa9eQ+XL6IoUaU=;
 b=XMgGqPF8F53y5+c1YsrNora8vVX1jfj36ThNkWtxCV2c5Dwz0tDqX6xL/QZM9aLk42kZdyk938kB12DB1JbJ59clWTCTaCx5mEssxlBDde798KoS0ec6NbTlcornS2nhVDgwVAvVGPSVwfmGCmtTXVPHQ1Axszn3bgACySnOa6QCtg21CxsXhgtM8euAbshwaANdIMlndd2ZMWslOqynZgc5kUNnpg0CRGrb8P6wXsxRc9qzWMq1nkPtK0HEloR2QC2G07jSRd7dK4GsxR0kENByC/VVrHVaT752w6ZqB3gaui/IgDSfQf+b/+CPjUiBzbyOdNMg4YFU7g2GqBebng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp/sE/amAVs4QOWn0J8g9D4MNlI7XOa9eQ+XL6IoUaU=;
 b=LrL2m2mCdf5A8ZkVfiFClihgSJ2Kxijsl9BvHtFSvJl4HjuEPY3/1HXL1vdpn0uBmABWyUZmDbaFQWATBZL9bKCDzoXtUsDdEcmYJ9RQ12TvY5KJbZvQEQRNQ1SiYsKq5wSN8LPKhXLCzNzwHyKln1aWxKzmDGzBsoDTMvySkTc=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3944.eurprd08.prod.outlook.com (20.179.0.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Fri, 6 Dec 2019 18:19:36 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 18:19:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v8 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
Thread-Topic: [PATCH v8 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
Thread-Index: AQHVq5P39bmAjGXCHEaLeEVAT9ClqKer0iSAgAFy2iqAACdEgA==
Date: Fri, 6 Dec 2019 18:19:36 +0000
Message-ID: <6d55367c-42a3-3622-a483-d997b428796d@virtuozzo.com>
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-22-vsementsov@virtuozzo.com>
 <54278946-ad45-1a0d-e2b2-f96b86285c05@redhat.com>
 <8736dxcuo5.fsf@dusky.pond.sub.org>
In-Reply-To: <8736dxcuo5.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0002.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::12) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191206211933925
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77b57994-b57d-4c1c-4c50-08d77a78d9ab
x-ms-traffictypediagnostic: AM6PR08MB3944:
x-microsoft-antispam-prvs: <AM6PR08MB39446C60E88CE445A465B2CDC15F0@AM6PR08MB3944.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(376002)(346002)(366004)(39840400004)(199004)(189003)(53546011)(8676002)(6506007)(81166006)(81156014)(8936002)(102836004)(71190400001)(4326008)(2906002)(2616005)(36756003)(64756008)(76176011)(66556008)(66476007)(66946007)(52116002)(66446008)(26005)(99286004)(71200400001)(110136005)(5660300002)(54906003)(86362001)(478600001)(305945005)(31696002)(316002)(31686004)(229853002)(186003)(6512007)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3944;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ju0dsAyJkiS0Ce4gEpb+M62reejl/1E7AdONsnoNfTWeRCCrSvIaUMPPOLH1QIAxHQcMTxEThFB+JE1lferoe7sozBrpGyaMT+me3wyIZz3qVfWFaua65O0tCHv2Ku9LooD8+hSTiEj+vBxy3i2e7pDMQZuEXtw4/jQ2SOxcH7fHnliKuII+7S5y6mcVIHTFS6F1AXzM0aCmWQDOs96pBsQBpCQSF2P8T9g+eysmW0PzPNp73iSZOkwR24U7bmglm8UHEa5Hv2vOzt3vF6L1XuzF/dLG+5Q5lPl9COw0823Fd/+9or05woBJ5uvQKrfgoLLqMSCWSOfwBttLLcnCYUr6/0L79IbFNuFM6avLBZ1JEvaXfu/kZEwqn1ciHHi4HE1hB1nfBc9fSh/mEOqtSj1kURgVOlYx9FpRs/kfC5IicmjkKgiEle0FNOw1vq4c
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <16CEBA86AE592244A064200C24F72D32@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b57994-b57d-4c1c-4c50-08d77a78d9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 18:19:36.4849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fT+EKqvlR3ucE07/l5yZVkgtQ9OZ0XFfsOa691jyxb872NYYFs1FDkXjF+bpxN4578EWAaJgcBsbtCV9tZM0QPnv2iNFaRhftMb8bsK71MI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3944
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.90
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMTIuMjAxOSAxODo1OCwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IEVyaWMgQmxha2Ug
PGVibGFrZUByZWRoYXQuY29tPiB3cml0ZXM6DQo+IA0KPj4gT24gMTIvNS8xOSAxMTo0NiBBTSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+PiBUaGUgbG9jYWxfZXJyIHBh
cmFtZXRlciBpcyBub3QgaGVyZSB0byByZXR1cm4gaW5mb3JtYXRpb24gYWJvdXQNCj4+PiBuYmRf
aXRlcl9jaGFubmVsX2Vycm9yIGZhaWx1cmUuIEluc3RlYWQgaXQncyBhc3N1bWVkIHRvIGJlIGZp
bGxlZCB3aGVuDQo+Pj4gcGFzc2VkIHRvIHRoZSBmdW5jdGlvbi4gVGhpcyBpcyBhbHJlYWR5IHN0
cmVzc2VkIGJ5IGl0cyBuYW1lDQo+Pj4gKGxvY2FsX2VyciwgaW5zdGVhZCBvZiBjbGFzc2ljIGVy
cnApLiBTdHJlc3MgaXQgYWRkaXRpb25hbGx5IGJ5DQo+Pj4gYXNzZXJ0aW9uLg0KPj4+DQo+Pj4g
U2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2
aXJ0dW96em8uY29tPg0KPj4+IC0tLQ0KPj4+ICAgIGJsb2NrL25iZC5jIHwgMSArDQo+Pj4gICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pg0KPj4gT3VyIHRpbWluZyByZXN1bHRl
ZCBpbiBjcm9zc2VkIG1haWxzIC0gSSB3YXMgcmVwbHlpbmcgdG8gdjcgd2hlbiB0aGlzDQo+PiBs
YW5kZWQsIGFuZCBteSByZXBseSB0aGVyZSBpcyBzdGlsbCByZWxldmFudCAobmFtZWx5LCBhIGJl
dHRlciBjb21taXQNCj4+IG1lc3NhZ2UgaXMgbmVlZGVkLCBidXQgdGhlIGNvZGUgZ2V0cyBteSBS
LWIgd2l0aCB0aGF0IGNoYW5nZSkuDQo+IA0KPiBJZiB2OCB0dXJucyBvdXQgdG8gYmUgZmluZSBl
eGNlcHQgZm9yIGNvbW1pdCBtZXNzYWdlIHR3ZWFrcywgSSdsbCBnbGFkbHkNCj4gdG8gdGhlc2Ug
aW4gbXkgdHJlZS4gIEp1c3QgdGVsbCBtZSB3aGF0IHRvIGRvIGluIGEgcmVwbHkgdG8gdGhpcw0K
PiBtZXNzYWdlLg0KPiANCg0KWWVzLCB0aGlzIHdvdWxkIGJlIGdyZWF0LCB0aGFua3MhDQoNClRo
ZSBvbmx5IHRoaW5nIGlzIHlvdXIgc3VnZ2VzdGlvbiBvbiBwYXRjaCAyMSwgYnV0IGl0IG1heSBi
ZSBhcHBsaWVkIGluIHNlcGFyYXRlIChhbmQgaXQncyBhY3R1YWxseSBhIHNlcGFyYXRlIHRoaW5n
KQ0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

