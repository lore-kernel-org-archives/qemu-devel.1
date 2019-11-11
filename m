Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9372C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6166B214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bfmVyxEP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HsFcLvWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6166B214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCtn-0000Ol-BG
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2113f9b6e=Anup.Patel@wdc.com>)
 id 1iUCsT-00086d-H6
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2113f9b6e=Anup.Patel@wdc.com>)
 id 1iUCsR-0000iR-Qu
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:49:21 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2113f9b6e=Anup.Patel@wdc.com>)
 id 1iUCsR-0000gm-2V; Mon, 11 Nov 2019 11:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573490959; x=1605026959;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gzmAtfcxZeZhb+uc6ns8pL1gbJ8hdGAKIQWAS5CMziw=;
 b=bfmVyxEPU1e/YwA+nkILMHil6YFGkdzhb0N/onPnYQ1q241/X17Zjp27
 lYn/rUHEZWivMAMZ3tb9D5bS2dM98tmxPZuXYpexQfGfPRcBxJNa8xrIU
 BBcGAfICLSg09Rxy5ffkQzdFF/PiBo3x9X7m/LDEwNhnZgpcRdlN/Z8Sv
 nswmVdp975/NFz71fgmurOpAog/ALjB6Eu3FQVRHGUup3sRsm6Tdw/qy4
 vTzMM1F2r6s7/DO376NzcLoR0nTZTzT0HlfvbDq4iDpdc7J+BVps293f4
 A/cWsNkr4ghTge/qxzkMJrxwtTNc/2zQt1H98RkhNET4UgvB7w0NH36Rf w==;
IronPort-SDR: pG+pcFgWSQdU+psP22VExcGwx9E8BXi8G4+ps1x/AQfU5q4Nyd3lEGcEdTbE5AKdeKleltjgBM
 DIUBs1g6oRbgOhqU0jtpVFR4IjUIHDkuH77zHLF6xrEJr0AAEo105JrEXE/uLvdwkvSEsO5t4/
 7pofEwzB6RxxZ3JZGHm/gGtWQidVDqzPq2+yyWrE0WMLe0e2RDzh31hO5xtMd6Ab3H2wUr8Wc5
 V9goRAD6AMj1YgLgvGaXr2KSrK4LyjORW4q+RmcqqdEIVbx/5XZY8+RTcPlqkpbi1u7c5jjzlX
 tgM=
X-IronPort-AV: E=Sophos;i="5.68,293,1569254400"; d="scan'208";a="229970371"
Received: from mail-sn1nam02lp2058.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.58])
 by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2019 00:49:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyheF14F/HGYKyAxkl+wJCfDzU2CuwcX+8Hs2Wj4B9A3BtjkV7uKEl2PJ/0FtnLH+t/4VuA2Y59Acb0EoHIqZEWqNekVqWKfkWeRFA2NRPKrfX+7mZrBIWqhzfTVXDmJEWC6q5DUWDLh4U0L1+dNgzdAom8lQDuvSuicOgQ/0jrgvuVuU1kkX6m0LlecnL3LB5v6KIhNEbugFn9BGTURbK0LahqJDSMkdDLJUdd39ByIbuHSViR5EZc0xX4Cr2u2r2y1/3kzAT4VE5vp+nC0lvJ6um/ssYqOZdLrt+9jUYUORHGm4NcHvPLTUSMyCo915jOkazHofUyMMHZjPcvVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzmAtfcxZeZhb+uc6ns8pL1gbJ8hdGAKIQWAS5CMziw=;
 b=muSqdfMufn6eq4PlQNgIITcXKKeGQrtUmRjSsBgBQx2T9kk47Ft5fTHwZ4k5kepC8moFrJ3HmyukMLd/1x+N/groaK1sTno0nEGcjSycb70bHbqlwR+rfNAU6kdN5Pioaj+0t6Qrk2Bl51TZIPoZImLR2lvNPHU6XxpfLikVogeJvVlnYaKp183XaeBRfB3JPdwaRqWwX/+MrwKP+4mB9loMChkyd6inyd5ikBI3tvjU/bjAPP2dpLy5hL0sT57h7hDQo/MWezZi92B48JX45mfje5kKRZla98HnvW5SSe0Pb5jAHhNcu7noFKeqITwcPt+Z4ZETwFLrs4XU985DNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzmAtfcxZeZhb+uc6ns8pL1gbJ8hdGAKIQWAS5CMziw=;
 b=HsFcLvWqEurMeiT6TpeXnQOpXy1EazZXGyuCbgo5N/vzH1xXHDAUcvBo5FAGrHbLTTtlOGAfc7kM7F5lNE8FbQ0DSidknELWVxLQrQNSCdvWNezWlUO97EwJXgHnHb+tF5itAVsDwXjAHMoScIZl9ApM2HKE50PCrihtQwnl2T8=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB7069.namprd04.prod.outlook.com (10.186.147.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 16:49:11 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ac5b:8360:b7a7:f8fd]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ac5b:8360:b7a7:f8fd%6]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 16:49:11 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: RE: [PATCH] riscv/virt: Add syscon reboot and poweroff DT nodes
