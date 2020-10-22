Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12F8C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5EFD2225F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FdEJqRTu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="w2Kuo7u1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EFD2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVTFG-0004dQ-KU
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=557099d69=Anup.Patel@wdc.com>)
 id 1kVTDm-0003Kf-EU; Thu, 22 Oct 2020 01:33:06 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=557099d69=Anup.Patel@wdc.com>)
 id 1kVTDk-00032s-Hj; Thu, 22 Oct 2020 01:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603344784; x=1634880784;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=3P0TElF+PfPgKw908F1ERC2M3FwLMmoCeHTZZo6CBgU=;
 b=FdEJqRTuGIFBqpoPuQMUn0dT5DAou+U6Dz4BXHozi36mVo8N23MJ6jBc
 Ty2Upsq/TBPp1vVHK0Cz/tV+rmB8fTjP3xRVZOo9ozzB2AJbryik3MBZ/
 b3y/2jLpD8e7FWoUNp7pIh/ll4c1wlzy3ssNL1lz9Sv96DnAPiwS98oc4
 XGTBz57GkzVsQCT/zHUItvVvMBspn7AqBwBqGmTF69kRD2FQ+WOPDRAVJ
 pTMWi25hKz969jNPigdbdfYtn1tt1mZ6ox+vAygQycIq6v7N+Xr6T3wwd
 iHPEpY6LMBS4udNaEU+XcxEWxCkWqKPSVF/JPHBQmrE5nyYx2XRbVe/Pw Q==;
IronPort-SDR: 2lPuDMpYXyAlv6VQKvzptiQ+Xq9g/odk9E6IZJdRXcW35fElveY+4Ru1V8tIMvOj6n/8vLRdcd
 5zAf2bIflX1TpNvRwWmMtsuWBSB94vmL9/e2BXQJXvh3BSisd8Wq6Jh3+/qJi3M80fwPZmS1TS
 lYMOQoi8qw8+579jb1jerO44+fZfbn+tBDKY87oFCk7g0NRfDOLRQ7uLvLd84hFU9wWUPb3QjR
 0XfElPhNVBIRpfFTuLqy+TGux7f0qw6Ha1YombA3oAYcOMC4EYdENHP1sM2qzoJGwJW0/y0T5t
 rP4=
X-IronPort-AV: E=Sophos;i="5.77,403,1596470400"; d="scan'208";a="150507378"
Received: from mail-bl2nam02lp2053.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.53])
 by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 13:32:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiMI5NTYYlUaMsaY05nf+ZuNJmjtr7ZofSDe1ZwFn/IOTmbyNYf06+FoGsDNJt3vTKMUIxIt9bcbtDR/MO7xoknvMnvbidui6WeiMX5fSSqFezM3lrpAmBiQuLej9TWf/M6wXtbXpj1wYDuT9fZVjaC7mK4nmXoVsFKy9dQUxQOK1PaYYeNC71PTZZCSGBva4Mbzj+lL6iCzF54kXzTEmvxG8jEv0MFDQWPH5OTNFieGZJL1pAYMGfeaFARsNFL5HJl0yvJuMiniwoHvvX+rcN01xptSbhgXrw/gEM0IC/H8PuxYYcDZCbCFPpWv3nV6pVEEyYT3RjNQst2Ow1As/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abHk57x/mjk8p42YcGispaSQP77JOgYCZq9e3q5AUzk=;
 b=chEQ/rA11+cHoAuhy8GpmM86us/C5gxOcOtR8/xKwffeedhhaGvpEcNQQUJHRBCWI5XcgxZwiqRH71jyCCj4kHjTE/9Ij//vlKx0Tn+FvoffS0E9B/f66VXOMK0EcXNPRkpHVZmhpHHQgxr2XDyvQNFG+0scoK9TlAy1mLP/P1NiWmDvdpXDCyHje+sMSxAXTr2mRG6JPisRuYR9I3N7K8YGMPbaHEAMqKqd7XZHk+wtl/Tx5rQqC6ZzHgfVOJXTRmkHDWUnuA6rMC6oLxNNGKr7CWBpcwJ0ME3ptrzv1cChhb1RcqbhX8wLqoDujs4td8r351m0v9xAz7okVN1l1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abHk57x/mjk8p42YcGispaSQP77JOgYCZq9e3q5AUzk=;
 b=w2Kuo7u1dGMf8Enb6zLujQRmWjsy/qyD6Jx+D25HGCA2bRTL5zl8QiznpRQsujwAXVX6na4htX9KdZ0HomEcWQaT3Q77pbc/hmJJbeAi2BEeferLqBudbb3EFVQdHX3EBJ4q/htUF57v1x5vvW+IkpAG7AtUR9eMG+b/6YB4GS0=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR0401MB3509.namprd04.prod.outlook.com (2603:10b6:4:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Thu, 22 Oct
 2020 05:32:54 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::d035:e2c6:c11:51dd]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::d035:e2c6:c11:51dd%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 05:32:54 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 2/2] hw/riscv: virt: Allow passing custom DTB
Date: Thu, 22 Oct 2020 11:02:25 +0530
Message-Id: <20201022053225.2596110-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201022053225.2596110-1-anup.patel@wdc.com>
References: <20201022053225.2596110-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.78.74]
X-ClientProxiedBy: MA1PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::33) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.78.74) by
 MA1PR01CA0139.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 05:32:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0033141-f8ac-44ac-5b3f-08d8764bed30
