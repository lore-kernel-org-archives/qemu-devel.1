Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5B0C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 01:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497452071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 01:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FybnPBkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497452071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunNN-0007ia-Ff
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 20:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunD6-0002xM-Iu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunD5-0005yO-5F
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:32 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunD4-0005wd-UB; Thu, 23 Jan 2020 19:52:31 -0500
Received: by mail-wr1-x443.google.com with SMTP id y11so70648wrt.6;
 Thu, 23 Jan 2020 16:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tNwLpgaqJBykaTc5oOgXwXD6VBqNzz53tLLzaYeMYrA=;
 b=FybnPBkZS4YiM9UW0Pu9Qnrot/G1o/Xt6rv4EaBlnJP1cOlNjc+4FBRXTlyJf3Nctb
 dMQg7+nBVoCikLZ8n/05reExMyJHi+mS9waPBVxlBK4oAuFQ8vSQr7XTJNoDg9GE7XLO
 Fz3cup7aHnP+s8JlJ8pvGr3Cwi01UXTHA9oRJmMtu4Z0E2l3GnuDSDnCdK5TZRKvNnba
 sXTnEZ2B2mwVSi2K/2OsSNEgOBSMNeQ2F4PxMF6ATcdUdIUZt+gH3GL8V4Gctzutqvu9
 UuJiERNALGWXEAV0+rlrIopC2d0mGVuutBZitZ81FH7JjdFB149AyI8tfRDFbYBj8xhR
 0kUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tNwLpgaqJBykaTc5oOgXwXD6VBqNzz53tLLzaYeMYrA=;
 b=cmvCmpOHDUetprHSlRDLADsGWyPsfy2Pl/AsdGejNRMLCCxfr/6lQ5bJdthHaIvDAE
 LbkWYtkQ0gplHk8YSfMWbROtVxyLlZvUAp7uUNxJD4FUjUZKvmaZ+fuesBlVV9jytD5Q
 VCOBZ2YAFe3BNGd8gXulgezj8hVo0hZnnVS3eDwOWbN3gy5RIbkjqmLleWxGDMZ2yB+n
 P5BXWnTHmDEuOoZrqXfFwCdYPBThoBctYDhEhKkXXi6kJrUoMJIBqA1/fyKd2WNAY9L4
 Uk8UZAxUcA52m6aClSFuWaBnpZO9+YT0mJpJi/+1cTDDjKW4cJmjzNScWb6rBljrmi+m
 m9jg==
X-Gm-Message-State: APjAAAWeA7vp9Smw+nWBLI8EUkGEP1uSUOCrqj3sinI/jrhndbyAPk21
 z79rBzC17oAG4H/zJKBsvTnBxToM
X-Google-Smtp-Source: APXvYqyiWv0s1z8P4meCYE70SBEbnxzN04SU+FY3ZuVcgCqTHvX6kmnjiV+fJLaYXt38hQ+9GKquWQ==
X-Received: by 2002:adf:b648:: with SMTP id i8mr831531wre.91.1579827149744;
 Thu, 23 Jan 2020 16:52:29 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:52:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 24/25] tests/acceptance: Test the Arduino MEGA2560 board
Date: Fri, 24 Jan 2020 01:51:30 +0100
Message-Id: <20200124005131.16276-25-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

The test is based on
https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos/Demo
demo which. If working correctly, prints 'ABCDEFGHIJKLMNOPQRSTUVWX' out.
it also demostrates that timer and IRQ are working

As the path name demonstrates, the FreeRTOS tests target a
board based on a ATMega2560 MCU. We have one, the Arduino
MEGA2560.

Complementary documentation:

https://feilipu.me/2012/01/15/ethermega-arduino-mega-2560-and-freertos/
https://feilipu.me/2015/11/24/arduino_freertos/ (see 'Compatibility')

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200118191416.19934-21-mrolnik@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[rth: Squash multiple avocado fixups from f4bug]
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/acceptance/machine_avr6.py | 50 ++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 tests/acceptance/machine_avr6.py

diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
new file mode 100644
index 0000000000..b644d2a81c
--- /dev/null
+++ b/tests/acceptance/machine_avr6.py
@@ -0,0 +1,50 @@
+#
+# QEMU AVR
+#
+# Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com>
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import time
+
+from avocado_qemu import Test
+
+class AVR6Machine(Test):
+    timeout = 5
+
+    def test_freertos(self):
+        """
+        :avocado: tags=arch:avr
+        :avocado: tags=machine:arduino-mega-2560-v3
+        """
+        """
+        https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
+        constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
+        """
+        rom_url = ('https://github.com/seharris/qemu-avr-tests'
+                   '/raw/36c3e67b8755dcf/free-rtos/Demo'
+                   '/AVR_ATMega2560_GCC/demo.elf')
+        rom_hash = '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
+        rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
+
+        self.vm.add_args('-bios', rom_path)
+        self.vm.add_args('-nographic')
+        self.vm.launch()
+
+        time.sleep(2)
+        self.vm.shutdown()
+
+        self.assertIn('ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX',
+                self.vm.get_log())
-- 
2.21.1


