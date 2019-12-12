Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C4AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5DA214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgYiAkSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5DA214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOcw-0005h2-7w
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyd-0003wG-G7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyc-0007JK-8b
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:55 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyc-0007Hs-26
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:54 -0500
Received: by mail-wr1-x430.google.com with SMTP id c9so2603640wrw.8
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1UQ2kTNLPaicL/8LAE1GmhnSZYlZaS/Vm313Ic4mUkw=;
 b=XgYiAkSWQlt2SoFD0M62ObTvO2zVpIA8T7okLa0LVugQU/YkMN+0doPnRz+9+ZifRN
 CL8m5OAtADHNgTz8YhJ8iwPSKZjYKhL/kFU1Vd3X+niH/IuqAcnqCn9IrkdqeaeUVvO3
 6lx+E5skrFyeRz2bmIKySVziYesO8BfCPC5zoW4eWwAtxf/BVcvCeP+7SBYEaN5hfs5u
 X4cxPuGdmy1KcZR1tRUw0YE2Rq2NP0ZZVubAjl2BbEcFBotnPvbaQ+7mkNNWmdXhVdQ6
 0SaTYwN1ZRaNqa7bEdg7hBZW9uW3ZEGV4QV6sk9nfGuOjXOBBB1pfU25gPX6lHppaOv9
 DdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1UQ2kTNLPaicL/8LAE1GmhnSZYlZaS/Vm313Ic4mUkw=;
 b=g7RGOjEJMy+Ovne5/TD3DzSrscP7ehNAHFgMBzaLr0lRkg1+XBdURXiivs9AWnoHvA
 zQt456GFlrpUKVF6Mv5M6r6o3Vx28JcND0NaxaQPHfOW72BUJl0kwmz20K5JHG2+HWZL
 B2EkePYS0OP0Pqif5Mk+qgLN9yJoQ784WRQ3Y3Y9pZhMcDuallWF35lMBg0jXiaQ38ip
 kAhjptSW1+7nhNdvORd+u/QAEWo+YXCLY6rK/GdFVTRmFaecNCWOw7FE9x/8ELgghRWy
 G7BhcafEBJZsrAZo13mQ2VVV4Pnqx/VK1vlaCLLz3Gr9YWKS4KRnVEC9RD6zl23hu8JM
 pnFQ==
X-Gm-Message-State: APjAAAXvw/TGJHV86+mQFK9StyAyL7BfiYG0TgUlYAS73dX07UpIbCXL
 xVqv0XqhsNtue4xcn5tP90O01fhy
X-Google-Smtp-Source: APXvYqy2E9AxbVe9yQ698mq0hZ50w6kgQg4zunOK5GKhuGq9I4AZTKvPbmWJhd+EZoQ5JNBKobkG2w==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr6272794wrs.184.1576155232693; 
 Thu, 12 Dec 2019 04:53:52 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 055/132] meson: convert replay directory to Meson
Date: Thu, 12 Dec 2019 13:51:39 +0100
Message-Id: <1576155176-2464-56-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs        |  1 -
 meson.build          |  1 +
 replay/Makefile.objs |  9 ---------
 replay/meson.build   | 11 +++++++++++
 4 files changed, 12 insertions(+), 10 deletions(-)
 delete mode 100644 replay/Makefile.objs
 create mode 100644 replay/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 98c16c5..542d8e8 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -60,7 +60,6 @@ common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
 
 common-obj-y += hw/
-common-obj-y += replay/
 common-obj-y += backends/
 endif
 
diff --git a/meson.build b/meson.build
index 2355a99..29c68cd 100644
--- a/meson.build
+++ b/meson.build
@@ -591,6 +591,7 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 common_ss.add(files('cpus-common.c'))
 
 subdir('monitor')
+subdir('replay')
 
 mods = []
 block_mods = []
diff --git a/replay/Makefile.objs b/replay/Makefile.objs
deleted file mode 100644
index cee6539..0000000
--- a/replay/Makefile.objs
+++ /dev/null
@@ -1,9 +0,0 @@
-common-obj-y += replay.o
-common-obj-y += replay-internal.o
-common-obj-y += replay-events.o
-common-obj-y += replay-time.o
-common-obj-y += replay-input.o
-common-obj-y += replay-char.o
-common-obj-y += replay-snapshot.o
-common-obj-y += replay-net.o
-common-obj-y += replay-audio.o
\ No newline at end of file
diff --git a/replay/meson.build b/replay/meson.build
new file mode 100644
index 0000000..b532189
--- /dev/null
+++ b/replay/meson.build
@@ -0,0 +1,11 @@
+softmmu_ss.add(files(
+  'replay.c',
+  'replay-internal.c',
+  'replay-events.c',
+  'replay-time.c',
+  'replay-input.c',
+  'replay-char.c',
+  'replay-snapshot.c',
+  'replay-net.c',
+  'replay-audio.c',
+))
-- 
1.8.3.1



