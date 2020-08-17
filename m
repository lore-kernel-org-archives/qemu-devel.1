Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ADFC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BF1204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2Zu0UfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BF1204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gj0-0003kc-H7
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHY-0005CP-Le
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHW-0006Ey-Up
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id f18so13347432wmc.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q89jAjyHBRq6xfP3HIT0eKnoY4vV+s645d2y/Ix2bG4=;
 b=t2Zu0UfQzzVFV1nHFdnDfv1HHeHlCG6iLHSvLwcwljkIyPPQxZhhhUTJCzQ2ndlbWW
 jUYDziK4NJbkvUVVLN+b58bR6iZ/VvdijQ8SLq06aMgllkOYzqqXV2/FwcrWP/76DHUv
 wHbKD9Q7sbH3UzzVpoYCuMBNoVl2A9fzruwlp7Cd/XLkiK+SqECYVWzN1Ois8ZTXI/cT
 XEFBjihdUPWYFOa+mLoCeVmkMytB1hpUJtevdlKoCYTrjzHdugUPBuvRAftWAJ9cs+Ha
 aBIHmAvz9iJaNocQdzL0MJfoByccbJ//zCSQwGjsvBO5zO9DGnVx/dr9ZVDe5uwIPrEx
 q7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Q89jAjyHBRq6xfP3HIT0eKnoY4vV+s645d2y/Ix2bG4=;
 b=DG984yj+1ukhRsGjHScTRCnffL+HfqJhdG6qYZKp/FEc9arJ5hvsFB4XQA8P7FV7c1
 ys13K8uFgP3qSmC8Gz2nQmrHkV7MbZYh6O/58rEJSTi46aqmblAMGo11uMoKQ2quUyxV
 TbgiQ+QIuUGPi1TEVWHCoLNDFKsFEWCvAyXRQc8LUGh/3icLyJJpewrqyIu7AIXWwy97
 ZPM/vEEpAsrlgL/wrBq3xQ4/G14UQuzZyTphtKONEBhbc+UsEL6L/4jH285PMCePfpjb
 Edxjvm08o/l2fLuIb28XTJIciD6sPH8ccGFzW055Ija5VkFb+747bEzmmInRBJeXzGPZ
 FMdA==
X-Gm-Message-State: AOAM532srrdK3S3tkNm5DVA+Zioo3Wb59tj7xLuybkHMDaDA2+spO7R0
 FyI5z8AJYKzUkUQIZLKH4ilZ4cnv0mw=
X-Google-Smtp-Source: ABdhPJwWdcZOtj23YVy6DZnCx6HfgZengAoBNYwOpweV4R1vpBl51hg0tJ2GofINiUTcdCvG0ukzzQ==
X-Received: by 2002:a05:600c:2116:: with SMTP id
 u22mr14803455wml.35.1597675117398; 
 Mon, 17 Aug 2020 07:38:37 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.36 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 072/150] meson: convert most of softmmu/
Date: Mon, 17 Aug 2020 16:36:05 +0200
Message-Id: <20200817143723.343284-73-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Leave out main.c, it's special due to fuzzing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build           |  2 ++
 softmmu/Makefile.objs | 14 +-------------
 softmmu/meson.build   | 10 ++++++++++
 3 files changed, 13 insertions(+), 13 deletions(-)
 create mode 100644 softmmu/meson.build

diff --git a/meson.build b/meson.build
index a9e52e56c7..9169e9d880 100644
--- a/meson.build
+++ b/meson.build
@@ -641,6 +641,8 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 
 common_ss.add(files('cpus-common.c'))
 
+subdir('softmmu')
+
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
 
diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
index c036887500..ec74d8a9fa 100644
--- a/softmmu/Makefile.objs
+++ b/softmmu/Makefile.objs
@@ -1,14 +1,2 @@
 softmmu-main-y = softmmu/main.o
-
-obj-y += arch_init.o
-obj-y += cpus.o
-obj-y += cpu-throttle.o
-obj-y += balloon.o
-obj-y += ioport.o
-obj-y += memory.o
-obj-y += memory_mapping.o
-
-obj-y += qtest.o
-
-obj-y += vl.o
-vl.o-cflags := $(SDL_CFLAGS)
+main.o-cflags := $(SDL_CFLAGS)
diff --git a/softmmu/meson.build b/softmmu/meson.build
new file mode 100644
index 0000000000..95d38df259
--- /dev/null
+++ b/softmmu/meson.build
@@ -0,0 +1,10 @@
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
+  'arch_init.c',
+  'balloon.c',
+  'cpus.c',
+  'cpu-throttle.c',
+  'ioport.c',
+  'memory.c',
+  'memory_mapping.c',
+  'qtest.c',
+  'vl.c'))
-- 
2.26.2



