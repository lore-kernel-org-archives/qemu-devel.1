Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01436C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42A12072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2JlhvMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42A12072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYBr-000288-DZ
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2k-00062c-Pr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2j-0008Do-BE
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:06 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:39949)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2j-00089L-0u
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:05 -0500
Received: by mail-wm1-x32e.google.com with SMTP id t14so1598790wmi.5
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZHJ4rnTOgWg//hYbF0PT3ZZVPprY5k8HnSbmiQGtXFc=;
 b=n2JlhvMfw9DJoxJpcLkfSZYJBYzPSywvJp/+MZ1qtUkTcE2AczAYwGXWN6Ee8g8Zbd
 s20s8kPBuqQ0rNZ807AqiIdDOiOGPL2g3uchGPGnb57YiB1Lwv9rHPwhD0AX0zyl/rDK
 zcQWYwKNW6mRUKKv2tgyBXwwSq2HrCuUzJR2VYc9mv+GWybSyNEeKbZz/02US2SEGrYF
 9lgBj9EbNx7aQfOfpSv8QBUSf9k0VUgFPwqPLtEKwzqs/pRdQIgeIRilCyRqBTzPUW4d
 5BUl+/PCCleEOT+OGYId68agKA0QU0SyL5YqHAkXXJI7qc4tDokHg5yDAQmfwHwU3WZR
 5Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ZHJ4rnTOgWg//hYbF0PT3ZZVPprY5k8HnSbmiQGtXFc=;
 b=pU7MSolBxN/1JSBlJcztyptiPUvhiHkp2NpWB6pQxou5Sx6oAs0/K6RUiohQV+/4zj
 MGYllo72fRrehvPWsPMHEepGi0ivBtS5TS4c3L29UDSmS76ljC1SFDaMadNoSj3I7OjX
 d3MTBXiXvV9AOrbeCYQiuxcEv35ZliWuZxaCNhLOsk+yO8eTkyXfBrDcSQ61kVE6RVgs
 omrxduYjaUNg/0EngpIh4MQFN7Y4WKXYudHhlfl/yyrMTVvgSCzC4kl7MQ1asGnfH6Up
 X47R9Xh5vbwi6ErOtrUbo59nhCX0DIILx5a7n9xO8Shj969CDnpgkEmF1At8h6XLME/S
 ROVw==
X-Gm-Message-State: APjAAAWzT1L6i1aaZm7F2I4gTptvlz7HMunYAPjVxUhByXzDSs/T6v3e
 Fi2JeYdbFUh0P7Rf/TC5SMF75VIc
X-Google-Smtp-Source: APXvYqzr94oMQB1P75dHIpL3Wm2H++lcaN3aQJtaiI0Cf72mZGdLCUlP6gi8sED4rqtnKddqosh3Jw==
X-Received: by 2002:a1c:e91a:: with SMTP id q26mr2842927wmc.59.1576670583779; 
 Wed, 18 Dec 2019 04:03:03 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/87] migration-test: Move -serial handling to common
 commandline
Date: Wed, 18 Dec 2019 13:01:34 +0100
Message-Id: <1576670573-48048-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
 tests/migration-test.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 6e828fb..e1304d7 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -579,13 +579,10 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "";
         machine_args = "";
         memory_size = "150M";
-        cmd_src = g_strdup_printf(" -serial file:%s/src_serial"
-                                  " -drive file=%s,format=raw",
-                                  tmpfs, bootpath);
-        cmd_dst = g_strdup_printf(" -serial file:%s/dest_serial"
-                                  " -drive file=%s,format=raw"
+        cmd_src = g_strdup_printf("-drive file=%s,format=raw", bootpath);
+        cmd_dst = g_strdup_printf("-drive file=%s,format=raw"
                                   " -incoming %s",
-                                  tmpfs, bootpath, uri);
+                                  bootpath, uri);
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
@@ -593,28 +590,22 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "";
         machine_args = "";
         memory_size = "128M";
-        cmd_src = g_strdup_printf(" -serial file:%s/src_serial -bios %s",
-                                  tmpfs, bootpath);
-        cmd_dst = g_strdup_printf(" -serial file:%s/dest_serial -bios %s"
+        cmd_src = g_strdup_printf("-bios %s", bootpath);
+        cmd_dst = g_strdup_printf("-bios %s"
                                   " -incoming %s",
-                                  tmpfs, bootpath, uri);
+                                  bootpath, uri);
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
         machine_type = "";
         machine_args = ",vsmt=8";
         memory_size = "256M";
-        cmd_src = g_strdup_printf("-nodefaults"
-                                  " -serial file:%s/src_serial"
-                                  " -prom-env 'use-nvramrc?=true' -prom-env "
+        cmd_src = g_strdup_printf("-nodefaults "
+                                  "-prom-env 'use-nvramrc?=true' -prom-env "
                                   "'nvramrc=hex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                  "until'", tmpfs, end_address,
-                                  start_address);
-        cmd_dst = g_strdup_printf(" -serial file:%s/dest_serial"
-                                  " -incoming %s",
-                                  tmpfs, uri);
-
+                                  "until'", end_address, start_address);
+        cmd_dst = g_strdup_printf(" -incoming %s", uri);
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") == 0) {
@@ -623,14 +614,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_args = "gic-version=max";
         memory_size = "150M";
         cmd_src = g_strdup_printf("-cpu max "
-                                  "-serial file:%s/src_serial "
                                   "-kernel %s",
-                                  tmpfs, bootpath);
+                                  bootpath);
         cmd_dst = g_strdup_printf("-cpu max "
-                                  "-serial file:%s/dest_serial "
                                   "-kernel %s "
                                   "-incoming %s",
-                                  tmpfs, bootpath, uri);
+                                  bootpath, uri);
 
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
@@ -661,10 +650,11 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
     cmd_source = g_strdup_printf("-machine %saccel=kvm:tcg%s "
                                  "-name source,debug-threads=on "
+                                 "-serial file:%s/src_serial "
                                  "-m %s "
                                  "%s %s %s %s",
                                  machine_type, machine_args,
-                                 memory_size,
+                                 tmpfs, memory_size,
                                  cmd_src, shmem_opts, opts_src, ignore_stderr);
     g_free(cmd_src);
     *from = qtest_init(cmd_source);
@@ -673,9 +663,10 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     cmd_target = g_strdup_printf("-machine %saccel=kvm:tcg%s "
                                  "-name target,debug-threads=on "
                                  "-m %s "
+                                 "-serial file:%s/dest_serial "
                                  "%s %s %s %s",
                                  machine_type, machine_args,
-                                 memory_size,
+                                 tmpfs, memory_size,
                                  cmd_dst, shmem_opts, opts_dst, ignore_stderr);
     g_free(cmd_dst);
     *to = qtest_init(cmd_target);
-- 
1.8.3.1



