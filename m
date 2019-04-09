Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ABFC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C604220880
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QmQQ64P1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C604220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37753 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDmb1-0000Vu-2M
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 04:59:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDmZq-0008FX-Ig
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDmZp-0005Ut-Nl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:57:58 -0400
Received: from mail-vi1eur04on072b.outbound.protection.outlook.com
	([2a01:111:f400:fe0e::72b]:32038
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hDmZm-0005T5-Uu; Tue, 09 Apr 2019 04:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=xgal8M9l2IIGgNjB5C7MyWSZFsHMB5kRrPNBFDyX0OA=;
	b=QmQQ64P1v8QrysJkqpG4ktQP6rJM3THCJ5XPeBi6fbERZNiOgXm7ab+nszJe6ig7zMTQZHPqzeYRkTqibSPobdnv2xEEDOfWyNleTGfVFW5pvVcTflI/Al4XUmEv8kP07CvVzUWQFY7GRUmO7M2zTl/YljkzXzax1REBphl1cWA=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3722.eurprd08.prod.outlook.com (20.178.47.221) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.16; Tue, 9 Apr 2019 08:57:51 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Tue, 9 Apr 2019 08:57:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 1/3] block: include base when checking image chain for
	block allocation
Thread-Index: AQHU7jgLaMkJ3yREgUSKZnS0r5BSCqYziCsA
Date: Tue, 9 Apr 2019 08:57:51 +0000
Message-ID: <1207047a-e028-b9d1-5614-00fb2450336f@virtuozzo.com>
References: <1554747741-918964-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554747741-918964-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1554747741-918964-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0022.eurprd05.prod.outlook.com
	(2603:10a6:3:e3::32) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190409115748744
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44072192-4f2a-4ac2-1aa3-08d6bcc9724b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3722; 
x-ms-traffictypediagnostic: DB7PR08MB3722:
x-microsoft-antispam-prvs: <DB7PR08MB3722C7DB7D1ED3CF506CB3B5C12D0@DB7PR08MB3722.eurprd08.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(136003)(396003)(346002)(39850400004)(376002)(189003)(199004)(54906003)(476003)(11346002)(97736004)(2616005)(25786009)(36756003)(2906002)(486006)(256004)(316002)(81166006)(2201001)(8936002)(26005)(186003)(86362001)(52116002)(446003)(478600001)(110136005)(81156014)(99286004)(71200400001)(4744005)(71190400001)(8676002)(14454004)(102836004)(66066001)(6506007)(386003)(107886003)(6116002)(68736007)(76176011)(3846002)(31686004)(31696002)(6246003)(6486002)(5660300002)(2501003)(4326008)(229853002)(7736002)(305945005)(105586002)(53936002)(106356001)(6436002)(6512007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3722;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KUqE8dEUvJRsmWrZGE3k34bEof2kp9ezB5F0tU+qZeNNTXxN6ImAGHKFDagabZPzJ52kewp4vcTY6RRtXR3wS/hcp4BtQ7ULvqyt88VQra73hVBpQFAGIsuilz37lLPcPVrT9Y2RWim6nw1iQAnw+L3vZlUPaUgSLiFZz2u1KcJSlVEzsThLwLo2gQQDWsXnEw7TMPqj+o3YPgISzqOBhhERVZ+aWzxRSyuRXvKh3Qswq0slT6MQuamcseZmr2QmbRXOvv/kMnWLrH9mrGAs40QyQJ8rGkL6G56I4TODuHiexpoT03CSQ8ClzYYknCPjRmImLOKQBws+47JeDuewl6JW0oQf+q0tRTIneNf0NHkB2nwtD25UTvyX9GfrxHb/pwo1Oi1BCiFZIakdheKuYpbKsEX9aC4c53VPyn1yCWA=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <C5E4E89F51B1494E8E725EDE866D6F00@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44072192-4f2a-4ac2-1aa3-08d6bcc9724b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 08:57:51.5800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3722
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::72b
Subject: Re: [Qemu-devel] [PATCH v4 1/3] block: include base when checking
 image chain for block allocation
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
Message-ID: <20190409085751.OjTTIXoKSo2AusDALjXvCtZK4xWDCAa946-QL0h7zVg@z>

MDguMDQuMjAxOSAyMToyMiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFRoaXMgcGF0Y2gg
aXMgdXNlZCBpbiB0aGUgJ2Jsb2NrL3N0cmVhbTogaW50cm9kdWNlIGEgYm90dG9tIG5vZGUnDQo+
IHRoYXQgaXMgZm9sbG93aW5nLiBJbnN0ZWFkIG9mIHRoZSBiYXNlIG5vZGUsIHRoZSBjYWxsZXIg
bWF5IHBhc3MNCj4gdGhlIG5vZGUgdGhhdCBoYXMgdGhlIGJhc2UgYXMgaXRzIGJhY2tpbmcgaW1h
Z2UgdG8gdGhlIGZ1bmN0aW9uDQo+IGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlKCkgd2l0aCBhIG5l
dyBwYXJhbWV0ZXIgaW5jbHVkZV9iYXNlID0gdHJ1ZQ0KPiBhbmQgZ2V0IHJpZCBvZiB0aGUgZGVw
ZW5kZW5jeSBvbiB0aGUgYmFzZSB0aGF0IG1heSBjaGFuZ2UgZHVyaW5nDQo+IGNvbW1pdC9zdHJl
YW0gcGFyYWxsZWwgam9icy4gTm93LCBpZiB0aGUgc3BlY2lmaWVkIGJhc2UgaXMgbm90DQo+IGZv
dW5kIGluIHRoZSBiYWNraW5nIGltYWdlIGNoYWluLCB0aGUgUUVNVSB3aWxsIGNyYXNoLg0KPiAN
Cj4gU3VnZ2VzdGVkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5PHZzZW1lbnRzb3ZA
dmlydHVvenpvLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2g8YW5kcmV5
LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpWbGFkaW1pcg0K

