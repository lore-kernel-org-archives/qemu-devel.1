Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FB3C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0860620B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DYIx9elv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0860620B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hucMt-0004sb-06
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 08:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48043)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hucLy-0004NJ-IL
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hucLx-0001yr-Gu
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:44:42 -0400
Received: from mail-eopbgr00120.outbound.protection.outlook.com
 ([40.107.0.120]:58418 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hucLw-0001xf-Qj; Mon, 05 Aug 2019 08:44:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqcZxVBKAxBtZffzq/cjVWtAKlbNRzV9BTKYRKTwgqlUKzFMlx0jhEpuVI75kPWOv8YBSwKL/SPTGfsPGRpmTyIfzv4uy7vvzpVuO6Xrvuil8ygaPxg5Mn5i+6x32s1mQCr8rDn6ojxD++3JgsH9thpLs2h6Tqj2JBkSxygi1et77tLMY9VgDv/hACfpl6MepawZcHgyzK9MwEEH4LylbWGzgvCnV0iK9SQO5MyRL4QTz8DGrDPR0DK5ZOQ+5FXuz93Eprcz6U2EsTaIn23Zaz/sm92twPhZqOcgkbCzuKDcv9TNXFt1meEQXls1L7IRFJc2JZYg6tMO5EQIV0ph1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiOyJgxfMDMUIR612az2kBd7TV8p4QY/hpqBCSzMC1Y=;
 b=Ufr6FoAzQYk8dwp5ldTWR9WSJyMwQ0BE79eByMkJYtsWtrFujVIchcYMMdaRU7RhoP/RfxtsMV60cKfVyCfEa9BtbcXVoL6YW4JFJNruGCdl1p8ngdOA17PhInOhh+Ow82GNAMQPYNuW2Ynh0IdjmW7Hxk81YI4An5AZANrzQaBsXOXzT0RSFxVnElWlxmXIW6VkItPWWH26IBfxMGHsjxnVfFF4XxZqspY6pYLa7CAwprAe9W3E8a9gX2T1M675CxE+uTjfYY+EfW05pZrOOeTq92yHX+pkOC3yQb5bW1JKrHD/srAqzhf5wmvTXrFCfqCS0JmDQyIBY8AQvN4veQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiOyJgxfMDMUIR612az2kBd7TV8p4QY/hpqBCSzMC1Y=;
 b=DYIx9elvnkHS22tk8X0Z1NhnPlilyquZfCesD0yleW8MYFT0Ln1rL/7GzXPBn+cZSrywJalW5Td+jFNlkBz6alDPAx0yd7lcxD0VTCS4KC60zS+j2zzbsZRWzVEO+TsnGPBZ8+8e21OnNwrAJEiIna8RtYxke9J/YS6fSqkDVEU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4572.eurprd08.prod.outlook.com (20.179.12.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 12:44:38 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 12:44:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH] iotests: Test unaligned blocking mirror write
Thread-Index: AQHVS4HlTE8lsWIUokqg+5d0Awzk4absgA6A
Date: Mon, 5 Aug 2019 12:44:37 +0000
Message-ID: <12ee91c4-9c00-b4f5-8a4d-27076672cd18@virtuozzo.com>
References: <20190805113526.20319-1-mreitz@redhat.com>
In-Reply-To: <20190805113526.20319-1-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0016.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::26)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190805154435939
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 266e70ce-0959-4603-f7c7-08d719a2ad4a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4572; 
x-ms-traffictypediagnostic: DB8PR08MB4572:
x-microsoft-antispam-prvs: <DB8PR08MB45720DF4550581C40DB49668C1DA0@DB8PR08MB4572.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(346002)(396003)(39840400004)(189003)(199004)(52294003)(71200400001)(71190400001)(76176011)(102836004)(64756008)(66446008)(316002)(110136005)(66066001)(486006)(53936002)(54906003)(26005)(8936002)(7736002)(14454004)(2501003)(6506007)(4326008)(386003)(14444005)(5660300002)(25786009)(2906002)(31686004)(305945005)(86362001)(446003)(8676002)(478600001)(68736007)(31696002)(11346002)(6486002)(186003)(229853002)(36756003)(6116002)(3846002)(256004)(66946007)(6436002)(66556008)(66476007)(99286004)(81166006)(6246003)(2616005)(81156014)(476003)(6512007)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4572;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kjRldh/Jyzk01H1W+JO+B2XPCusw9Cq5ioE5P6DMW4Ri/VnH4YDAeFNADUfxM5OJmFTtML1Me8QDlYXeMt4kziEiR+GdLycq+hh855t5Lm65wmFIJwKBUnZ+lQZpKpv7bbNfodCeUeN522CqHL1d377t/EuIZFaUpVlZCc/EF69p0j/y8CX+CF/QojMKMouPGqhjPGCeAM1BIgikp+6YlXgWAdQqLrfGzZG3FkOfZfb1aDBhHAJIBm6lU/0k5z1pFsUBBxB2sQDH7AHDOITzjHfyaNXLXTAGPz2mtEcgMNhtLvG3uuwsk/JwwNpAhbzBh75jwYhoSGTgYv3ApCavWJbrZTLLEWTjP7gxK4JsXdjupkD8x4zNXA+uzntS3C4F4Dlgd6L6HBYs7d90g+j5BqkxZX21g6re8hHMiG6NX3Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0F1819AE3F66F4BA6E4C16C553D56A4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266e70ce-0959-4603-f7c7-08d719a2ad4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 12:44:38.0143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4572
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.120
Subject: Re: [Qemu-devel] [PATCH] iotests: Test unaligned blocking mirror
 write
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMDguMjAxOSAxNDozNSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
UmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gSGksIHRoaXMgaXMgYSB0ZXN0IGZv
ciB0aGUgbWlycm9yIGJ1ZyBWbGFkaW1pciBmb3VuZC4gIE5hdHVyYWxseSwgaXQNCj4gZGVwZW5k
cyBvbiBzb21lIHBhdGNoIHRvIGZpeCBpdC4NCj4gDQo+IEJhc2VkLW9uOiA8MjAxOTA4MDIxODU4
MzAuNzQ2NDgtMS12c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IC0tLQ0KPiAgIHRlc3RzL3Fl
bXUtaW90ZXN0cy8xNTEgICAgIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIHRl
c3RzL3FlbXUtaW90ZXN0cy8xNTEub3V0IHwgIDQgKystLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwg
MjcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0
cy9xZW11LWlvdGVzdHMvMTUxIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzE1MQ0KPiBpbmRleCAxYmI3
NGQ2N2M0Li5hZDczNTlmYzhkIDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMTUx
DQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8xNTENCj4gQEAgLTExNCw2ICsxMTQsMzEgQEAg
Y2xhc3MgVGVzdEFjdGl2ZU1pcnJvcihpb3Rlc3RzLlFNUFRlc3RDYXNlKToNCj4gICAgICAgZGVm
IHRlc3RBY3RpdmVJT0ZsdXNoZWQoc2VsZik6DQo+ICAgICAgICAgICBzZWxmLmRvQWN0aXZlSU8o
VHJ1ZSkNCj4gICANCj4gKyAgICBkZWYgdGVzdFVuYWxpZ25lZEFjdGl2ZUlPKHNlbGYpOg0KPiAr
ICAgICAgICAjIEZpbGwgdGhlIHNvdXJjZSBpbWFnZQ0KPiArICAgICAgICByZXN1bHQgPSBzZWxm
LnZtLmhtcF9xZW11X2lvKCdzb3VyY2UnLCAnd3JpdGUgLVAgMSAwIDJNJykNCg0KMk0gb2Ygb25l
cw0KDQo+ICsNCj4gKyAgICAgICAgIyBTdGFydCB0aGUgYmxvY2sgam9iICh2ZXJ5IHNsb3dseSkN
Cj4gKyAgICAgICAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ2Jsb2NrZGV2LW1pcnJvcicsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGpvYl9pZD0nbWlycm9yJywNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZmlsdGVyX25vZGVfbmFtZT0nbWlycm9yLW5vZGUnLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZpY2U9J3NvdXJjZS1ub2RlJywNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdGFyZ2V0PSd0YXJnZXQtbm9kZScsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN5bmM9J2Z1bGwnLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb3B5X21vZGU9J3dyaXRlLWJsb2NraW5nJywNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYnVmX3NpemU9KDEwNDg1NzYgLy8gNCksDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNwZWVkPTEpDQo+ICsgICAgICAgIHNlbGYuYXNzZXJ0X3FtcChy
ZXN1bHQsICdyZXR1cm4nLCB7fSkNCj4gKw0KPiArICAgICAgICAjIFN0YXJ0IGFuIHVuYWxpZ25l
ZCByZXF1ZXN0IHRvIGEgZGlydHkgYXJlYQ0KPiArICAgICAgICByZXN1bHQgPSBzZWxmLnZtLmht
cF9xZW11X2lvKCdzb3VyY2UnLCAnd3JpdGUgLVAgMiAlaSAxJyAlICgxMDQ4NTc2ICsgNDIpKQ0K
DQp3cml0ZSBvbmx5IG9uZSBieXRlLCBidXQgdW5zZXQgdGhlIHdob2xlIGdyYW51bGFyaXR5IGNo
dW5rIGluIGJpdG1hcCwgc28gaXQgd291bGQgYmUNCnNraXBwZWQgZnJvbSBzZXF1ZW50aWFsIG1p
cnJvcmluZyBsb29wLCBhbmQgZmluYWwgaW1hZ2UgY29tcGFyaXNvbiB3aWxsIGZhaWwNCg0KPiAr
DQo+ICsgICAgICAgICMgTGV0IHRoZSBqb2IgZmluaXNoDQo+ICsgICAgICAgIHJlc3VsdCA9IHNl
bGYudm0ucW1wKCdibG9jay1qb2Itc2V0LXNwZWVkJywgZGV2aWNlPSdtaXJyb3InLCBzcGVlZD0w
KQ0KPiArICAgICAgICBzZWxmLmFzc2VydF9xbXAocmVzdWx0LCAncmV0dXJuJywge30pDQo+ICsg
ICAgICAgIHNlbGYuY29tcGxldGVfYW5kX3dhaXQoZHJpdmU9J21pcnJvcicpDQo+ICsNCj4gKyAg
ICAgICAgc2VsZi5wb3RlbnRpYWxfd3JpdGVzX2luX2ZsaWdodCA9IEZhbHNlDQo+ICAgDQo+ICAg
DQo+ICAgaWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoNCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8xNTEub3V0IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzE1MS5vdXQNCj4gaW5kZXgg
ZmJjNjNlNjJmOC4uOGQ3ZTk5NjcwMCAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3Rz
LzE1MS5vdXQNCj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzE1MS5vdXQNCj4gQEAgLTEsNSAr
MSw1IEBADQo+IC0uLg0KPiArLi4uDQo+ICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtUmFuIDIgdGVzdHMN
Cj4gK1JhbiAzIHRlc3RzDQo+ICAgDQo+ICAgT0sNCj4gDQoNClJldmlld2VkLWJ5OiBWbGFkaW1p
ciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCk5vdCBw
dXR0aW5nIG5vdyB0ZXN0ZWQtYnkgYXMgd2UgZGlkbid0IGRlY2lkZSB3aGF0IGlzIHRoZSBiYXNl
LiBIb3dldmVyLCBJJ3ZlDQpjaGVja2VkIHRoYXQgbmV3IHRlc3QtY2FzZSBmYWlscyBvbiBtYXN0
ZXIuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

