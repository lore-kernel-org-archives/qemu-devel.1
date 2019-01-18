Received: from eggs.gnu.org ([209.51.188.92]:48316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkZHM-0002Ws-99
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkZHL-0005Ej-Jg
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:54:08 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkZHK-0005BZ-Bq
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:54:07 -0500
Received: by mail-wr1-x441.google.com with SMTP id x10so16273867wrs.8
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 10:54:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 18:54:02 +0000
Message-Id: <20190118185402.3065-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tests: Disable ipmi-bt-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>

The ipmi-bt-test fails intermittently, especially on the NetBSD VM.
The frequency of this failure has recently gone up sharply to the
point that I'm having to retry the NetBSD build multiple times
to get a pass when merging pull requests.

Disable the test until we can figure out why it's failing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Fed up with this failing all the time so let's just turn it off.
Feel free to investigate what's actually going wrong with it...

 tests/Makefile.include | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index eaa81ee1d07..5e6b2c7058d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -186,7 +186,8 @@ check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
 check-qtest-i386-y += tests/rtc-test$(EXESUF)
 check-qtest-i386-y += tests/ipmi-kcs-test$(EXESUF)
-check-qtest-i386-y += tests/ipmi-bt-test$(EXESUF)
+# Disabled temporarily as it fails intermittently especially under NetBSD VM
+# check-qtest-i386-y += tests/ipmi-bt-test$(EXESUF)
 check-qtest-i386-y += tests/i440fx-test$(EXESUF)
 check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
 check-qtest-i386-y += tests/drive_del-test$(EXESUF)
-- 
2.20.1
