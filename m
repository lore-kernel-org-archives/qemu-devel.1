Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80C8C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E93B20880
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UyB/ExAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E93B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37755 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDmbH-0000h1-QH
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 04:59:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDma7-0008TV-GG
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDma6-0005c1-HA
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:58:15 -0400
Received: from mail-eopbgr130110.outbound.protection.outlook.com
	([40.107.13.110]:50086
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hDma4-0005aU-4O; Tue, 09 Apr 2019 04:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Q+oRUnxO9YrUfYB9EMLguKdH9DSDydSSdDrvYyVq6EQ=;
	b=UyB/ExALTodefb0DHRtkWwilt/0ewg9QfHz/0OwqZfAbxRxRRxZRsrfsUuZGjQl9SrIIJ4UWXPGFD5QxXI7qaXBL25ahFY3lX8eGvew290NQSTyFWLr8WBKshuBjfI7bl0vCBr1sXdjH6PHLsnbIcCmMXfG0V3t0MBQDFxxXwkQ=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3291.eurprd08.prod.outlook.com (52.134.111.29) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.15; Tue, 9 Apr 2019 08:58:09 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Tue, 9 Apr 2019 08:58:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 3/3] block/stream: introduce a bottom node
Thread-Index: AQHU7jgLObZ1QwoQV0aKntu9PwsjWqYziEEA
Date: Tue, 9 Apr 2019 08:58:08 +0000
Message-ID: <c977f2bc-914b-e470-5f44-8a72bdb54a41@virtuozzo.com>
References: <1554747741-918964-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554747741-918964-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1554747741-918964-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0001.eurprd05.prod.outlook.com
	(2603:10a6:3:e3::11) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190409115805963
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7a556cf-bb90-46e1-aff4-08d6bcc97c9d
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:DB7PR08MB3291; 
x-ms-traffictypediagnostic: DB7PR08MB3291:
x-microsoft-antispam-prvs: <DB7PR08MB3291A323B71DA5B76AFFEAAEC12D0@DB7PR08MB3291.eurprd08.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39850400004)(136003)(396003)(346002)(376002)(189003)(199004)(86362001)(14454004)(229853002)(6486002)(8936002)(2906002)(54906003)(110136005)(2201001)(305945005)(31696002)(4744005)(6246003)(7736002)(6436002)(36756003)(53936002)(99286004)(476003)(6512007)(11346002)(446003)(107886003)(2616005)(66066001)(486006)(5660300002)(256004)(106356001)(386003)(102836004)(71190400001)(316002)(105586002)(25786009)(4326008)(6116002)(52116002)(186003)(2501003)(81166006)(97736004)(68736007)(3846002)(6506007)(71200400001)(81156014)(31686004)(26005)(478600001)(8676002)(76176011);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3291;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4NTycuIV7lZqcZXrKO/fABppcRMAnPjK7FQZU0yCpaQq5Mp+9Oex3Ws0W7/hcQuYT3se3uJTU9vnoLcqlRlky2gMdFk4r007qFgmfqVEb7DpM6b+jUrs3XQ8LV8+j8xfG+UGfG3BGHUjxMMvPxa6hzl0ikAN5yb3DN3Ka6j8Ey3C/QRspmX1l9qFSel1Ma5CWA6lhZW9b8xUZl8n+Uhclb3tyBl3ZMCXl8hGp72UsBe5wR+Y0554T7N0tPc5R2ECrduGYAouBO2POLgBYuNCyAWjiMpY6W1qPM8/Xg76zWbuGCIX9w0I7BztodnLPqicH7fedEtK8SyTasZ8zqAoKErTlvGTF0jmgUuqNA5XId5pe3qFhZtfMNmZNRlCm9JshXaeyPAF4zP8l+143X0U1tuNOr22e9XgxgI2rGf4hug=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <56706CDD04DE954CB60868E1F773455D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a556cf-bb90-46e1-aff4-08d6bcc97c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 08:58:08.8093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3291
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.110
Subject: Re: [Qemu-devel] [PATCH v4 3/3] block/stream: introduce a bottom
 node
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409085808.7LlIICk3ARb7cIFHwVSG5weM_iMT9Wzudz6tp1XSGwk@z>

MDguMDQuMjAxOSAyMToyMiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFRoZSBib3R0b20g
bm9kZSBpcyB0aGUgaW50ZXJtZWRpYXRlIGJsb2NrIGRldmljZSB0aGF0IGhhcyB0aGUgYmFzZSBh
cyBpdHMNCj4gYmFja2luZyBpbWFnZS4gSXQgaXMgdXNlZCBpbnN0ZWFkIG9mIHRoZSBiYXNlIG5v
ZGUgd2hpbGUgYSBibG9jayBzdHJlYW0NCj4gam9iIGlzIHJ1bm5pbmcgdG8gYXZvaWQgZGVwZW5k
ZW5jeSBvbiB0aGUgYmFzZSB0aGF0IG1heSBjaGFuZ2UgZHVlIHRvIHRoZQ0KPiBwYXJhbGxlbCBq
b2JzLiBUaGUgY2hhbmdlIG1heSB0YWtlIHBsYWNlIGR1ZSB0byBhIGZpbHRlciBub2RlIGFzIHdl
bGwgdGhhdA0KPiBpcyBpbnNlcnRlZCBiZXR3ZWVuIHRoZSBiYXNlIGFuZCB0aGUgaW50ZXJtZWRp
YXRlIGJvdHRvbSBub2RlLiBJdCBvY2N1cnMNCj4gd2hlbiB0aGUgYmFzZSBub2RlIGlzIHRoZSB0
b3Agb25lIGZvciBhbm90aGVyIGNvbW1pdCBvciBzdHJlYW0gam9iLg0KPiBBZnRlciB0aGUgaW50
cm9kdWN0aW9uIG9mIHRoZSBib3R0b20gbm9kZSwgZG9uJ3QgZnJlZXplIGl0cyBiYWNraW5nIGNo
aWxkLA0KPiB0aGF0J3MgdGhlIGJhc2UsIGFueW1vcmUuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXk8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96
em8uY29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNl
bWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

