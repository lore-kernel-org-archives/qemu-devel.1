Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60699C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF242072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r88j6abD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF242072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihY79-0003NU-Mi
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2g-0005xO-VU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2f-0007tX-7b
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:02 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:55116)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2e-0007pi-SW
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:01 -0500
Received: by mail-wm1-x332.google.com with SMTP id b19so1551179wmj.4
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lQcQ8hHYJ9b8wR89sWSdLjNQioFt95lRtiBn1TJrwfs=;
 b=r88j6abDZc5HEwSRSlVxzAneVWBsiD9Ng2qBsfy0cI+jEHdQsSbPgAjjqaeyk1XGs4
 4MPsNAfcEOHcJySK1qcwrQ6XIuXiH4OQR9sivlWQTnXDsjC/Xgo0rJgc2jU4//32YMx/
 iU94PtQFXBiwLix987+umGllMMHdbaHA3PZi/AsF3IaVjkup9pYegqxqOp3KyKa3dkRm
 JHgELlme/90pb5NDeGWuriz+BccQwvUsQVA+v8+DW3a9l0YZjn2QLEr31X1HGgBncGv/
 BOeyKHP6/c3fJz3FD9i37ea6cIXsuP/ZdwK5Zwf9bmX14RybOWkVJ4POo1yuM4r+UMq+
 p1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=lQcQ8hHYJ9b8wR89sWSdLjNQioFt95lRtiBn1TJrwfs=;
 b=JJP2ApxFPHihed+C6/7zRLZjJSyLc8b9JD4lYp9vi57qVHFV3uItNiRpWW5C/42now
 kuykLN3jn0ThGvOWdKbz/w/t97h17bRESLAgWnulY2414xneXBili4fTwAKBcnZj7M/k
 smdtJ0RHkuEdmI0GZ6/zOleEOCFPp5I2Tq6CvkRzEiYe98RJPn37fdOYdTtFJNeOWDSq
 4YwgeDVn/yv+REaAlDGAKCGxwRlyzjKL2Hc1pCE1ckwLNKNdsD5CTBziX/vo8EvJLXJ3
 2AFg04mV5KTrvq6xXMAsnpJWfNpeRhfaw0m9lWbIEnf+OKBNOmaoxuoYlz1olAoNLZX5
 0RkA==
X-Gm-Message-State: APjAAAU9c1IQgk9A9RDyeNkqAeYHDU1+SfB8H+mRt4oMpWBOSt1eWFYU
 9DdiVv/bKb05UopuRvK7zIhCR5MF
X-Google-Smtp-Source: APXvYqwjcxTglWr+KY8LYDlrpO5+04SEvgB3V5jwKl/aeNtE86MGTyWM20++8CsfD+6w9ujKjxjG9g==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr2635340wmc.145.1576670579430; 
 Wed, 18 Dec 2019 04:02:59 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.02.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:02:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/87] migration-test: Move -machine to common commandline
Date: Wed, 18 Dec 2019 13:01:30 +0100
Message-Id: <1576670573-48048-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
index 0c01ed3..5a63158 100644
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



