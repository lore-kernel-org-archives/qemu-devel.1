Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF462C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DE6206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtfozgZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DE6206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfnFi-00015Z-9T
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5c-0005YM-Dg
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:15:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5a-0001Xs-Dj
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:15:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id x13so423424wrv.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=amxg9X1rCo75sQHICXUZgtnGOFtg3lKKCE8gKrKVo5Q=;
 b=jtfozgZ3SO4DbUM0iYv2+yW8MkqW1ekPKT/P8TscU3xnMRGt1Adkn1KEwLOTiDXnP1
 Msg4ccPFrTpYLs1lvpzo2lM/nCdVD5zM4AK9I/HFxepU49JKB/1SC2HtAkKB7AUhwSXs
 CSJPT7AESvMEcpP/c7nOFtudLRwp5yRk7V2v8vCxp3S0MJEIXkQ6OzloSqdc4XZaZdYB
 /6pDeUCDOXt1/puvOIl5T7e3tW19pSkMyoXRLmwcGwNmvHXBjBJL7IL07iAivXngWViX
 gIqLNioADjIbUGmQcMAmbQDqedcnui6IByAK3U9oWmBGQi70hoHqBqDQKpMrueGuaLKH
 9jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=amxg9X1rCo75sQHICXUZgtnGOFtg3lKKCE8gKrKVo5Q=;
 b=lMfSsiVsU5xMwGJ3ozLMG7K45gVsQBj934ItK0t/T+t7C1weezkBr0BfF4ldlCbqQi
 B1izt6suHw/sHFlBgqE8pbC3hacdXrVddQVvdRvi34zL8g8BrW5cGzzTPqW9MjaXJloe
 8YVK6NO/wIqbfumXR+dECkkmrLfA2/sk/46D6BA0Hkp8m0rYUN/lG6zGG/OfYQ8yt2e9
 7qUk+Ut9aby84SPF6j/6zBb9qnckPXTNIrnBxvW15rGK7FVJI6DsBTXaLVr3ChDiKHSl
 xnd+un28tE+rTSxpBX7nYT/cdvC/x3Sr0pu7/dOzupem2gkhP/9dGVe9gYYmQrCACZzo
 Kngw==
X-Gm-Message-State: AOAM53284G5VVkRkQ8LxAL4n28WNBkv7bdVCq0D9OjLjovon7Sh0wA4i
 b+v2mmOsXyaWeaML1poBZyU=
X-Google-Smtp-Source: ABdhPJz/1mJM1P5xIYlynP6s4CwbZEOwkoUpdvQ9HU9Gwy65h+qnVd90oXSL97e+q3HJOxMBhLq+FQ==
X-Received: by 2002:a05:6000:1184:: with SMTP id
 g4mr21301500wrx.46.1591028101076; 
 Mon, 01 Jun 2020 09:15:01 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a6sm21309896wrn.38.2020.06.01.09.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 09:15:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 12/12] docs: Document the RX target
Date: Mon,  1 Jun 2020 18:14:41 +0200
Message-Id: <20200601161441.8086-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601161441.8086-1-f4bug@amsat.org>
References: <20200601161441.8086-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Add rx-virt target specification document.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20200308130637.37651-1-ysato@users.sourceforge.jp>
[PMD: Rename as gdbsim, use machine argument]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/system/target-rx.rst | 36 ++++++++++++++++++++++++++++++++++++
 docs/system/targets.rst   |  1 +
 2 files changed, 37 insertions(+)
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
-- 
2.21.3


