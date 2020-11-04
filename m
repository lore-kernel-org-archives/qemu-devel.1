Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01C4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58214223FD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58214223FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaFzW-0007xx-3y
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiliyang@huawei.com>)
 id 1kaFv5-0001xt-G5; Wed, 04 Nov 2020 05:21:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiliyang@huawei.com>)
 id 1kaFv2-0002BD-Pj; Wed, 04 Nov 2020 05:21:35 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CR2kF3sMdzkZV4;
 Wed,  4 Nov 2020 18:21:25 +0800 (CST)
Received: from [10.108.235.13] (10.108.235.13) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 4 Nov 2020 18:21:21 +0800
Subject: [PATCH 3/4] bsd-user: "foo * bar" should be "foo *bar"
References: <81473730-4d0a-47e0-71f0-3aebdc7401e4@huawei.com>
To: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <philmd@redhat.com>, <alex.bennee@linaro.org>, <laurent@vivier.eu>
From: shiliyang <shiliyang@huawei.com>
X-Forwarded-Message-Id: <81473730-4d0a-47e0-71f0-3aebdc7401e4@huawei.com>
Message-ID: <b0963e45-fc06-ff70-019c-0dbf3d62d820@huawei.com>
Date: Wed, 4 Nov 2020 18:21:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <81473730-4d0a-47e0-71f0-3aebdc7401e4@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.108.235.13]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=shiliyang@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 05:21:16
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
ERROR: "foo ** bar" should be "foo **bar".
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Liyang Shi <shiliyang@huawei.com>

---
 bsd-user/bsdload.c |  6 +++---
 bsd-user/elfload.c | 22 +++++++++++-----------
 bsd-user/qemu.h    | 14 +++++++-------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/bsd-user/bsdload.c b/bsd-user/bsdload.c
index f38c4faacf..b2f352c041 100644
--- a/bsd-user/bsdload.c
+++ b/bsd-user/bsdload.c
@@ -20,7 +20,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
     return 0;
 }

-static int count(char ** vec)
+static int count(char **vec)
 {
     int         i;

@@ -125,8 +125,8 @@ abi_ulong loader_build_argptr(int envc, int argc, abi_ulong sp,
     return sp;
 }

-int loader_exec(const char * filename, char ** argv, char ** envp,
-             struct target_pt_regs * regs, struct image_info *infop)
+int loader_exec(const char *filename, char **argv, char **envp,
+             struct target_pt_regs *regs, struct image_info *infop)
 {
     struct linux_binprm bprm;
     int retval;
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 32378af7b2..d5746f25e7 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -547,12 +547,12 @@ struct exec

 #define DLINFO_ITEMS 12

-static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
+static inline void memcpy_fromfs(void *to, const void *from, unsigned long n)
 {
         memcpy(to, from, n);
 }

-static int load_aout_interp(void * exptr, int interp_fd);
+static int load_aout_interp(void *exptr, int interp_fd);

 #ifdef BSWAP_NEEDED
 static void bswap_ehdr(struct elfhdr *ehdr)
@@ -613,7 +613,7 @@ static void bswap_sym(struct elf_sym *sym)
  * to be put directly into the top of new user memory.
  *
  */
-static abi_ulong copy_elf_strings(int argc,char ** argv, void **page,
+static abi_ulong copy_elf_strings(int argc,char **argv, void **page,
                                   abi_ulong p)
 {
     char *tmp, *tmp1, *pag = NULL;
@@ -756,7 +756,7 @@ static void padzero(abi_ulong elf_bss, abi_ulong last_bss)


 static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
-                                   struct elfhdr * exec,
+                                   struct elfhdr *exec,
                                    abi_ulong load_addr,
                                    abi_ulong load_bias,
                                    abi_ulong interp_load_addr, int ibcs,
@@ -834,7 +834,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
 }


-static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
+static abi_ulong load_elf_interp(struct elfhdr *interp_elf_ex,
                                  int interpreter_fd,
                                  abi_ulong *interp_load_addr)
 {
@@ -1143,8 +1143,8 @@ static void load_symbols(struct elfhdr *hdr, int fd)
     syminfos = s;
 }

-int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
-                    struct image_info * info)
+int load_elf_binary(struct linux_binprm *bprm, struct target_pt_regs *regs,
+                    struct image_info *info)
 {
     struct elfhdr elf_ex;
     struct elfhdr interp_elf_ex;
@@ -1155,11 +1155,11 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
     unsigned int interpreter_type = INTERPRETER_NONE;
     unsigned char ibcs2_interpreter;
     int i;
-    struct elf_phdr * elf_ppnt;
+    struct elf_phdr *elf_ppnt;
     struct elf_phdr *elf_phdata;
     abi_ulong elf_bss, k, elf_brk;
     int retval;
-    char * elf_interpreter;
+    char *elf_interpreter;
     abi_ulong elf_entry, interp_load_addr = 0;
     abi_ulong start_code, end_code, start_data, end_data;
     abi_ulong reloc_func_desc = 0;
@@ -1334,7 +1334,7 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
        and then start this sucker up */

     {
-        char * passed_p;
+        char *passed_p;

         if (interpreter_type == INTERPRETER_AOUT) {
             snprintf(passed_fileno, sizeof(passed_fileno), "%d", bprm->fd);
@@ -1553,7 +1553,7 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
     return 0;
 }

-static int load_aout_interp(void * exptr, int interp_fd)
+static int load_aout_interp(void *exptr, int interp_fd)
 {
     printf("a.out interpreter not yet supported\n");
     return(0);
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index f8bb1e5459..cbf42129e4 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -123,19 +123,19 @@ struct linux_binprm {
         int argc, envc;
         char **argv;
         char **envp;
-        char * filename;        /* Name of binary */
+        char *filename;        /* Name of binary */
 };

 void do_init_thread(struct target_pt_regs *regs, struct image_info *infop);
 abi_ulong loader_build_argptr(int envc, int argc, abi_ulong sp,
                               abi_ulong stringp, int push_ptr);
-int loader_exec(const char * filename, char ** argv, char ** envp,
-             struct target_pt_regs * regs, struct image_info *infop);
+int loader_exec(const char *filename, char **argv, char **envp,
+             struct target_pt_regs *regs, struct image_info *infop);

-int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
-                    struct image_info * info);
-int load_flt_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
-                    struct image_info * info);
+int load_elf_binary(struct linux_binprm *bprm, struct target_pt_regs *regs,
+                    struct image_info *info);
+int load_flt_binary(struct linux_binprm *bprm, struct target_pt_regs *regs,
+                    struct image_info *info);

 abi_long memcpy_to_target(abi_ulong dest, const void *src,
                           unsigned long len);
-- 
2.29.1.59.gf9b6481aed

