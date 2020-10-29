Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF84C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77422204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GXvVrHfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77422204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8te-000369-9Z
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8rt-0001Qe-BP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8rp-0005fQ-Qj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603981529; x=1635517529;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TzxgUt8qZfaREE4D9HrT8ndkP8t5MJfPtFf4kMe2y/8=;
 b=GXvVrHfUcXt5j3DkxUvtEAPpig9DZPnkC8CjXuytNpk9xSNtq48fpmoF
 IEduPhESVKviQbve22Cb62FIMhPNLKuFV8GCPJCO8anzlypyedql5ppxs
 08Pmcqp3Eup8WbbDUvcorSXVBpbRBrXbaJ4JN3B0eTCtw1Ap5cLCIFb2F
 OaS9+a1PyD4aPmniX7hpkOFN2kxbf1alRuOD2y5nh9X9OPOUDBFpoAK9g
 aWcov+edY8hufZLPVWeOWxyCFToZqZD42/RFtzqU5S9C7yjXSAI8UnftB
 wlZgE2Kb3eve9FarP0XYUYPHrD+OAeKBb2dvUphWsxJ08bpSkw8ortHeY Q==;
IronPort-SDR: jk1/8KPwQeYelVA21UparILe4Ymk0w98uMmiaAWFD73HPzN+uMmAf4j8NK8DumxKFpNy44VKpR
 17q5ixr5vDCNCQ5bH6q+YnnMy4G5AvIe2Qnyy81nBvWLMECWMine4OjIBxCC+zy12tHZTGJGMY
 3roNY8gXs54Q/7f/5p5jH0j45vQH0iMmA/9YU5BpFTspdMvpH0RFVzJv8tueapwF56eXDViNNN
 t0K0e2P98v5yH/X+M6RlqX/HGwBHtJ7/A2+yA2rDPGkfUYLeKe7j7MQZGWDPu/Mr0HfZkRv29y
 OOc=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151317870"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:25:26 +0800
IronPort-SDR: 27fwbrPWP+OnEfY59TzgjTrDMyIO0CsNr7XrtOFhUo8Wf5ZbidfTqkQQL60XaxQxrnpJHhMEKw
 0HDGS5U19O0qABreKKaJAH2NZxDBcttR/qczvVDdR9iBEQMs4CXrstDwdONeZQqPcTc3pJ5A2Z
 lynHJ8fuKqIM7RASael7vdZYl53UFRqq/OA8mxWO1KcpgLt2WfcTG1VlFzbZy7Wk+E2t49eANb
 /5SJtm9zerQcM5X7Zpi0yT2m68/AsAXYkMWB8tvKNRhdawT69eSc/ybOY2/68mRKsmNA0Y6Tn5
 uA+yLNHNgI/EJFRf4L3bNX+2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 07:11:41 -0700
IronPort-SDR: vyLcTXvwM6YVAt/I+tMsb/R0d7QCJc82f6dOayh0MEZ2NdShmq8wapDWCfOhZK+JET4b/3s03p
 MBxt6NJM3HnFdeZadrdpwotOsHWakZ9lUAogv0n9oVvXWapEipjJaOKtcLKU7UG3RyMgEvyf0b
 SL6V3YnNE5DNwMYigUyhVEATybxOY2f3k+Oq1VPwexxRDmF2GQYvF/gzhUhIB/PQsPXXmzDxCF
 T8KmSOSvVDctoYK2I3/pS5QKlOOc0380B9vPUiHIpeyeuoyBkIhnBvc6I3FNuKmVdsCmUV63hJ
 oEE=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 07:25:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 02/18] hw/riscv: virt: Allow passing custom DTB
Date: Thu, 29 Oct 2020 07:13:42 -0700
Message-Id: <20201029141358.3102636-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029141358.3102636-1-alistair.francis@wdc.com>
References: <20201029141358.3102636-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=56447669b=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 10:25:26
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anup Patel <anup.patel@wdc.com>

Extend virt machine to allow passing custom DTB using "-dtb"
command-line parameter. This will help users pass modified DTB
to virt machine.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201022053225.2596110-2-anup.patel@wdc.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 6bfd10dfc7..25cea7aa67 100644
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
2.28.0


