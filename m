Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CE9C3F68F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D9F206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq0aGq9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D9F206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtS3-0004yV-Ps
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEy-0004kn-Cb
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEx-00072W-1R
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:00 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:35818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtEw-000716-Qv
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:58 -0500
Received: by mail-wm1-x32f.google.com with SMTP id p17so7413115wmb.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cNBpnObxWBVztSPS/48mA1SEs15cBP9TJArik3nLB+U=;
 b=Oq0aGq9bW19PtQ1OcuJdaJQlHoYPpS+i3IJ60/IrMscJAHHZBgPPsrwUgFSJMg9OWf
 Fpk95fhVTZR4rkJYfgmw/N52yTszBpCJ642CEgAtRcrvpaaPpqhnkpfi6vaenHgk2rVS
 0NR2zgQZS7xjEB87ty3gYDkNUh6dBg0vDMkbPu8L+rj6Qy2gXw+4xK4DD/Jt74z9Y4x/
 tP7OVClOiMdwH3SXdwxaggynI+EqWiRPbmEqLmHYK1+5MY4dZ/PSRQU0PlMqMeiMDMpU
 4bPHOnXoBlC4wCArPyI4d5gFUfyU0Z0qyyj0756/HU2kVTcIsFtfMCTUyiD0xXSkd96C
 /Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=cNBpnObxWBVztSPS/48mA1SEs15cBP9TJArik3nLB+U=;
 b=gLBZWFFtXUgSFSJ0eVQihhGS0GWg90qIa0k6IFTlvixU5QLuJtTmmXiqXedM7LQqxB
 8yQaDjkfHepHYMPIR3DNZhezBkiF2LF+H+u7FEnoUba9WuOj3tZVJsRdL1s4W1OcN8yX
 yBOltcy7PolsP0NOLUTGDyKxhtpV66f6u0EbCPVq49FfSn2sGrTBh/yNqIA/8ieyhwrM
 eysebi1jf0KDdEE3i0UcSbtYn0hGVDV1//bNGBjH9KTtH4kR3Ux9CruFKFIgDmY5iYHL
 CiUH2BCfkJ6AkI1ri3Vl+uUpEOJFAfKb9wEweuP0bBXLNC/AvynX3l82vLZU8y9wN0P2
 rEpQ==
X-Gm-Message-State: APjAAAWtWvQPRBwPPUVRNAgDXoxYffBRvfwu8+023Gj0BAcG86DNAPh5
 1a4UfnqpZoAwze5afvo/Nwaqy52a
X-Google-Smtp-Source: APXvYqy7nobk8PMef4mwNyz7lwt1sP2c6Aa6ZRGWmccFaQLstd5uePvRJU7DnH7NaE56jnKA6JNn1g==
X-Received: by 2002:a1c:486:: with SMTP id 128mr32218822wme.163.1576513737600; 
 Mon, 16 Dec 2019 08:28:57 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.28.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:28:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/62] migration-test: Rename cmd_src/dst to
 arch_source/arch_target
Date: Mon, 16 Dec 2019 17:27:54 +0100
Message-Id: <1576513726-53700-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

This explains better what they do and avoid confussino with
command_src/target.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com> #s390x
Tested-by: Laurent Vivier <lvivier@redhat.com>
---
 tests/migration-test.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 5ab8cfd..6c7c416 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -549,7 +549,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                bool use_shmem, const char *opts_src,
                                const char *opts_dst)
 {
-    gchar *cmd_src, *cmd_dst;
+    gchar *arch_source, *arch_target;
     gchar *cmd_source, *cmd_target;
     const gchar *ignore_stderr;
     char *bootpath = NULL;
@@ -579,8 +579,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "";
         machine_args = "";
         memory_size = "150M";
-        cmd_src = g_strdup_printf("-drive file=%s,format=raw", bootpath);
-        cmd_dst = g_strdup(cmd_src);
+        arch_source = g_strdup_printf("-drive file=%s,format=raw", bootpath);
+        arch_target = g_strdup(arch_source);
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
@@ -588,20 +588,20 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "";
         machine_args = "";
         memory_size = "128M";
-        cmd_src = g_strdup_printf("-bios %s", bootpath);
-        cmd_dst = g_strdup(cmd_src);
+        arch_source = g_strdup_printf("-bios %s", bootpath);
+        arch_target = g_strdup(arch_source);
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
         machine_type = "";
         machine_args = ",vsmt=8";
         memory_size = "256M";
-        cmd_src = g_strdup_printf("-nodefaults "
-                                  "-prom-env 'use-nvramrc?=true' -prom-env "
-                                  "'nvramrc=hex .\" _\" begin %x %x "
-                                  "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                  "until'", end_address, start_address);
-        cmd_dst = g_strdup("");
+        arch_source = g_strdup_printf("-nodefaults "
+                                      "-prom-env 'use-nvramrc?=true' -prom-env "
+                                      "'nvramrc=hex .\" _\" begin %x %x "
+                                      "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
+                                      "until'", end_address, start_address);
+        arch_target = g_strdup("");
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") == 0) {
@@ -609,10 +609,10 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "virt,";
         machine_args = "gic-version=max";
         memory_size = "150M";
-        cmd_src = g_strdup_printf("-cpu max "
-                                  "-kernel %s",
-                                  bootpath);
-        cmd_dst = g_strdup(cmd_src);
+        arch_source = g_strdup_printf("-cpu max "
+                                      "-kernel %s",
+                                      bootpath);
+        arch_target = g_strdup(arch_source);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
 
@@ -647,8 +647,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size, tmpfs,
-                                 cmd_src, shmem_opts, opts_src, ignore_stderr);
-    g_free(cmd_src);
+                                 arch_source, shmem_opts, opts_src,
+                                 ignore_stderr);
+    g_free(arch_source);
     *from = qtest_init(cmd_source);
     g_free(cmd_source);
 
@@ -660,8 +661,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size, tmpfs, uri,
-                                 cmd_dst, shmem_opts, opts_dst, ignore_stderr);
-    g_free(cmd_dst);
+                                 arch_target, shmem_opts, opts_dst,
+                                 ignore_stderr);
+    g_free(arch_target);
     *to = qtest_init(cmd_target);
     g_free(cmd_target);
 
-- 
1.8.3.1



