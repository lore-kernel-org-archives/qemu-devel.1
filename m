Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BA0C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20ABA214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BQ7mjBDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20ABA214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tPG-0001NA-Sp
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9swK-0003f0-Mg
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9swI-0000nE-Jn
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:29:19 -0400
Received: from mail-db5eur01on0714.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::714]:26350
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9swH-0000lu-Sv; Mon, 16 Sep 2019 11:29:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuRE9fkeHvEP/duJkWPE6rYZTCjTw32ukEg2KerPQCi/stsJ7eVIJeBH79W1bfcwxTvJFgLeedwiRDWX3L/+uquuIkqHda60nltI5DqwBht7Xgr2ePr5evz+uv7lC1IhzP7rSkdvdAAS+2O//ykPY+bY2jBDb4Zm8fmeDaFZlbIV9GFCotTWhl5GH4TKEWpEt38jG8iLT7792JHQhX0bPBbcy96rDRn5OMO93D1KLfZABwdyDN+xPX3Jv4NAL2l0dV2vdaCSeVftQBtsfSeTvbpg/UJpF/kbhyRSCr++AwTOWo8C/Ia5INPyD/PnC9IYoVCfkyiPY+7ae6ae8hazYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/B1VwStHEQ6ZsqzNIRsDDtDkYCEk3zUnmviguoO8Qg=;
 b=D5LV8cbeKvxFLIGBXukGvAbQr+xlYt5UdSgwp8NJBmorGO1fySIPXzadfGbxnMJ4j68iDm0m5u+ljKHPk/zI7bc10lfiimdpvZ84MKE1m24JvVtJIrbQBs3Nu0kPK2wMe/ULZP/mV9a+H27vylH0+I3hs1PCLcrGeLgm5Gt6JTf3jl62a+zbvhjozAqZY36/T3Zg1NuT93yvOYMvlGTTIecfaVP4Jn2TbST5Ayye7LGNA+Z5SUH+LSlCWbOSq3IJ1i95f5GodNWVPPvLauQ3zgP4K22J7WkPY9fEpX2x+9Vtsd4yPmXKOvs0tBD5TBXy0V3rGzjkHhgV/2PnzoYTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/B1VwStHEQ6ZsqzNIRsDDtDkYCEk3zUnmviguoO8Qg=;
 b=BQ7mjBDuSP0PbFtlLU9qd6+cCVHV82+iXzLjB8jnmh8PsOorWqtUvkdS0lg0j3BSMw6Y/NNGfU/cAcQ+iVBB7/ePEhwR9WeRP08s+X1xed+s6qMWZH+Koqvg7cDnNFxk703UVsYhnZb7bhfHjdqwsfnhaCjjP5Uf2z4INHQiMzU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5387.eurprd08.prod.outlook.com (52.133.241.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Mon, 16 Sep 2019 15:29:15 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 15:29:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 0/5] qcow2: async handling of fragmented io
Thread-Index: AQHVVEeEHwbIBHmZwU6qI+EoKXvyVacpekqAgAUB3YCAACJFAA==
Date: Mon, 16 Sep 2019 15:29:15 +0000
Message-ID: <b170ec97-4324-b8e2-f6cc-c2b1ec99eb67@virtuozzo.com>
References: <20190816153015.447957-1-vsementsov@virtuozzo.com>
 <11e54b5c-eafd-411e-aadf-5b9fa4d8dc4c@redhat.com>
 <3a239280-40ab-a100-bd13-c0fd45ea46e4@redhat.com>
