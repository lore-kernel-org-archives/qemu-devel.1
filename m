Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAC1C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 19:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7661320874
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 19:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7661320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJi5j-0004mx-UK
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 15:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhs0-0006Yz-0N; Sat, 19 Sep 2020 14:46:00 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrv-0001TJ-KI; Sat, 19 Sep 2020 14:45:59 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N7xml-1kWiW10YIF-014yep; Sat, 19 Sep 2020 20:45:22 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 14/17] linux-user/: fix some comment spelling errors
Date: Sat, 19 Sep 2020 20:44:48 +0200
Message-Id: <20200919184451.2129349-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FZMjZbzHZBvKrDOk3b2W0Bk6JJ0AoG5kSVUzhIQWlKSBPX/m28x
 KQGGoUvo8kEsH4BB8wcAwSxszN1HQUwgmEATqvlOJi9coQlmmyrIc5FBfGfd6WkPuy/+z11
 vvYVmF7BYVhBCxJM8W5grcErcZIfAETGvr1s+rQ5rkZhfuu95m6XwF20Dd2+3yZHp8SCi1J
 lUwFW0hXtTM1m8gxxgSCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nPYNp5kxVaY=:E0q+iVY3HiLohnbzOwaKmf
 m7M7iPF4zMs7BGNqMN5nCpo1mYTrdta4SOLSASZ4BJ17otk9A2Lrz2xQ+FLlBOYaoz3COLLfQ
 BoWvLRhBsZ6BiZ9xAg1luzed/oFqTzMdwmwQbtaSZuTvAxymodMsrbszdSAIiCR7EO1K8M3Ld
 Fgn6+QhFv4vHGvkyJryLI4Kt6VzI8OkbQJ2IJNZIeWl9taX/IpMx8SUzQYk9AxEmjDvcUM0D1
 cZYjn/loKpAkiQybd6VMxQQJ+NzdtVRp502fev3LcxD1Hn4vmy1HhSBiteowXlDDNIjIqAAec
 JzSxW0TKmY5Tes7IBH46RRZP2CDGHoIhUyQFSKAFCT/AkjOnREzT3q2rw1yEo5UEEjIb7Tecl
 Yj2FwWUYmMFlvWJWPPVoSWCRQD+nyh2gtYhX+V4ElLedfAbUN3ESb72paF4OC4MNxsEw3W9Io
 qFGad+IIZIbh+jatmGWcRfh8bWJPqaW0lo+rBhzhKQmYW5RmMaBJv8T57C+WaoEDCyE+gP7r6
 ALw5C+xtO6ZvJfyrQqLWPG/TloD7q3n2gkeI9i+UHOGHEqmyh2fb2ch8kRxY55q88CLlWHGnJ
 CfQuZQf1GgOO/XwiMI5bB1dSF4b+xkLi87jrpzgT15zZbxdYzt3yCV3mELcxCCycSHPXpY8g3
 gZOFpU5XBnB0UqNJBNGwBmykl9Jl4cADA2vzxuFqHA0j26HE4oShvJ7FjCK7zVrXl6y+AmufS
 t23tsCLA2E+KvYaFTEboIZnr8bgLdAQLCz+B7SVLVtSPPM8eIkJiqNrNBBMBdwLWY51+n7zLJ
 lhvYBybBys6IZ9+x8slL7xhUaOPnz0VRJxz8ve55EJw6THhX2mtpVf0dAHDYCin+mzbfn1D
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Alex Bennee <alex.bennee@linaro.org>,
 zhaolichang <zhaolichang@huawei.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhaolichang <zhaolichang@huawei.com>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the linux-user folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Alex Bennee <alex.bennee@linaro.org>
