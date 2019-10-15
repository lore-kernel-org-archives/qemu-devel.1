Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7B0C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08652064B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cQI9sZ+A";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jaCAvw1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08652064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKIJw-0008DH-Ne
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 04:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1843cfbdc=Anup.Patel@wdc.com>)
 id 1iKIIo-0006u7-1j
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1843cfbdc=Anup.Patel@wdc.com>)
 id 1iKIIm-0004Oc-Ot
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:35:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49833)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1843cfbdc=Anup.Patel@wdc.com>)
 id 1iKIIi-0004Ik-OT; Tue, 15 Oct 2019 04:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571128529; x=1602664529;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=05ZaGxn9gfD8Ho28WBUjaQVHahhbgzpw8jx2PKLYZlA=;
 b=cQI9sZ+A3kQImsk4BLNlTI8BUQ1gEKZX19oGGpC/3Ht+FX1dNUbP1HjP
 MwtDn+IY11zxqBNqnXbbTrcDBp/VTtWkn2Rsh7101XQR36qMP0oqB6vhv
 GZga0Ny8oiZdoE7u9wJ83ZauQm+bmKEyZ42GBKeuoMqlo30RFmiOR7YT8
 VknfXhchqa0l32NNSGaGGzWWSk97mXGx1A03Y1KzN6t5Fgx5h6uQUOB6T
 8snKLuwQudqy4vGr9txAKXPSB796PSElFFv+9zSphEWuWAl7nltQgbwS2
 gfewbAqaJm/3crQ9JyBVj7CuvFwfQU4VkByFGBJbEaCyzKAdI1RY/l7or Q==;
IronPort-SDR: zJwe1T8S0AI+2+JTE7zSi1PclKdxIBFlZCAOESDmt/s1oJWZHrmxCvaaUH4/wzOcQ8X/hFQ1qV
 JtP0V7P67+wvPkCycH3GmkS6jUigOLWCIMLMvtt1g3aiZk/gI1AEjGIDP8VuPzkuFRjiRacWGI
 QwR9n22vA6v4rB1qOKVVOYEvv1aJOQKUvDFv9JcR6bc67AJ+k6goc7LUZ1UmX75j9qyyaZjqJk
 0pFuvjY6W3Mow25D5qUgjGo6BV3aA1CMwenMrTlaaGVOGa9Hh2yO7IsovT7QEKLKnrQwV6qvZ0
 kZU=
X-IronPort-AV: E=Sophos;i="5.67,298,1566835200"; d="scan'208";a="124990110"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
 by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2019 16:35:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsdttBxR2H5SX6kHZm7tlMKjL/q2WwxG298wBrmsbXDXaFpDvdGmi3posBHxoEFwbwb/yyvRDbro+YdlXiqW00j+eEeTt/rw3i413uQy5pL8auC1b1BaoH+K92lA2xzzGzc9/xAOAg0yH9kGsT8L8ZL15wa4sN8IDkQs7JfvNwR0yuGZjNggsAmUAtC3+3JIhUhIGqOeMNPPxVT/+7nIiTj2P9tyZnL8NntSo61vfYYA4h1q55qaGzK9Zw+b5ut16PpvGwyU/x/tPoOPHRbQJbsRBR/JRhyFcIc6YqBLfbP5l5M8UbBXygPxJbe2+YNQqqpk4sQmOQH6WWFYIGQQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jfc6udNJNe9SwCUlMDNCIxBO9/c5cHRNtQiajaLmRSs=;
 b=cqtcGgGF6ax3NjsbuehBjtOcMbH9Xu7zQ9HLaIHN8471N+IV9BGy0oIpry07H6LPfARjWERjFt7f/GDEarzJW3gMEZRhH8GdA4DuN5B33rW0Sx8aOdVJwshtYrW5P7BJ7FkFGRN4RhjVvpWUsDcpMoAwi4ia3mRWNzy5xQrZ5sq08e71N1+Q3OpDl71C79TfwoghtMi5YSs+zlRbShI6GbSYnbmuO9idlVibJorb71VcZDua1hxX23nOYhkuCpLhEnOfIoRkpGpUygfAl/Mmi8iRAsQn6oVk2f9KIfqHWyoIx9m4WebnTRcq/3A2rN103TvUzTdsznx7aY9ChC9z7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jfc6udNJNe9SwCUlMDNCIxBO9/c5cHRNtQiajaLmRSs=;
 b=jaCAvw1z7bfHOpc9ODHcubFojKuVT3Nz5GBe6CkxbqSvgTqMt8hWEMgls7pN1Y3Qh59LFTIPOn9j5bKXi9b0GwmAOZvT5Mm+dUBOCLcDqc8OwHyauMfa8fBFJ71SjFXNCuRuaG3C3Zi3gnhYE46gTtdbDFqb8fXaeUSE6U4QqsE=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB7071.namprd04.prod.outlook.com (10.186.146.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Tue, 15 Oct 2019 08:35:24 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a%7]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 08:35:24 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v3 0/2] RTC support for QEMU RISC-V virt machine