In-Reply-To: <3a239280-40ab-a100-bd13-c0fd45ea46e4@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0271.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::23) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190916182912707
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3c3c881-cd4d-43ad-4dab-08d73abaa1f1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5387; 
x-ms-traffictypediagnostic: DB8PR08MB5387:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB53874DDC4E2D906FA23C14ADC18C0@DB8PR08MB5387.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(53754006)(316002)(76176011)(229853002)(53546011)(386003)(6506007)(6486002)(6116002)(52116002)(14454004)(966005)(25786009)(8676002)(81156014)(2906002)(81166006)(2501003)(3846002)(99286004)(71190400001)(71200400001)(8936002)(66946007)(66476007)(66556008)(64756008)(66446008)(66066001)(31686004)(186003)(53936002)(102836004)(305945005)(7736002)(6436002)(36756003)(4326008)(14444005)(486006)(256004)(26005)(54906003)(110136005)(2616005)(476003)(446003)(11346002)(6512007)(6246003)(6306002)(86362001)(31696002)(478600001)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5387;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: svjzHoV8l4zGE2TP12dntbKsDk/tw1ITZbjtvvHD2OHpp9/T73Cr2QgaAKTr2XJopT5iY2h9WocaQgGgJnXeaDzzB8PwytoOFyISnRaAI2K3kMXMoKNocv+gx2gL1xXB3ZwD2d/pN5eIZgG7h44Ux6mK+RBGFlQJ8Ve9wZuj55attn8FqUpQ36CzfX08uCFaoEQkV122OaAfOsr+IE95N68QppnjqK9mt4ySULqZBwZfVNB7ZJQJmhkzsniSgdyYaA1mstnZDgaZlSXyK2QK6gpWPlmdmPPPGuJOu2rLiGBAuk0bNS51NH0d0V5p0wtSFcYi+iVTdhsuVcus/dYnNhKI8qBnvuKIOWhJ5azu3DCoMYPlqeHvgBHTOR6sc5N+KO8oCLwN2/M8cCnikrh94kcO4axPSmJp7vqCWxXoC/I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1778BEF05513C340834387CD6CD62505@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c3c881-cd4d-43ad-4dab-08d73abaa1f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 15:29:15.3089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qB4K9XMmqr9J0Ab3TTRCOPx06pql7aGl6HaWdv1xJim4mStBbj1nYtbnRfTe1UHy0tLOaV0eOFo5aBfYksimWL6tySL145zgi65KT8c54jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5387
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe02::714
Subject: Re: [Qemu-devel] [PATCH v4 0/5] qcow2: async handling of fragmented
 io
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMDkuMjAxOSAxNjoyNiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMy4wOS4xOSAxMDo1OCwg
TWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMTYuMDguMTkgMTc6MzAsIFZsYWRpbWlyIFNlbWVudHNv
di1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gSGkgYWxsIQ0KPj4+DQo+Pj4gSGVyZSBpcyBhbiBhc3lu
Y2hyb25vdXMgc2NoZW1lIGZvciBoYW5kbGluZyBmcmFnbWVudGVkIHFjb3cyDQo+Pj4gcmVhZHMg
YW5kIHdyaXRlcy4gQm90aCBxY293MiByZWFkIGFuZCB3cml0ZSBmdW5jdGlvbnMgbG9vcHMgdGhy
b3VnaA0KPj4+IHNlcXVlbnRpYWwgcG9ydGlvbnMgb2YgZGF0YS4gVGhlIHNlcmllcyBhaW0gaXQg
dG8gcGFyYWxsZWxpemUgdGhlc2UNCj4+PiBsb29wcyBpdGVyYXRpb25zLg0KPj4+IEl0IGltcHJv
dmVzIHBlcmZvcm1hbmNlIGZvciBmcmFnbWVudGVkIHFjb3cyIGltYWdlcywgSSd2ZSB0ZXN0ZWQg
aXQNCj4+PiBhcyBkZXNjcmliZWQgYmVsb3cuDQo+Pg0KPj4gVGhhbmtzLCBJ4oCZdmUgY2hhbmdl
ZCB0d28gdGhpbmdzOg0KPj4gLSBSZXBsYWNlZCBhc3NlcnQoKHggJiAoQkRSVl9TRUNUT1JfU0la
RSAtIDEpKSA9PSAwKSBieQ0KPj4gICAgYXNzZXJ0KFFFTVVfSVNfQUxJR05FRCh4LCBCRFJWX1NF
Q1RPUl9TSVpFKSkgaW4gcGF0Y2ggMyAoY29uZmxpY3Qgd2l0aA0KPj4gICAg4oCcYmxvY2s6IFVz
ZSBRRU1VX0lTX0FMSUdORUTigJ0pLCBhbmQNCj4+IC0gUmVwbGFjZWQgdGhlIHJlbWFpbmluZyBp
bnN0YW5jZSBvZiDigJxxY293Ml9jb19kb19wd3JpdGV2KCnigJ0gYnkNCj4+ICAgIOKAnHFjb3cy
X2NvX3B3cml0ZXZfdGFzaygp4oCdIGluIGEgY29tbWVudCBpbiBwYXRjaCA0DQo+Pg0KPj4gYW5k
IGFwcGxpZWQgdGhlIHNlcmllcyB0byBteSBibG9jayBicmFuY2g6DQo+Pg0KPj4gaHR0cHM6Ly9n
aXQueGFuY2xpYy5tb2UvWGFuQ2xpYy9xZW11L2NvbW1pdHMvYnJhbmNoL2Jsb2NrDQo+IA0KPiBV
bmZvcnR1bmF0ZWx5LCBJ4oCZbGwgaGF2ZSB0byB1bnN0YWdlIHRoZSBzZXJpZXMgZm9yIG5vdyBi
ZWNhdXNlIHRoZSBmaXgNCj4gdG8gMDI24oCZcyByZWZlcmVuY2Ugb3V0cHV0IGlzbuKAmXQgc3Rh
YmxlLg0KPiANCj4gV2hlbiBydW5uaW5nIHRoZSB0ZXN0IGluIHBhcmFsbGVsIChJIGNhbiByZXBy
b2R1Y2UgaXQgd2l0aCBmb3VyDQo+IGluc3RhbmNlcyBvbiBteSBtYWNoaW5lIHdpdGggdHdvIGNv
cmVzICsgSFQpLCBJIGdldCBmYWlsdXJlcyBsaWtlOg0KPiANCj4gMDI2ICAgICAgZmFpbCAgICAg
ICBbMTU6MjE6MDldIFsxNToyMTozN10gICAgICAobGFzdDogMThzKSAgIG91dHB1dA0KPiBtaXNt
YXRjaCAoc2VlIDAyNi5vdXQuYmFkKQ0KPiAtLS0gdGVzdHMvcWVtdS1pb3Rlc3RzLzAyNi5vdXQg
MjAxOS0wOS0xNiAxNDo0OToyMC43MjA0MTA3MDEgKzAyMDANCj4gKysrIHRlc3RzL3FlbXUtaW90
ZXN0cy8wMjYub3V0LmJhZCAgICAgICAyMDE5LTA5LTE2IDE1OjIxOjM3LjE4MDcxMTkzNiArMDIw
MA0KPiBAQCAtNTYzLDcgKzU2Myw3IEBADQo+ICAgcWVtdS1pbzogRmFpbGVkIHRvIGZsdXNoIHRo
ZSByZWZjb3VudCBibG9jayBjYWNoZTogTm8gc3BhY2UgbGVmdCBvbiBkZXZpY2UNCj4gICB3cml0
ZSBmYWlsZWQ6IE5vIHNwYWNlIGxlZnQgb24gZGV2aWNlDQo+IA0KPiAtNzQgbGVha2VkIGNsdXN0
ZXJzIHdlcmUgZm91bmQgb24gdGhlIGltYWdlLg0KPiArNTIyIGxlYWtlZCBjbHVzdGVycyB3ZXJl
IGZvdW5kIG9uIHRoZSBpbWFnZS4NCj4gICBUaGlzIG1lYW5zIHdhc3RlIG9mIGRpc2sgc3BhY2Us
IGJ1dCBubyBoYXJtIHRvIGRhdGEuDQo+ICAgRm9ybWF0dGluZyAnVEVTVF9ESVIvdC5JTUdGTVQn
LCBmbXQ9SU1HRk1UIHNpemU9MTA3Mzc0MTgyNA0KPiANCj4gRmFpbHVyZXM6IDAyNg0KPiBGYWls
ZWQgMSBvZiAxIGlvdGVzdHMNCj4gDQoNClVuZm9ydHVuYXRlIGVub3VnaDopDQoNCkhtbSwgY2Fu
J3QgcmVwcm9kdWNlLCBidXQgSSB0ZW5kIHRvIGZpeCB0aGlzIGJ5IGp1c3QgZmlsdGVyaW5nIG91
dCBpbmZvcm1hdGlvbiBhYm91dA0KbGVha2VkIGNsdXN0ZXJzIGluIHRoaXMgdGVzdCwgYXMgbm8g
c2Vuc2UgaW4gdHJhY2tpbmcgaXQgZm9yIGZhaWx1cmUgcGF0aHMsIGtlZXBpbmcNCmluIG1pbmQg
bmV3bHkgaW50cm9kdWNlZCBhc3luYyBoYW5kbGluZyBvZiByZXF1ZXN0IHBhcnRzLg0KDQotLSAN
CkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

