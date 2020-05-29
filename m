Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1780FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A1C206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ENZO9k4l";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LNFrDgIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A1C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jedXM-00076g-SR
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 07:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=411e18819=Anup.Patel@wdc.com>)
 id 1jedU9-0002JB-Jm; Fri, 29 May 2020 07:47:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=411e18819=Anup.Patel@wdc.com>)
 id 1jedU8-00076e-4G; Fri, 29 May 2020 07:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590752856; x=1622288856;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=fcl2/s4taLYbTTKslRBqqC8oTwWKwM22EGfD/3R2t9E=;
 b=ENZO9k4lzdqwNYXliVchaRcowzBC5W3Iv65Oa7lGNQMp1tUW/aQshsVq
 cWZGF5e0Yw71UlCNRWMJwIsWVdzSf5aW85OmPpjt6Hdww20IbcZ6Hlnp6
 RoKEhYC+h6R8tOUB70Vm+yvOQ3gToqIKCh7HxrZ6Oms6YUv7jQKsS9jov
 8H7RrRtVB+rIqK3dm0EP+Wcn/nzumHvobuaWaC+8y7CzZZZHXjPrbXh02
 Dh9tzyi7lszRqhOVQgOU4cUjJMPPzxHsPfjymsfcXo3amGk1ENoIqIr2m
 a+v+GX9APW0QHzRQgGg3xhBzNC1z0BCCZ6li9NILmPWTuQFoJVhDAvBEp w==;
IronPort-SDR: mRubj2FRTRaK5VahYse8QyHF+U9eTqhD2+FTr3A5QkqNUPmwddMW+gLfnZmQvAvO0esl2YqImx
 ZcCoo3Osjb8grcRTwWXEX7uFmgCRhS9LlV58MKTpptnuTKBWWXpub1oMlzpk4xBZfD+Mr9gToK
 3LlFnwIl9h7q+ZDEtKBA2FaI338xWAE4DQPTVeyoz8KwXMZA1E2PaLZC5ws3WrRO4/Ab0I/QFh
 KPRq8n/JKaCzmEbi3QDUNVnz+5Ds4ydSxF50lnt2bX/V23BOo1dpNPNQ03eukJBwJ6iWDhNuGs
 kzE=
X-IronPort-AV: E=Sophos;i="5.73,448,1583164800"; d="scan'208";a="139120671"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 19:47:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDx8Jn2Vj1dNSP511teByWvKdffrOgKqTisP0erfw1eplo3UwTdNjEpK/RofVFyeuvXosilddmuknQwOLIxfPbR4B5VsT6NatL/o+VP9hpLAujvMqXAXiE2QzwgWJkUyZQRQqy9H4POyDqGf8fCeLwRJEwkxAR6R/m8OI0Mc3fVHZYaGMghha7Ep4sqKnRHo8tB7vA3X5z+knmK82xP07w+X7tgvdJ+dfwyGoO9QZeMi+dLoXG1t2fYaP6ChW0UBpYVAG5JN8PZq9w5Q1zJOvGTtBaOixY2uMge2GRehcvihm6+JMFA5xC6ROoCQShqfZZDf/pe2DIHlWARxquP1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSqZwf+oGC6GnqJHzn0BQlbEQMiydC/gkmw6w1nYSYI=;
 b=cVDVIbW98Y8j81SldP+o3PjRg63r8SI0TeZWQsabGnXJMXinNR6YsUICrfdzk1jXoSu/MTMJpGB+u7PMaolop1O7sBlozfo3oCLrp9P4kxDMOgPWvPv3eALuhW8FJ951u4wT0AmXRNjNoVz3UblZ+fCvti+AKWYV5PTFgmZ8qjLyaZy0vzgoW4tJvDzRvK+ySqL9K7WBk9BSaN/48YqWAAGPpne72k/e4GiFN/pqbgeLWgT2QjKumR7RIhHucmC95ado/eMkbv2x3/8T+rfThXc0Ij0jUb5HeG9UELS9XDsQT+UZfqsQI2pASJCJDXkQTp52Qzgfrz1+NYCayOgPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSqZwf+oGC6GnqJHzn0BQlbEQMiydC/gkmw6w1nYSYI=;
 b=LNFrDgItGe4d6Q8RJXeNTht/3m9Yq/xSUfPN5tOzI6z/cTo5HOlHJ3DlPBBTfoekE4nrMpTRMkoyVzh469nLxh4cEMwIZGmwYnb1DwuhSj1vz03t5NdqIExbX5zykRg6zYjXOTufizPc6USqoHD/i52WkT7FTbKWxscOmwtu9+Y=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB7019.namprd04.prod.outlook.com (2603:10b6:5:246::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 11:47:22 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 11:47:22 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v5 2/5] hw/riscv: Allow creating multiple instances of PLIC
