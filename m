Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F230C4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047202168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=here.com header.i=@here.com header.b="sNUwt+1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047202168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=here.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKg4c-0002Qg-55
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 05:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.bonnans@here.com>) id 1iKg3j-0001xL-HG
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.bonnans@here.com>) id 1iKg3g-0004Lv-TH
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:57:34 -0400
Received: from mail-eopbgr60133.outbound.protection.outlook.com
 ([40.107.6.133]:45155 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent.bonnans@here.com>)
 id 1iKg3g-0004L3-JQ; Wed, 16 Oct 2019 05:57:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/Ssa4ARDlfqcyKzzedf3JrrsggbVh2GXxFl0SM2KGPPEgcR8H+DYGfWUuhRKxi21027CDHmYdXI/a84YYA/oCWrCJ10EqdcOjblo9Tq034pmwL0zSgFDJGxmMuVb27sbx6jVqtjgU9YAxLF4PF9ztW6l7SsjIl7WrhkjcaFADpIqh9pnROCGHKEssRTAPWE4v4ySzCqFtCtyeKuKhjgNkwmEUlkoEQLqDFpwLUOxgK1WHzjrbbuqEq6x0BA1dQ606TTbfLKt2IJT115waBVp/jz6m4et7bAhwARpX9p5GRq5agagB25GtRfDuBfjO5rFLWAk/FCIZV1ijuMQnN+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kCoMf0RgSyPH00pF51anISg9P7MH4E5ivjJ2aNMtLM=;
 b=GsI5piRxpLaukKgyuPB/KruUADVLZ5ACKuGTOuUKaAybJ3P0snrYf3V3RBThbkBMgCtdSm/bHcrsfdl26PAcju89g0DnucO69ozOBs/OpMDGdIdfIrQD2JYrAdo0RMZoTzvHVKEN7B4f9KKrRcOMtLaETzM/r1LJbUxzPyoYotUZjY3FaeHma9odkAmcbUTjOyuBWI7bGF1ifVJNXtYVgPjgAhdcbn9TYIK0fa3jKvhfc7mVH0Y3pDKd9YEzIbi8FW/iGw/w6Cgad0qIxqZu204Wo9s0Zihsnt9x4GrEXi8++RkwFJPTeWhZYtn0UndOEEfgOPnW6JBcb7PMwCcuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=here.com; dmarc=pass action=none header.from=here.com;
 dkim=pass header.d=here.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=here.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kCoMf0RgSyPH00pF51anISg9P7MH4E5ivjJ2aNMtLM=;
 b=sNUwt+1PBGKUWLVv1jJTfUzQ/Yy+cNTGfvLGvjq26EGeNZv9hgyyvkMb+uFly+dUFuREqNRi5YJTCZbO0wsYQOEhEADntD0Nfth/FuH7OS/4b30JD0ZJWP7tFJCFBM/n0tNOLvkc2j4fJEOvdNHgPlRE4vZphcypys+r7V38G/I=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB2962.eurprd04.prod.outlook.com (10.167.170.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 16 Oct 2019 09:57:29 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::204a:79f8:1bb8:f8a8]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::204a:79f8:1bb8:f8a8%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 09:57:29 +0000
