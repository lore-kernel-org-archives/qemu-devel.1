Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5041BC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D67218DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP/eq3lS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D67218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFysf-0004EB-Qn
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 07:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFypb-0002TN-B4
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFypQ-0003vM-S8
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:59:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:38843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFypP-0003rk-7b
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:59:24 -0400
Received: by mail-wr1-x42a.google.com with SMTP id w12so2459370wro.5
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 03:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9Caa9lmxYku0TI+IX4UueSarN2JqoHdq0kQX92eOwIw=;
 b=DP/eq3lSRE6liFwvhjqSrQ8xjd9W9NvO4zQqXE5HIxYAiEb8byVWdwsF/Ssps1/Uev
 eyx0XbGwq39Q315S4zKE/ISRn93lHDFPoOSHj9PB8vWEJH6MwBYAZ8N6VOgkh4zZ1isG
 kJLncynkRgy9nuY7ONNKFslGwMHWlUm/eXd3IMFStjUlGj7G2oRLA3TaRoOUkPy5ZBub
 h8Q7o/P6zkezqefEgP13h0H1qOow8ohFQ6l3aZYiT2xstTmEGDr8KlCGoe1Uz4o2XQQY
 8gcBuNr30fvnzBFPNEJrAsNiAwX60txZR7arP8S0wrErM1pTV3xiWQL/3B9xPUQyHIl5
 ouGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=9Caa9lmxYku0TI+IX4UueSarN2JqoHdq0kQX92eOwIw=;
 b=EZUzAwduU5ioZiD+bs0X3GxzBao2x6VzgpwcxRA4wFxHymAhOoTeOW2RFYIHZiSU61
 Akz4P0NFdSC0bf55XUPjYnaMM7cEkeUtSIpyyZMa/detJX0pDJkl8WtDZI7t3Zgpu/Yz
 dI8oI2CvvbZbrloQQR9Cubpl4IiBRhkQUJJlmhROr/BIlCwCcBdJEb8hJSXXjhm3wI0J
 6obWY+nipM4cgm6Aq7X4KUJJ2h0uhY0SdhFBRzXhqAm3IydSBRVzRMHnD1iaay/2/J3l
 +kbvXmElP1A2ytF+ybWp5YQhzISKLpQV1BgbuH5nxTQ27VtFl7OD/ohWaSqNaT5sd4EA
 cSqw==
X-Gm-Message-State: APjAAAXRLZ6/WMglGdlG6dWQKcrGZUxZiEVaNWCxEHxXubrLIRIvEavi
 Et2bxHJM51TIbwE4KOAz5vxh1Z7F
X-Google-Smtp-Source: APXvYqxPGuHcjiVCeEuZV6vgyYbvGCZ0pZ0XR8vkUoyeX2PbzJEzQ6sTLoOxY+c1QV0R5MOVCkj+UQ==
X-Received: by 2002:adf:dbc6:: with SMTP id e6mr6486748wrj.149.1570100360512; 
 Thu, 03 Oct 2019 03:59:20 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id l10sm3391485wrh.20.2019.10.03.03.59.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Oct 2019 03:59:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/30] Misc patches for 2010-10-02
Date: Thu,  3 Oct 2019 12:59:17 +0200
Message-Id: <1570100358-22344-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: Thomas Huth <thuth@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 James Le Cuirot <chewi@gentoo.org>, Maxim Levitsky <mlevitsk@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Eric Auger <eric.auger@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Poletaev <poletaev@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7f21573c822805a8e6be379d9bcf3ad9effef3dc:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-10-01' into staging (2019-10-01 13:13:38 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 52c8850d80c5bf34afd3b203b912217f45327a9e:

  accel/kvm: ensure ret always set (2019-10-02 18:37:27 +0200)

----------------------------------------------------------------
* Compilation fix for KVM (Alex)
* SMM fix (Dmitry)
* VFIO error reporting (Eric)
* win32 fixes and workarounds (Marc-André)
* qemu-pr-helper crash bugfix (Maxim)
* VMX feature flags (myself)
* Memory leak fixes (myself)
* Record-replay deadlock (Pavel)
* i386 CPUID bits (Sebastian)
* kconfig tweak (Thomas)
* Valgrind fix (Thomas)
* distclean improvement (Thomas)
* Autoconverge test (Yury)

----------------------------------------------------------------
Alex Bennée (1):
      accel/kvm: ensure ret always set

Dmitry Poletaev (1):
      Fix wrong behavior of cpu_memory_rw_debug() function in SMM

Eric Auger (2):
      vfio: Turn the container error into an Error handle
      memory: allow memory_region_register_iommu_notifier() to fail

Marc-André Lureau (3):
      util: WSAEWOULDBLOCK on connect should map to EINPROGRESS
      tests: skip serial test on windows
      win32: work around main-loop busy loop on socket/fd event

Maxim Levitsky (1):
      qemu-pr-helper: fix crash in mpath_reconstruct_sense

Paolo Bonzini (16):
      target/i386: handle filtered_features in a new function mark_unavailable_features
      target/i386: introduce generic feature dependency mechanism
      target/i386: expand feature words to 64 bits
      target/i386: add VMX definitions
      vmxcap: correct the name of the variables
      target/i386: add VMX features
      target/i386: work around KVM_GET_MSRS bug for secondary execution controls
      ide: fix leak from qemu_allocate_irqs
      microblaze: fix leak of fdevice tree blob
      mcf5208: fix leak from qemu_allocate_irqs
      hppa: fix leak from g_strdup_printf
      mips: fix memory leaks in board initialization
      cris: do not leak struct cris_disasm_data
      lm32: do not leak memory on object_new/object_unref
      docker: test-debug: disable LeakSanitizer
      tests/docker: only enable ubsan for test-clang

Pavel Dovgaluk (1):
      replay: don't synchronize memory operations in replay mode

Sebastian Andrzej Siewior (1):
      i386: Add CPUID bit for CLZERO and XSAVEERPTR

Thomas Huth (3):
      target/i386/kvm: Silence warning from Valgrind about uninitialized bytes
      Makefile: Remove generated files when doing 'distclean'
      hw/isa: Introduce a CONFIG_ISA_SUPERIO switch for isa-superio.c

Yury Kotov (1):
      tests/migration: Add a test for auto converge

 Makefile                      |   6 +-
 accel/kvm/kvm-all.c           |   6 +-
 disas/cris.c                  |  59 +++---
 exec.c                        |  23 ++-
 hw/arm/smmuv3.c               |  18 +-
 hw/hppa/dino.c                |   1 +
 hw/hppa/machine.c             |   4 +-
 hw/i386/amd_iommu.c           |  17 +-
 hw/i386/intel_iommu.c         |   8 +-
 hw/ide/cmd646.c               |   1 +
 hw/isa/Kconfig                |  10 +-
 hw/isa/Makefile.objs          |   2 +-
 hw/m68k/mcf5208.c             |   2 +
 hw/microblaze/boot.c          |   1 +
 hw/mips/Kconfig               |   1 +
 hw/mips/mips_int.c            |   1 +
 hw/mips/mips_jazz.c           |   2 +
 hw/ppc/spapr_iommu.c          |   8 +-
 hw/timer/lm32_timer.c         |   6 +-
 hw/timer/milkymist-sysctl.c   |  10 +-
 hw/vfio/common.c              |  52 +++--
 hw/vfio/spapr.c               |   4 +-
 hw/virtio/vhost.c             |   9 +-
 include/exec/memory.h         |  21 +-
 include/hw/vfio/vfio-common.h |   2 +-
 include/sysemu/kvm.h          |   2 +-
 memory.c                      |  31 +--
 scripts/kvm/vmxcap            |  14 +-
 scsi/qemu-pr-helper.c         |   6 +-
 target/i386/cpu.c             | 447 +++++++++++++++++++++++++++++++++---------
 target/i386/cpu.h             | 146 +++++++++++++-
 target/i386/helper.c          |   5 +-
 target/i386/kvm.c             | 183 ++++++++++++++++-
 tests/Makefile.include        |  12 +-
 tests/docker/test-clang       |   4 +-
 tests/docker/test-debug       |   1 +
 tests/migration-test.c        | 157 +++++++++++++--
 tests/test-char.c             |   4 +-
 util/async.c                  |   6 +-
 util/oslib-win32.c            |   6 +-
 40 files changed, 1050 insertions(+), 248 deletions(-)
-- 
1.8.3.1

From 6a82dc314970c19db9212ee89087ec2dc02c0723 Mon Sep 17 00:00:00 2001
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Mon, 9 Sep 2019 16:13:35 +0300
Subject: [PULL 01/30] tests/migration: Add a test for auto converge

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190909131335.16848-4-yury-kotov@yandex-team.ru>
[Reorganize check_migration_status for rebase. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/migration-test.c | 157 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 138 insertions(+), 19 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 221a33d..59f291c 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -240,6 +240,17 @@ static int64_t read_ram_property_int(QTestState *who, const char *property)
     return result;
 }
 
+static int64_t read_migrate_property_int(QTestState *who, const char *property)
+{
+    QDict *rsp_return;
+    int64_t result;
+
+    rsp_return = migrate_query(who);
+    result = qdict_get_try_int(rsp_return, property, 0);
+    qobject_unref(rsp_return);
+    return result;
+}
+
 static uint64_t get_migration_pass(QTestState *who)
 {
     return read_ram_property_int(who, "dirty-sync-count");
@@ -254,32 +265,46 @@ static void read_blocktime(QTestState *who)
     qobject_unref(rsp_return);
 }
 
+static bool check_migration_status(QTestState *who, const char *goal,
+                                   const char **ungoals)
+{
+    bool ready;
+    char *current_status;
+    const char **ungoal;
+
+    current_status = migrate_query_status(who);
+    ready = strcmp(current_status, goal) == 0;
+    if (!ungoals) {
+        g_assert_cmpstr(current_status, !=, "failed");
+        /*
+         * If looking for a state other than completed,
+         * completion of migration would cause the test to
+         * hang.
+         */
+        if (strcmp(goal, "completed") != 0) {
+            g_assert_cmpstr(current_status, !=, "completed");
+        }
+    } else {
+        for (ungoal = ungoals; *ungoal; ungoal++) {
+            g_assert_cmpstr(current_status, !=,  *ungoal);
+        }
+    }
+    g_free(current_status);
+    return ready;
+}
+
 static void wait_for_migration_status(QTestState *who,
                                       const char *goal,
                                       const char **ungoals)
 {
-    while (true) {
-        bool completed;
-        char *status;
-        const char **ungoal;
-
-        status = migrate_query_status(who);
-        completed = strcmp(status, goal) == 0;
-        for (ungoal = ungoals; *ungoal; ungoal++) {
-            g_assert_cmpstr(status, !=,  *ungoal);
-        }
-        g_free(status);
-        if (completed) {
-            return;
-        }
+    while (!check_migration_status(who, goal, ungoals)) {
         usleep(1000);
     }
 }
 
 static void wait_for_migration_complete(QTestState *who)
 {
-    wait_for_migration_status(who, "completed",
-                              (const char * []) { "failed", NULL });
+    wait_for_migration_status(who, "completed", NULL);
 }
 
 static void wait_for_migration_pass(QTestState *who)
@@ -450,6 +475,17 @@ static void migrate_pause(QTestState *who)
     qobject_unref(rsp);
 }
 
+static void migrate_continue(QTestState *who, const char *state)
+{
+    QDict *rsp;
+
+    rsp = wait_command(who,
+                       "{ 'execute': 'migrate-continue',"
+                       "  'arguments': { 'state': %s } }",
+                       state);
+    qobject_unref(rsp);
+}
+
 static void migrate_recover(QTestState *who, const char *uri)
 {
     QDict *rsp;
@@ -814,9 +850,7 @@ static void test_postcopy_recovery(void)
      * Wait until postcopy is really started; we can only run the
      * migrate-pause command during a postcopy
      */
-    wait_for_migration_status(from, "postcopy-active",
-                              (const char * []) { "failed",
-                                                  "completed", NULL });
+    wait_for_migration_status(from, "postcopy-active", NULL);
 
     /*
      * Manually stop the postcopy migration. This emulates a network
@@ -1210,6 +1244,89 @@ static void test_validate_uuid_dst_not_set(void)
                           false, true);
 }
 
+static void test_migrate_auto_converge(void)
+{
+    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+    int64_t remaining, percentage;
+
+    /*
+     * We want the test to be stable and as fast as possible.
+     * E.g., with 1Gb/s bandwith migration may pass without throttling,
+     * so we need to decrease a bandwidth.
+     */
+    const int64_t init_pct = 5, inc_pct = 50, max_pct = 95;
+    const int64_t max_bandwidth = 400000000; /* ~400Mb/s */
+    const int64_t downtime_limit = 250; /* 250ms */
+    /*
+     * We migrate through unix-socket (> 500Mb/s).
+     * Thus, expected migration speed ~= bandwidth limit (< 500Mb/s).
+     * So, we can predict expected_threshold
+     */
+    const int64_t expected_threshold = max_bandwidth * downtime_limit / 1000;
+
+    if (test_migrate_start(&from, &to, uri, false, false, NULL, NULL)) {
+        return;
+    }
+
+    migrate_set_capability(from, "auto-converge", true);
+    migrate_set_parameter_int(from, "cpu-throttle-initial", init_pct);
+    migrate_set_parameter_int(from, "cpu-throttle-increment", inc_pct);
+    migrate_set_parameter_int(from, "max-cpu-throttle", max_pct);
+
+    /*
+     * Set the initial parameters so that the migration could not converge
+     * without throttling.
+     */
+    migrate_set_parameter_int(from, "downtime-limit", 1);
+    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
+
+    /* To check remaining size after precopy */
+    migrate_set_capability(from, "pause-before-switchover", true);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate(from, uri, "{}");
+
+    /* Wait for throttling begins */
+    percentage = 0;
+    while (percentage == 0) {
+        percentage = read_migrate_property_int(from, "cpu-throttle-percentage");
+        usleep(100);
+        g_assert_false(got_stop);
+    }
+    /* The first percentage of throttling should be equal to init_pct */
+    g_assert_cmpint(percentage, ==, init_pct);
+    /* Now, when we tested that throttling works, let it converge */
+    migrate_set_parameter_int(from, "downtime-limit", downtime_limit);
+    migrate_set_parameter_int(from, "max-bandwidth", max_bandwidth);
+
+    /*
+     * Wait for pre-switchover status to check last throttle percentage
+     * and remaining. These values will be zeroed later
+     */
+    wait_for_migration_status(from, "pre-switchover", NULL);
+
+    /* The final percentage of throttling shouldn't be greater than max_pct */
+    percentage = read_migrate_property_int(from, "cpu-throttle-percentage");
+    g_assert_cmpint(percentage, <=, max_pct);
+
+    remaining = read_ram_property_int(from, "remaining");
+    g_assert_cmpint(remaining, <, expected_threshold);
+
+    migrate_continue(from, "pre-switchover");
+
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+
+    g_free(uri);
+
+    test_migrate_end(from, to, true);
+}
+
 int main(int argc, char **argv)
 {
     char template[] = "/tmp/migration-test-XXXXXX";
@@ -1272,6 +1389,8 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/validate_uuid_dst_not_set",
                    test_validate_uuid_dst_not_set);
 
