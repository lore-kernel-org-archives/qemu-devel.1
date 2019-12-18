Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002D5C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A5921582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VjaZoz4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A5921582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihXnn-0003tl-Rs
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 06:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ihXmq-0003Hx-DL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ihXmo-00046G-LY
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:46:39 -0500
Received: from mail-eopbgr00093.outbound.protection.outlook.com
 ([40.107.0.93]:20869 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1ihXmj-0003y8-1f; Wed, 18 Dec 2019 06:46:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQXZgiFUd+x3RUcIKOugw1qJdRWXQEENUnoa9ShjoWIr81xH3abOVgrxVRwtKFpZoEQTP+JY7PoUOPJDYS9CQbsXBcxlt8LfvMb8aUJAENIeFyHmyHneII1R2am28PCUonaLtzukwThmmy6S9GXRG6RIhyJGgr5a+p/RCT3S/SILteX/oys3RLOyFxYZrupQyrrso+v3rxTGa9DxNjFIOyBBU+HLVKtuMPkIZqfJGpvT4w2GkLdCZNF/H3rkEKrVZR4E0Z4MMg9NYimrfQyIcu9vJfiQj07rv7A78obClqcho6O3qlOwmBCO2CX8lozYVAVe0pkhTwsNd1O6IoaKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Sj2HfOMlNPU6D/F/CGSSm+ZnW5rN4M1By2czWNCY8=;
 b=LFPGreRsOWJ+0n9Nmt1SeC/Kk+hK8/XeIQ7iyKozDLAtJZBtJUaBEIgu1GdGLIfMG46agiYdot0EFvHof5MaaJaNkD94+kkdUeZml8cxPa8qxRPIuSVUJUzDBG+Pe/1ekdvawH8owH8Vnop+HNaE5KyDH4kXFtwS1/sMj30Ef0xCxsOCngNJ4I8Z5j3WAif4XG1DCvOlJJF3LwflfWKOA4lYz882Bxrq/53ahM7S1cvVqba98Bh7MUwdb49GgbvkrZEuN2DMU7iNEGBr7UODgGYaVZhRa70XIxCKMW9Vw9FO4iXqCQPbz+KNRGKF+DBiXzvFxT8JoXhnEC1/VeFIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Sj2HfOMlNPU6D/F/CGSSm+ZnW5rN4M1By2czWNCY8=;
 b=VjaZoz4rIg9guJrkideh/KZzNUnyMbaBFveQi96NJJMeb0O/LlGJYZ+lC3U4Yey/9AyhKjD7P/YjR7T0O5QhBAvByL69A96ocPSozoQ9Kdc6E0VJUqq8hBlNUrwIRVzJjL4b+6x4x53km/LtLum89QjLGpAwWuhm42LI1ToRWt8=
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4625.eurprd08.prod.outlook.com (10.255.98.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Wed, 18 Dec 2019 11:46:28 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 11:46:27 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v12 0/3] qcow2: advanced compression options
Thread-Topic: [PATCH v12 0/3] qcow2: advanced compression options
Thread-Index: AQHVqQorzOtgprGhskagx0+UFdFUCae/33iA
Date: Wed, 18 Dec 2019 11:46:27 +0000
Message-ID: <47ca837b-ba14-48c2-d4e6-7bd877d15346@virtuozzo.com>
References: <1575288906-551879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1575288906-551879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0329.eurprd05.prod.outlook.com
 (2603:10a6:7:92::24) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb6ecbff-2fda-412d-4d61-08d783afeab1
x-ms-traffictypediagnostic: AM6PR08MB4625:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4625A896F2F7D35126718C6CF4530@AM6PR08MB4625.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(346002)(376002)(366004)(136003)(189003)(199004)(31686004)(8936002)(86362001)(81156014)(66476007)(4326008)(6512007)(6486002)(107886003)(81166006)(44832011)(66556008)(2616005)(54906003)(64756008)(186003)(2906002)(53546011)(5660300002)(31696002)(316002)(110136005)(52116002)(6506007)(478600001)(66946007)(8676002)(71200400001)(26005)(36756003)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4625;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: unI0nWIULNZ4hFtbkHWpM2QMXzThv2ZhxQrJwv8egF28OaKadjB6lS/5q/aoyteST2Wc1DzapvzrFDjxYmsJah6jp0KIUBlsRnrZ7ZybkWFpAjZVjBkDtODzmVhZabxsTgt4xCmth1TTDAIo3keSyVQXzWbMQqrKGcKD3zQ2KUGQav6XZSeDXwD6hhP/1AkvPzCXtNJhL7SuaOqhYEWVYrnkYoX4ce2MxVYbm4i36tOWyDA3b/OINDNsA7izruBmPlvEvPl+GHoIKFs5/QDz/bEBaxl58aBIvFd+i2Xu6GansUM3deo3JEPOzW/EOfAOdg1/F7JWJm+cW+I3V/NfCHZd0zWtzbLD/3ISIDg1kylBxzG7sxUMfP9sV04A+Q62AjvwxIwNdtd7cZzenl+xHzLBlE9YHzJVI4MMBRvlBhXC7PiWvriRCFliwxFbyA7i
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABCB87E96FDA454A936B06D4D9ACF4B5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6ecbff-2fda-412d-4d61-08d783afeab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 11:46:27.7877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CC349JWrKj8fhjbAB8GDXJ7Bu5CXeZ0HCVeF2JHekGzvfMp54ApRJSTAS1nKC/GRyX7uwkOCfJHjaC9yPQlKiHS0coeuc2n98riEiml15W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4625
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.93
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGluZ2luZy4uLg0KKHBsZWFzZSkNCg0KT24gMDIvMTIvMjAxOSAxNToxNSwgQW5kcmV5IFNoaW5r
ZXZpY2ggd3JvdGU6DQo+IFRoZSBjb21wcmVzc2lvbiBmaWx0ZXIgZHJpdmVyIGlzIGludHJvZHVj
ZWQgYXMgc3VnZ2VzdGVkIGJ5IE1heC4NCj4gQSBzYW1wbGUgdXNhZ2Ugb2YgdGhlIGZpbHRlciBj
YW4gYmUgZm91bmQgaW4gdGhlIHRlc3QgIzIxNC4NCj4gTm93LCBtdWx0aXBsZSBjbHVzdGVycyBj
YW4gYmUgd3JpdHRlbiBjb21wcmVzc2VkLg0KPiBJdCBpcyB1c2VmdWwgZm9yIHRoZSBiYWNrdXAg
am9iLg0KPiANCj4gdjEyOg0KPiAgICAwMTogTWlzc2VkIHRvIGNoYW5nZSB0aGUgZHJpdmVyIGlu
dGVyZmFjZSAuYmRydl9jb19ibG9ja19zdGF0dXMNCj4gICAgICAgIGZyb20gX3N0YXR1c19mcm9t
X2JhY2tpbmcgdG8gX3N0YXR1c19mcm9tX2ZpbGUgKG5vdGljZWQgYnkNCj4gICAgICAgIFZsYWRp
bWlyKS4NCj4gDQo+IEFuZHJleSBTaGlua2V2aWNoICgzKToNCj4gICAgYmxvY2s6IGludHJvZHVj
ZSBjb21wcmVzcyBmaWx0ZXIgZHJpdmVyDQo+ICAgIHFjb3cyOiBBbGxvdyB3cml0aW5nIGNvbXBy
ZXNzZWQgZGF0YSBvZiBtdWx0aXBsZSBjbHVzdGVycw0KPiAgICB0ZXN0cy9xZW11LWlvdGVzdHM6
IGFkZCBjYXNlIHRvIHdyaXRlIGNvbXByZXNzZWQgZGF0YSBvZiBtdWx0aXBsZQ0KPiAgICAgIGNs
dXN0ZXJzDQo+IA0KPiAgIGJsb2NrL01ha2VmaWxlLm9ianMgICAgICAgIHwgICAxICsNCj4gICBi
bG9jay9maWx0ZXItY29tcHJlc3MuYyAgICB8IDE2OCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gICBibG9jay9xY293Mi5jICAgICAgICAgICAgICB8IDEw
MiArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gICBxYXBpL2Jsb2NrLWNvcmUuanNvbiAg
ICAgICB8ICAxMCArLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjE0ICAgICB8ICA0MyArKysr
KysrKysrKysNCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjE0Lm91dCB8ICAxNCArKysrDQo+ICAg
NiBmaWxlcyBjaGFuZ2VkLCAzMDcgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0pDQo+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGJsb2NrL2ZpbHRlci1jb21wcmVzcy5jDQo+IA0KDQotLSANCldp
dGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQo=

