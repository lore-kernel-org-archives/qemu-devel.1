Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C87C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 13:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1CD206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 13:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T476C7mf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1CD206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsp1P-0004Sx-AC
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 09:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56649)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hsp0w-0003mT-Q7
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 09:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hsp0v-0002dR-QD
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 09:51:34 -0400
Received: from mail-am5eur03on070f.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::70f]:57059
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hsp0v-0002aj-1I; Wed, 31 Jul 2019 09:51:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6ijQik+3TnlkUKbAVz26f22FBcN4EBhhhtv2XjD+z66lypiO6Z7AEH48JPUg4OXIu1xiGNOmdythkU7JS/6rOL1uvnBaMWgocFFKKHTSPtVR75i3lRjLIUw7aSuDkDrfPftPIQSQE1NkgfT7Tpk6Yj3loKG2WBB2HYdlGSpx+DpeC2k7YrMkVn6rzgRaGHV2713EzjM9gWLyZfQPVJUs/p1vAsUJn2MIhHmxNhopO407FiMegCExQ9HebvOjB35MdJqrLxmbtJCfYDNnOxvzKYClhXkCT16P8aTiyfGtQTzPhFq4aFHTvRW6Giq4OMP5nwmGObDOOjVqr6lvTAm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOiYDhlmPB9kodt3wl7J1gbbx9eIXN77Hd8qBeHmf7k=;
 b=MCnu8TFvRaMVnGfVLIwM+tc6amx/rj5o6szHuYHPaJpttIF7eiDIEZcjbHxqkhMZh/dymAvUI+0cUonBI3yVVNB8I1qO1irEH396DH3LQlawwOlipq9GCXrFXp8wvI02nwc7wE0JYiWwZH6f3kwugTe2x3ylMEw7UefXdYNy+AHi6rz4/ZXt5Npsh5C5LxjK6UF6UVHleeOWZcmS4dp2HyEQXIu4O8PtfTnnh6EQV/XpiXEcLrYMkOAC3DcLh4DaNkmFaregi4GpDfzMMPMcbWxefnvNr2c9A05K5dW68e7KJbU8s510Wam+kYiSD0Y1y72iW54hm9XOQ4XbyJo3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOiYDhlmPB9kodt3wl7J1gbbx9eIXN77Hd8qBeHmf7k=;
 b=T476C7mfuHFGx6n4PCkySfH1k87mmyHhk2fBnvLerpWJweTX0+UqBiASfbfroIjC4m+X9uFgTlXI3XRvUlL0g9qjiaexWeq4bikRcIuA12r36tfhwYV+cZT0nV7VoF3HZOzdfDWHytrXYRvpfo/pybAuB8siZOFSWJOQmMcRz74=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5145.eurprd08.prod.outlook.com (10.255.18.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 13:51:30 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 13:51:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 2/3] block/backup: disable copy_range for
 compressed backup
Thread-Index: AQHVRvRzGRUbRY4DSk2j0h+STQvfFabjeZ6AgAFGkAA=
Date: Wed, 31 Jul 2019 13:51:30 +0000
Message-ID: <e0ef3073-56dd-ba27-8606-a7ea8a89bb9d@virtuozzo.com>
References: <20190730163251.755248-1-vsementsov@virtuozzo.com>
 <20190730163251.755248-3-vsementsov@virtuozzo.com>
 <fb49cc91-08cf-f2a8-da7c-7c648bf3317e@redhat.com>
