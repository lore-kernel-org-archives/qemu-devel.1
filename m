Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3E4C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D1C2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z6tcqDBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D1C2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxDX7-0006x6-Db
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 12:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56890)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxDWS-000649-4C
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxDWR-0003LZ-3S
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:50:16 -0400
Received: from mail-eopbgr60091.outbound.protection.outlook.com
 ([40.107.6.91]:25668 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxDWQ-0003L0-Uv; Mon, 12 Aug 2019 12:50:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR1spzc3bIJEWPI94g64tBCPZNTTC3GqCrdqesHfywRAvs9fTComtDDpC9U0LUJ9EdHHrzzfMzgQqM0FMkImVDwhwJ9rZhbqqHPcF7Kbx21IN5mN3wBlhBCEIMGHK2gs4e/v2GQQtbhyLQQujm7I0k5AINdTp2khU1Ts9XrGHrTiVIdoAzLkzwTIbTFtQSO2W4iEglSRIGMBI32211aNad3sG5Hn0X1bcyS/SzLVtmGAzfrXVNYaeLcQxHws8GuqcBoSM6gefBdZr5iW5AYkC32XxumJoUF4QVs6vquvedUNCwYIFlxyA3I5/RE5fxL1qtDBpw3ihmvLj3gtcIrvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTmZkVtC9Ffc8hqCvrYfjVu6fa8KfehI++RiFKRmpfc=;
 b=hyEAQv6hkcGctHazs05LSDMVYnsFowULVqaGGc9782FMackcLIAR+JWyYeLR9vKEJnFBQocwIE01qGrUbi95wxDkEswgWGhzv1akwUF+Y5hyuL5hY5peW84uW4wio1ATt3RsMC6EErwkVbWaQKqJ3mkRzHapfGq0K+cenIMMHr+z49Oa2ef9zwbz7KG4E4+k1X5eX1ul2Eb0v04Erhz2vbK10evmmcTeY7zZd+helN7iLHbXtc0qQajLNrxKqkXr/EbT6d3we7jcra3NAP3BJggoSo/Xv3JnCSS0c+7sDdTw79t7RliCrXFSnqyAzoTD/WB1mMx5vl12o56AaoKK9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTmZkVtC9Ffc8hqCvrYfjVu6fa8KfehI++RiFKRmpfc=;
 b=Z6tcqDBr7nnpVzJ1w/Z0J9+jk8z5nSdJIGFmh/gTB8Xp1TN0so/A8YE5GgnWgBkzXT5WxOTLgg3QZV+Mydpn87z7BmonJmsMCjt2PyGntktMU2guJGTTXedM3EU1RnX9M+6Up6dY1aP4uRkjyPwdcg/ugH8KAY/njtYCfas/KaQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5081.eurprd08.prod.outlook.com (10.255.19.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 16:50:11 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 16:50:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 3/3] vpc: Do not return RAW from block_status
Thread-Index: AQHVQwFgmtJInCYBUkSBviHaT9mW1ab3wI+AgAAGWwCAAA8TgA==
Date: Mon, 12 Aug 2019 16:50:11 +0000
Message-ID: <eaf85ded-c537-ceb3-9277-6765bb672daa@virtuozzo.com>
References: <20190725155512.9827-1-mreitz@redhat.com>
 <20190725155512.9827-4-mreitz@redhat.com>
 <627fbb64-5ffe-aca7-6198-9d991d4219e3@virtuozzo.com>
 <f50d585c-ac91-5dfa-365b-efda321aeffa@redhat.com>
In-Reply-To: <f50d585c-ac91-5dfa-365b-efda321aeffa@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0249.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::25) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190812195009234
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e931442b-c376-48cf-5fdf-08d71f452435
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5081; 
x-ms-traffictypediagnostic: DB8PR08MB5081:
x-microsoft-antispam-prvs: <DB8PR08MB5081CEFEC2399CA8B68BBDF9C1D30@DB8PR08MB5081.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(39840400004)(346002)(376002)(199004)(189003)(81166006)(6486002)(25786009)(5660300002)(31696002)(8936002)(81156014)(8676002)(256004)(64756008)(66556008)(66476007)(66446008)(66946007)(3846002)(6436002)(86362001)(53936002)(6116002)(2906002)(4326008)(6246003)(110136005)(54906003)(6512007)(71200400001)(71190400001)(7736002)(102836004)(386003)(52116002)(6506007)(14454004)(2501003)(186003)(305945005)(76176011)(53546011)(316002)(476003)(486006)(31686004)(66066001)(99286004)(478600001)(11346002)(446003)(36756003)(26005)(2616005)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5081;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qhkCMn2tzQQH4vxdhLgOtnfX4qA/4lZYme3rgNiialGP9Oy+8ZPBpBGMy4s2QFFmlvYJkBmwgjXBmri24hX7us3BbDvmhDg5awTTzQ0XPtO8Q1wajbgnxkVJt8zY5LIllTxjdOulwa9gITybIDL7EFOcuUgp1RE+yn0akqZryItDCanbj+126Quwwheh8r4lj/bRUWCE6ca8FEGeKJ+aoETuP0FWj5yxWSI6LDmvDHd3oDZjVOFK4c1zxhfY9MAF01dy6I2vDMZgzS7zS4c1+9PvdeiPbZb6la1uPUoSGnT0tIlO3iaD2G9wGNUyddrX4kLkOlC7sd0m52DbiytKj4LUbZoydeeOHx5urHsG1qiB2q7KX/Nm7Naf7D+JcjmVyv40vmr2KgpLlzlGGrPBv12hnYvR9KG0vIc9Cr5glE8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9379BB9FCF5F8940B88F28BD48556C99@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e931442b-c376-48cf-5fdf-08d71f452435
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 16:50:11.8477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFeSZMCNZjysF775Tn/oUfJ7UaOs8QpDCc+bgG4x1xphrnatBjF4nf603grnFDrg8VkrcHouCSD37UL82GUHQaGE0fOu1r6ociaL0stAQ9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5081
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.91
Subject: Re: [Qemu-devel] [PATCH 3/3] vpc: Do not return RAW from
 block_status
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDguMjAxOSAxODo1NiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMi4wOC4xOSAxNzozMywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDI1LjA3LjIwMTkgMTg6NTUs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiB2cGMgaXMgbm90IHJlYWxseSBhIHBhc3N0aHJvdWdoIGRy
aXZlciwgZXZlbiB3aGVuIHVzaW5nIHRoZSBmaXhlZA0KPj4+IHN1YmZvcm1hdCAod2hlcmUgaG9z
dCBhbmQgZ3Vlc3Qgb2Zmc2V0cyBhcmUgZXF1YWwpLiAgSXQgc2hvdWxkIGhhbmRsZQ0KPj4+IHBy
ZWFsbG9jYXRpb24gbGlrZSBhbGwgb3RoZXIgZHJpdmVycyBkbywgbmFtZWx5IGJ5IHJldHVybmlu
Zw0KPj4+IERBVEEgfCBSRUNVUlNFIGluc3RlYWQgb2YgUkFXLg0KPj4+DQo+Pj4gVGhlcmUgaXMg
bm8gdGFuZ2libGUgZGlmZmVyZW5jZSBidXQgdGhlIGZhY3QgdGhhdCBiZHJ2X2lzX2FsbG9jYXRl
ZCgpIG5vDQo+Pj4gbG9uZ2VyIGZhbGxzIHRocm91Z2ggdG8gdGhlIHByb3RvY29sIGxheWVyLg0K
Pj4NCj4+IEhtbS4gSXNuJ3QgYSByZWFsIGJ1ZyAoZml4ZWQgYnkgdGhpcyBwYXRjaCkgPw0KPj4N
Cj4+IEFzc3VtZSB2cGMtPmZpbGUgaXMgcWNvdzIgd2l0aCBiYWNraW5nLCB3aGljaCBoYXZlICJ1
bmFsbG9jYXRlZCIgcmVnaW9uLCB3aGljaCBpcw0KPj4gYmFja2VkIGJ5IGFjdHVhbCBkYXRhIGlu
IGJhY2tpbmcgZmlsZS4NCj4gDQo+IENvbWUgb24gbm93Lg0KPiANCj4+IFNvLCB0aGlzIHJlZ2lv
biB3aWxsIGJlIHJlcG9ydGVkIGFzIG5vdCBhbGxvY2F0ZWQgYW5kIHdpbGwgYmUgc2tpcHBlZCBi
eSBhbnkgY29weWluZw0KPj4gbG9vcCB1c2luZyBibG9jay1zdGF0dXM/IElzIGl0IGEgYnVnIG9m
IEJEUlZfQkxPQ0tfUkFXIGl0c2VsZj8gT3IgSSBkb24ndCB1bmRlcnN0YW5kDQo+PiBzb21ldGhp
bmcuLg0KPiANCj4gSSB0aGluayB3aGF0IHlvdSBkb27igJl0IHVuZGVyc3RhbmQgaXMgdGhhdCBp
ZiB5b3UgaGF2ZSBhIHZwYyBmaWxlIGluc2lkZQ0KPiBvZiBhIHFjb3cyIGZpbGUsIHlvdeKAmXJl
IGRvaW5nIGJhc2ljYWxseSBldmVyeXRoaW5nIHdyb25nLiA7LSkNCj4gDQo+IEJ1dCBtYXliZSB3
ZSBzaG91bGQgZHJvcCBCRFJWX0JMT0NLX1JBVy4uLiAgRG9lcyBpdCBkbyBhbnl0aGluZyBnb29k
IGZvcg0KPiB1cyBpbiB0aGUgcmF3IGRyaXZlcj8gIFNob3VsZG7igJl0IGl0IHRvbyBqdXN0IHJl
dHVybiBEQVRBIHwgUkVDVVJTRT8NCj4gDQoNCkFuZCBpZiBJIGhhdmUgcmF3IGRyaXZlciBhYm92
ZSBxY293MiwgaXQgd2lsbCBub3Qgd29yaywgbGlrZSBJJ3ZlIGRlc2NyaWJlZCBhYm92ZS4uDQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

