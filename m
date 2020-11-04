Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71979C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD05B22243
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD05B22243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaFwr-0003hv-Nm
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiliyang@huawei.com>)
 id 1kaFvJ-0002Ex-4U; Wed, 04 Nov 2020 05:21:49 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:2074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiliyang@huawei.com>)
 id 1kaFvF-0002Bk-K1; Wed, 04 Nov 2020 05:21:48 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CR2kX5VDwzhZlP;
 Wed,  4 Nov 2020 18:21:40 +0800 (CST)
Received: from [10.108.235.13] (10.108.235.13) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 4 Nov 2020 18:21:34 +0800
Subject: [PATCH 4/4] bsd-user: suspect code indent for conditional statements
References: <7ff969d1-3ed9-8723-3270-5737c9c4d1f7@huawei.com>
To: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <philmd@redhat.com>, <alex.bennee@linaro.org>, <laurent@vivier.eu>
From: shiliyang <shiliyang@huawei.com>
X-Forwarded-Message-Id: <7ff969d1-3ed9-8723-3270-5737c9c4d1f7@huawei.com>
Message-ID: <abd90c81-3263-4758-f78a-3d4d61d2515b@huawei.com>
Date: Wed, 4 Nov 2020 18:21:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <7ff969d1-3ed9-8723-3270-5737c9c4d1f7@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.108.235.13]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=shiliyang@huawei.com;
 helo=szxga06-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 05:21:41
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
Cc: alex.chen@huawei.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 hunongda@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch fixes error style problems found by checkpatch.pl:
ERROR: suspect code indent for conditional statements

Signed-off-by: Liyang Shi <shiliyang@huawei.com>

---
 bsd-user/elfload.c | 10 +++++-----
 bsd-user/main.c    |  4 ++--
 bsd-user/syscall.c |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index d5746f25e7..9f4210af9a 100644
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
diff --git a/bsd-user/main.c b/bsd-user/main.c
index ac40d79bfa..d8a2011501 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -831,8 +831,8 @@ int main(int argc, char **argv)
                 exit(1);
             }
         } else if (!strcmp(r, "B")) {
-           guest_base = strtol(argv[optind++], NULL, 0);
-           have_guest_base = true;
+            guest_base = strtol(argv[optind++], NULL, 0);
+            have_guest_base = true;
         } else if (!strcmp(r, "drop-ld-preload")) {
             (void) envlist_unsetenv(envlist, "LD_PRELOAD");
         } else if (!strcmp(r, "bsd")) {
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

