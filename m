Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D13C3F68F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7278F206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jec2Sint"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7278F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtGi-0006XW-46
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEr-0004am-3m
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEp-0006nQ-QV
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:53 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtEp-0006lY-JV
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:51 -0500
Received: by mail-wm1-x331.google.com with SMTP id m24so6034095wmc.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=J+zE46psqR1GZS+L/bb3YayL7qrQQaatDScX4KthbS4=;
 b=Jec2SintNr4xwAauSRLTtsVVllsrpOpePMK7nDBpaXfUG8ekDCh2wlobS+ynwkbCIU
 rdtU1Fs/U/tMosyzm7gBxAPmznsuahVL613/PQUSFbggfF9ZJMySgpTrslBqdn9d+zQx
 o91tlShWhBwGwT8UcElNNcuxCxmnOxyam8EoIh9XWjKiL9wt8OXvnGAVqeRSOfnOcplZ
 qS+8wSYbNx1O8RWnTnSwjABzm9gpsfgxzuK9q5DjpW8mAx6tf/vNBfcV8W3jfW7RXxfj
 vgla7Vtnd7x+/xPjCVT1b0x0ugxnjRBbebriOUPfuk1Kwvlna7FJXnm4uP3JWAumFhDh
 BV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=J+zE46psqR1GZS+L/bb3YayL7qrQQaatDScX4KthbS4=;
 b=dP51Gh3lkop+ovfkc87Ook6+MRfZBI+oCIbY+pvAo2jStL0Y9v2Vbb881hfOhnocPX
 uazPE/9Fy/ZhGKbvVl/CVvnL7qWIB7Z5OZ0vTEDLv1zfoiE8ufp5iOIWU3ZKNfkh2ra3
 Z9nhAIEez5e7ezJrQTVhAKYNG0g6jGzI7AvKPdzSsGvtUqdIsJrjKp1zJsoDSepo4jS6
 gtlZes7FOvhWUSGpFdzzVFthVKosSfB8nh7qwKCYCkVNFenhp4eYu/obDv2W8K/wxwgK
 Aek80Vx1dCDm+WEEbVNn4twuCtlWPBPD3aNT95drIedZmefU3mY3aBlLkCw75djdcES6
 5a6Q==
X-Gm-Message-State: APjAAAUdPbqLWmjhQjjihYURxmKmpbIsjMi3ZhE3uREZgWOMB7VJwmHI
 QlurY7xFb6KK7NigAMdZbnHRTrNg
X-Google-Smtp-Source: APXvYqxNesnTusSI37ikuQbHRPdBLL/ZlYVUtROHfXJ90lNS+XyVS2KzMptV8Qu9njiNNe+FB6UI2w==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr31375948wmj.96.1576513730304; 
 Mon, 16 Dec 2019 08:28:50 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.28.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:28:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/62] migration-test: Create cmd_soure and cmd_target
Date: Mon, 16 Dec 2019 17:27:46 +0100
Message-Id: <1576513726-53700-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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

We are repeating almost everything for each machine while creating the
command line for migration.  And once for source and another for
destination.  We start putting there opts_src and opts_dst.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com> #s390x
Tested-by: Laurent Vivier <lvivier@redhat.com>
---
 tests/migration-test.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index ebd77a5..9573861 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -557,6 +557,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                const char *opts_dst)
 {
     gchar *cmd_src, *cmd_dst;
+    gchar *cmd_source, *cmd_target;
     char *bootpath = NULL;
     char *extra_opts = NULL;
     char *shmem_path = NULL;
@@ -584,16 +585,16 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
                                   " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
-                                  " -drive file=%s,format=raw %s %s",
+                                  " -drive file=%s,format=raw %s",
                                   accel, tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "", opts_src);
+                                  extra_opts ? extra_opts : "");
         cmd_dst = g_strdup_printf("-machine accel=%s -m 150M"
                                   " -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=%s,format=raw"
-                                  " -incoming %s %s %s",
+                                  " -incoming %s %s",
                                   accel, tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "", opts_dst);
+                                  extra_opts ? extra_opts : "");
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
@@ -601,15 +602,15 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         extra_opts = use_shmem ? get_shmem_opts("128M", shmem_path) : NULL;
         cmd_src = g_strdup_printf("-machine accel=%s -m 128M"
                                   " -name source,debug-threads=on"
-                                  " -serial file:%s/src_serial -bios %s %s %s",
+                                  " -serial file:%s/src_serial -bios %s %s",
                                   accel, tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "", opts_src);
+                                  extra_opts ? extra_opts : "");
         cmd_dst = g_strdup_printf("-machine accel=%s -m 128M"
                                   " -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial -bios %s"
-                                  " -incoming %s %s %s",
+                                  " -incoming %s %s",
                                   accel, tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "", opts_dst);
+                                  extra_opts ? extra_opts : "");
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
@@ -620,15 +621,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                   " -prom-env 'use-nvramrc?=true' -prom-env "
                                   "'nvramrc=hex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                  "until' %s %s",  accel, tmpfs, end_address,
-                                  start_address, extra_opts ? extra_opts : "",
-                                  opts_src);
+                                  "until' %s",  accel, tmpfs, end_address,
+                                  start_address, extra_opts ? extra_opts : "");
         cmd_dst = g_strdup_printf("-machine accel=%s,vsmt=8 -m 256M"
                                   " -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
-                                  " -incoming %s %s %s",
+                                  " -incoming %s %s",
                                   accel, tmpfs, uri,
-                                  extra_opts ? extra_opts : "", opts_dst);
+                                  extra_opts ? extra_opts : "");
 
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
@@ -638,16 +638,16 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         cmd_src = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
                                   "-name vmsource,debug-threads=on -cpu max "
                                   "-m 150M -serial file:%s/src_serial "
-                                  "-kernel %s %s %s",
+                                  "-kernel %s %s",
                                   accel, tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "", opts_src);
+                                  extra_opts ? extra_opts : "");
         cmd_dst = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
                                   "-name vmdest,debug-threads=on -cpu max "
                                   "-m 150M -serial file:%s/dest_serial "
                                   "-kernel %s "
-                                  "-incoming %s %s %s",
+                                  "-incoming %s %s",
                                   accel, tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "", opts_dst);
+                                  extra_opts ? extra_opts : "");
 
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
@@ -671,11 +671,17 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         cmd_dst = tmp;
     }
 
-    *from = qtest_init(cmd_src);
+    cmd_source = g_strdup_printf("%s %s",
+                                 cmd_src, opts_src);
     g_free(cmd_src);
+    *from = qtest_init(cmd_source);
+    g_free(cmd_source);
 
-    *to = qtest_init(cmd_dst);
+    cmd_target = g_strdup_printf("%s %s",
+                                 cmd_dst, opts_dst);
     g_free(cmd_dst);
+    *to = qtest_init(cmd_target);
+    g_free(cmd_target);
 
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
-- 
1.8.3.1



