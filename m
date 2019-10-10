Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B147C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 883E42067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QAc4wnuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883E42067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIbEj-0003ap-CU
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1iIb6G-00037b-Po
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1iIb6F-0000Z6-7h
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:15:36 -0400
Received: from mail-eopbgr10103.outbound.protection.outlook.com
 ([40.107.1.103]:11597 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1iIb6E-0000YC-J7; Thu, 10 Oct 2019 12:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgbBNFv5XVAODVkYNoJaWMSjH4j5Yq0ZUaunspEmmVLd6+T49165oNzd4syXvXzVV/Rt5Ip3PNfia3vn2KMwomu7nDFQhjxm2tx3+/LA/Wfs6qs33J0bIFnHsoMvV2k8YQCPvJRA4Tg8Q2fOV9q25E/JA+TlETg00s4lWv8ere2zqb63TXBeAhm9CEwq7+Ze3McGP1AW3jfdSrgIGtFsv2b3lJ2P+Cfta0xlSCr1wQqsoc02D2VasjFhAJRP5/q3qfLvu4dTZRdT3lopQBDJx6YYckq+Ju4TAml26ww/FksNpJ/VCKJQiHGXEpPsU0uGyd9YSxxNjX4Zq3uunTToBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23YuJV50e4hWZJeb1NunsQy6uXZTCZ5CcVnrpqh3hn0=;
 b=LCow0EbWuUYQbX7B1yiv2/7vj7Kf2WJl6MqOSyHxdB11exzj8ORNaGdR9ic4h9ifT646oybMFEqvGUCV/OSeYuTRohJuyV9hQXUlgcPKQpy7byTa23VP3cBAt+x/7sYAt0Of2mljVmJzs/9nrEQrKXeo1pMNVfCX8UMBToSKfsig6V20cPJoWjO472MLaISCkKwh8sE3yvBlCkJMH0Nd0A+ZzVVUjGyo91yYBoA1SBYTNsqum+YoUdtcnDyd0Z2YEaPs70E3QS1a0wXKxG7M9Mhot335YSyDTp3m9Xti6HEt3gBn3Ls5xFGC/E1hsDqjA8SRQJr+hLo15LcdJ3BzGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23YuJV50e4hWZJeb1NunsQy6uXZTCZ5CcVnrpqh3hn0=;
 b=QAc4wnuDXyMXaqX5hQWitRyWTD1V85Mu112ZrGGP8XgPTlVC3cdp+W0m4xag8nl2z6ZueIoFwYZs/l8Wo/okppMP7TeSm87iwpMwsMRnG5Ch7pY+doVsE0ucse1DyC578IUJYA9C5h5PCTC70iuafuRc4zrw6XrrBdKeagWv2J8=
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com (10.255.122.155) by
 AM6PR08MB3253.eurprd08.prod.outlook.com (52.135.165.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 10 Oct 2019 16:15:31 +0000
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::19b8:b45c:1819:90f7]) by AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::19b8:b45c:1819:90f7%6]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 16:15:31 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Subject: Re: Problems with c8bb23cbdbe3 on ppc64le
Thread-Topic: Problems with c8bb23cbdbe3 on ppc64le
Thread-Index: AQHVf33nDBVjqwlk50WvNSfhpH2KP6dUDOAA
Date: Thu, 10 Oct 2019 16:15:31 +0000
Message-ID: <5ba5d289-4450-135c-f058-a7e498725058@virtuozzo.com>
References: <2e7d321c-89f4-f3fd-8331-6bc276880de2@redhat.com>
In-Reply-To: <2e7d321c-89f4-f3fd-8331-6bc276880de2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::31) To AM6PR08MB5208.eurprd08.prod.outlook.com
 (2603:10a6:20b:eb::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2c6736a-1c6f-4f28-9394-08d74d9d1279
x-ms-traffictypediagnostic: AM6PR08MB3253:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3253C87F7321C0903F041589F8940@AM6PR08MB3253.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(376002)(39840400004)(396003)(366004)(346002)(136003)(53754006)(189003)(199004)(6116002)(31686004)(25786009)(446003)(36756003)(186003)(11346002)(6246003)(76176011)(4326008)(81166006)(52116002)(81156014)(2616005)(476003)(53546011)(6506007)(486006)(44832011)(386003)(102836004)(229853002)(14444005)(256004)(316002)(3846002)(26005)(14454004)(6436002)(8676002)(2906002)(6486002)(5660300002)(66066001)(31696002)(305945005)(66556008)(64756008)(66446008)(66946007)(66476007)(54906003)(6512007)(7736002)(8936002)(71200400001)(6306002)(478600001)(71190400001)(110136005)(86362001)(99286004)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3253;
 H:AM6PR08MB5208.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8x51ndKnOV8kRlkgoHzfXvTrkFGpQsPDFZQxdP1aw+NrJr5lKlYv9KY83EEVKCeEHxdyOhjQ++YQS9lxhO6ZeN95ZWpJ5NTPE6JrsN1f0iQbjS3XsAZ7fttKxhXZNLE0vEAiKk0J49IaeVFlfQmHXkqnShqPNNic3JJiHYfuimGSBKqMo3SA+cqT/mKSQ1W25SKSMT4F4vcZHSFMUdX9sn7oB9hDe/4N7f3LXnk6Eg3ubOLLKmRBFLcOW/AzhSZV5G82lNkZ9pq1TK1V9GoQdYRPrsv6+6QMoXbcc0mSa7wHTGpd89KjpR2aB0QM5+tTqaHEr4gkKS5mvTlvcoCoG25xA2wUo845BIK/FrbwibfWVAhy4TwEKTsnUr24RYJmfH3vmwvBdo+/nkXsjxR8ZQKoREzIQYz6sM/5QG40y+HdeP2Cw/j7rkqArWdoMAmc8SUKlfKL4n0mCE/jyyuxTg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD402F1862A5874186EE3897F89C3330@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c6736a-1c6f-4f28-9394-08d74d9d1279
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 16:15:31.3415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLr7quVNQpGjJLag38+v/fwTvkB7xFByuzvRXLAEkvWObe9h3qCSiNt1IKTKcZcmXjbxRCJGWxRktjgZ10OGsxlVVwILAQnbK8GHaPaCEgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.103
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTAvMTAvMjAxOSA2OjE3IFBNLCBNYXggUmVpdHogd3JvdGU6DQo+IEhpIGV2ZXJ5b25lLA0K
PiANCj4gKENDcyBqdXN0IGJhc2VkIG9uIHRhZ3MgaW4gdGhlIGNvbW1pdCBpbiBxdWVzdGlvbikN
Cj4gDQo+IEkgaGF2ZSB0d28gYnVnIHJlcG9ydHMgd2hpY2ggY2xhaW0gcHJvYmxlbXMgb2YgcWNv
dzIgb24gWEZTIG9uIHBwYzY0bGUNCj4gbWFjaGluZXMgc2luY2UgcWVtdSA0LjEuMC4gIE9uZSBv
ZiB0aG9zZSBpcyBhYm91dCBiYWQgcGVyZm9ybWFuY2UNCj4gKHNvcnJ5LCBpcyBpc27igJl0IHB1
YmxpYyA6LS8pLCB0aGUgb3RoZXIgYWJvdXQgZGF0YSBjb3JydXB0aW9uDQo+IChodHRwczovL2J1
Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE3NTE5MzQpLg0KPiANCj4gSXQgbG9v
a3MgbGlrZSBpbiBib3RoIGNhc2VzIHJldmVydGluZyBjOGJiMjNjYmRiZTMgc29sdmVzIHRoZSBw
cm9ibGVtDQo+ICh3aGljaCBvcHRpbWl6ZWQgQ09XIG9mIHVuYWxsb2NhdGVkIGFyZWFzKS4NCj4g
DQo+IEkgdGhpbmsgSeKAmXZlIGxvb2tlZCBhdCBldmVyeSBhbmdsZSBidXQgY2Fu4oCYdCBmaW5k
IHdoYXQgY291bGQgYmUgd3JvbmcNCj4gd2l0aCBpdC4gIERvIGFueSBvZiB5b3UgaGF2ZSBhbnkg
aWRlYT8gOi0vDQo+IA0KDQpoaSwNCg0Kb2gsIHRoYXQgcGF0Y2ggc3RyaWtlcyBhZ2Fpbi4uDQoN
CkkgZG9uJ3QgcXVpdGUgZm9sbG93LCB3YXMgdGhpcyBidWcgY29uZmlybWVkIHRvIGhhcHBlbiBv
biB4ODY/IENvbW1lbnQgOA0KKGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5j
Z2k/aWQ9MTc1MTkzNCNjOCkgbWVudGlvbmVkIHRoYXQNCihvciB3YXMgdGhhdCBtaXhlZCB1cCB3
aXRoIHRoZSBvbGQgeGZzY3RsIGJ1Zz8pDQoNClJlZ2FyZGxlc3Mgb2YgdGhlIHBsYXRmb3JtLCBk
b2VzIGl0IHJlcHJvZHVjZT8gVGhhdCdzIGNvbWZvcnRpbmcNCmFscmVhZHk7IHdvcnN0IGNhc2Ug
d2UgY2FuIHRyYWNlIGVhY2ggYW5kIGV2ZXJ5IHJlcXVlc3QgdGhlbiAodW5sZXNzIGl0DQp3aWxs
IHN0b3AgdG8gcmVwcm9kdWNlIHRoaXMgd2F5KS4NCg0KQWxzbywgcGVyaGFwcyBpdCdzIHdvcnRo
IHRvIHRyeSB0byByZXBsYWNlIGZhbGxvY2F0ZSB3aXRoIHdyaXRlKDApPw0KRWl0aGVyIGluIHFj
b3cyIChpbiB0aGUgcGF0Y2gsIGJkcnZfY29fcHdyaXRlX3plcm9lcyAtPiBiZHJ2X2NvX3B3cml0
ZXYpDQpvciBpbiB0aGUgZmlsZSBkcml2ZXIuIEl0IG1pZ2h0IGhpbnQgd2hldGhlciBpdCdzIG1p
c2JlaGF2aW5nIGZhbGxvY2F0ZQ0KKGluIHFlbXUgb3IgaW4ga2VybmVsKSBvciBzb21ldGhpbmcg
ZWxzZS4NCg0KL0FudG9uDQo=

