Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89CCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5C3217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5C3217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZeT-0005Dt-VS
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1itZdF-0003zy-Os
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1itZdB-0005Ld-O4
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:10:29 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:43142 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1itZdB-0004bq-9d
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:10:25 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 2E5B31A20EF;
 Mon, 20 Jan 2020 17:09:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 086611A2107;
 Mon, 20 Jan 2020 17:09:20 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] tests/tcg/multiarch: Add tests for implemented alsa sound
 timer ioctls
Date: Mon, 20 Jan 2020 17:09:14 +0100
Message-Id: <1579536554-30701-3-git-send-email-Filip.Bozuta@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579536554-30701-1-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1579536554-30701-1-git-send-email-Filip.Bozuta@rt-rk.com>
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

Tests for individual ioctls are located in separate folders. These
folders are arranged by the same way these ioctls are implemented
in patches. These test files are simple programs that use these
ioctls to set/read some alsa timer features or to run some simple
alsa timer instructions.

Besides tests for individual ioctls, a global alsa ioctl test was
added at "tests/tcg/multiarch/rtc-ioctl-tests/GlobalTest/timer.c".
This test file was downloaded from a git repository that contains
alsa ioctl test suite. This repository is located at
"https://github.com/takaswie/alsa-ioctl-test".
It is used to test all of the alsa timer ioctls at once by running
a test macro defined in that file. The file was modified a little
bit by adding an output line that shows which test passed and at
which test the program aborts. It was also modified so that it
doesn't have styling problems detected by 'scripts/checkpatch.pl'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 .../Disable/disableEnhancedRead.c                  |  29 ++++
 .../EnhancedRead-test/Enable/enableEnhancedRead.c  |  29 ++++
 .../alsa-timer-ioctl-tests/GlobalTest/timer.c      | 158 +++++++++++++++++++++
 .../Instructions-tests/Continue/continue.c         |  39 +++++
 .../Instructions-tests/Pause/pause.c               |  39 +++++
 .../Instructions-tests/Start/start.c               |  39 +++++
 .../Instructions-tests/Stop/stop.c                 |  39 +++++
 .../SelectedParameters-tests/Info/info.c           |  46 ++++++
 .../SelectedParameters-tests/Params/params.c       |  44 ++++++
 .../SelectedParameters-tests/Status/status.c       |  45 ++++++
 .../alsa-timer-ioctl-tests/Selecting-test/select.c |  34 +++++
 .../SpecifiedParameters-tests/Ginfo/ginfo.c        |  43 ++++++
 .../SpecifiedParameters-tests/Gparams/gparams.c    |  37 +++++
 .../SpecifiedParameters-tests/Gstatus/gstatus.c    |  36 +++++
 .../Version-id-tests/NextDevice/nextDevice.c       |  34 +++++
 .../Version-id-tests/Pversion/pversion.c           |  30 ++++
 16 files changed, 721 insertions(+)
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/EnhancedRead-test/Disable/disableEnhancedRead.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/EnhancedRead-test/Enable/enableEnhancedRead.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/GlobalTest/timer.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Continue/continue.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Pause/pause.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Start/start.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Stop/stop.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/SelectedParameters-tests/Info/info.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/SelectedParameters-tests/Params/params.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/SelectedParameters-tests/Status/status.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/Selecting-test/select.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/SpecifiedParameters-tests/Ginfo/ginfo.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/SpecifiedParameters-tests/Gparams/gparams.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/SpecifiedParameters-tests/Gstatus/gstatus.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/Version-id-tests/NextDevice/nextDevice.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/Version-id-tests/Pversion/pversion.c

diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/EnhancedRead-test/Disable/disableEnhancedRead.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/EnhancedRead-test/Disable/disableEnhancedRead.c
new file mode 100644
index 0000000..2f930b6
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/EnhancedRead-test/Disable/disableEnhancedRead.c
@@ -0,0 +1,29 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    int tread = 0;
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_TREAD, &tread) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Enhanced read disabled!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/EnhancedRead-test/Enable/enableEnhancedRead.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/EnhancedRead-test/Enable/enableEnhancedRead.c
new file mode 100644
index 0000000..fd9dea6
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/EnhancedRead-test/Enable/enableEnhancedRead.c
@@ -0,0 +1,29 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    int tread = 1;
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_TREAD, &tread) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Enhanced read enabled!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/GlobalTest/timer.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/GlobalTest/timer.c
new file mode 100644
index 0000000..b7cfcbd
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/GlobalTest/timer.c
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
+#define TEST_IOCTL(fd, command, argument, expected)                    \
+    do {                                                               \
+        if (ioctl(fd, command, argument) < 0 && errno != expected) {   \
+            printf("%s: %s\n", #command, strerror(errno));             \
+            return false;                                              \
+        }                                                              \
+        printf("%s: Test passed!\n", #command);                        \
+        return true;                                                   \
+    } while (0)                                                         \
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
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Continue/continue.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Continue/continue.c
new file mode 100644
index 0000000..09e256c
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Continue/continue.c
@@ -0,0 +1,39 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+
+    struct snd_timer_select select;
+    select.id = id;
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_SELECT, &select) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_CONTINUE) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    printf("Timer continued!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Pause/pause.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Pause/pause.c
new file mode 100644
index 0000000..fd57693
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Pause/pause.c
@@ -0,0 +1,39 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+
+    struct snd_timer_select select;
+    select.id = id;
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_SELECT, &select) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_PAUSE) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    printf("Timer paused!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Start/start.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Start/start.c
new file mode 100644
index 0000000..75ead93
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Start/start.c
@@ -0,0 +1,39 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+
+    struct snd_timer_select select;
+    select.id = id;
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_SELECT, &select) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_START) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    printf("Timer started!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Stop/stop.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Stop/stop.c
new file mode 100644
index 0000000..c28b0a3
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/Instructions-tests/Stop/stop.c
@@ -0,0 +1,39 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+
+    struct snd_timer_select select;
+    select.id = id;
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_SELECT, &select) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_STOP) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    printf("Timer stopped!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/SelectedParameters-tests/Info/info.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/SelectedParameters-tests/Info/info.c
new file mode 100644
index 0000000..7a8ff28
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/SelectedParameters-tests/Info/info.c
@@ -0,0 +1,46 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+
+    struct snd_timer_select select;
+    select.id = id;
+
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_SELECT, &select) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    struct snd_timer_info info = {0};
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_INFO, &info) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    printf("flags: %u\n", info.flags);
+    printf("card: %d\n", info.card);
+    printf("id: %s\n", info.id);
+    printf("name: %s\n", info.name);
+    printf("resolution: %lu\n", info.resolution);
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/SelectedParameters-tests/Params/params.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/SelectedParameters-tests/Params/params.c
new file mode 100644
index 0000000..c3953ca
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/SelectedParameters-tests/Params/params.c
@@ -0,0 +1,44 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+
+    struct snd_timer_select select;
+    select.id = id;
+
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_SELECT, &select) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    struct snd_timer_params params = {0};
+    params.ticks = 1;
+    params.filter = SNDRV_TIMER_EVENT_TICK;
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_PARAMS, &params) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    printf("Parameters set!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/SelectedParameters-tests/Status/status.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/SelectedParameters-tests/Status/status.c
new file mode 100644
index 0000000..b56f4a5
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/SelectedParameters-tests/Status/status.c
@@ -0,0 +1,45 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+
+    struct snd_timer_select select;
+    select.id = id;
+
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_SELECT, &select) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    struct snd_timer_status status = {0};
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_STATUS, &status) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    printf("resolution: %d\n", status.resolution);
+    printf("lost: %d\n", status.lost);
+    printf("overrun: %d\n", status.overrun);
+    printf("queue: %d\n", status.queue);
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/Selecting-test/select.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/Selecting-test/select.c
new file mode 100644
index 0000000..75425f4
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/Selecting-test/select.c
@@ -0,0 +1,34 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+
+    struct snd_timer_select select;
+    select.id = id;
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_SELECT, &select) == ERROR) {
+        perror("ioctl:");
+        return -1;
+    }
+
+    printf("Global timer selected!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/SpecifiedParameters-tests/Ginfo/ginfo.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/SpecifiedParameters-tests/Ginfo/ginfo.c
new file mode 100644
index 0000000..cd5d1da
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/SpecifiedParameters-tests/Ginfo/ginfo.c
@@ -0,0 +1,43 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+
+    struct snd_timer_ginfo ginfo;
+    ginfo.tid = id;
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_GINFO, &ginfo) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("flags: %u\n", ginfo.flags);
+    printf("card: %d\n", ginfo.card);
+    printf("id: %s\n", ginfo.id);
+    printf("name: %s\n", ginfo.name);
+    printf("reserved0: %lu\n", ginfo.reserved0);
+    printf("resolution: %lu\n", ginfo.resolution);
+    printf("resolution_min: %lu\n", ginfo.resolution_min);
+    printf("reolution_max: %lu\n", ginfo.resolution_max);
+    printf("clients: %u\n", ginfo.clients);
+    printf("reserved: %s\n", ginfo.reserved);
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/SpecifiedParameters-tests/Gparams/gparams.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/SpecifiedParameters-tests/Gparams/gparams.c
new file mode 100644
index 0000000..012a49d
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/SpecifiedParameters-tests/Gparams/gparams.c
@@ -0,0 +1,37 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+
+    struct snd_timer_ginfo ginfo;
+    ginfo.tid = id;
+
+    gparams.period_num = 2;
+    gparams.period_den = 2;
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_GPARAMS, &gparams) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Parameters set!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/SpecifiedParameters-tests/Gstatus/gstatus.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/SpecifiedParameters-tests/Gstatus/gstatus.c
new file mode 100644
index 0000000..81a74ca
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/SpecifiedParameters-tests/Gstatus/gstatus.c
@@ -0,0 +1,36 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
+                              SNDRV_TIMER_SCLASS_NONE, -1,
+                              SNDRV_TIMER_GLOBAL_SYSTEM, 0};
+
+    struct snd_timer_ginfo ginfo;
+    ginfo.tid = id;
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_GSTATUS, &gstatus) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("resolution: %lu\n", gstatus.resolution);
+    printf("resolution_num: %lu\n", gstatus.resolution_num);
+    printf("resolution_den: %lu\n", gstatus.resolution_den);
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/Version-id-tests/NextDevice/nextDevice.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/Version-id-tests/NextDevice/nextDevice.c
new file mode 100644
index 0000000..d3d1d3e
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/Version-id-tests/NextDevice/nextDevice.c
@@ -0,0 +1,34 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct snd_timer_id id = {1, 0, 0, 0, 0};
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_NEXT_DEVICE, &id) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Timer dev_class: %d\n", id.dev_class);
+    printf("Timer dev_sclass: %d\n", id.dev_class);
+    printf("Timer card: %d\n", id.dev_class);
+    printf("Timer device: %d\n", id.dev_class);
+    printf("Timer subdevice: %d\n", id.dev_class);
+
+    return 0;
+}
+
diff --git a/tests/tcg/multiarch/alsa-timer-ioctl-tests/Version-id-tests/Pversion/pversion.c b/tests/tcg/multiarch/alsa-timer-ioctl-tests/Version-id-tests/Pversion/pversion.c
new file mode 100644
index 0000000..259846e
--- /dev/null
+++ b/tests/tcg/multiarch/alsa-timer-ioctl-tests/Version-id-tests/Pversion/pversion.c
@@ -0,0 +1,30 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sound/asound.h>
+
+#define ERROR -1
+
+int main()
+{
+    int fd = open("/dev/snd/timer", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    int version = 0;
+
+    if (ioctl(fd, SNDRV_TIMER_IOCTL_PVERSION, &version) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Timer version: %d\n", version);
+
+    return 0;
+}
+
-- 
2.7.4