Thread-Topic: [PATCH] riscv/virt: Add syscon reboot and poweroff DT nodes
Thread-Index: AQHVmJVLWfJWIKb/20SwKjfRTml2CaeF+jgggAAd2gCAABZPkA==
Date: Mon, 11 Nov 2019 16:49:11 +0000
Message-ID: <MN2PR04MB606123216877F480A92D77698D740@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20191111133804.14454-1-anup.patel@wdc.com>
 <MN2PR04MB60618CCC891177DC612532E98D740@MN2PR04MB6061.namprd04.prod.outlook.com>
 <CAEUhbmVCjFHD6HbA1LS2xbbUGjL5goo3dZat_ZXWiTV=50LvTA@mail.gmail.com>
In-Reply-To: <CAEUhbmVCjFHD6HbA1LS2xbbUGjL5goo3dZat_ZXWiTV=50LvTA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [49.207.51.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ac89bf0-25af-4df5-7bf3-08d766c71419
x-ms-traffictypediagnostic: MN2PR04MB7069:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB70690832CFD82C20BA0BFD078D740@MN2PR04MB7069.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(13464003)(199004)(189003)(54906003)(53546011)(186003)(6436002)(86362001)(66446008)(305945005)(55016002)(6116002)(66066001)(66946007)(66476007)(66556008)(76116006)(64756008)(102836004)(256004)(316002)(55236004)(74316002)(6246003)(71200400001)(71190400001)(229853002)(478600001)(7736002)(81156014)(6916009)(7696005)(76176011)(6506007)(9686003)(81166006)(26005)(25786009)(14454004)(33656002)(99286004)(11346002)(476003)(2906002)(4326008)(5660300002)(8676002)(52536014)(446003)(486006)(3846002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB7069;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQWvSGTsPVqMoa51/HCbiDU7b8OjBfnsxq4TujwebcPkg6pxmrGvS9JyewnnCAlMl0gVLrWTFs9sDtQ3UGyRTqpDB5rn5Q7g/Px7fAjYrSzYNzOIMKnqDw4M3fkBo1AzcPGy3yMHUf9E70pTw4K4RSTqAATQhS0JO2CDG3xrLO+iXEEiaSbhPK056HBuZD69Ra1RymuHZG6MkRfpTb/4vpoFN3buS6tXsGSbiDuN71QXuZOY45ZcmTTj++QHTFKjr1K+MHMu6SHSmR2YsQ3iNGar64GZB7i+aYDrdu0Oys/O1/wIm6vMj1bIF6hCyCSFC2ba0EGBfmh7eWEuxecD8H6LrxsIpJLGt13ob2UFQN2dk/4rve9Bddyil7OK/mvcdjM3fxaJajhH59mMHCj+2RE55LVF2xoNmiuYlof8Bsy4kzbWpxVl5VaqORX/x5gb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac89bf0-25af-4df5-7bf3-08d766c71419
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 16:49:11.6514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A44BN8XfjUv+kts4B+Ko6e1jLgqwT1iYjMiR2G6W9/DoN460fFgtZ7DO+zTHuFLaR55KKUxNJzqE7KRBfXLgWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7069
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Christoph Hellwig <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmluIE1lbmcgPGJtZW5n
LmNuQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxMSwgMjAxOSA4OjU4IFBN
DQo+IFRvOiBBbnVwIFBhdGVsIDxBbnVwLlBhdGVsQHdkYy5jb20+DQo+IENjOiBQZXRlciBNYXlk
ZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBBbGlzdGFpciBGcmFuY2lzDQo+IDxBbGlz
dGFpci5GcmFuY2lzQHdkYy5jb20+OyBTYWdhciBLYXJhbmRpa2FyIDxzYWdhcmtAZWVjcy5iZXJr
ZWxleS5lZHU+Ow0KPiBQYWxtZXIgRGFiYmVsdCA8cGFsbWVyQGRhYmJlbHQuY29tPjsgcWVtdS1k
ZXZlbEBub25nbnUub3JnOyBBdGlzaA0KPiBQYXRyYSA8QXRpc2guUGF0cmFAd2RjLmNvbT47IHFl
bXUtcmlzY3ZAbm9uZ251Lm9yZzsgQ2hyaXN0b3BoIEhlbGx3aWcNCj4gPGhjaEBsc3QuZGU+OyBB
bnVwIFBhdGVsIDxhbnVwQGJyYWluZmF1bHQub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBy
aXNjdi92aXJ0OiBBZGQgc3lzY29uIHJlYm9vdCBhbmQgcG93ZXJvZmYgRFQgbm9kZXMNCj4gDQo+
IE9uIE1vbiwgTm92IDExLCAyMDE5IGF0IDk6NDIgUE0gQW51cCBQYXRlbCA8QW51cC5QYXRlbEB3
ZGMuY29tPiB3cm90ZToNCj4gPg0KPiA+IENvcnJlY3QgUGFsbWVyJ3MgZW1haWwgYWRkcmVzcy4N
Cj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEFudXAg
UGF0ZWwNCj4gPiA+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTEsIDIwMTkgNzowOCBQTQ0KPiA+
ID4gVG86IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFBhbG1lciBE
YWJiZWx0DQo+ID4gPiA8cGFsbWVyQHNpZml2ZS5jb20+OyBBbGlzdGFpciBGcmFuY2lzIDxBbGlz
dGFpci5GcmFuY2lzQHdkYy5jb20+Ow0KPiA+ID4gU2FnYXIgS2FyYW5kaWthciA8c2FnYXJrQGVl
Y3MuYmVya2VsZXkuZWR1Pg0KPiA+ID4gQ2M6IEF0aXNoIFBhdHJhIDxBdGlzaC5QYXRyYUB3ZGMu
Y29tPjsgQ2hyaXN0b3BoIEhlbGx3aWcNCj4gPiA+IDxoY2hAbHN0LmRlPjsgQW51cCBQYXRlbCA8
YW51cEBicmFpbmZhdWx0Lm9yZz47DQo+ID4gPiBxZW11LXJpc2N2QG5vbmdudS5vcmc7IHFlbXUt
IGRldmVsQG5vbmdudS5vcmc7IEFudXAgUGF0ZWwNCj4gPiA+IDxBbnVwLlBhdGVsQHdkYy5jb20+
DQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0hdIHJpc2N2L3ZpcnQ6IEFkZCBzeXNjb24gcmVib290IGFu
ZCBwb3dlcm9mZiBEVCBub2Rlcw0KPiA+ID4NCj4gPiA+IFRoZSBTaUZpdmUgdGVzdCBkZXZpY2Ug
Zm91bmQgb24gdmlydCBtYWNoaW5lIGNhbiBiZSB1c2VkIGJ5IGdlbmVyaWMNCj4gPiA+IHN5c2Nv
biByZWJvb3QgYW5kIHBvd2Vyb2ZmIGRyaXZlcnMgYXZhaWxhYmxlIGluIExpbnV4IGtlcm5lbC4N
Cj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoIHVwZGF0ZXMgRkRUIGdlbmVyYXRpb24gaW4gdmlydCBt
YWNoaW5lIHNvIHRoYXQgTGludXgNCj4gPiA+IGtlcm5lbCBjYW4gcHJvYmUgYW5kIHVzZSBnZW5l
cmljIHN5c2NvbiBkcml2ZXJzLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFudXAgUGF0
ZWwgPGFudXAucGF0ZWxAd2RjLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGh3L3Jpc2N2L3ZpcnQu
YyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMjQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0t
Z2l0IGEvaHcvcmlzY3YvdmlydC5jIGIvaHcvcmlzY3YvdmlydC5jIGluZGV4DQo+ID4gPiBjYzhm
MzExZTZiLi5mZGZhMzU5NzEzDQo+ID4gPiAxMDA2NDQNCj4gPiA+IC0tLSBhL2h3L3Jpc2N2L3Zp
cnQuYw0KPiA+ID4gKysrIGIvaHcvcmlzY3YvdmlydC5jDQo+ID4gPiBAQCAtMTgyLDExICsxODIs
MTEgQEAgc3RhdGljIHZvaWQgY3JlYXRlX2ZkdChSSVNDVlZpcnRTdGF0ZSAqcywNCj4gPiA+IGNv
bnN0IHN0cnVjdCBNZW1tYXBFbnRyeSAqbWVtbWFwLA0KPiA+ID4gICAgICB1aW50NjRfdCBtZW1f
c2l6ZSwgY29uc3QgY2hhciAqY21kbGluZSkgIHsNCj4gPiA+ICAgICAgdm9pZCAqZmR0Ow0KPiA+
ID4gLSAgICBpbnQgY3B1Ow0KPiA+ID4gKyAgICBpbnQgY3B1LCBpOw0KPiA+ID4gICAgICB1aW50
MzJfdCAqY2VsbHM7DQo+ID4gPiAgICAgIGNoYXIgKm5vZGVuYW1lOw0KPiA+ID4gLSAgICB1aW50
MzJfdCBwbGljX3BoYW5kbGUsIHBoYW5kbGUgPSAxOw0KPiA+ID4gLSAgICBpbnQgaTsNCj4gPiA+
ICsgICAgY29uc3QgY2hhciB0ZXN0X2NvbXBhdFtdID0gInNpZml2ZSx0ZXN0MFwwc3lzY29uIjsN
Cj4gPiA+ICsgICAgdWludDMyX3QgcGxpY19waGFuZGxlLCB0ZXN0X3BoYW5kbGUsIHBoYW5kbGUg
PSAxOw0KPiA+ID4gICAgICBod2FkZHIgZmxhc2hzaXplID0gdmlydF9tZW1tYXBbVklSVF9GTEFT
SF0uc2l6ZSAvIDI7DQo+ID4gPiAgICAgIGh3YWRkciBmbGFzaGJhc2UgPSB2aXJ0X21lbW1hcFtW
SVJUX0ZMQVNIXS5iYXNlOw0KPiA+ID4NCj4gPiA+IEBAIC0zNTYsMTMgKzM1NiwzMyBAQCBzdGF0
aWMgdm9pZCBjcmVhdGVfZmR0KFJJU0NWVmlydFN0YXRlICpzLA0KPiA+ID4gY29uc3Qgc3RydWN0
IE1lbW1hcEVudHJ5ICptZW1tYXAsDQo+ID4gPiAgICAgIGNyZWF0ZV9wY2llX2lycV9tYXAoZmR0
LCBub2RlbmFtZSwgcGxpY19waGFuZGxlKTsNCj4gPiA+ICAgICAgZ19mcmVlKG5vZGVuYW1lKTsN
Cj4gPiA+DQo+ID4gPiArICAgIHRlc3RfcGhhbmRsZSA9IHBoYW5kbGUrKzsNCj4gPiA+ICAgICAg
bm9kZW5hbWUgPSBnX3N0cmR1cF9wcmludGYoIi90ZXN0QCVseCIsDQo+ID4gPiAgICAgICAgICAo
bG9uZyltZW1tYXBbVklSVF9URVNUXS5iYXNlKTsNCj4gPiA+ICAgICAgcWVtdV9mZHRfYWRkX3N1
Ym5vZGUoZmR0LCBub2RlbmFtZSk7DQo+ID4gPiAtICAgIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5n
KGZkdCwgbm9kZW5hbWUsICJjb21wYXRpYmxlIiwNCj4gInNpZml2ZSx0ZXN0MCIpOw0KPiA+ID4g
KyAgICBxZW11X2ZkdF9zZXRwcm9wKGZkdCwgbm9kZW5hbWUsICJjb21wYXRpYmxlIiwNCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICB0ZXN0X2NvbXBhdCwgc2l6ZW9mKHRlc3RfY29tcGF0KSk7
DQo+ID4gPiAgICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbHMoZmR0LCBub2RlbmFtZSwgInJlZyIs
DQo+ID4gPiAgICAgICAgICAweDAsIG1lbW1hcFtWSVJUX1RFU1RdLmJhc2UsDQo+ID4gPiAgICAg
ICAgICAweDAsIG1lbW1hcFtWSVJUX1RFU1RdLnNpemUpOw0KPiA+ID4gKyAgICBxZW11X2ZkdF9z
ZXRwcm9wX2NlbGwoZmR0LCBub2RlbmFtZSwgInBoYW5kbGUiLCB0ZXN0X3BoYW5kbGUpOw0KPiA+
ID4gKyAgICB0ZXN0X3BoYW5kbGUgPSBxZW11X2ZkdF9nZXRfcGhhbmRsZShmZHQsIG5vZGVuYW1l
KTsNCj4gDQo+IElzIHRoaXMgbmVjZXNzYXJ5Pw0KDQpJIHdhcyBkb3VidGZ1bCBhYm91dCB0aGlz
IGxpbmUgbXlzZWxmIGJ1dCBJIHRyaWVkIHRvIGtlZXAgY29kZQ0KY29uc2lzdGVudCB3aXRoIG90
aGVyIERUIG5vZGVzIChzdWNoIGFzIFBMSUMpLg0KDQpSZWdhcmRzLA0KQW51cA0KDQo+IA0KPiA+
ID4gKyAgICBnX2ZyZWUobm9kZW5hbWUpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICBub2RlbmFtZSA9
IGdfc3RyZHVwX3ByaW50ZigiL3JlYm9vdCIpOw0KPiA+ID4gKyAgICBxZW11X2ZkdF9hZGRfc3Vi
bm9kZShmZHQsIG5vZGVuYW1lKTsNCj4gPiA+ICsgICAgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmco
ZmR0LCBub2RlbmFtZSwgImNvbXBhdGlibGUiLCAic3lzY29uLQ0KPiA+ID4gcmVib290Iik7DQo+
ID4gPiArICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsIG5vZGVuYW1lLCAicmVnbWFwIiwg
dGVzdF9waGFuZGxlKTsNCj4gPiA+ICsgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgbm9k
ZW5hbWUsICJvZmZzZXQiLCAweDApOw0KPiA+ID4gKyAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwo
ZmR0LCBub2RlbmFtZSwgInZhbHVlIiwgRklOSVNIRVJfUkVTRVQpOw0KPiA+ID4gKyAgICBnX2Zy
ZWUobm9kZW5hbWUpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICBub2RlbmFtZSA9IGdfc3RyZHVwX3By
aW50ZigiL3Bvd2Vyb2ZmIik7DQo+ID4gPiArICAgIHFlbXVfZmR0X2FkZF9zdWJub2RlKGZkdCwg
bm9kZW5hbWUpOw0KPiA+ID4gKyAgICBxZW11X2ZkdF9zZXRwcm9wX3N0cmluZyhmZHQsIG5vZGVu
YW1lLCAiY29tcGF0aWJsZSIsICJzeXNjb24tDQo+ID4gPiBwb3dlcm9mZiIpOw0KPiA+ID4gKyAg
ICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCBub2RlbmFtZSwgInJlZ21hcCIsIHRlc3RfcGhh
bmRsZSk7DQo+ID4gPiArICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsIG5vZGVuYW1lLCAi
b2Zmc2V0IiwgMHgwKTsNCj4gPiA+ICsgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgbm9k
ZW5hbWUsICJ2YWx1ZSIsIEZJTklTSEVSX1BBU1MpOw0KPiA+ID4gICAgICBnX2ZyZWUobm9kZW5h
bWUpOw0KPiA+ID4NCj4gPiA+ICAgICAgbm9kZW5hbWUgPSBnX3N0cmR1cF9wcmludGYoIi91YXJ0
QCVseCIsDQo+ID4gPiAtLQ0KPiANCj4gUmVnYXJkcywNCj4gQmluDQo=

