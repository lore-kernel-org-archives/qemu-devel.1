Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2DEC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1A02187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SUiR3V6d";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hwiPLnY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1A02187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2VKy-0005AR-Qm
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 02:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3066d6cb9=Anup.Patel@wdc.com>)
 id 1j2VIp-0002GY-Hw
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3066d6cb9=Anup.Patel@wdc.com>)
 id 1j2VIo-0004Id-Iy
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:22:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3066d6cb9=Anup.Patel@wdc.com>)
 id 1j2VIm-0004FI-6a; Fri, 14 Feb 2020 02:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581664937; x=1613200937;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=b0pmzSsDhT7gX+NebTupjIXf2AnJNhohnxsqzoXtTic=;
 b=SUiR3V6dmEdz1rI1ttqRodiYMS9gTokwe2mYcuJ8LekVP9HlA8Oh5owY
 z25AIDImsy5qPaeAD4KHbelP+dgzLtKUsznATpD7Bov0TjBSIa+cCJmI8
 xR9GcusyFGe7MjaEPlP2vOYAQLBVx5ZedMM4BMQull6l3HDxLVn/7SYJd
 ps87Uxwnzha8lPAY9fGlkui7BxCJ6bRVdsve92uzZ0JYyU67/XpCK6lFR
 WBAtyh5v7w/8veFWP66I0CVgaET9eL1vJcR2q30fVsZm4q7MpJ7Wne2wK
 +DDeOo2ycat+ERKCrLG/WW6JjW+tgiLQcxktRU1NYoa9yujTcfaZ65YNc w==;
IronPort-SDR: AZ7M/Xw6vQHEBRWqXJXTft3xPWPzPcrwHhWWMC4cafaIbIK1dBafaCPsXwAMMEZ6UJxIa037Gn
 sQts9f2O48JN8SPf/yfunLngjxdLkmCcudy9+bsw468MbB0Fy3VW7qdjPCiWFtU5/aEbqcFduI
 Sd2SAt7qREPbqHOBTGukgZij09UH2nPyN2V2GpljeljMhUfZcP5uLEHguVS/6i/VwVRP79bXIc
 RwhIGLPT5fGzVbpGW9A6TUTlPKeEkpy2LVI5+XNECFWipq3Dgkgen800FjPSzvzuA+fgmwhLE5
 Kuo=
X-IronPort-AV: E=Sophos;i="5.70,439,1574092800"; d="scan'208";a="131289875"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2020 15:22:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POEGboh7xZSgJpgfDNxNI6tIRm+YAwoPDGcvfdLyyIqlhCOdgkLKyhA2to7CG3YMp29G5JC+q6JcZEj4Mv1b6tySZoxgj6sZgfZqeK0J2f7u2GRIZRT5lCTrGFsz3y+2SYzM5Q8epVwgOQxOTx1AySHqYRM86Om0fBGJU/FZ6RkE/mKM/EJK83kIIONIDcGsVVKQ/q4n/gjWz9GMZDsxn0UqAfPl1LWH3R7H/oT8+a3KNog926lNLQxvUtNqM359fbtGN3zbfh58hSQHUsE+8fHQAX6twB2YTBZaQk0/8pODbNheCBi9z+VgwrjXM5kdM+NLhKqqy6YDD5PfaXgHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGk173WuRUlWDVEV2Da9UJ3AE1WKlQ9G9E1ZfLWaCaE=;
 b=gk+4sP/LMJL++4hL0WKJsAGiWd+sh0hbTMKPwhgbmT9agOVWXPDHHLc3GV5FqJaWNiUrFfK3UQPi4hBLRjylWHS07FQ+5CcuNU7eGYNK8fgTBcFOWxhkHSaNqV8sqwNFVn2gVO/zcpmDgMzWIJ3En3cuCdDPZU9r99jA8EoP8fUo0FR/U5SBxtvnRmHjRE8ReU9spjTgwtB/cztOGJLkhtAv3GvlFGAj7K+y3RBx6vpvqQQESlHq2Xa5In8HDLc/Ri8oA0O6w52zsVPl6Y5udwVE7hm37hMKYxpjQPvovPBW4uDQ4TP/M4dc75UsTR6y2LrVZ3YEPlbT+9vlUG5GhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGk173WuRUlWDVEV2Da9UJ3AE1WKlQ9G9E1ZfLWaCaE=;
 b=hwiPLnY87ZsagIcJg7v7ImXaFQBApHi/4JGljoYOR2WsrCpgJ0FCA/wSwQnjekcAqCKdf05lERduFYR7sP7NlgVDA6sYWDhHi3cwl+LtNsRiaLhuoyU13N5utAo3CO09P54kB5ZMGAjdzWR8U7kqccqj10a6aGPxO/P7MndmMLg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6288.namprd04.prod.outlook.com (52.132.169.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Fri, 14 Feb 2020 07:22:13 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89%7]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 07:22:13 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 3/3] hw/riscv/spike: Allow more than one CPUs
