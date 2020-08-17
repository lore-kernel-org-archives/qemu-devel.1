Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E11EC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09B8204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUvph8Qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09B8204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gkl-0007p7-1K
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHb-0005KU-QW
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHZ-0006Fc-TC
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:43 -0400
Received: by mail-wm1-x343.google.com with SMTP id g75so14084377wme.4
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GQ0FBqMMB50mRn7MFpTrLJW86UCkKNmSBW1pI3/NZfI=;
 b=PUvph8QcONT0uEbLI7J4nV78pPz0xi94JPPpAhzaBFE8+IhaWafYaCyAYSJqjA1DWG
 +CtcV4H5bBwGqVA65bv887gkPBgW2l1EZX5DbRPd0/AZXWufXdtLxAwUX1v+x8asnfmY
 JDBqxzY1fXZi8uQCQCDXNumO5rOl1qIYREQzBaF+PgTozSGesX8q9iu49oOIF8lMQrjm
 9l3IhaY54UngUmQz1N2xb5bpy3u44W4jENAKqecS/5bRA278qP5opfIjfe7MDMHTtfJG
 ilZHuvNmzjW2KMFdcUf8Nri30c9SF3lchWmMcucv85AxHc/uh9dkCiysSa+h/uokhQVw
 SADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GQ0FBqMMB50mRn7MFpTrLJW86UCkKNmSBW1pI3/NZfI=;
 b=Su5nvWw96f/2f2WHJ9SXEVFzekUVpZyShh5s8KBAoCoS+vlF2KjYA9ez9+jf2g6R0H
 +GgjdmSbCqDEz+B5/5Zfjw16cFdkeKbe9/L0gzff+rfRX6Wm47gDXU5qfErIGga+/Cxd
 aSx9UE1CfxC/yA0FxF/wZCVBWhHo6gWA9i80Zx1LLqzLjiPWOc3D+LjTjATnfpX5Bydx
 HzBqsctcHKnpyEAyBX5VgvQYgM+NdvKjQHXvQenW2ZkAs2ZLGlYLEtTHBVzvzf8bg1Db
 q9cYwqjI3AVjgLK4jZjec6RZGy7i90ZvTM051uNNSuFmR43Tl59dflLvSC2vMv6mkPb5
 Cbhw==
X-Gm-Message-State: AOAM533gZnlR+mz8mUEJaxa+OgyqDtk4CvwfXw4gbnLK+sYjRFZVikeQ
 Cw4NB3KlAOb1TwL61IAkpppZ+av0oyY=
X-Google-Smtp-Source: ABdhPJw3NIT7Nw7tPBWiivy3Fm0Cv4m7ofPL4AKE4AUzxS7cZNzcooGP7kD4VK5YUIOztFOZ90LKFQ==
X-Received: by 2002:a05:600c:21c2:: with SMTP id
 x2mr15339039wmj.142.1597675120167; 
 Mon, 17 Aug 2020 07:38:40 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 075/150] meson: convert common QMP bits for qemu and
 qemu-storage-daemon
Date: Mon, 17 Aug 2020 16:36:08 +0200
Message-Id: <20200817143723.343284-76-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x343.google.com
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs         |  8 +++++---
 Makefile.target       |  1 -
 meson.build           | 10 ++++++++++
 monitor/Makefile.objs |  6 ------
 monitor/meson.build   |  9 +++++++++
 qom/Makefile.objs     |  2 --
 qom/meson.build       |  3 +++
 7 files changed, 27 insertions(+), 12 deletions(-)
 delete mode 100644 monitor/Makefile.objs
 create mode 100644 monitor/meson.build
 delete mode 100644 qom/Makefile.objs

diff --git a/Makefile.objs b/Makefile.objs
index 6657a6cce3..d7826c1e5c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -37,10 +37,11 @@ endif # CONFIG_SOFTMMU or CONFIG_TOOLS
 # storage-daemon-obj-y is code used by qemu-storage-daemon (these objects are
 # used for system emulation, too, but specified separately there)
 
