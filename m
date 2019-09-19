Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2138C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC7721848
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Gl49Xgw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC7721848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAy8P-00035S-IQ
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 11:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAy77-0001zb-1m
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAy75-00067P-UL
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:12:56 -0400
Received: from mail-am5eur03on0718.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::718]:23044
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAy6u-00061X-JG; Thu, 19 Sep 2019 11:12:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epTrTd4Miepzn8+/jKd4ZBuauxxfpmNab/9hrmB+gsxAT96vUWAQHy/9MXo8i9YhZZlXUOc0pApgXyfTacmsajeOLWWaZNehXEs+ngQ8tUiPsjo51wM+XG0QNvCt+2r8CIgtwEKrpb9OWlvumvaNMXxfVUD3MzU6HkiRKa5pzyLd9A6BOkJgzAh7IwFFIS1K79TCIJAuOCYjD47IOQTT7DzeV1SB4j7K+uTa/5PwutjtnbSHr9wFJAxSP/D+6CfA40JCVEw767mxnjAC+kve+e7MCO7KLQiDwjQZbJIKwcqCciSjycICx7l6xNOqE3X/9tBnXH/rQRLsQLJIDhgPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J8Dkf0b8VJdXEGADfaAAcd7b7hq1YnvD5ovTiuTo5E=;
 b=TBVTeQsYbSEk1ZOEaCOtukuOgqg2EHkmKaH1RyWzDB7wMHskER1b60cpGs5A4a27xCF2Y6l8WMZVniLOLpE+y4AI5e0WJKULCWXADIEQLQ0250k7NyDP6dc4MoGqBF0KPTFtcc1kFF9UvkLBGXHLSPYSC1/YXnLudaD6vLOQJpx39CzCFz5BkBsOKsvBT3X3okwrs/yU1CdKtdtgUVG1vUp1+TITWRwTrWzwFyqJzA2U/hTZLNH59LKGRxSy5Q049lnCpixiOxYbuJjDwLQFePbQIkpokLMpeyWOPoS7XWtutION6lpi9ha2qhui1Hsx0O7UbLRERFRcgEVDX3NHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J8Dkf0b8VJdXEGADfaAAcd7b7hq1YnvD5ovTiuTo5E=;
 b=Gl49Xgw74+uxKpaOoRR3IcYg310cmFUdZbWts8o89YMW2A/VkoIZms5fnlx0c3ywnHttfnCjzAcM4TnuKZv1PVEqnBgvkjI7vDBk14q9Mm5+GFGN36aR1eNVvRm+2uXp693ygL0WBaoofIIeq+3O6cc05dvzrcsjAf1cWCnIFUY=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4972.eurprd08.prod.outlook.com (10.255.18.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Thu, 19 Sep 2019 15:12:41 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 15:12:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC] error: auto propagated local_err
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKcxq6KAgAEOLgCAAEmpAIAACO4AgAAE0QCAAAPuAIAAB+6A
Date: Thu, 19 Sep 2019 15:12:41 +0000
Message-ID: <f00835e6-135f-ac92-d22f-e1aa7d72f463@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
 <20190919091720.GB10163@localhost.localdomain>
 <57483252-273c-4606-47a8-eddeb840109a@redhat.com>
 <35c972e1-bdb5-cbcb-ed45-6a51f19af98c@virtuozzo.com>
 <696673be-95c8-3f75-551c-26fccd230eb1@virtuozzo.com>
 <152afb5b-8efb-d968-d595-94f58ad02a04@redhat.com>