From: "Bonnans, Laurent" <laurent.bonnans@here.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 00/19] hw/arm/raspi: Improve Raspberry Pi 2/3 reliability
Thread-Topic: [PATCH 00/19] hw/arm/raspi: Improve Raspberry Pi 2/3 reliability
Thread-Index: AQHVdJCqR93wWUmCgke4ueNfTHgz2addJxsA
Date: Wed, 16 Oct 2019 09:57:29 +0000
Message-ID: <08cd5ba1-2c27-97cd-cc93-4e355bad9ded@here.com>
References: <20190926173428.10713-1-f4bug@amsat.org>
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurent.bonnans@here.com; 
x-originating-ip: [131.228.216.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9de2a2d-0436-449f-699f-08d7521f41cd
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM5PR04MB2962:|AM5PR04MB2962:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB29620BE4EBB501A8B145E5E985920@AM5PR04MB2962.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(199004)(189003)(102836004)(110136005)(76176011)(8936002)(25786009)(6436002)(966005)(86362001)(8676002)(81166006)(81156014)(6512007)(6306002)(11346002)(186003)(446003)(316002)(54906003)(2616005)(53546011)(6506007)(26005)(7416002)(476003)(2501003)(486006)(71200400001)(66476007)(66556008)(64756008)(91956017)(36756003)(31686004)(66446008)(305945005)(31696002)(99286004)(76116006)(229853002)(256004)(14454004)(14444005)(6486002)(5660300002)(6116002)(3846002)(71190400001)(66946007)(66066001)(478600001)(6246003)(4326008)(7736002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM5PR04MB2962;
 H:AM5PR04MB3299.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: here.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CKMGE5UQp3BUtKEUR7wxxRuxGJKpYarRdC5FWwiaQJ2wWNAnrce/CYblnoDGT6osLpz3Y5YWw7FWO6sO+1+LNTRwjnECq9jK+ftliEBKej+xGsCQxn3DvS05W7i5L7YGdUwRkRUmmkq/svnE86hDr7U2Vb4k6gZtEVH/xxXAVVtBR5LVVAWPak3KoskEPPLTui1Pf1/sf+dtauh93DPJwtOggdBFvy1rSCmZheshkcPbslEv9K8bBGYMZA/ZiztCmwby0vCjr0xRV0k6zacgTx8v0qeW/Vay+y1LRcaN3t0XN5vPxXa3GY05dMnL83Cz84weMq5Vjm2ktnuaSHOCaUMYXu3lmPLU9/o3TrH5Tnt8NoKBhH8wGbeEEYWaN565iT6nNYT7XSpR/bD7/rzsjL9p/feGCVOE4dQe1l8a/fS/stSg2s9nGf+OlshOYMM1yoFTcqImxb7iaQ5gghEJ+w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C10F73EB70FD84D82BD048B90004E56@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: here.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9de2a2d-0436-449f-699f-08d7521f41cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 09:57:29.5910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d4034cd-7225-4f72-b853-91feaea64919
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HMD5DMi11drv1SVpG/PqVhL5YjoeqQV2wmwX7ZjxFmabxxwa9BOwm3I4TmF4fWzZEY8ZmLqMSGgGqjaK+p62Ax2/zDBwzOtLQreCVjZ08WE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2962
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.133
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?Wm9sdMOhbiBCYWxkYXN6dGk=?= <bztemail@gmail.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Xiang,
 Cheng" <ext-cheng.xiang@here.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gOS8yNi8xOSA3OjM0IFBNLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCg0KPiBI
aSwNCj4NCj4gSSBwcmV2aW91c2x5IHBvc3RlZCBhIFJGQyBmb3IgdGhlIFJhc3BiZXJyeSBQaSA0
Og0KPiBodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL3FlbXUtZGV2ZWxAbm9uZ251Lm9yZy9t
c2c2NDIyNDEuaHRtbA0KPiBhbmQgZ290IGl0IGFsbW9zdCB3b3JraW5nIChib290cyBMaW51eCBr
ZXJuZWwgdG8gdXNlcmxhbmQsIHNhZGx5DQo+IEknbSBzdGlsbCBoYXZpbmcgdGltZW91dCBpc3N1
ZXMgd2l0aCB0aGUgZU1NQyBibG9jaykuDQo+IEhvd2V2ZXIgc2luY2UgaXQgaXMgcXVpdGUgdXNh
YmxlLCBJIHN0YXJ0ZWQgdG8gY2xlYW4gdXAgdG8gcG9zdA0KPiB0aGUgc2VyaWVzIGFuZCByZWFs
aXplZCBpdCBpcyB3YXkgdG9vIGJpZyBmb3IgUGV0ZXIgTWF5ZGVsbCwgc28NCj4gSSdtIGZvbGxv
d2luZyBoaXMgcnVsZSBvZiB0aHVtYiBieSBzcGxpdHRpbmcgaW4gMyBzZXRzIG9mIH4yMA0KPiBm
dW5jdGlvbmFsIHBhdGNoZXMuDQo+DQo+IEluIHRoaXMgZmlyc3Qgc2VyaWVzLCB3ZSBwYXkgb2xk
IGRlYnRzIHdpdGggdGhlc2UgbW9kZWxzLiBMaW51eA0KPiBldm9sdmVkIGFuZCByZWNlbnQga2Vy
bmVscyB3ZXJlIGJhcmVseSB1c2FibGUuIFUtYm9vdCBub3cgdGlja3MsDQo+IExpbnV4IHN0b3Bz
IHRvIE9vcHMgZXZlcnkgc28gYW5kIHRoZW4uIFdlIGNhbiB1c2UgbW9yZSB0aGFuIG9uZQ0KPiBj
b25zb2xlIGF0IGEgdGltZSAodGhpbmsgcHBwZD8pLg0KPg0KPiBUaGVuIHdlIGFkZCB2YXJpb3Vz
IHRlc3RzIHRvIGNvbmZpcm0gb3VyIGVmZm9ydCBtYWRlIHNlbnNlLCBhbmQNCj4gdG8gYXZvaWQg
cmVncmVzc2lvbnMuDQo+DQo+IExhdXJlbnQsIENoZW5nLCBkbyB5b3UgbWluZCB0ZXN0aW5nIG9u
IFUtQm9vdD8NCg0KR3JlYXQsIHRoYW5rcyBhIGxvdCBQaGlsIQ0KDQpXZSd2ZSBtYW5hZ2VkIHRv
IHJ1biB1LWJvb3Qgd2l0aCBzZXJpYWwgb3V0cHV0IGFuZCBzd2l0Y2ggdG8gdGhlIGtlcm5lbCAN
CnJlYWQgZnJvbSB0aGUgc2FtZSBzZCBjYXJkIGltYWdlIHdlIHVzZSBvbiByZWFsIGhhcmR3YXJl
Lg0KDQpJdCBhbHNvIHJlcXVpcmVzIHRoZSBzbWFsbCBoYWNrIHRvIG1ha2UgcWVtdSBzaW11bGF0
ZSB0aGUgZWFybHkgYm9vdCANCnNlcXVlbmNlIGZyb20gdGhlIHJwaSBmaXJtd2FyZSwgZm9sbG93
aW5nIHRoZSBleHBsYW5hdGlvbnMgb2YgUGV0ZXI6DQoNCiDCoMKgwqAgbWtpbWFnZSAtQSBhcm0g
LVQga2VybmVsIC1DIG5vbmUgLU8gbGludXggLWEgMHg4MDAgLWUgMHg4MDAgLWQgDQp1LWJvb3Qu
YmluIHUtYm9vdC5pbWcNCiDCoMKgwqAgcWVtdSAuLi4gLWtlcm5lbCB1LWJvb3QuaW1nIC4uLg0K
DQpBZnRlciB0aGF0LCB3ZSBhcmUgZ2V0dGluZyBrZXJuZWwgcGFuaWNzIGF0IHRoZSBwb2ludCB3
aGVyZSBvdXIgDQppbml0cmFtZnMnIGluaXQgZ2V0IGV4ZWN1dGVkLiBXZSBhcmUgbm90IHlldCBz
dXJlIGFib3V0IHRoZSBleGFjdCANCnJlYXNvbiwgYnV0IHRoYXQncyBzdGlsbCBhIGdyZWF0IGlt
cHJvdmVtZW50Lg0KDQpMYXVyZW50DQoNCj4gSW4gdGhlIG5leHQgcGFydCB3ZSdsbCBpbXByb3Zl
L3VwZGF0ZSB0aGUgTUJveC9Qcm9wZXJ0aWVzIGFuZCB0aGUNCj4gaW50ZXJydXB0IGNvbnRyb2xs
ZXIgYmxvY2tzLg0KPg0KPiBGaW5hbGx5IHRoZSBsYXN0IHBhcnQgYWRkcyB0aGUgcmFzcGk0Lg0K
Pg0KPiBQbGVhc2UgcmV2aWV3Lg0KPg0KPiBSZWdhcmRzLA0KPg0KPiBQaGlsLg0KPg==

