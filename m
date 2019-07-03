Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5FFC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6C021881
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cbBTCMzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6C021881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hijQ2-0008RJ-LA
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49647)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hij6H-00033L-D1
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hij6F-00026w-DF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:31:21 -0400
Received: from mail-eopbgr130103.outbound.protection.outlook.com
 ([40.107.13.103]:64390 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hij66-0001yF-4Z; Wed, 03 Jul 2019 13:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4ibbr2Vk2u5SlHpjw4Q7RvWlA4llkaf1jNSwEeXNe8=;
 b=cbBTCMzMZLCG5ncAxE0VN9VRMB2xnPzuQqDV1hBXN9DJhiWdODKtAr2UtBQwzGB2XIFM32b8dwzb4bOgWVrkA85KxKFdfdyaII5NK/Gyet/XubhwbfuJWx196qzJJJCbGumT7MPOpkoLhwU9MJ44Wr0/wHFNPsSWCqaqgJaQJd0=
Received: from DB7PR08MB3258.eurprd08.prod.outlook.com (52.134.111.155) by
 DB7PR08MB3740.eurprd08.prod.outlook.com (20.178.84.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 17:31:07 +0000
Received: from DB7PR08MB3258.eurprd08.prod.outlook.com
 ([fe80::5d2:b836:e08a:f5cf]) by DB7PR08MB3258.eurprd08.prod.outlook.com
 ([fe80::5d2:b836:e08a:f5cf%3]) with mapi id 15.20.2052.010; Wed, 3 Jul 2019
 17:31:07 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 7/7] iotests: Set read-zeroes on in null block driver
 for Valgrind
Thread-Index: AQHVLbfg6HDDOa716EeGIxU1+RHDY6a5Lr4A
Date: Wed, 3 Jul 2019 17:31:06 +0000
Message-ID: <cad53641-15c6-2ab1-9e22-a2700c640140@virtuozzo.com>
References: <1561729574-530879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1561729574-530879-8-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1561729574-530879-8-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::36) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:20::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0a08f1d-47db-47be-3282-08d6ffdc3af1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB7PR08MB3740; 
x-ms-traffictypediagnostic: DB7PR08MB3740:
x-microsoft-antispam-prvs: <DB7PR08MB3740CA93B2E12033B819D27EF4FB0@DB7PR08MB3740.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(136003)(366004)(346002)(39850400004)(199004)(189003)(31696002)(110136005)(86362001)(316002)(478600001)(2906002)(6246003)(5660300002)(6436002)(229853002)(36756003)(6486002)(6512007)(54906003)(31686004)(66066001)(53936002)(6116002)(3846002)(99286004)(4326008)(76176011)(446003)(11346002)(2501003)(305945005)(25786009)(71190400001)(8936002)(186003)(6506007)(71200400001)(8676002)(256004)(102836004)(66946007)(53546011)(81166006)(81156014)(7736002)(386003)(73956011)(44832011)(66446008)(476003)(486006)(52116002)(64756008)(66556008)(66476007)(68736007)(14454004)(26005)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3740;
 H:DB7PR08MB3258.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MZDV24TsULSxJVOEMSVIAkOgMeek18PXvRPjenf6bB76W99MsLTVLXlyy3JkdkibArGo+TbRmXXPwa1tyag6wAxI9TRWRKqHNqY+UeRI4jXz9Jgba6qzzBjSCA4hkLeuHBD/hKb6yZqLAAnDhCz5v2GHkEfmvMe8q6SLSmHCqwZCVnChjjZAnrepo3TT4WU/FVXBuGJ5orVVppKHp+tZrw6KuihqwnUFXj3tgYHWV6qmNuBF9MfjxodIqMS1y1m1rjvC21PTgvFimbvx19dQwORexUZVCU5gPfsE8/CvgpSF7xwDr3erYVrNVH0Qk5HKSrhXQilv2wAv+szjTvqYF1m17PxBWyi9pzh/S1Q4tRsk5mSixfFcqBiHfeWZVfTFUK7KXGgLMy+bd3NVeFniF/QKqiZlkhi8+MfSz4swBoY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E4A2147178AAD47990C235C7EB0F7DC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a08f1d-47db-47be-3282-08d6ffdc3af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 17:31:06.9265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3740
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.103
Subject: Re: [Qemu-devel] [PATCH v3 7/7] iotests: Set read-zeroes on in null
 block driver for Valgrind
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
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI4LzA2LzIwMTkgMTY6NDYsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPiBUaGUg
VmFsZ3JpbmQgdG9vbCByZXBvcnRzIGFib3V0IHRoZSB1bmluaXRpYWxpc2VkIGJ1ZmZlciAnYnVm
Jw0KPiBpbnN0YW50aWF0ZWQgb24gdGhlIHN0YWNrIG9mIHRoZSBmdW5jdGlvbiBndWVzc19kaXNr
X2xjaHMoKS4NCj4gSXQgaXMgcmV2ZWFsZWQgaW4gdGhlIHRlc3RzIDA1MSwgMTg2LCAyMjcgYW5k
IDI0MC4NCj4gUGFzcyAncmVhZC16ZXJvZXM9b24nIHRvIHRoZSBudWxsIGJsb2NrIGRyaXZlciBp
biB0aGUgbWVudGlvbmVkIHRlc3RzDQo+IHRvIG1ha2UgdGhlbSBkZXRlcm1pbmlzdGljLg0KPiBU
aGUgb3V0cHV0IG9mIHRoZSB0ZXN0cyBhYm92ZSBub3cgaW5jbHVkZXMgdGhlIHBhcmFtZXRlciAn
cmVhZC16ZXJvZXMnLg0KPiBTbywgdGhlIGJlbmNobWFyayBvdXRwdXQgZmlsZXMgYXJlIGJlaW5n
IGNoYW5nZWQgdG9vLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBLZXZpbiBXb2xmIDxrd29sZkByZWRo
YXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5r
ZXZpY2hAdmlydHVvenpvLmNvbT4NCj4gLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzA1MSAg
ICAgICAgfCAgMTAgKy0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzA1MS5wYy5vdXQgfCAgMTAg
Ky0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzE4NiAgICAgICAgfCAgMjAgKysrLS0tDQo+ICAg
dGVzdHMvcWVtdS1pb3Rlc3RzLzE4Ni5vdXQgICAgfCAxNTIgKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzIyNyAgICAgICAg
fCAgIDQgKy0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjI3Lm91dCAgICB8ICAgNCArLQ0KPiAg
IHRlc3RzL3FlbXUtaW90ZXN0cy8yNDAgICAgICAgIHwgICA4ICstLQ0KPiAgIDcgZmlsZXMgY2hh
bmdlZCwgMTA0IGluc2VydGlvbnMoKyksIDEwNCBkZWxldGlvbnMoLSkNCj4gDQoNClRoZSBWYWxn
cmluZCByZWJ1a2VzIHRoZSB1bmluaXRpYWxpemVkIGJ1ZmZlciBpbiB0aGUgZmluZF9pbWFnZV9m
b3JtYXQoKSANCm9mIGJsb2NrLmMgd2hlbiB0ZXN0IDE1NSBydW5zLg0KSSB3b3VsZCBsaWtlIHRv
IG1vZGlmeSB0aGUgcHl0aG9uIGNvZGUgaW4gdGhlIG1lbnRpb25lZCB0ZXN0IGJ5IA0KcmVwbGFj
aW5nIHRoZSBiYWNraW5nIGZpbGUgbmFtZToNCg0KdGFyZ2V0X2JhY2tpbmcgPSAnbnVsbC1jbzov
LycNCg0Kd2l0aA0KDQp0YXJnZXRfYmFja2luZyA9ICdqc29uOnsicmVhZC16ZXJvZXMiOiB0cnVl
LCAiZHJpdmVyIjogIm51bGwtY28ifScNCg0KSXMgdGhhdCB0aGUgcmlnaHQgYW5kIGVsZWdhbnQg
d2F5IHRvIGRvPw0KSWYgc28sIEkgd2lsbCBhZGQgaXQgdG8gdGhlIG5leHQgdmVyc2lvbi4NCg0K
QW5kcmV5DQoNCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gN
Cg==