-storage-daemon-obj-y = block/ monitor/ qapi/ qom/ storage-daemon/
+storage-daemon-obj-y = block/ qapi/ qom/ storage-daemon/
 storage-daemon-obj-y += blockdev.o blockdev-nbd.o iothread.o job-qmp.o
 storage-daemon-obj-$(CONFIG_WIN32) += os-win32.o
 storage-daemon-obj-$(CONFIG_POSIX) += os-posix.o
+storage-daemon-obj-y += libqmp.fa
 
 ######################################################################
 # Target independent part of system emulation. The long term path is to
@@ -48,8 +49,7 @@ storage-daemon-obj-$(CONFIG_POSIX) += os-posix.o
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = monitor/
-common-obj-y += net/
+common-obj-y = net/
 common-obj-$(CONFIG_LINUX) += fsdev/
 
 common-obj-y += accel/
@@ -83,6 +83,8 @@ common-obj-y += backends/
 
 common-obj-y += qapi/
 
+common-obj-y += libqmp.fa
+
 endif # CONFIG_SOFTMMU
 
 #######################################################################
diff --git a/Makefile.target b/Makefile.target
index c8f7a6c04b..54a9ef1330 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -157,7 +157,6 @@ ifdef CONFIG_SOFTMMU
 obj-y += softmmu/
 obj-y += gdbstub.o
 obj-y += hw/
-obj-y += monitor/
 obj-y += qapi/
 obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
diff --git a/meson.build b/meson.build
index e28937dee2..d7d10cbbaf 100644
--- a/meson.build
+++ b/meson.build
@@ -471,6 +471,7 @@ stub_ss = ss.source_set()
 trace_ss = ss.source_set()
 block_ss = ss.source_set()
 blockdev_ss = ss.source_set()
+qmp_ss = ss.source_set()
 common_ss = ss.source_set()
 softmmu_ss = ss.source_set()
 user_ss = ss.source_set()
@@ -651,6 +652,7 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 common_ss.add(files('cpus-common.c'))
 
 subdir('softmmu')
+subdir('monitor')
 
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
@@ -700,6 +702,14 @@ block = declare_dependency(link_whole: [libblock],
                            link_args: '@block.syms',
                            dependencies: [crypto, io])
 
+qmp_ss = qmp_ss.apply(config_host, strict: false)
+libqmp = static_library('qmp', qmp_ss.sources(),
+                        dependencies: qmp_ss.dependencies(),
+                        name_suffix: 'fa',
+                        build_by_default: false)
+
+qmp = declare_dependency(link_whole: [libqmp])
+
 foreach m : block_mods + softmmu_mods
   shared_module(m.name(),
                 name_prefix: '',
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
deleted file mode 100644
index a8533c9dd7..0000000000
--- a/monitor/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-obj-y += misc.o
-common-obj-y += monitor.o qmp.o hmp.o
-common-obj-y += qmp-cmds.o qmp-cmds-control.o
-common-obj-y += hmp-cmds.o
-
-storage-daemon-obj-y += monitor.o qmp.o qmp-cmds-control.o
diff --git a/monitor/meson.build b/monitor/meson.build
new file mode 100644
index 0000000000..0484a64341
--- /dev/null
+++ b/monitor/meson.build
@@ -0,0 +1,9 @@
+qmp_ss.add(files('monitor.c', 'qmp.c', 'qmp-cmds-control.c'))
+
+softmmu_ss.add(files(
+  'hmp-cmds.c',
+  'hmp.c',
+  'qmp-cmds.c',
+))
+
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('misc.c'))
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
deleted file mode 100644
index b9629045e6..0000000000
--- a/qom/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
-storage-daemon-obj-y += qom-qmp-cmds.o
diff --git a/qom/meson.build b/qom/meson.build
index 4af044d858..35815f6c04 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -7,6 +7,9 @@ qom_ss.add(files(
   'qom-qobject.c',
 ))
 
+qmp_ss.add(files('qom-qmp-cmds.c'))
+softmmu_ss.add(files('qom-hmp-cmds.c'))
+
 qom_ss = qom_ss.apply(config_host, strict: false)
 libqom = static_library('qom', qom_ss.sources(),
                         dependencies: [qom_ss.dependencies()],
-- 
2.26.2



