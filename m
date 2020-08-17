Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB07C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0242522BEB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5WQ4A9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0242522BEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hFo-00041v-16
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gLC-0003dn-Sy
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:42:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23069
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gL8-0006vr-SC
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LvymUVZshpWhdrmlfGlQijeyhUn+w1f5RXfbWUnQhVw=;
 b=K5WQ4A9MByrbhaGhLvXaQpzamUt5YaB+AatX1Q7atXF+CoL3xqHlKNMEErRyCGHEOJK8R7
 yHEcn00e19uK33o6xOft2FNh4mrr49ELS98tAI9V4yaySQhLkacSeCmuZuScBLuIwfvJm6
 iLvPtP6nKW/JvJH8JtWnEwXmMxWFH9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-86g-t1gQM_WVX2NtTdpOaQ-1; Mon, 17 Aug 2020 10:42:20 -0400
X-MC-Unique: 86g-t1gQM_WVX2NtTdpOaQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64082185E524
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:42:19 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC86670C3D;
 Mon, 17 Aug 2020 14:42:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 136/150] remove Makefile.target
Date: Mon, 17 Aug 2020 16:40:39 +0200
Message-Id: <20200817144053.345107-41-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:24:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Makefile        | 53 ++++---------------------------------------------
 Makefile.target | 12 -----------
 configure       | 17 ----------------
 3 files changed, 4 insertions(+), 78 deletions(-)
 delete mode 100644 Makefile.target

diff --git a/Makefile b/Makefile
index e6ede40f51..175776d912 100644
--- a/Makefile
+++ b/Makefile
@@ -168,17 +168,6 @@ include $(SRC_PATH)/tests/Makefile.include
 
 all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) recurse-all modules
 
-config-host.h: config-host.h-timestamp
-config-host.h-timestamp: config-host.mak
-
-TARGET_DIRS_RULES := $(foreach t, all fuzz clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
-
-.PHONY: $(TARGET_DIRS_RULES)
-# The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
-# $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub-goal
-$(TARGET_DIRS_RULES): $(TARGET_DEPS)
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
-
 # LIBFDT_lib="": avoid breaking existing trees with objects requiring -fPIC
 DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_lib=""
 DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
@@ -215,8 +204,6 @@ slirp/all: .git-submodule-status
 		CC="$(CC)" AR="$(AR)" 	LD="$(LD)" RANLIB="$(RANLIB)"	\
 		CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)")
 
-$(filter %/all, $(TARGET_DIRS_RULES)):
-
 ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 # Only keep -O and -g cflags
@@ -224,11 +211,9 @@ ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 $(ROM_DIRS_RULES):
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" CFLAGS="$(filter -O% -g%,$(CFLAGS))" $(notdir $@),)
 
-.PHONY: recurse-all recurse-clean recurse-install
-recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
-recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
-recurse-install: $(addsuffix /install, $(TARGET_DIRS))
-$(addsuffix /install, $(TARGET_DIRS)): all
+.PHONY: recurse-all recurse-clean
+recurse-all: $(ROM_DIRS)
+recurse-clean: $(addsuffix /clean, $(ROM_DIRS))
 
 ######################################################################
 
@@ -283,9 +268,6 @@ distclean: clean ninja-distclean
 	$(call clean-manual,system)
 	$(call clean-manual,tools)
 	$(call clean-manual,user)
-	for d in $(TARGET_DIRS); do \
-	rm -rf $$d || exit 1 ; \
-        done
 	rm -Rf .sdk
 
 KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv \
@@ -389,8 +371,7 @@ ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 # Needed by "meson install"
 export DESTDIR
 install: all $(if $(BUILD_DOCS),install-doc) \
-	install-datadir install-localstatedir \
-	recurse-install
+	install-datadir install-localstatedir
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
 endif
