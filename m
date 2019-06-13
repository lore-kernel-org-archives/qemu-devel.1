Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F236C31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3085720679
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="InZOxQ6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3085720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41254 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbSGo-000161-6B
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55637)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbRXJ-0004mD-Tj
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbRXI-0005lP-TL
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:21:09 -0400
Received: from mail-am5eur03on071d.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::71d]:15499
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbRXB-0005fH-51; Thu, 13 Jun 2019 11:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP6wFMhv4fXPyDyiXNQb2rab42BIxdJjmbpeZhNRFs4=;
 b=InZOxQ6b0Azfnx2UYZAvaiWv47LcpDCfM2sCGOPRrLJG40XCsibdhRr0tKXGUFDmoHG//061luCnW+BvfS8D981IVeHux3C3etm34RZX8+8/p7YKR03ffonbPkSZCYWfZlfX/fUUfUQ0LT8rxOQpXt87OCCVblDadTHDhiOrWes=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3075.eurprd08.prod.outlook.com (52.134.92.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Thu, 13 Jun 2019 15:20:56 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 15:20:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH 3/3] block/nbd: merge NBDClientSession struct back to
 BDRVNBDState
Thread-Index: AQHVIEBH0xMITr3E4EW/fglja6E9zKaZtZIAgAABHAA=
Date: Thu, 13 Jun 2019 15:20:56 +0000
Message-ID: <35dcdb7a-8a3d-81eb-76e9-e8dff544f726@virtuozzo.com>
References: <20190611102720.86114-1-vsementsov@virtuozzo.com>
 <20190611102720.86114-4-vsementsov@virtuozzo.com>
 <c03ff39b-5e8f-ed0a-d33c-2d2d4919cd33@redhat.com>
In-Reply-To: <c03ff39b-5e8f-ed0a-d33c-2d2d4919cd33@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0001.eurprd03.prod.outlook.com
 (2603:10a6:3:76::11) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613182054105
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c681d645-66cc-43ac-2061-08d6f012bb3d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3075; 
x-ms-traffictypediagnostic: AM0PR08MB3075:
x-microsoft-antispam-prvs: <AM0PR08MB3075BA80662D1D5C5754DC9EC1EF0@AM0PR08MB3075.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(346002)(366004)(39850400004)(136003)(199004)(189003)(66066001)(6512007)(73956011)(11346002)(36756003)(3846002)(4744005)(2501003)(8676002)(6436002)(2201001)(66556008)(86362001)(5660300002)(71200400001)(6116002)(53936002)(66476007)(2616005)(66946007)(486006)(64756008)(446003)(229853002)(66446008)(186003)(31696002)(102836004)(31686004)(81166006)(8936002)(316002)(6246003)(71190400001)(76176011)(52116002)(256004)(6486002)(110136005)(26005)(2906002)(68736007)(14454004)(305945005)(7736002)(53546011)(476003)(81156014)(25786009)(4326008)(6506007)(54906003)(99286004)(478600001)(386003)(156123004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3075;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AoVR654+iSikrI0JgT5Qe4bN2Yte/5ePmpNiVFtSyPtarkRqJIOafKjx59jinaLsEZQCSUHOYUkN3bKfR5LkrLdORaXhltctoDWxydKf5pyjMSwHOG4muQz/WsIbsZ5C1g9qnH6+c1geRvSWjojez99vLBW3PdwBWSyB5INWqsEY+Zw4+Y//MoClNfWpbCc8c7jEt6sQSnOWfCysFfD6wbcbYQP6CbrdUGdzuCnE/2me/68W8HgjvPpR/HJc0oK9niKe4Cy2k/wLS5C17IGfGIWJuVnuRFsbF/7eQC8PNKcBxt4ScrSm8dT7KiDMGKYUNjgxZUzpZpCeoCtFTWBTdORz6DJYCReQmD8z+mbQPThfjo73F7Y28uqiWU6a3REgkogPlrBKqcFhqhlc9p5j0PFOiv9mAzIp7xOylIDa+9Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79370876C7780446A249BCABD9B1C3D1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c681d645-66cc-43ac-2061-08d6f012bb3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 15:20:56.3405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3075
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::71d
Subject: Re: [Qemu-devel] [PATCH 3/3] block/nbd: merge NBDClientSession
 struct back to BDRVNBDState
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
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDYuMjAxOSAxODoxNiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gNi8xMS8xOSA1OjI3IEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gTm8gcmVhc29uIHRvIGtl
ZXAgaXQgc2VwYXJhdGUsIGl0IGRpZmZlcnMgZnJvbSBvdGhlcnMgYmxvY2sgZHJpdmVyDQo+PiBi
ZWhhdmlvciBhbmQgdGhlcmVmb3IgY29uZnVzZXMuIEluc3RlYWQgb2YgZ2VuZXJpYw0KPiANCj4g
cy90aGVyZWZvci90aGVyZWZvcmUvIChib3RoIHNwZWxsaW5ncyBhcmUgdmFsaWQsIGJ1dCB0aGUg
Zm9ybWVyIGxvb2tzDQo+IGFyY2hhaWMpDQoNCkludGVyZXN0aW5nLCBmb3IgbWUgaXQgd2FzIGp1
c3QgYSBtaXN0YWtlLg0KDQo+IA0KPj4gICAgJ3N0YXRlID0gKFN0YXRlKilicy0+b3BhcXVlJyB3
ZSBoYXZlIHRvIHVzZSBzcGVjaWFsIGhlbHBlci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFk
aW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAt
LS0NCj4+ICAgYmxvY2svbmJkLmMgfCAxOTcgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgOTQgaW5zZXJ0aW9u
cygrKSwgMTAzIGRlbGV0aW9ucygtKQ0KPj4NCj4gDQo+IFJldmlld2VkLWJ5OiBFcmljIEJsYWtl
IDxlYmxha2VAcmVkaGF0LmNvbT4NCj4gDQo+IEknbSBxdWV1aW5nIHRoaXMgc2VyaWVzIHRocm91
Z2ggbXkgTkJEIHRyZWUuDQo+IA0KDQpUaGFua3MhISBJJ2xsIHJlYmFzZSByZWNvbm5lY3Qgc2Vy
aWVzIG9uIHRoaXMuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

