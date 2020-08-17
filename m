Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99183C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BAD204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lid5JGJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BAD204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gUX-0005fz-GX
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGy-0004Fb-8Q
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:39412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGw-000680-E5
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:03 -0400
Received: by mail-wm1-x335.google.com with SMTP id g75so14082096wme.4
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dZwHbdO9HxehKFQePTOuC1KMP4DvkmrbQ/M7cw7Pcco=;
 b=Lid5JGJCu1pzO9Wxc4Vks3zGW6bw0qa+DikxWx8d4RoCRLrX3lZM3f1FRdxR6D5uKG
 Nk2Dn6ascuvSj/e6R7+f2cGOoPDAGPFpQIblXmO13X1xfFmaxBlSuqmfeVQ/Wa8H69Pw
 Y0uNqLULSEM+qIjQlF0dgYk88P4rG69oplEpg2875oeLsI+Joy2ApfmPXb2C09nku9kH
 CfTmzAVoqdqH3jJm/U0Y6QLj611DkO2qMqHj5lvBDhq3K3w6ELb8U/peN+d0lPFYKqI/
 Z50CZeSK4mIje5th6ZTirkE0dDhZEVY298nYUG4zBs5N09bZgBT3jQzp7/Ar687h4S98
 7oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dZwHbdO9HxehKFQePTOuC1KMP4DvkmrbQ/M7cw7Pcco=;
 b=ZVmXx7HKZDIw2DDQpnB3qBovjUd1Ex3ak0cJL4g9zds2Lv1Z9a43PRr2DgrMRN3e4T
 /jj6CepnvfnzkEmVsDOJkuFef3Pyl2SUay98QgWRyi0j+DVpdQxYSFJ0S34cqpu9Pqm3
 RFC5YGClmQen5AlsRqMjTi0Q3s2MtqgFifdrQkGPqCocQHobS57VYqLRD32K86iz8SK5
 cs0m47UyRHlMPB0y0sOklaEvQTHsOYrFTCqIr4nPYIhiXd9Nwu7A6paDd5DpcKa7g9zz
 FJ+D8+LoNtGiTWNiRPgeOuX/6ZZVuiiYG3XOy2PqSqFFvScw08GUGb5b6qJA0nihfzE0
 XKcQ==
X-Gm-Message-State: AOAM533YdM5+CM66RjFDe6gmqk12cPvazDe2pUz0HPfNcQIihYln8kUr
 mwYqVIH5zq4y+Kwx7l5llGKcNT3GWBg=
X-Google-Smtp-Source: ABdhPJxp1iJhjqOPd9x39Ntcfz+R/dOKnh0qwQfZoLhl0ncqByOUC7NU2KTVMViuJknI7DXQN/sHJw==
X-Received: by 2002:a1c:f30f:: with SMTP id q15mr14686124wmq.60.1597675080295; 
 Mon, 17 Aug 2020 07:38:00 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 034/150] contrib/vhost-user-gpu: convert to meson
Date: Mon, 17 Aug 2020 16:35:27 +0200
Message-Id: <20200817143723.343284-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x335.google.com
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
 Makefile                             | 18 +-----------------
 Makefile.objs                        |  1 -
 contrib/vhost-user-gpu/Makefile.objs | 10 ----------
 contrib/vhost-user-gpu/meson.build   | 13 +++++++++++++
 meson.build                          | 15 +++++++++++++++
 rules.mak                            |  7 -------
 6 files changed, 29 insertions(+), 35 deletions(-)
 delete mode 100644 contrib/vhost-user-gpu/Makefile.objs
 create mode 100644 contrib/vhost-user-gpu/meson.build

diff --git a/Makefile b/Makefile
index d02910b073..44626d6a80 100644
--- a/Makefile
+++ b/Makefile
@@ -184,16 +184,10 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-vhost-user-json-y =
 HELPERS-y = $(HELPERS)
 
 HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) += qemu-bridge-helper$(EXESUF)
 
-ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
-HELPERS-y += vhost-user-gpu$(EXESUF)
-vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
-endif
-
 # Sphinx does not allow building manuals into the same directory as
 # the source files, so if we're doing an in-tree QEMU build we must
 # build the manuals into a subdirectory (and then install them from