Message-Id: <20200917075029.313-7-zhaolichang@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/aarch64/signal.c              | 2 +-
 linux-user/cris/target_syscall.h         | 4 ++--
 linux-user/flat.h                        | 2 +-
 linux-user/flatload.c                    | 4 ++--
 linux-user/host/ppc64/safe-syscall.inc.S | 2 +-
 linux-user/syscall.c                     | 4 ++--
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index cd521ee42d17..d50c1ae58381 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -78,7 +78,7 @@ struct target_sve_context {
     struct target_aarch64_ctx head;
     uint16_t vl;
     uint16_t reserved[3];
-    /* The actual SVE data immediately follows.  It is layed out
+    /* The actual SVE data immediately follows.  It is laid out
      * according to TARGET_SVE_SIG_{Z,P}REG_OFFSET, based off of
      * the original struct pointer.
      */
diff --git a/linux-user/cris/target_syscall.h b/linux-user/cris/target_syscall.h
index d109a6b42a35..19e12814039c 100644
--- a/linux-user/cris/target_syscall.h
+++ b/linux-user/cris/target_syscall.h
@@ -4,7 +4,7 @@
 #define UNAME_MACHINE "cris"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
-/* pt_regs not only specifices the format in the user-struct during
+/* pt_regs not only specifies the format in the user-struct during
  * ptrace but is also the frame format used in the kernel prologue/epilogues
  * themselves
  */
@@ -32,7 +32,7 @@ struct target_pt_regs {
         unsigned long spc;
         unsigned long ccs;
         unsigned long srp;
-        unsigned long erp; /* This is actually the debugged process' PC */
+        unsigned long erp; /* This is actually the debugged process's PC */
         /* For debugging purposes; saved only when needed. */
         unsigned long exs;
         unsigned long eda;
diff --git a/linux-user/flat.h b/linux-user/flat.h
index 1e44b3344320..ed518e2013b1 100644
--- a/linux-user/flat.h
+++ b/linux-user/flat.h
@@ -43,7 +43,7 @@ struct flat_hdr {
 	abi_ulong reloc_count;  /* Number of relocation records */
 	abi_ulong flags;
 	abi_ulong build_date;   /* When the program/library was built */
-	abi_ulong filler[5];    /* Reservered, set to zero */
+	abi_ulong filler[5];    /* Reserved, set to zero */
 };
 
 #define FLAT_FLAG_RAM    0x0001 /* load program entirely into RAM */
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 8fb448f0bf06..14d2999d1537 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -442,7 +442,7 @@ static int load_flat_file(struct linux_binprm * bprm,
     indx_len = (indx_len + 15) & ~(abi_ulong)15;
 
     /*
-     * Alloate the address space.
+     * Allocate the address space.
      */
     probe_guest_base(bprm->filename, 0,
                      text_len + data_len + extra + indx_len);
@@ -794,7 +794,7 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
 #error here
     for (i = MAX_SHARED_LIBS-1; i>0; i--) {
             if (libinfo[i].loaded) {
-                    /* Push previos first to call address */
+                    /* Push previous first to call address */
                     --sp;
                     if (put_user_ual(start_addr, sp))
                         return -EFAULT;
diff --git a/linux-user/host/ppc64/safe-syscall.inc.S b/linux-user/host/ppc64/safe-syscall.inc.S
index 8ed73a5b8683..875133173bb6 100644
--- a/linux-user/host/ppc64/safe-syscall.inc.S
+++ b/linux-user/host/ppc64/safe-syscall.inc.S
@@ -84,7 +84,7 @@ safe_syscall_end:
 
 	/* code path when we didn't execute the syscall */
 0:	addi	3, 0, -TARGET_ERESTARTSYS
-	ld 14, 16(1) /* restore r14 to its orginal value */
+	ld 14, 16(1) /* restore r14 to its original value */
 	blr
 	.cfi_endproc
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 55ac5c320825..897d20c076ce 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -481,7 +481,7 @@ _syscall4(int, sys_prlimit64, pid_t, pid, int, resource,
 
 
 #if defined(TARGET_NR_timer_create)
-/* Maxiumum of 32 active POSIX timers allowed at any one time. */
+/* Maximum of 32 active POSIX timers allowed at any one time. */
 static timer_t g_posix_timers[32] = { 0, } ;
 
 static inline int next_free_host_timer(void)
@@ -8180,7 +8180,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     switch(num) {
     case TARGET_NR_exit:
         /* In old applications this may be used to implement _exit(2).
-           However in threaded applictions it is used for thread termination,
+           However in threaded applications it is used for thread termination,
            and _exit_group is used for application termination.
            Do thread termination if we have more then one thread.  */
 
-- 
2.26.2


