Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1675C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 17:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A75820829
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 17:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJvHZHNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A75820829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7MVb-0004Hx-Pj
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 13:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7MUl-0003dT-8b
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 13:30:59 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7MUj-0000MT-Qp
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 13:30:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id r4so12642778wrx.9
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Raus7Isiyid3WEc/Ocz9YyElsHP3uG3r5vaxVcFMgjw=;
 b=MJvHZHNp0mFzOou/WehPtWeE8pcFff/7JlkEbNhLZSQ9mVgnvhBgRMP7uQZBpgZu8h
 hseVqcZMg0LjPtCWERHdogYt7IgEwPyN2iyT3S3UhalTL/NsPR9GQFyxnWyU13ikbGZK
 mS3fECPnxFG2vARLmONw0w2rVxjjCpdvVOGhwtRKUaDSITcRXstxt76d/9MHOI/s87fd
 DRLxYjaCIPqZoPYeUO9rhbHA7qc51VeWIno5o6RuOwWUdbn5UT4YVPF5Z1USrChJFYCt
 HBaSxBheccjj2rTlfbPxux5edbTzUHtZ4NQbqhVDzWfw3DrzVGyKzn+uYmrlnu1xPi8b
 zGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Raus7Isiyid3WEc/Ocz9YyElsHP3uG3r5vaxVcFMgjw=;
 b=nqvbZHaUjr5Th8W17qPfGaaLApnRirmfczsQaFK5bCcnwPrMaNT86C1PO4Hp9jxZLa
 XuFjU0WIvG5ztkRSstqhH/S65i6HcHbtCQqCxgTtSWQoOqGmbT23eSZv0Xju30Pufr7Z
 UskviDNEJhxnrxl4q3thCabNAyNR5Nz9nDN+2ZMW8khtMtrRPi9bSAtabj87c1DLCV92
 vKH4nzoE031jHZF0OiDXSoj9NxYBb7JdZAzbXFfOYEzW7+bkrlDXug0VcuR6RqQDyU5Y
 9R7AHV8uN2l/t8lkfI3icc8RRvgEDHGQvk+kVp4XMr544ee/j8nqMv5IWHlCWgbvtEXs
 vsvA==
X-Gm-Message-State: AOAM532vcMJxfu3u2QC1EG5D3kqNqDpuvv/gbYTr8mDdLvycdhbZJkoD
 LVhEA6UrK8TYF5CDuyNlpXznLjAAi9U=
X-Google-Smtp-Source: ABdhPJx4n9xU7QjOTuklrNSYtKcnZqjqR0slA+msMwCxUIpf1uGlZVaFpWmjQUgH0jRduDPlYUkLUw==
X-Received: by 2002:adf:edc3:: with SMTP id v3mr11432451wro.193.1597599054054; 
 Sun, 16 Aug 2020 10:30:54 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm29797919wrh.18.2020.08.16.10.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2020 10:30:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] memory: Directly dispatch alias accesses on origin memory
 region
Date: Sun, 16 Aug 2020 19:30:51 +0200
Message-Id: <20200816173051.16274-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
calls:

The memory_region_init_alias() flow is:

  memory_region_init_alias()
  -> memory_region_init()
     -> object_initialize(TYPE_MEMORY_REGION)
        -> memory_region_initfn()
           -> mr->ops = &unassigned_mem_ops;

Later when accessing the alias, the memory_region_dispatch_read()
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
 softmmu/memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index af25987518..651705b7d1 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1405,6 +1405,10 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
     unsigned size = memop_size(op);
     MemTxResult r;
 
+    if (mr->alias) {
+        addr += mr->alias_offset;
+        mr = mr->alias;
+    }
     if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
         *pval = unassigned_mem_read(mr, addr, size);
         return MEMTX_DECODE_ERROR;
@@ -1449,6 +1453,10 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
 {
     unsigned size = memop_size(op);
 
+    if (mr->alias) {
+        addr += mr->alias_offset;
+        mr = mr->alias;
+    }
     if (!memory_region_access_valid(mr, addr, size, true, attrs)) {
         unassigned_mem_write(mr, addr, data, size);
         return MEMTX_DECODE_ERROR;
-- 
2.21.3