+    qtest_add_func("/migration/auto_converge", test_migrate_auto_converge);
+
     ret = g_test_run();
 
     g_assert_cmpint(ret, ==, 0);
-- 
1.8.3.1


From 278516f561e6329e6f603b7dd4aeff5e89fb9197 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 2 Jul 2019 15:32:41 +0200
Subject: [PULL 02/30] target/i386: handle filtered_features in a new function
 mark_unavailable_features

The next patch will add a different reason for filtering features, unrelated
to host feature support.  Extract a new function that takes care of disabling
the features and optionally reporting them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 87 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9e0bac3..52b3f3e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3096,17 +3096,41 @@ static char *feature_word_description(FeatureWordInfo *f, uint32_t bit)
     return NULL;
 }
 
-static void report_unavailable_features(FeatureWord w, uint32_t mask)
+static bool x86_cpu_have_filtered_features(X86CPU *cpu)
 {
+    FeatureWord w;
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+         if (cpu->filtered_features[w]) {
+             return true;
+         }
+    }
+
+    return false;
+}
+
+static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint32_t mask,
+                                      const char *verbose_prefix)
+{
+    CPUX86State *env = &cpu->env;
     FeatureWordInfo *f = &feature_word_info[w];
     int i;
     char *feat_word_str;
 
+    if (!cpu->force_features) {
+        env->features[w] &= ~mask;
+    }
+    cpu->filtered_features[w] |= mask;
+
+    if (!verbose_prefix) {
+        return;
+    }
+
     for (i = 0; i < 32; ++i) {
         if ((1UL << i) & mask) {
             feat_word_str = feature_word_description(f, i);
-            warn_report("%s doesn't support requested feature: %s%s%s [bit %d]",
-                        accel_uses_host_cpuid() ? "host" : "TCG",
+            warn_report("%s: %s%s%s [bit %d]",
+                        verbose_prefix,
                         feat_word_str,
                         f->feat_names[i] ? "." : "",
                         f->feat_names[i] ? f->feat_names[i] : "", i);
@@ -3511,7 +3535,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
 }
 
 static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
-static int x86_cpu_filter_features(X86CPU *cpu);
+static void x86_cpu_filter_features(X86CPU *cpu, bool verbose);
 
 /* Build a list with the name of all features on a feature word array */
 static void x86_cpu_list_feature_names(FeatureWordArray features,
@@ -3576,7 +3600,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
         next = &new->next;
     }
 
-    x86_cpu_filter_features(xc);
+    x86_cpu_filter_features(xc, false);
 
     x86_cpu_list_feature_names(xc->filtered_features, next);
 
@@ -3784,15 +3808,6 @@ static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
     return r;
 }
 
-static void x86_cpu_report_filtered_features(X86CPU *cpu)
-{
-    FeatureWord w;
-
-    for (w = 0; w < FEATURE_WORDS; w++) {
-        report_unavailable_features(w, cpu->filtered_features[w]);
-    }
-}
-
 static void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
 {
     PropValue *pv;
@@ -5154,24 +5169,24 @@ out:
  *
  * Returns: 0 if all flags are supported by the host, non-zero otherwise.
  */
-static int x86_cpu_filter_features(X86CPU *cpu)
+static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
 {
     CPUX86State *env = &cpu->env;
     FeatureWord w;
-    int rv = 0;
+    const char *prefix = NULL;
+
+    if (verbose) {
+        prefix = accel_uses_host_cpuid()
+                 ? "host doesn't support requested feature"
+                 : "TCG doesn't support requested feature";
+    }
 
     for (w = 0; w < FEATURE_WORDS; w++) {
         uint32_t host_feat =
             x86_cpu_get_supported_feature_word(w, false);
         uint32_t requested_features = env->features[w];
-        uint32_t available_features = requested_features & host_feat;
-        if (!cpu->force_features) {
-            env->features[w] = available_features;
-        }
-        cpu->filtered_features[w] = requested_features & ~available_features;
-        if (cpu->filtered_features[w]) {
-            rv = 1;
-        }
+        uint32_t unavailable_features = requested_features & ~host_feat;
+        mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
 
     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
@@ -5197,13 +5212,9 @@ static int x86_cpu_filter_features(X86CPU *cpu)
              * host can't emulate the capabilities we report on
              * cpu_x86_cpuid(), intel-pt can't be enabled on the current host.
              */
-            env->features[FEAT_7_0_EBX] &= ~CPUID_7_0_EBX_INTEL_PT;
-            cpu->filtered_features[FEAT_7_0_EBX] |= CPUID_7_0_EBX_INTEL_PT;
-            rv = 1;
+            mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT, prefix);
         }
     }
-
-    return rv;
 }
 
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -5244,16 +5255,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         goto out;
     }
 
-    if (x86_cpu_filter_features(cpu) &&
-        (cpu->check_cpuid || cpu->enforce_cpuid)) {
-        x86_cpu_report_filtered_features(cpu);
-        if (cpu->enforce_cpuid) {
-            error_setg(&local_err,
-                       accel_uses_host_cpuid() ?
-                           "Host doesn't support requested features" :
-                           "TCG doesn't support requested features");
-            goto out;
-        }
+    x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);
+
+    if (cpu->enforce_cpuid && x86_cpu_have_filtered_features(cpu)) {
+        error_setg(&local_err,
+                   accel_uses_host_cpuid() ?
+                       "Host doesn't support requested features" :
+                       "TCG doesn't support requested features");
+        goto out;
     }
 
     /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
-- 
1.8.3.1


From 50b1d74290637f47a45834b1ca9b905878634bb3 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jul 2019 17:26:45 +0200
Subject: [PULL 03/30] target/i386: introduce generic feature dependency
 mechanism

Sometimes a CPU feature does not make sense unless another is
present.  In the case of VMX features, KVM does not even allow
setting the VMX controls to some invalid combinations.

Therefore, this patch adds a generic mechanism that looks for bits
that the user explicitly cleared, and uses them to remove other bits
from the expanded CPU definition.  If these dependent bits were also
explicitly *set* by the user, this will be a warning for "-cpu check"
and an error for "-cpu enforce".  If not, then the dependent bits are
cleared silently, for convenience.

With VMX features, this will be used so that for example
"-cpu host,-rdrand" will also hide support for RDRAND exiting.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 72 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 52b3f3e..fae458c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -801,10 +801,6 @@ typedef struct FeatureWordInfo {
         /* If type==MSR_FEATURE_WORD */
         struct {
             uint32_t index;
-            struct {   /*CPUID that enumerate this MSR*/
-                FeatureWord cpuid_class;
-                uint32_t    cpuid_flag;
-            } cpuid_dep;
         } msr;
     };
     uint32_t tcg_features; /* Feature flags supported by TCG */
@@ -1218,10 +1214,6 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_ARCH_CAPABILITIES,
-            .cpuid_dep = {
-                FEAT_7_0_EDX,
-                CPUID_7_0_EDX_ARCH_CAPABILITIES
-            }
         },
     },
     [FEAT_CORE_CAPABILITY] = {
@@ -1238,14 +1230,30 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_CORE_CAPABILITY,
-            .cpuid_dep = {
-                FEAT_7_0_EDX,
-                CPUID_7_0_EDX_CORE_CAPABILITY,
-            },
         },
     },
 };
 
+typedef struct FeatureMask {
+    FeatureWord index;
+    uint32_t mask;
+} FeatureMask;
+
+typedef struct FeatureDep {
+    FeatureMask from, to;
+} FeatureDep;
+
+static FeatureDep feature_dependencies[] = {
+    {
+        .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_ARCH_CAPABILITIES },
+        .to = { FEAT_ARCH_CAPABILITIES,     ~0u },
+    },
+    {
+        .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_CORE_CAPABILITY },
+        .to = { FEAT_CORE_CAPABILITY,       ~0u },
+    },
+};
+
 typedef struct X86RegisterInfo32 {
     /* Name of register */
     const char *name;
@@ -5063,9 +5071,26 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 {
     CPUX86State *env = &cpu->env;
     FeatureWord w;
+    int i;
     GList *l;
     Error *local_err = NULL;
 
+    for (l = plus_features; l; l = l->next) {
+        const char *prop = l->data;
+        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
+
+    for (l = minus_features; l; l = l->next) {
+        const char *prop = l->data;
+        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
+
     /*TODO: Now cpu->max_features doesn't overwrite features
      * set using QOM properties, and we can convert
      * plus_features & minus_features to global properties
@@ -5083,19 +5108,18 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    for (l = plus_features; l; l = l->next) {
-        const char *prop = l->data;
-        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
-        if (local_err) {
-            goto out;
-        }
-    }
+    for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
+        FeatureDep *d = &feature_dependencies[i];
+        if (!(env->features[d->from.index] & d->from.mask)) {
+            uint32_t unavailable_features = env->features[d->to.index] & d->to.mask;
 
-    for (l = minus_features; l; l = l->next) {
-        const char *prop = l->data;
-        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
-        if (local_err) {
-            goto out;
+            /* Not an error unless the dependent feature was added explicitly.  */
+            mark_unavailable_features(cpu, d->to.index,
+                                      unavailable_features & env->user_features[d->to.index],
+                                      "This feature depends on other features that were not requested");
+
+            env->user_features[d->to.index] |= unavailable_features;
+            env->features[d->to.index] &= ~unavailable_features;
         }
     }
 
-- 
1.8.3.1


From 87c27fc1ea56baf7d7788d6478b14d52522c534a Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jul 2019 17:38:54 +0200
Subject: [PULL 04/30] target/i386: expand feature words to 64 bits

VMX requires 64-bit feature words for the IA32_VMX_EPT_VPID_CAP
and IA32_VMX_BASIC MSRs.  (The VMX control MSRs are 64-bit wide but
actually have only 32 bits of information).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h |  2 +-
 target/i386/cpu.c    | 71 +++++++++++++++++++++++++++-------------------------
 target/i386/cpu.h    |  2 +-
 target/i386/kvm.c    |  2 +-
 4 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index fd67477..9d14328 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -462,7 +462,7 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension);
 
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
                                       uint32_t index, int reg);
-uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
+uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
 
 
 void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fae458c..83a3692 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -789,7 +789,7 @@ typedef struct FeatureWordInfo {
      * In cases of disagreement between feature naming conventions,
      * aliases may be added.
      */
-    const char *feat_names[32];
+    const char *feat_names[64];
     union {
         /* If type==CPUID_FEATURE_WORD */
         struct {
@@ -803,11 +803,11 @@ typedef struct FeatureWordInfo {
             uint32_t index;
         } msr;
     };
-    uint32_t tcg_features; /* Feature flags supported by TCG */
-    uint32_t unmigratable_flags; /* Feature flags known to be unmigratable */
-    uint32_t migratable_flags; /* Feature flags known to be migratable */
+    uint64_t tcg_features; /* Feature flags supported by TCG */
+    uint64_t unmigratable_flags; /* Feature flags known to be unmigratable */
+    uint64_t migratable_flags; /* Feature flags known to be migratable */
     /* Features that shouldn't be auto-enabled by "-cpu host" */
-    uint32_t no_autoenable_flags;
+    uint64_t no_autoenable_flags;
 } FeatureWordInfo;
 
 static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
@@ -1236,7 +1236,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
 
 typedef struct FeatureMask {
     FeatureWord index;
-    uint32_t mask;
+    uint64_t mask;
 } FeatureMask;
 
 typedef struct FeatureDep {
@@ -1246,11 +1246,11 @@ typedef struct FeatureDep {
 static FeatureDep feature_dependencies[] = {
     {
         .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_ARCH_CAPABILITIES },
-        .to = { FEAT_ARCH_CAPABILITIES,     ~0u },
+        .to = { FEAT_ARCH_CAPABILITIES,     ~0ull },
     },
     {
         .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_CORE_CAPABILITY },
-        .to = { FEAT_CORE_CAPABILITY,       ~0u },
+        .to = { FEAT_CORE_CAPABILITY,       ~0ull },
     },
 };
 
@@ -1362,14 +1362,14 @@ const char *get_register_name_32(unsigned int reg)
  * Returns the set of feature flags that are supported and migratable by
  * QEMU, for a given FeatureWord.
  */
-static uint32_t x86_cpu_get_migratable_flags(FeatureWord w)
+static uint64_t x86_cpu_get_migratable_flags(FeatureWord w)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
-    uint32_t r = 0;
+    uint64_t r = 0;
     int i;
 
-    for (i = 0; i < 32; i++) {
-        uint32_t f = 1U << i;
+    for (i = 0; i < 64; i++) {
+        uint64_t f = 1ULL << i;
 
         /* If the feature name is known, it is implicitly considered migratable,
          * unless it is explicitly set in unmigratable_flags */
@@ -2931,7 +2931,7 @@ void x86_cpu_change_kvm_default(const char *prop, const char *value)
     assert(pv->prop);
 }
 
-static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
+static uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                    bool migratable_only);
 
 static bool lmce_supported(void)
@@ -3117,7 +3117,7 @@ static bool x86_cpu_have_filtered_features(X86CPU *cpu)
     return false;
 }
 
