Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E32C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAA0206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdZRFVcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAA0206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtMg-0005dv-MO
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEt-0004cw-6S
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEr-0006rG-Ln
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:55 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:53201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtEr-0006pK-EY
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:53 -0500
Received: by mail-wm1-x333.google.com with SMTP id p9so7441606wmc.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zxw60BFwP9AwKgv+HLe1mvNusF8kvgQh66UrHOxl68E=;
 b=QdZRFVcdwMej2Q3oFFPXBHUAvBJ0eSsULRvYcIjxdfkSwXIWicjYGctNQE6UkVDt6x
 Fbwz9vsvOQ2zoJEMlURkJwgj3Rs4qjg4pFUGrkj28A94IPLwdYpOeo24/pCQmkwY9OHr
 7Ff6W+L7KYB5gLY7NQ74KNeMPIz9vyzMUEmf96R7pTleMs8O5gJhiPgtJrTidzYVYCKZ
 rcu3pAcIoFDkQp3KToOQyOYht4oLDOU4o0d30yoStTpHiX+waCSsPcxMKh1yuVALuK+S
 kyw6ls7fh9oA/PM5AMfukIzpFYsdvQsOOHl9WS1/ZYjxTxNIShn61cQsWhTj9gkEUCSG
 nq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=zxw60BFwP9AwKgv+HLe1mvNusF8kvgQh66UrHOxl68E=;
 b=AC88p/MXirOnruZacNQSRgk7n4VcLXTwzfya5YRGT9uyn1vtylieEavhJSzceHYlBH
 zqzMc8807plVGj5mVubaN4sidQCWrhK+4izz0F7gV4JN0JgUT1SmRQssSvQ7DUjhol2n
 jQ9gW2z29WuKe+pvygQK74enLVNXCh6l2bUTnEgXGB1EUASVHj5VTflihiWBqEbtXRwx
 xnp1ZnScJZDLYibHrnEU2D7Zm4qXSFnUr9DD+nA/+Jiczn4x6upxr9zuNx+3tsLZVX+q
 ApaehhQAdj6NFy2qXPYfIXP7jZBxipH0P/T2nID7LnzRVqrVDEaU3iXXDzZE5kb08+rA
 PDfQ==
X-Gm-Message-State: APjAAAUSF4hRclorXyIAUDj8LSjrsyrKWoBdUDKDFPPMKod5vVVEBAoI
 LmzVo2sYdD9BBYZuSt1ljdn+ovA/
X-Google-Smtp-Source: APXvYqxlmTlz99F5WQ+eqvCP9SfD6V9jXzl5mA2E4vdNhlw/lwzipLX035ClCG2OZX/v2wxpGA9heA==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr4427109wmb.80.1576513732103;
 Mon, 16 Dec 2019 08:28:52 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.28.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:28:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/62] migration-test: Move -machine to common commandline
Date: Mon, 16 Dec 2019 17:27:48 +0100
Message-Id: <1576513726-53700-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Juan Quintela <quintela@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com> #s390x
Tested-by: Laurent Vivier <lvivier@redhat.com>
---
 tests/migration-test.c | 51 +++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 372e66c..39203f6 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -563,7 +563,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     char *extra_opts = NULL;
     char *shmem_path = NULL;
     const char *arch = qtest_get_arch();
-    const char *accel = "kvm:tcg";
+    const char *machine_type;
+    const char *machine_args;
 
     opts_src = opts_src ? opts_src : "";
     opts_dst = opts_dst ? opts_dst : "";
@@ -582,72 +583,78 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         /* the assembled x86 boot sector should be exactly one sector large */
         assert(sizeof(x86_bootsect) == 512);
         init_bootfile(bootpath, x86_bootsect, sizeof(x86_bootsect));
+        machine_type = "";
+        machine_args = "";
         extra_opts = use_shmem ? get_shmem_opts("150M", shmem_path) : NULL;
-        cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
+        cmd_src = g_strdup_printf("-m 150M"
                                   " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
                                   " -drive file=%s,format=raw %s",
-                                  accel, tmpfs, bootpath,
+                                  tmpfs, bootpath,
                                   extra_opts ? extra_opts : "");
