Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3EAC33CB8
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23BE21D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23BE21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZeX-0005JV-EY
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1itZdG-000401-1Z
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1itZdC-0005Ly-Ed
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:10:29 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:43141 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1itZdB-0004bp-W8
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:10:26 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 214141A2120;
 Mon, 20 Jan 2020 17:09:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id F02131A20F0;
 Mon, 20 Jan 2020 17:09:19 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tests/tcg/multiarch: Add tests for implemented rtc ioctls
Date: Mon, 20 Jan 2020 17:09:13 +0100
Message-Id: <1579536554-30701-2-git-send-email-Filip.Bozuta@rt-rk.com>
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

Tests for individual ioctls are located in separate folders. These
folders are arranged by the same way these ioctls are implemented
in patches. These test files are simple programs that use these ioctls
to set/read or turn on/off some rtc features.

Besides tests for individual ioctls, a global rtc ioctl test was
added at "tests/tcg/multiarch/rtc-ioctl-tests/GlobalTest/rtc-test.c"
This test file was downloaded from linux kernel and is located at
"linux/drivers/rtc/rtc-test.c".
This file was modified a little bit so that it doesn't have styling
problems identified by "scripts/checkpatch.pl".
It is used to further test functionalities of some rtc ioctls by
running rtc clock at different frequencies.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 .../Alarm-time-test/ReadAlarm/getAlarm.c           |  33 +++
 .../Alarm-time-test/ReadTime/getTime.c             |  35 ++++
 .../Alarm-time-test/SetAlarm/setAlarm.c            |  31 +++
 .../Alarm-time-test/SetTime/setTime.c              |  33 +++
 .../AlarmInterrupt/Disable/disableAlarmInterrupt.c |  29 +++
 .../AlarmInterrupt/Enable/enableAlarmInterrupt.c   |  29 +++
 .../Disable/disablePeriodicInterrupt.c             |  30 +++
 .../Enable/enablePeriodicInterrupt.c               |  29 +++
 .../Disable/disableUpdateInterrupt.c               |  29 +++
 .../UpdateInterrupt/Enable/enableUpdateInterrupt.c |  29 +++
 .../Disable/disableWatchdogInterrupt.c             |  30 +++
 .../Enable/enableWatchdogInterrupt.c               |  31 +++
 .../rtc-ioctl-tests/GlobalTest/rtc-test.c          | 227 +++++++++++++++++++++
 .../ReadEpoch/getEpoch.c                           |  32 +++
 .../ReadPeriodicInterrupt/getPeriodicInterrupt.c   |  31 +++
 .../SetEpoch/setEpoch.c                            |  32 +++
 .../SetPeriodicInterrupt/setPeriodicInterrupt.c    |  31 +++
 .../ReadPllCorrection/getPllCorrection.c           |  35 ++++
 .../SetPllCorrection/setPllCorrection.c            |  32 +++
 .../ClearVoltageLow/clearVoltageLow.c              |  32 +++
 .../ReadVoltageLow/getVoltageLow.c                 |  32 +++
 .../ReadWakeupAlarm/getWakeupAlarm.c               |  36 ++++
 .../SetWakeupAlarm/setWakeupAlarm.c                |  34 +++
 23 files changed, 922 insertions(+)
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/ReadAlarm/getAlarm.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/ReadTime/getTime.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/SetAlarm/setAlarm.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/SetTime/setTime.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Features-test/AlarmInterrupt/Disable/disableAlarmInterrupt.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Features-test/AlarmInterrupt/Enable/enableAlarmInterrupt.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Features-test/PeriodicInterrupt/Disable/disablePeriodicInterrupt.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Features-test/PeriodicInterrupt/Enable/enablePeriodicInterrupt.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Features-test/UpdateInterrupt/Disable/disableUpdateInterrupt.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Features-test/UpdateInterrupt/Enable/enableUpdateInterrupt.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Features-test/WatchdogInterrupt/Disable/disableWatchdogInterrupt.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Features-test/WatchdogInterrupt/Enable/enableWatchdogInterrupt.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/GlobalTest/rtc-test.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/ReadEpoch/getEpoch.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/ReadPeriodicInterrupt/getPeriodicInterrupt.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/SetEpoch/setEpoch.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/SetPeriodicInterrupt/setPeriodicInterrupt.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Pll-correction-test/ReadPllCorrection/getPllCorrection.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Pll-correction-test/SetPllCorrection/setPllCorrection.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Voltage-low-test/ClearVoltageLow/clearVoltageLow.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Voltage-low-test/ReadVoltageLow/getVoltageLow.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Wakeup-alarm-test/ReadWakeupAlarm/getWakeupAlarm.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/Wakeup-alarm-test/SetWakeupAlarm/setWakeupAlarm.c

diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/ReadAlarm/getAlarm.c b/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/ReadAlarm/getAlarm.c
new file mode 100644
index 0000000..7cd0958
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/ReadAlarm/getAlarm.c
@@ -0,0 +1,33 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct rtc_time alarm_time;
+
+    if (ioctl(fd, RTC_ALM_READ, &alarm_time) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Alarm Second: %d, Alarm Minute: %d, Alarm Hour: %d\n",
+           alarm_time.tm_sec, alarm_time.tm_min, alarm_time.tm_hour);
+
+    return 0;
+}
+
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/ReadTime/getTime.c b/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/ReadTime/getTime.c
new file mode 100644
index 0000000..ffb48ad
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/ReadTime/getTime.c
@@ -0,0 +1,35 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct rtc_time cur_time;
+
+    if (ioctl(fd, RTC_RD_TIME, &cur_time) < 0) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Second: %d, Minute: %d, Hour: %d, Day: %d, Month: %d, Year: %d\n",
+           cur_time.tm_sec, cur_time.tm_min, cur_time.tm_hour,
+           cur_time.tm_mday, cur_time.tm_mon, cur_time.tm_year);
+
+    printf("Time set!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/SetAlarm/setAlarm.c b/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/SetAlarm/setAlarm.c
new file mode 100644
index 0000000..ad29e82
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/SetAlarm/setAlarm.c
@@ -0,0 +1,31 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDWR);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct rtc_time alarm_time = {13, 35, 12};
+
+    if (ioctl(fd, RTC_ALM_SET, &alarm_time) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Alarm set!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/SetTime/setTime.c b/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/SetTime/setTime.c
new file mode 100644
index 0000000..51f721d
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/SetTime/setTime.c
@@ -0,0 +1,33 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/capability.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct rtc_time time = {54, 34, 13, 26, 8, 120, 0, 0, 0};
+
+    if (ioctl(fd, RTC_SET_TIME, &time) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Time set!\n");
+
+    return 0;
+}
+
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/AlarmInterrupt/Disable/disableAlarmInterrupt.c b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/AlarmInterrupt/Disable/disableAlarmInterrupt.c
new file mode 100644
index 0000000..bc89802
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/AlarmInterrupt/Disable/disableAlarmInterrupt.c
@@ -0,0 +1,29 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    if (ioctl(fd, RTC_AIE_OFF) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Alarm interrupt disabled!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/AlarmInterrupt/Enable/enableAlarmInterrupt.c b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/AlarmInterrupt/Enable/enableAlarmInterrupt.c
new file mode 100644
index 0000000..451cfe7
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/AlarmInterrupt/Enable/enableAlarmInterrupt.c
@@ -0,0 +1,29 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    if (ioctl(fd, RTC_AIE_ON) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Alarm interrupt enabled!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/PeriodicInterrupt/Disable/disablePeriodicInterrupt.c b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/PeriodicInterrupt/Disable/disablePeriodicInterrupt.c
new file mode 100644
index 0000000..5439794
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/PeriodicInterrupt/Disable/disablePeriodicInterrupt.c
@@ -0,0 +1,30 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    if (ioctl(fd, RTC_PIE_OFF) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Periodic interrupt disabled!\n");
+
+    return 0;
+}
+
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/PeriodicInterrupt/Enable/enablePeriodicInterrupt.c b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/PeriodicInterrupt/Enable/enablePeriodicInterrupt.c
new file mode 100644
index 0000000..3d6b4e3
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/PeriodicInterrupt/Enable/enablePeriodicInterrupt.c
@@ -0,0 +1,29 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    if (ioctl(fd, RTC_PIE_ON) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Periodic interrupt enabled!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/UpdateInterrupt/Disable/disableUpdateInterrupt.c b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/UpdateInterrupt/Disable/disableUpdateInterrupt.c
new file mode 100644
index 0000000..deda97f
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/UpdateInterrupt/Disable/disableUpdateInterrupt.c
@@ -0,0 +1,29 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    if (ioctl(fd, RTC_UIE_OFF) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Update interrupt disabled!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/UpdateInterrupt/Enable/enableUpdateInterrupt.c b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/UpdateInterrupt/Enable/enableUpdateInterrupt.c
new file mode 100644
index 0000000..f10fdf3
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/UpdateInterrupt/Enable/enableUpdateInterrupt.c
@@ -0,0 +1,29 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    if (ioctl(fd, RTC_UIE_ON) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Update interrupt enabled!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/WatchdogInterrupt/Disable/disableWatchdogInterrupt.c b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/WatchdogInterrupt/Disable/disableWatchdogInterrupt.c
new file mode 100644
index 0000000..bdd4e60
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/WatchdogInterrupt/Disable/disableWatchdogInterrupt.c
@@ -0,0 +1,30 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <linux/ioctl.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDONLY);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    if (ioctl(fd, RTC_WIE_OFF) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Watchdog interrupt disabled!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/WatchdogInterrupt/Enable/enableWatchdogInterrupt.c b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/WatchdogInterrupt/Enable/enableWatchdogInterrupt.c
new file mode 100644
index 0000000..1aef0a6
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/WatchdogInterrupt/Enable/enableWatchdogInterrupt.c
@@ -0,0 +1,31 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <linux/ioctl.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDONLY);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    if (ioctl(fd, RTC_WIE_ON) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Watchdog interrupt enabled!\n");
+
+    return 0;
+}
+
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/GlobalTest/rtc-test.c b/tests/tcg/multiarch/rtc-ioctl-tests/GlobalTest/rtc-test.c
new file mode 100644
index 0000000..f4799c2
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/GlobalTest/rtc-test.c
@@ -0,0 +1,227 @@
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
+
+    int i, fd, retval, irqcount = 0;
+    unsigned long tmp, data;
+    struct rtc_time rtc_tm;
+
+    fd = open("/dev/rtc", O_RDONLY);
+
+    if (fd == -1) {
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
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/ReadEpoch/getEpoch.c b/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/ReadEpoch/getEpoch.c
new file mode 100644
index 0000000..09c18ef
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/ReadEpoch/getEpoch.c
@@ -0,0 +1,32 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <linux/ioctl.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDONLY);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    int epoch;
+
+    if (ioctl(fd, RTC_EPOCH_READ, &epoch) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Epoch: %d\n", epoch);
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/ReadPeriodicInterrupt/getPeriodicInterrupt.c b/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/ReadPeriodicInterrupt/getPeriodicInterrupt.c
new file mode 100644
index 0000000..4591783
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/ReadPeriodicInterrupt/getPeriodicInterrupt.c
@@ -0,0 +1,31 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    unsigned long interrupt_rate;
+
+    if (ioctl(fd, RTC_IRQP_READ, &interrupt_rate) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Interrupt rate: %d\n", interrupt_rate);
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/SetEpoch/setEpoch.c b/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/SetEpoch/setEpoch.c
new file mode 100644
index 0000000..a3567c6
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/SetEpoch/setEpoch.c
@@ -0,0 +1,32 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <linux/ioctl.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    int epoch = 5;
+
+    if (ioctl(fd, RTC_EPOCH_SET, epoch) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Epoch set!\n", epoch);
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/SetPeriodicInterrupt/setPeriodicInterrupt.c b/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/SetPeriodicInterrupt/setPeriodicInterrupt.c
new file mode 100644
index 0000000..a0c78fe
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/SetPeriodicInterrupt/setPeriodicInterrupt.c
@@ -0,0 +1,31 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    int interrupt_rate = 32;
+
+    if (ioctl(fd, RTC_IRQP_SET, interrupt_rate) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Periodic interrupt_rate %d is set!\n", interrupt_rate);
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Pll-correction-test/ReadPllCorrection/getPllCorrection.c b/tests/tcg/multiarch/rtc-ioctl-tests/Pll-correction-test/ReadPllCorrection/getPllCorrection.c
new file mode 100644
index 0000000..2104050
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Pll-correction-test/ReadPllCorrection/getPllCorrection.c
@@ -0,0 +1,35 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <linux/ioctl.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDONLY);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct rtc_pll_info info;
+
+    if (ioctl(fd, RTC_PLL_GET, &info) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Pll control: %d, Pll value: %d, Pll max: %d,
+            Pll min: %d, Pll posmult: %d, Pll negmult: %d,  Pll clock: %ld\n",
+            info.pll_ctrl, info.pll_value, info.pll_max, info.pll_min,
+            info.pll_posmult, info.pll_negmult, info.pll_clock);
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Pll-correction-test/SetPllCorrection/setPllCorrection.c b/tests/tcg/multiarch/rtc-ioctl-tests/Pll-correction-test/SetPllCorrection/setPllCorrection.c
new file mode 100644
index 0000000..176e895
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Pll-correction-test/SetPllCorrection/setPllCorrection.c
@@ -0,0 +1,32 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <linux/ioctl.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc0", O_RDONLY);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct rtc_pll_info info = {1, 1, 1, 1, 1, 1, 1};
+
+    if (ioctl(fd, RTC_PLL_SET, &info) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Pll correction set!\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Voltage-low-test/ClearVoltageLow/clearVoltageLow.c b/tests/tcg/multiarch/rtc-ioctl-tests/Voltage-low-test/ClearVoltageLow/clearVoltageLow.c
new file mode 100644
index 0000000..ba14fe4
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Voltage-low-test/ClearVoltageLow/clearVoltageLow.c
@@ -0,0 +1,32 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <linux/ioctl.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDONLY);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    int voltage;
+
+    if (ioctl(fd, RTC_VL_CLR) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Voltage low cleared");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Voltage-low-test/ReadVoltageLow/getVoltageLow.c b/tests/tcg/multiarch/rtc-ioctl-tests/Voltage-low-test/ReadVoltageLow/getVoltageLow.c
new file mode 100644
index 0000000..8d90329
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Voltage-low-test/ReadVoltageLow/getVoltageLow.c
@@ -0,0 +1,32 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <linux/ioctl.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/proc/driver/rtc", O_RDONLY);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    int voltage;
+
+    if (ioctl(fd, RTC_VL_READ, &voltage) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Voltage low: %d\n", voltage);
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Wakeup-alarm-test/ReadWakeupAlarm/getWakeupAlarm.c b/tests/tcg/multiarch/rtc-ioctl-tests/Wakeup-alarm-test/ReadWakeupAlarm/getWakeupAlarm.c
new file mode 100644
index 0000000..d81238f
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Wakeup-alarm-test/ReadWakeupAlarm/getWakeupAlarm.c
@@ -0,0 +1,36 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct rtc_wkalrm alarm;
+
+    if (ioctl(fd, RTC_WKALM_RD, &alarm) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Alarm enabled: %d, Alarm pending: %d, Alarm second %d,
+            Alarm minute: %d, Alarm hour: %d, Alarm day: %d,
+            Alarm month: %d\n",
+            alarm.enabled, alarm.pending, alarm.time.tm_sec, alarm.time.tm_min,
+            alarm.time.tm_hour, alarm.time.tm_mday, alarm.time.tm_mon,
+            alarm.time.tm_year);
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/rtc-ioctl-tests/Wakeup-alarm-test/SetWakeupAlarm/setWakeupAlarm.c b/tests/tcg/multiarch/rtc-ioctl-tests/Wakeup-alarm-test/SetWakeupAlarm/setWakeupAlarm.c
new file mode 100644
index 0000000..db0552a
--- /dev/null
+++ b/tests/tcg/multiarch/rtc-ioctl-tests/Wakeup-alarm-test/SetWakeupAlarm/setWakeupAlarm.c
@@ -0,0 +1,34 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <fcntl.h>
+#include <linux/input.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define ERROR -1
+
+int main()
+{
+
+    int fd = open("/dev/rtc", O_RDONLY);
+
+    if (fd == ERROR) {
+        perror("open");
+        return -1;
+    }
+
+    struct rtc_time time = {25, 30, 10, 27, 8, 12, 0, 0, 0};
+
+    struct rtc_wkalrm alarm = {0, 0, time};
+
+    if (ioctl(fd, RTC_WKALM_SET, &alarm) == ERROR) {
+        perror("ioctl");
+        return -1;
+    }
+
+    printf("Wakeup alarm set!\n");
+
+    return 0;
+}
+
-- 
2.7.4


