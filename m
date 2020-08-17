Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C28C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D594C205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZ4p5EGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D594C205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gaU-0002Vk-3d
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH6-0004MT-7w
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:45585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH4-00069p-Mq
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:11 -0400
Received: by mail-wr1-x42b.google.com with SMTP id z18so15241906wrm.12
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WQv+f2f0fRtkp8SsmttK9Yb+gdx5W6ZpefDYJCwcG00=;
 b=tZ4p5EGbheOTF5TCOVqXXl/jID1l1hqzMQJ133aRDc+n4TOC9DKp4aE8FQX8wFYJy4
 g9mRuuNbdMEKqRtke2Rbv1pGMQyPt1vPmUqYLX2jSVvyr/EMBm+7ojd5nS7JFQu771Ys
 prYyBfzW9wLpKzQq8zKcMUx5XPHpKJaOGKIJAWHrPqRnj7HCv5Rzsx5FosKbgSS9ql4n
 egTUqbJK5nn1FJjFLqJBPUZxj8K2tcccZiOzu67KeTvFl5KkYREuR3+LaN8rP3GvZZex
 F7cqJTo24vNSDjxz6m10mhSrJId/lYUS0BiTPae+vjJ9C2eqCynm090311pZfX1oSaCg
 /Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WQv+f2f0fRtkp8SsmttK9Yb+gdx5W6ZpefDYJCwcG00=;
 b=uDacXGaDBQrSH40cOzlNcP1ZOxWxFdplVcC+oRFzosY1S0prBRU8uja+mfu/UuTBSL
 P4cir50WWzbcJWNWmuA/quRnFxLClIn1hxN82t55vixm9QiM24u0kOW/m5YrSg8Hs5Yt
 UXxvZLqJKsVX7dQvifG41PMghmpYOGrnPkJlVYdN5GWIq57Z596fda8HaIiI2+vPBjdf
 NF3mgJ2uIcFcz59qrvebFkSYSFl9OQMvyJFXjx/4ECh1DGKYAzyoSFccaU4F9qRhUhxA
 Dr12MfYkgBh/b0mGZulbBNmJ36MUq58Gs2bgZCdQfLToyEI4fx4knZsldnNtt5asmK0v
 SxzA==
X-Gm-Message-State: AOAM5322LZTLQI6BdyGuKWF6yAD37Xxb8ayq7xrRsjei2qQnm1YiijvV
 05yPc89bL/CfW3AXMfOkO/etZoEXhVg=
X-Google-Smtp-Source: ABdhPJzblm9nqdOH4C7NxgrIySNpesrVAFZm5LvfKipaX5gp750rKJi/3W4gi7dIYhjpsuQSDA/wcg==
X-Received: by 2002:adf:e647:: with SMTP id b7mr16943865wrn.220.1597675089228; 
 Mon, 17 Aug 2020 07:38:09 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 044/150] meson: add qemu-keymap
Date: Mon, 17 Aug 2020 16:35:37 +0200
Message-Id: <20200817143723.343284-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42b.google.com
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
 Makefile    |  5 -----
 configure   |  4 +---
 meson.build | 10 ++++++++++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index cbd5bd1a87..60dec5d0ff 100644
--- a/Makefile
+++ b/Makefile
@@ -418,8 +418,6 @@ qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(chardev-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y) $(COMMON_LDADDS)
 
-qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
-
 qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)
 
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
@@ -432,9 +430,6 @@ endif
 qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
-qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
-qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/configure b/configure
index a58d049d13..919f0413fa 100755
--- a/configure
+++ b/configure
@@ -6703,9 +6703,6 @@ if test "$softmmu" = yes ; then
     fi
     mpath=no
   fi
-  if test "$xkbcommon" = "yes"; then
-    tools="qemu-keymap\$(EXESUF) $tools"
-  fi
 fi
 
 # Probe for guest agent support/options
@@ -7022,6 +7019,7 @@ if test "$vnc_png" = "yes" ; then
   echo "CONFIG_VNC_PNG=y" >> $config_host_mak
 fi
 if test "$xkbcommon" = "yes" ; then
+  echo "CONFIG_XKBCOMMON=y" >> $config_host_mak
   echo "XKBCOMMON_CFLAGS=$xkbcommon_cflags" >> $config_host_mak
   echo "XKBCOMMON_LIBS=$xkbcommon_libs" >> $config_host_mak
 fi
diff --git a/meson.build b/meson.build
index 8c05db2cb6..fc65f01b6f 100644
--- a/meson.build
+++ b/meson.build
@@ -107,6 +107,11 @@ libcap_ng = not_found
 if 'CONFIG_LIBCAP_NG' in config_host
   libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
 endif
+xkbcommon = not_found
+if 'CONFIG_XKBCOMMON' in config_host
+  xkbcommon = declare_dependency(compile_args: config_host['XKBCOMMON_CFLAGS'].split(),
+                                 link_args: config_host['XKBCOMMON_LIBS'].split())
+endif
 rt = cc.find_library('rt', required: false)
 libiscsi = not_found
 if 'CONFIG_LIBISCSI' in config_host
@@ -301,6 +306,11 @@ if have_tools
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
+  if 'CONFIG_XKBCOMMON' in config_host
+    executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c'),
+               dependencies: [qemuutil, xkbcommon], install: true)
+  endif
+
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
-- 
2.26.2



