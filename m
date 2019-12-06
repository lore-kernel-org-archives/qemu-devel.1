Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9070FC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5530C24659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="P4zO4459"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5530C24659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEbY-0006Yi-V3
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idEMT-0007cZ-QE
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:13:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idEMO-00076g-GR
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:13:34 -0500
Received: from mail-eopbgr80129.outbound.protection.outlook.com
 ([40.107.8.129]:57769 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1idEMM-000738-M5; Fri, 06 Dec 2019 09:13:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyhV2+9QWKhvDgT1ZTiR2aoJRUal8jtVuuU0/m5PYcuXGB/8Cta6J3bm9V/H3qzq11VNWxaDzwbd/UvmU9rl/kD13+NB1FyBOhHfs2OKqUGXW98rLcq9w2eUVAJrWaOwxRIWrqT5vPOUJIRFSpNOsLiUs5T8NRnicQeW04gwcVpknuNOu6tjOv9aR0z6QBH0b0ZgLyOqbR7LKiu1ekXcRh0rXy7prdGt/ptS0K5BZLg2PjTiTChs/ZyAun4GYekiuJ2lomF8DdKvEJD2rRiQIg5pSIxQA6JPDT442rqdEaVEPl+VNhtdHPGglLtTwzXkc/74Wf/qrL94PYvsq7ovQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUPXIha3oBLF9Fv9HxiwFX9ODyffyARA8zlqPYXF3RE=;
 b=jDPKrDWXpaHsV2IgQX9HLpdJf14ZHVtja0amWkoC2E6wxyKGsaNTY1vaICSC0EJX9Iay7Tsa8WOXGuenctpPUfjTs1SddN/ihniWg5uxnq2Ii9l8VcdwDp+QoS4HHzR8gTNw5X18WFVXvVtH9dpqgpRjLObDitdwOdlANslkzcTzFSsU2RzQ1rEzVcUM2ib8qVeXuwjGsC3wQdTsGEt5TpI8m78e7J0pPUPuE+QzXrM5yi5rIbK0r5zLyS6riIIKWHQ0Aq8lSpTOhXlNebZpBirehcVxsdAPfaCiaatC3ClS1PMgh9MPj/CAxcBXd1d+GgR2sOV3zMm+R1PjwohZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUPXIha3oBLF9Fv9HxiwFX9ODyffyARA8zlqPYXF3RE=;
 b=P4zO4459qkANrLVdAeFkNes5UoH+OgyZjSFDoHkc38A68c90P2iIWAESH3SCaM7QDNA9chW8nkd8ZxJusmrqzZtdNtwjtQS/+OXh0ubrEynl0lM8j3P5y6S9BTqAkSMop0EgNzZ0kajrUfTCHXZZVWdlgTxnVWrF+uiOltnQoiw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3576.eurprd08.prod.outlook.com (20.177.114.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Fri, 6 Dec 2019 10:37:58 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 10:37:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Subject: Re: Offline manipulation of Dirty Bitmaps by qemu-img
Thread-Topic: Offline manipulation of Dirty Bitmaps by qemu-img
Thread-Index: AQHVq7yRhp4+7HnhFUuZ1nkVXc7x7Kes6vcA
Date: Fri, 6 Dec 2019 10:37:58 +0000
Message-ID: <d6f89557-d4e5-02f4-3082-37e61447bf87@virtuozzo.com>
References: <4a9e19d1-fe87-e3f5-8faf-18127914b7b4@redhat.com>
In-Reply-To: <4a9e19d1-fe87-e3f5-8faf-18127914b7b4@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0282.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::34) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191206133756127
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffba9126-ef92-4d42-86a6-08d77a385c3e
x-ms-traffictypediagnostic: AM6PR08MB3576:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB35769D21D75B5B49269D333CC15F0@AM6PR08MB3576.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(136003)(376002)(39850400004)(366004)(189003)(199004)(5660300002)(8936002)(52116002)(71190400001)(229853002)(86362001)(14454004)(71200400001)(14444005)(2906002)(6512007)(99286004)(76176011)(36756003)(478600001)(31696002)(110136005)(6486002)(107886003)(54906003)(186003)(31686004)(66446008)(4326008)(66556008)(64756008)(66476007)(66946007)(316002)(2616005)(102836004)(25786009)(11346002)(81156014)(81166006)(26005)(6506007)(8676002)(305945005)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3576;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FGvyU3pufuHw7DAIAE15HWzdOvp82j7KfcYL6QwkvBeouxlys1DdBKWUmKEfEJzj6JvIFKl+beehTQNLT/aKKYBOUg+IV/avwk6eZ7Bn2UMgEOcM/F7IQaby8GnOd4oSxlr44ZBqeSxibYyXPdB8v8kdVzZ4X/prgbFK2QoaaNg1H/VuI7AaSrU0cMeQnaAKubpmgaueBbdvUDxQxDz0FgAGYyE9JH6Ir3b+3DU96Umv8u/AcO5tABilWgyMagmgfEyu2f3Ldonfk0UspQs3y8gvML+XkU+OqcM9uoC26CWW2n3sXmmQBw5e0cv6PkyQvRhEaNfnx9GAd65qsJF6K89lg0dSTxNsCO/BiVOrOjsGjnB6oMTuGCb+a4DIPXAvF3V+aUG18ILn4UYT6h1QR6WU1KxAyysK5oNllIl80SfeXI0sX5ndEXo5vkSmi/hcMfkPsXc49tfqmNanJfene6GFcrbLCAzXWM6ufmdZ2YD5fbLL8RXkU6kBgpckOjBB
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FE145BAB8564D41A1512C95FA654796@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffba9126-ef92-4d42-86a6-08d77a385c3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 10:37:58.2022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bF4xobyR7lyqLj+vRuvSH0G31YwCx6jjCErkmuSNfdWj6S8VOLoi1mtjfeMP2LTxe36n8huqXJcX323Os1EliC8TSSmdBQK5mjc2fGmJLrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3576
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.129
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
Cc: Nir Soffer <nsoffer@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "libvirt-list@redhat.com" <libvirt-list@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMTIuMjAxOSAxOjM3LCBKb2huIFNub3cgd3JvdGU6DQo+IFRoaXMgaGFzIGNvbWUgdXAgaW4g
dGhlIHBhc3QsIGFuZCBJIGJlbGlldmUgd2UgZGlzY3Vzc2VkIHRoaXMgYXQgS1ZNDQo+IEZvcnVt
LCB0b286DQo+IA0KPiBUaGVyZSBoYXZlIGJlZW4gcmVxdWVzdHMgZnJvbSBvVmlydCAodmlhIE5p
ciBTb2ZmZXIpIHRvIGFkZCBzb21lIG9mZmxpbmUNCj4gYml0bWFwIG1hbmlwdWxhdGlvbiBmdW5j
dGlvbmFsaXR5LiBJbiB0aGUgcGFzdCwgb3VyIHN0YW5jZSBoYXMgZ2VuZXJhbGx5DQo+IGJlZW4g
IlVzZSBRRU1VIHdpdGhvdXQgYW4gYWNjZWxlcmF0b3IsIGFuZCB1c2UgUU1QIHRvIG1hbmlwdWxh
dGUgdGhlDQo+IGltYWdlcy4iDQo+IA0KPiBXZSBsaWtlIHRoaXMgZm9yIGEgZmV3IHJlYXNvbnM6
DQo+IA0KPiAxLiBJdCBrZWVwcyBiaXRtYXAgbWFuYWdlbWVudCBjb2RlIHRpZ2h0bHkgY2VudHJh
bGl6ZWQNCj4gMi4gSXQgYWxsb3dzIGZvciB0aGUgZnVsbCBzdWl0ZSBvZiBiaXRtYXAgbWFuaXB1
bGF0aW9ucyBpbiBlaXRoZXINCj4gb2ZmbGluZSBvciBvbmxpbmUgbW9kZSB3aXRoIG9uZSB0b29s
DQo+IDMuIFdlIHdvdWxkbid0IGhhdmUgdG8gd3JpdGUgbmV3IGNvZGUuDQo+IDQuIE9yIGRlc2ln
biBuZXcgQ0xJcyBhbmQgZHVwbGljYXRlIG91ciBleGlzdGluZyB3b3JrLg0KPiA1LiBPciB3cml0
ZSBldmVuIG1vcmUgdGVzdHMuDQo+IA0KPiBIb3dldmVyLCB0b29scyBsaWtlIG9WaXJ0IG1heSBv
ciBtYXkgbm90IGJlIGZ1bGx5IGVxdWlwcGVkIHRvIGxhdW5jaA0KPiBRRU1VIGluIHRoaXMgY29u
dGV4dCwgYW5kIHRoZXJlIGlzIGFsd2F5cyBhIGRlc2lyZSBmb3IgcWVtdS1pbWcgdG8gYmUNCj4g
YWJsZSB0byAiZG8gbW9yZSIsIHNvIGV4aXN0aW5nIG1hbmFnZW1lbnQgc3VpdGVzIGNvdWxkIGV4
dGVuZA0KPiBmdW5jdGlvbmFsaXR5IG1vcmUgZWFzaWx5Lg0KDQpJIHRoaW5rLCBhbGwgZ3V5cywg
d2hvIGRvbid0IHdhbnQgdG8gdXNlIFFlbXUgZGlyZWN0bHkgZm9yIGltYWdlIG1hbmlwdWxhdGlv
bnMsDQpzaG91bGQgaG9wZSBmb3IgS2V2aW4ncyAiW1JGQyBQQVRDSCAwMC8xOF0gQWRkIHFlbXUt
c3RvcmFnZS1kYWVtb24iLCB3aGljaCBpcw0KdGhlIGNvcnJlY3Qgc29sdXRpb24gb2YgdGhlaXIg
cHJvYmxlbS4gU3RpbGwsIEknbSBub3Qgb25lIG9mIHRoZXNlIGd1eXMuDQoNCj4gDQo+IChPciBz
byBJIGFtIGltYWdpbmluZy4pDQo+IA0KPiBJIGFtIHN0aWxsIGxlYW5pbmcgaGVhdmlseSBhZ2Fp
bnN0IGFkZGluZyBhbnkgbW9yZSBDTEkgY29tbWFuZHMgb3INCj4gb3B0aW9ucyB0byBxZW11LWlt
ZyByaWdodCBub3cuIEV2ZW4gaWYgd2UgZG8gYWRkIHNvbWUgb2YgdGhlIGZ1bmRhbWVudGFsDQo+
IG9uZXMgbGlrZSAiYWRkIiBvciAicmVtb3ZlIiwgaXQgc2VlbXMgb25seSBhIG1hdHRlciBvZiB0
aW1lIGJlZm9yZSB3ZQ0KPiBoYXZlIHRvIGFkZCAiY2xlYXIiLCAibWVyZ2UiLCBldGMuIElzIHRo
aXMganVzdCBhIHJhY2UgdG8gY29kZSBkdXBsaWNhdGlvbj8NCj4gDQo+IE9uIHRoZSBvdGhlciBo
YW5kLCBvbmUgb2YgdGhlIG90aGVyIHN1Z2dlc3Rpb25zIGlzIHRvIGhhdmUgcWVtdS1pbWcNCj4g
Y2hlY2sgLS1yZXBhaXIgb3B0aW9uYWxseSBkZWxldGUgY29ycnVwdGVkIGJpdG1hcHMuIEkga2lu
ZCBvZiBsaWtlIHRoaXMNCj4gaWRlYTogaXQncyBhIGJ1eWVyIGJld2FyZSBvcGVyYXRpb24gdGhh
dCBtaWdodCBtYWtlIG1hbmFnZW1lbnQgbGF5ZXJzDQo+IHVuaGFwcHksIGJ1dCB0aGVuIGFnYWlu
IC4uLiByZXBhaXIgaXMgYWx3YXlzIHNvbWV0aGluZyB0aGF0IGNvdWxkIG1ha2UNCj4gdGhpbmdz
IHdvcnNlLg0KPiANCj4gUGx1cywgaWYgeW91IG1hbmFnZSB0byBjb3JydXB0IGJpdG1hcHMgYmFk
bHkgZW5vdWdoIHRoYXQgdGhleSBjYW4ndCBldmVuDQo+IGJlIHBhcnNlZCwgeW91IG1pZ2h0IG5l
ZWQgYSBoZWF2eXdlaWdodCByZXBhaXIgb3BlcmF0aW9uLg0KPiANCg0KSW1wcm92aW5nICJjaGVj
ayIgaXMgYSBjb3JyZWN0IHRoaW5nLCBiZWNhdXNlIGl0J3MgZG9uZSBpbnNpZGUgcWNvdzIgZHJp
dmVyDQppdHNlbGYuIFdlIGp1c3QgZG9uJ3QgaGF2ZSBjb3JyZXNwb25kaW5nIHFtcCBjb21tYW5k
IG9yIGNvbW1hbmQgbGluZSBvcHRpb24NCmZvciBRZW11IHRvIHVzZSB0aGlzIHRoaW5nIChvciBJ
IG1pc3NlZCBpdCkuDQoNCj4gTmlyLCBkbyB5b3UgdGhpbmsgdGhhdCdkIGJlIHN1ZmZpY2llbnQg
Zm9yIHlvdXIgbmVlZHMgZm9yIG5vdywgb3Igd291bGQNCj4geW91IHN0aWxsIGxpa2UgdG8gc2Vl
IG1vcmUgZ3JhbnVsYXIgb2ZmbGluZSBtYW5hZ2VtZW50Pw0KPiANCj4gLS1qcw0KPiANCg0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

