Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131A9C3A5A4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D600A2189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QaRYT7GX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D600A2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2yRu-0003EN-V6
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 09:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2yQ7-0001cP-LN
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2yQ5-00080J-HY
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:55:30 -0400
Received: from mail-eopbgr10115.outbound.protection.outlook.com
 ([40.107.1.115]:41349 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i2yQ4-0007yO-GD
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:55:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/cOD/MZICLQrTCLDS4SozilImnTyRf95XULZRC9xO6sIfXQrdtVj0VDJ2jKvHyy5R93+gOwOpLyxSCvJdh/Yzpy65NC/PNJvGyxzhvtdxoCIrAmrK9KhdsUYkoVZftBwVgmGQyI1KWYbmEhn1YFyZonxSBXXwHuxv39+0qch7OPGJUvd1GDl8qWPozRJ2FmTt7QwHzh4ZSP5+app4B5v+FToqE+fC8xGx56NPHxrMpt0LAnCMsWxQtSuW1NwTZsVDfl9ugpIs1bZaZfnH4JDlUSZM/tljl7gyn+MhJ7YYwKmPTLW5tVawUACOKyQNktkALaS79NdqWyo4ANAo7dBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM5Y5QU9Cno6d8jrF7AZQAnNTF/lkOl4T8kXZ1spt7c=;
 b=M+IUeUsYw+QDNiBf05UEbov++0hWGQrvemX5cJZNmdUrNjnN5GPFh1SzLyIKEEdAvJVqFJTTsjwtGCgx6lKCQZWpqWKJ81Ov1No5OCiDD69IWW8Ky9qrZQ8AmRQ/XLQjlJ+zarClpZlzpVN5U1Nf08MLgLYQQW01R3dA+Md3H7m5AO+N4RuV8B3pKMh3Kkq2B2yBmu/bMsmE+HhNP12rGYigISYK0P2PKdRwAhhM6VRJo3IZu4px6LkM6gWNjhu8xfVHRrAA64Ryb/oqkrz2Tx4AGJWoSGMVWPAvIghXvk4YGbBZeUgBbVlylPro7O9IxD5MWldD6GwWMIwhYbK0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM5Y5QU9Cno6d8jrF7AZQAnNTF/lkOl4T8kXZ1spt7c=;
 b=QaRYT7GXilkVuK4v+M5V8dP/OGuNQWQxEOrmdXNE+DiGjMx3OdoOeHm0kjNZUmnX7wjNLl2ElnfkRaCSzPXIYNgrkU78wDCNMmRFbwMzeqlBe/hZh+2UAWkyPUmwjtktfGLp7Je2elIMDMbK/RhBfvNdQHanNHeFbY1jY96383A=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4091.eurprd08.prod.outlook.com (20.179.8.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 13:55:24 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 13:55:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 0/5] Add NBD fast zero support to qemu
 client and server
Thread-Index: AQHVWcI+3t/P2rVYrEWWUrw+KaYc6qcQnPKA
Date: Wed, 28 Aug 2019 13:55:24 +0000
Message-ID: <9d2ee7ad-a575-dc33-a7c7-dcaceea63792@virtuozzo.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143726.27062-1-eblake@redhat.com>
In-Reply-To: <20190823143726.27062-1-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0002.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::12) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190828165521422
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd4ae992-c15e-4821-51c5-08d72bbf5fee
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4091; 
x-ms-traffictypediagnostic: DB8PR08MB4091:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB8PR08MB4091FE941391CB0BFA68C2BEC1A30@DB8PR08MB4091.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(136003)(376002)(366004)(396003)(189003)(199004)(478600001)(6116002)(2906002)(66066001)(31696002)(229853002)(110136005)(305945005)(36756003)(7736002)(256004)(446003)(2616005)(486006)(11346002)(476003)(316002)(53936002)(86362001)(31686004)(3846002)(2501003)(6246003)(6306002)(8676002)(66556008)(71190400001)(81166006)(71200400001)(6512007)(99286004)(64756008)(76176011)(386003)(66946007)(5660300002)(66446008)(52116002)(6436002)(26005)(186003)(6486002)(102836004)(25786009)(8936002)(14444005)(81156014)(6506007)(4744005)(66476007)(4326008)(14454004)(966005)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4091;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tz+rJkUGKj/71add59vSfaGGsul6IupXMLb6SunPSb+H0kL7FQF4CM0yN0kK2ODuucwaU4M2+gexl+YF8fTy2fXJcVjLtkBGWpO/xZaIazwqfIW2jPCdeN4cMVx90eRR+M6xElbZbfgpBF1ui2eVBh0ixRMJm9dXV6UV83Hl+lShgYUdR0oHS/rhOpYa3KLMSE7mrXJEXksAkRLLcKrNR197WvqexjO+H5zDla4LXHYT7EoQekZMrhXbHv7nVYnKVxKhRs1zisNavx4TbhLNRI1Tg7JWDKofEd9T/GAJpa+1/w+/1qmG9oBZtesVyzsyP8wamTkF0z+Be7aupxPsq+HMtvueP7SCkTVVK1Jecvrz6rLNJPfVu5ufDUEXqX7DXfflNz175jK5OTfutmXKEOOY+sxTtZ0Qew9nlwJeIkw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D3161F2E2D2A84884C86ECBCD290B6F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4ae992-c15e-4821-51c5-08d72bbf5fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 13:55:24.6491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XAp+FkwBnXWaDd7WAqEOQREZa5IumdUH+Maqxf8cWRiY+A7e0yg+vfnh5H/iayCb8p62sGpZw4UphY54eXe1UYZh3HvMaq4NFSu6gI4XDL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4091
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.115
Subject: Re: [Qemu-devel] [PATCH 0/5] Add NBD fast zero support to qemu
 client and server
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
Cc: "libguestfs@redhat.com" <libguestfs@redhat.com>,
 "nbd@other.debian.org" <nbd@other.debian.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjMuMDguMjAxOSAxNzozNywgRXJpYyBCbGFrZSB3cm90ZToNCj4gU2VlIHRoZSBjcm9zcy1wb3N0