-static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint32_t mask,
+static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
                                       const char *verbose_prefix)
 {
     CPUX86State *env = &cpu->env;
@@ -3134,8 +3134,8 @@ static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint32_t mask,
         return;
     }
 
-    for (i = 0; i < 32; ++i) {
-        if ((1UL << i) & mask) {
+    for (i = 0; i < 64; ++i) {
+        if ((1ULL << i) & mask) {
             feat_word_str = feature_word_description(f, i);
             warn_report("%s: %s%s%s [bit %d]",
                         verbose_prefix,
@@ -3378,7 +3378,7 @@ static void x86_cpu_get_feature_words(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
                                       Error **errp)
 {
-    uint32_t *array = (uint32_t *)opaque;
+    uint64_t *array = (uint64_t *)opaque;
     FeatureWord w;
     X86CPUFeatureWordInfo word_infos[FEATURE_WORDS] = { };
     X86CPUFeatureWordInfoList list_entries[FEATURE_WORDS] = { };
@@ -3422,6 +3422,7 @@ static inline void feat2prop(char *s)
 /* Return the feature property name for a feature flag bit */
 static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
 {
+    const char *name;
     /* XSAVE components are automatically enabled by other features,
      * so return the original feature name instead
      */
@@ -3435,9 +3436,11 @@ static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
         }
     }
 
-    assert(bitnr < 32);
+    assert(bitnr < 64);
     assert(w < FEATURE_WORDS);
-    return feature_word_info[w].feat_names[bitnr];
+    name = feature_word_info[w].feat_names[bitnr];
+    assert(bitnr < 32 || !(name && feature_word_info[w].type == CPUID_FEATURE_WORD));
+    return name;
 }
 
 /* Compatibily hack to maintain legacy +-feat semantic,
@@ -3553,10 +3556,10 @@ static void x86_cpu_list_feature_names(FeatureWordArray features,
     strList **next = feat_names;
 
     for (w = 0; w < FEATURE_WORDS; w++) {
-        uint32_t filtered = features[w];
+        uint64_t filtered = features[w];
         int i;
-        for (i = 0; i < 32; i++) {
-            if (filtered & (1UL << i)) {
+        for (i = 0; i < 64; i++) {
+            if (filtered & (1ULL << i)) {
                 strList *new = g_new0(strList, 1);
                 new->value = g_strdup(x86_cpu_feature_name(w, i));
                 *next = new;
@@ -3725,7 +3728,7 @@ void x86_cpu_list(void)
     names = NULL;
     for (i = 0; i < ARRAY_SIZE(feature_word_info); i++) {
         FeatureWordInfo *fw = &feature_word_info[i];
-        for (j = 0; j < 32; j++) {
+        for (j = 0; j < 64; j++) {
             if (fw->feat_names[j]) {
                 names = g_list_append(names, (gpointer)fw->feat_names[j]);
             }
@@ -3780,11 +3783,11 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
-static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
+static uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                    bool migratable_only)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
-    uint32_t r = 0;
+    uint64_t r = 0;
 
     if (kvm_enabled()) {
         switch (wi->type) {
@@ -3955,7 +3958,7 @@ static QDict *x86_cpu_static_props(void)
     for (w = 0; w < FEATURE_WORDS; w++) {
         FeatureWordInfo *fi = &feature_word_info[w];
         int bit;
-        for (bit = 0; bit < 32; bit++) {
+        for (bit = 0; bit < 64; bit++) {
             if (!fi->feat_names[bit]) {
                 continue;
             }
@@ -5111,7 +5114,7 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
         FeatureDep *d = &feature_dependencies[i];
         if (!(env->features[d->from.index] & d->from.mask)) {
-            uint32_t unavailable_features = env->features[d->to.index] & d->to.mask;
+            uint64_t unavailable_features = env->features[d->to.index] & d->to.mask;
 
             /* Not an error unless the dependent feature was added explicitly.  */
             mark_unavailable_features(cpu, d->to.index,
@@ -5206,10 +5209,10 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
     }
 
     for (w = 0; w < FEATURE_WORDS; w++) {
-        uint32_t host_feat =
+        uint64_t host_feat =
             x86_cpu_get_supported_feature_word(w, false);
-        uint32_t requested_features = env->features[w];
-        uint32_t unavailable_features = requested_features & ~host_feat;
+        uint64_t requested_features = env->features[w];
+        uint64_t unavailable_features = requested_features & ~host_feat;
         mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
 
@@ -5506,7 +5509,7 @@ static void x86_cpu_unrealizefn(DeviceState *dev, Error **errp)
 
 typedef struct BitProperty {
     FeatureWord w;
-    uint32_t mask;
+    uint64_t mask;
 } BitProperty;
 
 static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
@@ -5514,7 +5517,7 @@ static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
 {
     X86CPU *cpu = X86_CPU(obj);
     BitProperty *fp = opaque;
-    uint32_t f = cpu->env.features[fp->w];
+    uint64_t f = cpu->env.features[fp->w];
     bool value = (f & fp->mask) == fp->mask;
     visit_type_bool(v, name, &value, errp);
 }
@@ -5567,7 +5570,7 @@ static void x86_cpu_register_bit_prop(X86CPU *cpu,
 {
     BitProperty *fp;
     ObjectProperty *op;
-    uint32_t mask = (1UL << bitnr);
+    uint64_t mask = (1ULL << bitnr);
 
     op = object_property_find(OBJECT(cpu), prop_name, NULL);
     if (op) {
@@ -5701,7 +5704,7 @@ static void x86_cpu_initfn(Object *obj)
     for (w = 0; w < FEATURE_WORDS; w++) {
         int bitnr;
 
-        for (bitnr = 0; bitnr < 32; bitnr++) {
+        for (bitnr = 0; bitnr < 64; bitnr++) {
             x86_cpu_register_feature_bit_props(cpu, w, bitnr);
         }
     }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5f6e3a0..c00cc35 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -502,7 +502,7 @@ typedef enum FeatureWord {
     FEATURE_WORDS,
 } FeatureWord;
 
-typedef uint32_t FeatureWordArray[FEATURE_WORDS];
+typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 
 /* cpuid_features bits */
 #define CPUID_FP87 (1U << 0)
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9206909..0a86c8c 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -442,7 +442,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
     return ret;
 }
 
-uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
+uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
 {
     struct {
         struct kvm_msrs info;
-- 
1.8.3.1


From b8484c4876a6d2c671efd4ea1d4036afa6cc976c Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jul 2019 18:24:52 +0200
Subject: [PULL 05/30] target/i386: add VMX definitions

These will be used to compile the list of VMX features for named
CPU models, and/or by the code that sets up the VMX MSRs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c00cc35..23a30e1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -452,6 +452,25 @@ typedef enum X86Seg {
 #define MSR_IA32_BNDCFGS                0x00000d90
 #define MSR_IA32_XSS                    0x00000da0
 
+#define MSR_IA32_VMX_BASIC              0x00000480
+#define MSR_IA32_VMX_PINBASED_CTLS      0x00000481
+#define MSR_IA32_VMX_PROCBASED_CTLS     0x00000482
+#define MSR_IA32_VMX_EXIT_CTLS          0x00000483
+#define MSR_IA32_VMX_ENTRY_CTLS         0x00000484
+#define MSR_IA32_VMX_MISC               0x00000485
+#define MSR_IA32_VMX_CR0_FIXED0         0x00000486
+#define MSR_IA32_VMX_CR0_FIXED1         0x00000487
+#define MSR_IA32_VMX_CR4_FIXED0         0x00000488
+#define MSR_IA32_VMX_CR4_FIXED1         0x00000489
+#define MSR_IA32_VMX_VMCS_ENUM          0x0000048a
+#define MSR_IA32_VMX_PROCBASED_CTLS2    0x0000048b
+#define MSR_IA32_VMX_EPT_VPID_CAP       0x0000048c
+#define MSR_IA32_VMX_TRUE_PINBASED_CTLS  0x0000048d
+#define MSR_IA32_VMX_TRUE_PROCBASED_CTLS 0x0000048e
+#define MSR_IA32_VMX_TRUE_EXIT_CTLS      0x0000048f
+#define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
+#define MSR_IA32_VMX_VMFUNC             0x00000491
+
 #define XSTATE_FP_BIT                   0
 #define XSTATE_SSE_BIT                  1
 #define XSTATE_YMM_BIT                  2
@@ -750,6 +769,117 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 
 #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
 
+/* VMX MSR features */
+#define MSR_VMX_BASIC_VMCS_REVISION_MASK             0x7FFFFFFFull
+#define MSR_VMX_BASIC_VMXON_REGION_SIZE_MASK         (0x00001FFFull << 32)
+#define MSR_VMX_BASIC_VMCS_MEM_TYPE_MASK             (0x003C0000ull << 32)
+#define MSR_VMX_BASIC_DUAL_MONITOR                   (1ULL << 49)
+#define MSR_VMX_BASIC_INS_OUTS                       (1ULL << 54)
+#define MSR_VMX_BASIC_TRUE_CTLS                      (1ULL << 55)
+
+#define MSR_VMX_MISC_PREEMPTION_TIMER_SHIFT_MASK     0x1Full
+#define MSR_VMX_MISC_STORE_LMA                       (1ULL << 5)
+#define MSR_VMX_MISC_ACTIVITY_HLT                    (1ULL << 6)
+#define MSR_VMX_MISC_ACTIVITY_SHUTDOWN               (1ULL << 7)
+#define MSR_VMX_MISC_ACTIVITY_WAIT_SIPI              (1ULL << 8)
+#define MSR_VMX_MISC_MAX_MSR_LIST_SIZE_MASK          0x0E000000ull
+#define MSR_VMX_MISC_VMWRITE_VMEXIT                  (1ULL << 29)
+#define MSR_VMX_MISC_ZERO_LEN_INJECT                 (1ULL << 30)
+
+#define MSR_VMX_EPT_EXECONLY                         (1ULL << 0)
+#define MSR_VMX_EPT_PAGE_WALK_LENGTH_4               (1ULL << 6)
+#define MSR_VMX_EPT_PAGE_WALK_LENGTH_5               (1ULL << 7)
+#define MSR_VMX_EPT_UC                               (1ULL << 8)
+#define MSR_VMX_EPT_WB                               (1ULL << 14)
+#define MSR_VMX_EPT_2MB                              (1ULL << 16)
+#define MSR_VMX_EPT_1GB                              (1ULL << 17)
+#define MSR_VMX_EPT_INVEPT                           (1ULL << 20)
+#define MSR_VMX_EPT_AD_BITS                          (1ULL << 21)
+#define MSR_VMX_EPT_ADVANCED_VMEXIT_INFO             (1ULL << 22)
+#define MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT            (1ULL << 25)
+#define MSR_VMX_EPT_INVEPT_ALL_CONTEXT               (1ULL << 26)
+#define MSR_VMX_EPT_INVVPID                          (1ULL << 32)
+#define MSR_VMX_EPT_INVVPID_SINGLE_ADDR              (1ULL << 40)
+#define MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT           (1ULL << 41)
+#define MSR_VMX_EPT_INVVPID_ALL_CONTEXT              (1ULL << 42)
+#define MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS (1ULL << 43)
+
+#define MSR_VMX_VMFUNC_EPT_SWITCHING                 (1ULL << 0)
+
+
+/* VMX controls */
+#define VMX_CPU_BASED_VIRTUAL_INTR_PENDING          0x00000004
+#define VMX_CPU_BASED_USE_TSC_OFFSETING             0x00000008
+#define VMX_CPU_BASED_HLT_EXITING                   0x00000080
+#define VMX_CPU_BASED_INVLPG_EXITING                0x00000200
+#define VMX_CPU_BASED_MWAIT_EXITING                 0x00000400
+#define VMX_CPU_BASED_RDPMC_EXITING                 0x00000800
+#define VMX_CPU_BASED_RDTSC_EXITING                 0x00001000
+#define VMX_CPU_BASED_CR3_LOAD_EXITING              0x00008000
+#define VMX_CPU_BASED_CR3_STORE_EXITING             0x00010000
+#define VMX_CPU_BASED_CR8_LOAD_EXITING              0x00080000
+#define VMX_CPU_BASED_CR8_STORE_EXITING             0x00100000
+#define VMX_CPU_BASED_TPR_SHADOW                    0x00200000
+#define VMX_CPU_BASED_VIRTUAL_NMI_PENDING           0x00400000
+#define VMX_CPU_BASED_MOV_DR_EXITING                0x00800000
+#define VMX_CPU_BASED_UNCOND_IO_EXITING             0x01000000
+#define VMX_CPU_BASED_USE_IO_BITMAPS                0x02000000
+#define VMX_CPU_BASED_MONITOR_TRAP_FLAG             0x08000000
+#define VMX_CPU_BASED_USE_MSR_BITMAPS               0x10000000
+#define VMX_CPU_BASED_MONITOR_EXITING               0x20000000
+#define VMX_CPU_BASED_PAUSE_EXITING                 0x40000000
+#define VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS   0x80000000
+
+#define VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES 0x00000001
+#define VMX_SECONDARY_EXEC_ENABLE_EPT               0x00000002
+#define VMX_SECONDARY_EXEC_DESC                     0x00000004
+#define VMX_SECONDARY_EXEC_RDTSCP                   0x00000008
+#define VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE   0x00000010
+#define VMX_SECONDARY_EXEC_ENABLE_VPID              0x00000020
+#define VMX_SECONDARY_EXEC_WBINVD_EXITING           0x00000040
+#define VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST       0x00000080
+#define VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT       0x00000100
+#define VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY    0x00000200
+#define VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING       0x00000400
+#define VMX_SECONDARY_EXEC_RDRAND_EXITING           0x00000800
+#define VMX_SECONDARY_EXEC_ENABLE_INVPCID           0x00001000
+#define VMX_SECONDARY_EXEC_ENABLE_VMFUNC            0x00002000
+#define VMX_SECONDARY_EXEC_SHADOW_VMCS              0x00004000
+#define VMX_SECONDARY_EXEC_ENCLS_EXITING            0x00008000
+#define VMX_SECONDARY_EXEC_RDSEED_EXITING           0x00010000
+#define VMX_SECONDARY_EXEC_ENABLE_PML               0x00020000
+#define VMX_SECONDARY_EXEC_XSAVES                   0x00100000
+
+#define VMX_PIN_BASED_EXT_INTR_MASK                 0x00000001
+#define VMX_PIN_BASED_NMI_EXITING                   0x00000008
+#define VMX_PIN_BASED_VIRTUAL_NMIS                  0x00000020
+#define VMX_PIN_BASED_VMX_PREEMPTION_TIMER          0x00000040
+#define VMX_PIN_BASED_POSTED_INTR                   0x00000080
+
+#define VMX_VM_EXIT_SAVE_DEBUG_CONTROLS             0x00000004
+#define VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE            0x00000200
+#define VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL      0x00001000
+#define VMX_VM_EXIT_ACK_INTR_ON_EXIT                0x00008000
+#define VMX_VM_EXIT_SAVE_IA32_PAT                   0x00040000
+#define VMX_VM_EXIT_LOAD_IA32_PAT                   0x00080000
+#define VMX_VM_EXIT_SAVE_IA32_EFER                  0x00100000
+#define VMX_VM_EXIT_LOAD_IA32_EFER                  0x00200000
+#define VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER       0x00400000
+#define VMX_VM_EXIT_CLEAR_BNDCFGS                   0x00800000
+#define VMX_VM_EXIT_PT_CONCEAL_PIP                  0x01000000
+#define VMX_VM_EXIT_CLEAR_IA32_RTIT_CTL             0x02000000
+
+#define VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS            0x00000004
+#define VMX_VM_ENTRY_IA32E_MODE                     0x00000200
+#define VMX_VM_ENTRY_SMM                            0x00000400
+#define VMX_VM_ENTRY_DEACT_DUAL_MONITOR             0x00000800
+#define VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL     0x00002000
+#define VMX_VM_ENTRY_LOAD_IA32_PAT                  0x00004000
+#define VMX_VM_ENTRY_LOAD_IA32_EFER                 0x00008000
+#define VMX_VM_ENTRY_LOAD_BNDCFGS                   0x00010000
+#define VMX_VM_ENTRY_PT_CONCEAL_PIP                 0x00020000
+#define VMX_VM_ENTRY_LOAD_IA32_RTIT_CTL             0x00040000
+
 /* Supported Hyper-V Enlightenments */
 #define HYPERV_FEAT_RELAXED             0
 #define HYPERV_FEAT_VAPIC               1
-- 
1.8.3.1


From db13b1515f62577bbfe9651726b6ad08a8e2244d Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jul 2019 16:51:24 +0200
Subject: [PULL 06/30] vmxcap: correct the name of the variables

The low bits are 1 if the control must be one, the high bits
are 1 if the control can be one.  Correct the variable names
as they are very confusing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/kvm/vmxcap | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index d8c7d6d..5dfeb2e 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -51,15 +51,15 @@ class Control(object):
         return (val & 0xffffffff, val >> 32)
     def show(self):
         print(self.name)
-        mbz, mb1 = self.read2(self.cap_msr)
-        tmbz, tmb1 = 0, 0
+        mb1, cb1 = self.read2(self.cap_msr)
+        tmb1, tcb1 = 0, 0
         if self.true_cap_msr:
-            tmbz, tmb1 = self.read2(self.true_cap_msr)
+            tmb1, tcb1 = self.read2(self.true_cap_msr)
         for bit in sorted(self.bits.keys()):
-            zero = not (mbz & (1 << bit))
-            one = mb1 & (1 << bit)
-            true_zero = not (tmbz & (1 << bit))
-            true_one = tmb1 & (1 << bit)
+            zero = not (mb1 & (1 << bit))
+            one = cb1 & (1 << bit)
+            true_zero = not (tmb1 & (1 << bit))
+            true_one = tcb1 & (1 << bit)
             s= '?'
             if (self.true_cap_msr and true_zero and true_one
                 and one and not zero):
-- 
1.8.3.1


From 3704ebecc8d9900d839b8ae082be05c9eaf999d3 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jul 2019 18:32:17 +0200
Subject: [PULL 07/30] target/i386: add VMX features

Add code to convert the VMX feature words back into MSR values,
allowing the user to enable/disable VMX features as they wish.  The same
infrastructure enables support for limiting VMX features in named
CPU models.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 225 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h |   9 +++
 target/i386/kvm.c | 160 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 392 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 83a3692..5b771f1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1232,6 +1232,163 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .index = MSR_IA32_CORE_CAPABILITY,
         },
     },
+
+    [FEAT_VMX_PROCBASED_CTLS] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, "vmx-vintr-pending", "vmx-tsc-offset",
+            NULL, NULL, NULL, "vmx-hlt-exit",
+            NULL, "vmx-invlpg-exit", "vmx-mwait-exit", "vmx-rdpmc-exit",
+            "vmx-rdtsc-exit", NULL, NULL, "vmx-cr3-load-noexit",
+            "vmx-cr3-store-noexit", NULL, NULL, "vmx-cr8-load-exit",
+            "vmx-cr8-store-exit", "vmx-flexpriority", "vmx-vnmi-pending", "vmx-movdr-exit",
+            "vmx-io-exit", "vmx-io-bitmap", NULL, "vmx-mtf",
+            "vmx-msr-bitmap", "vmx-monitor-exit", "vmx-pause-exit", "vmx-secondary-ctls",
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_TRUE_PROCBASED_CTLS,
+        }
+    },
+
+    [FEAT_VMX_SECONDARY_CTLS] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            "vmx-apicv-xapic", "vmx-ept", "vmx-desc-exit", "vmx-rdtscp-exit",
+            "vmx-apicv-x2apic", "vmx-vpid", "vmx-wbinvd-exit", "vmx-unrestricted-guest",
+            "vmx-apicv-register", "vmx-apicv-vid", "vmx-ple", "vmx-rdrand-exit",
+            "vmx-invpcid-exit", "vmx-vmfunc", "vmx-shadow-vmcs", "vmx-encls-exit",
+            "vmx-rdseed-exit", "vmx-pml", NULL, NULL,
+            "vmx-xsaves", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_PROCBASED_CTLS2,
+        }
+    },
+
+    [FEAT_VMX_PINBASED_CTLS] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            "vmx-intr-exit", NULL, NULL, "vmx-nmi-exit",
+            NULL, "vmx-vnmi", "vmx-preemption-timer", "vmx-posted-intr",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_TRUE_PINBASED_CTLS,
+        }
+    },
+
+    [FEAT_VMX_EXIT_CTLS] = {
+        .type = MSR_FEATURE_WORD,
+        /*
+         * VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE is copied from
+         * the LM CPUID bit.
+         */
+        .feat_names = {
+            NULL, NULL, "vmx-exit-nosave-debugctl", NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL /* vmx-exit-host-addr-space-size */, NULL, NULL,
+            "vmx-exit-load-perf-global-ctrl", NULL, NULL, "vmx-exit-ack-intr",
+            NULL, NULL, "vmx-exit-save-pat", "vmx-exit-load-pat",
+            "vmx-exit-save-efer", "vmx-exit-load-efer",
+                "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
+            NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
+        }
+    },
+
+    [FEAT_VMX_ENTRY_CTLS] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, "vmx-entry-noload-debugctl", NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, "vmx-entry-ia32e-mode", NULL, NULL,
+            NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
+            "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_TRUE_ENTRY_CTLS,
+        }
+    },
+
+    [FEAT_VMX_MISC] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, "vmx-store-lma", "vmx-activity-hlt", "vmx-activity-shutdown",
+            "vmx-activity-wait-sipi", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, "vmx-vmwrite-vmexit-fields", "vmx-zero-len-inject", NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_MISC,
+        }
+    },
+
+    [FEAT_VMX_EPT_VPID_CAPS] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            "vmx-ept-execonly", NULL, NULL, NULL,
+            NULL, NULL, "vmx-page-walk-4", "vmx-page-walk-5",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            "vmx-ept-2mb", "vmx-ept-1gb", NULL, NULL,
+            "vmx-invept", "vmx-eptad", "vmx-ept-advanced-exitinfo", NULL,
+            NULL, "vmx-invept-single-context", "vmx-invept-all-context", NULL,
+            NULL, NULL, NULL, NULL,
+            "vmx-invvpid", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            "vmx-invvpid-single-addr", "vmx-invept-single-context",
+                "vmx-invvpid-all-context", "vmx-invept-single-context-noglobals",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_EPT_VPID_CAP,
+        }
+    },
+
+    [FEAT_VMX_BASIC] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            [54] = "vmx-ins-outs",
+            [55] = "vmx-true-ctls",
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_BASIC,
+        },
+        /* Just to be safe - we don't support setting the MSEG version field.  */
+        .no_autoenable_flags = MSR_VMX_BASIC_DUAL_MONITOR,
+    },
+
+    [FEAT_VMX_VMFUNC] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            [0] = "vmx-eptp-switching",
+        },
+        .msr = {
+            .index = MSR_IA32_VMX_VMFUNC,
+        }
+    },
+
 };
 
 typedef struct FeatureMask {
@@ -1252,6 +1409,74 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_CORE_CAPABILITY },
         .to = { FEAT_CORE_CAPABILITY,       ~0ull },
     },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
