Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EB1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E79205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVswz6wK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E79205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gXt-000431-Tz
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGz-0004Fq-Iy
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:05 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:44463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGw-00068G-QU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:04 -0400
Received: by mail-wr1-x430.google.com with SMTP id c15so15228119wrs.11
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X2aYUPZOuivizIkGDiyJMkoYliOGwJAaeVDJ2ojEhe8=;
 b=bVswz6wKcE4YAIFF6Yc81IWwlfAlG4eyV+9n/nUk7SODNAynyrJk9dFQ86rwH0lfFV
 HUbgj9ePXUzUAl+ruys306SarCPHav+6hL4GwNNoV1DN/NuPo/IuxelWIC5q9RXequv+
 13j0XQlItpRytvgjlkZILkcOR0JwAXJguDtFVYRz3yjqGos8EXTGWzjvx/S2mEervkvv
 KX4sNAlEpPbhSZ6E2igST2OADxz6Y5henF89y+6PB/iOK1QC54x5SWoUd8NSFgNOafqx
 uvyryh5ho0ELPwemlnh2duq3BGPxcjl06xteu87h/+6a8LBDbIDDCcue5YbO7rEKxdlX
 eh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=X2aYUPZOuivizIkGDiyJMkoYliOGwJAaeVDJ2ojEhe8=;
 b=PWxo45Rj7OgLTD6IH7l8C1yyo0RgwSVRwroH+bsRKIy6UVXtsjRa0AG7FM1faAqZa8
 SlqbjMSW/q1Djtu7W8j8Ak5Sel1N8S4qPVJE0OySXUogswJoFfR3vUxmmGlza61aB+P8
 Ed6Uelcbg1hSUViISEIwUl/KznxcwaL6/BOMG6nGUTF1il7x+qL1tR7rzz+5VNv99Eq6
 sU2iGhFFW+sus0eS8XWEE3SdL4pfrQQuv5U+DTgH+j2v0v/i9EEhgfq8xhAKYA32LirI
 zQjqW78CA2bR4l5qlRc4I7GPr+aOLIg7XAVblZ2BkVq40n/LXS7gilD43BoSn/yfYa6i
 2iHQ==
X-Gm-Message-State: AOAM531MFE9IAxtD0HPqXxD1Pgp433HClpDqz1GTiKRT7dIQ+7Ggwysd
 x52jJvznazO4658n4A3vMyNc7qUqd5c=
X-Google-Smtp-Source: ABdhPJw4LiTQTybu+v1rpkFKUhILFk9bDBWoHmLsLxRlWynvwHJpaOJ2asGpdwBhFHt2ieUUtXbeGA==
X-Received: by 2002:a5d:440e:: with SMTP id z14mr15502213wrq.422.1597675081258; 
 Mon, 17 Aug 2020 07:38:01 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 035/150] contrib/ivshmem: convert to meson
Date: Mon, 17 Aug 2020 16:35:28 +0200
Message-Id: <20200817143723.343284-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x430.google.com
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
 Makefile                             | 9 ---------
 Makefile.objs                        | 2 --
 configure                            | 3 ---
 contrib/ivshmem-client/Makefile.objs | 1 -
 contrib/ivshmem-client/meson.build   | 4 ++++
 contrib/ivshmem-server/Makefile.objs | 1 -
 contrib/ivshmem-server/meson.build   | 4 ++++
 meson.build                          | 5 +++++
 8 files changed, 13 insertions(+), 16 deletions(-)
 delete mode 100644 contrib/ivshmem-client/Makefile.objs
 create mode 100644 contrib/ivshmem-client/meson.build
 delete mode 100644 contrib/ivshmem-server/Makefile.objs
 create mode 100644 contrib/ivshmem-server/meson.build

diff --git a/Makefile b/Makefile
index 44626d6a80..0cc478b2f1 100644
--- a/Makefile
+++ b/Makefile
@@ -292,8 +292,6 @@ dummy := $(call unnest-vars,, \
                 chardev-obj-y \
                 qga-obj-y \
                 elf2dmp-obj-y \
-                ivshmem-client-obj-y \
-                ivshmem-server-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -506,13 +504,6 @@ endif
 elf2dmp$(EXESUF): $(elf2dmp-obj-y)
 	$(call LINK, $^)
 
-ifdef CONFIG_IVSHMEM
-ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-endif
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/Makefile.objs b/Makefile.objs
index 2f2d4b2066..336a684ff3 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -104,7 +104,5 @@ qga-vss-dll-obj-y = qga/
 ######################################################################
 # contrib
 elf2dmp-obj-y = contrib/elf2dmp/
-ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
-ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
 
 ######################################################################
diff --git a/configure b/configure
index 9582ecdf02..b6237f8102 100755
--- a/configure
+++ b/configure
@@ -6680,9 +6680,6 @@ if test "$want_tools" = "yes" ; then
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) qemu-storage-daemon\$(EXESUF) $tools"
   fi
-  if [ "$ivshmem" = "yes" ]; then
-    tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
-  fi
   if [ "$curl" = "yes" ]; then
       tools="elf2dmp\$(EXESUF) $tools"
   fi
diff --git a/contrib/ivshmem-client/Makefile.objs b/contrib/ivshmem-client/Makefile.objs
deleted file mode 100644
index bfab2d20dd..0000000000
--- a/contrib/ivshmem-client/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-ivshmem-client-obj-y = ivshmem-client.o main.o
diff --git a/contrib/ivshmem-client/meson.build b/contrib/ivshmem-client/meson.build
new file mode 100644
index 0000000000..1b171efb4f
--- /dev/null
+++ b/contrib/ivshmem-client/meson.build
@@ -0,0 +1,4 @@
+executable('ivshmem-client', files('ivshmem-client.c', 'main.c'),
+           dependencies: glib,
+           build_by_default: targetos == 'linux',
+           install: false)
diff --git a/contrib/ivshmem-server/Makefile.objs b/contrib/ivshmem-server/Makefile.objs
deleted file mode 100644
index c060dd3698..0000000000
--- a/contrib/ivshmem-server/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-ivshmem-server-obj-y = ivshmem-server.o main.o
diff --git a/contrib/ivshmem-server/meson.build b/contrib/ivshmem-server/meson.build
new file mode 100644
index 0000000000..3a53942201
--- /dev/null
+++ b/contrib/ivshmem-server/meson.build
@@ -0,0 +1,4 @@
+executable('ivshmem-server', files('ivshmem-server.c', 'main.c'),
+           dependencies: [qemuutil, rt],
+           build_by_default: targetos == 'linux',
+           install: false)
diff --git a/meson.build b/meson.build
index 6f17032e95..0814ec3e62 100644
--- a/meson.build
+++ b/meson.build
@@ -90,6 +90,7 @@ libcap_ng = not_found
 if 'CONFIG_LIBCAP_NG' in config_host
   libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
 endif
+rt = cc.find_library('rt', required: false)
 libiscsi = not_found
 if 'CONFIG_LIBISCSI' in config_host
   libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
@@ -279,6 +280,10 @@ if have_tools
     subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
   endif
+  if 'CONFIG_IVSHMEM' in config_host
+    subdir('contrib/ivshmem-client')
+    subdir('contrib/ivshmem-server')
+  endif
 endif
 
 subdir('tools')
-- 
2.26.2



