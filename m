Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F02C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB25F2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iosxe3sA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB25F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaZX-0007XX-RT
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAaVV-0000if-P7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:05:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36880
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAaVT-0003K3-BQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598367902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SpOKpmoPR63A2ouAeyyv2SRBoxnyNRTpMnWZ/m2cKpw=;
 b=Iosxe3sAggLLwYfr9BslZ23JwPFFIYUddATLk+9Nw80rZvr7wpwwu9upQCyTeqL5WZHO/u
 PK2MfuoR2sdB/2deUW0zB27L15SER72a9wqdfi8K62fm2hIaSh51zQZzU0B7XRCswowb1/
 6esP/SlyAt2XX5GEL/fvslEE0eX7VCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-Wet2VMz6Pd2bg544PjyOcg-1; Tue, 25 Aug 2020 11:04:56 -0400
X-MC-Unique: Wet2VMz6Pd2bg544PjyOcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20E57106C109;
 Tue, 25 Aug 2020 15:04:55 +0000 (UTC)
Received: from localhost (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BE9C19C4F;
 Tue, 25 Aug 2020 15:04:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] meson: add NSIS building
Date: Tue, 25 Aug 2020 19:04:09 +0400
Message-Id: <20200825150409.346957-6-marcandre.lureau@redhat.com>
In-Reply-To: <20200825150409.346957-1-marcandre.lureau@redhat.com>
References: <20200825150409.346957-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 sw@weilnetz.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile        | 56 -----------------------------------------------
 meson.build     | 24 ++++++++++++++++++++
 scripts/nsis.sh | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 56 deletions(-)
 create mode 100755 scripts/nsis.sh

diff --git a/Makefile b/Makefile
index 81794d5c34..3ebd6929b4 100644
--- a/Makefile
+++ b/Makefile
@@ -294,62 +294,6 @@ endif
 		"$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
 
-ifdef CONFIG_WIN32
-
-INSTALLER = qemu-setup-$(VERSION)$(EXESUF)
-
-nsisflags = -V2 -NOCD
-
-ifneq ($(wildcard $(SRC_PATH)/dll),)
-ifeq ($(ARCH),x86_64)
-# 64 bit executables
-DLL_PATH = $(SRC_PATH)/dll/w64
-nsisflags += -DW64
-else
-# 32 bit executables
-DLL_PATH = $(SRC_PATH)/dll/w32
-endif
-endif
-
-.PHONY: installer
-installer: $(INSTALLER)
-
-INSTDIR=/tmp/qemu-nsis
-
-$(INSTALLER): $(SRC_PATH)/qemu.nsi
-	$(MAKE) install DESTDIR=${INSTDIR}
-ifdef SIGNCODE
-	(cd ${INSTDIR}/${bindir}; \
-         for i in *.exe; do \
-           $(SIGNCODE) $${i}; \
-         done \
-        )
-endif # SIGNCODE
-	(cd ${INSTDIR}/${bindir}; \
-         for i in qemu-system-*.exe; do \
-           arch=$${i%.exe}; \
-           arch=$${arch#qemu-system-}; \
-           echo Section \"$$arch\" Section_$$arch; \
-           echo SetOutPath \"\$$INSTDIR\"; \
-           echo File \"\$${BINDIR}\\$$i\"; \
-           echo SectionEnd; \
-         done \
-        ) >${INSTDIR}/${bindir}/system-emulations.nsh
-	makensis $(nsisflags) \
-                $(if $(BUILD_DOCS),-DCONFIG_DOCUMENTATION="y") \
-                $(if $(CONFIG_GTK),-DCONFIG_GTK="y") \
-                -DBINDIR="${INSTDIR}/${bindir}" \
-                $(if $(DLL_PATH),-DDLLDIR="$(DLL_PATH)") \
-                -DSRCDIR="$(SRC_PATH)" \
-                -DOUTFILE="$(INSTALLER)" \
-                -DDISPLAYVERSION="$(VERSION)" \
-                $(SRC_PATH)/qemu.nsi
-	rm -r ${INSTDIR}
-ifdef SIGNCODE
-	$(SIGNCODE) $(INSTALLER)
-endif # SIGNCODE
-endif # CONFIG_WIN
-
 # Add a dependency on the generated files, so that they are always
 # rebuilt before other object files
 ifneq ($(wildcard config-host.mak),)
diff --git a/meson.build b/meson.build
index 0720a7d684..4ee8ef1e9d 100644
--- a/meson.build
+++ b/meson.build
@@ -1217,6 +1217,30 @@ if build_docs
   endif
 endif
 
+if host_machine.system() == 'windows'
+  nsis_cmd = [
+    find_program('scripts/nsis.sh'),
+    '@OUTPUT@',
+    get_option('prefix'),
+    meson.current_source_dir(),
+    host_machine.cpu_family(),
+    '-DDISPLAYVERSION=' + meson.project_version(),
+  ]
+  if build_docs
+    nsis_cmd += '-DCONFIG_DOCUMENTATION=y'
+  endif
+  if 'CONFIG_GTK' in config_host
+    nsis_cmd += '-DCONFIG_GTK=y'
+  endif
+
+  nsis = custom_target('nsis',
+                       output: 'qemu-setup-' + meson.project_version() + '.exe',
+                       input: files('qemu.nsi'),
+                       build_always_stale: true,
+                       command: nsis_cmd + ['@INPUT@'])
+  alias_target('installer', nsis)
+endif
+
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
 summary_info += {'BIOS directory':    config_host['qemu_datadir']}
diff --git a/scripts/nsis.sh b/scripts/nsis.sh
new file mode 100755
index 0000000000..d7d8b39b04
--- /dev/null
+++ b/scripts/nsis.sh
@@ -0,0 +1,58 @@
+#!/bin/bash -e
+
+OUTFILE="$1"
+shift
+PREFIX="$1"
+shift
+SRCDIR="$1"
+shift
+CPU="$1"
+shift
+
+DESTDIR=$(mktemp -d)
+trap 'rm -rf $DESTDIR' EXIT
+make DESTDIR="$DESTDIR/" install
+
+do_signcode() {
+    if [ -z "$SIGNCODE" ]; then
+        return
+    fi
+    "$SIGNCODE" "$@"
+}
+
+shopt -s nullglob
+
+(
+    cd "$DESTDIR$PREFIX"
+    for i in qemu-system-*.exe; do
+        arch=${i%.exe}
+        arch=${arch#qemu-system-}
+        echo Section \""$arch"\" "Section_$arch"
+        echo SetOutPath \"\$INSTDIR\"
+        echo File \"\${BINDIR}\\$i\"
+        echo SectionEnd
+    done
+) > "$DESTDIR$PREFIX/system-emulations.nsh"
+
+(
+    cd "$DESTDIR$PREFIX"
+    for i in *.exe; do
+        do_signcode "$i"
+    done
+)
+
+if [ "$CPU" = "x86_64" ]; then
+    CPUARG="-DW64"
+    DLLDIR="w64"
+else
+    DLLDIR="w32"
+fi
+
+if [ -d "$SRCDIR/dll" ]; then
+   DLLARG="-DDLLDIR=$SRCDIR/dll/$DLLDIR"
+fi
+
+makensis -V2 -NOCD -DSRCDIR="$SRCDIR" -DBINDIR="$DESTDIR$PREFIX" \
+         $CPUARG $DLLARG -DOUTFILE="$OUTFILE" "$@"
+
+do_signcode "$OUTFILE"
-- 
2.26.2


