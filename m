Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5F1C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5F421655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEYvPCvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5F421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOKM-0004ck-BO
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy9-000390-7B
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy7-0006HG-Pi
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:25 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNy7-0006FV-HS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:23 -0500
Received: by mail-wr1-x443.google.com with SMTP id b6so2659160wrq.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zcm+dNIQfsuLlzTia26mC9LJPo0t1Xzlic84x4r+w0g=;
 b=oEYvPCvVE8ljiT9/yFJBQ8y2expcIlzQsSCZ2Ia8hLIKXP6nkuf6WfocLehB7IPZJV
 DCZqsQF4kKGIX1E1pAbPs3L2NmhWKrhCa+oXS4T+c2nrwEkgJ8/Ayo19q/FnppASjw7P
 CjOxoBJNrEoCmZTUyFdPoJTsTGmgK8ZYG81D/ezHspfgcL/tOLSwX6nISo7ymMxAQjGM
 5LvgjNEBGRPCIJAggPrM6jsEUUf5j19M33fx1ejeRSt27nsaAdexoD9w77gFZwOxKR10
 T30YSFUX3y/k3HvBzNmNlHOC/fKC4brbX4m3rD8VNLijnPG5tchprglP59n0nugN2PUe
 qLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Zcm+dNIQfsuLlzTia26mC9LJPo0t1Xzlic84x4r+w0g=;
 b=FLiawNnZl+7zrvlCpocHAYB4c/dMPxXVhSvJPMeRxcX1BCSRnMxFkeW8mM+nZ1x+I0
 NkbAYVb3JHMRBRs4qNv+rSdRsGQ0HIaYV2uj/1kDSa65zZbziYXTIPpKZK9dAMhuMChI
 my6IoCcf1tjxIqG/4tg9K4UAKFg/r/KXBGFGH+CiSkGlijyU7pyOFDWLqZ49jl0ZB2Pv
 M3G6QMqkCce7Dbhryb+unHVwdT3Od1EC6TX6kWxdPdNP8BR7Fk7EY/deP+iPK5XeWyRv
 JsmpvlPgsae1P+ttRW5S1EsZCRcCOZ1B7GYKtWVqYH8polsg+IcGud2EVHxXad/e7prI
 9Vag==
X-Gm-Message-State: APjAAAU8wmsMjB/iOSwfkQG6ecqEb2GUDmEzyeMa/CsoajxsN6QH0078
 6fF3n1bOPsaCr5Unt1aUHym7LZu3
X-Google-Smtp-Source: APXvYqwsSoMA2sIWOQcrwmRpotHSo4tMRRSb5l9tgAIaXHt1OEMedrKLaBGiOVIJXwdqUtquclivgQ==
X-Received: by 2002:adf:f288:: with SMTP id k8mr6536769wro.301.1576155202277; 
 Thu, 12 Dec 2019 04:53:22 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 024/132] meson: add qemu-keymap
Date: Thu, 12 Dec 2019 13:51:08 +0100
Message-Id: <1576155176-2464-25-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Makefile    |  5 -----
 configure   | 24 ------------------------
 meson.build |  6 ++++++
 3 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index d153186..fe4df0d 100644
--- a/Makefile
+++ b/Makefile
@@ -372,8 +372,6 @@ qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 
-qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
-
 qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)
 
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
@@ -387,9 +385,6 @@ endif
 qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
-qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
-qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
-
 ifneq ($(EXESUF),)
 .PHONY: qga/qemu-ga
 qga/qemu-ga: qga/qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
diff --git a/configure b/configure
index 9615d63..d05c0de 100755
--- a/configure
+++ b/configure
@@ -385,7 +385,6 @@ vde=""
 vnc_sasl=""
 vnc_jpeg=""
 vnc_png=""
-xkbcommon=""
 xen=""
 xen_ctrl_version=""
 xen_pci_passthrough=""
@@ -3292,22 +3291,6 @@ EOF
 fi
 
 ##########################################
-# xkbcommon probe
-if test "$xkbcommon" != "no" ; then
-  if $pkg_config xkbcommon --exists; then
-    xkbcommon_cflags=$($pkg_config xkbcommon --cflags)
-    xkbcommon_libs=$($pkg_config xkbcommon --libs)
-    xkbcommon=yes
-  else
-    if test "$xkbcommon" = "yes" ; then
-      feature_not_found "xkbcommon" "Install libxkbcommon-devel"
-    fi
-    xkbcommon=no
-  fi
-fi
-
-
-##########################################
 # xfsctl() probe, used for file-posix.c
 if test "$xfs" != "no" ; then
   cat > $TMPC << EOF
@@ -6093,9 +6076,6 @@ if test "$softmmu" = yes ; then
     fi
     mpath=no
   fi
-  if test "$xkbcommon" = "yes"; then
-    tools="qemu-keymap\$(EXESUF) $tools"
-  fi
 fi
 
 # Probe for guest agent support/options
@@ -6640,10 +6620,6 @@ fi
 if test "$vnc_png" = "yes" ; then
   echo "CONFIG_VNC_PNG=y" >> $config_host_mak
 fi
-if test "$xkbcommon" = "yes" ; then
-  echo "XKBCOMMON_CFLAGS=$xkbcommon_cflags" >> $config_host_mak
-  echo "XKBCOMMON_LIBS=$xkbcommon_libs" >> $config_host_mak
-fi
 if test "$xfs" = "yes" ; then
   echo "CONFIG_XFS=y" >> $config_host_mak
 fi
diff --git a/meson.build b/meson.build
index 854b1cb..14a8a9a 100644
--- a/meson.build
+++ b/meson.build
@@ -60,6 +60,7 @@ libcap_ng = declare_dependency()
 if 'CONFIG_LIBCAP_NG' in config_host
   libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
 endif
+xkbcommon = dependency('xkbcommon', required: false)
 rt = cc.find_library('rt', required: false)
 libiscsi = declare_dependency()
 if 'CONFIG_LIBISCSI' in config_host
@@ -228,6 +229,11 @@ if have_tools
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
+  if xkbcommon.found()
+    executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c'),
+               dependencies: [qemuutil, xkbcommon], install: true)
+  endif
+
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
-- 
1.8.3.1



