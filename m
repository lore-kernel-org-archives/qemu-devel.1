Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42B0C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 13:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A064F206C1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 13:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="evU9HmgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A064F206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxtIo-0001HK-Op
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 09:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxtI3-0000j7-T8
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 09:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxtI1-0004ij-Td
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 09:26:10 -0400
Received: from mail-eopbgr00125.outbound.protection.outlook.com
 ([40.107.0.125]:26955 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxtI1-0004cd-7v; Wed, 14 Aug 2019 09:26:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V36ChIFyi31QoOR6a9eJcpQex/7bV9kpV1ihSp+zGpwDGfu/GIqcB/4Zu8rlLAFJ+/AQKnlP1Yw5zaWy9z4FM20o46kIca4xp/WgRc6DsWZnMx/1vqoU4O3+zV5YIAenutqD7h+kMgB3H7tasF33ntUlMBYfiH7Uc/1+Iz6q17kx91N/npaU1prBFA87B7vlqwQOpB4kmVI29KcgjPXRfCY/bjZL3xUnJWJ28ZJ5Zxvh2qRS2oQthtyoK8RkWsieh/+xuhsVFDA8w/ME+2xhi7tg6pR4YDbx4MMnjS5jdrZrmlUY9vuO58fW0XyLUVUAzHGM2CdcPupkUnnsbcTAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njQosIqr5waFsCWIXJKd3Ptp/SnlunMnFSkytEU1nwk=;
 b=QuN7K7pNeBZb9atksYnWTttLR8te4ocid4MSp0yx4pgaIs08gYMStqfevzsPoIHRz9NFAB5gd+XoyUtSkYfVYZ9aba7nODhd/5mNayBwxD5kJiTwuFVZCSso3dvqUYLQNd5BfXzXnbTC4UXjLGxiaAGUUPVeAhHSA0JvtJnpzqnMzABIJnTUtqD0o+ZeVps9mfg7tA/DyYWNOSNrXOi3RpLCnlvcca7RYTYmG1Y1T0vf/aWzuXfi77spM9p5bFpaSvvt0GqglDxhjCzCr5hboHVnBezcR5QRKw4dpbSFxzVzTfhZ+cs18/hAToMzmmVAU9+LlzOEZC4gZ/E8JAuevQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njQosIqr5waFsCWIXJKd3Ptp/SnlunMnFSkytEU1nwk=;
 b=evU9HmgCWW3TyN3OhuSMZAGudZjnIqkX6c7jNzj1HlTuakk8DNFxu3MORjH7owQEUJ1BK1XAqbgOOjdcJSxfS/7PyZrFv3zMrKfg5ubxVjZKY4gkux9T+3dVwiW/Sd9QSmbTdBHtrGM8h5LIQuSBJ4waE3f2GuKwNO0zTgm6mtQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5276.eurprd08.prod.outlook.com (20.179.15.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Wed, 14 Aug 2019 13:26:06 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 13:26:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Thread-Topic: bitmaps branch rebase
Thread-Index: AQHVTWltVQx506Q4G0etSyv54Bu6tqb6rM0A
Date: Wed, 14 Aug 2019 13:26:04 +0000
Message-ID: <38cc9bad-5936-4fa9-81e6-bddbcc59758e@virtuozzo.com>
References: <ff425747-145c-68e3-134d-432fe1198247@redhat.com>
In-Reply-To: <ff425747-145c-68e3-134d-432fe1198247@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::19)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190814162600242
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce1af8e9-fb52-4419-6b59-08d720baf4ee
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5276; 
x-ms-traffictypediagnostic: DB8PR08MB5276:
x-microsoft-antispam-prvs: <DB8PR08MB527698D8EBDA818CE0128755C1AD0@DB8PR08MB5276.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39840400004)(346002)(366004)(396003)(136003)(199004)(60444003)(189003)(52314003)(3846002)(8936002)(86362001)(66066001)(31696002)(478600001)(81156014)(476003)(53936002)(4326008)(26005)(36756003)(76176011)(6506007)(6116002)(2906002)(186003)(8676002)(6246003)(386003)(81166006)(102836004)(446003)(2616005)(31686004)(25786009)(486006)(256004)(7736002)(99286004)(66446008)(110136005)(66476007)(66556008)(305945005)(14444005)(14454004)(71200400001)(6512007)(66946007)(54906003)(3480700005)(71190400001)(7116003)(6486002)(52116002)(229853002)(316002)(6436002)(5660300002)(11346002)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5276;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HyoGp0nEgJJ94h1D9CNjGXN3ZkSsmZo0fjqWmHC8t/h+Zp9U9dJjViDxMqockg4rWAvVhdxKppdD0f+nNmW2PWKYXvRYsqdHyuNHNgkn/nXPZLtSha1haOwAtD5MXGpGXH5TAhmspaPngrIienvYwEJMACGrMgV4SseUjFAaenyj/JcSUOHpWqJuh2n+LgCk9Tdu4j+Gf1lb1Z3DAKB/4a5jdrSsPdHSlzEhMrp9+cWTy0eABqfARQmHnV0ZwRtFOkPL3aYQ0h/8kbff1SX83ylg8mgnq7exp844/pXq/Fju2P1PI9CF9QMe/BwH5U9Y7QTT+wyX9l7gSFU1iObDIFI4puD/4UEvo1qE/BY8IQPGu/kt5KHNC/uiKHWrnfxDPDAu+XsdOxdIorY+e/vwpF3I4mOQIlD5c+UUt5ffDtw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B462680102B600438D8B34FC79994720@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1af8e9-fb52-4419-6b59-08d720baf4ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 13:26:04.3637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QifZbWHqUBtnv1lnrgVj6TuFyp9pvseb7OEWUpmRC0F2Wd19oDWY06TZgOrmaVImO6nDpFSlV1iHXPP7gInlP0h1bniLnAEU/HjY0P9FkJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5276
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.125
Subject: Re: [Qemu-devel] bitmaps branch rebase
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDguMDguMjAxOSAwOjQ1LCBKb2huIFNub3cgd3JvdGU6DQo+IEZZSTogSSByZWJhc2VkIGpzbm93
L2JpdG1hcHMgb24gdG9wIG9mIGt3b2xmL2Jsb2NrLW5leHQsIGl0c2VsZiBiYXNlZCBvbg0KPiB0
b3Agb2YgdjQuMS4wLXJjNC4NCj4gDQo+IEknbGwgcG9zdCB0aGlzIGFsb25nIHdpdGggdGhlIGV2
ZW50dWFsIHB1bGwgcmVxdWVzdCwgYnV0IGhlcmUncyB0aGUNCj4gZGlmZnN0YXQgYWdhaW5zdCB0
aGUgcHVibGlzaGVkIHBhdGNoZXM6DQo+IA0KPiAwMTEvMzM6WzAwMDNdIFtGQ10gJ2Jsb2NrL2Jh
Y2t1cDogdXBncmFkZSBjb3B5X2JpdG1hcCB0byBCZHJ2RGlydHlCaXRtYXAnDQo+IDAxNi8zMzpb
LS0tLV0gWy1DXSAnaW90ZXN0czogQWRkIHZpcnRpby1zY3NpIGRldmljZSBoZWxwZXInDQo+IDAx
Ny8zMzpbMDAwMl0gW0ZDXSAnaW90ZXN0czogYWRkIHRlc3QgMjU3IGZvciBiaXRtYXAtbW9kZSBi
YWNrdXBzJw0KPiAwMzAvMzM6WzAwMDFdIFtGQ10gJ2Jsb2NrL2JhY2t1cDogdGVhY2ggVE9QIHRv
IG5ldmVyIGNvcHkgdW5hbGxvY2F0ZWQNCj4gcmVnaW9ucycNCj4gMDMyLzMzOlswMDE4XSBbRkNd
ICdpb3Rlc3RzLzI1NzogdGVzdCB0cmFkaXRpb25hbCBzeW5jIG1vZGVzJw0KPiANCj4gMTE6IEEg
bmV3IGhiaXRtYXAgY2FsbCB3YXMgYWRkZWQgdXBzdHJlYW0sIGNoYW5nZWQgdG8NCj4gYmRydl9k
aXJ0eV9iaXRtYXBfbmV4dF96ZXJvLg0KPiAxNjogQ29udGV4dC1vbmx5IChzZWxmLmhhc19xdWl0
IGlzIG5ldyBjb250ZXh0IGluIDA0MCkNCj4gMTc6IFJlbW92ZWQgJ2F1dG8nIHRvIGZvbGxvdyB1
cHN0cmVhbSB0cmVuZHMgaW4gaW90ZXN0IGZhc2hpb24NCj4gMzA6IFJlbW92ZSByZXQgPSAtRUNB
TkNFTEVEIGFzIGFncmVlZCBvbi1saXN0Ow0KPiAgICAgIENvbnRleHQgY2hhbmdlcyBmb3IgZGly
dHlfZW5kIHBhdGNoZXMNCj4gMzI6IEZpeCBjYXBpdGFsaXphdGlvbiBpbiB0ZXN0LCBhcyBtZW50
aW9uZWQgb24gbGlzdC4NCj4gDQo+IEkgdGhpbmsgdGhlIGNoYW5nZXMgYXJlIGFjdHVhbGx5IGZh
aXJseSBtaW5pbWFsIGFuZCB0cmFuc2xhdGUgZmFpcmx5DQo+IGRpcmVjdGx5OyBsZXQncyByZXZp
ZXcgdGhlIHJlYmFzZSBvbi1saXN0IGluIHJlc3BvbnNlIHRvIHRoZSBQVUxMIG1haWxzDQo+IHdo
ZW4gSSBzZW5kIHRoZW0uDQo+IA0KDQoNClRoZXJlIGlzIGEgYnVnIGluICJibG9jay9iYWNrdXA6
IHRlYWNoIFRPUCB0byBuZXZlciBjb3B5IHVuYWxsb2NhdGVkIHJlZ2lvbnMiOg0KDQoNCiA+IEBA
IC0yNTYsNiArMjg3LDE1IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGJhY2t1cF9kb19jb3co
QmFja3VwQmxvY2tKb2IgKmpvYiwNCiA+ICAgICAgICAgICAgICBjb250aW51ZTsgLyogYWxyZWFk
eSBjb3BpZWQgKi8NCiA+ICAgICAgICAgIH0NCiA+DQogPiArICAgICAgICBpZiAoam9iLT5pbml0
aWFsaXppbmdfYml0bWFwKSB7DQogPiArICAgICAgICAgICAgcmV0ID0gYmFja3VwX2JpdG1hcF9y
ZXNldF91bmFsbG9jYXRlZChqb2IsIHN0YXJ0LCAmc2tpcF9ieXRlcyk7DQogPiArICAgICAgICAg
ICAgaWYgKHJldCA9PSAwKSB7DQogPiArICAgICAgICAgICAgICAgIHRyYWNlX2JhY2t1cF9kb19j
b3dfc2tpcF9yYW5nZShqb2IsIHN0YXJ0LCBza2lwX2J5dGVzKTsNCiA+ICsgICAgICAgICAgICAg
ICAgc3RhcnQgKz0gc2tpcF9ieXRlczsNCiA+ICsgICAgICAgICAgICAgICAgY29udGludWU7DQog
PiArICAgICAgICAgICAgfQ0KDQphc3N1bWUgcmV0ID09IDEsIHNvIHdlIHNlZSBza2lwX2J5dGVz
IG9mIGFsbG9jYXRlZCBieXRlcw0KDQogPiArICAgICAgICB9DQogPiArDQogPiAgICAgICAgICBk
aXJ0eV9lbmQgPSBiZHJ2X2RpcnR5X2JpdG1hcF9uZXh0X3plcm8oam9iLT5jb3B5X2JpdG1hcCwg
c3RhcnQsDQogPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKGVuZCAtIHN0YXJ0KSk7DQogPiAgICAgICAgICBpZiAoZGlydHlfZW5kIDwgMCkgew0KID4N
Cg0KYnV0IHRoZW4sIHdlIG1heSBjb3B5IG1vcmUgdGhhbiBza2lwX2J5dGVzLCBpLmUuIHRvdWNo
IGZvbGxvd2luZyBwb3NzaWJseSB1bmFsbG9jYXRlZCBhcmVhLg0KDQo9PT0NCg0KQWxzbywgaWYg
d2FudCB0byBmaXggaXQgYW55d2F5LCBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIG1ha2UgYWRkaXRp
b25hbCB3aGlsZSBsb29wIGJlZm9yZSB0aGlzIG9uZQ0KYW5kIHJlc2V0IGFsbCB1bmFsbG9jYXRl
ZCBmcm9tIHN0YXJ0IHRvIGVuZCwgb3RoZXJ3aXNlIHdlIG1heSBjYWxsIGJsb2NrX3N0YXR1cyBm
b3IgZXZlcnkgY2x1c3Rlcg0Kb24gZWFjaCBsb29wIGl0ZXJhdGlvbiwgZXZlbiBpZiB0aGUgZmly
c3QgY2FsbCByZXR1cm5zIHNraXBfYnl0ZXMgPj0gKGVuZCAtIHN0YXJ0KS4NCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