Date: Fri, 29 May 2020 17:16:38 +0530
Message-Id: <20200529114641.121332-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200529114641.121332-1-anup.patel@wdc.com>
References: <20200529114641.121332-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::19) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.109.153) by
 MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Fri, 29 May 2020 11:47:18 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.109.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7fe73b2f-567e-4ac6-2710-08d803c60c87
X-MS-TrafficTypeDiagnostic: DM6PR04MB7019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB7019DE0688092F802232B11B8D8F0@DM6PR04MB7019.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NuFzG2luYRyc0j7xyZkkKftY9NDDfd4oeIP3sPEHBpjx8DE63NPghpbsiES0UdU3jIxDtF+u7xc2tLkyruY3MZQzc0/e70B4Pu6GzQIExyrhNJDCNmCCcJaTghXe2ng8vQuWNGfSE+s++yttkZOdz5Ybrn4WV7tI0993/aEYznhv1OB8KfeN+sENsynI7kij+a1Stuw9svEbK6TfddWUt08RIqIcMFAfiosg8DFynMGoFbmW/4c7/n/NEmEr6JPCEyZtlTMT2ha19tM080i71slmvGCEuZEw/lqGjfxUtW6ied6OkARPdsLAm8fh/jwPVrv1BzgGGjPLZ0cxoojEqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(8936002)(83380400001)(8886007)(2906002)(186003)(478600001)(6666004)(316002)(1006002)(36756003)(54906003)(55016002)(1076003)(110136005)(66946007)(26005)(16526019)(956004)(86362001)(2616005)(66476007)(66556008)(5660300002)(7696005)(52116002)(4326008)(55236004)(44832011)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9LJbDxtAiXd5fBl0gygbGSiSh8WaG46Ylsi8M+SMIKoOpMaVId2hkc78mJ3smRuL5idW2fcYA/uUb6OXWsM/KDu5oxvAGtDtn8+2iW4tYOaIeSYtrMpz9qAjq+lib6ICb66Q40xIAzBAXYzy4ROLdy4NCsjhXDzzgxxMHHWyZ+aKvKf7Pmlj8kIJGQWzlUFz2H5CIXx9kSVCYcmzvFjOv16O+ShI6hIGLb5PzgQKQdCXEOnUM+XX9RgaeYANrUYdfpVae7fUNEdPYvoGemYzY4igrgVzgWXRnrbTY4sTS3CtoIKqY2GgLfOE96+rjeMKAj24ac7jAgqSDI2odMKqhigGBk93tlUBAvgs11pZVAts/CBZqz1mlTWGpYWE+m5zqk2+ymD3PYxsIDIDX3evVmOtl1TxroeLZHbuL+ARrLAS8iVb/wd7ar46yzRP5uMMsvuk28WqfuknAJuIAk1AVvm2JDxW9wqRzbDTWT9md1g=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe73b2f-567e-4ac6-2710-08d803c60c87
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 11:47:22.2926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqJRZDXsfN2gGFIhfeopTcfqvWIRl5zJtXMynhTNZZGiNRbu6lZM2gsg0nWXyaMEM1v80PWlVePafxzRSMfQMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7019
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=411e18819=Anup.Patel@wdc.com; helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 07:47:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Anup Patel <anup.patel@wdc.com>, qemu-riscv@nongnu.org,
 Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmerdabbelt@google.com>,
 qemu-devel@nongnu.org, Atish Patra <atish.patra@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We extend PLIC emulation to allow multiple instances of PLIC in
a QEMU RISC-V machine. To achieve this, we remove first HART id
zero assumption from PLIC emulation.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_e.c            |  2 +-
 hw/riscv/sifive_plic.c         | 24 +++++++++++++-----------
 hw/riscv/sifive_u.c            |  2 +-
 hw/riscv/virt.c                |  2 +-
 include/hw/riscv/sifive_plic.h | 12 +++++++-----
 5 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 1c3b37d0ba..bd122e71ae 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -152,7 +152,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
-        (char *)SIFIVE_E_PLIC_HART_CONFIG,
+        (char *)SIFIVE_E_PLIC_HART_CONFIG, 0,
         SIFIVE_E_PLIC_NUM_SOURCES,
         SIFIVE_E_PLIC_NUM_PRIORITIES,
         SIFIVE_E_PLIC_PRIORITY_BASE,
diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index c1e04cbb98..f88bb48053 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -352,6 +352,7 @@ static const MemoryRegionOps sifive_plic_ops = {
 
 static Property sifive_plic_properties[] = {
     DEFINE_PROP_STRING("hart-config", SiFivePLICState, hart_config),
+    DEFINE_PROP_UINT32("hartid-base", SiFivePLICState, hartid_base, 0),
     DEFINE_PROP_UINT32("num-sources", SiFivePLICState, num_sources, 0),
     DEFINE_PROP_UINT32("num-priorities", SiFivePLICState, num_priorities, 0),
     DEFINE_PROP_UINT32("priority-base", SiFivePLICState, priority_base, 0),
@@ -400,10 +401,12 @@ static void parse_hart_config(SiFivePLICState *plic)
     }
     hartid++;
 
-    /* store hart/mode combinations */
     plic->num_addrs = addrid;
+    plic->num_harts = hartid;
+
+    /* store hart/mode combinations */
     plic->addr_config = g_new(PLICAddr, plic->num_addrs);
-    addrid = 0, hartid = 0;
+    addrid = 0, hartid = plic->hartid_base;
     p = plic->hart_config;
     while ((c = *p++)) {
         if (c == ',') {
@@ -429,8 +432,6 @@ static void sifive_plic_irq_request(void *opaque, int irq, int level)
 
 static void sifive_plic_realize(DeviceState *dev, Error **errp)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
-    unsigned int smp_cpus = ms->smp.cpus;
     SiFivePLICState *plic = SIFIVE_PLIC(dev);
     int i;
 
@@ -451,8 +452,8 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
      * lost a interrupt in the case a PLIC is attached. The SEIP bit must be
      * hardware controlled when a PLIC is attached.
      */
-    for (i = 0; i < smp_cpus; i++) {
-        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(i));
+    for (i = 0; i < plic->num_harts; i++) {
+        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(plic->hartid_base + i));
         if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
             error_report("SEIP already claimed");
             exit(1);
@@ -488,16 +489,17 @@ type_init(sifive_plic_register_types)
  * Create PLIC device.
  */
 DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
-    uint32_t num_sources, uint32_t num_priorities,
-    uint32_t priority_base, uint32_t pending_base,
-    uint32_t enable_base, uint32_t enable_stride,
-    uint32_t context_base, uint32_t context_stride,
-    uint32_t aperture_size)
+    uint32_t hartid_base, uint32_t num_sources,
+    uint32_t num_priorities, uint32_t priority_base,
+    uint32_t pending_base, uint32_t enable_base,
+    uint32_t enable_stride, uint32_t context_base,
+    uint32_t context_stride, uint32_t aperture_size)
 {
     DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_PLIC);
     assert(enable_stride == (enable_stride & -enable_stride));
     assert(context_stride == (context_stride & -context_stride));
     qdev_prop_set_string(dev, "hart-config", hart_config);
+    qdev_prop_set_uint32(dev, "hartid-base", hartid_base);
     qdev_prop_set_uint32(dev, "num-sources", num_sources);
     qdev_prop_set_uint32(dev, "num-priorities", num_priorities);
     qdev_prop_set_uint32(dev, "priority-base", priority_base);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index c193761916..53e48e2ff5 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -586,7 +586,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
-        plic_hart_config,
+        plic_hart_config, 0,
         SIFIVE_U_PLIC_NUM_SOURCES,
         SIFIVE_U_PLIC_NUM_PRIORITIES,
         SIFIVE_U_PLIC_PRIORITY_BASE,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 51afe7e23b..421815081d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -584,7 +584,7 @@ static void riscv_virt_board_init(MachineState *machine)
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[VIRT_PLIC].base,
-        plic_hart_config,
+        plic_hart_config, 0,
         VIRT_PLIC_NUM_SOURCES,
         VIRT_PLIC_NUM_PRIORITIES,
         VIRT_PLIC_PRIORITY_BASE,
diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_plic.h
index 4421e81249..ace76d0f1b 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -48,6 +48,7 @@ typedef struct SiFivePLICState {
     /*< public >*/
     MemoryRegion mmio;
     uint32_t num_addrs;
+    uint32_t num_harts;
     uint32_t bitfield_words;
     PLICAddr *addr_config;
     uint32_t *source_priority;
@@ -58,6 +59,7 @@ typedef struct SiFivePLICState {
 
     /* config */
     char *hart_config;
+    uint32_t hartid_base;
     uint32_t num_sources;
     uint32_t num_priorities;
     uint32_t priority_base;
@@ -70,10 +72,10 @@ typedef struct SiFivePLICState {
 } SiFivePLICState;
 
 DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
-    uint32_t num_sources, uint32_t num_priorities,
-    uint32_t priority_base, uint32_t pending_base,
-    uint32_t enable_base, uint32_t enable_stride,
-    uint32_t context_base, uint32_t context_stride,
-    uint32_t aperture_size);
+    uint32_t hartid_base, uint32_t num_sources,
+    uint32_t num_priorities, uint32_t priority_base,
+    uint32_t pending_base, uint32_t enable_base,
+    uint32_t enable_stride, uint32_t context_base,
+    uint32_t context_stride, uint32_t aperture_size);
 
 #endif
-- 
2.25.1