In-Reply-To: <fb49cc91-08cf-f2a8-da7c-7c648bf3317e@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0185.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::33) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190731165126757
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7a43976-b98d-49b2-b7b7-08d715be30c5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5145; 
x-ms-traffictypediagnostic: DB8PR08MB5145:
x-microsoft-antispam-prvs: <DB8PR08MB5145E16738B298AAB85F307FC1DF0@DB8PR08MB5145.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(39850400004)(366004)(346002)(396003)(199004)(189003)(86362001)(8676002)(478600001)(81156014)(81166006)(8936002)(99286004)(2501003)(476003)(486006)(68736007)(5660300002)(2616005)(11346002)(31696002)(446003)(6246003)(305945005)(36756003)(2906002)(7736002)(52116002)(14454004)(76176011)(66066001)(110136005)(71200400001)(54906003)(102836004)(6486002)(66946007)(66476007)(386003)(64756008)(53546011)(6116002)(3846002)(66556008)(6506007)(66446008)(31686004)(107886003)(229853002)(316002)(53936002)(71190400001)(186003)(256004)(4326008)(6436002)(26005)(25786009)(6512007)(14444005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5145;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ypycqk5SfAsRKc3Jq/Jbtp6ut8FDd2cQ0tRYjgR6rhlL4cIMHvv+yQg3FaYUDghq5sP/Hqb4tu37lt2uSpKh2NislcF0DCPyI89qUnxpjIMqcet6pZFOM1Qw7Nkgy+qAMZqh9nMmN4ULtolAqGe9uVKnczPbI0Bppsry6wQwcMEjeMDUvXBS4XsUVmiLqvLMeAHFlM6iGhVMAUS3gkkHE9Babf/OwfOa+kkJG0W3HkjM6yxdGXRFhvyKt5ePUmkIXq7zSpDCQljbYDgzwWXUeIRCylGNfUSVciiIu8q5J0VZDghFCZQrbms+JaELVdn+WQTDZ8FirYxFtPd/hnBMUzAo/J81OyAwBSLqCkOKwjyEHU8a0woHzWWJBV0bwvrSHMrz2cTNOSaWyjGd4rLmfsrbjHFWubvKJQPeMBFzCPc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D67B8995B9B3C449B106B8213ECC8F7E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a43976-b98d-49b2-b7b7-08d715be30c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 13:51:30.4669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5145
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::70f
Subject: Re: [Qemu-devel] [PATCH 2/3] block/backup: disable copy_range for
 compressed backup
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
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMDcuMjAxOSAyMToyMiwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDcvMzAvMTkg
MTI6MzIgUE0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBFbmFibGVk
IGJ5IGRlZmF1bHQgY29weV9yYW5nZSBpZ25vcmVzIGNvbXByZXNzIG9wdGlvbi4gSXQncyBkZWZp
bml0ZWx5DQo+PiB1bmV4cGVjdGVkIGZvciB1c2VyLg0KPj4NCj4+IEl0J3MgYnJva2VuIHNpbmNl
IGludHJvZHVjdGlvbiBvZiBjb3B5X3JhbmdlIHVzYWdlIGluIGJhY2t1cCBpbg0KPj4gOWRlZDRh
MDExNDk2Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gICBibG9jay9iYWNrdXAu
YyB8IDIgKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2JhY2t1cC5jIGIvYmxvY2svYmFja3VwLmMN
Cj4+IGluZGV4IGY0YWFmMDhkZjMuLmM1Zjk0MTEwMWEgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9i
YWNrdXAuYw0KPj4gKysrIGIvYmxvY2svYmFja3VwLmMNCj4+IEBAIC02NDUsNyArNjQ1LDcgQEAg
QmxvY2tKb2IgKmJhY2t1cF9qb2JfY3JlYXRlKGNvbnN0IGNoYXIgKmpvYl9pZCwgQmxvY2tEcml2
ZXJTdGF0ZSAqYnMsDQo+PiAgICAgICBqb2ItPmNsdXN0ZXJfc2l6ZSA9IGNsdXN0ZXJfc2l6ZTsN
Cj4+ICAgICAgIGpvYi0+Y29weV9iaXRtYXAgPSBjb3B5X2JpdG1hcDsNCj4+ICAgICAgIGNvcHlf
Yml0bWFwID0gTlVMTDsNCj4+IC0gICAgam9iLT51c2VfY29weV9yYW5nZSA9IHRydWU7DQo+PiAr
ICAgIGpvYi0+dXNlX2NvcHlfcmFuZ2UgPSAhY29tcHJlc3M7IC8qIGNvbXByZXNzaW9uIGlzbid0
IHN1cHBvcnRlZCBmb3IgaXQgKi8NCj4+ICAgICAgIGpvYi0+Y29weV9yYW5nZV9zaXplID0gTUlO
X05PTl9aRVJPKGJsa19nZXRfbWF4X3RyYW5zZmVyKGpvYi0+Y29tbW9uLmJsayksDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBibGtfZ2V0X21heF90cmFuc2Zl
cihqb2ItPnRhcmdldCkpOw0KPj4gICAgICAgam9iLT5jb3B5X3JhbmdlX3NpemUgPSBNQVgoam9i
LT5jbHVzdGVyX3NpemUsDQo+Pg0KPiANCj4gQWdyZWUsIHRoZXNlIGFyZW4ndCBjb21wYXRpYmxl
IG9wdGlvbnMuIElzIHRoaXMgd29ydGggYSBub3RlIGluDQo+IGRvY3MvaW50ZXJvcC9saXZlLWJs
b2NrLW9wZXJhdGlvbnMucnN0Pw0KDQpVc2VfY29weV9yYW5nZSBpcyBub3QgYW4gdXNlci12aXNp
YmxlIG9wdGlvbiBhbmQgaXQncyBub3QgZG9jdW1lbnRlZCBhcyBJIGNhbiBzZWUsDQpzbyBJIHRo
aW5rIHdlIGRvbid0IG5lZWQuDQoNCj4gDQo+IFJldmlld2VkLWJ5OiBKb2huIFNub3cgPGpzbm93
QHJlZGhhdC5jb20+DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

