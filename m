Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302B6C3524A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 13:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8D420658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 13:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PZVMkt+y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KVwp6ru4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8D420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyFYb-0003im-4q
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 08:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=29495a510=Anup.Patel@wdc.com>)
 id 1iyFX1-0001Ik-UW
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 08:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=29495a510=Anup.Patel@wdc.com>)
 id 1iyFX0-0004Nt-Kl
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 08:43:23 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23407)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=29495a510=Anup.Patel@wdc.com>)
 id 1iyFWx-0004Lh-Ka; Sun, 02 Feb 2020 08:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580650999; x=1612186999;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=+RsXoSggij9UK4OY2xLBNvHTIdzJ4C4zMTlalL9Wk44=;
 b=PZVMkt+y2XOa07/AFXZMVsIhhoUgqCMl4Mj6jcHtk2C8Llmu+ROLRy9X
 psjwbrfrIejk5vfKsCd4LujU1/nZSJwvD4tjN95wucBqRMXh8QIvHb1sQ
 4Qbg2N/aDSqB543KTUxC8KQar046Wo1h6Psukfn0K81yu/cvd336y44nx
 mEMAHmLk+ao9qk8zt8L+JI84Gk0zDL3mGGvt8am275936WWl0hP5sAze2
 BYl4ZxvrgiDLGIlZ85BDZeS7ShVRieQLSQbYrjD/Vq1YrohTkmIfsplb8
 mqHJGGQ7Iygm+3bU3GI/duyFpD4hNXAfV2/giOTg+oDKNhr1hDLpVnY+L g==;
IronPort-SDR: pUT0DK1p0vyo7IJQc1awh5D5KCcg0mLfq9oxMSko87qiVdCL21tfoY5PRw/Kpo6SP+YARgFJtb
 dDU6NQrnfir6Az1FD9mMvFdHvoKcbDmfi3YtSDC3f522/GVviioYdxJdeRrGHaAQrkXW1yofc4
 WlRqcvt2UREeOqoJU0a6HAnaXto818Jgf2XhftI6a/2f4dc40qn4nOQSPFrKafDI5abwbwIAoT
 WpZ2Pw5Kvv4MRuLw8BtdxHjyn2ynjqjT1XoqiHKgq9Jg9/wMV0r/L3RRqJbYwb6a/6SLgUwQxA
 3QA=
X-IronPort-AV: E=Sophos;i="5.70,394,1574092800"; d="scan'208";a="128929971"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
 by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2020 21:43:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehAozPt+TTTwxoHd2qN1qtOh3SQLDiYXOMG7UTo41xf3HjSzSUOdHwJZz22wcbpfMWyhN85jtrat39lxigtsaA2d1BhsiUcVeFOmLQAyV+sCncNpKyz8OZgCuqynzR3hZ7+q8Lwj+jDvDWZ8PUhr02CKBN1BoSc8UfrIKx7ZpzfKGcnuhGVaDshCgYcAPax5hjW3P7HkeoN855d4Pl9o4FxMblj0im9u/fYCm44ag+yT1FLMDWvHmjECfeEMf2/GZW+b3CQcVgEW0ZQSbUDbsfYJS6qqNUi5i3yCdoGKb5Il2ea6u3K+nqLZKDS5D9ROYPPvDBVw+6CPZqrifKj9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXVWD6kaefkFuq2Xhot7bzYwQH75TZP2Zh89f6rRS5E=;
 b=mhJQEFhW090bnyWJNX6zdKzz54ugcqoGY2DrO3HcpKTUPJhR822+pxZ+tDboeHzfdZ7uVI5cBG297x9j5SNXnUIup1Tjyr/NzqAUFY2QbzMrNoeFJrMpQfZd36j69Nbj2DSghg7VEyoS/BC4RRC53QUBaft+1IPpJXUTLXEY0ibhyYwPK0N1obWqPFvj9siekHI415CmqI8cM4myjowPTgFS+aSzpUu6dhDt9bvJPHSeD4pLo07fSbvQG7+NovN5kKe2pXLYz6uGqGscNqI1qJmreIV4J3qFt/b5rcsR8PYpm6NZdrvQzRtzFWGN+kEqdRSAztsxPCgrUIHxplQojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXVWD6kaefkFuq2Xhot7bzYwQH75TZP2Zh89f6rRS5E=;
 b=KVwp6ru4k7C2ta+fwMMLpFXgsVKi1V5hHNF1hjPRxLgfOmqIszVMAELJ/nqjpualVoduQYEO6eza+7VtAgRh+90z8UWcSVpNG1IrdIkR8L1WJ/3J9zb1cZepk2JpUUJYCubgx9B7TzCjbJ6tV+BN69CtJnPynNVexT9bx3H1LZw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB7038.namprd04.prod.outlook.com (10.186.146.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Sun, 2 Feb 2020 13:43:17 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89%7]) with mapi id 15.20.2686.031; Sun, 2 Feb 2020
 13:43:17 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v3 2/2] hw/riscv: Provide rdtime callback for TCG in CLINT
 emulation