+        .to = { FEAT_VMX_PROCBASED_CTLS,    ~0ull },
+    },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
+        .to = { FEAT_VMX_PINBASED_CTLS,     ~0ull },
+    },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
+        .to = { FEAT_VMX_EXIT_CTLS,         ~0ull },
+    },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
+        .to = { FEAT_VMX_ENTRY_CTLS,        ~0ull },
+    },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
+        .to = { FEAT_VMX_MISC,              ~0ull },
+    },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
+        .to = { FEAT_VMX_BASIC,             ~0ull },
+    },
+    {
+        .from = { FEAT_8000_0001_EDX,       CPUID_EXT2_LM },
+        .to = { FEAT_VMX_ENTRY_CTLS,        VMX_VM_ENTRY_IA32E_MODE },
+    },
+    {
+        .from = { FEAT_VMX_PROCBASED_CTLS,  VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    ~0ull },
+    },
+    {
+        .from = { FEAT_XSAVE,               CPUID_XSAVE_XSAVES },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_XSAVES },
+    },
+    {
+        .from = { FEAT_1_ECX,               CPUID_EXT_RDRAND },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_RDRAND_EXITING },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_INVPCID },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_ENABLE_INVPCID },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_RDSEED },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_RDSEED_EXITING },
+    },
+    {
+        .from = { FEAT_8000_0001_EDX,       CPUID_EXT2_RDTSCP },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_RDTSCP },
+    },
+    {
+        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_EPT },
+        .to = { FEAT_VMX_EPT_VPID_CAPS,     0xffffffffull },
+    },
+    {
+        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_EPT },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST },
+    },
+    {
+        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_VPID },
+        .to = { FEAT_VMX_EPT_VPID_CAPS,     0xffffffffull << 32 },
+    },
+    {
+        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_VMFUNC },
+        .to = { FEAT_VMX_VMFUNC,            ~0ull },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 23a30e1..c62e3b6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -518,6 +518,15 @@ typedef enum FeatureWord {
     FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
     FEAT_ARCH_CAPABILITIES,
     FEAT_CORE_CAPABILITY,
+    FEAT_VMX_PROCBASED_CTLS,
+    FEAT_VMX_SECONDARY_CTLS,
+    FEAT_VMX_PINBASED_CTLS,
+    FEAT_VMX_EXIT_CTLS,
+    FEAT_VMX_ENTRY_CTLS,
+    FEAT_VMX_MISC,
+    FEAT_VMX_EPT_VPID_CAPS,
+    FEAT_VMX_BASIC,
+    FEAT_VMX_VMFUNC,
     FEATURE_WORDS,
 } FeatureWord;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0a86c8c..7c5ad26 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -100,6 +100,7 @@ static bool has_msr_virt_ssbd;
 static bool has_msr_smi_count;
 static bool has_msr_arch_capabs;
 static bool has_msr_core_capabs;
+static bool has_msr_vmx_vmfunc;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -448,7 +449,8 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
         struct kvm_msrs info;
         struct kvm_msr_entry entries[1];
     } msr_data;
-    uint32_t ret;
+    uint64_t value;
+    uint32_t ret, can_be_one, must_be_one;
 
     if (kvm_feature_msrs == NULL) { /* Host doesn't support feature MSRs */
         return 0;
@@ -474,7 +476,25 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
         exit(1);
     }
 
-    return msr_data.entries[0].data;
+    value = msr_data.entries[0].data;
+    switch (index) {
+    case MSR_IA32_VMX_PROCBASED_CTLS2:
+    case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
+    case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
+    case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
+    case MSR_IA32_VMX_TRUE_EXIT_CTLS:
+        /*
+         * Return true for bits that can be one, but do not have to be one.
+         * The SDM tells us which bits could have a "must be one" setting,
+         * so we can do the opposite transformation in make_vmx_msr_value.
+         */
+        must_be_one = (uint32_t)value;
+        can_be_one = (uint32_t)(value >> 32);
+        return can_be_one & ~must_be_one;
+
+    default:
+        return value;
+    }
 }
 
 
@@ -1939,6 +1959,9 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_CORE_CAPABILITY:
                 has_msr_core_capabs = true;
                 break;
+            case MSR_IA32_VMX_VMFUNC:
+                has_msr_vmx_vmfunc = true;
+                break;
             }
         }
     }
@@ -2413,6 +2436,132 @@ static int kvm_put_msr_feature_control(X86CPU *cpu)
     return 0;
 }
 
