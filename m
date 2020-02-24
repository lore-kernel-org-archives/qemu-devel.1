Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F4AC3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434342072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WMAgGKHY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vGjR2DjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434342072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6BZI-0005hM-Gi
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=316298c0a=Anup.Patel@wdc.com>)
 id 1j6BYZ-00057z-Mj
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:05:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=316298c0a=Anup.Patel@wdc.com>)
 id 1j6BYY-0006Am-5x
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:05:47 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21480)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=316298c0a=Anup.Patel@wdc.com>)
 id 1j6BYT-00067N-HQ; Mon, 24 Feb 2020 06:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582542342; x=1614078342;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gd5DkkKzXhqc5kSO8uwDvHSXDED69THV++JzYRlk6Fc=;
 b=WMAgGKHYpA9fvLUZ7sth0nR4C0UzBDfUXYEbPDZ5wTnAQMcabMMathYD
 rM2hmCrikS32bdkocrYMdelc85OBlelaJ7toXJFuq5BjLRgroXehXS/IF
 CXJ6Iqp2Flmiv1S0sWPlO99QWrCD9X/BQmhCQs9IX2wTAD1xuxJj0/v5l
 5c6cCXHOr5Q8FV1nQUmnlOxBJEJ3Xe3XgS901OVHpqt8l8R4gVR5JSQpw
 /G2odJT8aROqHRYSOibzAY9RC9EEGVEpo/3fsLkWHpSQu53IEEwUtm+XB
 Aw75wf12+IXDfgzovvR9Xq9X3pzx+ajOOvV8VwSoFTujm4Ui+FCk5tSid A==;
IronPort-SDR: bnTyEMBLYEIs3gDHyQbErlqMxokV6aaYGOQgdnk5E5rsaa8V9Qpec/kRDAxvSiGJfmtFeCvFup
 ALtRznt7phE6R7PbBip1c+PY/49XL9RddCU39PiGZN9+NMlqnsW5tEIekt5bhgsc4YMmwLqYY1
 y78QZNrzteZ9jJ8k2yH8D3d6Llgx5IFpO4r9QiYxVCZz35dXKuhId8qnPt20dqddG5YJ29Hb7e
 +Y/CuCl8kPjOBWL8AZ+Gwd3Z2gLYfkrDfD/xvm4ICN6SVe1I4sjMCPp1MROkzpic68U67SwX4r
 k4U=
X-IronPort-AV: E=Sophos;i="5.70,479,1574092800"; d="scan'208";a="132018478"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2020 19:05:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h77A7Wdz+v39FGrvO0z11YlLosvkiObLTb1tcJxCR47WW/PcDVDWOriJJqxmbaK/i7nnMUIEmSQUz3W2v2GMG3gyAdElV6xOXvEQ8LDuTqNJsC/q/nXCforrM9kShUNmpPrRyjIAr867GY8Jw8wNKpHxM3tEwvOM4jBMALYt+DIWmsyyjHcL2LLpaoidf7UnvaREv42OtDi2GE9iaOKLNvyyi5Wh4wPChtl/VB7X2QnqUCOmgqaEVFqdF08Sqwij+cGGpHd9oDBEw8BonzKZxw//fnXe1M8vtloKj6jodaPBWeBlUQc2eFRXSGFw9ONg/o/uTyolhIyTOkSAb0TSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd5DkkKzXhqc5kSO8uwDvHSXDED69THV++JzYRlk6Fc=;
 b=Iny++xaMDb/xHoMbmlOroyojTjZXUnanwDicg7MIjYcAHtBiRxppo4UQ4tqf8VTZCfHJbO2vc/5tTPjn7uw84PMS1VD8DSSoGx9k8cTcR8gJL8uDhyMOXGukAZs5jvtkwq0xyQ03wbKPakIAgv0ujiIQLieXzlyy80aZaQrNDfz9V0OBrdeZWnGOfVgJOc0vD2DvxdXoxUtrtKih2wTAgHWnJ9AaOxWndXovyuBNVmygSj17x0G5NqZyhIYO3d0cXlr5RmcnMaY7oyfFkEslm6GitDW047/D6+ARIXA6JjjnUsaui71izvWRKpZQMzMeQz5be5aQGYkftNP1kaUT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd5DkkKzXhqc5kSO8uwDvHSXDED69THV++JzYRlk6Fc=;
 b=vGjR2DjGAbs+Iga2xDRsS/8StMT/jOdVLNRYNO3ujH817fo1xFlR1jDxdt9TggTINMzYr9Ft7nN0P/n1ecR3oXav9zZk8vOMMLfwPRtbK73i0iEB0iInh2zwjsNyfITcjKbsdq5GOph4043bmBEFfhzP4wqUOzysT78tMMgvvTU=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
 by MN2PR04MB6078.namprd04.prod.outlook.com (2603:10b6:208:e3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 11:05:35 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8%6]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 11:05:35 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>, Jose Martins
 <josemartins90@gmail.com>
