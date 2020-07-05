Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D0FC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B85E2068F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B85E2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5Rr-0006M2-No
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5FI-0007rj-SE
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:52 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:46625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5FH-0008N8-4a
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:52 -0400
Received: by mail-ej1-f47.google.com with SMTP id p20so39621954ejd.13
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rTb61qVqQxM+c4GL5A/lVhDhxPH2+VJexS8aBrwdYmw=;
 b=Jl24SWbRETLGOsUe7J6PwC/+K9rjNUfLpYyZmNIl+duOlL7h8HzD+Gs1Xg0TyPlEiE
 vom7ag1r3rDte5hxQVtCaCbelgwnuBa52C3KMqC2qkpF8+BOhNAqhR4Cr/UtyJLn4NtK
 /lNLBGo8xZDRmp6isffOG272o0cBjY4USVa9Lifzh1Vt8367aY5klS1/bD6a5hyVxqOO
 ogf9MMWg9F0o3ny1kxBIaHD1t9WxQHi+OWVS+mhqWvVUjq7uKKDtm2F1PLZmRHcYljx/
 Exz0kvcbss99uQZ9gcVvtwrRAhVAfS/M4bQqi30PvOBZlHrKQ/GTDcrzERt637i9E+NZ
 803w==
X-Gm-Message-State: AOAM531IAEUBbzcl8FL5TW9nPPnqAB9JLuAhWehtAWZMxbNjSn+HoSQ9
 wB27QZc0nLpkMqFjqzwWadDwhHlN
X-Google-Smtp-Source: ABdhPJy6jiuxLbKJtLSo3ndogQB1ENI2BcB9G+TQzSZ/1NW+DeFWatY+FI29MJvG9e1mOnawh5KH/g==
X-Received: by 2002:a17:906:4bcf:: with SMTP id
 x15mr30329957ejv.188.1593957829621; 
 Sun, 05 Jul 2020 07:03:49 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:49 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 30/30] target/avr: Add section into QEMU documentation
Date: Sun,  5 Jul 2020 16:03:15 +0200
Message-Id: <20200705140315.260514-31-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
References: <20200705140315.260514-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.47; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f47.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The new section explains basic ways of using AVR target in QEMU.

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
[thuth: Converted doc from texi to Sphinx syntax]
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 docs/system/target-avr.rst | 37 +++++++++++++++++++++++++++++++++++++
 docs/system/targets.rst    |  1 +
 2 files changed, 38 insertions(+)
 create mode 100644 docs/system/target-avr.rst

diff --git a/docs/system/target-avr.rst b/docs/system/target-avr.rst
new file mode 100644
index 0000000000..40d212a9a7
--- /dev/null
+++ b/docs/system/target-avr.rst
@@ -0,0 +1,37 @@
+.. _AVR-System-emulator:
+
+AVR System emulator
+-------------------
+
+Use the executable ``qemu-system-avr`` to emulate a AVR 8 bit based machine.
+These can have one of the following cores: avr1, avr2, avr25, avr3, avr31,
+avr35, avr4, avr5, avr51, avr6, avrtiny, xmega2, xmega3, xmega4, xmega5,
+xmega6 and xmega7.
+
+As for now it supports few Arduino boards for educational and testing purposes.
+These boards use a ATmega controller, which model is limited to USART & 16-bit
+timer devices, enought to run FreeRTOS based applications (like
+https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
+).
+
+Following are examples of possible usages, assuming demo.elf is compiled for
+AVR cpu
+
+ - Continuous non interrupted execution: 
+   ``qemu-system-avr -machine mega2560 -bios demo.elf``
+
+ - Continuous non interrupted execution with serial output into telnet window:
+   ``qemu-system-avr -machine mega2560 -bios demo.elf -serial
+   tcp::5678,server,nowait -nographic``
+   and then in another shell
+   ``telnet localhost 5678``
+
+ - Debugging wit GDB debugger:
+   ``qemu-system-avr -machine mega2560 -bios demo.elf -s -S``
+   and then in another shell
+   ``avr-gdb demo.elf``
+   and then within GDB shell
+   ``target remote :1234``
+
+ - Print out executed instructions:
+   ``qemu-system-avr -machine mega2560 -bios demo.elf -d in_asm``
diff --git a/docs/system/targets.rst b/docs/system/targets.rst
index 99435a3eba..560783644d 100644
--- a/docs/system/targets.rst
+++ b/docs/system/targets.rst
@@ -19,3 +19,4 @@ Contents:
    target-xtensa
    target-s390x
    target-rx
+   target-avr
-- 
2.26.2


