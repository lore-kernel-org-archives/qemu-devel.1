Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94D1C2D0D2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D1B2064B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TSR8CjqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D1B2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJVZ-0003BD-R3
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iiJMH-0007DK-AN
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:34:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iiJMG-0007a1-0f
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:34:24 -0500
Received: from mail-ve1eur01on071b.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::71b]:49793
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iiJMF-0007N1-34
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:34:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrKbLoB/2ssyK/D1rjAGGB47LJDJEUCgZrLI3iP9suUgVBSFfrnvKg6X+sf9G7wP8Ue/Y/aE4UDigg5zftNoci0I6X2ZsRCXfPRV4NiF1GyRH7uTGYN7lo434ZId1W1MPEP5iP/ojVGez5dQDvogd07nYmMp1oW3e4o14dPa1O6dXwbYvClKvRZ+fmAh+/+wADzfEKv1dZXqus5LLhrWVDiPMy1fcZ3AX8sjOlG/9sM3fqPv8wJpt4i+ic0y7j8k87GvGRU0qWpaO7xcmQ+SFxt6FU8RjIC3H+K99UBLdFv1RKtC1vOPe7y/a1sGM0iBZ/fu9UVpt9pGNNqUdwBxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZcFlmdGf0xkg3DRRpS45eXlhTZnEVABnq1F8apbA9k=;
 b=RvwwpW4aTppF+kMJGvVtLnNYVNhlUDr+anxrH4I1rjMXCYcVijM1PhL2DUurauwaKdlE1XzSlMAoJDwaDd+aLVo5S+kaqtneP8ocABm5rRhdN5IUGQlNHoTFV+A75SHLRB/JIeaJpAN14BJRUjR79U3jLxwdAw14RqB7lp04NIVCNVvZ7lVI6YEW/71g+1iFzYU8d1XCg+Tue++SIxjCArdDwN79obCxPa0sUnHtuJLs6zkYLSMCrB+etfKiLEdEDwwVr8npgjdwLUMV3Z5DmDIXXiSGoDT1Il4ahs2a9B4iOLv7QZVvYk3GryCdmfESrdCXvsSc1GwWoSVamdsdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZcFlmdGf0xkg3DRRpS45eXlhTZnEVABnq1F8apbA9k=;
 b=TSR8CjqKROaxS5rE6jsp8bR4aw1DPcKRKkr8hBgjYz51ggBOqnpKzEGg72rUF1zoNllF7ZVoyskQ9DEgCJt0wRASAO+RGAaRsGIa3745EK9wW0MC68kNXuNGZs/2sMmv9ZpFobM+8NPb8jG+bVeTicupIxEjtSLw+1agspAZ97Y=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3155.eurprd08.prod.outlook.com (52.134.90.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Fri, 20 Dec 2019 14:34:20 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::893d:bf37:4b98:12]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::893d:bf37:4b98:12%4]) with mapi id 15.20.2559.012; Fri, 20 Dec 2019
 14:34:20 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 0/2] virtio: make seg_max virtqueue size dependent
