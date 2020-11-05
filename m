Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCEBC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 418F620756
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418F620756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaePb-0002la-4G
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:30:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiliyang@huawei.com>)
 id 1kaeNG-00011V-B6; Thu, 05 Nov 2020 07:28:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiliyang@huawei.com>)
 id 1kaeNE-0004SE-8o; Thu, 05 Nov 2020 07:28:18 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CRjTx6WJxzkfw0;
 Thu,  5 Nov 2020 20:28:05 +0800 (CST)
Received: from [10.108.235.13] (10.108.235.13) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 5 Nov 2020 20:28:03 +0800
From: shiliyang <shiliyang@huawei.com>
Subject: [PATCH V2 2/4] bsd-user: suspect code indent for conditional
 statements
To: <qemu-devel@nongnu.org>, <philmd@redhat.com>, <pbonzini@redhat.com>,
 <david@redhat.com>
Message-ID: <9464808c-d676-afab-3b99-ac54f621e9d1@huawei.com>
Date: Thu, 5 Nov 2020 20:28:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.108.235.13]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=shiliyang@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 07:27:41
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: alex.chen@huawei.com, qemu-trivial@nongnu.org, hunongda@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch fixes error style problems found by checkpatch.pl:
ERROR: suspect code indent for conditional statements

Signed-off-by: Liyang Shi <shiliyang@huawei.com>

---
 bsd-user/elfload.c | 10 +++++-----
 bsd-user/syscall.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 35c340f13a..a121e71339 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -184,7 +184,7 @@ static inline void init_thread(struct target_pt_regs *regs, struct image_info *i
     memset(regs, 0, sizeof(*regs));
     regs->ARM_cpsr = 0x10;
     if (infop->entry & 1)
-      regs->ARM_cpsr |= CPSR_T;
+        regs->ARM_cpsr |= CPSR_T;
     regs->ARM_pc = infop->entry & 0xfffffffe;
     regs->ARM_sp = infop->start_stack;
     /* FIXME - what to for failure of get_user()? */
@@ -784,7 +784,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
         sp = sp &~ (abi_ulong)15;
         size = (DLINFO_ITEMS + 1) * 2;
         if (k_platform)
-          size += 2;
+            size += 2;
 #ifdef DLINFO_ARCH_ITEMS
         size += DLINFO_ARCH_ITEMS * 2;
 #endif
@@ -871,7 +871,7 @@ static abi_ulong load_elf_interp(struct elfhdr *interp_elf_ex,
                 malloc(sizeof(struct elf_phdr) * interp_elf_ex->e_phnum);

         if (!elf_phdata)
-          return ~((abi_ulong)0UL);
+            return ~((abi_ulong)0UL);

         /*
          * If the size of this structure has changed, then punt, since
@@ -1267,7 +1267,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct target_pt_regs *regs,

             if (strcmp(elf_interpreter,"/usr/lib/libc.so.1") == 0 ||
                 strcmp(elf_interpreter,"/usr/lib/ld.so.1") == 0) {
-              ibcs2_interpreter = 1;
+                ibcs2_interpreter = 1;
             }

 #if 0
@@ -1314,7 +1314,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct target_pt_regs *regs,
         /* Now figure out which format our binary is */
         if ((N_MAGIC(interp_ex) != OMAGIC) && (N_MAGIC(interp_ex) != ZMAGIC) &&
                 (N_MAGIC(interp_ex) != QMAGIC)) {
-          interpreter_type = INTERPRETER_ELF;
+            interpreter_type = INTERPRETER_ELF;
         }

         if (interp_elf_ex.e_ident[0] != 0x7f ||
diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index d38ec7a162..9b471b665c 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -241,7 +241,7 @@ static abi_long do_freebsd_sysctl(abi_ulong namep, int32_t namelen, abi_ulong ol
         return -TARGET_EFAULT;
     holdlen = oldlen;
     for (p = hnamep, q = snamep, i = 0; i < namelen; p++, i++)
-       *q++ = tswap32(*p);
+        *q++ = tswap32(*p);
     oidfmt(snamep, namelen, NULL, &kind);
     /* XXX swap hnewp */
     ret = get_errno(sysctl(snamep, namelen, holdp, &holdlen, hnewp, newlen));
-- 
2.29.1.59.gf9b6481aed


