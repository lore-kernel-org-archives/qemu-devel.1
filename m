Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E6CC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC658217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="knVK5TTR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WI7PJgJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC658217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSK14-0000gS-0y
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSJvl-0004pa-Rj
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSJvk-00065k-Nq
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:56:57 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:48677)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSJvi-00063q-9c; Wed, 06 Nov 2019 06:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573041414; x=1604577414;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+4DVSZF1OwyKe+oveoGbmdIZHMMAa7gf6OZSpH/u0Js=;
 b=knVK5TTROF0zyI+Neawt9RLi+ujfpA5wWqfthx2pEcfUFDl84hhh+4PU
 ECw2IH4jbbZZsggVXimhEMoVFTdBkFY7GYEVMwQ+i4XNFVhuYEoFS8p2c
 Rn3vbJcbl2ec8n6uEfritUXmJVoEFzdkLT5BdpTKUT+k3kq1pTEOx/dim
 Rk9sDheoszdqmw8yluudstkHoJdswBJ8sel3I8F1dTOoYlFKwcI7NYtot
 uafeohqD1C2aT4bLVfHVZ80TK2CcwnOr8wtX1kFlxe+FECq/gV+EBK6ek
 jpALm4RZORLzF2u8Ip+BdhIC/o8/En6Tm86aq7QCfEWxbv4V9iHKAK5UM w==;
IronPort-SDR: VpgPLlZfsrN3t3e1SYOQdqLKCgKzNaU/BV04+pM9AoxnMdswKxiMTWdMVc1jhEKMGbm6NR/6Xr
 9sBIGfdmeJ/Rh6Xp0ZbqMMkLzI6uVek3vv1d0hkkoVS/XQWKlnMwBhpDuNz42ZMxcOgzjtoRrj
 5lYBdbE7XiJE0t2v6kxexQRi7xRRD75Wa8BwqMht4bKtI6v06pkFuBWdH3mkBX8Lk9sQzOE+IP
 dgl0athhG2GJYE2LIfNi7g0UVnuGMUb6y/tDjn/SQCN8FgbA+g8PzsUEalXByMDPOPnuCOCgpY
 Qf4=
X-IronPort-AV: E=Sophos;i="5.68,274,1569254400"; d="scan'208";a="123881597"
Received: from mail-dm3nam05lp2051.outbound.protection.outlook.com (HELO
 NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.51])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2019 19:56:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1RBuRIM9mbsJDCCSh9r6cA6f1lk11WkADxLzhQlzB37DZZ2daIOlNe2st4LaucmJi67rdDRybGZ9FRbRa5H6zGrvW3qhm4nSaZ/5Gk07lPk5Np9+qdVlLKXtx3g5sIb/tdCynVnpvOqaHMnVz4M8/aFmAnX+LAJwUNQG6UaEAD6SoT77uLLeQ9jG8rNyKT8B8Lc9w9s+HP4Cn7jE7hHDGvjkCKu3l2KzirbECDD4um8M41l5u89RNfOj/C595q2UDGcc4fFRNRHj/Og+dMa+gv70zQhXWxWlbqs2vtc7jpuCAhubsXG4xB7qt5gBbh47QYzgiiQtVGfE5KIdMBZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4DVSZF1OwyKe+oveoGbmdIZHMMAa7gf6OZSpH/u0Js=;
 b=jjXS6jAd3cHegA/ov9kuTN/1SpQA3gqAHY6x1Mdr9LZvM2rEGkfqALmX7dOGQLLZptgYW5G9wPt2SpXJ2GYYSBT4qmc+TMyFSzchKTiSOyGAPEg1+KYtpJZcE2r47Ztk0skqk//X1ABdm4XZNVD+DHyZSWsJFmgrRYq/eAku0aW+pSN7T0yF2hb+ODtjRaCnW2BzizsUPb48FmL+M508vclcrwzziOCJKd2amuGXOa0TJgw5wdukoWUBv12gWNeNrR61WUGYyh1sD8rtEoopCMkRBgj2nTGxp+yCd5LbGNssOlck1fFXIkNjw3hEdRU+x7QauP8pd74PL6/YhG1kYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4DVSZF1OwyKe+oveoGbmdIZHMMAa7gf6OZSpH/u0Js=;
 b=WI7PJgJpohFq9XDZ7csqvXSnzB0MfikfYxTShFt3R8YusHu9xy9+ZkuasRCQNeroHNLuzo77zvMnZ/kODHiUXGnLzZ9lHvpg/ygxIQ0C21wRaGZSKGuh0OKswsZjWwHfwPWxYeuonYq39bVMxeW0CiuhMz2Lrq91hZlFN/44Le8=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6080.namprd04.prod.outlook.com (20.178.247.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 11:56:50 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::b181:29c4:fcfb:7a0a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::b181:29c4:fcfb:7a0a%7]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 11:56:50 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v8 3/3] MAINTAINERS: Add maintainer entry for Goldfish RTC
