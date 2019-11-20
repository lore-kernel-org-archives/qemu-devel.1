Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773E0C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4293D22473
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RYtWiIlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4293D22473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOrn-0002M5-5D
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXOqN-00011c-Em
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXOqK-0002Nc-Pf
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:12:22 -0500
Received: from mail-eopbgr70108.outbound.protection.outlook.com
 ([40.107.7.108]:23878 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXOqK-0002L5-IM
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:12:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0ActY/YxILrhSqEa09Gz05b+Pey9/pZdweS6E/+vcnRPmMV3mB9FhmBhcVwIBgTGx2n0akM5urEQBzVtovOgwaSXlMEjN+d2zVbmLp6zjKEXNvzjd/IU5RQhGTm9gqCwuZURFZTuxOarTd2EhdVgXmYoUjZCDSXdXMnMclDQqgLhnd5LVyKlbG6wiTiMxVs4+2EdYkdTj4rIRaAhh1zkcYwW02A4p463E3QkJNdsxeFO/OmGgUDB5CejknqQp8NIfHyqKWNKX0IfcNTuTN9xnIq3X/LrmmH4ehTqy7Y7WTXuhlOYImaZEsWPD1jf55w7bj/I7pcLfXF2Xrx1t3wrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p4svWRarmcs6eugkJIcCNqQPTxoIl42FLMn0JIDWZE=;
 b=lG4hHNcNvOzlv0bvm5MOlkVVT2INJqtroesN94aBBcX/0Xm9zWnWPVfwZoaJVT5WgDpDAsmxCHWK7j5gVGOTV5cfl3bCsiLlQJ2A8g7Sj7JrsVlBZ159C8bkXPdd7IwCcz43I9u503e3MoPmTDV9XupYfyijCNT1mxQ+TefrkrkgNmNB+Y7J4bzEUdXfzgcdy29sl+Lg50YL5Q6t9Q3vot5uMuPfUyuQBUsA7/NW02Rv3RhWpkp6cYXB8iJknttlMuZuYdFoppxoLXpU4mxpSc57c4i+DBkkLTuRmppvxfxk1/n3xG3E+pNimzAqi66qGTwxW2SL5Tk4+MEdGbbChw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p4svWRarmcs6eugkJIcCNqQPTxoIl42FLMn0JIDWZE=;
 b=RYtWiIltbxztigyAGZ0UrrxQ0jsClndtVFlYf6md3fcyR87+XpmqbHftRUd7vh7Pibk9iSAy6BNdVW8gRx+MwnKfezPzyEXO++ttGdw2HwUU3OLscagQA6RQyaCFpgMRA1eAYhrQ3HbJb7f4yfdoHfjYWT5LuUYYoKlLQwtmb80=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4674.eurprd08.prod.outlook.com (10.255.97.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 12:12:17 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 12:12:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [RFC v5 000/126] error: auto propagated local_err
Thread-Topic: [RFC v5 000/126] error: auto propagated local_err
Thread-Index: AQHVgE3dlsNxBDOk202dFu/C5nZLkaeBkkIAgBJ9GACAAB0bAIAACm2A
Date: Wed, 20 Nov 2019 12:12:17 +0000
Message-ID: <4a75a927-323b-0d33-8236-224fe94cf26e@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <d1756cd0-8ad7-1e6c-b127-59ed24c5e512@virtuozzo.com>
 <538354c8-7ba9-8b1c-476e-5733c418207b@virtuozzo.com>
 <20191120110614.11049f9f@bahia.lan>
In-Reply-To: <20191120110614.11049f9f@bahia.lan>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::19)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120151215544
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02dcaf8f-68b3-472e-4642-08d76db2e303
x-ms-traffictypediagnostic: AM6PR08MB4674:
x-microsoft-antispam-prvs: <AM6PR08MB46746C4A53E1AA1AABE19B5EC14F0@AM6PR08MB4674.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(396003)(366004)(346002)(136003)(51444003)(189003)(199004)(14454004)(66066001)(476003)(229853002)(316002)(99286004)(486006)(11346002)(446003)(2616005)(186003)(26005)(102836004)(31686004)(6246003)(8936002)(31696002)(4326008)(6436002)(6486002)(6506007)(81166006)(81156014)(8676002)(386003)(71190400001)(66556008)(66476007)(36756003)(66946007)(66446008)(64756008)(6512007)(5660300002)(25786009)(256004)(7736002)(478600001)(86362001)(76176011)(2906002)(6916009)(52116002)(3846002)(6116002)(305945005)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4674;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vuOazF+xsyr4Xb2RyYhAAx5nhS/cQkEBiaDxpdKzxJGZGLrrTKx5vmtfdcIcsGX/kEElQDEuNLePPglTM43yzd5zIIuQhS8hz0eI8eJgQo7s7tGcHph/WtSBXWKgOWmocw+sEk4pmdl6862Dj5OEQRC2aRo2xr70sRbDj/R2oGyPwehuKlDINUcgs8bVbIxrfmMeYv8pelJC11c3GhRfWYyQSMIyHogASIhk61zL/n84Jll55pFy6K16wtilS1fYZFw+MD/JEioB6U2UmQIve8rLck+qSeOiUfqDnUMblkOJ+v1/W1MDudArAIdzpDiPiTJ4mnMo50p4QFmfw2Yd9VEPckdJNUEA8qu5H/DltOFiEupCxMycYSRduqQMFobOxOV574mm85eauIE/aNsdKUv2W6L3eIi/7rAHy11Y9luEjRwHEbwmU/UWZF87bFCp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <84B6B32ED1F7D94F8B0A68F8ECB78C9F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dcaf8f-68b3-472e-4642-08d76db2e303
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 12:12:17.8142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q25XVLCyPi0rd4hLL+CeVqYucw8G4xdzRTnHmC3QxkUAeJiD/R2p9RMD96aoEjx7Ob5wNdoivD6gmaVtQMzA2yLmUnzNoeaM8Hx6s5xffwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4674
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.108
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMTEuMjAxOSAxNDozNCwgR3JlZyBLdXJ6IHdyb3RlOg0KPiBPbiBXZWQsIDIwIE5vdiAyMDE5
IDA5OjUwOjU0ICswMDAwDQo+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXk8dnNlbWVudHNv
dkB2aXJ0dW96em8uY29tPiAgd3JvdGU6DQo+IA0KPj4gT2theS4uLg0KPj4NCj4+IEkgdGhpbmsg
dGhhdDoNCj4+DQo+PiAxLiBBIGxvdCBvZiBlZmZvcnRzIChub3Qgb25seSBteSwgSSB0aGluayBy
ZXZpZXdpbmcgaXMgYWxyZWFkeSBleGNlZWRlZCBnZW5lcmF0aW9uIGVmZm9ydHMpDQo+PiAgICAg
YXJlIG1hZGUsIGl0IHdvdWxkIGJlIHNhZCB0byBsb3NlIHRoZW0uDQo+Pg0KPj4gMi4gSXQncyBz
YWZlIGVub3VnaCB0byBhcHBseSBvbmx5IHBhcnQgb2YgZ2VuZXJhdGVkIHBhdGNoZXM6IHdlIGp1
c3QgZml4IGVycm9yX2Fib3J0L2Vycm9yX2ZhdGFsDQo+PiAgICAgaW4gbW9yZSBwb3B1bGFyIHN1
YnN5c3RlbXMsIHdoYXQncyB3cm9uZyB3aXRoIHRoYXQ/IFdoeSBub3QgdG8gY292ZXIgODAlIGNh
c2VzIGJ5IDIwJSBlZmZvcnRzPw0KPj4NCj4+IDMuIEl0J3Mgb2J2aW91c2x5IGltcG9zc2libGUg
dG8gbWVyZ2UgdGhlIHdob2xlIHNlcmllcy4gQSBsb3Qgb2YgdGltZSBwYXNzZWQsIHNlcmllcyBk
aXZlcmdlcy4NCj4+DQo+Pg0KPj4gU28gSSBwcm9wb3NlIHRoZSBmb2xsb3dpbmcgcGxhbjoNCj4+
DQo+PiAxLiBJIHJlc2VuZCBzbWFsbCBzZXBhcmF0ZSBzZXJpZXMgb2YgcHJlcGFyYXRpb24gcGF0
Y2hlcyBwZXIgbWFpbnRhaW5lci4gVGhleSBhcmUgZ29vZCBhbnl3YXkuDQo+Pg0KPj4gMi4gV2Ug
Y29tbWl0IHBhdGNoIHdpdGggbWFjcm8gKGNoYW5naW5nIE1VU1QgdG8gU0hPVUxEIGluIGRvY3Vt
ZW50YXRpb24pIGFuZCBjb2NjaW5lbGxlIHNjcmlwdC4NCj4+ICAgICAgKG9yIHRoYXQgbWF5IGJl
IGNvbWJpbmVkIHdpdGggdGhlIGZpcnN0IHNlcmllcyBmcm9tIFszLl0pDQo+Pg0KPj4gMy4gV2hl
biBvbmUgb2YgcHJlcGFyYXRpb25zIHRha2VuIHRvIG1haW50YWluZXIncyB0cmVlLCBJIHNlbmQg
Z2VuZXJhdGVkIHBhdGNoZXMgZm9yDQo+PiAgICAgIGl0cyBtYWludGFpbmVyLg0KPj4NCj4+DQo+
PiBJZiBubyBvYmplY3Rpb25zIGR1cmluZyBhIHdlZWssIEknbGwgc3RhcnQgdGhhdCBwbGFuLCBo
b3BlIHNvbWVvbmUgd2lsbCBzdXBwb3J0IGl0Lg0KPj4NCj4gSGkgVmxhZGltaXIsDQo+IA0KPiBJ
IHN1cHBvcnQgeW91ciBwbGFuIGFuZCBJIHdpbGwgaGVscCB0aGlzIHRvIGdvIGZvcndhcmQgZm9y
IDlwZnMsIFBvd2VyUEMNCj4gYW5kIFhJVkUuIEknbGwgc3RhcnQgd2l0aCBwdXNoaW5nIHRoZSBw
cmVwYXJhdG9yeSBwYXRjaCBmb3IgOXBmcyB0byBteQ0KPiA5cC1uZXh0IGJyYW5jaCByaWdodCBh
d2F5Lg0KPiANCj4gW1JGQyB2NSAwMDkvMTI2XSA5cGZzOiB3ZWxsIGZvcm0gZXJyb3IgaGludCBo
ZWxwZXJzDQo+IA0KPiBDaGVlcnMsDQoNClRoYW5rIHlvdSBHcmVnIQ0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=