Subject: RE: [PATCH 1/1] target/riscv: Fix VS mode interrupts forwarding.
Thread-Topic: [PATCH 1/1] target/riscv: Fix VS mode interrupts forwarding.
Thread-Index: AQHV6lA85AxxfPtdLUe1fUudkiM/e6go2eGAgAAIJICAAAhYgIABNyOAgAANuUA=
Date: Mon, 24 Feb 2020 11:05:34 +0000
Message-ID: <MN2PR04MB6061244D856F92F469E8E53B8DEC0@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <0c4859f90948ba392da456c9e1daf8fde8f5b22e.1582453384.git.rajnesh.kanwal49@gmail.com>
 <CAC41xo0PWCZw4mrcEfRq9fv+b3mSk9sN0mWhFXPwgdD6LR8xnQ@mail.gmail.com>
 <CAHfcQ+GGCXj6f+PMMvqNhg=Lzpi1Ke+OaEO6-pb5gjSngm3Upg@mail.gmail.com>
 <CAC41xo0V_F4ExJjoYx4AWQXViX-WwgfFx219EyCb8mk-okKUAQ@mail.gmail.com>
 <CAHfcQ+Fw_mEAyGXwry8_jdXBJcMoV3-x8T61oypzQ3_-1Tn_Pw@mail.gmail.com>
