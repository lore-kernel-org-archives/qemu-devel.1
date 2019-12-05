Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F9FC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EB224249
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AmXX0iW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EB224249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictB3-0007qX-LU
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 10:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ict5I-000218-To
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ict5H-0007vf-72
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:30:28 -0500
Received: from mail-eopbgr130139.outbound.protection.outlook.com
 ([40.107.13.139]:61607 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ict5G-0007ng-T7
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:30:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACmB7ribvDlOR9ozP72ysHDmhgHMi2EfSYM/iJ6uR0lTRQGsGQl4fmRbgGikobkj+U3Aplb8idNP/FSf3HcQ4FMBEcsvCfplOQ8va8unZhFWUMLYOAvZCvyWlGoZn0qtkH3cTaODG+eor6lDn35cKs0vpx8rq3lUiPAijtuH3+emub58x6ZXxsIJoJ/XwKOm1k/Ngdn9YfTlgLU+1/UgIv2ay9+W9zH00U/TLIia0VtsHLic5LWm4qDXjmP8MrRUwLHnwEhL9m9mHfUrX8Ql4iL/Eqr3s2uBebKFthwDk7vdn1Dzty+3vn239V7s4l5vuoWalke38ZvbH+5cqKMlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1v3J42u4MAAm+ZBPjtjNv235W0NWWL5NvCD14ftboE=;
 b=PiEkODgbackVHk6Ls8HYFL2Y2SxIa0vI/3Eqqf+wRSOqTjmN9cKJzkHhntoXU6VG9qnZRjc2nmMImhA+nPtzyCRKwcZihE8U0+KNJKQ88rCL/RLLrAg0wceF4E7T5eBT7yvnOGLpGapYRrhJu8g60diRksyZG6syQCpHZT9z7evMUmCMTNRRgomk2mhml+ORzkAJMpI3fy7XIVrgVENXsa9rxjRhMyUJE5kcnxcphhZkY0rCit53WEw0aE0loO1QKIqdUtV+KtVjxtwqQoXBq60yJse9Uk7qHh3Yu6bSAB6ojYVbBotYb8YGTBst4uAyYGraEVf/hBnbsZEbIRxX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1v3J42u4MAAm+ZBPjtjNv235W0NWWL5NvCD14ftboE=;
 b=AmXX0iW4tknT/6rxwFWc5y1rcx/Y7AHzufRTC49lRa1IsGSVNYdpkS5aKgi3lurnIEwq9ZtbeV8wpl6yb3yGryR1MsBs6mFfaJaRvLBYDPp8rqU1tYpWRqX2YhH6d7sJUbkiLSj9TvRI5dI7QQ3JCDwzL1cvfD0WXSJwZTbjDHA=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4310.eurprd08.prod.outlook.com (20.179.5.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 15:30:24 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 15:30:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 06/21] io: Fix Error usage in a comment <example>
Thread-Topic: [PATCH 06/21] io: Fix Error usage in a comment <example>
Thread-Index: AQHVp7ZbVHfYGk1xQ0aB9fAkuSK/h6ersmQA
Date: Thu, 5 Dec 2019 15:30:24 +0000
Message-ID: <397f067b-faad-44f8-dc26-ab652e7ca6a2@virtuozzo.com>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-7-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-7-armbru@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0047.eurprd07.prod.outlook.com
 (2603:10a6:7:66::33) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191205183022643
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cda57c7a-7aa8-48cd-bcdf-08d779980c39
x-ms-traffictypediagnostic: AM6PR08MB4310:
x-microsoft-antispam-prvs: <AM6PR08MB43100E0CFB4BDF8596C0ACF7C15C0@AM6PR08MB4310.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(39850400004)(396003)(366004)(189003)(199004)(14444005)(64756008)(66446008)(8936002)(66556008)(66476007)(11346002)(4326008)(305945005)(5660300002)(2616005)(14454004)(81166006)(81156014)(8676002)(6486002)(76176011)(25786009)(316002)(2906002)(99286004)(478600001)(52116002)(110136005)(66946007)(26005)(31686004)(86362001)(186003)(6506007)(31696002)(36756003)(229853002)(102836004)(71200400001)(71190400001)(6512007)(4744005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4310;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DYPQxwykYj1fcqhVW5ioh7C6zIIRX9wiMwHSGz7TXiJ3K9cDrWrS3lj4U5PK0USsBAGjrKiJP54ErBt2qCox7d+oSPsTNthXAcG4/hdI+etSawsC9fN0BCZUcTtQHkgx++fYP0TSuw9OQeY2/Xvf0Xb53ZtpT93heG4scKmuH9DTPIrZvCBp4c9on36w7aZoUudvqHs/fTwqBaj6dxDWKdNq8GXyaYIgBKpI34jsK7WBa2bc/IlciplXe8q5toC6wC/CZvZxz2TonbMWFG3H8BsjzL7kdmYSpVorBlqKY5Gb+bLDZNZDKr7LDhqEUGiIPqIDFKEJAfgCXQNSLd/0RwcYT/oISEG2G+7ZmH/yOZgfLvQCNicC+quYtMJtoeIK4S7MUjuzGj7L5iSGkPZw7z+2ckH66k3wYbEuQk8AAI4BSiWzVtKvwklqbS/iWYV3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF35D177D8A8184E8E8C2EBBF9D0DF55@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda57c7a-7aa8-48cd-bcdf-08d779980c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 15:30:24.4114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKn7YVF+zfyZIHVa2/S41lh0FmG7EmBeTGxGBelcvuZxKoNDbW7U9rdSgVPa+a5GEdzpU6c9OlhraQgNEyN2E/S2JpmW975GW4uOfKmuotI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4310
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.139
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
Cc: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMTEuMjAxOSAyMjo0MiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IENjOiAiRGFuaWVs
IFAuIEJlcnJhbmfDqSIgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1h
cmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgaW5jbHVkZS9p
by90YXNrLmggfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9pby90YXNrLmggYi9pbmNsdWRl
L2lvL3Rhc2suaA0KPiBpbmRleCA1Y2I5ZmFmOWYyLi4xYWJiZmI4YjY1IDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL2lvL3Rhc2suaA0KPiArKysgYi9pbmNsdWRlL2lvL3Rhc2suaA0KPiBAQCAtMTE5
LDcgKzExOSw3IEBAIHR5cGVkZWYgdm9pZCAoKlFJT1Rhc2tXb3JrZXIpKFFJT1Rhc2sgKnRhc2ss
DQo+ICAgICogICBnYm9vbGVhbiBteW9iamVjdF9vcGVyYXRpb25fdGltZXIoZ3BvaW50ZXIgb3Bh
cXVlKQ0KPiAgICAqICAgew0KPiAgICAqICAgICAgUUlPVGFzayAqdGFzayA9IFFJT19UQVNLKG9w
YXF1ZSk7DQo+IC0gKiAgICAgIEVycm9yICplcnI7Kg0KPiArICogICAgICBFcnJvciAqZXJyID0g
TlVMTDsNCj4gICAgKg0KPiAgICAqICAgICAgLi4uY2hlY2sgc29tZXRoaW5nIGltcG9ydGFudC4u
Lg0KPiAgICAqICAgICAgIGlmIChlcnIpIHsNCj4gDQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCihJIGFsc28g
dGhpbmsgeW91IGNhbiBzYWZlbHkgcy9GaXggRXJyb3IgdXNhZ2UvRml4IHR5cG8vIGluIHN1Ympl
Y3QpDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

