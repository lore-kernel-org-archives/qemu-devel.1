Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1967AC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D709F20729
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCvHRiY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D709F20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gvF-0004P5-4e
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHe-0005SN-Mg
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHc-0006GP-R6
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id p14so13425805wmg.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Mmk59c4EQAPRiDRW+X6xYt7ikYTDWIzvbsC0+nBpJk=;
 b=pCvHRiY1Xb6zoXUlifvVhxD2PeK+uKMcV+AzS8iAL1aq+JYbiRJX8rB7PRPBSt+LSq
 QtrTNGvTMm7MISIyofe1pr18NhSG6umEZWD6O6x13uaBIw6Xuq7EWiLsi4ItJFUeM2lZ
 qdadvV7GINClI1erGoaa0fAyQRZmRbPkp0AQmDcRipqELbKUJKIZ8JG+vfbJZcQEZqqF
 DIhqd+eShCwqPWuwgfWVl1GQeLR8L0PRgJvb+FVvPcvXwAGFUE6nKXrsojfqSwOOy+lV
 7km7KYhwoaUfYaKKQMsBsCTXdWtmqAlK4u0FBOfkMboDPSE1JKnffh6pxdGfhGZdyPyY
 gG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0Mmk59c4EQAPRiDRW+X6xYt7ikYTDWIzvbsC0+nBpJk=;
 b=IMrVRyNNX6yCqrM0y0XKHYDCAVDO+7YShYRP5akfu3BGJSxBXtFkkoicCEvNuU+dQh
 HQ2T85ljvluF/PDNU+s7zwQgvvkohZTMFHs3BdisjE+bFkDS2Zkh0eHqAKohUkJix6gO
 YCLLmNruqayB9St+7IGY6GGmt38oioUS9fcj1n/an7kZXfvUsn5bXDTJaJxKsaHbx3x3
 qVYB4N9bH8vYay1vaV7lpsOLYeurL2ux0286ETcrSWkGY3qkPPWrd6x9mPt2SY2RxHDt
 J9jrNpw9EROr7KDneqRRVjyL7m28XKyG+zsSEGMaq5KvarSG6PrMUn+wBWF53yBH1Ga4
 DA9A==
X-Gm-Message-State: AOAM533J9feqeJj9+Ox0hfDDzHPUOM4qyjhu3js5qqYLxIgetQ8aEFol
 A2wSLyKKFfmvj6YLJbIqlZD9NrvlDTs=
X-Google-Smtp-Source: ABdhPJwm5vZBk9WAJKf61yYuYSFu2bX5LaAhNd1+sIurcLJLd4ABzQR1K9gyKW47U/aYLw6xhx8UCA==
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr14418069wmb.2.1597675123060; 
 Mon, 17 Aug 2020 07:38:43 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 078/150] meson: convert migration directory to Meson
Date: Mon, 17 Aug 2020 16:36:11 +0200
Message-Id: <20200817143723.343284-79-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32c.google.com
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs           |  1 -
 Makefile.target         |  1 -
 meson.build             |  5 +++++
 migration/Makefile.objs | 18 ------------------
 migration/meson.build   | 40 ++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include  |  7 +++----
 6 files changed, 48 insertions(+), 24 deletions(-)
 delete mode 100644 migration/Makefile.objs
 create mode 100644 migration/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index cfb2cf2b49..9d0a82d82a 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -43,7 +43,6 @@ common-obj-y = net/
 common-obj-$(CONFIG_LINUX) += fsdev/
 
 common-obj-y += accel/
-common-obj-y += migration/
 
 common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
 common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
diff --git a/Makefile.target b/Makefile.target
index 54a9ef1330..4d912df3a3 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -158,7 +158,6 @@ obj-y += softmmu/
 obj-y += gdbstub.o
 obj-y += hw/
 obj-y += qapi/
-obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
 
 # Temporary until emulators are linked by Meson
diff --git a/meson.build b/meson.build
index 3c79d0cea3..dc9ce85689 100644
--- a/meson.build
+++ b/meson.build
@@ -304,6 +304,10 @@ lzo = not_found
 if 'CONFIG_LZO' in config_host
   lzo = declare_dependency(link_args: config_host['LZO_LIBS'].split())
 endif