X-MS-TrafficTypeDiagnostic: DM5PR0401MB3509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR0401MB3509A376C98C0689A9AF5D0E8D1D0@DM5PR0401MB3509.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:79;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FZkQU8xr7+OkgRAKLvsBnSAzehJQNYOx4Em/2d6H9hM9YCyzhMIbwToxakEwGFfjghUPH8HI41oee6N84stSdry7K71sH6ARCvLy12KP69Q0+YcxbNN7thww3BySZkXjrfJjo2Z3yrvCOyuEqHGIYAxLy4pl83EZQvmrx37TrpqggWaC7XaUVx/Ma/oqw+FLoUF/QF0j/PfpmX+t4jbM6+YnKA3hj0khOFHqvOKAf41LItFBG6OEDcY15EB8k/W6KMh5t3UvWyB4XhK4MbN20nuRPdgZPtc48IfKtFiOXBp/mO/yxJ2C5nCUO9fEuTq0SNnYLNJB+vAMC9FwgcwgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(7696005)(52116002)(4326008)(1076003)(55016002)(6666004)(44832011)(8886007)(110136005)(2906002)(5660300002)(54906003)(83380400001)(316002)(66946007)(26005)(86362001)(2616005)(8936002)(956004)(66556008)(36756003)(478600001)(66476007)(186003)(16526019)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6tjpBLM8FXC+WnQb3pR1JwaMkL/H2lRIWoLBNcrA/AJTCxLrQZgORhy3dNmaF2hm9r5jkNZrmoQo93C0EGnyiTJg+99ZkF/XcRF5EL9yLXIOu/TnnKUeBRxfcBMudn6Myv41i49wpfQ9hxfdwNhjU8N0jNlfpJMz9MWsLQ3UmOh0rJeWJGXETdcjPdzGvv1tPVKSOI2435FuF7XZPnT3ngzjNkSTr+HWyvmEJPE7htVQqSLj7GyV93Uzilm5AR/YE86llGk0eiISacKNKOTZGVnjY0jcYq7QCtmJrkVwK8z0seDvnP5LRMOxjAiwMknHMZ4K3+h+phfKfWuqENDNlDxDjmI8yx+YWf3ijCSx1Uy5ZXqbSRr6SylMYKolNB9obV2Kov7JQVxNvju0BFc211cjO0XEy/Ok0RAYvS/9J4yUNLoaK+sqH+fAQblu/h0KCUwUrbWY+MYiNJhle0NqU2jEM8gcTfofyMF2xSYsAX4uteW8DnWBIj9y/QVR6jdtjFToDlpuSXjmRCGQSCX10Ij9b1LTYGtJU9rViLZB7uHrSvD6TKbnu9gZS5pR66pwJcC7tLcd/l1sWzr0/s1Zxnen9InzxPmSIFuKsuzqpsgIbHytrRrEC/BQv35yDvUEqDYTqzYtIgvFoaErIG+2fw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0033141-f8ac-44ac-5b3f-08d8764bed30
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 05:32:54.8578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ev7T90b0yhbICl6t5wJfyUmn78kzCmnFd1il2j2QhjbSZBNY4LYbYPZk0X347JhJAQf5anpt1axaCK+/QJ60VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3509
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=557099d69=Anup.Patel@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 01:33:02
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extend virt machine to allow passing custom DTB using "-dtb"
command-line parameter. This will help users pass modified DTB
to virt machine.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/virt.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 41bd2f38ba..d535119e37 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -181,6 +181,7 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
 {
     void *fdt;
     int i, cpu, socket;
+    const char *dtb_filename;
     MachineState *mc = MACHINE(s);
     uint64_t addr, size;
     uint32_t *clint_cells, *plic_cells;
@@ -194,10 +195,20 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
 
-    fdt = s->fdt = create_device_tree(&s->fdt_size);
-    if (!fdt) {
-        error_report("create_device_tree() failed");
-        exit(1);
+    dtb_filename = qemu_opt_get(qemu_get_machine_opts(), "dtb");
+    if (dtb_filename) {
+        fdt = s->fdt = load_device_tree(dtb_filename, &s->fdt_size);
+        if (!fdt) {
+            error_report("load_device_tree() failed");
+            exit(1);
+        }
+        goto update_bootargs;
+    } else {
+        fdt = s->fdt = create_device_tree(&s->fdt_size);
+        if (!fdt) {
+            error_report("create_device_tree() failed");
+            exit(1);
+        }
     }
 
     qemu_fdt_setprop_string(fdt, "/", "model", "riscv-virtio,qemu");
@@ -418,9 +429,6 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
 
     qemu_fdt_add_subnode(fdt, "/chosen");
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", name);
-    if (cmdline) {
-        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
-    }
     g_free(name);
 
     name = g_strdup_printf("/soc/rtc@%lx", (long)memmap[VIRT_RTC].base);
@@ -441,6 +449,11 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
                                  2, flashbase + flashsize, 2, flashsize);
     qemu_fdt_setprop_cell(s->fdt, name, "bank-width", 4);
     g_free(name);
+
+update_bootargs:
+    if (cmdline) {
+        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    }
 }
 
 static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
-- 
2.25.1


