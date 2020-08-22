Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C591BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 16:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E26520738
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 16:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OojEY/06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E26520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9WAy-00016d-Pz
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 12:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9WAR-0000h1-SY
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 12:14:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9WAQ-0001EN-HV
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 12:14:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id o4so608932wrn.0
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CBBc5h0tlO9pcuO/0Fz1v/rNWxpnjyRFGDHAJePNn6M=;
 b=OojEY/06VpV/0PmASrO7KboUB+1xdg5rc3ARFw508oZOQZz+jZtRf2l0NPvbyQbWa4
 u3QLp0oWr+Sv0iB/4ljT28X9p9dZLgFqVryBxQ47RI5gIGspOSCwQP8VFdfnKht6HjYf
 pmzMbymj4NFg5VAx6chIKbUBnZq80jsQddwOo+646ll5oGnnnJFM/HF39O7pv8+5SP+L
 cQt/gqsEmkUbzYasruuLG5bDVyS2FNbnGEN6Iy6rWUcPsrkyoa/OA9JjyN9CAj8kKoE4
 Cmt95WzeeTCzUb82/d/IccdGQLxxdGTyLwe8oRsVPlV5ubJDfyVqDaff177wRuSbB3qu
 FNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=CBBc5h0tlO9pcuO/0Fz1v/rNWxpnjyRFGDHAJePNn6M=;
 b=JE2yxsinG7+J1QsxjWykrMlT8nSBK3CvchktGEVbVmL5GzXmTVd6rPG8Xc7OWvW7wu
 tx+6BcV8fNOvliS5r0syDe1wXtviHkCTgAc1lW9GgJh9KVFmTO1NXXJZJfz9bMxgNL81
 fbULLukiJXFwuqLRCcSr5v8ZvaApAIlT1n21qouAzWJdWXPRk3m+o9V1IU1jOwSIAJm9
 Hfv/tF3RQUDGFLytarWT6pa1XuA/uw8tkY2S4BXt+GT+NQXgcZja+eBFPZH1o74Ecm9B
 UHOZyXUN91mbWELjtXvQAG0GS1BkSr5cJXex12LA1+pVUHFjn2JMS065FxT+qWdA9aR0
 0BxA==
X-Gm-Message-State: AOAM5312b5RwEXmgn9SEhS0eCJ/hoBTL7i9dq0aYRQVLQzmUB4uUdT00
 BctrrVEV+/ZI8ODSdVEG2bhSC2FqNzg=
X-Google-Smtp-Source: ABdhPJwwJYMztRnJTVi6ryJ5MSC/gJR09KoHPVEy2mVpqiEn4ICco2mE3RTr8fI4FyeOJ5BZ9drlbw==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr3033493wrk.314.1598112892715; 
 Sat, 22 Aug 2020 09:14:52 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id v7sm12235768wmj.28.2020.08.22.09.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2020 09:14:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] memory: Directly dispatch alias accesses on origin memory
 region
Date: Sat, 22 Aug 2020 18:14:49 +0200
Message-Id: <20200822161449.1327517-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is an issue when accessing an alias memory region via the
memory_region_dispatch_read() / memory_region_dispatch_write()
calls.

Since commit 2cdfcf272d ("memory: assign MemoryRegionOps to all
regions") we assign &unassigned_mem_ops to all MemoryRegions.

The memory_region_init_alias() flow is:

  memory_region_init_alias()
  -> memory_region_init()
     -> object_initialize(TYPE_MEMORY_REGION)
        -> memory_region_initfn()
           -> mr->ops = &unassigned_mem_ops;

When accessing the alias using memory_region_dispatch_read(),
flow is:

  memory_region_dispatch_read()
  -> memory_region_access_valid(mr)
     -> mr->ops->valid.accepts()
        -> unassigned_mem_accepts()
        <- false
     <- false
   <- MEMTX_DECODE_ERROR

The caller gets a MEMTX_DECODE_ERROR while the access is OK.

Fix by directly dispatching aliases accesses to its origin region.

Fixes: 2cdfcf272d ("memory: assign MemoryRegionOps to all regions")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v1:
- reword as not a bugfix (Paolo)
- access the aliases recursively (Paolo)
---
 softmmu/memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index 70b93104e8c..3627985bf9f 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1405,6 +1405,10 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
     unsigned size = memop_size(op);
     MemTxResult r;
 
+    while (mr->alias) {
+        addr += mr->alias_offset;
+        mr = mr->alias;
+    }
     if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
         *pval = unassigned_mem_read(mr, addr, size);
         return MEMTX_DECODE_ERROR;
@@ -1449,6 +1453,10 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
 {
     unsigned size = memop_size(op);
 
+    while (mr->alias) {
+        addr += mr->alias_offset;
+        mr = mr->alias;
+    }
     if (!memory_region_access_valid(mr, addr, size, true, attrs)) {
         unassigned_mem_write(mr, addr, data, size);
         return MEMTX_DECODE_ERROR;
-- 
2.26.2