Thread-Topic: [PATCH v5 0/2] virtio: make seg_max virtqueue size dependent
Thread-Index: AQHVt0FSJkWGbX6jQES8JXuqqI6J96fDFpuA
Date: Fri, 20 Dec 2019 14:34:19 +0000
Message-ID: <4aac9743-336a-c18b-7cc8-cd02d99cca6a@virtuozzo.com>
References: <20191220140443.1399-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20191220140443.1399-1-dplotnikov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0241.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::17) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b276622-7c74-42ec-d021-08d78559b308
x-ms-traffictypediagnostic: AM0PR08MB3155:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB31551B3425695E3094886A14CF2D0@AM0PR08MB3155.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(366004)(346002)(39850400004)(396003)(189003)(199004)(53546011)(2906002)(186003)(36756003)(26005)(6512007)(5660300002)(6486002)(8676002)(6916009)(81166006)(6506007)(316002)(478600001)(52116002)(71200400001)(66476007)(66556008)(64756008)(66446008)(107886003)(66946007)(86362001)(31696002)(2616005)(31686004)(54906003)(8936002)(81156014)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3155;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJAmZj9xSqioByN245GXq2C6IA6OE+f4eh8/Jt6X6G4UE1Mp4zC6OrxoSGKeMpjfADU4R6QWr3rvfwIrT5MT2nwFinfyf8Q1YfFgC3bOa5zzlQgx5xr5CoFfUEV/L44YstOLeDDlJsq1Vzv8gKIwSudISpebgdv5di6ts/8SbbjrNNIR5j2hQ2Fv1jFeuZacWwerXiJClNNBo4Su1wWoE6BMwxx74fdSq66WcEjkyAkDE0wiZnKS8ok0a2dwZIL0Imd09KJ1FuvVW348/xNWQPmEfgiU1exvUB5ogj5rquX4vkA6HTjbmgdkXyriI97DQFycOuT32pkRSLHO5pvFFkxAGOWOeIIBMCSMqOcK9V0FiIuWJwiMo0qLOaE0wE+7xsDwjnEtT6rhGXWzZfFiD/861z0kb8mUDeEVPGYIeeFeVcFhiT78Ko2xp66JM+bL
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A743CA8A6F43D4E822F11EA51FC52FB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b276622-7c74-42ec-d021-08d78559b308
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 14:34:19.9876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uxl82rqu7FOChN1HfYrmqTs4vXHQ8luOGB7dFEN4PNkMqziXrB6NgR0gB3wvAPSCa8Jns5IbygjDpsgib69kcX2zOur0iWafIivnM0Iz4gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3155
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::71b
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "kwolf@radhat.com" <kwolf@radhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@radhat.com" <mst@radhat.com>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UExFQVNFLCBJR05PUkUgVEhJUyBQQVRDSCBTRVQNCg0KT24gMjAuMTIuMjAxOSAxNzowNCwgRGVu
aXMgUGxvdG5pa292IHdyb3RlOg0KPiB2NToNCj4gICAgKiByZWJhc2VkIG9uIHRoZSByZWNlbnQg
bWFzdGVyIFtNU1RdDQo+ICAgICogTk9URTogdGhlIHRlc3QgZG9lc24ndCBwYXNzIGJlY2F1c2Ug
NS4wIG1hY2hpbmUgdHlwZSB1c2UgNC4yIGNvbXBhdA0KPiAgICAgICAgICAgIGluc3RlYWQgb2Yg
aXQncyBvd24gb3Igbm8gY29tcGF0IGF0IGFsbC4gVGhlIHRlc3Qgd2lsbCBwYXNzDQo+ICAgICAg
ICAgICAgb25jZSB0aGUgbmV3IDUuMCBjb21wYXQgaXMgdXNlZC4NCj4NCj4gdjQ6DQo+ICAgICog
cmViYXNlZCBvbiA0LjIgW01TVF0NCj4NCj4gdjM6DQo+ICAgICogYWRkIHByb3BlcnR5IHRvIHNl
dCBpbiBtYWNoaW5lIHR5cGUgW01TVF0NCj4gICAgKiBhZGQgbWluIHF1ZXVlIHNpemUgY2hlY2sg
W1N0ZWZhbl0NCj4gICAgKiBhZGQgYXZvY2FkbyBiYXNlZCB0ZXN0IFtNYXgsIFN0ZWZhbiwgRWR1
YXJkbywgQ2xlYmVyXQ0KPg0KPiB2MjoNCj4gICAgKiB0aGUgc3RhbmRhbG9uZSBwYXRjaCB0byBt
YWtlIHNlZ19tYXggdmlydHF1ZXVlIHNpemUgZGVwZW5kZW50DQo+ICAgICogb3RoZXIgcGF0Y2hl
cyBhcmUgcG9zdHBvbmVkDQo+DQo+IHYxOg0KPiAgICB0aGUgaW5pdGlhbCBzZXJpZXMNCj4NCj4g
RGVuaXMgUGxvdG5pa292ICgyKToNCj4gICAgdmlydGlvOiBtYWtlIHNlZ19tYXggdmlydHF1ZXVl
IHNpemUgZGVwZW5kZW50DQo+ICAgIHRlc3RzOiBhZGQgdmlydGlvLXNjc2kgYW5kIHZpcnRpby1i
bGsgc2VnX21heF9hZGp1c3QgdGVzdA0KPg0KPiAgIGh3L2Jsb2NrL3ZpcnRpby1ibGsuYyAgICAg
ICAgICAgICAgICAgICAgIHwgICA5ICstDQo+ICAgaHcvY29yZS9tYWNoaW5lLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDMgKw0KPiAgIGh3L3Njc2kvdmhvc3Qtc2NzaS5jICAgICAgICAg
ICAgICAgICAgICAgIHwgICAyICsNCj4gICBody9zY3NpL3ZpcnRpby1zY3NpLmMgICAgICAgICAg
ICAgICAgICAgICB8ICAxMCArLQ0KPiAgIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1ibGsuaCAg
ICAgICAgICAgIHwgICAxICsNCj4gICBpbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tc2NzaS5oICAg
ICAgICAgICB8ICAgMSArDQo+ICAgdGVzdHMvYWNjZXB0YW5jZS92aXJ0aW9fc2VnX21heF9hZGp1
c3QucHkgfCAxMzQgKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDcgZmlsZXMgY2hhbmdlZCwg
MTU4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNzU1
IHRlc3RzL2FjY2VwdGFuY2UvdmlydGlvX3NlZ19tYXhfYWRqdXN0LnB5DQo+DQoNCg==

