Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E559CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E787C21929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MrRb8AcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E787C21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO13N-0007As-N4
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iO0wP-00049V-TX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iO0wO-0007hF-VH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:51:49 -0400
Received: from mail-eopbgr10101.outbound.protection.outlook.com
 ([40.107.1.101]:55987 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iO0wL-0007dy-JC; Fri, 25 Oct 2019 10:51:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpP7Q2wmOEUAU0SDyicYs04HuCTyQsMnjAfXsFhIOUhBsphl8HToGRR8XOxEY6wySO6yqbCptVwvOgvCni1girE77ryJnCpuF52fe8odbJy9t3jsI8TuZJLgvr8181iLTNMPaKQ72amers8ZsTcL/HZTLzkcVA+T+ZfPFhDQj5RnMESZ5qLbxyunPVmIJx3nZavn4mzNroZrBzE2mKJiT+NkrnObYox7yUwFQC7KbBPL+rt2Eu3QnHPD8DbNQq+GMMYKAVAcRpu2FdFALYBBdytxdyiyMdebfEdaTsPaROwBHtF3hsCKv06YKXXZmC+F/dSiu0+faoaYfZKIdVrhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBBoP/nQl5xsdHFa7jwy59Vw61ZWmMmvIzjd4KIFcn4=;
 b=TI4TsGtyCaVQAKuSUcsdymOpc/6tKGuVT1aCqDbtXJz+m4MpNWNDtd92xV0bTDHJM3ToJyvO48cyf1qtqUDU8/HFQ8Chs8Ff3vf1sptFCYZEt70CDz3MP6fzVehf3hzPbI9LYEKNNm5uoeF22g8RXTSZ9px6fnSxQ2J4JtitZROhVtWPCeEZxeZf+Ku3wXJrvQYe8Eou8IFP1cVYvB9N1Y9fV0RpUu8x1LF+aqvmPmYQrfqtHzbGDJ2hOyS3kfkJNOWssKOefTdfkdnZoytgHWDrc8RN4KOzvmO+v4al4pN1TwzSauoZy9jQwAAkMgHS1x/isxS/4fccMInrFkJKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBBoP/nQl5xsdHFa7jwy59Vw61ZWmMmvIzjd4KIFcn4=;
 b=MrRb8AcXH8QP32YqGA+qZ5CZEMm2BkOwYdobgbcufk/4lVs1MoYP/3LBQ6acYbkwPilXv1e1SY0WjIGSaKLLx6Fjrh4fnr0BrpdTsL/u4BksSvUuPB/sWkJqbwblM2KSIhSoQfh0AT9DHcOGdp9+zwI/S06gkJmbzAL5dhJEAMs=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB3571.eurprd08.prod.outlook.com (20.177.108.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 25 Oct 2019 14:51:42 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2367.029; Fri, 25 Oct 2019
 14:51:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PULL 3/3] iotests: test nbd reconnect
Thread-Topic: [PULL 3/3] iotests: test nbd reconnect
Thread-Index: AQHViUXRzq5CGy1h5UabpD2t6ZqjHadrblwAgAAGgoA=
Date: Fri, 25 Oct 2019 14:51:42 +0000
Message-ID: <8a56ae72-a111-8e98-abd4-675bc8d43bf1@virtuozzo.com>
References: <20191023020126.24991-1-eblake@redhat.com>
 <20191023020126.24991-4-eblake@redhat.com>
 <4d5f2858-a0a1-a005-ef2e-056e7b0e8e88@redhat.com>
In-Reply-To: <4d5f2858-a0a1-a005-ef2e-056e7b0e8e88@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0045.eurprd09.prod.outlook.com
 (2603:10a6:7:15::34) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191025175139433
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32201da5-d1ad-411d-c4ce-08d7595ad90a
x-ms-traffictypediagnostic: AM0PR08MB3571:
x-microsoft-antispam-prvs: <AM0PR08MB357142778D45053C2EF5AE4BC1650@AM0PR08MB3571.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(39840400004)(346002)(366004)(396003)(199004)(189003)(102836004)(36756003)(2501003)(110136005)(76176011)(14444005)(53546011)(7736002)(31686004)(99286004)(3846002)(52116002)(386003)(6506007)(6116002)(25786009)(256004)(305945005)(4326008)(2906002)(186003)(66556008)(64756008)(66946007)(26005)(6246003)(66476007)(66446008)(6436002)(86362001)(6512007)(6486002)(66066001)(5660300002)(229853002)(31696002)(54906003)(316002)(486006)(4744005)(476003)(478600001)(8936002)(2616005)(446003)(14454004)(81166006)(71200400001)(11346002)(71190400001)(8676002)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3571;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ChxMVXkGJzUUQ1gf3Pq1ye4PTfzqn4uV4ii8qXTd+0RbrrhUSdZrhDzgJYVFsPNFFNW+88b3VI3ggIaYZMPDaCZfNLJZt/DlPuN55WT7tuoc/XcWVlVRXIv3oJywmfudEw+fZhaec+DxtQO+Lc99bSukO0sv0z+IWyMGXuOWhmxLR8IefX2Sx/OtfgRJXSdaKjHSSu1BLkDrz+rPquwMv/Spx6Fih48rize4bLT5ESg+A83NIp6nQp9KeWPx22dIuvAL9honnywilAt32OH6Y72Bje/D7vOpow4isT3ssvImwT06Jxd1fsFT3RP3EMH+ZdQ4beKhqwtXyj2brRjSN39sPfKJyr0G8js992rF4NCnQEH1pKE1KAcjetEQPm0tzwEysi5KvSZL0/Tmm83wQJQzuqw0NdlqANRoeITJ6izyfkdCW7fFlpiKzHSgiPQe
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6FFAD1F4A30DE4BA58AC9A15F444BE5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32201da5-d1ad-411d-c4ce-08d7595ad90a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 14:51:42.2133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alNwBe0iHZbnKWUCrEUWtIDOj6BHsP61Xrk5EgWLc/DvvGb2Pe+YXCv3SCJR63wMkxAaaFiUv9rz5VaTBHw3G/mY2dzmJnMI4i1kRTXQ8gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3571
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.101
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
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjUuMTAuMjAxOSAxNzoyOCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyMy4xMC4xOSAwNDowMSwg
RXJpYyBCbGFrZSB3cm90ZToNCj4+IEZyb206IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkg
PHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+DQo+PiBBZGQgdGVzdCwgd2hpY2ggc3RhcnRz
IGJhY2t1cCB0byBuYmQgdGFyZ2V0IGFuZCByZXN0YXJ0cyBuYmQgc2VydmVyDQo+PiBkdXJpbmcg
YmFja3VwLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IE1lc3NhZ2UtSWQ6IDwyMDE5MTAwOTA4
NDE1OC4xNTYxNC00LXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBF
cmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQmxh
a2UgPGVibGFrZUByZWRoYXQuY29tPg0KPj4gLS0tDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8y
NjQgICAgICAgIHwgOTUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAg
dGVzdHMvcWVtdS1pb3Rlc3RzLzI2NC5vdXQgICAgfCAxMyArKysrKw0KPj4gICB0ZXN0cy9xZW11
LWlvdGVzdHMvZ3JvdXAgICAgICB8ICAxICsNCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVz
dHMucHkgfCAxMSArKysrDQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgMTIwIGluc2VydGlvbnMoKykN
Cj4+ICAgY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL3FlbXUtaW90ZXN0cy8yNjQNCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3FlbXUtaW90ZXN0cy8yNjQub3V0DQo+IA0KPiBJIHN1cHBv
c2UgdGhpcyB0ZXN0IHNob3VsZCBsaW1pdCB0aGUgc3VwcG9ydGVkIGltYWdlIGZvcm1hdHMuICBG
b3IgbWUsDQo+IGl0IGZhaWxzIGZvciBhdCBsZWFzdCBMVUtTLCBjbG9vcCwgYW5kIHZwYy4gIChE
dWUgdG8gZGlmZmVyZW50IHJlYXNvbnMNCj4gZm9yIGVhY2ggZm9ybWF0LikNCj4gDQoNClNvcnJ5
IGZvciB0aGlzLiBJIHNob3VsZCBmaW5hbGx5IHJlbWVtYmVyIHRvIChhbG1vc3QpIGFsd2F5cyBy
ZXN0cmljdCBteSB0ZXN0cyB0byBxY293Mi4NClBhdGNoIHNlbnQuDQoNCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpWbGFkaW1pcg0K

