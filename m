Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E4C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4C920844
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qnmX/ocR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4C920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxY5D-0007LG-7n
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42389)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxY4d-0006dl-4a
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxY4c-0006dX-2m
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:46:55 -0400
Received: from mail-eopbgr50118.outbound.protection.outlook.com
 ([40.107.5.118]:21862 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxY4b-0006cy-Ra; Tue, 13 Aug 2019 10:46:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfjCZWM8Rg/sv8pCoryrUfI+YE5nv2x/pk7nRvpKM40qzmhsSs0hOXyEicT91RwKsg7RW4uAEyJmzofvS8sKZauGmZIKQXzjwqSIj92RerMVd8TVrj3hvhhwcio9RYZQ3ZNGou29dEVxV1OJUILP/n3JLlUcQAsTNhqOtgV7W+f6sSSp4jP4f4aHqw+LX9epjyZ+eu5ktbZWAwoDNwmIhv94SuPOpZI+OQcF4MJw9/cYdX0s7XUVOupBvoBwyAMslhWV1V+u7+uuk2ZP7WF/Nou/83XJCr0Dkogqpom7XmHlYk7VQXREczqG7BVAYA/0MuMEj02+fiIO2psYkEsFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFiI85EbPzvGZZd6AfCF9VkJLEEfJuzx7+N9VcgNTbU=;
 b=adpYN1e9VLTRVx3dp49sKIP7pfbS/7+kTccDj6ETs1dt0nmMsoKmsfDLki/6p5UEumbF2rHAOix1SX201m8s19HfmEUYdwvX0/GFjATts/pmMKL5PGzsH77XO3bUehtSETeZuxwUOwmh+x5iB8tye9XwhU0HeOdgQGN/CsYdBVrF21r7LFWsQqMmggI/sy/9gugbyWCWgWYDoMzT9ermHtyBBE4IcQ30DoPlssspRD3+kV9uivzGp8yodaVYBjvxCMzb4EU9oJCIG1+kGNEI8M8K32fCVSs9R6duh1N4VUTwwjE6+4vslPR5lS6VZer2l7yf2YwdX9fA1on1LfEIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFiI85EbPzvGZZd6AfCF9VkJLEEfJuzx7+N9VcgNTbU=;
 b=qnmX/ocRyK0keUKvhvZOPHycby/eLzA9C5VFqolh4Cu10XV+NtRFrZY86HAuZ1lZG99kWkRwZf12uYP6DzYL1t9BbJ0f47z+1MN0DVOHZPCI+2tit0VzkRwu//V6vLGBrikDU4wZOk3xeLteiR5Ww9EBGzc4u+NIfxLxGvtCYq8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4938.eurprd08.prod.outlook.com (10.255.16.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Tue, 13 Aug 2019 14:46:50 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 14:46:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH 0/2] deal with BDRV_BLOCK_RAW
Thread-Index: AQHVUTlscGMEUismPEagfLbq4nW+tab36tGAgAABHQCAANb8gIAABheAgAAIyICAAE6FgP//2BGAgAAsr4CAAARdAA==
Date: Tue, 13 Aug 2019 14:46:50 +0000
Message-ID: <48fa03d6-259d-9ded-dacb-a4975f8d24e4@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
 <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
 <3d5fcc5b-cdb0-f028-1ea2-af85850db20e@virtuozzo.com>
 <15cf7372-826a-0684-d6ad-90deea36959e@virtuozzo.com>
 <43fb7754-6f94-00f6-6172-70cbb53e787c@virtuozzo.com>
 <94ccf129-cc7e-2778-7688-fd718f8df249@virtuozzo.com>
 <20190813115115.GG4663@localhost.localdomain>
 <b0c32bfc-f4cf-0d46-beb8-ba4cf79b76c5@redhat.com>
In-Reply-To: <b0c32bfc-f4cf-0d46-beb8-ba4cf79b76c5@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0156.eurprd05.prod.outlook.com
 (2603:10a6:7:28::43) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813174648643
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab8d41d4-3bdb-44be-4486-08d71ffd1343
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4938; 
x-ms-traffictypediagnostic: DB8PR08MB4938:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB49382192DA431D1C5497D64AC1D20@DB8PR08MB4938.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(376002)(366004)(39840400004)(396003)(189003)(199004)(486006)(446003)(305945005)(76176011)(26005)(53546011)(6506007)(102836004)(7736002)(99286004)(66066001)(81166006)(81156014)(6486002)(229853002)(2616005)(8936002)(386003)(52116002)(36756003)(6436002)(107886003)(2906002)(6512007)(11346002)(476003)(71200400001)(4326008)(71190400001)(25786009)(53936002)(86362001)(6246003)(256004)(64756008)(66556008)(66946007)(66476007)(66446008)(31686004)(4744005)(5660300002)(14454004)(478600001)(6116002)(3846002)(8676002)(186003)(110136005)(54906003)(316002)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4938;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QSYOZnN+BU5PGfGrj1D8olpyTWUvXnx0pYK8hqbsr0H7dK12DYpQ6BD9BMj/ANNJuIlWiZ2x6S96YGnciWVLSzSxlNIADiKWGDk8n6HWwJbLedxB63vXzpSTwVnT2Hv2lPLb0IQXBbKspsx93N0QRM44lmWb9PlZo0s/BCOw25lLoiddy16t+dk45FSxssLdcDH5shiecF+vL9jFLqRKvROY6Obs2Ehfa+XYFF1Ge+fEKxX7C3JNIEeg7GX+Xm0c9tLeqpOQ85Va5W5DocMHDzqo22P7LcXRPK9WyVuTIiprpCPfMzc3xUW5lioRU+DYRLsvS1MHF7thB3p1E21J1s50q4j8Y2WL9RenbeiQoDWB4l8doC5cEKX087hCmuQU7P4wnFV2hKTt608TKcLsNR0IyznlNOx2l+Sc0Q4LFLo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6C44B3D67DD0948A413A2CB07140DD9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8d41d4-3bdb-44be-4486-08d71ffd1343
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 14:46:50.7637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +qHiz6vTV/mkya/iZVGXoMqJA81bGFYqVShz19B7xATk0ylRtoQqUeLsEod81p29nTF+pJ1hrrEBBxls/UwcFLVbSikS25ta8Ey523MwsSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4938
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.118
Subject: Re: [Qemu-devel] [PATCH 0/2] deal with BDRV_BLOCK_RAW
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDguMjAxOSAxNzozMSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMy4wOC4xOSAxMzo1MSwg
S2V2aW4gV29sZiB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPj4gSG0uLi4gVGhpcyBpcyBhIG1l
c3MuIDotKQ0KPiANCj4gSnVzdCBvdXQgb2YgY3VyaW9zaXR5OiBXaHk/DQo+IA0KPiBBcmVu4oCZ
dCB0aGVyZSBvbmx5IHR3byB0aGluZ3Mgd2UgcmVhbGx5IG5lZWQgZnJvbSB0aGUgYmxvY2tfc3Rh
dHVzDQo+IGluZnJhc3RydWN0dXJlPw0KPiANCj4gKDEpIFdoZXRoZXIgc29tZXRoaW5nIGlzIGFs
bG9jYXRlZCBpbiB0aGUgZ2l2ZW4gbGF5ZXIgb2YgdGhlIGJhY2tpbmcgY2hhaW4sDQo+IA0KPiAo
MikgV2hldGhlciB3ZSBrbm93IHRoYXQgYSBnaXZlbiByYW5nZSByZWFkcyBhcyB6ZXJvZXMuDQo+
IA0KPiBEbyB3ZSByZWFsbHkgbmVlZCBhbnl0aGluZyBlbHNlPw0KPiANCg0KcWVtdS1pbWcgbWFw
Pw0KDQoNCjEuIFdlIG5lZWQgdG8gZml4IHRoZSBidWcgc29tZWhvdw0KMi4gV2UgbmVlZCB0byBm
aXggY29tbWVudCBhYm91dCBkaWZmZXJlbnQgYmxvY2stc3RhdHVzIGZsYWdzLCBhcyBpdCByZWFs
bHkNCmxhY2tzIGluZm9ybWF0aW9uIG9mIHdoYXQgYWN0dWFsbHkgIkRBVEEiIG1lYW5zICh0b2dl
dGhlciB3aXRoICpmaWxlKS4NCkFuZCB3aGF0IGZpbmFsbHkgbWVhbnMgImFsbG9jYXRlZCIsIGNh
biB5b3UgZGVmaW5lIGl0IHByZWNpc2VseT8NCjMuIEZpeCBuYmQtc2VydmVyIHRvIGJlIGNsb3Nl
ciB0byBOQkQgc3BlYyBhYm91dCBibG9jay1zdGF0dXMNCg0KSSBtYWRlIHNldmVyYWwgdHJpZXMg
dG8gaW1hZ2luZSBbMV0gYW5kIFsyXSBidXQgbmV2ZXIgc3VjY2VlZGVkLi4NCg0KDQotLSANCkJl
c3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

