Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3C2C32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 16:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA67206C1
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 16:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MWt2YB37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA67206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwTsl-00031h-BJ
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 12:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwTrv-0002XU-W4
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 12:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwTrv-00078M-0R
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 12:05:23 -0400
Received: from mail-eopbgr10109.outbound.protection.outlook.com
 ([40.107.1.109]:37915 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwTru-00075E-EB; Sat, 10 Aug 2019 12:05:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYtFl9S6b9aPHETpk/RdMjg5NhRg5QwZELSnMB71KVqbcRu48JTSUbeOGTwcZDJWGQYpyQ6SMSlj6Pzx4fwO3/0lAarNrgIN1yQ6WRyRSVjmRlR4HIz4DJs0iOfncs0nOBoGHdBFxhiZ2fabKOdy4BAoTy93IbPXTbj9pkrZqn3gkqdD1iMTtFVdUPNT2N0IQ9MTW88KhcHxwJxh92qjPBSpRdOrdFKerpfySqpLu4gD5tDDcT5hf7enRMh8N5t2mGHpr7agpxmAVrRcUCAM0M3sUtPeFCJoQRN3F1TLA5/mGqjxvCnzmwxOkbRv43/hJEDiz6JFlCSHkw9iwMcfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVzZLJM0N3/gQyGJwsZJvJO6jVO7ZZ07mOmsB2f0dMg=;
 b=ndulu+7Cjp/h+RLnwh75mx3Xl+dqjqTPUz5LlEPGBoJDKpJrHQKCJCxCdvgmx8OdMH1DpTDoaQbbeeIGkeZgo3cb+rg1GJnSRDJwBjaBMCTL3U+40Ggw4YoeQNQazDzmyq4a8Sa+Fpfw38Fm753CMCcZMVc/gWziN6HTtNmd0VCpflRGuQkvJ5ySJYfYADPD3nQLN/p+OHhiJgiUry9aS7YT2jLEFvCGAkTZkYPMIYYbUVoEeeI1K+MpPobrOdzBLCCnOP+hkXvxyjyrhTTfFuPOuIkgtdPB7ZjosaTCOZ5x3uc4trfuZ8AWdxaFHNKCqPDR65DcP0LzugMQfA4GBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVzZLJM0N3/gQyGJwsZJvJO6jVO7ZZ07mOmsB2f0dMg=;
 b=MWt2YB37ZTuD9akceakNIYcKdIk5QhtHvwTX3BxoQqI0ntnm5r0zbcBxNu3UxwGsRhtEAEOyw6991M2PhkumQujNLplZogPMRvhnkh2Zcl2ozakHq9KiBgG/USTW1binZcG1nfq5NRxCoZKKMHyxXWNfUNprt2GX+Nxv/tNhj1I=
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com (52.132.215.9) by
 AM0PR08MB4308.eurprd08.prod.outlook.com (20.179.33.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Sat, 10 Aug 2019 16:05:18 +0000
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::1d02:1f6:aa28:4aff]) by AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::1d02:1f6:aa28:4aff%3]) with mapi id 15.20.2157.022; Sat, 10 Aug 2019
 16:05:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 15/42] block: Re-evaluate backing file handling in
 reopen
