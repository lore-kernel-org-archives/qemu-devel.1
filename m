Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7709FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D2D206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xflu7zCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D2D206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WoE-00058c-EJ
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VoE-0000RK-Iw
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22374
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vo5-0003Kl-Ch
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZGVOku/ZtwNMG/Y3T0BZ78NZd0WWVwcAP0LZQk6wcY=;
 b=Xflu7zCsVuMDqAMnNd0109jRxLll0mVUxfjI2IZpTbqKlshyJLM8O5JFi3hg3KB2A3u8ii
 OzI8W00kuGwxBg473xeKcy1dvMZb/JDFpj3EQgCRVCCFHtBxGf546kfUgDo4typNMwctvv
 Z2l/BHlqH2SpafsK9CZjpKDR0jPHwzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-Giv6aN0GMsmjHlFxW9Rxzg-1; Fri, 14 Aug 2020 05:15:14 -0400
X-MC-Unique: Giv6aN0GMsmjHlFxW9Rxzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C7D11005E5A
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:15:14 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF4CA5C1BD
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:15:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 142/150] rules.mak: drop unneeded macros
Date: Fri, 14 Aug 2020 05:13:18 -0400
Message-Id: <20200814091326.16173-143-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 01:57:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore                  |   1 -
 Makefile                    |   7 +-
 configure                   |  55 ++-------
 docs/devel/build-system.txt |   5 +-
 rules.mak                   | 231 +-----------------------------------
 scripts/create_config       |   6 +-
 6 files changed, 23 insertions(+), 282 deletions(-)

diff --git a/.gitignore b/.gitignore
index f8b3cd6fd5..92311284ef 100644
--- a/.gitignore
+++ b/.gitignore
@@ -78,7 +78,6 @@
 *.msi
 *.dll
 *.so
-*.mo
 *.fn
 *.ky
 *.log
diff --git a/Makefile b/Makefile
index 373dd7286c..fca7d03f76 100644
--- a/Makefile
+++ b/Makefile
@@ -133,7 +133,7 @@ endif
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: recurse-all modules
+all: recurse-all
 
 # LIBFDT_lib="": avoid breaking existing trees with objects requiring -fPIC
 DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_lib=""
@@ -188,7 +188,7 @@ clean: recurse-clean ninja-clean clean-ctlist
 	-test -f ninjatool && ./ninjatool $(if $(V),-v,) -t clean
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
-	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f \
+	find . \( -name '*.so' -o -name '*.dll' -o -name '*.[oda]' \) -type f \
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-aarch64.a \
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
@@ -373,9 +373,6 @@ print-help = $(quiet-@)$(call print-help-run,$1,$2)
 help:
 	@echo  'Generic targets:'
 	$(call print-help,all,Build all)
-ifdef CONFIG_MODULES
-	$(call print-help,modules,Build all modules)
-endif
 	$(call print-help,dir/file.o,Build specified target only)
 	$(call print-help,install,Install QEMU, documentation and tools)
 	$(call print-help,ctags/TAGS,Generate tags file for editors)
diff --git a/configure b/configure
index 9ed1390224..f0bddaa675 100755
--- a/configure
+++ b/configure
@@ -29,7 +29,6 @@ TMPC="${TMPDIR1}/${TMPB}.c"
 TMPO="${TMPDIR1}/${TMPB}.o"
 TMPCXX="${TMPDIR1}/${TMPB}.cxx"
 TMPE="${TMPDIR1}/${TMPB}.exe"
-TMPMO="${TMPDIR1}/${TMPB}.mo"
 TMPTXT="${TMPDIR1}/${TMPB}.txt"
 
 rm -f config.log
@@ -423,7 +422,7 @@ bigendian="no"
 mingw32="no"
 gcov="no"
 EXESUF=""
-DSOSUF=".so"
+HOST_DSOSUF=".so"
 LDFLAGS_SHARED="-shared"
 modules="no"
 module_upgrades="no"
@@ -954,7 +953,7 @@ fi
 
 if test "$mingw32" = "yes" ; then
   EXESUF=".exe"
-  DSOSUF=".dll"
+  HOST_DSOSUF=".dll"
   # MinGW needs -mthreads for TLS and macro _MT.
   QEMU_CFLAGS="-mthreads $QEMU_CFLAGS"
   LIBS="-lwinmm -lws2_32 $LIBS"