+static uint64_t make_vmx_msr_value(uint32_t index, uint32_t features)
+{
+    uint32_t default1, can_be_one, can_be_zero;
+    uint32_t must_be_one;
+
+    switch (index) {
+    case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
+        default1 = 0x00000016;
+        break;
+    case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
+        default1 = 0x0401e172;
+        break;
+    case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
+        default1 = 0x000011ff;
+        break;
+    case MSR_IA32_VMX_TRUE_EXIT_CTLS:
+        default1 = 0x00036dff;
+        break;
+    case MSR_IA32_VMX_PROCBASED_CTLS2:
+        default1 = 0;
+        break;
+    default:
+        abort();
+    }
+
+    /* If a feature bit is set, the control can be either set or clear.
+     * Otherwise the value is limited to either 0 or 1 by default1.
+     */
+    can_be_one = features | default1;
+    can_be_zero = features | ~default1;
+    must_be_one = ~can_be_zero;
+
+    /*
+     * Bit 0:31 -> 0 if the control bit can be zero (i.e. 1 if it must be one).
+     * Bit 32:63 -> 1 if the control bit can be one.
+     */
+    return must_be_one | (((uint64_t)can_be_one) << 32);
+}
+
+#define VMCS12_MAX_FIELD_INDEX (0x17)
+
+static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
+{
+    uint64_t kvm_vmx_basic =
+        kvm_arch_get_supported_msr_feature(kvm_state,
+                                           MSR_IA32_VMX_BASIC);
+    uint64_t kvm_vmx_misc =
+        kvm_arch_get_supported_msr_feature(kvm_state,
+                                           MSR_IA32_VMX_MISC);
+    uint64_t kvm_vmx_ept_vpid =
+        kvm_arch_get_supported_msr_feature(kvm_state,
+                                           MSR_IA32_VMX_EPT_VPID_CAP);
+
+    /*
+     * If the guest is 64-bit, a value of 1 is allowed for the host address
+     * space size vmexit control.
+     */
+    uint64_t fixed_vmx_exit = f[FEAT_8000_0001_EDX] & CPUID_EXT2_LM
+        ? (uint64_t)VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE << 32 : 0;
+
+    /*
+     * Bits 0-30, 32-44 and 50-53 come from the host.  KVM should
+     * not change them for backwards compatibility.
+     */
+    uint64_t fixed_vmx_basic = kvm_vmx_basic &
+        (MSR_VMX_BASIC_VMCS_REVISION_MASK |
+         MSR_VMX_BASIC_VMXON_REGION_SIZE_MASK |
+         MSR_VMX_BASIC_VMCS_MEM_TYPE_MASK);
+
+    /*
+     * Same for bits 0-4 and 25-27.  Bits 16-24 (CR3 target count) can
+     * change in the future but are always zero for now, clear them to be
+     * future proof.  Bits 32-63 in theory could change, though KVM does
+     * not support dual-monitor treatment and probably never will; mask
+     * them out as well.
+     */
+    uint64_t fixed_vmx_misc = kvm_vmx_misc &
+        (MSR_VMX_MISC_PREEMPTION_TIMER_SHIFT_MASK |
+         MSR_VMX_MISC_MAX_MSR_LIST_SIZE_MASK);
+
+    /*
+     * EPT memory types should not change either, so we do not bother
+     * adding features for them.
+     */
+    uint64_t fixed_vmx_ept_mask =
+            (f[FEAT_VMX_SECONDARY_CTLS] & VMX_SECONDARY_EXEC_ENABLE_EPT ?
+	     MSR_VMX_EPT_UC | MSR_VMX_EPT_WB : 0);
+    uint64_t fixed_vmx_ept_vpid = kvm_vmx_ept_vpid & fixed_vmx_ept_mask;
+
+    kvm_msr_entry_add(cpu, MSR_IA32_VMX_TRUE_PROCBASED_CTLS,
+                      make_vmx_msr_value(MSR_IA32_VMX_TRUE_PROCBASED_CTLS,
+                                         f[FEAT_VMX_PROCBASED_CTLS]));
+    kvm_msr_entry_add(cpu, MSR_IA32_VMX_TRUE_PINBASED_CTLS,
+                      make_vmx_msr_value(MSR_IA32_VMX_TRUE_PINBASED_CTLS,
+                                         f[FEAT_VMX_PINBASED_CTLS]));
+    kvm_msr_entry_add(cpu, MSR_IA32_VMX_TRUE_EXIT_CTLS,
+                      make_vmx_msr_value(MSR_IA32_VMX_TRUE_EXIT_CTLS,
+                                         f[FEAT_VMX_EXIT_CTLS]) | fixed_vmx_exit);
+    kvm_msr_entry_add(cpu, MSR_IA32_VMX_TRUE_ENTRY_CTLS,
+                      make_vmx_msr_value(MSR_IA32_VMX_TRUE_ENTRY_CTLS,
+                                         f[FEAT_VMX_ENTRY_CTLS]));
+    kvm_msr_entry_add(cpu, MSR_IA32_VMX_PROCBASED_CTLS2,
+                      make_vmx_msr_value(MSR_IA32_VMX_PROCBASED_CTLS2,
+                                         f[FEAT_VMX_SECONDARY_CTLS]));
+    kvm_msr_entry_add(cpu, MSR_IA32_VMX_EPT_VPID_CAP,
+                      f[FEAT_VMX_EPT_VPID_CAPS] | fixed_vmx_ept_vpid);
+    kvm_msr_entry_add(cpu, MSR_IA32_VMX_BASIC,
+                      f[FEAT_VMX_BASIC] | fixed_vmx_basic);
+    kvm_msr_entry_add(cpu, MSR_IA32_VMX_MISC,
+                      f[FEAT_VMX_MISC] | fixed_vmx_misc);
+    if (has_msr_vmx_vmfunc) {
+        kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMFUNC, f[FEAT_VMX_VMFUNC]);
+    }
+
+    /*
+     * Just to be safe, write these with constant values.  The CRn_FIXED1
+     * MSRs are generated by KVM based on the vCPU's CPUID.
+     */
+    kvm_msr_entry_add(cpu, MSR_IA32_VMX_CR0_FIXED0,
+                      CR0_PE_MASK | CR0_PG_MASK | CR0_NE_MASK);
+    kvm_msr_entry_add(cpu, MSR_IA32_VMX_CR4_FIXED0,
+                      CR4_VMXE_MASK);
+    kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM,
+                      VMCS12_MAX_FIELD_INDEX << 1);
+}
+
 static int kvm_put_msrs(X86CPU *cpu, int level)
 {
     CPUX86State *env = &cpu->env;
@@ -2670,6 +2819,13 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
             kvm_msr_entry_add(cpu, MSR_MC0_CTL + i, env->mce_banks[i]);
         }
     }
+    /*
+     * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST, but
+     * all kernels with MSR features should have them.
+     */
+    if (kvm_feature_msrs && cpu_has_vmx(env)) {
+        kvm_msr_entry_add_vmx(cpu, env->features);
+    }
 
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, cpu->kvm_msr_buf);
     if (ret < 0) {
-- 
1.8.3.1


From e597e8f9a9f1da3ac5c7c56ae20fd753db16a023 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 2 Jul 2019 14:58:48 +0200
Subject: [PULL 08/30] target/i386: work around KVM_GET_MSRS bug for secondary
 execution controls

Some secondary controls are automatically enabled/disabled based on the CPUID
values that are set for the guest.  However, they are still available at a
global level and therefore should be present when KVM_GET_MSRS is sent to
/dev/kvm.

Unfortunately KVM forgot to include those, so fix that.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 7c5ad26..91d0bf6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -479,6 +479,23 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
     value = msr_data.entries[0].data;
     switch (index) {
     case MSR_IA32_VMX_PROCBASED_CTLS2:
+        /* KVM forgot to add these bits for some time, do this ourselves.  */
+        if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) & CPUID_XSAVE_XSAVES) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_XSAVES << 32;
+        }
+        if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) & CPUID_EXT_RDRAND) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING << 32;
+        }
+        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_EBX_INVPCID) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID << 32;
+        }
+        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_EBX_RDSEED) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING << 32;
+        }
+        if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) & CPUID_EXT2_RDTSCP) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
+        }
+        /* fall through */
     case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
     case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
     case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
-- 
1.8.3.1


From 3d3198e9151c961fe0eed42d39860034a325c4c1 Mon Sep 17 00:00:00 2001
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 24 Sep 2019 09:47:38 +0200
Subject: [PULL 09/30] target/i386/kvm: Silence warning from Valgrind about
 uninitialized bytes

When I run QEMU with KVM under Valgrind, I currently get this warning:

 Syscall param ioctl(generic) points to uninitialised byte(s)
    at 0x95BA45B: ioctl (in /usr/lib64/libc-2.28.so)
    by 0x429DC3: kvm_ioctl (kvm-all.c:2365)
    by 0x51B249: kvm_arch_get_supported_msr_feature (kvm.c:469)
    by 0x4C2A49: x86_cpu_get_supported_feature_word (cpu.c:3765)
    by 0x4C4116: x86_cpu_expand_features (cpu.c:5065)
    by 0x4C7F8D: x86_cpu_realizefn (cpu.c:5242)
    by 0x5961F3: device_set_realized (qdev.c:835)
    by 0x7038F6: property_set_bool (object.c:2080)
    by 0x707EFE: object_property_set_qobject (qom-qobject.c:26)
    by 0x705814: object_property_set_bool (object.c:1338)
    by 0x498435: pc_new_cpu (pc.c:1549)
    by 0x49C67D: pc_cpus_init (pc.c:1681)
  Address 0x1ffeffee74 is on thread 1's stack
  in frame #2, created by kvm_arch_get_supported_msr_feature (kvm.c:445)

It's harmless, but a little bit annoying, so silence it by properly
initializing the whole structure with zeroes.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 91d0bf6..522d9fd 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -188,7 +188,7 @@ static int kvm_get_tsc(CPUState *cs)
     struct {
         struct kvm_msrs info;
         struct kvm_msr_entry entries[1];
-    } msr_data;
+    } msr_data = {};
     int ret;
 
     if (env->tsc_valid) {
@@ -448,7 +448,7 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
     struct {
         struct kvm_msrs info;
         struct kvm_msr_entry entries[1];
-    } msr_data;
+    } msr_data = {};
     uint64_t value;
     uint32_t ret, can_be_one, must_be_one;
 
-- 
1.8.3.1


From 8c2e135c4915aee6f5ce886e395b5f4d253dcadb Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <mlevitsk@redhat.com>
Date: Tue, 24 Sep 2019 02:38:48 +0300
Subject: [PULL 10/30] qemu-pr-helper: fix crash in mpath_reconstruct_sense

The 'r' variable was accidently shadowed, and because of this
we were always passing 0 to mpath_generic_sense, instead of original
return value, which triggers an abort()

This is an attempt to fix the
https://bugzilla.redhat.com/show_bug.cgi?id=1720047
although there might be other places in the code
that trigger qemu-pr-helper crash, and this fix might
not be the root cause.

The crash was reproduced by creating an iscsi target on a test machine,
and passing it twice to the guest like that:

-blockdev node-name=idisk0,driver=iscsi,transport=...,target=...
-device scsi-block,drive=idisk0,bus=scsi0.0,bootindex=-1,scsi-id=1,lun=0,share-rw=on
-device scsi-block,drive=idisk0,bus=scsi0.0,bootindex=-1,scsi-id=1,lun=1,share-rw=on

Then in the guest, both /dev/sda and /dev/sdb were aggregated by multipath to /dev/mpatha,
which was passed to a nested guest like that

-object pr-manager-helper,id=qemu_pr_helper,path=/root/work/vm/testvm/.run/pr_helper.socket
-blockdev node-name=test,driver=host_device,filename=/dev/mapper/mpatha,pr-manager=qemu_pr_helper
-device scsi-block,drive=test,bus=scsi0.0,bootindex=-1,scsi-id=0,lun=0

The nested guest run:

sg_persist --no-inquiry  -v --out --register --param-sark 0x1234 /dev/sda

Strictly speaking this is wrong configuration since qemu is where
the multipath was split, and thus the iscsi target was not aware of
multipath, and thus when libmpathpersist code rightfully tried to register
the PR key on all paths, it failed to do so.

However qemu-pr-helper should not crash in this case.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/qemu-pr-helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index a8a74d1..debb18f 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -323,10 +323,10 @@ static int mpath_reconstruct_sense(int fd, int r, uint8_t *sense)
              */
             uint8_t cdb[6] = { TEST_UNIT_READY };
             int sz = 0;
-            int r = do_sgio(fd, cdb, sense, NULL, &sz, SG_DXFER_NONE);
+            int ret = do_sgio(fd, cdb, sense, NULL, &sz, SG_DXFER_NONE);
 
-            if (r != GOOD) {
-                return r;
+            if (ret != GOOD) {
+                return ret;
             }
             scsi_build_sense(sense, mpath_generic_sense(r));
             return CHECK_CONDITION;
-- 
1.8.3.1


From 99e910fbd8844eefa429f66a2b687b4001e88628 Mon Sep 17 00:00:00 2001
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Date: Tue, 17 Sep 2019 12:54:06 +0300
Subject: [PULL 11/30] replay: don't synchronize memory operations in replay
 mode

Commit 9458a9a1df1a4c719e24512394d548c1fc7abd22 added synchronization
of vCPU and migration operations through calling run_on_cpu operation.
However, in replay mode this synchronization is unneeded, because
I/O and vCPU threads are already synchronized.
This patch disables such synchronization for record/replay mode.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
---
 exec.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index 8a0a661..1d6e4d8 100644
--- a/exec.c
+++ b/exec.c
@@ -2959,8 +2959,17 @@ static void tcg_log_global_after_sync(MemoryListener *listener)
      * by pushing the migration thread's memory read after the vCPU thread has
      * written the memory.
      */
-    cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
-    run_on_cpu(cpuas->cpu, do_nothing, RUN_ON_CPU_NULL);
+    if (replay_mode == REPLAY_MODE_NONE) {
+        /*
+         * VGA can make calls to this function while updating the screen.
+         * In record/replay mode this causes a deadlock, because
+         * run_on_cpu waits for rr mutex. Therefore no races are possible
+         * in this case and no need for making run_on_cpu when
+         * record/replay is not enabled.
+         */
+        cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
+        run_on_cpu(cpuas->cpu, do_nothing, RUN_ON_CPU_NULL);
+    }
 }
 
 static void tcg_commit(MemoryListener *listener)
-- 
1.8.3.1


From 2f51c90e0242c769ac17c0b300c4e59e2811a6a7 Mon Sep 17 00:00:00 2001
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 11 Sep 2019 18:29:00 +0200
Subject: [PULL 12/30] Makefile: Remove generated files when doing 'distclean'

When running "make distclean" we currently leave a lot of generated
files in the build directory. Fix that.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile               |  6 +++---
 tests/Makefile.include | 12 +++++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 8da3359..47b1e1f 100644
