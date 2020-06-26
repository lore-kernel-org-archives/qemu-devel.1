Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484D3C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1621F20767
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yVStqs2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1621F20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofSz-00083s-8k
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6h-0001cr-LS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:51 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6g-0002A2-1c
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:51 -0400
Received: by mail-pf1-x443.google.com with SMTP id b16so4033639pfi.13
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e+nPcVW2JQX4kQO3F4ekVFtgJoGprqMYmF1Q9wwLqRs=;
 b=yVStqs2gip2T/sKpXtnwfx5Y0pzw4/JkymozLTUK7lRWpJhkR63YdRF4y7jSw8Oj9t
 FHXxtv+pd+YF2fAb981Wu90JmEfSFw4Xlvga+4PveTio+rsRsrnRpdbTrabyrr8lkFnk
 13sL0AOF2S3cWx5ZQxQi4FM2rk+XvzfvuaCqUnPSDh80pFdnEPWuOXBp9wg3YOaEYp9p
 HWB0S2m7d07vQMTbyvnisoN9YFy8DKVN21pQ241mTTeiHeyplVhF6Q4yqLNvSEhvinoU
 7h80SCrRdHO9FHm1bLfrVXdxhrD7ii3iInB/U2w2YvxkCresu3/Clu+OQ29d19OaR2Lo
 6koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e+nPcVW2JQX4kQO3F4ekVFtgJoGprqMYmF1Q9wwLqRs=;
 b=ttX30EIeewOPSYEPOBwip114TEbSDN7azLpfuT/xQzithQ6FU0oEXnvzzXiC+84d+V
 YZCF04WGlsoXGTr7UraL9eYRGDVqAEM4JrU60kFuDk1p+lA2g0Qy89O8kTZqwoHJgC+I
 K14YEdJv3pqRICAUDtl/HRPq56NgMtMdMToCXupDXXLztSCd9rD4u5dMGyNTB1nIn2sa
 lgQKWOkIGYDKVRNCWinVxyt4Ad+ZGNdu7+DoiLqUwmEW+PjVDP/CQ3bPDbLbeNyMZzHc
 u5V4cMHKzgB8kCqrtWScu3IXuKuOnPXbAGYOp0TMXp1+Ks/ASXRQzUZTOBj0hWtiTuVV
 oWpA==
X-Gm-Message-State: AOAM533+3WpxLZi8iLSm0D0urLdnZQVZ8hti0FklVo+Q84IHOpVFXn2Z
 uS0kVka+9+eNBu2q6M/7+9hTnQSt1xM=
X-Google-Smtp-Source: ABdhPJzfktmToyFZFefZf/DkWV8rOlsrXWFZBgl+kVDitHzsaoXjk6U69eojtzCvVuuy73Lu7YwD/g==
X-Received: by 2002:a63:af0f:: with SMTP id w15mr897900pge.363.1593142368246; 
 Thu, 25 Jun 2020 20:32:48 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 46/46] target/arm: Add arm,armv8.5-memtag to dtb
Date: Thu, 25 Jun 2020 20:31:44 -0700
Message-Id: <20200626033144.790098-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mte-v4 linux arm kernel development branch requires these tags.
It is still an open question as to whether they will be required
for the final commit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v9: Split from patch creating the tag memory; sort to the end
    since it's not yet certain that it's a requirement.
---
 include/hw/arm/boot.h |  3 +++
 hw/arm/boot.c         | 12 +++++++++---
 hw/arm/virt.c         |  2 ++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index ce2b48b88b..605446afe7 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -116,6 +116,9 @@ struct arm_boot_info {
      */
     bool secure_board_setup;
 
+    /* If set, all ram objects have tag memory objects. */
+    bool tag_memory;
+
     arm_endianness endianness;
 };
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index fef4072db1..4f96ce42fe 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -427,7 +427,7 @@ static void set_kernel_args_old(const struct arm_boot_info *info,
 
 static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
                                uint32_t scells, hwaddr mem_len,
-                               int numa_node_id)
+                               int numa_node_id, bool tag_memory)
 {
     char *nodename;
     int ret;
@@ -446,6 +446,10 @@ static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
         ret = qemu_fdt_setprop_cell(fdt, nodename,
                                     "numa-node-id", numa_node_id);
     }
+    if (tag_memory) {
+        qemu_fdt_setprop(fdt, nodename, "arm,armv8.5-memtag", "", 0);
+    }
+
 out:
     g_free(nodename);
     return ret;
@@ -534,6 +538,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     hwaddr mem_base, mem_len;
     char **node_path;
     Error *err = NULL;
+    bool tag_memory;
 
     if (binfo->dtb_filename) {
         char *filename;
@@ -599,12 +604,13 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     }
     g_strfreev(node_path);
 
+    tag_memory = binfo->tag_memory;
     if (ms->numa_state != NULL && ms->numa_state->num_nodes > 0) {
         mem_base = binfo->loader_start;
         for (i = 0; i < ms->numa_state->num_nodes; i++) {
             mem_len = ms->numa_state->nodes[i].node_mem;
             rc = fdt_add_memory_node(fdt, acells, mem_base,
-                                     scells, mem_len, i);
+                                     scells, mem_len, i, tag_memory);
             if (rc < 0) {
                 fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
                         mem_base);
@@ -615,7 +621,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
     } else {
         rc = fdt_add_memory_node(fdt, acells, binfo->loader_start,
-                                 scells, binfo->ram_size, -1);
+                                 scells, binfo->ram_size, -1, tag_memory);
         if (rc < 0) {
             fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
                     binfo->loader_start);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 22ce6d6199..8a4ddf13f7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1422,6 +1422,7 @@ static void create_secure_ram(VirtMachineState *vms,
 
     if (secure_tag_sysmem) {
         create_tag_ram(secure_tag_sysmem, base, size, "mach-virt.secure-tag");
+        qemu_fdt_setprop(vms->fdt, nodename, "arm,armv8.5-memtag", "", 0);
     }
 
     g_free(nodename);
@@ -1842,6 +1843,7 @@ static void machvirt_init(MachineState *machine)
          */
         if (object_property_find(cpuobj, "tag-memory", NULL)) {
             if (!tag_sysmem) {
+                vms->bootinfo.tag_memory = true;
                 tag_sysmem = g_new(MemoryRegion, 1);
                 memory_region_init(tag_sysmem, OBJECT(machine),
                                    "tag-memory", UINT64_MAX / 32);
-- 
2.25.1