In-Reply-To: <CAHfcQ+Fw_mEAyGXwry8_jdXBJcMoV3-x8T61oypzQ3_-1Tn_Pw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [49.207.61.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19ca400b-3ad3-482d-aa64-08d7b91978f2
x-ms-traffictypediagnostic: MN2PR04MB6078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6078A7B462C921EC3C0A59E88DEC0@MN2PR04MB6078.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(316002)(52536014)(86362001)(71200400001)(8936002)(2906002)(7696005)(4326008)(8676002)(81166006)(81156014)(186003)(54906003)(966005)(55236004)(64756008)(66556008)(76116006)(33656002)(53546011)(55016002)(5660300002)(478600001)(9686003)(6506007)(26005)(66946007)(110136005)(66476007)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6078;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMnOCpRfnEcWN5rcB2Ri8Iv5Y4Xd8ZaGYh5LdSPoKYasaVG/qcHMmXIJ6FMx5yBHpwk+HCnHSW5yXzpN7b46tUHZhMT2bUdxStj9g4c1Goe10X/muoPsHcZBJCQNZSRp4KvF3EFIZfrrpmcfVOXRYn7sBq1l6STR78vfKQrc/8ywM6aQdCK1OH0lYamhy44MK+TRngSSdj9RHmv3qcIANAm7uH366gDqVGl61WNDjrNk3Re2aUP58sIY17koVlxxvvsiQCu4qOFAG1Cat76Zntz6G5R6twPdi7XbHJ7Vg+uQL0zNpyYe+6Z3hi1cLnCeadoITlCRjZfZju4zPYDB6mhbNvBUaV3rG98zOQN45r4o4yNdSKuqQ7aFafpktvL8eocpTAaAoWUCT+7ToLUtWZomom4IZu7sVqrFk6nD7I+WsS553kqRnHqy4ZPq0bDxOMQyDTCzWxgKUk1c0sj4msgwmE0+slNhXjBWS4YmSfHi4Pm0DIdr6tQJ8jGhe2BrzVoquHtCsvfZ4bRsJgFJIw==
x-ms-exchange-antispam-messagedata: smddx9Lv+t8oRIMz2cdOWUjMkuHOOrMxCw8Id2Q+hQmra2zFBC+AbFryQ1Jv5KsfFNmqBbplCkIBTnb4EnL7dSsVSN7c0mXf+jYO+gkKfbLzNAXDt68Xd+hwh4QyrM90NUb8zgm8KLr17ZbX3silHg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ca400b-3ad3-482d-aa64-08d7b91978f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 11:05:34.9535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rj2+rzqdzPYvKIXSKK/hH/Jrjk+oV3k1n5AxoQKutJrFjguZvZukX88EciaIJTY51eqrq1vKHiRfqZRoHsaWLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6078
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGksDQoNClllcywgaW5kZWVkIHRoaXMgaGFzIHRvIGJlIGZpeGVkIGluIFFFTVUsIFh2aXNvciBh
bmQgS1ZNLg0KDQpCZWZvcmUgZml4aW5nIFh2aXNvciBhbmQgS1ZNLCB3ZSBoYXZlIHRvIGZpcnN0
IGZpeCB0aGlzIGluIFFFTVUuDQoNCkZvciBYdmlzb3IgUklTQy1WLCBmZWVsIGZyZWUgdG8gc2Vu
ZCBwYXRjaCB0byBYdmlzb3ItZGV2ZWxAZ29vZ2xlZ3JvdXBzLmNvbQ0KRm9yIEtWTSBSSVNDLVYs
IEkgd2lsbCB1cGRhdGUgaXQgaW4gdjExIHBhdGNoIHNlcmllcyBhbmQgS1ZNIFJJU0MtViBnaXQg
cmVwbyBhcyB3ZWxsLg0KDQpSZWdhcmRzLA0KQW51cA0KDQpGcm9tOiBRZW11LXJpc2N2IDxxZW11
LXJpc2N2LWJvdW5jZXMrYW51cC5wYXRlbD13ZGMuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBP
ZiBSYWpuZXNoIEthbndhbA0KU2VudDogTW9uZGF5LCBGZWJydWFyeSAyNCwgMjAyMCAzOjQ0IFBN
DQpUbzogSm9zZSBNYXJ0aW5zIDxqb3NlbWFydGluczkwQGdtYWlsLmNvbT4NCkNjOiBBbGlzdGFp
ciBGcmFuY2lzIDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+OyBwYWxtZXJkYWJiZWx0QGdvb2ds
ZS5jb207IHFlbXUtcmlzY3ZAbm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQpTdWJq
ZWN0OiBSZTogW1BBVENIIDEvMV0gdGFyZ2V0L3Jpc2N2OiBGaXggVlMgbW9kZSBpbnRlcnJ1cHRz
IGZvcndhcmRpbmcuDQoNCk5pY2UgY2F0Y2guIFlvdSBhcmUgcmlnaHQuIEkgd2FzIGEgYml0IGNv
bmZ1c2VkIGFmdGVyIGxvb2tpbmcgYXQgY3VycmVudCB4dmlzb3IgYW5kIEtWTSBwb3J0LiBUaGV5
IGFyZSBkZWxlZ2F0aW5nIFMgbW9kZSBpbnRlcnJ1cHRzIHRvIFZTIG1vZGUsIGFzIHBlciBteSB1
bmRlcnN0YW5kaW5nIGFmdGVyIGxvb2tpbmcgYXQgaHR0cHM6Ly9naXRodWIuY29tL2t2bS1yaXNj
di9saW51eC9ibG9iL3Jpc2N2X2t2bV9tYXN0ZXIvYXJjaC9yaXNjdi9rdm0vbWFpbi5jIGxpbmUg
bm8uIDM0LiBJIHdpbGwgc2VlIGlmIHRoZXJlIGlzIGEgd2F5IHRvIGRlY2xpbmUgYSBwYXRjaC4g
DQpUaGFua3MgZm9yIHBvaW50aW5nIHRoYXQgb3V0Lg0KUmVnYXJkcywNClJham5lc2gNCg0KT24g
U3VuLCBGZWIgMjMsIDIwMjAgYXQgODo0MCBQTSBKb3NlIE1hcnRpbnMgPG1haWx0bzpqb3NlbWFy
dGluczkwQGdtYWlsLmNvbT4gd3JvdGU6DQpObyBwcm9ibGVtLiBCdXQgSSdtIGZhaWxpbmcgdG8g
c2VlIHdoYXQgeW91IG1lYW4uIE15IHJlYXNvbmluZyB3YXM6DQp0aGUgc3BlY2lmaWNhdGlvbiBt
YW5kYXRlcyB0aGF0IG9ubHkgVlMgbW9kZSBpbnRlcnJ1cHQgYml0cyBhcmUNCndyaXRhYmxlIGlu
IGhpZGVsZWcsIGFsbCB0aGUgb3RoZXJzIG11c3QgYmUgaGFyZHdpcmVkIHRvIHplcm8uIFRoaXMN
Cm1lYW5zIHRoZSBoeXBlcnZpc29yIGNhbid0IHJlYWxseSBkZWxlZ2F0ZSBTIG1vZGUgaW50ZXJy
dXB0cyBhcyB5b3UNCmFyZSBzYXlpbmcuIFNvLCBpZiB0aGlzIGlzIGltcGxlbWVudGVkIGNvcnJl
Y3RseSwgeW91IHdpbGwgbmV2ZXIgZ2V0DQppbnNpZGUgdGhhdCBpZiBjb25kaXRpb24gYmVjYXVz
ZSBvZiBhbiBIUyBpbnRlcnJ1cHQuIEFuZCBhbGwNCmRlbGVnYXRhYmxlIGFzeW5jaHJvbm91cyBl
eGNlcHRpb24gdmFsdWVzIG11c3QgYmUgZGVjcmVtZW50ZWQuIFNvLA0KY2hlY2tpbmcgaWYgdGhp
cyBpcyBhbiBhc3luYyBleGNlcHRpb24gc2hvdWxkIGRvIHRoZSBqb2IuDQoNCkpvc2UNCg0KT24g
U3VuLCAyMyBGZWIgMjAyMCBhdCAxNToxMCwgUmFqbmVzaCBLYW53YWwgPG1haWx0bzpyYWpuZXNo
LmthbndhbDQ5QGdtYWlsLmNvbT4gd3JvdGU6DQo+DQo+IEhlbGxvIEpvc2UsDQo+DQo+IFNvcnJ5
IEkgZGlkbid0IHNlZSB0aGF0IGFzIGl0IGhhZG4ndCBiZWNhbWUgYSBwYXJ0IG9mIHRoZSBwb3J0
LiBJIGRvbid0IGtub3cgaG93DQo+IHRoZXkgcHJvY2VlZCB3aXRoIHNhbWUgcGF0Y2hlcy4NCj4N
Cj4gSnVzdCB0byBhZGQsIHRoZXJlIGlzIGEgbWlub3IgcHJvYmxlbSB3aXRoIHlvdXIgcGF0Y2gu
IFRoZSBjYXVzZSB2YWx1ZSBzaG91bGQNCj4gb25seSBiZSBkZWNyZW1lbnRlZCBieSBvbmUgZm9y
IFZTIG1vZGUgaW50ZXJydXB0cy4gSW4gY2FzZSBpZiBoeXBlcnZpc29yIGhhcw0KPiBkZWxlZ2F0
ZWQgUyBtb2RlIGludGVycnVwdHMgdGhlbiB3ZSBzaG91bGQgbm90IGRlY3JlbWVudCBjYXVzZSBm
b3IgdGhvc2UNCj4gaW50ZXJydXB0cy4NCj4NCj4gUmVnYXJkcywNCj4gUmFqbmVzaA0KPg0KPg0K
PiBPbiBTdW4sIEZlYiAyMywgMjAyMCBhdCA3OjQxIFBNIEpvc2UgTWFydGlucyA8bWFpbHRvOmpv
c2VtYXJ0aW5zOTBAZ21haWwuY29tPiB3cm90ZToNCj4+DQo+PiBIZWxsbyByYWpuZXNoLA0KPj4N
Cj4+IEkgaGFkIGFscmVhZHkgc3VibWl0dGVkIGFsbW9zdCB0aGlzIGV4YWN0IHBhdGNoIGEgZmV3
IHdlZWtzIGFnby4NCj4+DQo+PiBKb3NlDQo+Pg0KPj4gT24gU3VuLCAyMyBGZWIgMjAyMCBhdCAx
Mzo1MSwgPG1haWx0bzpyYWpuZXNoLmthbndhbDQ5QGdtYWlsLmNvbT4gd3JvdGU6DQo+PiA+DQo+
PiA+IEZyb206IFJham5lc2ggS2Fud2FsIDxtYWlsdG86cmFqbmVzaC5rYW53YWw0OUBnbWFpbC5j
b20+DQo+PiA+DQo+PiA+IEN1cnJlbnRseSByaXNjdl9jcHVfbG9jYWxfaXJxX3BlbmRpbmcgaXMg
dXNlZCB0byBmaW5kIG91dCBwZW5kaW5nDQo+PiA+IGludGVycnVwdCBhbmQgVlMgbW9kZSBpbnRl
cnJ1cHRzIGFyZSBiZWluZyBzaGlmdGVkIHRvIHJlcHJlc2VudA0KPj4gPiBTIG1vZGUgaW50ZXJy
dXB0cyBpbiB0aGlzIGZ1bmN0aW9uLiBTbyB3aGVuIHRoZSBjYXVzZSByZXR1cm5lZCBieQ0KPj4g
PiB0aGlzIGZ1bmN0aW9uIGlzIHBhc3NlZCB0byByaXNjdl9jcHVfZG9faW50ZXJydXB0IHRvIGFj
dHVhbGx5DQo+PiA+IGZvcndhcmQgdGhlIGludGVycnVwdCwgdGhlIFZTIG1vZGUgZm9yd2FyZGlu
ZyBjaGVjayBkb2VzIG5vdCB3b3JrDQo+PiA+IGFzIGludGVuZGVkIGFuZCBpbnRlcnJ1cHQgaXMg
YWN0dWFsbHkgZm9yd2FyZGVkIHRvIGh5cGVydmlzb3IuIFRoaXMNCj4+ID4gcGF0Y2ggZml4ZXMg
dGhpcyBpc3N1ZS4NCj4+ID4NCj4+ID4gU2lnbmVkLW9mZi1ieTogUmFqbmVzaCBLYW53YWwgPG1h
aWx0bzpyYWpuZXNoLmthbndhbDQ5QGdtYWlsLmNvbT4NCj4+ID4gLS0tDQo+PiA+wqAgdGFyZ2V0
L3Jpc2N2L2NwdV9oZWxwZXIuYyB8IDkgKysrKysrKystDQo+PiA+wqAgMSBmaWxlIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4gPg0KPj4gPiBkaWZmIC0tZ2l0IGEv
dGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMNCj4+
ID4gaW5kZXggYjllOTBkZmQ5YS4uNTk1MzVlY2JhNiAxMDA2NDQNCj4+ID4gLS0tIGEvdGFyZ2V0
L3Jpc2N2L2NwdV9oZWxwZXIuYw0KPj4gPiArKysgYi90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5j
DQo+PiA+IEBAIC00Niw3ICs0Niw3IEBAIHN0YXRpYyBpbnQgcmlzY3ZfY3B1X2xvY2FsX2lycV9w
ZW5kaW5nKENQVVJJU0NWU3RhdGUgKmVudikNCj4+ID7CoCDCoCDCoCB0YXJnZXRfdWxvbmcgcGVu
ZGluZyA9IGVudi0+bWlwICYgZW52LT5taWUgJg0KPj4gPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfihNSVBfVlNTSVAgfCBNSVBfVlNUSVAgfCBNSVBf
VlNFSVApOw0KPj4gPsKgIMKgIMKgIHRhcmdldF91bG9uZyB2c3BlbmRpbmcgPSAoZW52LT5taXAg
JiBlbnYtPm1pZSAmDQo+PiA+IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAoTUlQX1ZTU0lQIHwgTUlQX1ZTVElQIHwgTUlQX1ZTRUlQKSkgPj4gMTsNCj4+ID4g
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIChNSVBfVlNTSVAg
fCBNSVBfVlNUSVAgfCBNSVBfVlNFSVApKTsNCj4+ID4NCj4+ID7CoCDCoCDCoCB0YXJnZXRfdWxv
bmcgbWllwqAgwqAgPSBlbnYtPnByaXYgPCBQUlZfTSB8fA0KPj4gPsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIChlbnYtPnByaXYgPT0gUFJWX00gJiYgbXN0YXR1c19t
aWUpOw0KPj4gPiBAQCAtOTAwLDYgKzkwMCwxMyBAQCB2b2lkIHJpc2N2X2NwdV9kb19pbnRlcnJ1
cHQoQ1BVU3RhdGUgKmNzKQ0KPj4gPg0KPj4gPsKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChyaXNj
dl9jcHVfdmlydF9lbmFibGVkKGVudikgJiYgKChoZGVsZWcgPj4gY2F1c2UpICYgMSkgJiYNCj4+
ID7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAhZm9yY2VfaHNfZXhlY3ApIHsNCj4+ID4gK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qDQo+PiA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCogU2VlIGlmIHdlIG5lZWQgdG8gYWRqdXN0IGNhdXNlLiBZZXMgaWYgaXRzIFZTIG1vZGUgaW50
ZXJydXB0DQo+PiA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCogbm8gaWYgaHlwZXJ2aXNv
ciBoYXMgZGVsZWdhdGVkIG9uZSBvZiBocyBtb2RlJ3MgaW50ZXJydXB0DQo+PiA+ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCovDQo+PiA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAo
Y2F1c2UgPT0gSVJRX1ZTX1RJTUVSIHx8IGNhdXNlID09IElSUV9WU19TT0ZUIHx8DQo+PiA+ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYXVzZSA9PSBJUlFfVlNfRVhUKQ0KPj4gPiAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2F1c2UgPSBjYXVzZSAtIDE7DQo+PiA+wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogVHJhcCB0byBWUyBtb2RlICovDQo+PiA+wqAgwqAg
wqAgwqAgwqAgwqAgwqAgfSBlbHNlIGlmIChyaXNjdl9jcHVfdmlydF9lbmFibGVkKGVudikpIHsN
Cj4+ID7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBUcmFwIGludG8gSFMgbW9kZSwgZnJv
bSB2aXJ0ICovDQo+PiA+IC0tDQo+PiA+IDIuMTcuMQ0KPj4gPg0KPj4gPg0K

