Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3A1C34033
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767FF24649
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767FF24649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3yom-0000Z6-L3
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1j3ylg-0006Vw-Cq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1j3yld-0003d7-VB
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:02:12 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:56740 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1j3yld-0003Nk-F7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:02:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id EC2081A217E;
 Tue, 18 Feb 2020 10:01:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 2D1BD1A200F;
 Tue, 18 Feb 2020 10:00:48 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] tests/tcg/multiarch: Add tests for implemented alsa
 sound timer ioctls
Date: Tue, 18 Feb 2020 10:00:42 +0100
Message-Id: <1582016442-1677-3-git-send-email-Filip.Bozuta@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582016442-1677-1-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1582016442-1677-1-git-send-email-Filip.Bozuta@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds tests for following 14 implemented alsa timer ioctls:

* SNDRV_TIMER_IOCTL_PVERSION        * SNDRV_TIMER_IOCTL_INFO
* SNDRV_TIMER_IOCTL_NEXT_DEVICE     * SNDRV_TIMER_IOCTL_PARAMS
* SNDRV_TIMER_IOCTL_TREAD           * SNDRV_TIMER_IOCTL_STATUS
* SNDRV_TIMER_IOCTL_GINFO           * SNDRV_TIMER_IOCTL_START
* SNDRV_TIMER_IOCTL_GPARAMS         * SNDRV_TIMER_IOCTL_STOP
* SNDRV_TIMER_IOCTL_GSTATUS         * SNDRV_TIMER_IOCTL_CONTINUE
* SNDRV_TIMER_IOCTL_SELECT          * SNDRV_TIMER_IOCTL_PAUSE

Names and descriptions of these ioctls can be found in patches that
implement them.

Test folder for these ioctl tests is located at
"tests/tcg/multiarch/alsa-timer-ioctl-tests/"

There are two folders located in the test folder, one for test that  was written
manually ("/manual-test") and one for the test that  was obtained remotely ("/remote-test").

Manual test:

    This test was written manually to test all the implemented alsa timer ioctls
    and was added at "/manual-test/alsa-timer-ioctl-manual-test.c". A separate test
    function was written for each ioctl. Each of these functions uses a global test
    macro 'TEST_ALSA_IOCTL' to run these tests. The file can be run to test all ioctls
    or it can test only the specified ioctls. This depends on the commands specified
    when running the test.

    For Example (assuming 'rtc-ioctl-manual-test' is the compiled .exe file):

      running './alsa-timer-ioctl-manual-test SNDRV_TIMER_IOCTL_TREAD' tests only the
      ioctl SNDRV_TIMER_IOCTL_TREAD

      running './alsa-timer-ioctl-manual-test  SNDRV_TIMER_IOCTL_INFO SNDRV_TIMER_IOCTL_STOP
      SNDRV_TIMER_IOCTL_PAUSE' tests ioctls SNDRV_TIMER_IOCTL_INFO, SNDRV_TIMER_IOCTL_STOP,
      SNDRV_TIMER_IOCTL_PAUSE

    If no ioctl is specified when running the test file, all the ioctls
    are tested:

      running './rtc-ioctl-test' tests all ioctls

Remote test:

    Besides the manual tests, a remote alsa timer ioctl test was added at
    "/remote-test/timer.c". This test file was downloaded from a git repository
    that contains alsa ioctl test suite. This repository is located at
    "https://github.com/takaswie/alsa-ioctl-test". It is used to test all of the
    alsa timer ioctls at once by running a test macro defined in that file.
    The file was modified a little bit by adding an output line that shows which
    test passed and at which test the program aborts. It was also modified so that
    it doesn't have styling problems detected by 'scripts/checkpatch.pl'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 .../manual-test/alsa-timer-ioctl-manual-test.c     | 294 +++++++++++++++++++++
 .../alsa-timer-ioctl-tests/remote-test/timer.c     | 158 +++++++++++
 2 files changed, 452 insertions(+)
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/manual-test/alsa-timer-ioctl-manual-test.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/remote-test/timer.c

diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/manual-test/alsa-timer-ioctl-manual-test.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/manual-test/alsa-timer-ioctl-manual-test.c
new file mode 100644
index 0000000..68d66e2
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/manual-test/alsa-timer-ioctl-manual-test.c
@@ -0,0 +1,294 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+#define TEST_ALSA_IOCTL(fd, command, argument, supported)     \
+    do {                                                      \
+        printf("%s:\n", #command);                            \
+        if (ioctl(fd, command, argument) == ERROR) {          \
+            perror("ioctl");                                  \
+            printf("\n");                                     \
+            supported = false;                                \
+        }                                                     \
+    } while (0)
+
+static bool test_pversion(int fd, bool supported)
+{
+    int version = 0;
+
+    TEST_ALSA_IOCTL(fd, SNDRV_TIMER_IOCTL_PVERSION, &version, supported);
+    if (supported) {
+        printf("Timer version: %d\n", version);
+        printf("\n");
+    }
+    return supported;
+}
+
+static bool test_next_device(int fd, bool supported)
+{
+    struct snd_timer_id id = {1, 0, 0, 0, 0};
+
+    TEST_ALSA_IOCTL(fd, SNDRV_TIMER_IOCTL_NEXT_DEVICE, &id, supported);
+    if (supported) {
+        printf("Timer dev_class: %d\n", id.dev_class);
+        printf("Timer dev_sclass: %d\n", id.dev_class);
+        printf("Timer card: %d\n", id.dev_class);
+        printf("Timer device: %d\n", id.dev_class);
+        printf("Timer subdevice: %d\n", id.dev_class);
+        printf("\n");
+    }
+    return supported;
+}
+
+static bool test_tread(int fd, bool supported)
+{
+    int tread = 1;
+
+    TEST_ALSA_IOCTL(fd, SNDRV_TIMER_IOCTL_TREAD, &tread, supported);
+    if (supported) {
+        printf("Enhanced read enabled!\n");
+        printf("\n");
+    }
+    return supported;
+}
+
+static bool test_ginfo(int fd, bool supported)
+{
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+    struct snd_timer_ginfo ginfo;
+    ginfo.tid = id;
+
+    TEST_ALSA_IOCTL(fd, SNDRV_TIMER_IOCTL_GINFO, &ginfo, supported);
+    if (supported) {
+        printf("Timer flags: %u\n", ginfo.flags);
+        printf("Card number: %d\n", ginfo.card);
+        printf("Timer identification: %s\n", ginfo.id);
+        printf("Timer name: %s\n", ginfo.name);
+        printf("Average period resolution: %luns\n", ginfo.resolution);
+        printf("Minimal period resolution: %luns\n", ginfo.resolution_min);
+        printf("Maximal period resolution: %luns\n", ginfo.resolution_max);
+        printf("Active timer clients: %u\n", ginfo.clients);
+        printf("\n");
+    }
+    return supported;
+}
+
+static bool test_gparams(int fd, bool supported)
+{
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+    struct snd_timer_gparams gparams;
+    gparams.tid = id;
+
+    gparams.period_num = 2;
+    gparams.period_den = 3;
+
+    TEST_ALSA_IOCTL(fd, SNDRV_TIMER_IOCTL_GPARAMS, &gparams, supported);
+    if (supported) {
+        printf("Period duration numerator set: %lus\n", gparams.period_num);
+        printf("Period duration denominator set: %lus\n", gparams.period_den);
+        printf("\n");
+    }
+    return supported;
+}
+
+static bool test_gstatus(int fd, bool supported)
+{
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+    struct snd_timer_gstatus gstatus;
+    gstatus.tid = id;
+
+    TEST_ALSA_IOCTL(fd, SNDRV_TIMER_IOCTL_GSTATUS, &gstatus, supported);
+    if (supported) {
+        printf("Current period resolution: %luns\n", gstatus.resolution);
+        printf("Period resolution numerator: %lu\n", gstatus.resolution_num);
+        printf("Period resolution denominator: %lu\n", gstatus.resolution_den);
+        printf("\n");
+    }
+    return supported;
+}
+
+static bool test_select(int fd, bool supported)
+{
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+    struct snd_timer_select select;
+    select.id = id;
+
+    TEST_ALSA_IOCTL(fd, SNDRV_TIMER_IOCTL_SELECT, &select, supported);
+    if (supported) {
+        printf("Global timer selected!\n");
+        printf("\n");
+    }
+    return supported;
+}
+
+static bool test_info(int fd, bool supported)
+{
+    struct snd_timer_info info = {0};
+
+    TEST_ALSA_IOCTL(fd, SNDRV_TIMER_IOCTL_INFO, &info, supported);
+    if (supported) {
+        printf("timer flags: %u\n", info.flags);
+        printf("card number: %d\n", info.card);
+        printf("timer identificator: %s\n", info.id);
+        printf("timer name: %s\n", info.name);
+        printf("average period resolution: %luns\n", info.resolution);
+        printf("\n");
+    }
+    return supported;
+}
+
+static bool test_params(int fd, bool supported)
+{
+    struct snd_timer_params params = {0};
+    params.ticks = 1;
+    params.filter = SNDRV_TIMER_EVENT_TICK;
+
+    TEST_ALSA_IOCTL(fd, SNDRV_TIMER_IOCTL_PARAMS, &params, supported);
+    if (supported) {
+        printf("Resolution in ticks set: %u\n", params.ticks);
+        printf("Event filter set: %d\n", params.filter);
+        printf("\n");
+    }
+    return supported;
+}
+
+static bool test_status(int fd, bool supported)
+{
+    struct snd_timer_status status = {0};
+
+    TEST_ALSA_IOCTL(fd, SNDRV_TIMER_IOCTL_STATUS, &status, supported);
+    if (supported) {
+        printf("Current period resolution: %dns\n", status.resolution);
+        printf("Master tick lost: %d\n", status.lost);
+        printf("Read queue overruns: %d\n", status.overrun);
+        printf("Queue size: %d\n", status.queue);
+        printf("\n");
+    }
+    return supported;
+}
+
+static bool test_start(int fd, bool supported)
+{
+    TEST_ALSA_IOCTL(fd, SNDRV_TIMER_IOCTL_START, NULL, supported);
+    if (supported) {
+        printf("Alsa sound timer started!\n");
+        printf("\n");
+    }
+    return supported;
+}
+
+static bool test_pause(int fd, bool supported)
+{
+    TEST_ALSA_IOCTL(fd, SNDRV_TIMER_IOCTL_PAUSE, NULL, supported);
+    if (supported) {
+        printf("Alsa sound timer paused!\n");
+        printf("\n");
+    }
+    return supported;
+}
+
+static bool test_continue(int fd, bool supported)
+{
+    TEST_ALSA_IOCTL(fd, SNDRV_TIMER_IOCTL_CONTINUE, NULL, supported);
+    if (supported) {
+        printf("Alsa sound timer continued!\n");
+        printf("\n");
+    }
+    return supported;
+}
+
+static bool test_stop(int fd, bool supported)
+{
+    TEST_ALSA_IOCTL(fd, SNDRV_TIMER_IOCTL_STOP, NULL, supported);
+    if (supported) {
+        printf("Alsa sound timer stopped!\n");
+        printf("\n");
+    }
+    return supported;
+}
+
+int main(int argc, char **argv)
+{
+    char ioctls[15][35] = {"SNDRV_TIMER_IOCTL_PVERSION",
+                           "SNDRV_TIMER_IOCTL_NEXT_DEVICE",
+                           "SNDRV_TIMER_IOCTL_TREAD",
+                           "SNDRV_TIMER_IOCTL_GINFO",
+                           "SNDRV_TIMER_IOCTL_GPARAMS",
+                           "SNDRV_TIMER_IOCTL_GSTATUS",
+                           "SNDRV_TIMER_IOCTL_SELECT",
+                           "SNDRV_TIMER_IOCTL_INFO",
+                           "SNDRV_TIMER_IOCTL_PARAMS",
+                           "SNDRV_TIMER_IOCTL_STATUS",
+                           "SNDRV_TIMER_IOCTL_START",
+                           "SNDRV_TIMER_IOCTL_PAUSE",
+                           "SNDRV_TIMER_IOCTL_CONTINUE",
+                           "SNDRV_TIMER_IOCTL_STOP"};
+
+    bool (*const funcs[]) (int, bool) = {
+          test_pversion,
+          test_next_device,
+          test_tread,
+          test_ginfo,
+          test_gparams,
+          test_gstatus,
+          test_select,
+          test_info,
+          test_params,
+          test_status,
+          test_start,
+          test_pause,
+          test_continue,
+          test_stop,
+          NULL
+    };
+
+    int fd = open("/dev/snd/timer", O_RDWR | O_NONBLOCK);
+
+    if (fd == ERROR) {
+        perror("open");
+        exit(EXIT_FAILURE);
+    }
+
+    bool supported = true;
+
+    if (argc > 1) {
+        for (int i = 1; i < argc; i++) {
+            int j = 0;
+            int found = 0;
+
+            for (int j = 0; j < 14; j++) {
+                if (!strcmp(argv[i], ioctls[j])) {
+                    found = 1;
+                    funcs[j](fd, supported);
+                }
+            }
+
+            if (!found) {
+                printf("%s: No such ioctl command!\n", argv[i]);
+            }
+        }
+    } else {
+        unsigned int i = 0;
+
+        while (funcs[i++]) {
+            funcs[i - 1](fd, supported);
+        }
+    }
+
+    exit(EXIT_SUCCESS);
+}
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/remote-test/timer.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/remote-test/timer.c
new file mode 100644
index 0000000..d45f0b2
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/remote-test/timer.c
@@ -0,0 +1,158 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include <sys/ioctl.h>
+
+#include <errno.h>
+#include <string.h>
+
+#include <sound/asound.h>
+
+static void build_system_timer_id(struct snd_timer_id *tid)
+{
+    tid->dev_class = SNDRV_TIMER_CLASS_GLOBAL;
+    tid->dev_sclass = SNDRV_TIMER_SCLASS_NONE;
+    tid->card = -1;
+    tid->device = SNDRV_TIMER_GLOBAL_SYSTEM;
+    tid->subdevice = 0;
+}
+
+#define TEST_IOCTL(fd, command, argument, expected)                     \
+    do {                                                                \
+        if (ioctl(fd, command, argument) < 0 && errno != expected) {    \
+            printf("%s: %s\n", #command, strerror(errno));              \
+            return false;                                               \
+        }                                                               \
+        printf("%s: Test passed!\n", #command);                         \
+        return true;                                                    \
+    } while (0)
+
+static bool check_pversion(int fd)
+{
+    int version = 0;
+    TEST_IOCTL(fd, SNDRV_TIMER_IOCTL_PVERSION, &version, 0);
+}
+
+static bool check_next_device(int fd)
+{
+    struct snd_timer_id id = {0};
+    TEST_IOCTL(fd, SNDRV_TIMER_IOCTL_NEXT_DEVICE, &id, 0);
+}
+
+static bool check_tread(int fd)
+{
+    int tread = 1;
+    TEST_IOCTL(fd, SNDRV_TIMER_IOCTL_TREAD, &tread, 0);
+}
+
+static bool check_ginfo(int fd)
+{
+    struct snd_timer_ginfo ginfo = {0};
+    build_system_timer_id(&ginfo.tid);
+    TEST_IOCTL(fd, SNDRV_TIMER_IOCTL_GINFO, &ginfo, 0);
+}
+
+static bool check_gparams(int fd)
+{
+    struct snd_timer_gparams gparams = {0};
+    build_system_timer_id(&gparams.tid);
+    TEST_IOCTL(fd, SNDRV_TIMER_IOCTL_GPARAMS, &gparams, ENOSYS);
+}
+
+static bool check_gstatus(int fd)
+{
+    struct snd_timer_gstatus gstatus = {0};
+    build_system_timer_id(&gstatus.tid);
+    TEST_IOCTL(fd, SNDRV_TIMER_IOCTL_GSTATUS, &gstatus, 0);
+}
+
+static bool check_select(int fd)
+{
+    struct snd_timer_select select = {0};
+    build_system_timer_id(&select.id);
+    TEST_IOCTL(fd, SNDRV_TIMER_IOCTL_SELECT, &select, 0);
+}
+
+static bool check_info(int fd)
+{
+    struct snd_timer_info info = {0};
+    TEST_IOCTL(fd, SNDRV_TIMER_IOCTL_INFO, &info, 0);
+}
+
+static bool check_params(int fd)
+{
+    struct snd_timer_params params = {0};
+    params.ticks = 1;
+    params.filter = SNDRV_TIMER_EVENT_TICK;
+    TEST_IOCTL(fd, SNDRV_TIMER_IOCTL_PARAMS, &params, 0);
+}
+
+static bool check_status(int fd)
+{
+    struct snd_timer_status status = {0};
+    TEST_IOCTL(fd, SNDRV_TIMER_IOCTL_STATUS, &status, 0);
+}
+
+static bool check_start(int fd)
+{
+    TEST_IOCTL(fd, SNDRV_TIMER_IOCTL_START, NULL, 0);
+}
+
+static bool check_stop(int fd)
+{
+    TEST_IOCTL(fd, SNDRV_TIMER_IOCTL_STOP, NULL, 0);
+}
+
+static bool check_continue(int fd)
+{
+    TEST_IOCTL(fd, SNDRV_TIMER_IOCTL_CONTINUE, NULL, 0);
+}
+
+static bool check_pause(int fd)
+{
+    TEST_IOCTL(fd, SNDRV_TIMER_IOCTL_PAUSE, NULL, 0);
+}
+
+int main(void)
+{
+    bool (*const funcs[])(int) = {
+        check_pversion,
+        check_next_device,
+        check_tread,
+        check_ginfo,
+        check_gparams,
+        check_gstatus,
+        check_select,
+        check_info,
+        check_params,
+        check_status,
+        check_start,
+        check_pause,
+        check_continue,
+        check_stop,
+        NULL,
+    };
+    unsigned int i;
+    int fd;
+
+    fd = open("/dev/snd/timer", O_RDONLY);
+    if (fd < 0) {
+        printf("%s\n", strerror(errno));
+        return EXIT_FAILURE;
+    }
+
+    i = 0;
+    while (funcs[i]) {
+        if (!funcs[i++](fd)) {
+            printf("Timer test aborts.\n");
+            return EXIT_FAILURE;
+        }
+    }
+
+    return EXIT_SUCCESS;
+}
-- 
2.7.4