In-Reply-To: <152afb5b-8efb-d968-d595-94f58ad02a04@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0004.eurprd03.prod.outlook.com
 (2603:10a6:3:76::14) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919181237441
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e18d49d-754c-4f31-b116-08d73d13d09f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4972; 
x-ms-traffictypediagnostic: DB8PR08MB4972:
x-microsoft-antispam-prvs: <DB8PR08MB497217860BC2176EB84EE62FC1890@DB8PR08MB4972.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(396003)(346002)(39850400004)(366004)(189003)(199004)(52314003)(52116002)(6512007)(5660300002)(6436002)(66446008)(64756008)(66556008)(66476007)(66946007)(6486002)(229853002)(25786009)(99286004)(54906003)(6246003)(31696002)(316002)(110136005)(86362001)(2906002)(31686004)(76176011)(4326008)(36756003)(305945005)(256004)(7736002)(7416002)(7406005)(8936002)(81156014)(81166006)(186003)(476003)(53546011)(102836004)(386003)(6506007)(14454004)(3846002)(26005)(478600001)(6116002)(2616005)(446003)(8676002)(11346002)(71200400001)(486006)(71190400001)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4972;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0JYaBJyb1oAdoLN+2lr+o0W2p7JPzhOdRclYaESxZjHvkUG9LA9mjU+xj9olCpUAJ/WQpzEbT7FCPbQJXm6NTLQNRcnw3ONZyz0Lnp8wCIVCdEmUBlivrkqlPnBuCi7d1rzM2x1uZGzPlYnsvx6uE2rLYtZf+MLz/P10Of6UYqtYuQsqmyip/5rk6Zto5ivdSHsSZ4skrMGNSJDPjFXRjJDyYJPyuTltsAYgxArSAmKW7cpsmr4FAGmCOHvIaYrsIkoGZbz5BXNqG4xK3fQR5vGDYTiBW7sdAn+MKpqsD9kw9UfE7khuCMvT5IJUTe5HG4DLiKlx2LiBcqU+TaJOfElwxcQ1IAdigz1IIwUkc07Pu2Rpg9OeGwXap0WzrN2HF1sn8ElsHYaGdD1wHmpYhtxe/xvLmmHIGSIjOyzmENA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <97B28422EC76964EA4C8F1480CE7289E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e18d49d-754c-4f31-b116-08d73d13d09f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 15:12:41.1154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1szyjuY/3N+U1ecHa2ZXMPQIKtFxFWAMY+PTqH6E9igNMpsJXTPBeOrC4KZo02GmG+3GS3fRC6t8F7KO0phd4ImbbA4qvfQlQ4Hb2NJF38g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4972
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::718
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "codyprime@gmail.com" <codyprime@gmail.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDkuMjAxOSAxNzo0NCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS8xOS8xOSA5OjMwIEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPiANCj4+Pg0KPj4+IFRvIHRo
ZSBzYW1lIHRvcGljLCBvZiBtaW5pbWl6YXRpb246IHNob3VsZCB3ZSBhbHdheXMgY2FsbCBNQUtF
X0VSUlBfU0FGRSBhdCBmdW5jdGlvbiB0b3AsIG9yIG9ubHkNCj4+PiBpbiBibG9jaywgd2hlcmUg
aXQgaXMgbmVlZGVkIChhc3N1bWUsIHdlIGRlcmVmZXJlbmNlIGl0IG9ubHkgaW5zaWRlIHNvbWUg
ImlmIiBvciAid2hpbGUiPw0KPj4+IEtldmluLCBpcyBzb21ldGhpbmcgYmFkIGluIHByb3BhZ2F0
aW9uLCB3aGVuIGl0IG5vdCByZWxhdGVkIHRvIGVycm9yX2Fib3J0Pw0KPj4+DQo+Pj4NCj4+DQo+
PiBPciwgZXZlbiwgd2UgbWF5IHVzZSBNQUtFX0VSUlBfU0FGRSBvbiBldmVyeSBmdW5jdGlvbiwg
d2hpY2ggaGF2ZSBFcnJvciAqKmVycnAgYXJndW1lbnQsIGV2ZW4gaWYgd2UgbmVpdGhlcg0KPj4g
ZGVyZWZlcmVuY2UgaXQgbm9yIGFwcGVuZCBoaW50cz8gSXMgaXQgd2hhdCB5b3UgcHJvcG9zZSBi
eSAiU0lOR0xFIHBhcmFkaWdtIj8gSXQncyBvZiBjb3Vyc2Ugc2ltcGxlciB0byBzY3JpcHQsDQo+
PiB0byBjaGVjayBpbiBjaGVja3BhdGNoIGFuZCB0byBtYWludGFpbi4NCj4gDQo+IFllcy4gVGhl
IHNpbXBsZXIgd2UgbWFrZSB0aGUgcnVsZXMsIGFuZCB0aGUgbGVzcyBib2lsZXJwbGF0ZSBpdCBl
bnRhaWxzLA0KPiB0aGUgbW9yZSBsaWtlbHkgdGhhdCB3ZSBjYW46DQo+IA0KPiBhKSBhdm9pZCBl
eGNlcHRpb25zIGFuZCBjb3JuZXIgY2FzZXMgdGhhdCBjb3N0IHJldmlldyB0aW1lDQo+IGIpIGF1
dG9tYXRlIHRoZSBjb252ZXJzaW9uIGludG8gY29tcGx5aW5nIHdpdGggdGhlIHJ1bGUNCj4gYykg
Y29kaWZ5IHRob3NlIHJ1bGVzIGluIHN5bnRheCBjaGVjayB0byBlbnN1cmUgdGhleSBhcmUgZm9s
bG93ZWQNCj4gcG9zdC1jb252ZXJzaW9uDQo+IA0KPiBBTFdBWVMgdXNpbmcgTUFLRV9FUlJQX1NB
RkUoKSBvbiBlbnRyeSB0byBhbnkgZnVuY3Rpb24gdGhhdCBoYXMgYW4gRXJyb3INCj4gKiplcnJw
IHBhcmFtZXRlciBpcyBkaXJ0LXNpbXBsZSB0byBleHBsYWluLiAgSXQgaGFzIG5vIHBlcmZvcm1h
bmNlDQo+IHBlbmFsdHkgaWYgdGhlIHVzZXIgcGFzc2VkIGluIGEgbm9ybWFsIGVycm9yIG9yIGVy
cm9yX2Fib3J0ICh0aGUgY29zdCBvZg0KPiBhbiAnaWYnIGhpZGRlbiBpbiB0aGUgbWFjcm8gaXMg
cHJvYmFibHkgbmVnbGlnaWJsZSBjb21wYXJlZCB0bw0KPiBldmVyeXRoaW5nIGVsc2Ugd2UgZG8p
LCBhbmQgaGFzIG5vIHNlbWFudGljIHBlbmFsdHkgaWYgdGhlIHVzZXIgcGFzc2VkDQo+IGluIE5V
TEwgb3IgZXJyb3JfZmF0YWwgKHdlIG5vdyBnZXQgdGhlIGJlaGF2aW9yIHdlIHdhbnQgd2l0aCBs
ZXNzDQo+IGJvaWxlcnBsYXRlKS4NCj4gDQo+IEhhdmluZyB0byB0aGluayAnZG9lcyB0aGlzIG1l
dGhvZCByZXF1aXJlIG1lIHRvIHVzZSBNQUtFX0VSUlBfU0FGRSwgb3INCj4gY2FuIEkgb21pdCBp
dD8nIGRvZXMgbm90IHByb3ZpZGUgdGhlIHNhbWUgc2ltcGxpY2l0eS4NCj4gDQoNCkludGVyZXN0
aW5nOiBpdCdzIGFub3RoZXIgc3RvcnksIGJ1dCB3aXRoIHRoaXMgbWFjcm8gdXNlZCBpbiBlYWNo
IGVycnAtZnVuY3Rpb24gd2UgY2FuIGNvbGxlY3QNCnRoZSB3aG9sZSBjYWxsLXN0YWNrIG9mIHRo
ZSBlcnJvciBpbnQgRXJyb3Igb2JqZWN0LCBhbmQgcmVwb3J0IGl0Lg0KSXQgbWF5IGJlIG5vdCBn
b29kIGZvciBlbmQtdXNlciwgYnV0IHZlcnkgdXNlZnVsIGZvciB0ZXN0aW5nLg0KDQpPciBpcyBp
dCBiYWQgaWRlYT8gQW55d2F5LCBJIG9mdGVuIGhhdmUgdGhlIHByb2JsZW06IEkgaGF2ZSBzb21l
IGVycm9yIHJlcG9ydGVkLCBhbmQgbmVlZCB0bw0KdW5kZXJzdGFuZCB3aGVyZSB3YXMgaXQgZnJv
bS4uIGdpdCBncmVwIGhlbHBzLCBidXQgYmFja3RyYWNlIHdvdWxkIGJlIGEgbG90IGJldHRlci4N
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