+rdma = not_found
+if 'CONFIG_RDMA' in config_host
+  rdma = declare_dependency(link_args: config_host['RDMA_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -651,6 +655,7 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 common_ss.add(files('cpus-common.c'))
 
 subdir('softmmu')
+subdir('migration')
 subdir('monitor')
 subdir('replay')
 
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
deleted file mode 100644
index 0fc619e380..0000000000
--- a/migration/Makefile.objs
+++ /dev/null
@@ -1,18 +0,0 @@
-common-obj-y += migration.o socket.o fd.o exec.o
-common-obj-y += tls.o channel.o savevm.o
-common-obj-y += colo.o colo-failover.o
-common-obj-y += vmstate.o vmstate-types.o page_cache.o
-common-obj-y += qemu-file.o global_state.o
-common-obj-y += qemu-file-channel.o
-common-obj-y += xbzrle.o postcopy-ram.o
-common-obj-y += qjson.o
-common-obj-y += block-dirty-bitmap.o
-common-obj-y += multifd.o
-common-obj-y += multifd-zlib.o
-common-obj-$(CONFIG_ZSTD) += multifd-zstd.o
-
-common-obj-$(CONFIG_RDMA) += rdma.o
-
-common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
-
-rdma.o-libs := $(RDMA_LIBS)
diff --git a/migration/meson.build b/migration/meson.build
new file mode 100644
index 0000000000..ac8ff1419f
--- /dev/null
+++ b/migration/meson.build
@@ -0,0 +1,40 @@
+# Files needed by unit tests
+migration_files = files(
+  'page_cache.c',
+  'xbzrle.c',
+  'vmstate-types.c',
+  'vmstate.c',
+  'qemu-file-channel.c',
+  'qemu-file.c',
+  'qjson.c',
+)
+
+libmigration = static_library('migration', sources: migration_files + genh,
+                              name_suffix: 'fa',
+                              build_by_default: false)
+migration = declare_dependency(link_with: libmigration,
+                               dependencies: [zlib, qom, io])
+softmmu_ss.add(migration)
+
+softmmu_ss.add(files(
+  'block-dirty-bitmap.c',
+  'channel.c',
+  'colo-failover.c',
+  'colo.c',
+  'exec.c',
+  'fd.c',
+  'global_state.c',
+  'migration.c',
+  'multifd.c',
+  'multifd-zlib.c',
+  'postcopy-ram.c',
+  'savevm.c',
+  'socket.c',
+  'tls.c',
+))
+
+softmmu_ss.add(when: ['CONFIG_RDMA', rdma], if_true: files('rdma.c'))
+softmmu_ss.add(when: 'CONFIG_LIVE_BLOCK_MIGRATION', if_true: files('block.c'))
+softmmu_ss.add(when: 'CONFIG_ZSTD', if_true: [files('multifd-zstd.c'), zstd])
+
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('ram.c'))
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 66acf9cdb3..425c8ce699 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -227,7 +227,8 @@ tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
 tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
 tests/test-bitmap$(EXESUF): tests/test-bitmap.o $(test-util-obj-y)
 tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
-tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
+tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/libmigration.fa $(test-util-obj-y) \
+	$(test-io-obj-y)
 tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-util-obj-y)
 tests/test-int128$(EXESUF): tests/test-int128.o
 tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)
@@ -253,9 +254,7 @@ tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/vmstate-if.o \
 	hw/core/clock.o hw/core/qdev-clock.o \
 	$(test-qapi-obj-y)
-tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
-	migration/vmstate.o migration/vmstate-types.o migration/qemu-file.o \
-        migration/qemu-file-channel.o migration/qjson.o \
+tests/test-vmstate$(EXESUF): tests/test-vmstate.o migration/libmigration.fa \
 	$(test-io-obj-y)
 tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-obj-y)
 tests/test-base64$(EXESUF): tests/test-base64.o $(test-util-obj-y)
-- 
2.26.2