Thread-Topic: [PATCH v3 0/2] RTC support for QEMU RISC-V virt machine
Thread-Index: AQHVgzN8aIwWSXk02EWLNM6K8aNiZA==
Date: Tue, 15 Oct 2019 08:35:23 +0000
Message-ID: <20191015083459.76959-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::22) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5ce4bb3-b590-4fbf-a093-08d7514a9f0f
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR04MB7071:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB7071D14FA1E0CA4F04D71E308D930@MN2PR04MB7071.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(189003)(199004)(26005)(71200400001)(256004)(14444005)(66946007)(386003)(6506007)(66476007)(66556008)(64756008)(66446008)(14454004)(966005)(36756003)(71190400001)(102836004)(186003)(478600001)(44832011)(66066001)(476003)(486006)(2616005)(2906002)(25786009)(5660300002)(86362001)(81166006)(3846002)(316002)(50226002)(305945005)(1076003)(4326008)(2171002)(6306002)(6512007)(6486002)(54906003)(8676002)(8936002)(110136005)(7736002)(52116002)(99286004)(6116002)(6436002)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB7071;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a2X5VXuiY58jv72Tu4ap3y9X4/IZyeSFKo1YtzZOVXgFszus+0P2+TICBKZm69MPVZE1/vUgDLYSu41IOg3CZeclpQ75io+OCfq1ukuUdk1KLScCbGClqoHGWzCTyNie87y/5pDBjNlYguFIOnqw4CyhlOo916+DWviwPFF3SmsWUiCZ0B5wS/iFUp9jl0UR6F3ahCu3r3DSOCSdSua3A+A/dl6d9+ECt4ibZBDymNjYMPqUucG2EhMUco3X0roNKNrvxWK1DLuxmNjMHfOM8twmkQ0M9eciMPTaAkVHOTxIj6xcjzYrp6ptNv1Ppfid/Lx7QCzJEmcwlr51HUgbtmiB3CAkza7C3D0j84PdMc9mHXnoK3yCkNgn7T4kn93/HMsEUUGyq0Y+kP+CHvmS54a0+cpJYU+2pCYFvM6XQS1DpEPuZXiW9RmQ3yYEdgHISk2E2QqInFHquKGCSQdpTQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B27D4AAFCE41544AB71EEEFFDFEBF98@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ce4bb3-b590-4fbf-a093-08d7514a9f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 08:35:23.8493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZhC4umuNKCpbz3JDVEl3jpe8GiEAhUSjd6t+u3lIOsbAnJVvd81pTfxCUp/+UCEn5n6w2dQbUQasOrBLsRTWcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7071
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.141
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
Cc: Atish Patra <Atish.Patra@wdc.com>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds RTC device to QEMU RISC-V virt machine. We have
selected Goldfish RTC device model for this. It's a pretty simple
synthetic device with few MMIO registers and no dependency external
clock. The driver for Goldfish RTC is already available in Linux so
we just need to enable it in Kconfig for RISCV and also update Linux
defconfigs.

We have tested this series with Linux-5.4-rc1 plus defconfig changes
available in 'goldfish_rtc_v2' branch of:
https://github.com/avpatel/linux.git

Changes since v2:
 - Rebased patches on recent RTC refactoring by Philippe Mathieu-Daud??
   (Refer, https://patchew.org/QEMU/20191003230404.19384-1-philmd@redhat.co=
m/)

Changes since v1:
 - Implemented VMState save/restore for Goldfish RTC

Anup Patel (2):
  hw: timer: Add Goldfish RTC device
  riscv: virt: Use Goldfish RTC device

 hw/riscv/Kconfig                |   1 +
 hw/riscv/virt.c                 |  15 ++
 hw/rtc/Kconfig                  |   3 +
 hw/rtc/Makefile.objs            |   1 +
 hw/rtc/goldfish_rtc.c           | 278 ++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h         |   2 +
 include/hw/timer/goldfish_rtc.h |  46 ++++++
 7 files changed, 346 insertions(+)
 create mode 100644 hw/rtc/goldfish_rtc.c
 create mode 100644 include/hw/timer/goldfish_rtc.h

--
2.17.1

