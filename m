Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BF8C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A2720868
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLcsdEZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A2720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36242 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNf2-0004Ie-MK
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 08:58:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wzssyqa@gmail.com>) id 1hGNe8-0003y2-Vh
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wzssyqa@gmail.com>) id 1hGNe7-0000Xb-2x
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:08 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wzssyqa@gmail.com>) id 1hGNe4-0000UA-HT
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:05 -0400
Received: by mail-pf1-x443.google.com with SMTP id 8so10386845pfr.4
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=k7x2sFuioDEqvUFZlpcUlZt4Dq3LaEUtf/EE/DXfhXI=;
	b=SLcsdEZTZO9Z/BL8/a2ZkqzV31sRH4lhjrC6yI0beZtO8n+H3cGvW+npeq5zY34Yt0
	SouOinFid39P7Ka8mABuo378ZmPAf5hIO+nCV0baDpmO1AqxPwQNbCUTeHFF/rqQ1K8Q
	9IbS8Uoi1T1cWfRLbvvuUATblMXMxLI/cXm2t8S3gJ3jZ+CEyDUZfhlVTvlj0rP+NuGt
	kwOsrHJh/wnJZuyl5tieCMd8fQMSfzTxFd/WkZnuYUUP4S8EI4a8b/zWGgFEBXx8HmXJ
	LS3exlyQYeVxAsgDJPfqUVLuKr6hZOWDofTQyIQxb3UcI4vKRpicAj73EF3aBr0SNPjX
	/Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=k7x2sFuioDEqvUFZlpcUlZt4Dq3LaEUtf/EE/DXfhXI=;
	b=E/fW5vmeGsBrYPeyTJcaYumKZB4FzxQPsJTVKmiAG5u0TpcExg708MUjufrH1Lauj6
	OzrWDhoXy18uxgH4Wi1EHH7toDr87CZYNDdp2JDtwFfxGt3RqH6exXxVOJJXOz0BX26U
	/QJtFHXIR1bH6JYhEymVW0gwfjcSAgZ1QmLakFizjPjbGuUfXiNwBP2v+PM0PQohNh7q
	LIvnS3S6dz0L56QWbS2bI+RFs5Y8CCyVTdEsvJD9K9lJp7H0dCdm2hM406pfabNTscBM
	7rEgtxeRgJVOqD/VBDf8y+W4xRVc1rH02VdwytmFDJ4DxkQ74foMQMfStYa66NmTYjPI
	9gpw==
X-Gm-Message-State: APjAAAV7AS3ZJ7+wOq/RwX7j5TXyB48jDNgQxSU5CasMS1YBLhP0HiVd
	gbjCM4ZTq8X7jKfd8vGOI7s=
X-Google-Smtp-Source: APXvYqx3EsFbg649ELI/Ts1D5pLwY3X0puOG3t64BH26EoqbDILM22z/bMr1dGGMam+MeaOWGKcTMA==
X-Received: by 2002:a63:1203:: with SMTP id h3mr77638649pgl.164.1555419420306; 
	Tue, 16 Apr 2019 05:57:00 -0700 (PDT)
Received: from loongson.users.bfsu.cn ([2001:250:218:3698:d4c:a991:7c4e:a8bf])
	by smtp.gmail.com with ESMTPSA id
	f71sm90676390pfc.109.2019.04.16.05.56.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:56:59 -0700 (PDT)
From: YunQiang Su <syq@debian.org>
To: linux-fsdevel@vger.kernel.org
Date: Tue, 16 Apr 2019 20:56:41 +0800
Message-Id: <20190416125641.3068-1-syq@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH] binfmt_misc: pass info about P flag by AT_FLAGS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pburton@wavecomp.com, YunQiang Su <ysu@wavecomp.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125641.zpNYaJ0_YdzaHVWRtJRjhHh_HwbDeb2fRNOTv9Tz6ZI@z>

From: YunQiang Su <ysu@wavecomp.com>

Currently program invoked by binfmt_misc cannot be aware about whether
P flag, aka preserve path is enabled.

Some applications like qemu need to know since it has 2 use case:
  1. call by hand, like: qemu-mipsel-static test.app OPTION
     so, qemu have to assume that P option is not enabled.
  2. call by binfmt_misc. If qemu cannot know about whether P flag is
     enabled, distribution's have to set qemu without P flag, and
     binfmt_misc call qemu like:
       qemu-mipsel-static /absolute/path/to/test.app OPTION
     even test.app is not called by absoulute path, like
       ./relative/path/to/test.app

This patch passes this information by the 3rd bits of unused AT_FLAGS.
Then, in qemu, we can get this info by:
   getauxval(AT_FLAGS) & (1<<3)

See: https://bugs.launchpad.net/qemu/+bug/1818483
Signed-off-by: YunQiang Su <ysu@wavecomp.com>
---
 fs/binfmt_elf.c         | 6 +++++-
 fs/binfmt_elf_fdpic.c   | 9 +++++++--
 fs/binfmt_misc.c        | 2 ++
 include/linux/binfmts.h | 4 ++++
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 09e76b25d833..30688fbad615 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -175,6 +175,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	unsigned char k_rand_bytes[16];
 	int items;
 	elf_addr_t *elf_info;
+	elf_addr_t flags = 0;
 	int ei_index = 0;
 	const struct cred *cred = current_cred();
 	struct vm_area_struct *vma;
@@ -249,7 +250,10 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
-	NEW_AUX_ENT(AT_FLAGS, 0);
+	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0) {
+		flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
+	}
+	NEW_AUX_ENT(AT_FLAGS, flags);
 	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
 	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index b53bb3729ac1..ba3385be00fb 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -46,7 +46,7 @@
 
 typedef char *elf_caddr_t;
 
-#if 0
+#if 1
 #define kdebug(fmt, ...) printk("FDPIC "fmt"\n" ,##__VA_ARGS__ )
 #else
 #define kdebug(fmt, ...) do {} while(0)
@@ -511,6 +511,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	char __user *u_platform, *u_base_platform, *p;
 	int loop;
 	int nr;	/* reset for each csp adjustment */
+	unsigned long flags = 0;
 
 #ifdef CONFIG_MMU
 	/* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
@@ -651,7 +652,11 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
 	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
-	NEW_AUX_ENT(AT_FLAGS,	0);
+	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0) {
+		flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
+	}
+	kdebug("AT_FLAGS %ld\n", flags);
+	NEW_AUX_ENT(AT_FLAGS,	flags);
 	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
 	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index aa4a7a23ff99..46c509cd096e 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -156,6 +156,8 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		retval = remove_arg_zero(bprm);
 		if (retval)
 			goto ret;
+	} else {
+		bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
 	}
 
 	if (fmt->flags & MISC_FMT_OPEN_BINARY) {
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 688ab0de7810..c082650a0310 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -77,6 +77,10 @@ struct linux_binprm {
 #define BINPRM_FLAGS_PATH_INACCESSIBLE_BIT 2
 #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 << BINPRM_FLAGS_PATH_INACCESSIBLE_BIT)
 
+/* if preserve the argv0 for the interpreter  */
+#define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
+#define BINPRM_FLAGS_PRESERVE_ARGV0 (1 << BINPRM_FLAGS_PRESERVE_ARGV0_BIT)
+
 /* Function parameter for binfmt->coredump */
 struct coredump_params {
 	const kernel_siginfo_t *siginfo;
-- 
2.20.1