--- a/Makefile
+++ b/Makefile
@@ -696,14 +696,14 @@ clean: recurse-clean
 		-exec rm {} +
 	rm -f $(edk2-decompressed)
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
-	rm -f fsdev/*.pod scsi/*.pod
+	rm -f fsdev/*.pod scsi/*.pod docs/*.pod docs/*/*.pod docs/*/.buildinfo
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
 	@# May not be present in generated-files-y
 	rm -f trace/generated-tracers-dtrace.dtrace*
 	rm -f trace/generated-tracers-dtrace.h*
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
-	rm -f qapi-gen-timestamp
+	rm -f qapi-gen-timestamp vhost-user-input
 	rm -rf qga/qapi-generated
 	rm -f config-all-devices.mak
 
@@ -724,7 +724,7 @@ distclean: clean
 	rm -f tests/tcg/config-*.mak
 	rm -f config-all-devices.mak config-all-disas.mak config.status
 	rm -f $(SUBDIR_DEVICES_MAK)
-	rm -f po/*.mo tests/qemu-iotests/common.env
+	rm -f po/*.mo
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
 	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
 	rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky qemu-doc.kys
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3543451..48b52da 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1176,11 +1176,21 @@ check: check-block check-qapi-schema check-unit check-softfloat check-qtest chec
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
-	rm -f tests/test-qapi-gen-timestamp
 	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
+	rm -f tests/qemu-iotests/common.env tests/qemu-iotests/check.*
+	rm -f tests/test-qapi-gen-timestamp tests/qht-bench$(EXESUF) \
+		tests/fp/fp-test tests/fp/*.out tests/qapi-schema/*.test.*
 
 clean: check-clean
 
+check-distclean:
+	rm -f tests/test-qapi-types*.c tests/test-qapi-visit*.c \
+		tests/test-qapi-commands*.c tests/test-qapi-events*.c \
+		tests/test-qapi-emit-events.[ch] tests/test-qapi-introspect.c \
+		tests/include/test-qapi-*.c
+
+distclean: check-distclean
+
 # Build the help program automatically
 
 all: $(QEMU_IOTESTS_HELPERS-y)
-- 
1.8.3.1


From 19ad67802d7ebbcc9da428ea03e1729f437785da Mon Sep 17 00:00:00 2001
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 30 Sep 2019 17:04:36 +0200
Subject: [PULL 13/30] hw/isa: Introduce a CONFIG_ISA_SUPERIO switch for
 isa-superio.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, isa-superio.c is always compiled as soon as CONFIG_ISA_BUS
is enabled. But there are also machines that have an ISA BUS without
any of the superio chips attached to it, so we should not compile
isa-superio.c in case we only compile a QEMU for such a machine.
Thus add a proper CONFIG_ISA_SUPERIO switch so that this file only gets
compiled when we really, really need it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/Kconfig       | 10 +++++++---
 hw/isa/Makefile.objs |  2 +-
 hw/mips/Kconfig      |  1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 6db0d79..98a2899 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -13,9 +13,13 @@ config I82378
     select MC146818RTC
     select PCSPK
 
-config PC87312
+config ISA_SUPERIO
     bool
     select ISA_BUS
+
+config PC87312
+    bool
+    select ISA_SUPERIO
     select I8259
     select I8254
     select I8257
@@ -34,14 +38,14 @@ config PIIX4
 
 config VT82C686
     bool
-    select ISA_BUS
+    select ISA_SUPERIO
     select ACPI_SMBUS
     select SERIAL_ISA
     select FDC
 
 config SMC37C669
     bool
-    select ISA_BUS
+    select ISA_SUPERIO
     select SERIAL_ISA
     select PARALLEL
     select FDC
diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
index 9e106df..ff97485 100644
--- a/hw/isa/Makefile.objs
+++ b/hw/isa/Makefile.objs
@@ -1,5 +1,5 @@
 common-obj-$(CONFIG_ISA_BUS) += isa-bus.o
-common-obj-$(CONFIG_ISA_BUS) += isa-superio.o
+common-obj-$(CONFIG_ISA_SUPERIO) += isa-superio.o
 common-obj-$(CONFIG_APM) += apm.o
 common-obj-$(CONFIG_I82378) += i82378.o
 common-obj-$(CONFIG_PC87312) += pc87312.o
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 62aa01b..2c2adbc 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -13,6 +13,7 @@ config R4K
 
 config MALTA
     bool
+    select ISA_SUPERIO
 
 config MIPSSIM
     bool
-- 
1.8.3.1


From 1ad2ab35242f226959d30655b6fe68f996e05db6 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 1 Oct 2019 15:36:21 +0200
Subject: [PULL 14/30] ide: fix leak from qemu_allocate_irqs

The array returned by qemu_allocate_irqs is malloced, free it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/ide/cmd646.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index f3ccd11..19984d2 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -300,6 +300,7 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
         d->bmdma[i].bus = &d->bus[i];
         ide_register_restart_cb(&d->bus[i]);
     }
+    g_free(irq);
 
     vmstate_register(DEVICE(dev), 0, &vmstate_ide_pci, d);
     qemu_register_reset(cmd646_reset, d);
-- 
1.8.3.1


From 7aef3dbac8808906022f9b698b7e84f983135b50 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 1 Oct 2019 15:36:22 +0200
Subject: [PULL 15/30] microblaze: fix leak of fdevice tree blob
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The device tree blob returned by load_device_tree is malloced.
Free it before returning.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/microblaze/boot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index bade4d2..d1d7dfb 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -100,6 +100,7 @@ static int microblaze_load_dtb(hwaddr addr,
     }
 
     cpu_physical_memory_write(addr, fdt, fdt_size);
+    g_free(fdt);
     return fdt_size;
 }
 
-- 
1.8.3.1


From 0005a2225b2f7128d924cda5135eb4b200b3bccf Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 1 Oct 2019 15:36:23 +0200
Subject: [PULL 16/30] mcf5208: fix leak from qemu_allocate_irqs

The array returned by qemu_allocate_irqs is malloced, free it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/m68k/mcf5208.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 012710d..60c5802 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -273,6 +273,8 @@ static void mcf5208evb_init(MachineState *machine)
                      0xfc030000, pic + 36);
     }
 
+    g_free(pic);
+
     /*  0xfc000000 SCM.  */
     /*  0xfc004000 XBS.  */
     /*  0xfc008000 FlexBus CS.  */
-- 
1.8.3.1


From 192d41f01c90974d5acac10e69e6ca665aaeb9f7 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 1 Oct 2019 15:36:24 +0200
Subject: [PULL 17/30] hppa: fix leak from g_strdup_printf
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

memory_region_init_* takes care of copying the name into memory it owns.
Free it in the caller.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/hppa/dino.c    | 1 +
 hw/hppa/machine.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index e0466ee..ab6969b 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -485,6 +485,7 @@ PCIBus *dino_init(MemoryRegion *addr_space,
         memory_region_init_alias(&s->pci_mem_alias[i], OBJECT(s),
                                  name, &s->pci_mem, addr,
                                  DINO_MEM_CHUNK_SIZE);
+        g_free(name);
     }
 
     /* Set up PCI view of memory: Bus master address space.  */
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 2736ce8..7e23675 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -78,13 +78,15 @@ static void machine_hppa_init(MachineState *machine)
 
     /* Create CPUs.  */
     for (i = 0; i < smp_cpus; i++) {
+        char *name = g_strdup_printf("cpu%ld-io-eir", i);
         cpu[i] = HPPA_CPU(cpu_create(machine->cpu_type));
 
         cpu_region = g_new(MemoryRegion, 1);
         memory_region_init_io(cpu_region, OBJECT(cpu[i]), &hppa_io_eir_ops,
-                              cpu[i], g_strdup_printf("cpu%ld-io-eir", i), 4);
+                              cpu[i], name, 4);
         memory_region_add_subregion(addr_space, CPU_HPA + i * 0x1000,
                                     cpu_region);
+        g_free(name);
     }
 
     /* Limit main memory. */
-- 
1.8.3.1


From 64b17a936cb98d0fe4a5f3aeb80c74563094565d Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 1 Oct 2019 15:36:25 +0200
Subject: [PULL 18/30] mips: fix memory leaks in board initialization

They are not a big deal, but they upset asan.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/mips/mips_int.c  | 1 +
 hw/mips/mips_jazz.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 5ebc961..863ed45 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -81,6 +81,7 @@ void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
     for (i = 0; i < 8; i++) {
         env->irq[i] = qi[i];
     }
+    g_free(qi);
 }
 
 void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level)
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index c967b97..8d010a0 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -362,6 +362,8 @@ static void mips_jazz_init(MachineState *machine,
 
     /* LED indicator */
     sysbus_create_simple("jazz-led", 0x8000f000, NULL);
+
+    g_free(dmas);
 }
 
 static
-- 
1.8.3.1


From b7fae666b861e8efd43f7d2db880dff99bdc4461 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 1 Oct 2019 15:36:26 +0200
Subject: [PULL 19/30] cris: do not leak struct cris_disasm_data

Use a stack-allocated struct to avoid a memory leak.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 disas/cris.c | 59 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/disas/cris.c b/disas/cris.c
index 2f43c9b..0b0a3fb 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -1294,24 +1294,17 @@ static int cris_constraint
 /* Parse disassembler options and store state in info.  FIXME: For the
    time being, we abuse static variables.  */
 
-static bfd_boolean
-cris_parse_disassembler_options (disassemble_info *info,
+static void
+cris_parse_disassembler_options (struct cris_disasm_data *disdata,
+				 char *disassembler_options,
 				 enum cris_disass_family distype)
 {
-  struct cris_disasm_data *disdata;
-
-  info->private_data = calloc (1, sizeof (struct cris_disasm_data));
-  disdata = (struct cris_disasm_data *) info->private_data;
-  if (disdata == NULL)
-    return false;
-
   /* Default true.  */
   disdata->trace_case
-    = (info->disassembler_options == NULL
-       || (strcmp (info->disassembler_options, "nocase") != 0));
+    = (disassembler_options == NULL
+       || (strcmp (disassembler_options, "nocase") != 0));
 
   disdata->distype = distype;
-  return true;
 }
 
 static const struct cris_spec_reg *
@@ -2736,9 +2729,10 @@ static int
 print_insn_cris_with_register_prefix (bfd_vma vma,
 				      disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_v0_v10))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_v0_v10);
   return print_insn_cris_generic (vma, info, true);
 }
 /* Disassemble, prefixing register names with `$'.  CRIS v32.  */
@@ -2747,9 +2741,10 @@ static int
 print_insn_crisv32_with_register_prefix (bfd_vma vma,
 					 disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_v32))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_v32);
   return print_insn_cris_generic (vma, info, true);
 }
 
@@ -2761,9 +2756,10 @@ static int
 print_insn_crisv10_v32_with_register_prefix (bfd_vma vma,
 					     disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_common_v10_v32))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_common_v10_v32);
   return print_insn_cris_generic (vma, info, true);
 }
 
@@ -2773,9 +2769,10 @@ static int
 print_insn_cris_without_register_prefix (bfd_vma vma,
 					 disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_v0_v10))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_v0_v10);
   return print_insn_cris_generic (vma, info, false);
 }
 
@@ -2785,9 +2782,10 @@ static int
 print_insn_crisv32_without_register_prefix (bfd_vma vma,
 					    disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_v32))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_v32);
   return print_insn_cris_generic (vma, info, false);
 }
 
@@ -2798,9 +2796,10 @@ static int
 print_insn_crisv10_v32_without_register_prefix (bfd_vma vma,
 						disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_common_v10_v32))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_common_v10_v32);
   return print_insn_cris_generic (vma, info, false);
 }
 #endif
-- 
1.8.3.1


From 7e9f82e9378021bc46ab1741070602e36b2558ea Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 1 Oct 2019 15:36:27 +0200
Subject: [PULL 20/30] lm32: do not leak memory on object_new/object_unref
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bottom halves and ptimers are malloced, but nothing in these
files is freeing memory allocated by instance_init.  Since
these are sysctl devices that are never unrealized, just moving
the allocations to realize is enough to avoid the leak in
practice (and also to avoid upsetting asan when running
device-introspect-test).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/timer/lm32_timer.c       |  6 +++---
 hw/timer/milkymist-sysctl.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index ac3edaf..cf316ed 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -186,9 +186,6 @@ static void lm32_timer_init(Object *obj)
 
     sysbus_init_irq(dev, &s->irq);
 
-    s->bh = qemu_bh_new(timer_hit, s);
-    s->ptimer = ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
-
     memory_region_init_io(&s->iomem, obj, &timer_ops, s,
                           "timer", R_MAX * 4);
     sysbus_init_mmio(dev, &s->iomem);
@@ -198,6 +195,9 @@ static void lm32_timer_realize(DeviceState *dev, Error **errp)
 {
     LM32TimerState *s = LM32_TIMER(dev);
 
+    s->bh = qemu_bh_new(timer_hit, s);
+    s->ptimer = ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
+
     ptimer_set_freq(s->ptimer, s->freq_hz);
 }
 
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 9583507..6aedc11 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -283,11 +283,6 @@ static void milkymist_sysctl_init(Object *obj)
     sysbus_init_irq(dev, &s->timer0_irq);
     sysbus_init_irq(dev, &s->timer1_irq);
 
-    s->bh0 = qemu_bh_new(timer0_hit, s);
-    s->bh1 = qemu_bh_new(timer1_hit, s);
-    s->ptimer0 = ptimer_init(s->bh0, PTIMER_POLICY_DEFAULT);
-    s->ptimer1 = ptimer_init(s->bh1, PTIMER_POLICY_DEFAULT);
-
     memory_region_init_io(&s->regs_region, obj, &sysctl_mmio_ops, s,
             "milkymist-sysctl", R_MAX * 4);
     sysbus_init_mmio(dev, &s->regs_region);
@@ -297,6 +292,11 @@ static void milkymist_sysctl_realize(DeviceState *dev, Error **errp)
 {
     MilkymistSysctlState *s = MILKYMIST_SYSCTL(dev);
 
+    s->bh0 = qemu_bh_new(timer0_hit, s);
+    s->bh1 = qemu_bh_new(timer1_hit, s);
+    s->ptimer0 = ptimer_init(s->bh0, PTIMER_POLICY_DEFAULT);
+    s->ptimer1 = ptimer_init(s->bh1, PTIMER_POLICY_DEFAULT);
+
     ptimer_set_freq(s->ptimer0, s->freq_hz);
     ptimer_set_freq(s->ptimer1, s->freq_hz);
 }
