Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86482C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A532207F7
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A532207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5t4a-0007kS-KN
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 11:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1k5t42-0007Kl-TB; Wed, 12 Aug 2020 11:53:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1k5t3z-00062e-IZ; Wed, 12 Aug 2020 11:53:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id p20so2537998wrf.0;
 Wed, 12 Aug 2020 08:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nMDBJ4z8t6kInHEJCqXELzn78TzjorTmxQyL7f9oSRA=;
 b=Vf1kFyxFZM/YgVvwqzFXazByWqorAOAbm/dLCY8ZAAXoVGD7t8Ozhrlm1nLHr0ghFi
 NJJ+KpibvT/rWd/BGS0AAq/r9bG/xy96ZVgkrX/iAwE3ldX3OXfINEAAaJ9skITk8UtF
 J7NGKQ8PK1actOM5x675Z/CIuCM90eBntQI6IDiBeZmafcSetilLtQVN0lM8duQ+njnC
 DqQ0460VMDNKbelnFC/khrGMBZnZDVa3+9MFEV3V2cSb67F5joHts/toQqcENyGH2vQG
 kgZNpjwR1iXW+IH9rV6SGk9CFJK7aBk7iplLWE9PIXFZNhpLUG2t2nQ5ceWs/ldmHE22
 wq4w==
X-Gm-Message-State: AOAM5329m3xBqTuW4R9gVorY6tHpTksGt0cY+PBWwuIsDTxjMB7EH5a3
 bnPqjHcN8z4jxP/KQMabuCt7e3HppgA=
X-Google-Smtp-Source: ABdhPJwaakqdDC2tKW6WtYfvMkBeTekK48fdySqIDztgv82Bkvwxm1qMz4KX7gqPW02ChOPdcfRuhA==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr288932wrw.148.1597247592316; 
 Wed, 12 Aug 2020 08:53:12 -0700 (PDT)
Received: from localhost.localdomain ([46.114.148.4])
 by smtp.gmail.com with ESMTPSA id h10sm4776478wro.57.2020.08.12.08.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 08:53:11 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH] docs/system/target-avr: Improve the AVR docs and add to
 MAINTAINERS
Date: Wed, 12 Aug 2020 17:53:04 +0200
Message-Id: <20200812155304.18016-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.221.67; envelope-from=th.huth@gmail.com;
 helo=mail-wr1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 11:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The examples look nicer when using "::" code blocks.
Also mention that "-d in_asm" only outputs instructions that have not
been translated by the JIT layer yet.
And while we're at it, also add the AVR doc file to the MAINTAINERS file.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS                |  1 +
 docs/system/target-avr.rst | 47 +++++++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0886eb3d2b..5b21962bc6 100644
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
index dc99afc895..1410031f5e 100644
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