@@ -6206,31 +6205,6 @@ EOF
   fi
 fi
 
-#################################################
-# Sparc implicitly links with --relax, which is
-# incompatible with -r, so --no-relax should be
-# given. It does no harm to give it on other
-# platforms too.
-
-# Note: the prototype is needed since QEMU_CFLAGS
-#       contains -Wmissing-prototypes
-cat > $TMPC << EOF
-extern int foo(void);
-int foo(void) { return 0; }
-EOF
-if ! compile_object ""; then
-  error_exit "Failed to compile object file for LD_REL_FLAGS test"
-fi
-for i in '-Wl,-r -Wl,--no-relax' -Wl,-r -r; do
-  if do_cc -nostdlib $i -o $TMPMO $TMPO; then
-    LD_REL_FLAGS=$i
-    break
-  fi
-done
-if test "$modules" = "yes" && test "$LD_REL_FLAGS" = ""; then
-  feature_not_found "modules" "Cannot find how to build relocatable objects"
-fi
-
 ##########################################
 # check for sysmacros.h
 
@@ -6962,12 +6936,7 @@ fi
 echo "CONFIG_AUDIO_DRIVERS=$audio_drv_list" >> $config_host_mak
 for drv in $audio_drv_list; do
     def=CONFIG_AUDIO_$(echo $drv | LC_ALL=C tr '[a-z]' '[A-Z]')
-    case "$drv" in
-	alsa | oss | pa | sdl)
-	    echo "$def=m" >> $config_host_mak ;;
-	*)
-	    echo "$def=y" >> $config_host_mak ;;
-    esac
+    echo "$def=y" >> $config_host_mak
 done
 if test "$alsa" = "yes" ; then
     echo "CONFIG_ALSA=y" >> $config_host_mak
@@ -7056,7 +7025,7 @@ if test "$iconv" = "yes" ; then
   echo "ICONV_LIBS=$iconv_lib" >> $config_host_mak
 fi
 if test "$curses" = "yes" ; then
-  echo "CONFIG_CURSES=m" >> $config_host_mak
+  echo "CONFIG_CURSES=y" >> $config_host_mak
   echo "CURSES_CFLAGS=$curses_inc" >> $config_host_mak
   echo "CURSES_LIBS=$curses_lib" >> $config_host_mak
 fi
@@ -7151,7 +7120,7 @@ if test "$bswap_h" = "yes" ; then
   echo "CONFIG_MACHINE_BSWAP_H=y" >> $config_host_mak
 fi
 if test "$curl" = "yes" ; then
-  echo "CONFIG_CURL=m" >> $config_host_mak
+  echo "CONFIG_CURL=y" >> $config_host_mak
   echo "CURL_CFLAGS=$curl_cflags" >> $config_host_mak
   echo "CURL_LIBS=$curl_libs" >> $config_host_mak
 fi
@@ -7160,7 +7129,7 @@ if test "$brlapi" = "yes" ; then
   echo "BRLAPI_LIBS=$brlapi_libs" >> $config_host_mak
 fi
 if test "$gtk" = "yes" ; then
-  echo "CONFIG_GTK=m" >> $config_host_mak
+  echo "CONFIG_GTK=y" >> $config_host_mak
   echo "GTK_CFLAGS=$gtk_cflags" >> $config_host_mak
   echo "GTK_LIBS=$gtk_libs" >> $config_host_mak
   if test "$gtk_gl" = "yes" ; then
@@ -7423,13 +7392,13 @@ if test "$zstd" = "yes" ; then
 fi
 
 if test "$libiscsi" = "yes" ; then
-  echo "CONFIG_LIBISCSI=m" >> $config_host_mak
+  echo "CONFIG_LIBISCSI=y" >> $config_host_mak
   echo "LIBISCSI_CFLAGS=$libiscsi_cflags" >> $config_host_mak
   echo "LIBISCSI_LIBS=$libiscsi_libs" >> $config_host_mak
 fi
 
 if test "$libnfs" = "yes" ; then
-  echo "CONFIG_LIBNFS=m" >> $config_host_mak
+  echo "CONFIG_LIBNFS=y" >> $config_host_mak
   echo "LIBNFS_LIBS=$libnfs_libs" >> $config_host_mak
 fi
 