-- 
1.8.3.1


From f3048fe79ca8967394505c08eba720a2532c52c5 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 1 Oct 2019 15:36:28 +0200
Subject: [PULL 21/30] docker: test-debug: disable LeakSanitizer

There are just too many leaks in device-introspect-test (especially for
the plethora of arm and aarch64 boards) to make LeakSanitizer useful;
disable it for now.

Whoever is interested in debugging leaks can also use valgrind like this:

   QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64 \
   QTEST_QEMU_IMG=qemu-img \
   valgrind --trace-children=yes --leak-check=full \
   tests/device-introspect-test -p /aarch64/device/introspect/concrete/defaults/none

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/test-debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/test-debug b/tests/docker/test-debug
index 137f4f2..c050fa0 100755
--- a/tests/docker/test-debug
+++ b/tests/docker/test-debug
@@ -21,6 +21,7 @@ cd "$BUILD_DIR"
 OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
 OPTS="--enable-debug --enable-sanitizers $OPTS"
 
+export ASAN_OPTIONS=detect_leaks=0
 build_qemu $OPTS
 check_qemu check V=1
 install_qemu
-- 
1.8.3.1


From 471e2b7b5b1bdb842cf6b755abf8334b3cbd2184 Mon Sep 17 00:00:00 2001
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Wed, 25 Sep 2019 23:49:48 +0200
Subject: [PULL 22/30] i386: Add CPUID bit for CLZERO and XSAVEERPTR

The CPUID bits CLZERO and XSAVEERPTR are availble on AMD's ZEN platform
and could be passed to the guest.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5b771f1..313a2ef 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1130,7 +1130,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_8000_0008_EBX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            NULL, NULL, NULL, NULL,
+            "clzero", NULL, "xsaveerptr", NULL,
             NULL, NULL, NULL, NULL,
             NULL, "wbnoinvd", NULL, NULL,
             "ibpb", NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c62e3b6..033991c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -723,6 +723,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_7_1_EAX_AVX512_BF16 (1U << 5) /* AVX512 BFloat16 Instruction */
 
+#define CPUID_8000_0008_EBX_CLZERO		(1U << 0) /* CLZERO instruction */
+#define CPUID_8000_0008_EBX_XSAVEERPTR	(1U << 2) /* Always save/restore FP error pointers */
 #define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
                                                                              do not invalidate cache */
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
-- 
1.8.3.1


From 2b59b557ab863372b0d9c9c64c47990aedf99801 Mon Sep 17 00:00:00 2001
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 24 Sep 2019 10:25:16 +0200
Subject: [PULL 23/30] vfio: Turn the container error into an Error handle

The container error integer field is currently used to store
the first error potentially encountered during any
vfio_listener_region_add() call. However this fails to propagate
detailed error messages up to the vfio_connect_container caller.
Instead of using an integer, let's use an Error handle.

Messages are slightly reworded to accomodate the propagation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/common.c              | 43 ++++++++++++++++++++++++++++---------------
 hw/vfio/spapr.c               |  4 +++-
 include/hw/vfio/vfio-common.h |  2 +-
 3 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 3e03c49..cebbb1c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -509,6 +509,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     int ret;
     VFIOHostDMAWindow *hostwin;
     bool hostwin_found;
+    Error *err = NULL;
 
     if (vfio_listener_skipped_section(section)) {
         trace_vfio_listener_region_add_skip(
@@ -543,13 +544,20 @@ static void vfio_listener_region_add(MemoryListener *listener,
                                hostwin->max_iova - hostwin->min_iova + 1,
                                section->offset_within_address_space,
                                int128_get64(section->size))) {
-                ret = -1;
+                error_setg(&err,
+                    "region [0x%"PRIx64",0x%"PRIx64"] overlaps with existing"
+                    "host DMA window [0x%"PRIx64",0x%"PRIx64"]",
+                    section->offset_within_address_space,
+                    section->offset_within_address_space +
+                        int128_get64(section->size) - 1,
+                    hostwin->min_iova, hostwin->max_iova);
                 goto fail;
             }
         }
 
         ret = vfio_spapr_create_window(container, section, &pgsize);
         if (ret) {
+            error_setg_errno(&err, -ret, "Failed to create SPAPR window");
             goto fail;
         }
 
@@ -594,10 +602,8 @@ static void vfio_listener_region_add(MemoryListener *listener,
     }
 
     if (!hostwin_found) {
-        error_report("vfio: IOMMU container %p can't map guest IOVA region"
-                     " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx,
-                     container, iova, end);
-        ret = -EFAULT;
+        error_setg(&err, "Container %p can't map guest IOVA region"
+                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
         goto fail;
     }
 
@@ -664,11 +670,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
     ret = vfio_dma_map(container, iova, int128_get64(llsize),
                        vaddr, section->readonly);
     if (ret) {
-        error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
-                     "0x%"HWADDR_PRIx", %p) = %d (%m)",
-                     container, iova, int128_get64(llsize), vaddr, ret);
+        error_setg(&err, "vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
+                   "0x%"HWADDR_PRIx", %p) = %d (%m)",
+                   container, iova, int128_get64(llsize), vaddr, ret);
         if (memory_region_is_ram_device(section->mr)) {
             /* Allow unexpected mappings not to be fatal for RAM devices */
+            error_report_err(err);
             return;
         }
         goto fail;
@@ -688,9 +695,14 @@ fail:
      */
     if (!container->initialized) {
         if (!container->error) {
-            container->error = ret;
+            error_propagate_prepend(&container->error, err,
+                                    "Region %s: ",
+                                    memory_region_name(section->mr));
+        } else {
+            error_free(err);
         }
     } else {
+        error_report_err(err);
         hw_error("vfio: DMA mapping failed, unable to continue");
     }
 }
@@ -1251,6 +1263,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container = g_malloc0(sizeof(*container));
     container->space = space;
     container->fd = fd;
+    container->error = NULL;
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
 
@@ -1308,9 +1321,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                      &address_space_memory);
             if (container->error) {
                 memory_listener_unregister(&container->prereg_listener);
-                ret = container->error;
-                error_setg(errp,
-                    "RAM memory listener initialization failed for container");
+                ret = -1;
+                error_propagate_prepend(errp, container->error,
+                    "RAM memory listener initialization failed: ");
                 goto free_container_exit;
             }
         }
@@ -1365,9 +1378,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     memory_listener_register(&container->listener, container->space->as);
 
     if (container->error) {
-        ret = container->error;
-        error_setg_errno(errp, -ret,
-                         "memory listener initialization failed for container");
+        ret = -1;
+        error_propagate_prepend(errp, container->error,
+            "memory listener initialization failed: ");
         goto listener_release_exit;
     }
 
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 96c0ad9..e853eeb 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -17,6 +17,7 @@
 #include "hw/hw.h"
 #include "exec/ram_addr.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "trace.h"
 
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
@@ -85,7 +86,8 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
          */
         if (!container->initialized) {
             if (!container->error) {
-                container->error = ret;
+                error_setg_errno(&container->error, -ret,
+                                 "Memory registering failed");
             }
         } else {
             hw_error("vfio: Memory registering failed, unable to continue");
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9107bd4..fd56420 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -71,7 +71,7 @@ typedef struct VFIOContainer {
     MemoryListener listener;
     MemoryListener prereg_listener;
     unsigned iommu_type;
-    int error;
+    Error *error;
     bool initialized;
     unsigned long pgsizes;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
-- 
1.8.3.1


From bd2ebcb77278c698e3f66401365ca3471e6cc868 Mon Sep 17 00:00:00 2001
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 24 Sep 2019 10:25:17 +0200
Subject: [PULL 24/30] memory: allow memory_region_register_iommu_notifier()
 to fail

Currently, when a notifier is attempted to be registered and its
flags are not supported (especially the MAP one) by the IOMMU MR,
we generally abruptly exit in the IOMMU code. The failure could be
handled more nicely in the caller and especially in the VFIO code.

So let's allow memory_region_register_iommu_notifier() to fail as
well as notify_flag_changed() callback.

All sites implementing the callback are updated. This patch does
not yet remove the exit(1) in the amd_iommu code.

in SMMUv3 we turn the warning message into an error message saying
that the assigned device would not work properly.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                | 10 ++++++++--
 hw/arm/smmuv3.c       | 18 ++++++++++--------
 hw/i386/amd_iommu.c   | 17 ++++++++++-------
 hw/i386/intel_iommu.c |  8 +++++---
 hw/ppc/spapr_iommu.c  |  8 +++++---
 hw/vfio/common.c      |  9 +++++++--
 hw/virtio/vhost.c     |  9 +++++++--
 include/exec/memory.h | 21 ++++++++++++++++-----
 memory.c              | 31 ++++++++++++++++++++-----------
 9 files changed, 88 insertions(+), 43 deletions(-)

diff --git a/exec.c b/exec.c
index 1d6e4d8..bdcfcdf 100644
--- a/exec.c
+++ b/exec.c
@@ -660,7 +660,8 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
      */
     MemoryRegion *mr = MEMORY_REGION(iommu_mr);
     TCGIOMMUNotifier *notifier;
-    int i;
+    Error *err = NULL;
+    int i, ret;
 
     for (i = 0; i < cpu->iommu_notifiers->len; i++) {
         notifier = g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i);
@@ -689,7 +690,12 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
                             0,
                             HWADDR_MAX,
                             iommu_idx);
-        memory_region_register_iommu_notifier(notifier->mr, &notifier->n);
+        ret = memory_region_register_iommu_notifier(notifier->mr, &notifier->n,
+                                                    &err);
+        if (ret) {
+            error_report_err(err);
+            exit(1);
+        }
     }
 
     if (!notifier->active) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index db051dc..e2fbb83 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1469,20 +1469,21 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
     dc->realize = smmu_realize;
 }
 
-static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
-                                       IOMMUNotifierFlag old,
-                                       IOMMUNotifierFlag new)
+static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
+                                      IOMMUNotifierFlag old,
+                                      IOMMUNotifierFlag new,
+                                      Error **errp)
 {
     SMMUDevice *sdev = container_of(iommu, SMMUDevice, iommu);
     SMMUv3State *s3 = sdev->smmu;
     SMMUState *s = &(s3->smmu_state);
 
     if (new & IOMMU_NOTIFIER_MAP) {
-        int bus_num = pci_bus_num(sdev->bus);
-        PCIDevice *pcidev = pci_find_device(sdev->bus, bus_num, sdev->devfn);
-
-        warn_report("SMMUv3 does not support notification on MAP: "
-                     "device %s will not function properly", pcidev->name);
+        error_setg(errp,
+                   "device %02x.%02x.%x requires iommu MAP notifier which is "
+                   "not currently supported", pci_bus_num(sdev->bus),
+                   PCI_SLOT(sdev->devfn), PCI_FUNC(sdev->devfn));
+        return -EINVAL;
     }
 
     if (old == IOMMU_NOTIFIER_NONE) {
@@ -1492,6 +1493,7 @@ static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
         trace_smmuv3_notify_flag_del(iommu->parent_obj.name);
         QLIST_REMOVE(sdev, next);
     }
+    return 0;
 }
 
 static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 0888452..d372636 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1466,18 +1466,21 @@ static const MemoryRegionOps mmio_mem_ops = {
     }
 };
 
-static void amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
-                                            IOMMUNotifierFlag old,
-                                            IOMMUNotifierFlag new)
+static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
+                                           IOMMUNotifierFlag old,
+                                           IOMMUNotifierFlag new,
+                                           Error **errp)
 {
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
 
     if (new & IOMMU_NOTIFIER_MAP) {
-        error_report("device %02x.%02x.%x requires iommu notifier which is not "
-                     "currently supported", as->bus_num, PCI_SLOT(as->devfn),
-                     PCI_FUNC(as->devfn));
-        exit(1);
+        error_setg(errp,
+                   "device %02x.%02x.%x requires iommu notifier which is not "
+                   "currently supported", as->bus_num, PCI_SLOT(as->devfn),
+                   PCI_FUNC(as->devfn));
+        return -EINVAL;
     }
+    return 0;
 }
 
 static void amdvi_init(AMDVIState *s)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f1de8fd..771bed2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2929,9 +2929,10 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     return iotlb;
 }
 
-static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
-                                          IOMMUNotifierFlag old,
-                                          IOMMUNotifierFlag new)
+static int vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
+                                         IOMMUNotifierFlag old,
+                                         IOMMUNotifierFlag new,
+                                         Error **errp)
 {
     VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
@@ -2944,6 +2945,7 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     } else if (new == IOMMU_NOTIFIER_NONE) {
         QLIST_REMOVE(vtd_as, next);
     }
+    return 0;
 }
 
 static int vtd_post_load(void *opaque, int version_id)
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index e87b3d5..3d3bcc8 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -205,9 +205,10 @@ static int spapr_tce_get_attr(IOMMUMemoryRegion *iommu,
     return -EINVAL;
 }
 
-static void spapr_tce_notify_flag_changed(IOMMUMemoryRegion *iommu,
-                                          IOMMUNotifierFlag old,
-                                          IOMMUNotifierFlag new)
+static int spapr_tce_notify_flag_changed(IOMMUMemoryRegion *iommu,
+                                         IOMMUNotifierFlag old,
+                                         IOMMUNotifierFlag new,
+                                         Error **errp)
 {
     struct SpaprTceTable *tbl = container_of(iommu, SpaprTceTable, iommu);
 
@@ -216,6 +217,7 @@ static void spapr_tce_notify_flag_changed(IOMMUMemoryRegion *iommu,
     } else if (old != IOMMU_NOTIFIER_NONE && new == IOMMU_NOTIFIER_NONE) {
         spapr_tce_set_need_vfio(tbl, false);
     }
+    return 0;
 }
 
 static int spapr_tce_table_post_load(void *opaque, int version_id)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index cebbb1c..5ca1148 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -636,9 +636,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
                             section->offset_within_region,
                             int128_get64(llend),
                             iommu_idx);
-        QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
 
