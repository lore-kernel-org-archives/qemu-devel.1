Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7A7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25DD2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abQFFxVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25DD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVCV-0000xi-Tp
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4B-0006Q6-KJ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV49-00088B-2D
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:22 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:56048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV47-00080E-Sr
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:20 -0500
Received: by mail-wm1-x32d.google.com with SMTP id q9so3483870wmj.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zla3h/TZTZZ2FJmQlbkLgAItmfO88rZ4mtPOcgpOO7o=;
 b=abQFFxVxu41nvvH9iqBOmtDbSbqC+lpXQYIBo3rSjJ+YlasWi4OPP7kAwEV3bIsuo9
 LJOllBDQSWVKV+0KNBgJcnTU9KLp9RPDP9GHGgcVrUX2bhtf+aJVe5r6PY7AkkTqrXjD
 Dh9Xl8zGKmgNvRys5GrQJmW1vdp7/A6fukGy/R6B5G2JqXh7fAZ5k2D/WH2hqja3mwl6
 dKPxW3Bc7INiShS13UHidysb3jb+4XvZ89iLg38J8uymBylcqXsfGyDaazvpgWUvXYJS
 n+EvJqRGaxejji+sOsEOuhxoshVSJDYVy9/6XmHpwFr3LmF/jDxaUbAUn9WTBtjXR9Ri
 UWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zla3h/TZTZZ2FJmQlbkLgAItmfO88rZ4mtPOcgpOO7o=;
 b=sVpuZxqAAD8nQvglWa5tNztsXTz5vxckjTfRUdFww2IKmJJdsJ7bsoQnm+f+Sm/M0n
 /x28WGLHGW44JegA2ZwuKfpGHNc5I+y/lOaFkZw/IVGNoiHU3/YfS4z6FV7wincF9mL6
 cdUQsig7BvDgme1Lvw4YggyQSHRTSu50cVMOD4uO4aWXuIfOAylPtgnOANfPNUN0jEn4
 y3xcb04hWN0M/ZkZkhOHdvTxtqHpROff5divl/4fHlq6/7JAgTzLa1FbL+KoOIVQMjCV
 S0djrnPeR4rADkG1dfCX/obwL+DsfjYzKki8IwRpB8LHKQh+rGeSA/uyfrMZA7yOr+r+
 THAw==
X-Gm-Message-State: APjAAAUq/XQzTYqCk6ATsQgedXgShkOT5BprPD6qelSPtgvzBmqqfLej
 uqVC4D7z22cE/5QJfCT1s2X0Oizw
X-Google-Smtp-Source: APXvYqyQ/iz11+YmQI3A1an9z+arJ6+y6ksgHQdzlGHdU5T/GQ/H7NGVOI8lAL7fnL2jOz+C8WGf8w==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr6351282wmj.170.1580234056476; 
 Tue, 28 Jan 2020 09:54:16 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 011/142] meson: use coverage option
Date: Tue, 28 Jan 2020 18:51:31 +0100
Message-Id: <20200128175342.9066-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
 Makefile               | 14 --------------
 Makefile.target        | 16 ----------------
 configure              | 10 ++--------
 docs/devel/testing.rst |  7 +++----
 4 files changed, 5 insertions(+), 42 deletions(-)

diff --git a/Makefile b/Makefile
index 3b127ef5c8..9aa0808649 100644
--- a/Makefile
+++ b/Makefile
@@ -692,14 +692,6 @@ module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
 	"GEN","$@")
 
-ifdef CONFIG_GCOV
-.PHONY: clean-coverage
-clean-coverage:
-	$(call quiet-command, \
-		find . \( -name '*.gcda' -o -name '*.gcov' \) -type f -exec rm {} +, \
-		"CLEAN", "coverage files")
-endif
-
 clean: recurse-clean
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
@@ -1170,9 +1162,6 @@ endif
 		echo '')
 	@echo  'Cleaning targets:'
 	@echo  '  clean           - Remove most generated files but keep the config'
-ifdef CONFIG_GCOV
-	@echo  '  clean-coverage  - Remove coverage files'
-endif
 	@echo  '  distclean       - Remove all generated files'
 	@echo  '  dist            - Build a distributable tarball'
 	@echo  ''
@@ -1184,9 +1173,6 @@ endif
 	@echo  'Documentation targets:'
 	@echo  '  html info pdf txt'
 	@echo  '                  - Build documentation in specified format'
-ifdef CONFIG_GCOV
-	@echo  '  coverage-report - Create code coverage report'
-endif
 	@echo  ''
 ifdef CONFIG_WIN32
 	@echo  'Windows targets:'
