Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D658BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB7B920708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5FnimvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7B920708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssQs-0001x5-W3
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAM-0000GJ-LJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:18:02 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAK-0002xj-GM
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:18:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id r12so46172992wrj.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IBIliU2TvqhuT2+YwakVDSLtJXEXe6zfG/AsoZOUvLc=;
 b=a5FnimvEMyGyCAvdKKmK+xMV79vaP5p6TKHmucn504j05Tc3QVZVLwCTxl5dgI3nPj
 ssP0jTIgq2GiBzCdW9t4iqtOrVO7c3jIr7ErA0Znjks1bHudrJ5PwQ3yIbvlNVhWMN5b
 Yx2Lmoo8wDJDNmT641rgN5bUSyuJYhvnZ9V+KCBtTW7MLfXRJ85/YLXLC/IAtKscgA9e
 fbhgXBvFhA45F+qVZRNXZNM5GBzUx7uGpqrHeMtxWmUBDEo3NhNbcVii4X9iWnLNBM7Z
 U8LE8oQZUTmxuzUs+VNXhOHkNxmkoI65EtLOYV3+HidtYokITuRjv0pKMjXWOeErx1Fw
 eb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IBIliU2TvqhuT2+YwakVDSLtJXEXe6zfG/AsoZOUvLc=;
 b=kuG59xDb8lbozxeSOJzMTv3CiETa4IgforU7qHcUx5MOAPDLxd/4r0qpu2gTGRaHMe
 PwjXV8Aw7GYpWDSO5tfChETMQR0FNsBjbFqeiLAZA8ibhyVqe0o0o9Adup6KO7yttOjn
 cxQtD8yahxWRjwE/0p9+fSMoDfAGc9johwC+AFnzNqFRe0F6LXfPSeqt9WxTtiSOSDt7
 uDGOv+lMR0ameAMm+EEJkPq12lwm0DPYzY8K4z7rvOjuPoyjEXBUh+W/HgsQnLkWv+Z4
 xOecanveV6irTSG3yEcd7xlG1WCC65rMMM8N8EbJNYnQ08Jklrzq5yDwvBZCteCmfgxn
 vI4A==
X-Gm-Message-State: AOAM5315lAlJCGWKL6bh+CfpYN7m0ImKfXWQtiW/eJkRCsrRM1UkOnUC
 Yq2qplHMuDGEUHdW0LOarBBXQTgP
X-Google-Smtp-Source: ABdhPJxg1de/lvq0mJ1/gRowZ/SK+G14W454NwpG/npo7vEgPoXKdVFqB0oiot2F4l3JSGDJfaSGdA==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr60574398wru.158.1594145878971; 
 Tue, 07 Jul 2020 11:17:58 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/32] target/avr: Add section into QEMU documentation
Date: Tue,  7 Jul 2020 20:17:07 +0200
Message-Id: <20200707181710.30950-30-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <huth@tuxfamily.org>

The new section explains basic ways of using AVR target in QEMU.

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
[thuth: Converted doc from texi to Sphinx syntax]
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20200705140315.260514-31-huth@tuxfamily.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/system/target-avr.rst | 37 +++++++++++++++++++++++++++++++++++++
 docs/system/targets.rst    |  1 +
 2 files changed, 38 insertions(+)
 create mode 100644 docs/system/target-avr.rst

diff --git a/docs/system/target-avr.rst b/docs/system/target-avr.rst
new file mode 100644
index 0000000000..dc99afc895
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
2.21.3


