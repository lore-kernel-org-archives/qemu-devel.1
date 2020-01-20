Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAE4C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872FA20684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="d/sK0jWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872FA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itT5C-00025c-KB
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itT4P-00018S-1J
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itT4L-0002LM-Fu
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:10:04 -0500
Received: from mail-eopbgr150103.outbound.protection.outlook.com
 ([40.107.15.103]:11808 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itT4L-0002Kl-9m; Mon, 20 Jan 2020 04:10:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFTcSlo0RRr0BGoUCFoPt3gi9NZznO1mxrvu8jZkf497ZMk/uFvytQLzEVaLjPuUSqnXoQ05dJjXOpIgKBNV/K7ozxhQRNyx3A5KfllR5WYdgq2uKoP72cZ2hu8mE05GUtYIPgJd4gKSmUrTDAOAH0kIS3MdaiGuCpsHjO5o91iUz7WtslQezKpnARCPZxonJEK9VYQtyvrITGzK2pHNaOdE33qiS0ues5KIEHJPxn6QWtwkZ96I5Qf4+/4Us/Qy9EjH5mYhh8UunKAzUPwSZ4AJHp+UTvAFPhC43DXvER47WcBfoq6wJdfGKH4b6rmpV6P1azWW8BJD8TvQ9m2iNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbLB8jMjuLEcpPba6U30dm+KFl0JEOaqFnCLFj8qpSE=;
 b=lWRxIbsV0H4yy7F3rf8zHDIZpjeoE4kIG1r/+WiFIaSFGvMVGl7oWsfdG/z5b2Zr3bgUk90KdIAAw44cSrJWjkHMo01dgr5uE1ITkiNPtaVNiu/QNDpmP5z48vBVY11CEQLhD4R7u90749FUgJzQjwG/ovLLpbYx1Gc1wQFpiQoqguZOau/vnvhLyullNhkvjz4wmpNZQvk6CBbW/DIbaLn31B3mf4VXPO1Usvof1LQHgA0aZuIb7JaPK1g5B5irUVZQAesQPzd8DN2PvPT0nhlFvdLFvoErtZ0hFmGL52XXxepbXsft7qztA5A0kAJWOQIV0jlxqaT2nzPFIRyhWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbLB8jMjuLEcpPba6U30dm+KFl0JEOaqFnCLFj8qpSE=;
 b=d/sK0jWi7qIpC3rTFieHR3mj3KsHCYHussztpTrRUXk/W2pssbZ5SPPL/tz0+w2ssxgug0P9xzUMMOydfZzhRjCx8UBI0nKivnLf3AjOn/DsZ8Coj5628JLG7K9OBDmWAUGdaoLcAvQUZZwtgX2KGQHoFSUPWLmtikLYT2ZPFOg=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3527.eurprd08.prod.outlook.com (20.177.112.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.25; Mon, 20 Jan 2020 09:09:59 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 09:09:59 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0402CA0036.eurprd04.prod.outlook.com (2603:10a6:7:7c::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 09:09:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 for-5.0 0/7] block-copy improvements: part I
Thread-Topic: [PATCH v2 for-5.0 0/7] block-copy improvements: part I
Thread-Index: AQHVpU23N4tIPiZFCES+LN2VFjOlDKfBSw8AgDJNFwA=
Date: Mon, 20 Jan 2020 09:09:59 +0000
Message-ID: <bee43863-28e9-09c8-8058-2d667f114338@virtuozzo.com>
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <bbfcf774-e763-f7ed-2501-e5fba150cd5e@virtuozzo.com>
In-Reply-To: <bbfcf774-e763-f7ed-2501-e5fba150cd5e@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0036.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::25) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120120954024
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c98d671-6648-45c5-dc49-08d79d88866c
x-ms-traffictypediagnostic: AM6PR08MB3527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3527C2E1B1285FA94A13A01CC1320@AM6PR08MB3527.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(366004)(346002)(376002)(396003)(199004)(189003)(66446008)(66556008)(66476007)(64756008)(956004)(66946007)(107886003)(2906002)(54906003)(6486002)(186003)(71200400001)(16526019)(26005)(86362001)(31696002)(52116002)(2616005)(8936002)(478600001)(8676002)(81156014)(81166006)(4326008)(31686004)(5660300002)(16576012)(36756003)(6916009)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3527;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PljPTQElAMulfmeDjFtHmsiknq9DVpf7P3xtmlTQWLp+OFGkCeyLOd3BjnL9vzjCtgr2fgQiyh8UgrFSAWIv+882c4iOERWl0XmT2N6OKCbaQrJCBSls+LOsEga7dSIxCoIs+GnRcXG4fQDAxQo+kp+CVcTjHpa1ABmiQJua7A41tt4nPdjdPUChCSjaAKuDNluF+8NSeyvUPwuKqS9YwTx4h5N6aTTyhpQ7V8CNJJRTlWTVYQK09jXJqPEYcJWNSnDTqgLge2TeENkYxOBnnickNRrbX35ol3LTyfBsFO3kAGuxhT0pdb8614PfY1CYPUsDbbPh/JBOoSsWyIHWUahX2r+G7Aj/pj5vVmbTAKEokcncyUubjwl5xqeTUsEUkKprQp6KvzSwr0eFeFmkM//6N0P9fr5NimW3fasnMUA9TpUYQF3Zda3WSNc7oxqg
Content-Type: text/plain; charset="utf-8"
Content-ID: <06ADF7F6FC1B56419ECFB97EF2B00F04@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c98d671-6648-45c5-dc49-08d79d88866c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 09:09:59.4767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ses0/jqDWJq9GcPEVM69aL7eQXodM0Z5by923C2dGo0Zxvmcs7iZUwIzYD/ZS/HcCRp82ozCR9/PPmCD45d6f36x/G8CFld9f2WD8bfpDh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3527
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.103
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQoxOS4xMi4yMDE5IDEyOjAxLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBwaW5nLiBTZXJpZXMgYXBwbGllcyBvbiBjdXJyZW50IG1hc3Rlcg0KPiANCj4gMjcu
MTEuMjAxOSAyMTowOCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhp
IGFsbCENCj4+DQo+PiBUaGlzIGlzIGEgZmlyc3QgcGFydCBvZiBteQ0KPj4gwqDCoCBbUkZDIDAw
LzI0XSBiYWNrdXAgcGVyZm9ybWFuY2U6IGJsb2NrX3N0YXR1cyArIGFzeW5jDQo+Pg0KPj4gUGF0
Y2hlcyBhcmUgbW9zdGx5IHNlcGFyYXRlIGJ5IHRoZWlyIGlkZWEsIGJ1dCBzZW5kaW5nIHRoZW0g
YWxsIGluDQo+PiBzZXBhcmF0ZSBpcyBpbmVmZmljaWVudC4NCj4+DQo+PiBWbGFkaW1pciBTZW1l
bnRzb3YtT2dpZXZza2l5ICg3KToNCj4+IMKgwqAgYmxvY2svYmxvY2stY29weTogc3BlY2lhbGNh
c2UgZmlyc3QgY29weV9yYW5nZSByZXF1ZXN0DQo+PiDCoMKgIGJsb2NrL2Jsb2NrLWNvcHk6IHVz
ZSBibG9ja19zdGF0dXMNCj4+IMKgwqAgYmxvY2svYmxvY2stY29weTogZmFjdG9yIG91dCBibG9j
a19jb3B5X2ZpbmRfaW5mbGlnaHRfcmVxDQo+PiDCoMKgIGJsb2NrL2Jsb2NrLWNvcHk6IHJlZmFj
dG9yIGludGVyZmFjZXMgdG8gdXNlIGJ5dGVzIGluc3RlYWQgb2YgZW5kDQo+PiDCoMKgIGJsb2Nr
L2Jsb2NrLWNvcHk6IHJlbmFtZSBzdGFydCB0byBvZmZzZXQgaW4gaW50ZXJmYWNlcw0KPj4gwqDC
oCBibG9jay9ibG9jay1jb3B5OiByZWR1Y2UgaW50ZXJzZWN0aW5nIHJlcXVlc3QgbG9jaw0KPj4g
wqDCoCBibG9jay9ibG9jay1jb3B5OiBoaWRlIHN0cnVjdHVyZSBkZWZpbml0aW9ucw0KPj4NCj4+
IMKgIGluY2x1ZGUvYmxvY2svYmxvY2stY29weS5oIHzCoCA1NyArLS0tLS0NCj4+IMKgIGJsb2Nr
L2JhY2t1cC10b3AuY8KgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNiArLQ0KPj4gwqAgYmxvY2svYmFj
a3VwLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDI3ICstLQ0KPj4gwqAgYmxvY2svYmxv
Y2stY29weS5jwqDCoMKgwqDCoMKgwqDCoCB8IDM3OSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tDQo+PiDCoCBibG9jay90cmFjZS1ldmVudHPCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDEgKw0KPj4gwqAgNSBmaWxlcyBjaGFuZ2VkLCAzMTYgaW5zZXJ0aW9ucygrKSwgMTU0IGRl
bGV0aW9ucygtKQ0KPj4NCj4gDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXIN
Cg==

