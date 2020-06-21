Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A055C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFB224748
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNUhS0qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFB224748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmzXJ-0003LS-BM
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 08:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOi-0005Wa-F7
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:32 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOg-0002sB-OC
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id h5so14017792wrc.7
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 05:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sH5Z7PRdVohuoItYDl5pz8xjGsZcdn/4T0aCVreGxQE=;
 b=VNUhS0qwVHBPqs/7BDhN4Shxzj0oR2USE/DL7xqrIrfo6rg1W3Lk5MKZHgn0LidjdK
 pBus3MqJJ2M0q4DrYQKNJyCcHi1LdKwCIB9YsWx8HfOf8flMN032jVudKnauP1gtidId
 GFXMnQwVzQ0VO6LoFm++RXVXAU/fAV9lzD5QfWnOBjrCkyeawCG17AqxhBddtbK3c0mx
 CapzmqhwXSZUIn9099zfhj0p0RFi7w6PQMidXxYZ7I3KVS6RjlMYdOT6Cw7tilCU+LRH
 WLlTuFB+oRKQWseQy5PDoWVlDxMcdxg6Y59kYnQOr/xLxb/suFzNcn7UEZjHzOd/U4wh
 fzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sH5Z7PRdVohuoItYDl5pz8xjGsZcdn/4T0aCVreGxQE=;
 b=S+PBy9H0Ii6ADvzZSvf3AO4spdq4RK7RvxLXaXypDZafgsSCfY0LXX7iG5Fiotzjiu
 /wnWmR9SKMkDfPO5WxUg16fLwGFQ19sMqOCCzwnG3H5lTPk89ZJt810LuvjSxmLaflbA
 rbG/9BYR3jg06nht/A4tSxbqKUUO0f43DdVmWokIwdBb7TUvVYqkqrkK5b1TzwcOfg5s
 OGvm/8/aWJtyVF8h7Qhyn6YecVbhnVb8H/3BrjlHxdT6809RnOBe2kE1A0uX/kd1Z2Hn
 0r76nh2svuVNQueAlNZGkyVt9os/U+/DC6B/I/SJ7VwkYrQfJx6+qHZD4rp7JzpI3V2O
 Zf8Q==
X-Gm-Message-State: AOAM533+IFujB8rfB5uZjbR6a9hZ4C/jUck35RWmchdBczi8E4STlIOL
 eEbgaibey1wffkJvDbbKUE07vIrL
X-Google-Smtp-Source: ABdhPJzxaQQBUfqKw3Ek3zqe/pQS6NGe6YbJ2IwZhN4H+GwgH/fThLJsZNxPd7gmtc1Kqcg6VHOWsQ==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr494022wro.214.1592743708998; 
 Sun, 21 Jun 2020 05:48:28 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o10sm13779362wrj.37.2020.06.21.05.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 05:48:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/15] docs: Document the RX target
Date: Sun, 21 Jun 2020 14:48:07 +0200
Message-Id: <20200621124807.17226-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200621124807.17226-1-f4bug@amsat.org>
References: <20200621124807.17226-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Add rx-virt target specification document.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20200308130637.37651-1-ysato@users.sourceforge.jp>
[PMD: Cover in MAINTAINERS, rename as gdbsim, use machine argument]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/target-rx.rst | 36 ++++++++++++++++++++++++++++++++++++
 docs/system/targets.rst   |  1 +
 MAINTAINERS               |  1 +
 3 files changed, 38 insertions(+)
 create mode 100644 docs/system/target-rx.rst

diff --git a/docs/system/target-rx.rst b/docs/system/target-rx.rst
new file mode 100644
index 0000000000..4a20a89a06
--- /dev/null
+++ b/docs/system/target-rx.rst
@@ -0,0 +1,36 @@
+.. _RX-System-emulator:
+
+RX System emulator
+--------------------
+
+Use the executable ``qemu-system-rx`` to simulate RX target (GDB simulator).
+This target emulated following devices.
+
+-  R5F562N8 MCU
+
+   -  On-chip memory (ROM 512KB, RAM 96KB)
+   -  Interrupt Control Unit (ICUa)
+   -  8Bit Timer x 1CH (TMR0,1)
+   -  Compare Match Timer x 2CH (CMT0,1)
+   -  Serial Communication Interface x 1CH (SCI0)
+
+-  External memory 16MByte
+
+Example of ``qemu-system-rx`` usage for RX is shown below:
+
+Download ``<u-boot_image_file>`` from
+https://osdn.net/users/ysato/pf/qemu/dl/u-boot.bin.gz
+
+Start emulation of rx-virt::
+  qemu-system-rx -M gdbsim-r5f562n8 -bios <u-boot_image_file>
+
+Download ``kernel_image_file`` from
+https://osdn.net/users/ysato/pf/qemu/dl/zImage
+
+Download ``device_tree_blob`` from
+https://osdn.net/users/ysato/pf/qemu/dl/rx-virt.dtb
+
+Start emulation of rx-virt::
+  qemu-system-rx -M gdbsim-r5f562n8 \
+      -kernel <kernel_image_file> -dtb <device_tree_blob> \
+      -append "earlycon"
diff --git a/docs/system/targets.rst b/docs/system/targets.rst
index 0d8f91580a..99435a3eba 100644
--- a/docs/system/targets.rst
+++ b/docs/system/targets.rst
@@ -18,3 +18,4 @@ Contents:
    target-m68k
    target-xtensa
    target-s390x
+   target-rx
diff --git a/MAINTAINERS b/MAINTAINERS
index 1c9b4bc8e7..5a46536d86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1257,6 +1257,7 @@ RX Machines
 rx-gdbsim
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Maintained
+F: docs/system/target-rx.rst
 F: hw/rx/rx-gdbsim.c
 F: tests/acceptance/machine_rx_gdbsim.py
 
-- 
2.21.3


