Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C4FC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165D420673
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eV44ebQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165D420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD6bI-0006on-5H
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 08:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD6a0-0005sw-Cr
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD6Zz-0006qi-1E
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:39:36 -0400
Received: from mail-eopbgr150122.outbound.protection.outlook.com
 ([40.107.15.122]:61761 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD6Zy-0006qX-7g; Wed, 25 Sep 2019 08:39:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPiRBOM3vyjSYAHKD3qeORFqZPhSYT6e3UM6YyqdgcYddtZGF6iMSOBR5LAyDGpC0YKeF6t6heB0cF+781EjIPUdU2NrxmK595dSs6sMVX4FQmh0TvEoVqwzapElu569kWaR7cHq/8VpkAJkyss5zPHBIwOs4gnVHpqg6XAdtTw1e95Sno1MLpiBvFD5bHhSgPBSVeEfTuB+xE8F/rdXOxtAzNmF62wDe5+hDDhlvNbpxcrbgqiKAdZRtcIy5XoDZUfHY+ChCFaX2yJiq+NjcSK3CwUKEOy/LeigLD3aQk6pNxjg+/rknjW5YNqxFg0Y64puRSCwRN+BTZxO1PhrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BKw5f4Cq8WpgXQzmqFeB67bVFf2sLtOfp3gYSMSptw=;
 b=oXHuOMemJbxz2GHiu499v2M++Awrx7Nl2olNDpBBLIbX4RAlOWq5UAZJ4EALppQR0nlh8VSoEtifK5yd2UcAYOYpO1YNNoJszre5mUDYfrHB8OSdd6ZAJWbHISFp3dfk/rzB7e3gItFnZMT6aoP+Jq3VwX04Aj/1JP6it8LwP51m5iKmIqjr6jZCt2lRfXLmJ+WSIOrQN32Kah+uta34ewpEcTkSfxaw6Nl7m4vSlL1a7f0oX8ygB7e4FlTyhTl6dDrAUp5nUOUVP2/EB5Koa1hNOexTL3/YJ6DWza1nm8XmzDF2EWPlvzZgfjGMQO48b3ASUlBEsRIM9w4pPaRApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BKw5f4Cq8WpgXQzmqFeB67bVFf2sLtOfp3gYSMSptw=;
 b=eV44ebQY7XyaeP6PgMpOH1iv4xGdwVNdAKiJGIP2M/jGGlfL3fxDA9Ss6L3G5hvGPDznF79jGl5XBxHVejgw2ytx2zODzyA7thgFH+DmtEL2cr6Cy2+X995QFfTLwQpBwUpK8N4y7fcpGupE+GlFNNgPXP7q9ob8S2Mf/tnH8qo=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5499.eurprd08.prod.outlook.com (10.255.185.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 12:39:31 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 12:39:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 06/22] block: Add bdrv_recurse_can_replace()
Thread-Topic: [PATCH 06/22] block: Add bdrv_recurse_can_replace()
Thread-Index: AQHVb8nw0xHdweN830moo46fBzOAIqc8XPWA
Date: Wed, 25 Sep 2019 12:39:31 +0000
Message-ID: <37b5883c-b4e9-4b9d-fae4-8a1f0b04cd54@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-7-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-7-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0013.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::23) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925153927725
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3e7b8d2-d4f1-4ed9-4066-08d741b5695e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5499; 
x-ms-traffictypediagnostic: DB8PR08MB5499:
x-microsoft-antispam-prvs: <DB8PR08MB5499C73AE7C8146FEFBB7E3CC1870@DB8PR08MB5499.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(396003)(346002)(366004)(136003)(376002)(39850400004)(199004)(189003)(25786009)(86362001)(54906003)(186003)(2906002)(3846002)(66476007)(2501003)(476003)(6116002)(66946007)(486006)(5660300002)(31686004)(11346002)(446003)(229853002)(6506007)(386003)(26005)(4326008)(66066001)(76176011)(6486002)(2616005)(102836004)(14454004)(6512007)(81166006)(71200400001)(71190400001)(316002)(7736002)(478600001)(8676002)(81156014)(31696002)(14444005)(305945005)(6436002)(256004)(52116002)(66556008)(64756008)(66446008)(36756003)(8936002)(110136005)(6246003)(99286004)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5499;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jUoK13UkQ3cWuHvvU7rf95SGNnnt+wO1M/bRjO/a7XaDHqqM/uiW6mt5JJzXADXqLCUJnOM5G2GgWLAKKB5zY62CO/sAZxEa+PlrkSUxBB6hnQcRaeKkB9WD/gvjECGFCg/u61+O7ZOK5lmq/CHwLFZYPs5uS0WiaZ/6C/Dw5V3/Tmwr1Dnse2rG7fbuyQda2YiQBRBJ3JjkTTK15fEWT0A+E2ztQs0Jyz3m6ngoKLtAYDUVPhtffN232WlmtPUgS4SXAXJ85dOGchNj704nsAv2w4LsBaock+8jWYXEEsAtn9z8gp4UbV7nj6yOLPxjU7sNksEux2JntM5PRDBxmXTzO/YwXR2iQrKY3EaqvV3Wn7kMOhasuFPT2znGuWFPYLZtYv/giMeJ8UF/j/eZKVwtuNjLvufGesj2wap86b8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <559CEC5BD0E2664989963A23634BD967@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e7b8d2-d4f1-4ed9-4066-08d741b5695e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 12:39:31.0316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2E6np1xkda8jBXZDMr+DhTxR6xtufYlCkeStZStV7r9mDyubc/rTVqFdP4YvFnGJttI0Nhkwf6nrkEGgXzYUgx9gWcu1s+fh1qMF5vXZQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5499
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.122
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBBZnRlciBhIGNvdXBsZSBvZiBm
b2xsb3ctdXAgcGF0Y2hlcywgdGhpcyBmdW5jdGlvbiB3aWxsIHJlcGxhY2UNCj4gYmRydl9yZWN1
cnNlX2lzX2ZpcnN0X25vbl9maWx0ZXIoKSBpbiBjaGVja190b19yZXBsYWNlX25vZGUoKS4NCj4g
DQo+IGJkcnZfcmVjdXJzZV9pc19maXJzdF9ub25fZmlsdGVyKCkgaXMgYm90aCBub3Qgc3VmZmlj
aWVudGx5IHNwZWNpZmljIGZvcg0KPiBjaGVja190b19yZXBsYWNlX25vZGUoKSAoaXQgYWxsb3dz
IGNhc2VzIHRoYXQgc2hvdWxkIG5vdCBiZSBhbGxvd2VkLA0KPiBsaWtlIHJlcGxhY2luZyBjaGls
ZCBub2RlcyBvZiBxdW9ydW0gd2l0aCBkaXNzZW50aW5nIGRhdGEgdGhhdCBoYXZlIG1vcmUNCj4g
cGFyZW50cyB0aGFuIGp1c3QgcXVvcnVtKSwgYW5kIGl0IGlzIHRvbyByZXN0cmljdGl2ZSAoaXQg
aXMgcGVyZmVjdGx5DQo+IGZpbmUgdG8gcmVwbGFjZSBmaWx0ZXJzKS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUv
YmxvY2svYmxvY2tfaW50LmggfCAxMCArKysrKysrKysrDQo+ICAgYmxvY2suYyAgICAgICAgICAg
ICAgICAgICB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAg
MiBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9ibG9jay9ibG9ja19pbnQuaCBiL2luY2x1ZGUvYmxvY2svYmxvY2tfaW50LmgNCj4gaW5k
ZXggNWZkNGYxN2Q5My4uMGJlN2QxMmYwNCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9ibG9jay9i
bG9ja19pbnQuaA0KPiArKysgYi9pbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oDQo+IEBAIC0xMDMs
NiArMTAzLDEzIEBAIHN0cnVjdCBCbG9ja0RyaXZlciB7DQo+ICAgICAgICAqLw0KPiAgICAgICBi
b29sICgqYmRydl9yZWN1cnNlX2lzX2ZpcnN0X25vbl9maWx0ZXIpKEJsb2NrRHJpdmVyU3RhdGUg
KmJzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJs
b2NrRHJpdmVyU3RhdGUgKmNhbmRpZGF0ZSk7DQo+ICsgICAgLyoNCj4gKyAgICAgKiBSZXR1cm4g
dHJ1ZSBpZiBAdG9fcmVwbGFjZSBjYW4gYmUgcmVwbGFjZWQgYnkgYSBCRFMgd2l0aCB0aGUNCj4g
KyAgICAgKiBzYW1lIGRhdGEgYXMgQGJzIHdpdGhvdXQgaXQgYWZmZWN0aW5nIEBicydzIGJlaGF2
aW9yICh0aGF0IGlzLA0KPiArICAgICAqIHdpdGhvdXQgaXQgYmVpbmcgdmlzaWJsZSB0byBAYnMn
cyBwYXJlbnRzKS4NCj4gKyAgICAgKi8NCj4gKyAgICBib29sICgqYmRydl9yZWN1cnNlX2Nhbl9y
ZXBsYWNlKShCbG9ja0RyaXZlclN0YXRlICpicywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBCbG9ja0RyaXZlclN0YXRlICp0b19yZXBsYWNlKTsNCj4gICANCj4gICAg
ICAgaW50ICgqYmRydl9wcm9iZSkoY29uc3QgdWludDhfdCAqYnVmLCBpbnQgYnVmX3NpemUsIGNv
bnN0IGNoYXIgKmZpbGVuYW1lKTsNCj4gICAgICAgaW50ICgqYmRydl9wcm9iZV9kZXZpY2UpKGNv
bnN0IGNoYXIgKmZpbGVuYW1lKTsNCj4gQEAgLTEyNTQsNiArMTI2MSw5IEBAIHZvaWQgYmRydl9m
b3JtYXRfZGVmYXVsdF9wZXJtcyhCbG9ja0RyaXZlclN0YXRlICpicywgQmRydkNoaWxkICpjLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBwZXJtLCB1aW50NjRf
dCBzaGFyZWQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90ICpu
cGVybSwgdWludDY0X3QgKm5zaGFyZWQpOw0KPiAgIA0KPiArYm9vbCBiZHJ2X3JlY3Vyc2VfY2Fu
X3JlcGxhY2UoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBCbG9ja0RyaXZlclN0YXRlICp0b19yZXBsYWNlKTsNCj4gKw0KPiAgIC8qDQo+ICAg
ICogRGVmYXVsdCBpbXBsZW1lbnRhdGlvbiBmb3IgZHJpdmVycyB0byBwYXNzIGJkcnZfY29fYmxv
Y2tfc3RhdHVzKCkgdG8NCj4gICAgKiB0aGVpciBmaWxlLg0KPiBkaWZmIC0tZ2l0IGEvYmxvY2su
YyBiL2Jsb2NrLmMNCj4gaW5kZXggN2Q5OWNhNjkyYy4uYTJkZWNhNGFjOSAxMDA2NDQNCj4gLS0t
IGEvYmxvY2suYw0KPiArKysgYi9ibG9jay5jDQo+IEBAIC02MjA2LDYgKzYyMDYsNDQgQEAgYm9v
bCBiZHJ2X3JlY3Vyc2VfaXNfZmlyc3Rfbm9uX2ZpbHRlcihCbG9ja0RyaXZlclN0YXRlICpicywN
Cj4gICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgIH0NCj4gICANCj4gKy8qDQo+ICsgKiBUaGlzIGZ1
bmN0aW9uIGNoZWNrcyB3aGV0aGVyIHRoZSBnaXZlbiBAdG9fcmVwbGFjZSBpcyBhbGxvd2VkIHRv
IGJlDQo+ICsgKiByZXBsYWNlZCBieSBhIG5vZGUgdGhhdCBhbHdheXMgc2hvd3MgdGhlIHNhbWUg
ZGF0YSBhcyBAYnMuICBUaGlzIGlzDQo+ICsgKiB1c2VkIGZvciBleGFtcGxlIHRvIHZlcmlmeSB3
aGV0aGVyIHRoZSBtaXJyb3Igam9iIGNhbiByZXBsYWNlDQo+ICsgKiBAdG9fcmVwbGFjZSBieSB0
aGUgdGFyZ2V0IG1pcnJvcmVkIGZyb20gQGJzLg0KPiArICogVG8gYmUgcmVwbGFjZWFibGUsIEBi
cyBhbmQgQHRvX3JlcGxhY2UgbWF5IGVpdGhlciBiZSBndWFyYW50ZWVkIHRvDQo+ICsgKiBhbHdh
eXMgc2hvdyB0aGUgc2FtZSBkYXRhIChiZWNhdXNlIHRoZXkgYXJlIG9ubHkgY29ubmVjdGVkIHRo
cm91Z2gNCj4gKyAqIGZpbHRlcnMpLCBvciBzb21lIGRyaXZlciBtYXkgYWxsb3cgcmVwbGFjaW5n
IG9uZSBvZiBpdHMgY2hpbGRyZW4NCj4gKyAqIGJlY2F1c2UgaXQgY2FuIGd1YXJhbnRlZSB0aGF0
IHRoaXMgY2hpbGQncyBkYXRhIGlzIG5vdCB2aXNpYmxlIGF0DQo+ICsgKiBhbGwgKGZvciBleGFt
cGxlLCBmb3IgZGlzc2VudGluZyBxdW9ydW0gY2hpbGRyZW4gdGhhdCBoYXZlIG5vIG90aGVyDQo+
ICsgKiBwYXJlbnRzKS4NCj4gKyAqLw0KPiArYm9vbCBiZHJ2X3JlY3Vyc2VfY2FuX3JlcGxhY2Uo
QmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBC
bG9ja0RyaXZlclN0YXRlICp0b19yZXBsYWNlKQ0KPiArew0KPiArICAgIGlmICghYnMgfHwgIWJz
LT5kcnYpIHsNCj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgIH0NCj4gKw0KPiArICAg
IGlmIChicyA9PSB0b19yZXBsYWNlKSB7DQo+ICsgICAgICAgIHJldHVybiB0cnVlOw0KPiArICAg
IH0NCj4gKw0KPiArICAgIC8qIEZvciBmaWx0ZXJzLCB3ZSBjYW4gcmVjdXJzZSBvbiBvdXIgb3du
ICovDQo+ICsgICAgaWYgKGJzLT5kcnYtPmlzX2ZpbHRlcikgew0KPiArICAgICAgICBCZHJ2Q2hp
bGQgKmNoaWxkID0gYnMtPmZpbGUgPzogYnMtPmJhY2tpbmc7DQoNCnRoZW4sIG1heWJlIGFzc2V0
KCFicy0+ZHJ2LT5iZHJ2X3JlY3Vyc2VfY2FuX3JlcGxhY2UpDQoNCj4gKyAgICAgICAgcmV0dXJu
IGJkcnZfcmVjdXJzZV9jYW5fcmVwbGFjZShjaGlsZC0+YnMsIHRvX3JlcGxhY2UpOw0KPiArICAg
IH0NCg0Kb3IsIHRoaXMgbWF5IGJlIGZpbHRlci1za2lwcGluZyBsb29wIGluc3RlYWQgb2YgcmVj
dXJzaW9uLCBsaWtlDQoNCndoaWxlIChicyAmJiBicy0+ZHJ2ICYmIGJzLT5kcnYtPmlzX2ZpbHRl
cikgew0KICAgYnMgPSAoYnMtPmZpbGUgPzogYnMtPmJhY2tpbmcpLT5iczsNCn0NCg0KYXQgZnVu
Y3Rpb24gc3RhcnQuDQoNCmVpdGhlciB3YXk6DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1l
bnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCj4gKw0KPiArICAg
IC8qIFNlZSB3aGF0IHRoZSBkcml2ZXIgY2FuIGRvICovDQo+ICsgICAgaWYgKGJzLT5kcnYtPmJk
cnZfcmVjdXJzZV9jYW5fcmVwbGFjZSkgew0KPiArICAgICAgICByZXR1cm4gYnMtPmRydi0+YmRy
dl9yZWN1cnNlX2Nhbl9yZXBsYWNlKGJzLCB0b19yZXBsYWNlKTsNCj4gKyAgICB9DQo+ICsNCj4g
KyAgICAvKiBTYWZlIGRlZmF1bHQgKi8NCj4gKyAgICByZXR1cm4gZmFsc2U7DQo+ICt9DQo+ICsN
Cj4gICBCbG9ja0RyaXZlclN0YXRlICpjaGVja190b19yZXBsYWNlX25vZGUoQmxvY2tEcml2ZXJT
dGF0ZSAqcGFyZW50X2JzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjb25zdCBjaGFyICpub2RlX25hbWUsIEVycm9yICoqZXJycCkNCj4gICB7DQo+IA0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

