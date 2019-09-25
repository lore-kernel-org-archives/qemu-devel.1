Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F05C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:00:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33B021D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="faxW6FtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33B021D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCWZ-0007tF-E1
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 15:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIm-0001w9-Ci
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIl-0004QW-0q
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:12 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCIk-0004Pf-RR
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:10 -0400
Received: by mail-pf1-x443.google.com with SMTP id q12so4145411pff.9
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fp+IhM5CQTB4UG88fPA7PY7U/XNGkntrALZi2zvKv3E=;
 b=faxW6FtGYTuPX1Z9H1uXQIDVHyVZmJo4OpZK6UyixfJ6RjM1HW5/XzQfdNaPeKPIIy
 CfqjcD7e1eUpJyEeJPYv2PlXER9rzjbbzpiJX6tFkaB48fGhkLoxhLPp6JFW+57vzsfL
 SuWuJz8nIuvllc/qXQHX95B2mEfUmQxQvUijyL/ASzhZafMQxio7q9CqP5EfkgLPU8GE
 Ofp3K7H97Y9f4akCJcMiFeSeqhZTjyF6ZZz+IiNgj9VvxRZIIB5XkC9j5kG+h6IEjFne
 rkw6dgXdr6uPLcxRXg8oDEHTX0Ec2nHOnt3+zfA0QjRJxagY8vf36vHMyp73yn9CE93g
 +xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fp+IhM5CQTB4UG88fPA7PY7U/XNGkntrALZi2zvKv3E=;
 b=RC/3bJ0j+Cxhd9idwl4gbUDpYNPpV+Tr2fRjPb/EX1NH4QpoTrJJwi9fHKEoVUegg+
 MujKxVS/elUKO+eGouHAqz83c4Q9xMfmZPZ3aTO5ntcvRmhLHcHxfR8fpVNkFDavMviv
 KCtfZMDOS7/XRI28Q9e8mjL7b39k5ZPv/P1NnJc7ijXfVYDCv4xHcQO4ZLhF6clOu2yb
 i6/Hee3su80rnd+Uz1fBBIkznjBZwZ+s1GFhXb2THtcxJBJW9NLhyewqHA5GXqEOIvG9
 42gjQWnlMHyct/a2LwZy7dzF4ql10kM66r7cecgeRNpWDuGrVzpKkhVU+JTiqCmIg5Xx
 uCtQ==
X-Gm-Message-State: APjAAAV4LC+dYGH3FbgVB84y5L3rJDCHtL9HbXaKLeqPWv2IBXUWIWgY
 bDMYkvBPnJ0/O+YJip0f3uk4uRB+Z/Q=
X-Google-Smtp-Source: APXvYqz+kcm0pkE1lLoP2brG/MKm9p1SIiUp8IP6Ayj57fuEXyGvKB5YIQpUlZaV9ShdLhFUVKRP6w==
X-Received: by 2002:a17:90a:9ca:: with SMTP id 68mr7989502pjo.66.1569437169030; 
 Wed, 25 Sep 2019 11:46:09 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id l24sm6133229pff.151.2019.09.25.11.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 11:46:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/16] cputlb: Remove cpu->mem_io_vaddr
Date: Wed, 25 Sep 2019 11:45:45 -0700
Message-Id: <20190925184548.30673-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925184548.30673-1-richard.henderson@linaro.org>
References: <20190925184548.30673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the merge of notdirty handling into store_helper,
the last user of cpu->mem_io_vaddr was removed.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 2 --
 accel/tcg/cputlb.c    | 2 --
 hw/core/cpu.c         | 1 -
 3 files changed, 5 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c7cda65c66..031f587e51 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -338,7 +338,6 @@ struct qemu_work_item;
  * @next_cpu: Next CPU sharing TB cache.
  * @opaque: User data.
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
- * @mem_io_vaddr: Target virtual address at which the memory was accessed.
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to queued_work_*.
  * @queued_work_first: First asynchronous work pending.
@@ -413,7 +412,6 @@ struct CPUState {
      * we store some rarely used information in the CPU context.
      */
     uintptr_t mem_io_pc;
-    vaddr mem_io_vaddr;
     /*
      * This is only needed for the legacy cpu_unassigned_access() hook;
      * when all targets using it have been converted to use
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b56e9ddf8c..4b24811ce7 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -928,7 +928,6 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         cpu_io_recompile(cpu, retaddr);
     }
 
-    cpu->mem_io_vaddr = addr;
     cpu->mem_io_access_type = access_type;
 
     if (mr->global_locking && !qemu_mutex_iothread_locked()) {
@@ -968,7 +967,6 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     if (!cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
-    cpu->mem_io_vaddr = addr;
     cpu->mem_io_pc = retaddr;
 
     if (mr->global_locking && !qemu_mutex_iothread_locked()) {
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 0035845511..73b1ee34d0 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -261,7 +261,6 @@ static void cpu_common_reset(CPUState *cpu)
     cpu->interrupt_request = 0;
     cpu->halted = 0;
     cpu->mem_io_pc = 0;
-    cpu->mem_io_vaddr = 0;
     cpu->icount_extra = 0;
     atomic_set(&cpu->icount_decr_ptr->u32, 0);
     cpu->can_do_io = 1;
-- 
2.17.1