@@ -7451,7 +7420,7 @@ if test "$qom_cast_debug" = "yes" ; then
   echo "CONFIG_QOM_CAST_DEBUG=y" >> $config_host_mak
 fi
 if test "$rbd" = "yes" ; then
-  echo "CONFIG_RBD=m" >> $config_host_mak
+  echo "CONFIG_RBD=y" >> $config_host_mak
   echo "RBD_LIBS=$rbd_libs" >> $config_host_mak
 fi
 
@@ -7523,7 +7492,7 @@ if test "$getauxval" = "yes" ; then
 fi
 
 if test "$glusterfs" = "yes" ; then
-  echo "CONFIG_GLUSTERFS=m" >> $config_host_mak
+  echo "CONFIG_GLUSTERFS=y" >> $config_host_mak
   echo "GLUSTERFS_CFLAGS=$glusterfs_cflags" >> $config_host_mak
   echo "GLUSTERFS_LIBS=$glusterfs_libs" >> $config_host_mak
 fi
@@ -7553,7 +7522,7 @@ if test "$glusterfs_iocb_has_stat" = "yes" ; then
 fi
 
 if test "$libssh" = "yes" ; then
-  echo "CONFIG_LIBSSH=m" >> $config_host_mak
+  echo "CONFIG_LIBSSH=y" >> $config_host_mak
   echo "LIBSSH_CFLAGS=$libssh_cflags" >> $config_host_mak
   echo "LIBSSH_LIBS=$libssh_libs" >> $config_host_mak
 fi
@@ -7813,7 +7782,7 @@ echo "LIBS+=$LIBS" >> $config_host_mak
 echo "LIBS_TOOLS+=$libs_tools" >> $config_host_mak
 echo "PTHREAD_LIB=$PTHREAD_LIB" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
-echo "DSOSUF=$DSOSUF" >> $config_host_mak
+echo "HOST_DSOSUF=$HOST_DSOSUF" >> $config_host_mak
 echo "LDFLAGS_SHARED=$LDFLAGS_SHARED" >> $config_host_mak
 echo "LIBS_QGA=$libs_qga" >> $config_host_mak
 echo "TASN1_LIBS=$tasn1_libs" >> $config_host_mak
diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
index 41bd08ea3a..fea67b207c 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.txt
@@ -404,10 +404,7 @@ using Makefile.target for the build rules.
 - rules.mak
 
 This file provides the generic helper rules for invoking build tools, in
