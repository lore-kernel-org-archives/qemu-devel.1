Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2714C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF4B20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBIU1tOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF4B20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWDE-0001BD-SO
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV85-0004Io-SA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV83-0000Ht-SZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:25 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:39012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV83-0000Bk-0o
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:23 -0500
Received: by mail-wr1-x42a.google.com with SMTP id y11so17096231wrt.6
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l9hO5PgZb/Nyq4E6wf+anMGT7YhM7l+MgQPxon2X7xQ=;
 b=oBIU1tOrdsx3uBOfyVSibPSbMN5DgIyL+Cif+L1CJZI26In89xDvbTp63wAVEHXhkN
 scEWyh9BHkakrsF00oq81j/ksVzq8Y8qJEINwnXdPqufqjin7gtEveVJyxnmq/gk7omd
 SIoi4SGHSA0yjF07WZ0rnRdru0VPcUZ8/ARRip9N7RSqWaY8ra/NUVtLbNk9vSsdYPRT
 BrrTEEag4Lixy4ESQd/ESpWfMLLdJvYLXlY4B3a6Sv5l84OkRSPs7yOYRWOKADXniovy
 xUvaZCTa2sTcP9zCruCz+OTFOkcYFnJw9r8u7S+qVpoVIgmUJYuUBrk+Ca0t8Ge1T5D7
 /B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=l9hO5PgZb/Nyq4E6wf+anMGT7YhM7l+MgQPxon2X7xQ=;
 b=shrXPUYE+StU5cNBAIEMuPmdcmWnC2GddW77DQ0yo3jKM6opFP1xLNV5PjXN5l93VJ
 659j2CI2R8LpDVJYaSq6Fj/s3eAXuGmmEm1hN+pfNKtU2NTWDigFKzKmLhq1rLpHVTEO
 JmEETGUEVkon7HF3RhGgIu3emjR2/Y5ixpn2xLmV3tZktWLANKgmag/Bp34yx4WOlfOm
 PYc0JMffJrIScm13ARqmCeE0zQVqO6qFs0dv/PyVJPYtGy3VY98mY99MXIs+Leg/Fqvc
 xJ6czdPfTbL6T/FVVlBJtadLqAE0wEwp85EygQaZracCE8fjF8ZSYE9B2rdovDGhCAbX
 SFMg==
X-Gm-Message-State: APjAAAUDbaKjhqyEpDB+FdugbSXHm9JDldALzfCry/pM1EmJ/G5IQSg4
 WOjP0ax5V+dAvF75fYOqcKjGkPc5
X-Google-Smtp-Source: APXvYqz5jazxdp2FrcwkbQPW+eIDxDjbSzfr5igdRCTkRQ2Y6Nt5saMd7d5uX4UXPoMbOd3VkNAd6Q==
X-Received: by 2002:adf:c746:: with SMTP id b6mr29687331wrh.298.1580234300744; 
 Tue, 28 Jan 2020 09:58:20 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 116/142] meson: cpu-emu
Date: Tue, 28 Jan 2020 18:53:16 +0100
Message-Id: <20200128175342.9066-117-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
---
 Makefile.target         | 12 ------------
 configure               |  6 ++++++
 meson.build             | 29 +++++++++++++++++++++++++++++
 scripts/feature_to_c.sh | 24 ++++++++----------------
 4 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 3671c29f97..5c4ba3db54 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -108,15 +108,6 @@ obj-y += $(LIBQEMU)
 obj-y += trace/
 
 #########################################################
-# cpu emulator library
-obj-y += exec.o exec-vary.o
-obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-op-gvec.o
-obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/optimize.o
-obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
-obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
-obj-$(CONFIG_TCG) += fpu/softfloat.o
-obj-y += disas.o
-obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 LIBS := $(libs_cpu) $(LIBS)
 
 obj-$(CONFIG_PLUGIN) += plugins/
@@ -201,9 +192,6 @@ ifdef CONFIG_DARWIN
 	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
 endif
 
-gdbstub-xml.c: $(TARGET_XML_FILES) $(SRC_PATH)/scripts/feature_to_c.sh
-	$(call quiet-command,rm -f $@ && $(SHELL) $(SRC_PATH)/scripts/feature_to_c.sh $@ $(TARGET_XML_FILES),"GEN","$(TARGET_DIR)$@")
-
 clean: clean-target
 	rm -f *.a *~ $(PROGS)
 	rm -f $(shell find . -name '*.[od]')
diff --git a/configure b/configure
index aa51bb783c..5c6217e7e6 100755
--- a/configure
+++ b/configure
@@ -5125,9 +5125,13 @@ case "$capstone" in
       LIBCAPSTONE=libcapstone.a
     fi
     libs_cpu="-L$PWD/capstone -lcapstone $libs_cpu"
