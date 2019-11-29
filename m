Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9D9C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C8821736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RTP1L6aF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C8821736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iai0g-0005z4-IF
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 10:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iahtX-0001J4-4D
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iahtS-0005W0-Ty
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:09:16 -0500
Received: from mail-eopbgr140094.outbound.protection.outlook.com
 ([40.107.14.94]:4257 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iahtR-0005HD-2S
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:09:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwXReJLF/UrlNLgWPagUfcFPZwPp/8nCRX5sSZAo71OVbkcwA5yhBhGwIEkhaOfj7Z8F77gnvoj6jnZuUO0YyikaXvSrP8VmzZnu2FOMmBFErmsDAp9wbDrRIMx2PYStQ5cZ95hprsruZhzKkrvH2Gtm7RWv6gv2KnSpeXysZDt4n+XIfNUqjLmARRaV2f/7yBIlOC+LPVacqMFJDOr4+XeBbE7o2ihZVR8D+2MsxIRGJrttmXfl8v5aGTZQ4RfznGMvoqzPf7a+oFC7PbpUm0Z7VxCQnV5E9qPYT9fRrlOkx5Ok4Kkc1Xc4DUwp2/LkCPJJYaCBPnsuLfxjxw8+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doQR9BbspKb0nOQPAUfX3U1nnNgafO/DTFx+iWVJ9ag=;
 b=iGsV2K0bI93+xt0klKT3/iUpQGJtg3vYUlPgYnn7JjH82+mNc5Fzk1HctZtjPDEI70CcNVjNul++xeyjGyIg8mPVoYQjen0Yznc7X2j6meKb6DPBkbx8CNlvanbDcFJXD5z+r0UpSf1wXmUX2VXNJX2iJ8HtZ7ixq3zgV01z+e52/KZ5vWGWcculA4O/PPTQNXS2XQ4yNSXkRtybX9m9tlL1U29bXEwXlFZTgefR3TXsyiHnGE8bdqIUuQV4UAyG9kAT5VDwmgcHrASWTOWvCIhaU0XKgJ2YfcHUQsumlQBo3kZKZKIOI8EjaFD7uFpYqPCx7KiGt48egDorq3hztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doQR9BbspKb0nOQPAUfX3U1nnNgafO/DTFx+iWVJ9ag=;
 b=RTP1L6aF/qmyUBlgkF7yxg7bqFy8X9hgR1Al064UFDIpeiZ8BUg7F7FuZ//YJuqkFYohWeEt5FTp3rK7gy4Qb8gGG5QWOrsdlu25SkI7wIkXcZI0vXb8AejI/BDSk++ywaoCw+qLxoPJ2Nnm7UoVodBgNQ37hQu+5HUAdVQr4PY=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4583.eurprd08.prod.outlook.com (20.178.88.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Fri, 29 Nov 2019 15:09:08 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 15:09:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6] error: rename errp to errp_in where it is IN-argument
Thread-Topic: [PATCH v6] error: rename errp to errp_in where it is IN-argument
Thread-Index: AQHVpVGz6p/zLL3Qt0SjF9DL93KD5KegpCn6gAAIsQCAAF2o1YAAyNqAgABmf2CAAAlkAA==
Date: Fri, 29 Nov 2019 15:09:07 +0000
Message-ID: <41f32448-f2b8-1822-25df-f02c61df9bc4@virtuozzo.com>
References: <20191127183704.14825-1-vsementsov@virtuozzo.com>
 <878so05bca.fsf@dusky.pond.sub.org>
 <f901e0db-61df-898f-ce18-096bfeadf525@virtuozzo.com>
 <87mucf218w.fsf@dusky.pond.sub.org>
 <80e563ee-31fb-da43-ddde-c8666e4b92c6@virtuozzo.com>
 <87eexqda3c.fsf@dusky.pond.sub.org>
In-Reply-To: <87eexqda3c.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0061.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::32) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129180906329
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 212e2513-8bef-4b39-88d2-08d774de14db
x-ms-traffictypediagnostic: AM6PR08MB4583:
x-microsoft-antispam-prvs: <AM6PR08MB4583A28538DFA8D86DD621A5C1460@AM6PR08MB4583.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39840400004)(376002)(346002)(366004)(199004)(189003)(5660300002)(99286004)(561944003)(36756003)(4326008)(11346002)(446003)(2616005)(2906002)(3846002)(6116002)(71200400001)(71190400001)(6436002)(31686004)(256004)(14444005)(6486002)(305945005)(54906003)(7736002)(316002)(81166006)(81156014)(66066001)(14454004)(86362001)(102836004)(66556008)(66946007)(8676002)(66446008)(6246003)(64756008)(66476007)(6916009)(229853002)(52116002)(76176011)(478600001)(6512007)(8936002)(6506007)(25786009)(26005)(186003)(386003)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4583;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xryJsKSvJu56XXloqB0D9XIe3lLmb+sMBWENRmj2OSitRh1xpEyH/Bf9IAd32E8kk07w+QY92kexNMLpBD90e/vWtWZPMuEedl1lGeOFRh1OCUrZsmV/BMj0dLdbeYj3VolwvD8VBI8GulLoG36DS+IYOLkbfiY+NQAYKkXsSkZvr7wtM+9v/nqOIGMxvsG6dRzL1vKuIPpd3j93UTxeOeNmKK3aTkzRno1EjqL4qTUNnmWWZ7C/zAuwS98N5BgAoNTLecFRKiA+dCpvhZMG4Y60iG4CBtxgfQ6DC8aOO+KO2EVAQI07sNj+z0h/mkj0Yu1YvcnQ0ArW6JMWjXbxsixZ/SFzzm36PGxECtRWUhjUq6aAmIYTkKaTOaXvn9A+72IE43NRkXSvjT9YupqW0AF0uOttPhBYNs/GX4HODP7iLz/wt7OkP6bQ+Yno2qSU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <83C47495AF2330459413081B3CF89D91@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212e2513-8bef-4b39-88d2-08d774de14db
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 15:09:07.9646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBGtIXU8XPnM4HaADXAfsm15xNX77cD8dzR/a4qGEMDqW9xrUAZbLFL0luO0nfgqGvOc6jJQrlD3k9WMUh+moFmIesbGY4GFCubgRi6+anM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4583
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.94
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
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMTEuMjAxOSAxNzozNSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiAN
Cj4+IDI4LjExLjIwMTkgMjM6MjksIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPj4+IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVz
Og0KPj4+DQo+Pj4+IDI4LjExLjIwMTkgMTc6MjMsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0K
Pj4+Pj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPiB3cml0ZXM6DQo+Pj4+Pg0KPj4+Pj4+IEVycm9yICoqZXJycCBpcyBhbG1vc3QgYWx3YXlz
IE9VVC1hcmd1bWVudDogaXQncyBhc3N1bWVkIHRvIGJlIE5VTEwsIG9yDQo+Pj4+Pj4gcG9pbnRl
ciB0byBOVUxMLWluaXRpYWxpemVkIHBvaW50ZXIsIG9yIHBvaW50ZXIgdG8gZXJyb3JfYWJvcnQg
b3INCj4+Pj4+PiBlcnJvcl9mYXRhbCwgZm9yIGNhbGxlZSB0byByZXBvcnQgZXJyb3IuDQo+Pj4+
Pj4NCj4+Pj4+PiBCdXQgdmVyeSBmZXcgZnVuY3Rpb25zIGluc3RlYWQgZ2V0IEVycm9yICoqZXJy
cCBhcyBJTi1hcmd1bWVudDoNCj4+Pj4+PiBpdCdzIGFzc3VtZWQgdG8gYmUgc2V0IChvciwgbWF5
YmUsIE5VTEwpLCBhbmQgY2FsbGVlIHNob3VsZCBjbGVhbiBpdCwNCj4+Pj4+PiBvciBhZGQgc29t
ZSBpbmZvcm1hdGlvbi4NCj4+Pj4+Pg0KPj4+Pj4+IEluIHN1Y2ggY2FzZXMsIHJlbmFtZSBlcnJw
IHRvIGVycnBfaW4uDQo+Pj4+Pg0KPj4+Pj4gTWlzc2luZzogd2h5IGlzIHRoZSByZW5hbWUgdXNl
ZnVsPw0KPj4+Pg0KPj4+PiBUaGUgbWFpbiByZWFzb24gaXMgdG8gcHJlcGFyZSBmb3IgY29jY2lu
ZWxsZSBwYXJ0Lg0KPj4+DQo+Pj4gSXQncyBub3QgYSBwcmVyZXF1aXNpdGUgZm9yIGFwcGx5aW5n
IHRoZSBwYXRjaGVzIENvY2NpbmVsbGUgcHJvZHVjZXMsDQo+Pj4gb25seSBhIHByZXJlcXVpc2l0
ZSBmb3IgcnVubmluZyBDb2NjaW5lbGxlLg0KPj4+DQo+Pj4+PiBJdCdzIHVzZWZ1bCBpZiBpdCBo
ZWxwcyByZWFkZXJzIHJlY29nbml6ZSB1bnVzdWFsIEVycm9yICoqIHBhcmFtZXRlcnMsDQo+Pj4+
PiBhbmQgcmVjb2duaXppbmcgdW51c3VhbCBFcnJvciAqKiBwYXJhbWV0ZXJzIGlzIGFjdHVhbGx5
IGEgcHJvYmxlbS4gIEknbQ0KPj4+Pj4gbm90IHN1cmUgaXQgaXMsIGJ1dCBteSBmYW1pbGlhcml0
eSB3aXRoIHRoZSBFcnJvciBpbnRlcmZhY2UgbWF5IGJsaW5kDQo+Pj4+PiBtZS4NCj4+Pj4+DQo+
Pj4+PiBIb3cgbWFueSBmdW5jdGlvbnMgaGF2ZSB1bnVzdWFsIEVycm9yICoqcGFyYW1ldGVycz8g
IEhvdyBhcmUgdGhleSB1c2VkPw0KPj4+Pj4gQW55IGNhbGxzIHRoYXQgY291bGQgZWFzaWx5IGJl
IG1pc3Rha2VuIGFzIHRoZSB1c3VhbCBjYXNlPyAgU2VlIFsqXQ0KPj4+Pj4gYmVsb3cuDQo+IFsu
Li5dDQo+Pj4+PiBbKl0gVGhlIGluZm9ybWF0aW9uIEkgYXNrZWQgZm9yIGFib3ZlIGlzIGJ1cmll
ZCBpbiB0aGVzZSBwYXRjaGVzLiAgSSdsbA0KPj4+Pj4gdHJ5IHRvIGRpZyBpdCB1cCBhcyBJIGdv
IHJldmlld2luZyB0aGVtLg0KPj4+Pj4NCj4+Pj4+IFNlY29uZCwgaXQgcmlza3Mgc29tZSBvZiB0
aGVzZSAiZnVydGhlciBwYXRjaGVzIiBvdmVydGFrZSB0aGlzIG9uZSwgYW5kDQo+Pj4+PiB0aGVu
IGl0cyBjb21taXQgbWVzc2FnZSB3aWxsIGJlIG1pc2xlYWRpbmcuICBNb3Jlb3ZlciwgdGhlIG90
aGVyIGNvbW1pdHMNCj4+Pj4+IHdpbGwgbGFjayBjb250ZXh0Lg0KPiBbLi4uXQ0KPj4+Pj4+IGRp
ZmYgLS1naXQgYS91dGlsL2Vycm9yLmMgYi91dGlsL2Vycm9yLmMNCj4+Pj4+PiBpbmRleCBkNDUz
MmNlMzE4Li4yNzU1ODZmYWE4IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL3V0aWwvZXJyb3IuYw0KPj4+
Pj4+ICsrKyBiL3V0aWwvZXJyb3IuYw0KPiBbLi4uXQ0KPj4+Pj4+IEBAIC0yNzEsMTEgKzI3MSwx
MSBAQCB2b2lkIGVycm9yX2ZyZWUoRXJyb3IgKmVycikNCj4+Pj4+PiAgICAgICAgIH0NCj4+Pj4+
PiAgICAgfQ0KPj4+Pj4+ICAgICANCj4+Pj4+PiAtdm9pZCBlcnJvcl9mcmVlX29yX2Fib3J0KEVy
cm9yICoqZXJycCkNCj4+Pj4+PiArdm9pZCBlcnJvcl9mcmVlX29yX2Fib3J0KEVycm9yICoqZXJy
cF9pbikNCj4+Pj4+PiAgICAgew0KPj4+Pj4+IC0gICAgYXNzZXJ0KGVycnAgJiYgKmVycnApOw0K
Pj4+Pj4+IC0gICAgZXJyb3JfZnJlZSgqZXJycCk7DQo+Pj4+Pj4gLSAgICAqZXJycCA9IE5VTEw7
DQo+Pj4+Pj4gKyAgICBhc3NlcnQoZXJycF9pbiAmJiAqZXJycF9pbik7DQo+Pj4+Pj4gKyAgICBl
cnJvcl9mcmVlKCplcnJwX2luKTsNCj4+Pj4+PiArICAgICplcnJwX2luID0gTlVMTDsNCj4+Pg0K
Pj4+IFRoaXMgb25lIGlzIGFjdHVhbGx5IGluL291dC4NCj4+Pg0KPj4+IFRvIG1ha2UgdGhlIGNv
bXBpbGVyIGNoZWNrIGVycnBfaW4gaXMgdHJ1bHkgYW4gaW4tYXJndW1lbnQsIHdlIGNhbg0KPj4+
IGRlY2xhcmUgaXQgYXMgRXJyb3IgKmNvbnN0ICplcnJwX2luLg0KPj4+DQo+Pj4gQnV0IHdlIGNh
biBzYXZlIG91cnNlbHZlcyB0aGUgdHJvdWJsZSBvZiByZW5hbWluZyBpdDsgdGhlIGNvbnN0IHNo
b3VsZA0KPj4+IHN1ZmZpY2UgdG8gdGVsbCBib3RoIGh1bWFuIHJlYWRlcnMgYW5kIENvY2NpbmVs
bGUgdGhhdCB0aGlzIGlzIG5vdCB5b3VyDQo+Pj4gY29tbW9uIG91dC1hcmd1bWVudC4gIEkgdGhp
bmsgSSBsaWtlIHRoaXMgYmV0dGVyIHRoYW4gcmVseWluZyBvbiBhDQo+Pj4gbmFtaW5nIGNvbnZl
bnRpb24uICBXaGF0IGFib3V0IHlvdT8NCj4+DQo+PiBJIHRoaW5rIGl0J3MgZ29vZCBpZGVhLi4u
IEJ1dCB3aGF0IHRvIGRvIHdpdGggZXJyb3JfZnJlZV9vcl9hYm9ydCwgYW5kIG90aGVyIGZ1bmN0
aW9ucw0KPj4gd2hpY2ggZ2V0IGZpbGxlZCBlcnJwLCBhbmQgd2FudCB0byBzZXQgaXQgdG8gTlVM
TD8gUGF0Y2ggMjEgYWRkcyB0aHJlZSBzdWNoIGZ1bmN0aW9ucy4uDQo+Pg0KPj4gTWF5YmUsIGFk
ZCBhc3NlcnQoZXJycCkgYXQgc3RhcnQgb2Ygc3VjaCBmdW5jdGlvbnMsIGFuZCBjYXRjaCBpdCBi
eSBjb2NjaW5lbGxlIChub3Qgc3VyZQ0KPj4gdGhhdCBpdCBpcyBwb3NzaWJsZSk/DQo+IA0KPiBJ
IHdlbnQgdGhyb3VnaCB0aGUgZ2l0IGJyYW5jaCB5b3UgcHJvdmlkZWQuDQo+IA0KPiBUaGVzZSBn
ZXQgcmlkIG9mIHVudXN1YWwgRXJyb3IgKiogcGFyYW1ldGVyczoNCj4gDQo+ICAgICAgMDFlMTA2
NjdkMSBobXA6IGRyb3AgRXJyb3IgcG9pbnRlciBpbmRpcmVjdGlvbiBpbiBobXBfaGFuZGxlX2Vy
cm9yDQo+ICAgICAgNjA2YmZiNzUyMCB2bmM6IGRyb3AgRXJyb3IgcG9pbnRlciBpbmRpcmVjdGlv
biBpbiB2bmNfY2xpZW50X2lvX2Vycm9yDQo+IA0KPiAgICAgIEdldCByaWQgb2YgdGhlbSBieSBw
ZWVsaW5nIG9mZiBhbiBpbmRpcmVjdGlvbi4NCj4gDQo+IFRoZXNlIHRyeSB0byBtYWtlIHVudXN1
YWwgRXJyb3IgKiogcGFyYW1ldGVycyBzdGFuZCBvdXQ6DQo+IA0KPiAgICAgIDUxZTczYjMzMDUg
ZXJyb3I6IHJlbmFtZSBlcnJwIHRvIGVycnBfaW4gd2hlcmUgaXQgaXMgSU4tYXJndW1lbnQNCj4g
DQo+ICAgICAgRm91ciByZW5hbWVzLg0KPiANCj4gICAgICBUaHJlZSBmdW5jdGlvbnMgbW9kaWZ5
IHRoZSBlcnJvciwgbmFtZSBAZXJycF9pbiBpcyBva2F5LCBteSBjb25zdA0KPiAgICAgIHByb3Bv
c2FsIHdvcmtzLg0KPiANCj4gICAgICBlcnJvcl9mcmVlX29yX2Fib3J0KCkgY2xlYXJzICplcnJw
X2luLCBuYW1lIEBlcnJwX2luIGlzIG1pc2xlYWRpbmcsDQo+ICAgICAgY29uc3QgZG9lc24ndCB3
b3JrLg0KPiANCj4gICAgICBmN2JkZmQ0MmRhIHFkZXYtbW9uaXRvcjogd2VsbCBmb3JtIGVycm9y
IGhpbnQgaGVscGVycw0KPiANCj4gICAgICBUd28gcmVuYW1lcy4gIEJvdGggZnVuY3Rpb25zIG1v
ZGlmeSB0aGUgZXJyb3IsIHJlbmFtZSBpcyBva2F5LCBjb25zdA0KPiAgICAgIHdvcmtzLg0KPiAN
Cj4gICAgICA5ZDRhYWM3Mjk5IG5iZDogd2VsbCBmb3JtIG5iZF9pdGVyX2NoYW5uZWxfZXJyb3Ig
ZXJycCBoYW5kbGVyDQo+IA0KPiAgICAgIE9uZSByZW5hbWUsIGZyb20gQGxvY2FsX2Vyci4gIG5i
ZF9pdGVyX2NoYW5uZWxfZXJyb3IoKSBjbGVhcnMgKmVycnBfaW4sDQo+ICAgICAgbmFtZSBAZXJy
cF9pbiBpcyBtaXNsZWFkaW5nLCBjb25zdCBkb2Vzbid0IHdvcmsuDQo+IA0KPiAgICAgIGZiMWJk
ODNjNDAgcHBjOiB3ZWxsIGZvcm0ga3ZtcHBjX2hpbnRfc210X3Bvc3NpYmxlIGVycm9yIGhpbnQg
aGVscGVyDQo+IA0KPiAgICAgIE9uZSByZW5hbWUuICBUaGUgZnVuY3Rpb24gbW9kaWZ5IHRoZSBl
cnJvciwgcmVuYW1lIGlzIG9rYXksIGNvbnN0IHdvcmtzLg0KPiANCj4gICAgICBlMDI0ZTg5YjEw
IDlwZnM6IHdlbGwgZm9ybSBlcnJvciBoaW50IGhlbHBlcnMNCj4gDQo+ICAgICAgVHdvIHJlbmFt
ZXMuICBCb3RoIGZ1bmN0aW9ucyBtb2RpZnkgdGhlIGVycm9yLCByZW5hbWUgaXMgb2theSwgY29u
c3QNCj4gICAgICB3b3Jrcy4NCj4gDQo+IFRoZXNlIG1ha2UgdXN1YWwgRXJyb3IgKiogcGFyYW1l
dGVycyBsb29rLCB3ZWxsLCBtb3JlIHVzdWFsOg0KPiANCj4gICAgICBjMDE2NDlkOTk5IGh3L2Nv
cmUvcWRldjogY2xlYW51cCBFcnJvciAqKiB2YXJpYWJsZXMNCj4gICAgICBhNWY2NDI0MTYzIGJs
b2NrL3NuYXBzaG90OiByZW5hbWUgRXJyb3IgKiogcGFyYW1ldGVyIHRvIG1vcmUgY29tbW9uIGVy
cnANCj4gICAgICBhZTIwMGNhMjFlIGh3L2kzODYvYW1kX2lvbW11OiByZW5hbWUgRXJyb3IgKiog
cGFyYW1ldGVyIHRvIG1vcmUgY29tbW9uIGVycnANCj4gICAgICA1NjFmNzNlNjgxIHFnYTogcmVu
YW1lIEVycm9yICoqIHBhcmFtZXRlciB0byBtb3JlIGNvbW1vbiBlcnJwDQo+ICAgICAgMTI1ODlh
OTZjZCBtb25pdG9yL3FtcC1jbWRzOiByZW5hbWUgRXJyb3IgKiogcGFyYW1ldGVyIHRvIG1vcmUg
Y29tbW9uIGVycnANCj4gICAgICBmNjA4ZmM1OTk5IGh3L3MzOTB4OiByZW5hbWUgRXJyb3IgKiog
cGFyYW1ldGVyIHRvIG1vcmUgY29tbW9uIGVycnANCj4gICAgICA3NDdhOTBkMDQ0IGh3L3RwbTog
cmVuYW1lIEVycm9yICoqIHBhcmFtZXRlciB0byBtb3JlIGNvbW1vbiBlcnJwDQo+ICAgICAgM2Qx
OWU2NjYxMCBody91c2I6IHJlbmFtZSBFcnJvciAqKiBwYXJhbWV0ZXIgdG8gbW9yZSBjb21tb24g
ZXJycA0KPiAgICAgIDA3MzY2NjQ4ZWYgaW5jbHVkZS9xb20vb2JqZWN0Lmg6IHJlbmFtZSBFcnJv
ciAqKiBwYXJhbWV0ZXIgdG8gbW9yZSBjb21tb24gZXJycA0KPiANCj4gVGhlc2UgZG9uJ3QgdG91
Y2ggRXJyb3IgKiogcGFyYW1ldGVyIGRlY2xhcmF0aW9uczoNCj4gDQo+ICAgICAgZjZlNGZmZmMx
NiBody9jb3JlL2xvYWRlci1maXQ6IGZpeCBmcmVlaW5nIGVycnAgaW4gZml0X2xvYWRfZmR0DQo+
ICAgICAgYjViYmE4ODBhZSBuZXQvbmV0OiBDbGVhbiB1cCB2YXJpYWJsZSBzaGFkb3dpbmcgaW4g
bmV0X2NsaWVudF9pbml0KCkNCj4gICAgICA0YTQ0NjJjZTRjIGh3L3NkOiBkcm9wIGV4dHJhIHdo
aXRlc3BhY2UgaW4gc2RoY2lfc3lzYnVzX3JlYWxpemUoKSBoZWFkZXINCj4gICAgICBkNTJkNDRl
ODIyIGJhY2tlbmRzL2NyeXB0b2RldjogZHJvcCBsb2NhbF9lcnIgZnJvbSBjcnlwdG9kZXZfYmFj
a2VuZF9jb21wbGV0ZSgpDQo+ICAgICAgN2U5NWQzMDc2NiBody92ZmlvL2FwOiBkcm9wIGxvY2Fs
X2VyciBmcm9tIHZmaW9fYXBfcmVhbGl6ZQ0KPiANCj4gVW51c3VhbCBFcnJvciAqKiBwYXJhbWV0
ZXJzIHRoYXQgY2FuIGJlIG1hZGUgRXJyb3IgKmNvbnN0ICplcnJwIHNob3VsZA0KPiBub3QgYWxz
byBuZWVkIGEgcmVuYW1lLCBuZWl0aGVyIHRvIGF2b2lkIGNvbmZ1c2lvbiBhYm91dCBAZXJycCdz
IHJvbGUsDQo+IG5vciB0byBoZWxwIENvY2NpbmVsbGUuDQo+IA0KPiBVbnVzdWFsIEVycm9yICoq
IHBhcmFtZXRlcnMgdGhhdCBjYW4ndCBiZSBtYWRlIEVycm9yICpjb25zdCAqZXJycDoNCj4gDQo+
ICAgICAgbmJkX2l0ZXJfY2hhbm5lbF9lcnJvcigpOiBwYXJhbWV0ZXIgaXMgY2FsbGVkIEBsb2Nh
bF9lcnIuICBDb25mdXNpb24NCj4gICAgICBzZWVtcyBhcyB1bmxpa2VseSB3aXRob3V0IHRoZSBy
ZW5hbWUgYXMgd2l0aCBpdC4gIENvY2NpbmVsbGUgc2hvdWxkDQo+ICAgICAgbm90IG5lZWQgdGhl
IHJlbmFtZS4gIE5vIG5lZWQgdG8gdG91Y2guICBJJ20gd2lsbGluZyB0byBhY2NlcHQgeW91cg0K
PiAgICAgIGFzc2VydGlvbiBjaGFuZ2UuDQoNCkhtbSBidXQgeW91IHJldmVydGVkIGl0Li4gV2ls
bCB5b3Uga2VlcCBhbiBhc3NlcnRpb24/DQoNCj4gDQo+ICAgICAgZXJyb3JfZnJlZV9vcl9hYm9y
dCgpOiBwYXJhbWV0ZXIgaXMgY2FsbGVkIEBlcnJwLiAgQ29uZnVzaW9uIHNlZW1zDQo+ICAgICAg
YXMgdW5saWtlbHkgd2l0aG91dCB0aGUgcmVuYW1lIGFzIHdpdGggaXQuICBDb2NjaW5lbGxlIHNo
b3VsZCBub3QNCj4gICAgICBuZWVkIHRoZSByZW5hbWUuICBJJ20gd2lsbGluZyB0byBhY2NlcHQg
YSByZW5hbWUgdG8gQGxvY2FsX2Vycg0KPiAgICAgIHJlZ2FyZGxlc3MuDQoNClNvLCBlaXRoZXIg
d2UgcmVuYW1lIGl0IHRvIGxvY2FsX2Vyciwgb3IgY29jY2luZWxsZSBzaG91bGQgZGlzdGluZ3Vp
c2ggaXQNCmJ5IGFzc2VydGlvbiBhdCB0aGUgdG9wLg0KDQo+IA0KPiBJIHB1c2hlZCBteSBmaXh1
cHMgdG8gZ2l0Oi8vcmVwby5vci5jei9xZW11L2FybWJydS5naXQgYnJhbmNoIGVycm9yLXByZXAN
Cj4gZm9yIHlvdXIgY29udmVuaWVuY2UuICBUaGUgY29tbWl0IG1lc3NhZ2VzIG9mIHRoZSBmaXhl
ZCB1cCBjb21taXRzIG5lZWQNCj4gcmVwaHJhc2luZywgb2YgY291cnNlLg0KPiANCg0KTG9va2Vk
IHRocm91Z2ggZml4dXBzLCBsb29rcyBPSyBmb3IgbWUsIHRoYW5rcyEgV2hhdCBuZXh0Pw0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