@@ -420,9 +401,6 @@ endif
 	set -e; for x in $(KEYMAPS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
 	done
-	for d in $(TARGET_DIRS); do \
-	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
-        done
 
 # documentation
 MAKEINFO=makeinfo
@@ -537,20 +515,6 @@ docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-ref.html \
 
 $(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
 
-# Reports/Analysis
-
-%/coverage-report.html:
-	@mkdir -p $*
-	$(call quiet-command,\
-		gcovr -r $(SRC_PATH) \
-		$(foreach t, $(TARGET_DIRS), --object-directory $(BUILD_DIR)/$(t)) \
-		 --object-directory $(BUILD_DIR) \
-		-p --html --html-details -o $@, \
-		"GEN", "coverage-report.html")
-
-.PHONY: coverage-report
-coverage-report: $(CURDIR)/reports/coverage/coverage-report.html
-
 ifdef CONFIG_WIN32
 
 INSTALLER = qemu-setup-$(VERSION)$(EXESUF)
@@ -638,15 +602,6 @@ endif
 	$(call print-help,cscope,Generate cscope index)
 	$(call print-help,sparse,Run sparse on the QEMU source)
 	@echo  ''
-	@$(if $(TARGET_DIRS), \
-		echo 'Architecture specific targets:'; \
-		$(foreach t, $(TARGET_DIRS), \
-		$(call print-help-run,$(t)/all,Build for $(t)); \
-		$(if $(CONFIG_FUZZ), \
-			$(if $(findstring softmmu,$(t)), \
-				$(call print-help-run,$(t)/fuzz,Build fuzzer for $(t)); \
-		))) \
-		echo '')
 	@echo  'Cleaning targets:'
 	$(call print-help,clean,Remove most generated files but keep the config)
 	$(call print-help,distclean,Remove all generated files)
diff --git a/Makefile.target b/Makefile.target
deleted file mode 100644
index a07149c0a6..0000000000
--- a/Makefile.target
+++ /dev/null
@@ -1,12 +0,0 @@
-# -*- Mode: makefile -*-
-
-BUILD_DIR?=$(CURDIR)/..
-
-include ../config-host.mak
-include config-target.mak
-include $(SRC_PATH)/rules.mak
-
-all:
-install: all
-	
-.PHONY: all clean install
diff --git a/configure b/configure
index 94e458f4be..840a90d987 100755
--- a/configure
+++ b/configure
@@ -316,7 +316,6 @@ audio_drv_list=""
 block_drv_rw_whitelist=""
 block_drv_ro_whitelist=""
 host_cc="cc"
-libs_softmmu=""
 libs_tools=""
 audio_win_int=""
 libs_qga=""
@@ -864,7 +863,6 @@ Darwin)
   audio_drv_list="coreaudio try-sdl"
   audio_possible_drivers="coreaudio sdl"
   QEMU_LDFLAGS="-framework CoreFoundation -framework IOKit $QEMU_LDFLAGS"
-  libs_softmmu="-F/System/Library/Frameworks -framework Cocoa -framework IOKit $libs_softmmu"
   # Disable attempts to use ObjectiveC features in os/object.h since they
   # won't work when we're compiling with gcc as a C compiler.
   QEMU_CFLAGS="-DOS_OBJECT_USE_OBJC=0 $QEMU_CFLAGS"
@@ -2555,7 +2553,6 @@ if test "$lzo" != "no" ; then
 int main(void) { lzo_version(); return 0; }
 EOF
     if compile_prog "" "-llzo2" ; then
-        libs_softmmu="$libs_softmmu -llzo2"
         lzo_libs="-llzo2"
         lzo="yes"
     else
@@ -2575,7 +2572,6 @@ if test "$snappy" != "no" ; then
 int main(void) { snappy_max_compressed_length(4096); return 0; }
 EOF
     if compile_prog "" "-lsnappy" ; then
-        libs_softmmu="$libs_softmmu -lsnappy"
         snappy_libs='-lsnappy'
         snappy="yes"
     else
@@ -2675,7 +2671,6 @@ if test "$xen" != "no" ; then
       xen_pc="$xen_pc xentoolcore"
     fi
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
-    libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
     xen_cflags="$($pkg_config --cflags $xen_pc)"
     xen_libs="$($pkg_config --libs $xen_pc)"
   else
@@ -3420,7 +3415,6 @@ EOF
   rdma_libs="-lrdmacm -libverbs -libumad"
   if compile_prog "" "$rdma_libs" ; then
     rdma="yes"
-    libs_softmmu="$libs_softmmu $rdma_libs"
   else
     if test "$rdma" = "yes" ; then
         error_exit \
@@ -4451,8 +4445,6 @@ EOF
   fi
 fi
 
-libs_softmmu="$libs_softmmu $fdt_libs"
-
 ##########################################
 # opengl probe (for sdl2, gtk, milkymist-tmu2)
 
@@ -4676,7 +4668,6 @@ EOF
 
   if compile_prog "" "-lnuma" ; then
     numa=yes
-    libs_softmmu="-lnuma $libs_softmmu"
     numa_libs="-lnuma"
   else
     if test "$numa" = "yes" ; then
@@ -5218,7 +5209,6 @@ if compile_prog "" "" ; then
   have_openpty="yes"
 else
   if compile_prog "" "-lutil" ; then
-    libs_softmmu="-lutil $libs_softmmu"
     libs_tools="-lutil $libs_tools"
     have_openpty="yes"
   fi
@@ -5237,7 +5227,6 @@ EOF
      $pkg_config --atleast-version=0.12.3 spice-protocol && \
      compile_prog "$spice_cflags" "$spice_libs" ; then
     spice="yes"
-    libs_softmmu="$libs_softmmu $spice_libs"
     QEMU_CFLAGS="$QEMU_CFLAGS $spice_cflags"
   else
     if test "$spice" = "yes" ; then
@@ -6390,7 +6379,6 @@ if test "$libpmem" != "no"; then
 		libpmem="yes"
 		libpmem_libs=$($pkg_config --libs libpmem)
 		libpmem_cflags=$($pkg_config --cflags libpmem)
-		libs_softmmu="$libs_softmmu $libpmem_libs"
 		QEMU_CFLAGS="$QEMU_CFLAGS $libpmem_cflags"
 	else
 		if test "$libpmem" = "yes" ; then
@@ -6408,7 +6396,6 @@ if test "$libdaxctl" != "no"; then
 		libdaxctl="yes"
 		libdaxctl_libs=$($pkg_config --libs libdaxctl)
 		libdaxctl_cflags=$($pkg_config --cflags libdaxctl)
-		libs_softmmu="$libs_softmmu $libdaxctl_libs"
 		QEMU_CFLAGS="$QEMU_CFLAGS $libdaxctl_cflags"
 	else
 		if test "$libdaxctl" = "yes" ; then
@@ -6837,7 +6824,6 @@ echo_version() {
 # prepend pixman and ftd flags after all config tests are done
 QEMU_CFLAGS="$pixman_cflags $fdt_cflags $QEMU_CFLAGS"
 QEMU_LDFLAGS="$fdt_ldflags $QEMU_LDFLAGS"
-libs_softmmu="$pixman_libs $libs_softmmu"
 
 config_host_mak="config-host.mak"
 
@@ -6866,7 +6852,6 @@ echo "qemu_helperdir=$libexecdir" >> $config_host_mak
 echo "qemu_localedir=$qemu_localedir" >> $config_host_mak
 echo "qemu_icondir=$qemu_icondir" >> $config_host_mak
 echo "qemu_desktopdir=$qemu_desktopdir" >> $config_host_mak
-echo "libs_softmmu=$libs_softmmu" >> $config_host_mak
 echo "GIT=$git" >> $config_host_mak
 echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
 echo "GIT_UPDATE=$git_update" >> $config_host_mak
@@ -8117,8 +8102,6 @@ if [ "$TARGET_SYSTBL_ABI" != "" ] && [ "$TARGET_SYSTBL" = "" ]; then
   TARGET_SYSTBL=syscall.tbl
 fi
 
-symlink "$source_path/Makefile.target" "$target_dir/Makefile"
-
 upper() {
     echo "$@"| LC_ALL=C tr '[a-z]' '[A-Z]'
 }
-- 
2.26.2