-        cmd_dst = g_strdup_printf("-machine accel=%s -m 150M"
+        cmd_dst = g_strdup_printf("-m 150M"
                                   " -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=%s,format=raw"
                                   " -incoming %s %s",
-                                  accel, tmpfs, bootpath, uri,
+                                  tmpfs, bootpath, uri,
                                   extra_opts ? extra_opts : "");
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
         init_bootfile(bootpath, s390x_elf, sizeof(s390x_elf));
+        machine_type = "";
+        machine_args = "";
         extra_opts = use_shmem ? get_shmem_opts("128M", shmem_path) : NULL;
-        cmd_src = g_strdup_printf("-machine accel=%s -m 128M"
+        cmd_src = g_strdup_printf("-m 128M"
                                   " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial -bios %s %s",
-                                  accel, tmpfs, bootpath,
+                                  tmpfs, bootpath,
                                   extra_opts ? extra_opts : "");
-        cmd_dst = g_strdup_printf("-machine accel=%s -m 128M"
+        cmd_dst = g_strdup_printf("-m 128M"
                                   " -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial -bios %s"
                                   " -incoming %s %s",
-                                  accel, tmpfs, bootpath, uri,
+                                  tmpfs, bootpath, uri,
                                   extra_opts ? extra_opts : "");
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
+        machine_type = "";
+        machine_args = ",vsmt=8";
         extra_opts = use_shmem ? get_shmem_opts("256M", shmem_path) : NULL;
-        cmd_src = g_strdup_printf("-machine accel=%s,vsmt=8 -m 256M -nodefaults"
+        cmd_src = g_strdup_printf("-m 256M -nodefaults"
                                   " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
                                   " -prom-env 'use-nvramrc?=true' -prom-env "
                                   "'nvramrc=hex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                  "until' %s",  accel, tmpfs, end_address,
+                                  "until' %s", tmpfs, end_address,
                                   start_address, extra_opts ? extra_opts : "");
-        cmd_dst = g_strdup_printf("-machine accel=%s,vsmt=8 -m 256M"
+        cmd_dst = g_strdup_printf("-m 256M"
                                   " -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
                                   " -incoming %s %s",
-                                  accel, tmpfs, uri,
+                                  tmpfs, uri,
                                   extra_opts ? extra_opts : "");
 
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") == 0) {
         init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
+        machine_type = "virt,";
+        machine_args = "gic-version=max";
         extra_opts = use_shmem ? get_shmem_opts("150M", shmem_path) : NULL;
-        cmd_src = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
-                                  "-name vmsource,debug-threads=on -cpu max "
+        cmd_src = g_strdup_printf("-name vmsource,debug-threads=on -cpu max "
                                   "-m 150M -serial file:%s/src_serial "
                                   "-kernel %s %s",
-                                  accel, tmpfs, bootpath,
+                                  tmpfs, bootpath,
                                   extra_opts ? extra_opts : "");
-        cmd_dst = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
-                                  "-name vmdest,debug-threads=on -cpu max "
+        cmd_dst = g_strdup_printf("-name vmdest,debug-threads=on -cpu max "
                                   "-m 150M -serial file:%s/dest_serial "
                                   "-kernel %s "
                                   "-incoming %s %s",
-                                  accel, tmpfs, bootpath, uri,
+                                  tmpfs, bootpath, uri,
                                   extra_opts ? extra_opts : "");
 
         start_address = ARM_TEST_MEM_START;
@@ -667,13 +674,15 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         ignore_stderr = "";
     }
 
-    cmd_source = g_strdup_printf("%s %s %s",
+    cmd_source = g_strdup_printf("-machine %saccel=kvm:tcg%s %s %s %s",
+                                 machine_type, machine_args,
                                  cmd_src, opts_src, ignore_stderr);
     g_free(cmd_src);
     *from = qtest_init(cmd_source);
     g_free(cmd_source);
 
-    cmd_target = g_strdup_printf("%s %s %s",
+    cmd_target = g_strdup_printf("-machine %saccel=kvm:tcg%s %s %s %s",
+                                 machine_type, machine_args,
                                  cmd_dst, opts_dst, ignore_stderr);
     g_free(cmd_dst);
     *to = qtest_init(cmd_target);
-- 
1.8.3.1