Thread-Index: AQHVTs2Pf4KlP5DWkEaMqlb+GFG9Q6b0jTCA
Date: Sat, 10 Aug 2019 16:05:18 +0000
Message-ID: <3df1dae2-ed11-20e3-7512-34b9d9a06f3b@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-16-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-16-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0153.eurprd06.prod.outlook.com
 (2603:10a6:7:16::40) To AM0PR08MB5491.eurprd08.prod.outlook.com
 (2603:10a6:208:189::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190810190515464
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d1105af-0188-47a1-023f-08d71dac89c7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4308; 
x-ms-traffictypediagnostic: AM0PR08MB4308:
x-microsoft-antispam-prvs: <AM0PR08MB43083285EC87E18CD18847B5C1D10@AM0PR08MB4308.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(366004)(136003)(39840400004)(346002)(199004)(189003)(53936002)(36756003)(54906003)(110136005)(478600001)(2616005)(31696002)(71200400001)(4326008)(476003)(99286004)(71190400001)(66066001)(4744005)(2501003)(6512007)(14454004)(316002)(25786009)(6246003)(5660300002)(64756008)(66446008)(186003)(386003)(305945005)(26005)(66556008)(66476007)(86362001)(81166006)(8676002)(6506007)(11346002)(446003)(102836004)(66946007)(81156014)(7736002)(2906002)(76176011)(486006)(3846002)(6116002)(52116002)(14444005)(6436002)(6486002)(8936002)(31686004)(256004)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4308;
 H:AM0PR08MB5491.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sTO6X8P3ol2SKuR1FXq/BOkUllLEs+iO2jmVhH1eutpZXZdEE3CzUsARH5rCdlKt0ncqH3h92q29nkyrgX6vNK2PyJ/pTIytqm+14Ab9/UhgKj6x2OUcquhTVvhdwNBz8KC4nDD4bYIpTSY2IEnG6uKmXIj9PkK3rKbRpHBpejrrTGzm1+/xTJchn/hw4bXKBf3dTlgoWKr10PF+HHPz55Y4jLWIR4D9H0j7kNAW+YbKFkyPjbtlSmVBvdLVKAUg1WULpvdkjq9eChVOaAAG7M2MOkUA8aSLbASnFnCXUhlhs10kVR68fEAe+ZR/bjoX/r/83sD4iwuBDLeg/sJ1afklgQu3EZLx9LHkEj0Q2qNzym8lNTM4Kj7QezsdYfVAjAydHv0YNnEmff+zNXtC+LbWqHk6jbjoBvKTn0wVyRk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E7F7FCBA804884092822BFF218923F7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1105af-0188-47a1-023f-08d71dac89c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 16:05:18.1337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJL50xE3H8gGgtEyx+ZH898EwC0IqZCmropMe2kX1J4sIPkpqCjGiVq+mF5UIOiGZZecmJFQNmes8o0WE+jzXMcNn8FLf1QTBb+SVFlrqWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4308
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.109
Subject: Re: [Qemu-devel] [PATCH v6 15/42] block: Re-evaluate backing file
 handling in reopen
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxOToxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBSZW9wZW5pbmcgYSBub2RlJ3Mg
YmFja2luZyBjaGlsZCBuZWVkcyBhIGJpdCBvZiBzcGVjaWFsIGhhbmRsaW5nIGJlY2F1c2UNCj4g
dGhlICJiYWNraW5nIiBjaGlsZCBoYXMgZGlmZmVyZW50IGRlZmF1bHRzIHRoYW4gYWxsIG90aGVy
IGNoaWxkcmVuDQo+IChhbW9uZyBvdGhlciB0aGluZ3MpLiAgQWRkaW5nIGZpbHRlciBzdXBwb3J0
IGhlcmUgaXMgYSBiaXQgbW9yZQ0KPiBkaWZmaWN1bHQgdGhhbiBqdXN0IHVzaW5nIHRoZSBjaGls
ZCBhY2Nlc3MgZnVuY3Rpb25zLiAgSW4gZmFjdCwgd2Ugb2Z0ZW4NCj4gaGF2ZSB0byBkaXJlY3Rs
eSB1c2UgYnMtPmJhY2tpbmcgYmVjYXVzZSB0aGVzZSBmdW5jdGlvbnMgYXJlIGFib3V0IHRoZQ0K
PiAiYmFja2luZyIgY2hpbGQgKHdoaWNoIG1heSBvciBtYXkgbm90IGJlIHRoZSBDT1cgYmFja2lu
ZyBmaWxlKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0ejxtcmVpdHpAcmVkaGF0LmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRz
b3ZAdmlydHVvenpvLmNvbT4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

