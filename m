Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CA5CA9EBC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 10:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621F3208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 10:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="skBZ4C+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621F3208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP26o-0006i0-Ek
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 06:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP25n-00064D-Ns
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP25m-0001Mj-FH
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:17:43 -0400
Received: from mail-eopbgr130102.outbound.protection.outlook.com
 ([40.107.13.102]:33393 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iP25f-0001BN-F9; Mon, 28 Oct 2019 06:17:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/Y7+0T5KK9x8DKv8mKWPu5yaF7mq1gbD5mxl/owdEEmTNP/mLvSv9O/MeYDEUC7mcu5AQyWV7XG0Bnzlu038C9URdFeJnhZ+PMXWy1V6IwR9CH+Rk54MfS4ZX9Krqb4P5/w4Y9QTdq6as0sdQGiOzpRV0OgGt0SPlaxSmzaZaAKQT4P7y7iAzYPqBDQPK3VxbLKl8sUJ8/tZWd+Y58Q8Z4VRSFeBfRwht/22iKGYeWy1kEGiYOlbjjk/8yTfmAS2hGRErh7tBIdQoAvKXx51mRpOEza4jC++KFnGViuiysspf8Bq2B8skTAmfKZDG96bZ8ad4DuMG3q1p/EBreXdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXsonlv25hU8LfOOITlXNVi6IIXlin2CCDiX0yYlVIo=;
 b=e8pS1RDSciJ9AUuRfBDROMRziXmL7uYLAjgv86zUI80tIoVq+9TKTECynWDY5xxsh4nmSF3WYgIg5OIV8//8+QGX/HAyWn6A8l09A+YB8R1/BMFqJU0Ht2k7t5LvABP9hOJzw0mqSDLbOZ4bcjb68TNKFMVRE+BuTzJiqNF8baIaBf4940QJp2U5cI/9hA8jXgz+U5dU2ekZZqQuRdQk89HVJkXNNmjAxcFX9PmSeFsolxEFSSR/h1FPQhabw4NkRpejr5rRCRyUHj+HbKrMhQhmKCuM+MM+JnSlRT16r3bb3yYaKrtaIcgG7MVP/CAHKsd0lZZATMa/z5OSr0CW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXsonlv25hU8LfOOITlXNVi6IIXlin2CCDiX0yYlVIo=;
 b=skBZ4C+lwY0uJIygqAwlHnSuZMH77SlFDGoFydWWLDdkEBUyETzIfqsTva1R1i9WyocNFevGo2/I1GQFwwZGnSyMiOUMWfrsvtNFzu7zF6RuGGZjL0fvJrGOOw3OtvJEmbmIbuSMidI6CRtqT/KymbQO1KczGMYAGE5BvfogH9k=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3091.eurprd08.prod.outlook.com (52.134.95.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Mon, 28 Oct 2019 10:17:27 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 10:17:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH] iotests: Test nbd client reconnect
Thread-Topic: [PATCH] iotests: Test nbd client reconnect
Thread-Index: AQHVjNWtN0zAChVWmUuOhdT9OKo1xadvsIUAgAAnlwA=
Date: Mon, 28 Oct 2019 10:17:27 +0000
Message-ID: <bd964acf-63a1-daba-904d-2a74e3b3a781@virtuozzo.com>
References: <1572187725-685325-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <8acd5c43-adcb-eff5-aa87-030d57216a5e@redhat.com>
In-Reply-To: <8acd5c43-adcb-eff5-aa87-030d57216a5e@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0143.eurprd05.prod.outlook.com
 (2603:10a6:7:28::30) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191028131724942
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba6f3994-43de-4ab6-9151-08d75b900891
x-ms-traffictypediagnostic: AM0PR08MB3091:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3091786B98DB8525E3D92796C1660@AM0PR08MB3091.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(39840400004)(136003)(366004)(396003)(189003)(199004)(51444003)(6436002)(4326008)(25786009)(3846002)(6116002)(81166006)(8936002)(7736002)(81156014)(2201001)(305945005)(186003)(76176011)(99286004)(86362001)(31696002)(8676002)(52116002)(26005)(102836004)(66476007)(446003)(66556008)(11346002)(64756008)(14454004)(5660300002)(2906002)(6506007)(66946007)(66446008)(386003)(54906003)(110136005)(53546011)(66066001)(229853002)(478600001)(71190400001)(2501003)(71200400001)(36756003)(107886003)(256004)(6246003)(14444005)(2616005)(476003)(316002)(486006)(31686004)(6512007)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3091;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SnbolKYCcprWcK8DGOIc+w/hKBRZRh+btXdQMkFkFGGwyqVZ280YLSUm90ocrhbF3/IgW7+advvEyvkI41+Q5zOFf/c7+iPM7bmCI4Yh0/ePQ0Wtw8B6VaNgJ47YkqcOJG6TaTIwC+PhrQvaG1PsanDYujjdSHfJURRZCIGPnXHNOtsr0F01bCoMJa61hzz0YpPXRsh8svrt6fthD6CadG59fHvsbYnq948gVL795t1STCdaWQTr99g+a/eG0CfMLJqlj09cMtmBzlts3iNl6rZbu2aTjyPIw0NivcuhT6kBiJTRtICh/fkkhyrZTwFaX2h2ewuET73hbOnZSbz/0DNsMLbpJ4gfQifjCEHROMxCfFMAwZv9qNih2bPrn1GgAgK9Ro8lASNLt3HbDmUHIzKcWlUpNV7/nNcgY7lh/AwG+d9VBCZWBzihP7r0dDAA
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C427E56DDED254792951E2CA25176D0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6f3994-43de-4ab6-9151-08d75b900891
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 10:17:27.4769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dvmvFry+KURKee9Ibqj7HrOgPHp9xS2B5u4YNPuFY4ceN5xDlTTotJ5zsjgZU19PwdOSYRGq0AfJVtn/HFp1nUGRgcsenDCFIt9gp5X2RJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3091
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.102
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
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMTAuMjAxOSAxMDo1NSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMjcvMTkgMzo0OCBQ
TSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+PiBUaGUgc3RyZXNzIHRlc3QgZm9yIGFuIE5C
RCBjbGllbnQuIFRoZSBOQkQgc2VydmVyIGlzIGRpc2Nvbm5lY3RlZCBhZnRlcg0KPj4gYSBjbGll
bnQgd3JpdGUgb3BlcmF0aW9uLiBUaGUgTkJEIGNsaWVudCBzaG91bGQgcmVjb25uZWN0IGFuZCBy
ZXRyeSB0aGUNCj4+IG9wZXJhdGlvbi4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IERlbmlzIFYuIEx1
bmV2IDxkZW5Ab3BlbnZ6Lm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNo
IDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiDCoCB0ZXN0cy9x
ZW11LWlvdGVzdHMvMjc3wqDCoMKgwqAgfCA5MSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+PiDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvMjc3Lm91dCB8wqAg
NyArKysrDQo+PiDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXDCoMKgIHzCoCAxICsNCj4+IMKg
IDMgZmlsZXMgY2hhbmdlZCwgOTkgaW5zZXJ0aW9ucygrKQ0KPj4gwqAgY3JlYXRlIG1vZGUgMTAw
NzU1IHRlc3RzL3FlbXUtaW90ZXN0cy8yNzcNCj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy9xZW11LWlvdGVzdHMvMjc3Lm91dA0KPiANCj4gSG93IGRvZXMgdGhpcyBkaWZmZXIgZnJvbSAy
NjQ/wqAgSWYgaXQgYWRkcyBhbnl0aGluZyBuZXcsIGNhbiBpdCBiZSBtZXJnZWQgaW50byB0aGUg
ZXhpc3RpbmcgdGVzdD8NCj4gDQoNCjI2NCBpcyBiYWNrdXAgb3ZlciBOQkQgd2l0aCByZWNvbm5l
Y3QuIEhlcmUgaXMgYW5vdGhlciB0aGluZzogY2hlY2sgdGhhdCB0aGUgb25seSBzbWFsbCByZXF1
ZXN0IHdvcmtzDQp3aXRoIHJlY29ubmVjdCwgaWYgZGlzY29ubmVjdCBvY2N1cnMgZXhhY3RseSBh
ZnRlciByZXF1ZXN0IHdhcyBhY2NlcHRlZCBieSBzZXJ2ZXIgYW5kIGNsaWVudCBrbm93cywNCnRo
YXQgcmVxdWVzdHMgaXMgc3VjY2Vzc2Z1bGx5IGFjY2VwdGVkLiBXZSB3YW50IHRvIGNoZWNrIHRo
YXQgY2xpZW50IHdpbGwgbm90IHdhaXQgcmVwbHkgZm9yZXZlciBidXQNCnJlc2VuZCB0aGUgcmVx
dWVzdCB0byBuZXcgc3RhcnRlZCBOQkQgc2VydmVyLg0KDQpTbywgSSB0aGluaywgdGhleSBhcmUg
ZGlmZmVyZW50IGVub3VnaCB0byBrZWVwIHRoZW0gaW4gc2VwYXJhdGUuIFN0aWxsLCBpZiB3ZSB3
YW50IHRvIG1lcmdlIHRoZW0sIGl0DQptZWFucyB0aGF0IHdlIHNob3VsZCByZXdyaXRlIHRoZW0g
aW4gdW5pdHRlc3Qgc3R5bGUsIHdpdGggdGVzdC1jYXNlcywgYXMgSSB0aGluayB0aGF0IGh1Z2Ug
dGV4dC1jYW1wYXJpbmcNCnRlc3RzIHdpdGggc2V2ZXJhbCB0ZXN0IGNhc2VzIGFyZSBiYWQgdGhp
bmcsIEknbGwgd3JpdGUgYSBzZXBhcmF0ZSBsZXR0ZXIgYWJvdXQgaXQgdG8gZGlzY3VzcyBhIGJp
dCBsYXRlci4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