Date: Fri, 14 Feb 2020 12:51:27 +0530
Message-Id: <20200214072127.64330-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214072127.64330-1-anup.patel@wdc.com>
References: <20200214072127.64330-1-anup.patel@wdc.com>
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::25) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
MIME-Version: 1.0
Received: from wdc.com (106.51.31.230) by
 MA1PR0101CA0015.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend
 Transport; Fri, 14 Feb 2020 07:22:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [106.51.31.230]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b45c916-a3da-4008-2378-08d7b11e9c72
X-MS-TrafficTypeDiagnostic: MN2PR04MB6288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB628895C8E9B8CD594770B8E68D150@MN2PR04MB6288.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(110136005)(478600001)(54906003)(316002)(52116002)(1076003)(7696005)(66946007)(36756003)(16526019)(8676002)(4326008)(4744005)(81156014)(1006002)(44832011)(55236004)(8886007)(2906002)(956004)(26005)(66556008)(66476007)(8936002)(2616005)(5660300002)(86362001)(186003)(55016002)(81166006)(6666004)(32040200004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6288;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2oVMRC2/mQGjO9IS/ZVeMb94q9zRQ0kNJnjOCqW1nkATIL22RlR36e4iS47nSQRV5hqtzyjMmtPBBBl2TbU4V7CYahhNxfmUcqvsEogG+fqfnCdm5/fr/zORWjbEGGpyK538jxlirwuUx/IzRwFS3Mw6+s7itz/Bh5Tr0ONpa7OPEmEFo8QrJ1GDyg06sw4irihG2F2r/F5+sjWtUB8wdK5txDPt53K+oX8iq2L+WnfvqFHeflr8Pew2Dj2055d6LIv3GQYqmpNKwtqIHo7pWOmsVx1SvJG+H1W+wU4GEzaS0Oac3IHKE9qGM99aGtiQOrdk85vIZQGBDBywaQyW1Jf+qk+hvQ/DXrdgFzzfrZ06dG9YUGUv80Ao2FAyd9+nfwun8io6Bs6vm41bOeJOUJ7HCZzDyiy66cjN+hMJOFbh6krz8ULd/TCeqeMYBywtow8WDG9c1R/IoCJa+tSyQPH5LNeACOWCa51HjIitc1iParHogEMg/W5f3yepU/9
X-MS-Exchange-AntiSpam-MessageData: ku/s4C4uI+7ezBZYSpud+MG+qGYll8jEIFmRvCrHU90cRRzu7nnKvfUIqhpY23yqCF42f7YHmxbof3gI6rHxm3fYGN+HqgF+IXjyFVtErOKEfaFR8TFH1PXHs5n/UAWA9LkRtS+INvxbPnOAnDtTmQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b45c916-a3da-4008-2378-08d7b11e9c72
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 07:22:13.2013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3H93okejwB4ryZi+GLlLiywC/5mvB94U4CbaHcqkjVEIsXBX0jW0inCAa4ogxxYgSLJpJ/mLBCnTM0JF1n9jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6288
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, the upstream Spike ISA simulator allows more than
one CPUs so we update QEMU Spike machine on similar lines to
allow more than one CPUs.

The maximum number of CPUs for QEMU Spike machine is kept
same as QEMU Virt machine.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/spike.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 060a86f922..1eac0d9a83 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -469,7 +469,7 @@ static void spike_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Spike Board";
     mc->init = spike_board_init;
-    mc->max_cpus = 1;
+    mc->max_cpus = 8;
     mc->is_default = 1;
     mc->default_cpu_type = SPIKE_V1_10_0_CPU;
 }
-- 
2.17.1


