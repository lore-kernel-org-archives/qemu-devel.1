Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47490C00454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1588B205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvj3jjVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1588B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifO2H-0008NW-Mt
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxt-0002jz-9R
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxr-0005mE-M8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:09 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:40408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNxr-0005kI-Dm
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:07 -0500
Received: by mail-wm1-x329.google.com with SMTP id t14so2369687wmi.5
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AGFv06tZwmNRYT44YFhPZ2AJ7Xz8YvGe/TQO//kFRjg=;
 b=hvj3jjVfyVy/wl2i1qvtEa5JxMOLSx+iXOJNMwXCY8oeuc2AuADbqJE8M6nWgfaD49
 +/ajttiyJEJZ2rsZNISsG2eeu1o2kps7vjONy7IyflPZiB0zvHg+Inj87v2aNo4wC6Cn
 Hj43ksAkSD+qq6us20LFLvYXhTIWlzwNKd37u63YmvBOaUYAq3McBRJIBJiwAgvvG1lR
 lmOa6K0zJ6MI4DGdus8yE7kzrNTZS7uc/BDkLfjqkhrBCqXe2tPol8s76+h1dg6AB6zt
 YPuk3rS8USwGEDFjQxAX4w96ImqhUcc9PZCexbAp3g8bT6NKX08zeLEGK3fJau++uesF
 qlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AGFv06tZwmNRYT44YFhPZ2AJ7Xz8YvGe/TQO//kFRjg=;
 b=pDJNA7fXBaSXrKCQIs7tBpAKiyxb6hM5GgHqHnmXi5oXNKDPEVQpmQLBf7l8Hg0xHx
 UNl8jM/GmP7o9MbIcZFYQ/ZjsSZ/oE/opaXsyaZvcNUjyoITR3Q6WC4F8E2DT5XrhBzi
 /dj3fntXlq3rCEX/XIINJpL+7xdtVl2W+tOsTzyvtTE7BzGYsquVY0Dpu3tZVdHeqQRm
 GdVtP9P/4kfsFhGEijlouFBJ8G1ceOlBrxqwSTf8QSJTZJH9I0A1dZRIa1OL1hgnhD7i
 WkSJ0NgKtDb8qhTxfMMMzBX5WYR6im35ncLSogqfC90My6K3EaaJ/RqOgjdx5oKFeBy9
 kvEA==
X-Gm-Message-State: APjAAAXl0esisQzmlcMzpPIP55X592CZgeVOlVN7i6pNUjLhTDwv6dp1
 Q9lfEyO4ZBpxH5FrBB6saW9DLVG1
X-Google-Smtp-Source: APXvYqwWS+fNLnAeu/nmt3Fe4Y84d++/rAe9RG/C4YIl7/pS1U9Fkklwmg7UN1bgAm42ui7eJbWkpA==
X-Received: by 2002:a7b:ce19:: with SMTP id m25mr6117748wmc.83.1576155186106; 
 Thu, 12 Dec 2019 04:53:06 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 008/132] meson: use coverage option
Date: Thu, 12 Dec 2019 13:50:52 +0100
Message-Id: <1576155176-2464-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
---
 Makefile               | 14 --------------
 Makefile.target        | 16 ----------------
 configure              | 10 ++--------
 docs/devel/testing.rst |  7 +++----
 4 files changed, 5 insertions(+), 42 deletions(-)

diff --git a/Makefile b/Makefile
index 44daed6..292da1f 100644
--- a/Makefile
+++ b/Makefile
@@ -661,14 +661,6 @@ module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
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
@@ -1150,9 +1142,6 @@ endif
 		echo '')
 	@echo  'Cleaning targets:'
 	@echo  '  clean           - Remove most generated files but keep the config'
-ifdef CONFIG_GCOV
-	@echo  '  clean-coverage  - Remove coverage files'
-endif
 	@echo  '  distclean       - Remove all generated files'
 	@echo  '  dist            - Build a distributable tarball'
 	@echo  ''
@@ -1164,9 +1153,6 @@ endif
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
index 532e4ab..f4b44af 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -238,19 +238,3 @@ endif
 
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
index 80055f1..5112683 100755
--- a/configure
+++ b/configure
@@ -417,7 +417,6 @@ tcg_interpreter="no"
 bigendian="no"
 mingw32="no"
 gcov="no"
-gcov_tool="gcov"
 EXESUF=""
 DSOSUF=".so"
 LDFLAGS_SHARED="-shared"
@@ -973,8 +972,6 @@ for opt do
   ;;
   --meson=*) meson="$optarg"
   ;;
-  --gcov=*) gcov_tool="$optarg"
-  ;;
   --smbd=*) smbd="$optarg"
   ;;
   --extra-cflags=*)
@@ -1720,7 +1717,6 @@ Advanced options (experts only):
   --with-coroutine=BACKEND coroutine backend. Supported options:
                            ucontext, sigaltstack, windows
   --enable-gcov            enable test coverage analysis with gcov
-  --gcov=GCOV              use specified gcov [$gcov_tool]
   --disable-blobs          disable installing provided firmware blobs
   --with-vss-sdk=SDK-path  enable Windows VSS support in QEMU Guest Agent
   --with-win-sdk=SDK-path  path to Windows Platform SDK (to build VSS .tlb)
@@ -5967,8 +5963,7 @@ esac
 write_c_skeleton
 
 if test "$gcov" = "yes" ; then
-  CFLAGS="-fprofile-arcs -ftest-coverage -g $CFLAGS"
-  LDFLAGS="-fprofile-arcs -ftest-coverage $LDFLAGS"
+  :
 elif test "$fortify_source" = "yes" ; then
   CFLAGS="-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $CFLAGS"
 elif test "$debug" = "no"; then
@@ -6434,7 +6429,6 @@ echo "debug stack usage $debug_stack_usage"
 echo "mutex debugging   $debug_mutex"
 echo "crypto afalg      $crypto_afalg"
 echo "GlusterFS support $glusterfs"
-echo "gcov              $gcov_tool"
 echo "gcov enabled      $gcov"
 echo "TPM support       $tpm"
 echo "libssh support    $libssh"
@@ -7359,7 +7353,6 @@ echo "TASN1_CFLAGS=$tasn1_cflags" >> $config_host_mak
 echo "POD2MAN=$POD2MAN" >> $config_host_mak
 if test "$gcov" = "yes" ; then
   echo "CONFIG_GCOV=y" >> $config_host_mak
-  echo "GCOV=$gcov_tool" >> $config_host_mak
 fi
 
 if test "$libudev" != "no"; then
@@ -7942,6 +7935,7 @@ NINJA=$PWD/ninjatool $python $meson setup \
 	$(test "$strip_opt" = yes && echo --strip) \
 	--buildtype $(if test "$debug" = yes; then echo debug; else echo debugoptimized; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
+        -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
         $cross_arg \
 	"$PWD" "$source_path"
 
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index bf75675..c81ed35 100644
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
1.8.3.1