IGNvdmVyIGxldHRlciBmb3IgbW9yZSBkZXRhaWxzOg0KPiBodHRwczovL3d3dy5yZWRoYXQuY29t
L2FyY2hpdmVzL2xpYmd1ZXN0ZnMvMjAxOS1BdWd1c3QvbXNnMDAzMjIuaHRtbA0KPiANCj4gQmFz
ZWQtb246IGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5
LTA4L21zZzA0ODA1Lmh0bWwNCj4gW0FuZHJleSBTaGlua2V2aWNoIGJsb2NrOiB3b3JrYXJvdW5k
IGZvciB1bmFsaWduZWQgYnl0ZSByYW5nZSBpbiBmYWxsb2NhdGUoKV0NCg0KSSBhc3N1bWUsIEkg
Y2FuIGxvb2sgYXQgZ2l0Oi8vcmVwby5vci5jei9xZW11L2VyaWNiLmdpdCBmYXN0LXplcm8gYnJh
bmNoPw0KDQo+IA0KPiBFcmljIEJsYWtlICg1KToNCj4gICAgbmJkOiBJbXByb3ZlIHBlci1leHBv
cnQgZmxhZyBoYW5kbGluZyBpbiBzZXJ2ZXINCj4gICAgbmJkOiBQcmVwYXJlIGZvciBOQkRfQ01E
X0ZMQUdfRkFTVF9aRVJPDQo+ICAgIG5iZDogSW1wbGVtZW50IGNsaWVudCB1c2Ugb2YgTkJEIEZB
U1RfWkVSTw0KPiAgICBuYmQ6IEltcGxlbWVudCBzZXJ2ZXIgdXNlIG9mIE5CRCBGQVNUX1pFUk8N
Cj4gICAgbmJkOiBUb2xlcmF0ZSBtb3JlIGVycm9ycyB0byBzdHJ1Y3R1cmVkIHJlcGx5IHJlcXVl
c3QNCj4gDQo+ICAgZG9jcy9pbnRlcm9wL25iZC50eHQgfCAgMyArLQ0KPiAgIGluY2x1ZGUvYmxv
Y2svbmJkLmggIHwgIDYgKysrLQ0KPiAgIGJsb2NrL25iZC5jICAgICAgICAgIHwgIDcgKysrKysN
Cj4gICBibG9ja2Rldi1uYmQuYyAgICAgICB8ICAzICstDQo+ICAgbmJkL2NsaWVudC5jICAgICAg
ICAgfCAzOSArKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gICBuYmQvY29tbW9uLmMgICAgICAg
ICB8ICA1ICsrKysNCj4gICBuYmQvc2VydmVyLmMgICAgICAgICB8IDcwICsrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgcWVtdS1uYmQuYyAgICAgICAgICAg
fCAgNyArKystLQ0KPiAgIDggZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKSwgNTIgZGVs
ZXRpb25zKC0pDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