-        memory_region_register_iommu_notifier(section->mr, &giommu->n);
+        ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
+                                                    &err);
+        if (ret) {
+            g_free(giommu);
+            goto fail;
+        }
+        QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
         memory_region_iommu_replay(giommu->iommu, &giommu->n);
 
         return;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2386b51..99de5f1 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -677,8 +677,9 @@ static void vhost_iommu_region_add(MemoryListener *listener,
                                          iommu_listener);
     struct vhost_iommu *iommu;
     Int128 end;
-    int iommu_idx;
+    int iommu_idx, ret;
     IOMMUMemoryRegion *iommu_mr;
+    Error *err = NULL;
 
     if (!memory_region_is_iommu(section->mr)) {
         return;
@@ -701,7 +702,11 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     iommu->iommu_offset = section->offset_within_address_space -
                           section->offset_within_region;
     iommu->hdev = dev;
-    memory_region_register_iommu_notifier(section->mr, &iommu->n);
+    ret = memory_region_register_iommu_notifier(section->mr, &iommu->n, &err);
+    if (ret) {
+        error_report_err(err);
+        exit(1);
+    }
     QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next);
     /* TODO: can replay help performance here? */
 }
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6e67043..e499dc2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -288,10 +288,16 @@ typedef struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      * @old_flags: events which previously needed to be notified
      * @new_flags: events which now need to be notified
+     *
+     * Returns 0 on success, or a negative errno; in particular
+     * returns -EINVAL if the new flag bitmap is not supported by the
+     * IOMMU memory region. In case of failure, the error object
+     * must be created
      */
-    void (*notify_flag_changed)(IOMMUMemoryRegion *iommu,
-                                IOMMUNotifierFlag old_flags,
-                                IOMMUNotifierFlag new_flags);
+    int (*notify_flag_changed)(IOMMUMemoryRegion *iommu,
+                               IOMMUNotifierFlag old_flags,
+                               IOMMUNotifierFlag new_flags,
+                               Error **errp);
     /* Called to handle memory_region_iommu_replay().
      *
      * The default implementation of memory_region_iommu_replay() is to
@@ -1079,13 +1085,18 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
  * memory_region_register_iommu_notifier: register a notifier for changes to
  * IOMMU translation entries.
  *
+ * Returns 0 on success, or a negative errno otherwise. In particular,
+ * -EINVAL indicates that at least one of the attributes of the notifier
+ * is not supported (flag/range) by the IOMMU memory region. In case of error
+ * the error object must be created.
+ *
  * @mr: the memory region to observe
  * @n: the IOMMUNotifier to be added; the notify callback receives a
  *     pointer to an #IOMMUTLBEntry as the opaque value; the pointer
  *     ceases to be valid on exit from the notifier.
  */
-void memory_region_register_iommu_notifier(MemoryRegion *mr,
-                                           IOMMUNotifier *n);
+int memory_region_register_iommu_notifier(MemoryRegion *mr,
+                                          IOMMUNotifier *n, Error **errp);
 
 /**
  * memory_region_iommu_replay: replay existing IOMMU translations to
diff --git a/memory.c b/memory.c
index a99b8c0..978da3d 100644
--- a/memory.c
+++ b/memory.c
@@ -1817,33 +1817,38 @@ bool memory_region_is_logging(MemoryRegion *mr, uint8_t client)
     return memory_region_get_dirty_log_mask(mr) & (1 << client);
 }
 
-static void memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *iommu_mr)
+static int memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *iommu_mr,
+                                                   Error **errp)
 {
     IOMMUNotifierFlag flags = IOMMU_NOTIFIER_NONE;
     IOMMUNotifier *iommu_notifier;
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
+    int ret = 0;
 
     IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
         flags |= iommu_notifier->notifier_flags;
     }
 
     if (flags != iommu_mr->iommu_notify_flags && imrc->notify_flag_changed) {
-        imrc->notify_flag_changed(iommu_mr,
-                                  iommu_mr->iommu_notify_flags,
-                                  flags);
+        ret = imrc->notify_flag_changed(iommu_mr,
+                                        iommu_mr->iommu_notify_flags,
+                                        flags, errp);
     }
 
-    iommu_mr->iommu_notify_flags = flags;
+    if (!ret) {
+        iommu_mr->iommu_notify_flags = flags;
+    }
+    return ret;
 }
 
-void memory_region_register_iommu_notifier(MemoryRegion *mr,
-                                           IOMMUNotifier *n)
+int memory_region_register_iommu_notifier(MemoryRegion *mr,
+                                          IOMMUNotifier *n, Error **errp)
 {
     IOMMUMemoryRegion *iommu_mr;
+    int ret;
 
     if (mr->alias) {
-        memory_region_register_iommu_notifier(mr->alias, n);
-        return;
+        return memory_region_register_iommu_notifier(mr->alias, n, errp);
     }
 
     /* We need to register for at least one bitfield */
@@ -1854,7 +1859,11 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
            n->iommu_idx < memory_region_iommu_num_indexes(iommu_mr));
 
     QLIST_INSERT_HEAD(&iommu_mr->iommu_notify, n, node);
-    memory_region_update_iommu_notify_flags(iommu_mr);
+    ret = memory_region_update_iommu_notify_flags(iommu_mr, errp);
+    if (ret) {
+        QLIST_REMOVE(n, node);
+    }
+    return ret;
 }
 
 uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommu_mr)
@@ -1907,7 +1916,7 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
     }
     QLIST_REMOVE(n, node);
     iommu_mr = IOMMU_MEMORY_REGION(mr);
-    memory_region_update_iommu_notify_flags(iommu_mr);
+    memory_region_update_iommu_notify_flags(iommu_mr, NULL);
 }
 
 void memory_region_notify_one(IOMMUNotifier *notifier,
-- 
1.8.3.1


From 3716ad2adceafc00ecb8268274b170fe1dd88a35 Mon Sep 17 00:00:00 2001
From: Dmitry Poletaev <poletaev@ispras.ru>
Date: Wed, 18 Sep 2019 13:07:06 +0300
Subject: [PULL 25/30] Fix wrong behavior of cpu_memory_rw_debug() function in
 SMM

There is a problem, that you don't have access to the data using cpu_memory_rw_debug() function when in SMM. You can't remotely debug SMM mode program because of that for example.
Likely attrs version of get_phys_page_debug should be used to get correct asidx at the end to handle access properly.
Here the patch to fix it.

Signed-off-by: Dmitry Poletaev <poletaev@ispras.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c    | 2 +-
 target/i386/cpu.h    | 3 ++-
 target/i386/helper.c | 5 ++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 313a2ef..8fcb571 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6245,7 +6245,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->asidx_from_attrs = x86_asidx_from_attrs;
     cc->get_memory_mapping = x86_cpu_get_memory_mapping;
-    cc->get_phys_page_debug = x86_cpu_get_phys_page_debug;
+    cc->get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug;
     cc->write_elf64_note = x86_cpu_write_elf64_note;
     cc->write_elf64_qemunote = x86_cpu_write_elf64_qemunote;
     cc->write_elf32_note = x86_cpu_write_elf32_note;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 033991c..eaa5395 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1690,7 +1690,8 @@ void x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
 
 void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
-hwaddr x86_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+                                         MemTxAttrs *attrs);
 
 int x86_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 0fa51be..c3a6e4f 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -715,7 +715,8 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
+                                         MemTxAttrs *attrs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -725,6 +726,8 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     uint32_t page_offset;
     int page_size;
 
+    *attrs = cpu_get_mem_attrs(env);
+
     a20_mask = x86_get_a20_mask(env);
     if (!(env->cr[0] & CR0_PG_MASK)) {
         pte = addr & a20_mask;
-- 
1.8.3.1


From 54ab28073a479d74cf0bdb7e173b75bd977c8762 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 1 Oct 2019 17:26:07 +0400
Subject: [PULL 26/30] util: WSAEWOULDBLOCK on connect should map to
 EINPROGRESS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In general, WSAEWOULDBLOCK can be mapped to EAGAIN as done by
socket_error() (or EWOULDBLOCK). But for connect() with non-blocking
sockets, it actually means the operation is in progress:

https://docs.microsoft.com/en-us/windows/win32/api/winsock2/nf-winsock2-connect
"The socket is marked as nonblocking and the connection cannot be completed immediately."

(this is also the behaviour implemented by GLib GSocket)

This fixes socket_can_bind_connect() test on win32.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/oslib-win32.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index c62cd43..886e400 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -585,7 +585,11 @@ int qemu_connect_wrap(int sockfd, const struct sockaddr *addr,
     int ret;
     ret = connect(sockfd, addr, addrlen);
     if (ret < 0) {
-        errno = socket_error();
+        if (WSAGetLastError() == WSAEWOULDBLOCK) {
+            errno = EINPROGRESS;
+        } else {
+            errno = socket_error();
+        }
     }
     return ret;
 }
-- 
1.8.3.1


From d8b01575cfadd94edbdca3febfc33b517413bda8 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 1 Oct 2019 17:26:08 +0400
Subject: [PULL 27/30] tests: skip serial test on windows
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Serial test is currently hard-coded to /dev/null.

On Windows, serial chardev expect a COM: device, which may not be
availble.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-char.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index d62de1b..45e42af 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1103,7 +1103,7 @@ static void char_socket_server_two_clients_test(gconstpointer opaque)
 }
 
 
-#ifdef HAVE_CHARDEV_SERIAL
+#if defined(HAVE_CHARDEV_SERIAL) && !defined(WIN32)
 static void char_serial_test(void)
 {
     QemuOpts *opts;
@@ -1460,7 +1460,7 @@ int main(int argc, char **argv)
 #endif
 
     g_test_add_func("/char/udp", char_udp_test);
-#ifdef HAVE_CHARDEV_SERIAL
+#if defined(HAVE_CHARDEV_SERIAL) && !defined(WIN32)
     g_test_add_func("/char/serial", char_serial_test);
 #endif
     g_test_add_func("/char/hotswap", char_hotswap_test);
-- 
1.8.3.1


From 2690c7ff5247cc2aa7350ae88bd9740bfcc6b8a4 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 1 Oct 2019 17:26:09 +0400
Subject: [PULL 28/30] win32: work around main-loop busy loop on socket/fd
 event
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 05e514b1d4d5bd4209e2c8bbc76ff05c85a235f3 introduced an AIO
context optimization to avoid calling event_notifier_test_and_clear() on
ctx->notifier. On Windows, the same notifier is being used to wakeup the
wait on socket events (see commit
d3385eb448e38f828c78f8f68ec5d79c66a58b5d).

The ctx->notifier event is added to the gpoll sources in
aio_set_event_notifier(), aio_ctx_check() should clear the event
regardless of ctx->notified, since Windows sets the event by itself,
bypassing the aio->notified. This fixes qemu not clearing the event
resulting in a busy loop.

Paolo suggested to me on irc to call event_notifier_test_and_clear()
after select() >0 from aio-win32.c's aio_prepare. Unfortunately, not all
fds associated with ctx->notifiers are in AIO fd handlers set.
(qemu_set_nonblock() in util/oslib-win32.c calls qemu_fd_register()).

This is essentially a v2 of a patch that was sent earlier:
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg00420.html

that resurfaced when James investigated Spice performance issues on Windows:
https://gitlab.freedesktop.org/spice/spice/issues/36

In order to test that patch, I simply tried running test-char on
win32, and it hangs. Applying that patch solves it. QIO idle sources
are not dispatched. I haven't investigated much further, I suspect
source priorities and busy looping still come into play.

This version keeps the "notified" field, so event_notifier_poll()
should still work as expected.

Cc: James Le Cuirot <chewi@gentoo.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/async.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/async.c b/util/async.c
index 4e4c7af..ca83e32 100644
--- a/util/async.c
+++ b/util/async.c
@@ -354,7 +354,11 @@ void aio_notify(AioContext *ctx)
 
 void aio_notify_accept(AioContext *ctx)
 {
-    if (atomic_xchg(&ctx->notified, false)) {
+    if (atomic_xchg(&ctx->notified, false)
+#ifdef WIN32
+        || true
+#endif
+    ) {
         event_notifier_test_and_clear(&ctx->notifier);
     }
 }
-- 
1.8.3.1


From 2ab909dd07e1317e3cfae8d235e3705cb1e98ccb Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 1 Oct 2019 15:48:55 +0200
Subject: [PULL 29/30] tests/docker: only enable ubsan for test-clang

-fsanitize=undefined is not the same thing as --enable-sanitizers.  After
commit 47c823e ("tests/docker: add sanitizers back to clang build", 2019-09-11)
test-clang is almost duplicating the asan (test-debug) test, so
partly revert commit 47c823e5b while leaving ubsan enabled.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/test-clang | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/docker/test-clang b/tests/docker/test-clang
index db9e697..8c51ead 100755
--- a/tests/docker/test-clang
+++ b/tests/docker/test-clang
@@ -17,7 +17,9 @@ requires clang
 
 cd "$BUILD_DIR"
 
-OPTS="--cxx=clang++ --cc=clang --host-cc=clang --enable-sanitizers"
+OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
+OPTS="$OPTS --extra-cflags=-fsanitize=undefined \
+    --extra-cflags=-fno-sanitize=float-divide-by-zero"
 build_qemu $OPTS
 check_qemu
 install_qemu
-- 
1.8.3.1


From 52c8850d80c5bf34afd3b203b912217f45327a9e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 2 Oct 2019 11:22:12 +0100
Subject: [PULL 30/30] accel/kvm: ensure ret always set
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some of the cross compilers rightly complain there are cases where ret
may not be set. 0 seems to be the reasonable default unless particular
slot explicitly returns -1.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index aabe097..d2d96d7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -712,11 +712,11 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
     KVMState *s = kvm_state;
     uint64_t start, size, offset, count;
     KVMSlot *mem;
-    int ret, i;
+    int ret = 0, i;
 
     if (!s->manual_dirty_log_protect) {
         /* No need to do explicit clear */
-        return 0;
+        return ret;
     }
 
     start = section->offset_within_address_space;
@@ -724,7 +724,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
 
     if (!size) {
         /* Nothing more we can do... */
-        return 0;
+        return ret;
     }
 
     kvm_slots_lock(kml);
-- 
1.8.3.1