Thread-Topic: [PATCH v8 3/3] MAINTAINERS: Add maintainer entry for Goldfish RTC
Thread-Index: AQHVlJlGSNz4s7KScUOMdkpk039ulQ==
Date: Wed, 6 Nov 2019 11:56:50 +0000
Message-ID: <20191106115602.74299-4-anup.patel@wdc.com>
References: <20191106115602.74299-1-anup.patel@wdc.com>
In-Reply-To: <20191106115602.74299-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::11) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.25.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 873afeba-f9c7-470d-d928-08d762b06850
x-ms-traffictypediagnostic: MN2PR04MB6080:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6080CF2B02FE586CF0D967C88D790@MN2PR04MB6080.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(9456002)(2616005)(6506007)(99286004)(52116002)(55236004)(102836004)(186003)(36756003)(76176011)(66556008)(81156014)(8676002)(26005)(8936002)(6116002)(50226002)(476003)(256004)(2171002)(386003)(6512007)(4326008)(44832011)(71200400001)(71190400001)(7736002)(2906002)(5660300002)(14454004)(6486002)(1076003)(3846002)(446003)(486006)(11346002)(66946007)(4744005)(66476007)(64756008)(110136005)(54906003)(81166006)(316002)(86362001)(66066001)(478600001)(25786009)(66446008)(6436002)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6080;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HksotSIY2XEnC/P0oUpqtnA0mu3rvDwxbSsgXUT5dad0b8ySQhXfPgC5fSX10Yn6wLF9C6PLo71PeCALgxI7hj/WWKazzf5/kHzXRNm0GPkLqrf0EzLo7woF2BTc9iUN+0BEdCNI8vi1WGKJmiF5jZlhQefcu+zl5iKctSCvpje59hv5U8oSrmkg+aOg4G4sJmU+K0DQc+KP8inKofe+39WkOQ/7nPbwsW0U0e2cAqXcBaLmORqop4wajQD9MX3yrCggddLPhtg/j4qT3ozh7h+mqpdpbMIj5vLFJtbpW3rLsELh4xsY4NLLP0N99K3GkuOwUXfiASEE2iTQUEYx/JaAwGvyCfCDeonxJWj2EY7ZGkzUGih3B4dPpf9LOp56gLMKYYroFgBS7/yqw4e9B77ckeTkRT4v0uBuKVKb+Mq5DcpuQublcL7gLc/PMvdA
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9713CD3A72257F47A53DDA3342AB1B46@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873afeba-f9c7-470d-d928-08d762b06850
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 11:56:50.5286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UmImUvGWZZV59UJQrqzghjcMcsDfMtD+qoVtLNeEWhqdcH8ksfPy568bC+QcaqU6EgxH3fUVO8PwxAOWm+1sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6080
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
 Anup Patel <anup@brainfault.org>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Philippe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add myself as Goldfish RTC maintainer until someone else is
willing to maintain it.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2a68555ae..492c0d1baa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -558,6 +558,14 @@ F: include/hw/arm/digic.h
 F: hw/*/digic*
 F: include/hw/*/digic*
=20
+Goldfish RTC
+M: Anup Patel <anup.patel@wdc.com>
+M: Alistair Francis <Alistair.Francis@wdc.com>
+L: qemu-riscv@nongnu.org
+S: Maintained
+F: hw/rtc/goldfish_rtc.c
+F: include/hw/rtc/goldfish_rtc.h
+
 Gumstix
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Philippe Mathieu-Daud?? <f4bug@amsat.org>
--=20
2.17.1


