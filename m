Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E7FC282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD0F207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dujY9V58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD0F207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haGha-000452-4t
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44614)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1haGeu-0002Al-Sk
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1haGeq-0004Se-Jt
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:32:06 -0400
Received: from mail-eopbgr60129.outbound.protection.outlook.com
 ([40.107.6.129]:32161 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1haGed-0004GC-FA; Mon, 10 Jun 2019 05:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzBFTevCW9fc55IjsnM1LvQ0R1e2FcKunPwS/EwqCQQ=;
 b=dujY9V58nsio6IvKZA6u9jfuYo5hvpXlMl/fdRxyUxd3RGt9vbJb4/3D00PxKNXqNmOJgdOhA0v9mSoXf4Q7ByVV7DhwADARAimf7sYD3vdeZMvPETmmUhN7LXeyDPusMJh/cVbyQuE9fcxSk4GNNwhzFo9tAf9MUH9UGuEaehs=
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com (20.177.61.92) by
 VI1PR08MB2832.eurprd08.prod.outlook.com (10.175.245.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.17; Mon, 10 Jun 2019 09:31:32 +0000
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::3826:4d4e:cf5f:81e5]) by VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::3826:4d4e:cf5f:81e5%7]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 09:31:32 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH 2/7] iotests: amendment for benchmark output
 of 039 061 137
Thread-Index: AQHVHvIveAwor4mXO0SNx+LSQbRsPaaUmtCAgAAF24A=
Date: Mon, 10 Jun 2019 09:31:31 +0000
Message-ID: <0be160ab-8d2a-7aa6-2b1a-f8aa59a08e9c@virtuozzo.com>
References: <1560105348-459129-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560105348-459129-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190610091031.GD7809@redhat.com>
In-Reply-To: <20190610091031.GD7809@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0051.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::19) To VI1PR08MB3677.eurprd08.prod.outlook.com
 (2603:10a6:803:85::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c13fe257-0a22-4984-6685-08d6ed866c28
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB2832; 
x-ms-traffictypediagnostic: VI1PR08MB2832:
x-microsoft-antispam-prvs: <VI1PR08MB28325395C328DED01B0A6709F4130@VI1PR08MB2832.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(366004)(136003)(39840400004)(376002)(346002)(396003)(189003)(199004)(256004)(76176011)(52116002)(4744005)(71190400001)(36756003)(5660300002)(81166006)(81156014)(8676002)(71200400001)(6506007)(53546011)(7736002)(44832011)(107886003)(66066001)(476003)(2616005)(14454004)(8936002)(3846002)(6116002)(305945005)(386003)(486006)(99286004)(478600001)(4326008)(73956011)(6512007)(66446008)(11346002)(6246003)(6436002)(186003)(2906002)(86362001)(446003)(66556008)(64756008)(53936002)(31686004)(66476007)(31696002)(66946007)(6486002)(229853002)(26005)(54906003)(25786009)(6916009)(102836004)(68736007)(316002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2832;
 H:VI1PR08MB3677.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YOn9HAOLwe4lDPYB5oh/o10hLBXbtQzDgCkF3fIvv5CK84ABDsFzcAuBJ7CpK0bdE82KTflbifVOD7oG2QCgmO9bYYJDcszMZp6HDgKAsfU2Oq3g0rJNj6e+oZNdrB6A5X/CTF/3MSVi3ZSBAJlA/x8mto5DpnHv65tiRQtbVYckeY7x5dswRQZMBHRV/tFEN2s2YlP3uL1E1oV/lzr47KdOwQVGzI7hLEyqN7hbac7cN0xAkmgrzimJOPU0dyO9taiiCdqegQh1pryyHJP+RrmFq4JuiG1zhNKfO6rWHPNgf51mMrfEdkxHlfmiSiABEF89lxbM+9J264eI68Awdyebaexm34T8wfAvjwoGrVlbDBwC1VTuktdLzgAAZ9kXSf56ai4dh2fDvq1jtZ8YUZBBrhXmJCKZnJYDFQwB9/U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E18F90957A168448B95D93BE64D0D804@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13fe257-0a22-4984-6685-08d6ed866c28
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 09:31:31.8409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2832
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.129
Subject: Re: [Qemu-devel] [PATCH 2/7] iotests: amendment for benchmark
 output of 039 061 137
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
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDEwLzA2LzIwMTkgMTI6MTAsIERhbmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+IE9u
IFN1biwgSnVuIDA5LCAyMDE5IGF0IDA5OjM1OjQzUE0gKzAzMDAsIEFuZHJleSBTaGlua2V2aWNo
IHdyb3RlOg0KPj4gQWZ0ZXIgaW5jbHVkaW5nIHRoZSBWYWxncmluZCBpbnRvIHRoZSBRRU1VIHBy
b2Nlc3NlcyB3cmFwcGVycyBpbiB0aGUNCj4+IGNvbW1vbi5yYyBzY3JpcHQsIHRoZSBvdXRwdXQg
Zm9yIHRoZSB0ZXN0cyAwMzkgMDYxIDEzNyBoYXMgYmVlbg0KPj4gY2hhbmdlZCBhbmQgaXMgdG8g
YmUgYW1lbmRlZC4NCj4gDQo+IFRoZSBjaGFuZ2UgdG8gY29tbW9uLnJjIHdhcyBkb25lIGluIHRo
ZSBwcmV2aW91cyBwYXRjaCwgc28gdGhpcw0KPiBmaXh1cCBzaG91bGQgYmUgdGhlcmUgdG9vLiBT
ZXBhcmF0aW5nIHRoZSBmaXh1cCB3aWxsIGltcGFjdCBwZW9wbGUNCj4gZG9pbmcgImdpdCBiaXNl
Y3QiIHRvIHRyYWNrIGRvd24gYnVncy4NCj4gDQo+IA0KPiBSZWdhcmRzLA0KPiBEYW5pZWwNCj4g
DQpZZXMsIEkgd2lsbCBpbiB2MiwgdGhhbmsgeW91Lg0KQW5kcmV5DQoNCg0K