diff --git a/Makefile.target b/Makefile.target
index 6e61f607b1..3bb5d75eb9 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -240,19 +240,3 @@ endif
 
 generated-files-y += config-target.h
 Makefile: $(generated-files-y)
-
-# Reports/Analysis
-#
-# The target specific coverage report only cares about target specific
-# blobs and not the shared code.
-#
-
-%/coverage-report.html:
-	@mkdir -p $*
-	$(call quiet-command,\
-		gcovr -r $(SRC_PATH) --object-directory $(CURDIR) \
-		-p --html --html-details -o $@, \
-		"GEN", "coverage-report.html")
-
-.PHONY: coverage-report
-coverage-report: $(CURDIR)/reports/coverage/coverage-report.html
diff --git a/configure b/configure
index a9ab67bf26..c3409938f2 100755
--- a/configure
+++ b/configure
@@ -418,7 +418,6 @@ tcg_interpreter="no"
 bigendian="no"
 mingw32="no"
 gcov="no"
-gcov_tool="gcov"
 EXESUF=""
 DSOSUF=".so"
 LDFLAGS_SHARED="-shared"
@@ -980,8 +979,6 @@ for opt do
   ;;
   --meson=*) meson="$optarg"
   ;;
-  --gcov=*) gcov_tool="$optarg"
-  ;;
   --smbd=*) smbd="$optarg"
   ;;
   --extra-cflags=*)
@@ -1739,7 +1736,6 @@ Advanced options (experts only):
   --with-coroutine=BACKEND coroutine backend. Supported options:
                            ucontext, sigaltstack, windows
   --enable-gcov            enable test coverage analysis with gcov
-  --gcov=GCOV              use specified gcov [$gcov_tool]
   --disable-blobs          disable installing provided firmware blobs
   --with-vss-sdk=SDK-path  enable Windows VSS support in QEMU Guest Agent
   --with-win-sdk=SDK-path  path to Windows Platform SDK (to build VSS .tlb)
@@ -6111,8 +6107,7 @@ esac
 write_c_skeleton
 
 if test "$gcov" = "yes" ; then
-  CFLAGS="-fprofile-arcs -ftest-coverage -g $CFLAGS"
-  LDFLAGS="-fprofile-arcs -ftest-coverage $LDFLAGS"
+  :
 elif test "$fortify_source" = "yes" ; then
   CFLAGS="-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $CFLAGS"
 elif test "$debug" = "no"; then
@@ -6587,7 +6582,6 @@ echo "debug stack usage $debug_stack_usage"
 echo "mutex debugging   $debug_mutex"
 echo "crypto afalg      $crypto_afalg"
 echo "GlusterFS support $glusterfs"
-echo "gcov              $gcov_tool"
 echo "gcov enabled      $gcov"
 echo "TPM support       $tpm"
 echo "libssh support    $libssh"
@@ -7537,7 +7531,6 @@ echo "TASN1_CFLAGS=$tasn1_cflags" >> $config_host_mak
 echo "POD2MAN=$POD2MAN" >> $config_host_mak
 if test "$gcov" = "yes" ; then
   echo "CONFIG_GCOV=y" >> $config_host_mak
-  echo "GCOV=$gcov_tool" >> $config_host_mak
 fi
 
 if test "$libudev" != "no"; then
@@ -8125,6 +8118,7 @@ NINJA=$PWD/ninjatool $python $meson setup \
 	$(test "$strip_opt" = yes && echo --strip) \
 	--buildtype $(if test "$debug" = yes; then echo debug; else echo debugoptimized; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
+        -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
         $cross_arg \
 	"$PWD" "$source_path"
 
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index ab5be0c729..053ce37da2 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -163,13 +163,12 @@ instrumenting the tested code. To use it, configure QEMU with
 ``--enable-gcov`` option and build. Then run ``make check`` as usual.
 
 If you want to gather coverage information on a single test the ``make
-clean-coverage`` target can be used to delete any existing coverage
+clean-gcda`` target can be used to delete any existing coverage
 information before running a single test.
 
 You can generate a HTML coverage report by executing ``make
-coverage-report`` which will create
-./reports/coverage/coverage-report.html. If you want to create it
-elsewhere simply execute ``make /foo/bar/baz/coverage-report.html``.
+coverage-html`` which will create
+``meson-logs/coveragereport/index.html``.
 
 Further analysis can be conducted by running the ``gcov`` command
 directly on the various .gcda output files. Please read the ``gcov``
-- 
2.21.0



