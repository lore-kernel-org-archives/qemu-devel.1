Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E419AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8C6205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WngXz3PC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8C6205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gr1-00041C-OW
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHk-0005hF-MA
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:56079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHi-0006HY-PQ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:52 -0400
Received: by mail-wm1-x329.google.com with SMTP id 9so13415915wmj.5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/tsncgwQh4W0ceyyi2wK+lJDdvVOT/ajFgeIk/PUNhA=;
 b=WngXz3PCr6DddeZxvqNygPLOXtECsX6h4S9zlK1GngwRR0KKK25eECIL0g6T4KNSGD
 gqWlxANOOAbAxUBJ5vFgMyGN7GgJLRbeQWtq/MR0T5nhbo8N4GC6Q0nw5zKwKw0g3nR1
 xd8gpz+G240voF2WEDuLpgQICrjYeBhTTxTn4Hf9c3KIk6MHM/Sy/Bjs0vFdcuIZSjzn
 DvJaACymDgbr7X/ezvr3J0NNIn5XRoA+HT4CPMBkct4ocX+WlBr9JS2SUZpE0nNv5Hfg
 ZKcVbHY9yY5/nRFgcSLIujpJDbek20/RETBAcINGzg8+R17gTpg+vXcGnwTjz5lH+2DR
 3d/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/tsncgwQh4W0ceyyi2wK+lJDdvVOT/ajFgeIk/PUNhA=;
 b=Z1EJRyYc0v/JW7WDfqCZ45TOfWfH/oWy6/HiGja4cmaePM/WPgohKhPlL/ieVRZEfu
 T/krBIDQjy1Zgsa0SFZNxgU1Bt0TwXFfDW/Zmke8XSuSHXWXTQd/GwF7fttEF83oG9LY
 qYkLCNmxsTE53V3Ypt/ZpetxyBqhj6er9YrgNOqNwShDmbCFwdmpOTLf4sT7PARY6mdQ
 iyHEDvuHoq6k57jJoUG9qEpCPeIb3LJr/CgfH8KV9KE/GSxh2pwgnIB4/jx+y7eQUw08
 PLnWmNQ3ht+fGqlhkwnnNi41SH/aJarlq206Kv3Z+dSWJVr/e5qbdhXCei5m1cGsPzeu
 XSKQ==
X-Gm-Message-State: AOAM533u6Qt/ib2SSUcEWfv7Rmf8FR/WiYO2H+F/GMSg1LWc3OpmaLhj
 qdlEhYcmNEFBiPG6XnvymJD+eARKtbs=
X-Google-Smtp-Source: ABdhPJy06w0S9GWJbHcgoTmmFgnWEsk89XdC5yGqDld4MTzJcWT9aKhrGira41ZGocwKhmP3AsPruQ==
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr14602091wmj.8.1597675129120; 
 Mon, 17 Aug 2020 07:38:49 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 084/150] meson: convert hw/xen
Date: Mon, 17 Aug 2020 16:36:17 +0200
Message-Id: <20200817143723.343284-85-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x329.google.com
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
 configure            |  7 +++++--
 hw/Makefile.objs     |  1 -
 hw/meson.build       |  1 +
 hw/xen/Makefile.objs |  7 -------
 hw/xen/meson.build   | 20 ++++++++++++++++++++
 meson.build          |  6 ++++++
 6 files changed, 32 insertions(+), 10 deletions(-)
 create mode 100644 hw/meson.build
 delete mode 100644 hw/xen/Makefile.objs
 create mode 100644 hw/xen/meson.build

diff --git a/configure b/configure
index b037d175ea..6a964de121 100755
--- a/configure
+++ b/configure
@@ -2691,6 +2691,8 @@ if test "$xen" != "no" ; then
     fi
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
     libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
+    xen_cflags="$($pkg_config --cflags $xen_pc)"
+    xen_libs="$($pkg_config --libs $xen_pc)"
   else
 
     xen_libs="-lxenstore -lxenctrl -lxenguest"
@@ -2971,9 +2973,8 @@ EOF
 
     if test "$xen" = yes; then
       if test $xen_ctrl_version -ge 40701  ; then
-        libs_softmmu="$xen_stable_libs $libs_softmmu"
+        xen_libs="$xen_libs $xen_stable_libs "
       fi
-      libs_softmmu="$xen_libs $libs_softmmu"
     fi
   fi
 fi
@@ -7264,6 +7265,8 @@ fi
 if test "$xen" = "yes" ; then
   echo "CONFIG_XEN_BACKEND=y" >> $config_host_mak
   echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=$xen_ctrl_version" >> $config_host_mak
+  echo "XEN_CFLAGS=$xen_cflags" >> $config_host_mak
+  echo "XEN_LIBS=$xen_libs" >> $config_host_mak
 fi
 if test "$linux_aio" = "yes" ; then
   echo "CONFIG_LINUX_AIO=y" >> $config_host_mak
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 14b7ea4eb6..d204a906af 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -35,7 +35,6 @@ devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
-devices-dirs-$(CONFIG_XEN) += xen/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 devices-dirs-$(CONFIG_NUBUS) += nubus/
 devices-dirs-y += semihosting/
diff --git a/hw/meson.build b/hw/meson.build
new file mode 100644
index 0000000000..08112a5e4b
--- /dev/null
+++ b/hw/meson.build
@@ -0,0 +1 @@
+subdir('xen')
diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
deleted file mode 100644
index 502b32d877..0000000000
--- a/hw/xen/Makefile.objs
+++ /dev/null
@@ -1,7 +0,0 @@
-# xen backend driver support
-common-obj-y += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-bus.o xen-bus-helper.o xen-backend.o
-
-obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
-obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
-obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt_load_rom.o
-obj-$(call lnot,$(CONFIG_XEN_PCI_PASSTHROUGH)) += xen_pt_stub.o
diff --git a/hw/xen/meson.build b/hw/xen/meson.build
new file mode 100644
index 0000000000..076954b89c
--- /dev/null
+++ b/hw/xen/meson.build
@@ -0,0 +1,20 @@
+softmmu_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
+  'xen-backend.c',
+  'xen-bus-helper.c',
+  'xen-bus.c',
+  'xen-legacy-backend.c',
+  'xen_devconfig.c',
+  'xen_pvdev.c',
+))
+
+xen_specific_ss = ss.source_set()
+xen_specific_ss.add(when: 'CONFIG_XEN_PCI_PASSTHROUGH', if_true: files(
+  'xen-host-pci-device.c',
+  'xen_pt.c',
+  'xen_pt_config_init.c',
+  'xen_pt_graphics.c',
+  'xen_pt_load_rom.c',
+  'xen_pt_msi.c',
+), if_false: files('xen_pt_stub.c'))
+
+specific_ss.add_all(when: ['CONFIG_XEN', xen], if_true: xen_specific_ss)
diff --git a/meson.build b/meson.build
index acd730ba92..86608e99d4 100644
--- a/meson.build
+++ b/meson.build
@@ -321,6 +321,11 @@ numa = not_found
 if 'CONFIG_NUMA' in config_host
   numa = declare_dependency(link_args: config_host['NUMA_LIBS'].split())
 endif
+xen = not_found
+if 'CONFIG_XEN_BACKEND' in config_host
+  xen = declare_dependency(compile_args: config_host['XEN_CFLAGS'].split(),
+                           link_args: config_host['XEN_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -674,6 +679,7 @@ subdir('migration')
 subdir('monitor')
 subdir('net')
 subdir('replay')
+subdir('hw')
 
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
-- 
2.26.2