Date: Sun,  2 Feb 2020 19:12:17 +0530
Message-Id: <20200202134217.14264-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202134217.14264-1-anup.patel@wdc.com>
References: <20200202134217.14264-1-anup.patel@wdc.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0033.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::46) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
MIME-Version: 1.0
Received: from wdc.com (217.111.249.45) by
 AM0PR02CA0033.eurprd02.prod.outlook.com (2603:10a6:208:3e::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32 via Frontend Transport; Sun, 2 Feb 2020 13:43:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.111.249.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7be8e38-b44f-49db-bed9-08d7a7e5db71
X-MS-TrafficTypeDiagnostic: MN2PR04MB7038:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB7038923CF48310581CFB3FB18D010@MN2PR04MB7038.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:13;
X-Forefront-PRVS: 0301360BF5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(39850400004)(136003)(366004)(346002)(396003)(189003)(199004)(26005)(5660300002)(186003)(316002)(16526019)(956004)(2616005)(44832011)(36756003)(8936002)(110136005)(4326008)(55016002)(1076003)(54906003)(66476007)(66556008)(2906002)(55236004)(478600001)(66946007)(7696005)(81156014)(81166006)(8676002)(86362001)(52116002)(8886007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB7038;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OxzJW7DN6YKr7Jnjoz6zJZB+CO8v9CvqWBFZZSAvLuYwhb87zi/7EbHVercSqhfqE+55EVBRq1TItab4IaLk4HGgmWckKMsksjb/Y6luchnH1Nko/stIGFJJrt+EOJYh165zpcRitRJKQY71iAhHvyZnD2MdFsZpihNeAxtPekep7o3KISwkCOgN1fKfxEYOOf152HjzHAvjDmC0E6+PSFyur5KhHfrFJBf23A6c27ZPR4ehf8/mJfKC1KonDzvUDhnurfvyqYblY5KQawplFpa/CMVEYbid2AALcO+QZNgWV/z1h0T2tGoBSgmdCwIEAF8wH9lxr/AB8UNgxtkIxjjCUCzOYPrCrNk3wk1naY22p/b0RIUMqikwOdQVoMcPkK6y7iH/Ni/v2PBt3zIbgIh7x6FpSnlJCk/EZfUCupuXjkg9SHu1Mdsk14uy3QSa
X-MS-Exchange-AntiSpam-MessageData: S6DZCKQXSxp133djK41e4Dqij5mDZ1YfQL3ty5kOcyio+NitMvnnN9lydNaZtYUlAjXk3AxZe91v/MEMp+iytLIQw6lVOWZy7yQLL7dludmu9EATexQyqRC1Ltrgl28DCR56geEGS0q561lNZVxjWQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7be8e38-b44f-49db-bed9-08d7a7e5db71
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2020 13:43:17.0096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21dIIvxeONSkAIb/OVKLlomjrFw0yMDS/vHh+7g0fyqZKKad3KXnyjWTdNkTxKwh1+QKPZtkwIorEODvcvjuWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7038
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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

This patch extends CLINT emulation to provide rdtime callback for
TCG. This rdtime callback will be called wheneven TIME CSRs are
read in privileged modes.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_clint.c         | 6 +++++-
 hw/riscv/sifive_e.c             | 2 +-
 hw/riscv/sifive_u.c             | 2 +-
 hw/riscv/spike.c                | 9 ++++++---
 hw/riscv/virt.c                 | 2 +-
 include/hw/riscv/sifive_clint.h | 3 ++-
 6 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index e2feee871b..e933d35092 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -227,7 +227,8 @@ type_init(sifive_clint_register_types)
  * Create CLINT device.
  */
 DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
-    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base)
+    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base,
+    bool provide_rdtime)
 {
     int i;
     for (i = 0; i < num_harts; i++) {
@@ -236,6 +237,9 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
         if (!env) {
             continue;
         }
+        if (provide_rdtime) {
+            riscv_cpu_set_rdtime_fn(env, cpu_riscv_read_rtc);
+        }
         env->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                   &sifive_clint_timer_cb, cpu);
         env->timecmp = 0;
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 8a6b0348df..a254cad489 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -164,7 +164,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_E_PLIC].size);
     sifive_clint_create(memmap[SIFIVE_E_CLINT].base,
         memmap[SIFIVE_E_CLINT].size, ms->smp.cpus,
-        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
     create_unimplemented_device("riscv.sifive.e.aon",
         memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
     sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0e12b3ccef..156a003642 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -549,7 +549,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
         memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
-        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
 
     object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 8823681783..6e5723a171 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -227,7 +227,8 @@ static void spike_board_init(MachineState *machine)
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+        false);
 }
 
 static void spike_v1_10_0_board_init(MachineState *machine)
@@ -316,7 +317,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+        false);
 }
 
 static void spike_v1_09_1_board_init(MachineState *machine)
@@ -424,7 +426,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+        false);
 
     g_free(config_string);
 }
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c44b865959..50838019c8 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -562,7 +562,7 @@ static void riscv_virt_board_init(MachineState *machine)
         memmap[VIRT_PLIC].size);
     sifive_clint_create(memmap[VIRT_CLINT].base,
         memmap[VIRT_CLINT].size, smp_cpus,
-        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, true);
     sifive_test_create(memmap[VIRT_TEST].base);
 
     for (i = 0; i < VIRTIO_COUNT; i++) {
diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_clint.h
index ae8286c884..4a720bfece 100644
--- a/include/hw/riscv/sifive_clint.h
+++ b/include/hw/riscv/sifive_clint.h
@@ -41,7 +41,8 @@ typedef struct SiFiveCLINTState {
 } SiFiveCLINTState;
 
 DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
-    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base);
+    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base,
+    bool provide_rdtime);
 
 enum {
     SIFIVE_SIP_BASE     = 0x0,
-- 
2.17.1


