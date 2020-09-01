Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586E0C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28FED206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FED206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7AV-0004Hs-7V
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zO-0005bm-Jy; Tue, 01 Sep 2020 10:10:22 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zJ-0003q1-D6; Tue, 01 Sep 2020 10:10:22 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MO9qz-1jxuYe0rxx-00Oajk; Tue, 01 Sep 2020 16:10:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 24/44] docs/system/target-avr: Improve the AVR docs and add to
 MAINTAINERS
Date: Tue,  1 Sep 2020 16:09:34 +0200
Message-Id: <20200901140954.889743-25-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZE42EJ6lYk1XVAUwqnV+LgGkzDrF5g9Ly3o1vyWJimPTCjldwak
 iJHMQZrCkahow97Y6AyWM+yiRPLBlYDynHsFP/w6/VPH1brAdXBU+I0luWw2Qo+61V63VE/
 MTpDNbc11aydduTmcmZZiHfEdf1uLltgX+n2xH47ju7q8S2FjLnP553wlZW2g0KSKl7L1Lq
 v3nAsVgSTR/RNh3+EfGqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Jck6vwPhoE=:aV8pTtyIC3Fjp9TYUWZ8up
 Whet0dcX+K+smqDbdey9NOSvOvNy3XFBiTjrhNhcAetJ2KVYkQZkgagjnYRphEK3J8MYo6gmu
 ZpLd3xLyAfg+rqpaBVRoz1lxLaFuJFpeUycp/czE4emRwQqgvOI2c/SuxdkAI3j48APZA50aS
 DlIE8VLVA7RZilP3W6PYeQh6wu7KNCOLMRCuKvXhQY617oiHk9wkmcD+qDF3j6dXBHWAso9Ef
 44TA3xgIIOfmui9yaiwlMwM2vDwz5LZzmhwfUqpryjsDO/aUnOqZRix/Nm7W2EJ1bbHCloMDm
 V+VA7jj/tLEos56UkIaeYnlJWXIBYKCXhfrOR3fMUUsIIzP2BztHA7/D94RkDdZAhdqrokxjW
 zVpT5eZynuRTRuXo7DnkBhkJPdmKhhBeF16Ln83ekbn5G34Q6fCyNjWlf6kNKpTJx5akUofED
 I5sP7BEQNlLGuRlox+FoN96pN75YlUco6wMvKC3OLbmHegqKIVPPAWgmZgg3EOQYJo5iwxSj/
 So+R0pW9ZRR1g70zYWx9saP2v2TnhgnGhITXnmiaWgFJ7G/dCBnpKNEOw0aF/h/9oboYezcJK
 Hpziw9NabLWCTw1e7YggoTZK1O4xScshuLulabfgQlyVF3AIgC34wJpPvC4qm+y6EOvP38+Ji
 yzh3W9RyuaQn5Ux9Gb/doU4ZJ47Q4Vb/GmCElMcXEh38g80fQOzdyqEnnCm5g9yr4L+czLoa3
 attttfAYF/cnvFIfxIiq1vBFbW0P/9rgQ0i5q4BwK5iXgdJkZUEUNHr2PLi0XPyU6FjzQ3/PL
 x02rEhbqb9Q/s7r9x8z3DbCkjoO/4ycJskAsYmTT8KAxuTC0NPHC+qVHwX3ibqJyHvOl8yQ
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:09:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <huth@tuxfamily.org>

The examples look nicer when using "::" code blocks.
Also mention that "-d in_asm" only outputs instructions that have not
been translated by the JIT layer yet.
And while we're at it, also add the AVR doc file to the MAINTAINERS file.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Rolnik <mrolnik@gmail.com>
Message-Id: <20200812155304.18016-1-huth@tuxfamily.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS                |  1 +
 docs/system/target-avr.rst | 47 +++++++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a22c8be4296..b5ba553ee01a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -171,6 +171,7 @@ AVR TCG CPUs
 M: Michael Rolnik <mrolnik@gmail.com>
 R: Sarah Harris <S.E.Harris@kent.ac.uk>
 S: Maintained
+F: docs/system/target-avr.rst
 F: gdb-xml/avr-cpu.xml
 F: target/avr/
 F: tests/acceptance/machine_avr6.py
diff --git a/docs/system/target-avr.rst b/docs/system/target-avr.rst
index dc99afc895d0..eb5c513cce09 100644
--- a/docs/system/target-avr.rst
+++ b/docs/system/target-avr.rst
@@ -17,21 +17,32 @@ https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR_ATMega
 Following are examples of possible usages, assuming demo.elf is compiled for
 AVR cpu
 
- - Continuous non interrupted execution:
-   ``qemu-system-avr -machine mega2560 -bios demo.elf``
-
- - Continuous non interrupted execution with serial output into telnet window:
-   ``qemu-system-avr -machine mega2560 -bios demo.elf -serial
-   tcp::5678,server,nowait -nographic``
-   and then in another shell
-   ``telnet localhost 5678``
-
- - Debugging wit GDB debugger:
-   ``qemu-system-avr -machine mega2560 -bios demo.elf -s -S``
-   and then in another shell
-   ``avr-gdb demo.elf``
-   and then within GDB shell
-   ``target remote :1234``
-
- - Print out executed instructions:
-   ``qemu-system-avr -machine mega2560 -bios demo.elf -d in_asm``
+- Continuous non interrupted execution::
+
+   qemu-system-avr -machine mega2560 -bios demo.elf
+
+- Continuous non interrupted execution with serial output into telnet window::
+
+   qemu-system-avr -M mega2560 -bios demo.elf -nographic \
+                   -serial tcp::5678,server,nowait
+
+  and then in another shell::
+
+   telnet localhost 5678
+
+- Debugging wit GDB debugger::
+
+   qemu-system-avr -machine mega2560 -bios demo.elf -s -S
+
+  and then in another shell::
+
+   avr-gdb demo.elf
+
+  and then within GDB shell::
+
+   target remote :1234
+
+- Print out executed instructions (that have not been translated by the JIT
+  compiler yet)::
+
+   qemu-system-avr -machine mega2560 -bios demo.elf -d in_asm
-- 
2.26.2


