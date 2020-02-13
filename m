Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92527C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BB720873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BB720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FSf-00013X-IA
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1j2FRc-00083y-Kc
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1j2FRZ-0007Ur-0s
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:26:19 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:47109 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1j2FRX-00058Q-Un
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:26:16 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 0388C1A20E0;
 Thu, 13 Feb 2020 15:25:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id A51D01A2084;
 Thu, 13 Feb 2020 15:25:10 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] tests/tcg/multiarch: Add tests for implemented rtc
 ioctls
Date: Thu, 13 Feb 2020 15:25:04 +0100
Message-Id: <1581603905-21565-2-git-send-email-Filip.Bozuta@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581603905-21565-1-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1581603905-21565-1-git-send-email-Filip.Bozuta@rt-rk.com>
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

This patch adds tests for following 22 implemented rtc ioctls:

* RTC_AIE_ON     * RTC_ALM_SET      * RTC_WKALM_SET
* RTC_AIE_OFF    * RTC_ALM_READ     * RTC_WKALM_RD
* RTC_UIE_ON     * RTC_RD_TIME      * RTC_PLL_GET
* RTC_UIE_OFF    * RTC_SET_TIME     * RTC_PLL_SET
* RTC_PIE_ON     * RTC_IRQP_READ    * RTC_VL_READ
* RTC_PIE_OFF    * RTC_IRQP_SET     * RTC_VL_CLR
* RTC_WIE_ON     * RTC_EPOCH_READ
* RTC_WIE_OFF    * RTC_EPOCH_SET

Names and descriptions of these ioctls can be found in patches that
implement them.

Test folder for these ioctl tests is located at
"tests/tcg/multiarch/rtc-ioctl-tests/"

There are two folders located in the test folder, one for test that was written
manually ("/manual-test") and one the test that was obtained remotely ("/remote-test").

Manual test:

    This test was written manually to test all the implemented rtc ioctls and
    was added at "/manual-test/rtc-ioctl-manual-test.c". A separate test function
    was written for each ioctl. Each of these functions uses a global test macro
    'TEST_RTC_IOCTL' to run these tests. The file can be run to test all ioctls
    or it can test only the specified ioctls. This depends on the commands
    specified when running the test.

    For Example (assuming 'rtc-ioctl-manual-test' is the compiled .exe file):

      running './rtc-ioctl-manual-test RTC_AIE_ON' tests only the ioctl RTC_AIE_ON
      running './rtc-ioctl-manual-test  RTC_AIE_ON RTC_SET_TIME RTC_ALM_READ' tests
      ioctls RTC_AIE_ON, RTC_SET_TIME, RTC_ALM_READ

    If no ioctl is specified when running the test file, all the ioctls
    are tested:

      running './rtc-ioctl-test' tests all ioctls

Remote test:

    Besides the manual test, a remote rtc ioctl test was added at
    "/remote-test/rtc-test.c". The test file "rtc-test.c" was downloaded
    from linux kernel and is located at "linux/drivers/rtc/rtc-test.c".
    This file was modified a little bit so that it doesn't have styling
    problems identified by "scripts/checkpatch.pl". It is used to further
    test functionalities of some rtc ioctls by running rtc clock at different
    frequencies.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 .../manual-test/rtc-ioctl-manual-test.c            | 352 +++++++++++++++++++++
 .../rtc-ioctl-tests/remote-test/rtc-test.c         | 226 +++++++++++++
 2 files changed, 578 insertions(+)
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/manual-test/rtc-ioctl-manual-test.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/remote-test/rtc-test.c

diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/manual-test/rtc-ioctl-manual-test.c b/tests/tcg/multiarch/rtc-ioctl-tests/manual-test/rtc-ioctl-manual-test.c
new file mode 100644
index 0000000..f073442
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/manual-test/rtc-ioctl-manual-test.c
@@ -0,0 +1,352 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <string.h>
+
+#define ERROR -1
+
+#define TEST_RTC_IOCTL(fd, command, argument, supported)      \
+    do {                                                      \
+        printf("%s:\n", #command);                            \
+        if (ioctl(fd, command, argument) == ERROR) {          \
+            perror("ioctl");                                  \
+            printf("\n");                                     \
+            supported = false;                                \
+        }                                                     \
+    } while (0)
+
+static bool test_aie_on(int fd, bool supported)
+{
+    TEST_RTC_IOCTL(fd, RTC_AIE_ON, NULL, supported);
+    if (supported) {
+        printf("Alarm interrupt enabled!\n\n");
+    }
+    return supported;
+}
+
+static bool test_aie_off(int fd, bool supported)
+{
+    TEST_RTC_IOCTL(fd, RTC_AIE_OFF, NULL, supported);
+    if (supported) {
+        printf("Alarm interrupt disabled!\n\n");
+    }
+    return supported;
+}
+
+static bool test_pie_on(int fd, bool supported)
+{
+    TEST_RTC_IOCTL(fd, RTC_PIE_ON, NULL, supported);
+    if (supported) {
+        printf("Periodic interrupt enabled!\n\n");
+    }
+    return supported;
+}
+
+static bool test_pie_off(int fd, bool supported)
+{
+    TEST_RTC_IOCTL(fd, RTC_PIE_OFF, NULL, supported);
+    if (supported) {
+        printf("Periodic interrupt disabled!\n\n");
+    }
+    return supported;
+}
+
+static bool test_uie_on(int fd, bool supported)
+{
+    TEST_RTC_IOCTL(fd, RTC_UIE_ON, NULL, supported);
+    if (supported) {
+        printf("Update interrupt enabled!\n\n");
+    }
+    return supported;
+}
+
+static bool test_uie_off(int fd, bool supported)
+{
+    TEST_RTC_IOCTL(fd, RTC_UIE_OFF, NULL, supported);
+    if (supported) {
+        printf("Update interrupt disabled!\n\n");
+    }
+    return supported;
+}
+
+static bool test_wie_on(int fd, bool supported)
+{
+    TEST_RTC_IOCTL(fd, RTC_WIE_ON, NULL, supported);
+    if (supported) {
+        printf("Watchdog interrupt enabled!\n\n");
+    }
+    return supported;
+}
+
+static bool test_wie_off(int fd, bool supported)
+{
+    TEST_RTC_IOCTL(fd, RTC_WIE_OFF, NULL, supported);
+    if (supported) {
+        printf("Watchdog interrupt disabled!\n\n");
+    }
+    return supported;
+}
+
+static bool test_set_time(int fd, bool supported)
+{
+    struct rtc_time alarm_time = {54, 34, 13, 26, 8, 120, 0, 0, 0};
+
+    TEST_RTC_IOCTL(fd, RTC_SET_TIME, &alarm_time, supported);
+    if (supported) {
+        printf("Time set:\n");
+        printf("Second: %d, Minute: %d, Hour: %d, "
+               "Day: %d, Month: %d, Year: %d\n\n",
+               alarm_time.tm_sec, alarm_time.tm_min, alarm_time.tm_hour,
+               alarm_time.tm_mday, alarm_time.tm_mon, alarm_time.tm_year);
+    }
+    return supported;
+}
+
+static bool test_rd_time(int fd, bool supported)
+{
+    struct rtc_time alarm_time;
+
+    TEST_RTC_IOCTL(fd, RTC_RD_TIME, &alarm_time, supported);
+    if (supported) {
+        printf("Time read:\n");
+        printf("Second: %d, Minute: %d, Hour: %d, "
+               "Day: %d, Month: %d, Year: %d\n\n",
+               alarm_time.tm_sec, alarm_time.tm_min, alarm_time.tm_hour,
+               alarm_time.tm_mday, alarm_time.tm_mon, alarm_time.tm_year);
+    }
+    return supported;
+}
+
+static bool test_alm_set(int fd, bool supported)
+{
+    struct rtc_time alarm_time = {13, 35, 12};
+
+    TEST_RTC_IOCTL(fd, RTC_ALM_SET, &alarm_time, supported);
+    if (supported) {
+        printf("Alarm time set:\n");
+        printf("Second: %d, Minute: %d, Hour: %d\n\n",
+               alarm_time.tm_sec, alarm_time.tm_min, alarm_time.tm_hour);
+    }
+    return supported;
+}
+
+static bool test_alm_read(int fd, bool supported)
+{
+    struct rtc_time alarm_time;
+
+    TEST_RTC_IOCTL(fd, RTC_ALM_READ, &alarm_time, supported);
+    if (supported) {
+        printf("Alarm time read:\n");
+        printf("Second: %d, Minute: %d, Hour: %d\n\n",
+               alarm_time.tm_sec, alarm_time.tm_min, alarm_time.tm_hour);
+    }
+    return supported;
+}
+
+static bool test_irqp_set(int fd, bool supported)
+{
+    unsigned long interrupt_rate = 32;
+
+    TEST_RTC_IOCTL(fd, RTC_IRQP_SET, interrupt_rate, supported);
+    if (supported) {
+        printf("Periodic interrupt set: %lu\n\n", interrupt_rate);
+    }
+    return supported;
+}
+
+static bool test_irqp_read(int fd, bool supported)
+{
+    unsigned long interrupt_rate;
+
+    TEST_RTC_IOCTL(fd, RTC_IRQP_READ, &interrupt_rate, supported);
+    if (supported) {
+        printf("Periodic interrupt read: %lu\n\n", interrupt_rate);
+    }
+    return supported;
+}
+
+static bool test_epoch_set(int fd, bool supported)
+{
+    unsigned long epoch = 5;
+
+    TEST_RTC_IOCTL(fd, RTC_EPOCH_SET, epoch, supported);
+    if (supported) {
+        printf("Epoch set: %lu\n\n", epoch);
+    }
+    return supported;
+}
+
+static bool test_epoch_read(int fd, bool supported)
+{
+    unsigned long epoch;
+
+    TEST_RTC_IOCTL(fd, RTC_EPOCH_READ, epoch, supported);
+    if (supported) {
+        printf("Epoch read: %lu\n\n", epoch);
+    }
+    return supported;
+}
+
+static bool test_wkalm_set(int fd, bool supported)
+{
+    struct rtc_time time = {25, 30, 10, 27, 8, 12, 0, 0, 0};
+    struct rtc_wkalrm alarm = {0, 0, time};
+
+    TEST_RTC_IOCTL(fd, RTC_WKALM_SET, &alarm, supported);
+    if (supported) {
+        printf("Wakeup alarm set:\n");
+        printf("Enabled: %d, Pending: %d\n", alarm.enabled, alarm.pending);
+        printf("Second: %d, Minute: %d, Hour: %d\n\n",
+               alarm.time.tm_sec, alarm.time.tm_min, alarm.time.tm_hour);
+    }
+    return supported;
+}
+
+static bool test_wkalm_rd(int fd, bool supported)
+{
+    struct rtc_wkalrm alarm;
+
+    TEST_RTC_IOCTL(fd, RTC_WKALM_RD, &alarm, supported);
+    if (supported) {
+        printf("Wakeup alarm read:\n");
+        printf("Enabled: %d, Pending: %d\n", alarm.enabled, alarm.pending);
+        printf("Second: %d, Minute: %d, Hour: %d\n\n",
+               alarm.time.tm_sec, alarm.time.tm_min, alarm.time.tm_hour);
+    }
+    return supported;
+}
+
+static bool test_pll_set(int fd, bool supported)
+{
+    struct rtc_pll_info info = {1, 5, 50, 10, 20, 10, 15};
+
+    TEST_RTC_IOCTL(fd, RTC_PLL_SET, &info, supported);
+    if (supported) {
+        printf("Pll correction set:\n");
+        printf("Pll ctrl: %d, Pll value: %d, Pll max %d, "
+               "Pll min: %d, Pll posmult: %d, Pll negmult: %d, "
+               "Pll clock: %lu\n\n",
+               info.pll_ctrl, info.pll_value, info.pll_max,
+               info.pll_min, info.pll_posmult, info.pll_negmult,
+               info.pll_clock);
+    }
+    return supported;
+}
+
+static bool test_pll_get(int fd, bool supported)
+{
+    struct rtc_pll_info info;
+
+    TEST_RTC_IOCTL(fd, RTC_PLL_GET, &info, supported);
+    if (supported) {
+        printf("Pll correction read:\n");
+        printf("Pll ctrl: %d, Pll value: %d, Pll max %d, "
+               "Pll min: %d, Pll posmult: %d, Pll negmult: %d, "
+               "Pll clock: %lu\n\n",
+               info.pll_ctrl, info.pll_value, info.pll_max,
+               info.pll_min, info.pll_posmult, info.pll_negmult,
+               info.pll_clock);
+    }
+    return supported;
+}
+
+static bool test_vl_read(int fd, bool supported)
+{
+    int voltage_low;
+
+    TEST_RTC_IOCTL(fd, RTC_VL_READ, &voltage_low, supported);
+    if (supported) {
+        printf("Voltage low: %d\n\n", voltage_low);
+    }
+    return supported;
+}
+
+static bool test_vl_clear(int fd, bool supported)
+{
+    TEST_RTC_IOCTL(fd, RTC_VL_CLR, NULL, supported);
+    if (supported) {
+        printf("Voltage low cleared!\n");
+    }
+    return supported;
+}
+
+int main(int argc, char **argv)
+{
+    char ioctls[23][15] = {"RTC_AIE_ON", "RTC_AIE_OFF",
+                           "RTC_UIE_ON", "RTC_UIE_OFF",
+                           "RTC_PIE_ON", "RTC_PIE_OFF",
+                           "RTC_WIE_ON", "RTC_WIE_OFF",
+                           "RTC_ALM_SET", "RTC_ALM_READ",
+                           "RTC_RD_TIME", "RTC_SET_TIME",
+                           "RTC_IRQP_READ", "RTC_IRQP_SET",
+                           "RTC_EPOCH_READ", "RTC_EPOCH_SET",
+                           "RTC_WKALM_SET", "RTC_WKALM_RD",
+                           "RTC_PLL_GET", "RTC_PLL_SET",
+                           "RTC_VL_READ", "RTC_VL_CLR"};
+
+    bool (*const funcs[]) (int, bool) = {
+          test_aie_on,
+          test_aie_off,
+          test_uie_on,
+          test_uie_off,
+          test_pie_on,
+          test_pie_off,
+          test_wie_on,
+          test_wie_off,
+          test_alm_set,
+          test_alm_read,
+          test_rd_time,
+          test_set_time,
+          test_irqp_read,
+          test_irqp_set,
+          test_epoch_read,
+          test_epoch_set,
+          test_wkalm_set,
+          test_wkalm_rd,
+          test_pll_get,
+          test_pll_set,
+          test_vl_read,
+          test_vl_clear,
+          NULL
+    };
+
+    int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
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
+            for (int j = 0; j < 22; j++) {
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
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/remote-test/rtc-test.c b/tests/tcg/multiarch/rtc-ioctl-tests/remote-test/rtc-test.c
new file mode 100644
index 0000000..a56c3c7
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/remote-test/rtc-test.c
@@ -0,0 +1,226 @@
+/*
+ *  Real Time Clock Driver Test/Example Program
+ *
+ *  Compile with:
+ *      gcc -s -Wall -Wstrict-prototypes rtctest.c -o rtctest
+ *
+ *  Copyright (C) 1996, Paul Gortmaker.
+ *
+ *  Released under the GNU General Public License, version 2,
+ *  included herein by reference.
+ *
+ */
+
+#include <stdio.h>
+#include <linux/rtc.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+
+int main(void)
+{
+    int i, fd, retval, irqcount = 0;
+    unsigned long tmp, data;
+    struct rtc_time rtc_tm;
+
+    fd = open("/dev/rtc", O_RDONLY);
+
+    if (fd ==  -1) {
+        perror("/dev/rtc");
+        exit(errno);
+    }
+
+    fprintf(stderr, "\n\t\t\tRTC Driver Test Example.\n\n");
+
+    /* Turn on update interrupts (one per second) */
+    retval = ioctl(fd, RTC_UIE_ON, 0);
+    if (retval == -1) {
+        perror("ioctl");
+        exit(errno);
+    }
+
+    fprintf(stderr,
+            "Counting 5 update (1/sec) interrupts from reading /dev/rtc:");
+    fflush(stderr);
+
+    for (i = 1; i < 6; i++) {
+        /* This read will block */
+        retval = read(fd, &data, sizeof(unsigned long));
+
+        if (retval == -1) {
+            perror("read");
+            exit(errno);
+        }
+
+        fprintf(stderr, " %d", i);
+        fflush(stderr);
+        irqcount++;
+    }
+
+    fprintf(stderr, "\nAgain, from using select(2) on /dev/rtc:");
+    fflush(stderr);
+
+    for (i = 1; i < 6; i++) {
+        struct timeval tv = {5, 0};    /* 5 second timeout on select */
+        fd_set readfds;
+
+        FD_ZERO(&readfds);
+        FD_SET(fd, &readfds);
+
+        /* The select will wait until an RTC interrupt happens. */
+        retval = select(fd + 1, &readfds, NULL, NULL, &tv);
+        if (retval == -1) {
+            perror("select");
+            exit(errno);
+        }
+
+        /* This read won't block unlike the select-less case above. */
+        retval = read(fd, &data, sizeof(unsigned long));
+        if (retval == -1) {
+            perror("read");
+            exit(errno);
+        }
+
+        fprintf(stderr, " %d", i);
+        fflush(stderr);
+        irqcount++;
+    }
+
+    /* Turn off update interrupts */
+    retval = ioctl(fd, RTC_UIE_OFF, 0);
+    if (retval == -1) {
+        perror("ioctl");
+        exit(errno);
+    }
+
+    /* Read the RTC time/date */
+    retval = ioctl(fd, RTC_RD_TIME, &rtc_tm);
+    if (retval == -1) {
+        perror("ioctl");
+        exit(errno);
+    }
+
+    fprintf(stderr, "\n\nCurrent RTC date/time is %d-%d-%d, %02d:%02d:%02d.\n",
+            rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rtc_tm.tm_year + 1900,
+            rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
+
+    /* Set the alarm to 5 sec in the future, and check for rollover */
+    rtc_tm.tm_sec += 5;
+    if (rtc_tm.tm_sec >= 60) {
+        rtc_tm.tm_sec %= 60;
+        rtc_tm.tm_min++;
+    }
+
+    if (rtc_tm.tm_min == 60) {
+        rtc_tm.tm_min = 0;
+        rtc_tm.tm_hour++;
+    }
+
+    if (rtc_tm.tm_hour == 24) {
+        rtc_tm.tm_hour = 0;
+    }
+
+    retval = ioctl(fd, RTC_ALM_SET, &rtc_tm);
+    if (retval == -1) {
+        perror("ioctl");
+        exit(errno);
+    }
+
+    /* Read the current alarm settings */
+    retval = ioctl(fd, RTC_ALM_READ, &rtc_tm);
+    if (retval == -1) {
+        perror("ioctl");
+        exit(errno);
+    }
+
+    fprintf(stderr, "Alarm time now set to %02d:%02d:%02d.\n",
+            rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
+
+    /* Enable alarm interrupts */
+    retval = ioctl(fd, RTC_AIE_ON, 0);
+    if (retval == -1) {
+        perror("ioctl");
+        exit(errno);
+    }
+
+    fprintf(stderr, "Waiting 5 seconds for alarm...");
+    fflush(stderr);
+    /* This blocks until the alarm ring causes an interrupt */
+    retval = read(fd, &data, sizeof(unsigned long));
+    if (retval == -1) {
+        perror("read");
+        exit(errno);
+    }
+
+    irqcount++;
+    fprintf(stderr, " okay. Alarm rang.\n");
+
+    /* Disable alarm interrupts */
+    retval = ioctl(fd, RTC_AIE_OFF, 0);
+    if (retval == -1) {
+        perror("ioctl");
+        exit(errno);
+    }
+
+    /* Read periodic IRQ rate */
+    retval = ioctl(fd, RTC_IRQP_READ, &tmp);
+    if (retval == -1) {
+        perror("ioctl");
+        exit(errno);
+    }
+
+    fprintf(stderr, "\nPeriodic IRQ rate was %ldHz.\n", tmp);
+
+    fprintf(stderr, "Counting 20 interrupts at:");
+    fflush(stderr);
+
+    /* The frequencies 128Hz, 256Hz, ... 8192Hz are only allowed for root. */
+    for (tmp = 2; tmp <= 64; tmp *= 2) {
+
+        retval = ioctl(fd, RTC_IRQP_SET, tmp);
+        if (retval == -1) {
+            perror("ioctl");
+            exit(errno);
+        }
+
+        fprintf(stderr, "\n%ldHz:\t", tmp);
+        fflush(stderr);
+
+        /* Enable periodic interrupts */
+        retval = ioctl(fd, RTC_PIE_ON, 0);
+        if (retval == -1) {
+            perror("ioctl");
+            exit(errno);
+        }
+
+        for (i = 1; i < 21; i++) {
+            /* This blocks */
+            retval = read(fd, &data, sizeof(unsigned long));
+            if (retval == -1) {
+                perror("read");
+                exit(errno);
+            }
+            fprintf(stderr, " %d", i);
+            fflush(stderr);
+            irqcount++;
+        }
+
+        /* Disable periodic interrupts */
+        retval = ioctl(fd, RTC_PIE_OFF, 0);
+        if (retval == -1) {
+            perror("ioctl");
+            exit(errno);
+        }
+    }
+
+    fprintf(stderr, "\n\n\t\t\t *** Test complete ***\n");
+    fprintf(stderr, "\nTyping \"cat /proc/interrupts\" will show %d
+            more events on IRQ 8.\n\n", irqcount);
+
+    close(fd);
+    return 0;
+
+} /* end main */
-- 
2.7.4