+    capstone_libs="-L$PWD/capstone -lcapstone"
+    capstone_cflags="-I${source_path}/capstone/include"
     ;;
 
   system)
+    capstone_libs="$($pkg_config --libs capstone)"
+    capstone_cflags="$($pkg_config --cflags capstone)"
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
     libs_cpu="$($pkg_config --libs capstone) $libs_cpu"
     ;;
@@ -7408,6 +7412,8 @@ if test "$ivshmem" = "yes" ; then
 fi
 if test "$capstone" != "no" ; then
   echo "CONFIG_CAPSTONE=y" >> $config_host_mak
+  echo "CAPSTONE_CFLAGS=$capstone_cflags" >> $config_host_mak
+  echo "CAPSTONE_LIBS=$capstone_libs" >> $config_host_mak
 fi
 if test "$debug_mutex" = "yes" ; then
   echo "CONFIG_DEBUG_MUTEX=y" >> $config_host_mak
diff --git a/meson.build b/meson.build
index a96c54ceb1..91326b12d8 100644
--- a/meson.build
+++ b/meson.build
@@ -318,6 +318,11 @@ if 'CONFIG_USB_LIBUSB' in config_host
   libusb = declare_dependency(compile_args: config_host['LIBUSB_CFLAGS'].split(),
                               link_args: config_host['LIBUSB_LIBS'].split())
 endif
+capstone = declare_dependency()
+if 'CONFIG_CAPSTONE' in config_host
+  capstone = declare_dependency(compile_args: config_host['CAPSTONE_CFLAGS'].split(),
+                                link_args: config_host['CAPSTONE_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -490,6 +495,19 @@ hw_arch = {}
 target_arch = {}
 target_softmmu_arch = {}
 
+specific_ss.add(files('disas.c', 'exec.c'), capstone)
+specific_ss.add(files('exec-vary.c'), capstone)
+specific_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'fpu/softfloat.c',
+  'tcg/optimize.c',
+  'tcg/tcg-common.c',
+  'tcg/tcg-op-gvec.c',
+  'tcg/tcg-op-vec.c',
+  'tcg/tcg-op.c',
+  'tcg/tcg.c',
+))
+specific_ss.add(when: 'CONFIG_TCG_INTERPRETER', if_true: files('disas/tci.c', 'tcg/tci.c'))
+
 # TODO: add each directory to the subdirs from its own meson.build, once
 # we have those
 trace_events_subdirs = [
@@ -725,6 +743,8 @@ common_all = static_library('common',
                             dependencies: common_all.dependencies(),
                             name_suffix: 'fa')
 
+feature_to_c = find_program('scripts/feature_to_c.sh')
+
 foreach target : target_dirs
   config_target = target_config[target]
   target_name = config_target['TARGET_NAME']
@@ -766,6 +786,15 @@ foreach target : target_dirs
     endif
   endif
 
+  if 'TARGET_XML_FILES' in config_target
+    gdbstub_xml = custom_target(target + '-gdbstub-xml.c',
+                                output: target + '-gdbstub-xml.c',
+                                input: files(config_target['TARGET_XML_FILES'].split()),
+                                command: [feature_to_c, '@INPUT@'],
+                                capture: true)
+    arch_srcs += gdbstub_xml
+  endif
+
   t = target_arch[arch].apply(config_target, strict: false)
   arch_srcs += t.sources()
 
diff --git a/scripts/feature_to_c.sh b/scripts/feature_to_c.sh
index c8ce9b88f6..b1169899c1 100644
--- a/scripts/feature_to_c.sh
+++ b/scripts/feature_to_c.sh
@@ -19,16 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, see <http://www.gnu.org/licenses/>.
 
-output=$1
-shift
-
-if test -z "$output" || test -z "$1"; then
-  echo "Usage: $0 OUTPUTFILE INPUTFILE..."
-  exit 1
-fi
-
-if test -e "$output"; then
-  echo "Output file \"$output\" already exists; refusing to overwrite."
+if test -z "$1"; then
+  echo "Usage: $0 INPUTFILE..."
   exit 1
 fi
 
@@ -60,17 +52,17 @@ for input; do
       printf "'\''\\n'\'', \n"
     } END {
       print "  0 };"
-    }' < $input >> $output
+    }' < $input
 done
 
-echo >> $output
-echo "const char *const xml_builtin[][2] = {" >> $output
+echo
+echo "const char *const xml_builtin[][2] = {"
 
 for input; do
   basename=$(echo $input | sed 's,.*/,,')
   arrayname=xml_feature_$(echo $input | sed 's,.*/,,; s/[-.]/_/g')
-  echo "  { \"$basename\", $arrayname }," >> $output
+  echo "  { \"$basename\", $arrayname },"
 done
 
-echo "  { (char *)0, (char *)0 }" >> $output
-echo "};" >> $output
+echo "  { (char *)0, (char *)0 }"
+echo "};"
-- 
2.21.0