-particular the compiler and linker. This also contains the magic (hairy)
-'unnest-vars' function which is used to merge the variable definitions
-from all Makefile.objs in the source tree down into the main Makefile
-context.
+particular the compiler and linker.
 
 
 - default-configs/*.mak
diff --git a/rules.mak b/rules.mak
index 6cab0b9cbd..c66c8218f0 100644
--- a/rules.mak
+++ b/rules.mak
@@ -33,11 +33,6 @@ QEMU_DGFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 # different for target-dependent ones.
 QEMU_LOCAL_INCLUDES = -iquote $(BUILD_DIR) -iquote $(BUILD_DIR)/$(@D) -iquote $(@D)
 
-WL_U := -Wl,-u,
-find-symbols = $(if $1, $(sort $(shell $(NM) -P -g $1 | $2)))
-defined-symbols = $(call find-symbols,$1,awk '$$2!="U"{print $$1}')
-undefined-symbols = $(call find-symbols,$1,awk '$$2=="U"{print $$1}')
-
 WL := -Wl,
 ifdef CONFIG_DARWIN
 whole-archive = $(WL)-force_load,$1
@@ -45,32 +40,7 @@ else
 whole-archive = $(WL)--whole-archive $1 $(WL)--no-whole-archive
 endif
 
-# All the .mo objects in -m variables are also added into corresponding -y
-# variable in unnest-vars, but filtered out here, when LINK is called.
-#
-# The .mo objects are supposed to be linked as a DSO, for module build. So here
-# they are only used as a placeholders to generate those "archive undefined"
-# symbol options (-Wl,-u,$symbol_name), which are the archive functions
-# referenced by the code in the DSO.
-#
-# Also the presence in -y variables will also guarantee they are built before
-# linking executables that will load them. So we can look up symbol reference
-# in LINK.
-#
-# This is necessary because the exectuable itself may not use the function, in
-# which case the function would not be linked in. Then the DSO loading will
-# fail because of the missing symbol.
-process-archive-undefs = $(filter-out %.a %.fa %.mo %$(DSOSUF),$1) \
-                $(addprefix $(WL_U), \
-                     $(filter $(call defined-symbols,$(filter %.a %.fa, $1)), \
-		$(call undefined-symbols,$(filter %.mo %$(DSOSUF),$1)))) \
-		$(foreach l,$(filter %.fa,$1),$(call whole-archive,$l)) \
-		$(filter %.a,$1)
-
-extract-libs = $(strip $(foreach o,$(filter-out %.mo %$(DSOSUF),$1),$($o-libs)))
-expand-objs = $(strip $(sort $(filter %.o,$1)) \
-		$(foreach o,$(filter %.mo %$(DSOSUF),$1),$($o-objs)) \
-		$(filter-out %.o %.mo %$(DSOSUF),$1))
+extract-libs = $(strip $(foreach o,$1,$($o-libs)))
 
 %.o: %.c
 	@mkdir -p $(dir $@)
@@ -83,7 +53,9 @@ expand-objs = $(strip $(sort $(filter %.o,$1)) \
 LINKPROG = $(or $(CXX),$(CC))
 
 LINK = $(call quiet-command, $(LINKPROG) $(CFLAGS) $(QEMU_LDFLAGS) -o $@ \
-       $(call process-archive-undefs, $1) \
+       $(filter-out %.a %.fa,$1) \
+       $(foreach l,$(filter %.fa,$1),$(call whole-archive,$l)) \
+       $(filter %.a,$1) \
        $(call extract-libs,$1) $(LIBS),"LINK","$(TARGET_DIR)$@")
 
 %.o: %.S
@@ -109,25 +81,11 @@ LINK = $(call quiet-command, $(LINKPROG) $(CFLAGS) $(QEMU_LDFLAGS) -o $@ \
 %.o: %.dtrace
 	$(call quiet-command,dtrace -o $@ -G -s $<,"GEN","$(TARGET_DIR)$@")
 
-DSO_OBJ_CFLAGS := -fPIC -DBUILD_DSO
-module-common.o: CFLAGS += $(DSO_OBJ_CFLAGS)
-%$(DSOSUF): QEMU_LDFLAGS += $(LDFLAGS_SHARED)
-%$(DSOSUF): %.mo
-	$(call LINK,$^)
-	@# Copy to build root so modules can be loaded when program started without install
-	$(if $(findstring /,$@),$(call quiet-command,cp $@ $(subst /,-,$@),"CP","$(subst /,-,$@)"))
-
-
-LD_REL := $(CC) -nostdlib $(LD_REL_FLAGS)
-
-%.mo:
-	$(call quiet-command,$(LD_REL) -o $@ $^,"LD","$(TARGET_DIR)$@")
-
 .PHONY: modules
 modules:
 
 %$(EXESUF): %.o
-	$(call LINK,$(filter %.o %.a %.mo %.fa, $^))
+	$(call LINK,$(filter %.o %.a %.fa, $^))
 
 %.a:
 	$(call quiet-command,rm -f $@ && $(AR) rcs $@ $^,"AR","$(TARGET_DIR)$@")
@@ -160,15 +118,6 @@ define install-prog
 	$(if $(STRIP),$(STRIP) $(foreach T,$1,"$2/$(notdir $T)"),)
 endef
 
-# find-in-path
-# Usage: $(call find-in-path, prog)
-# Looks in the PATH if the argument contains no slash, else only considers one
-# specific directory.  Returns an # empty string if the program doesn't exist
-# there.
-find-in-path = $(if $(findstring /, $1), \
-        $(wildcard $1), \
-        $(wildcard $(patsubst %, %/$1, $(subst :, ,$(PATH)))))
-
 # Logical functions (for operating on y/n values like CONFIG_FOO vars)
 # Inputs to these must be either "y" (true) or "n" or "" (both false)
 # Output is always either "y" or "n".
@@ -205,175 +154,5 @@ clean: clean-timestamp
 # will delete the target of a rule if commands exit with a nonzero exit status
 .DELETE_ON_ERROR:
 
-# save-vars
-# Usage: $(call save-vars, vars)
-# Save each variable $v in $vars as save-vars-$v, save their object's
-# variables, then clear $v.  saved-vars-$v contains the variables that
-# where saved for the objects, in order to speedup load-vars.
-define save-vars
-    $(foreach v,$1,
-        $(eval save-vars-$v := $(value $v))
-        $(eval saved-vars-$v := $(foreach o,$($v), \
-            $(if $($o-cflags), $o-cflags $(eval save-vars-$o-cflags := $($o-cflags))$(eval $o-cflags := )) \
-            $(if $($o-libs), $o-libs $(eval save-vars-$o-libs := $($o-libs))$(eval $o-libs := )) \
-            $(if $($o-objs), $o-objs $(eval save-vars-$o-objs := $($o-objs))$(eval $o-objs := ))))
-        $(eval $v := ))
-endef
-
-# load-vars
-# Usage: $(call load-vars, vars, add_var)
-# Load the saved value for each variable in @vars, and the per object
-# variables.
-# Append @add_var's current value to the loaded value.
-define load-vars
-    $(eval $2-new-value := $(value $2))
-    $(foreach v,$1,
-        $(eval $v := $(value save-vars-$v))
-        $(foreach o,$(saved-vars-$v),
-            $(eval $o := $(save-vars-$o)) $(eval save-vars-$o := ))
-        $(eval save-vars-$v := )
-        $(eval saved-vars-$v := ))
-    $(eval $2 := $(value $2) $($2-new-value))
-endef
-
-# fix-paths
-# Usage: $(call fix-paths, obj_path, src_path, vars)
-# Add prefix @obj_path to all objects in @vars, and add prefix @src_path to all
-# directories in @vars.
-define fix-paths
-    $(foreach v,$3,
-        $(foreach o,$($v),
-            $(if $($o-libs),
-                $(eval $1$o-libs := $($o-libs)))
-            $(if $($o-cflags),
-                $(eval $1$o-cflags := $($o-cflags)))
-            $(if $($o-objs),
-                $(eval $1$o-objs := $(addprefix $1,$($o-objs)))))
-        $(eval $v := $(addprefix $1,$(filter-out %/,$($v))) \
-                     $(addprefix $2,$(filter %/,$($v)))))
-endef
-
-# unnest-var-recursive
-# Usage: $(call unnest-var-recursive, obj_prefix, vars, var)
-#
-# Unnest @var by including subdir Makefile.objs, while protect others in @vars
-# unchanged.
-#
-# @obj_prefix is the starting point of object path prefix.
-#
-define unnest-var-recursive
-    $(eval dirs := $(sort $(filter %/,$($3))))
-    $(eval $3 := $(filter-out %/,$($3)))
-    $(foreach d,$(dirs:%/=%),
-            $(call save-vars,$2)
-            $(eval obj := $(if $1,$1/)$d)
-            $(eval -include $(SRC_PATH)/$d/Makefile.objs)
-            $(call fix-paths,$(if $1,$1/)$d/,$d/,$2)
-            $(call load-vars,$2,$3)
-            $(call unnest-var-recursive,$1,$2,$3))
-endef
-
-# unnest-vars
-# Usage: $(call unnest-vars, obj_prefix, vars)
-#
-# @obj_prefix: object path prefix, can be empty, or '..', etc. Don't include
-# ending '/'.
-#
-# @vars: the list of variable names to unnest.
-#
-# This macro will scan subdirectories's Makefile.objs, include them, to build
-# up each variable listed in @vars.
-#
-# Per object and per module cflags and libs are saved with relative path fixed
-# as well, those variables include -libs, -cflags and -objs. Items in -objs are
-# also fixed to relative path against SRC_PATH plus the prefix @obj_prefix.
-#
-# All nested variables postfixed by -m in names are treated as DSO variables,
-# and will be built as modules, if enabled.
-#
-# A simple example of the unnest:
-#
-#     obj_prefix = ..
-#     vars = hot cold
-#     hot  = fire.o sun.o season/
-#     cold = snow.o water/ season/
-#
-# Unnest through a faked source directory structure:
-#
-#     SRC_PATH
-#        ├── water
-#        │   └── Makefile.objs──────────────────┐
-#        │       │ hot += steam.o               │
-#        │       │ cold += ice.mo               │
-#        │       │ ice.mo-libs := -licemaker    │
-#        │       │ ice.mo-objs := ice1.o ice2.o │
-#        │       └──────────────────────────────┘
-#        │
-#        └── season
-#            └── Makefile.objs──────┐
-#                │ hot += summer.o  │
-#                │ cold += winter.o │
-#                └──────────────────┘
-#
-# In the end, the result will be:
-#
-#     hot  = ../fire.o ../sun.o ../season/summer.o
-#     cold = ../snow.o ../water/ice.mo ../season/winter.o
-#     ../water/ice.mo-libs = -licemaker
-#     ../water/ice.mo-objs = ../water/ice1.o ../water/ice2.o
-#
-# Note that 'hot' didn't include 'water/' in the input, so 'steam.o' is not
-# included.
-#
-define unnest-vars
-    # In the case of target build (i.e. $1 == ..), fix path for top level
-    # Makefile.objs objects
-    $(if $1,$(call fix-paths,$1/,,$2))
-
-    # Descend and include every subdir Makefile.objs
-    $(foreach v, $2,
-        $(call unnest-var-recursive,$1,$2,$v)
-        # Pass the .mo-cflags and .mo-libs along to its member objects
-        $(foreach o, $(filter %.mo,$($v)),
-            $(foreach p,$($o-objs),
-                $(if $($o-cflags), $(eval $p-cflags += $($o-cflags)))
-                $(if $($o-libs), $(eval $p-libs += $($o-libs))))))
-
-    # For all %.mo objects that are directly added into -y, just expand them
-    $(foreach v,$(filter %-y,$2),
-        $(eval $v := $(foreach o,$($v),$(if $($o-objs),$($o-objs),$o))))
-
-    $(foreach v,$(filter %-m,$2),
-        # All .o found in *-m variables are single object modules, create .mo
-        # for them
-        $(foreach o,$(filter %.o,$($v)),
-            $(eval $(o:%.o=%.mo)-objs := $o))
-        # Now unify .o in -m variable to .mo
-        $(eval $v := $($v:%.o=%.mo))
-        $(eval modules-m += $($v))
-
-        # For module build, build shared libraries during "make modules"
-        # For non-module build, add -m to -y
-        $(if $(CONFIG_MODULES),
-             $(foreach o,$($v),
-                   $(eval $($o-objs): CFLAGS += $(DSO_OBJ_CFLAGS))
-                   $(eval $o: $($o-objs)))
-             $(eval $(patsubst %-m,%-y,$v) += $($v))
-             $(eval modules: $($v:%.mo=%$(DSOSUF))),
-             $(eval $(patsubst %-m,%-y,$v) += $(call expand-objs, $($v)))))
-
-    # Post-process all the unnested vars
-    $(foreach v,$2,
-        $(foreach o, $(filter %.mo,$($v)),
-            # Find all the .mo objects in variables and add dependency rules
-            # according to .mo-objs. Report error if not set
-            $(if $($o-objs),
-                $(eval $(o:%.mo=%$(DSOSUF)): module-common.o $($o-objs))))
-        $(shell mkdir -p ./ $(sort $(dir $($v))))
-        # Include all the .d files
-        $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$(filter %.o,$($v)))))
-        $(eval $v := $(filter-out %/,$($v))))
-endef
-
 print-%:
 	@echo '$*=$($*)'
diff --git a/scripts/create_config b/scripts/create_config
index bc82661041..ec5c0b4124 100755
--- a/scripts/create_config
+++ b/scripts/create_config
@@ -91,6 +91,9 @@ case $line in
     name=${line%=*}
     echo "#define $name 1"
     ;;
+ HOST_DSOSUF=*)
+    echo "#define HOST_DSOSUF \"${line#*=}\""
+    ;;
  HOST_*=*) # configuration
     name=${line%=*}
     value=${line#*=}
@@ -123,9 +126,6 @@ case $line in
     value=${line#*=}
     echo "#define $name $value"
     ;;
- DSOSUF=*)
-    echo "#define HOST_DSOSUF \"${line#*=}\""
-    ;;
 esac
 
 done # read
-- 
2.26.2



