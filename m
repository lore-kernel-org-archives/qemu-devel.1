Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D0BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE56208D5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyvqTtR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE56208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jldeB-0008JO-VA
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 15:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldXE-0004nU-8v
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:44 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:32822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldXC-0006Vd-IE
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:43 -0400
Received: by mail-ed1-x543.google.com with SMTP id o26so2980641edq.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=st/NuADr8TdJH+6fO2pHqCM868VhnYEYagWoXKn0oKU=;
 b=iyvqTtR7cSPIwurCWR6yKhLblx5OmGhqhQEDpFoisHCbfX8VQCgfP51AZwMb571mmv
 8HrvSwrgGoGLXiSOEU5gM1F2O9WpQp599zMq0HKgyy8z3SCN7pneIaHPz1QZS1I0bF5R
 wpo5kfw2mjl2pGBNLgQcahKtl+QFV5WAIKr/dDrXL3dgGzHg7l3DQYn6nR2/z/WZOA2p
 570BcDLg/YWJ9N3aazSOLXRzRLh8UWEqyVmnRGxZlvJ511cY+AaabTXYMikOAUqgAjmw
 xC6p3v2/ZxDoFuPQoejvlQfApHXA47ZON7yTzfi9G6hMEanH72zCB+5/1kZZdH5U7R+F
 GdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=st/NuADr8TdJH+6fO2pHqCM868VhnYEYagWoXKn0oKU=;
 b=B/TPdib3Ozn/eMjJTqSxvF+HgwovZ+ldpzK2UHd/1hGD9Xb5zf8HtwLn1ue4pczWSd
 lMju3sFmMjQusbDZ1J5592+uoOvwiGp7T2nasLIoOrOab5tTyIsJFBaIZJ8I9HJGKPY6
 UzVYELNb8k/wvxVGT6PWXFrUaSszXg8vVyMkBE+H8/8G+az2LRv3copxEee0wci6Pm1r
 4uOWN97g5BVLxcMPOjYa6xXvAyFsu8lea4Y0G0XV6vLLDToP17h0do9y0vcis3/kyPFy
 POvbZ2mkey9oH0rJsINyIrTJs+2XhfGxy9gVlaS/EWt1hwawNGG1ogxmlD8P0TZbapFW
 PxAw==
X-Gm-Message-State: AOAM530Tj7yhLbjqm6D6/bRtjUG5NooDaNGkwWF+MO7hA+loWhKZ+Usi
 1V0IHWHpfvN5QZk+U9+97pE=
X-Google-Smtp-Source: ABdhPJzTJsbNUtM8BR5ks0VtrqENlRBpi6UFcDe/W//zZfl+IwKvOg3BORSBs3jJ8fr1y6XsPIH/Cg==
X-Received: by 2002:a50:f60a:: with SMTP id c10mr605285edn.295.1592421341074; 
 Wed, 17 Jun 2020 12:15:41 -0700 (PDT)
Received: from x1w.redhat.com (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id y21sm324308edl.72.2020.06.17.12.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 12:15:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Subject: [PATCH rc1 15/15] docs: Document the RX target
Date: Wed, 17 Jun 2020 21:15:19 +0200
Message-Id: <20200617191519.14842-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617191519.14842-1-f4bug@amsat.org>
References: <20200617191519.14842-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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
Cc: Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Add rx-virt target specification document.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20200308130637.37651-1-ysato@users.sourceforge.jp>
[PMD: Cover in MAINTAINERS, rename as gdbsim, use machine argument]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