@@ -300,7 +294,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -314,7 +307,7 @@ dummy := $(call unnest-vars,, \
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules $(vhost-user-json-y)
+all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
 
 qemu-version.h: FORCE
 	$(call quiet-command, \
@@ -520,9 +513,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
 
-vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
@@ -720,12 +710,6 @@ endif
 ifneq ($(HELPERS-y),)
 	$(call install-prog,$(HELPERS-y),$(DESTDIR)$(libexecdir))
 endif
-ifneq ($(vhost-user-json-y),)
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/vhost-user/"
-	for x in $(vhost-user-json-y); do \
-		$(INSTALL_DATA) $$x "$(DESTDIR)$(qemu_datadir)/vhost-user/"; \
-	done
-endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
 endif
diff --git a/Makefile.objs b/Makefile.objs
index 0922c3ed00..2f2d4b2066 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -106,6 +106,5 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
 
 ######################################################################
diff --git a/contrib/vhost-user-gpu/Makefile.objs b/contrib/vhost-user-gpu/Makefile.objs
deleted file mode 100644
index 09296091be..0000000000
--- a/contrib/vhost-user-gpu/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-vhost-user-gpu-obj-y = vhost-user-gpu.o virgl.o vugbm.o
-
-vhost-user-gpu.o-cflags := $(PIXMAN_CFLAGS) $(GBM_CFLAGS)
-vhost-user-gpu.o-libs := $(PIXMAN_LIBS)
-
-virgl.o-cflags := $(VIRGL_CFLAGS) $(GBM_CFLAGS)
-virgl.o-libs := $(VIRGL_LIBS)
-
-vugbm.o-cflags := $(GBM_CFLAGS)
-vugbm.o-libs := $(GBM_LIBS)
diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gpu/meson.build
new file mode 100644
index 0000000000..6c1459f54a
--- /dev/null
+++ b/contrib/vhost-user-gpu/meson.build
@@ -0,0 +1,13 @@
+if 'CONFIG_TOOLS' in config_host and 'CONFIG_VIRGL' in config_host \
+    and 'CONFIG_GBM' in config_host and 'CONFIG_LINUX' in config_host
+  executable('vhost-user-gpu', files('vhost-user-gpu.c', 'virgl.c', 'vugbm.c'),
+             link_with: libvhost_user,
+             dependencies: [qemuutil, pixman, gbm, virgl],
+             install: true,
+             install_dir: get_option('libexecdir'))
+
+  configure_file(input: '50-qemu-gpu.json.in',
+                 output: '50-qemu-gpu.json',
+                 configuration: config_host,
+                 install_dir: config_host['qemu_datadir'] / 'vhost-user')
+endif
diff --git a/meson.build b/meson.build
index a8c22b20e5..6f17032e95 100644
--- a/meson.build
+++ b/meson.build
@@ -79,6 +79,8 @@ if 'CONFIG_GNUTLS' in config_host
   gnutls = declare_dependency(compile_args: config_host['GNUTLS_CFLAGS'].split(),
                               link_args: config_host['GNUTLS_LIBS'].split())
 endif
+pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
+                            link_args: config_host['PIXMAN_LIBS'].split())
 seccomp = not_found
 if 'CONFIG_SECCOMP' in config_host
   seccomp = declare_dependency(compile_args: config_host['SECCOMP_CFLAGS'].split(),
@@ -93,6 +95,16 @@ if 'CONFIG_LIBISCSI' in config_host
   libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
                                 link_args: config_host['LIBISCSI_LIBS'].split())
 endif
+gbm = not_found
+if 'CONFIG_GBM' in config_host
+  gbm = declare_dependency(compile_args: config_host['GBM_CFLAGS'].split(),
+                           link_args: config_host['GBM_LIBS'].split())
+endif
+virgl = not_found
+if 'CONFIG_VIRGL' in config_host
+  virgl = declare_dependency(compile_args: config_host['VIRGL_CFLAGS'].split(),
+                             link_args: config_host['VIRGL_LIBS'].split())
+endif
 
 target_dirs = config_host['TARGET_DIRS'].split()
 have_user = false
@@ -261,6 +273,9 @@ if have_tools
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
+    if 'CONFIG_LINUX' in config_host
+      subdir('contrib/vhost-user-gpu')
+    endif
     subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
   endif
diff --git a/rules.mak b/rules.mak
index 7aefd37b5d..1aa6394079 100644
--- a/rules.mak
+++ b/rules.mak
@@ -402,13 +402,6 @@ TEXI2MAN = $(call quiet-command, \
 %.8:
 	$(call TEXI2MAN)
 
-GEN_SUBST = $(call quiet-command, \
-	sed -e "s!@libexecdir@!$(libexecdir)!g" < $< > $@, \
-	"GEN","$@")
-
-%.json: %.json.in
-	$(call GEN_SUBST)
-
 # Support for building multiple output files by atomically executing
 # a single rule which depends on several input files (so the rule
 # will be executed exactly once, not once per output file, and
-- 
2.26.2



