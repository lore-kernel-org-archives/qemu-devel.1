Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266B1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7880204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmr3CWaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7880204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gTL-0002eL-5l
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGm-0003nL-I6
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:52 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:36388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGk-00064H-Fe
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:52 -0400
Received: by mail-wr1-x42a.google.com with SMTP id 88so15281188wrh.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F/wQ36U34280qL2K1OxdmvgUNjncr7As1uiWfdy1L4U=;
 b=Gmr3CWaCajvl/MJxDhzDGSpqMbyXJ3s/rzTuZVNYtXfoRNVq20VLCDkCcc9e1IgzHq
 /Kod41a6ap3s05n1k/2HowGn0UciP0UdrxGrtYNYFTpDFUvhKEloQhhHpvhOvekdGY3Z
 QSroYDCFtKrVQNZCB/3rHE8voCJoiY5O48eyEcGyhvAgMN8M9Tq5rWt0qGkzPfvyxzfw
 P4iLdPHToibOuDeIP7PMUSL00mve3+f5iY9y2b/QRlyjKcTvWdVUPZn4CJnB+QaAM8c9
 cakkk8TLnmaX9dzmij2n9dqTRBpjfHipddlTX41NZx4vUtx5CgnP7+F3dnThAvomtSvp
 NQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=F/wQ36U34280qL2K1OxdmvgUNjncr7As1uiWfdy1L4U=;
 b=DyvOaBtKmqOXGat4OOR1CWRrsaWy3LU1nFRfmXDirsa3OX6lP6cPbVfrppDlS4QUrY
 Po1c93whHWOhI+YTjf3EeWSiMH25vIqp4SMsXADTcoYRRRKhE6u1NvK8lyF9OAVOfLlK
 A7V3j0qzbKwGTA/UV/GBodwM9wo2dtOMakggvRlPU9y9dykKBxSsXPOu8OmU8UW85PVJ
 0Q6m3oRTWAT8cA9pbsRfDsJLytVFPI1g0HfORP+qvCdvvDvz0iFF9ARJBqle1xjnfi/T
 E0YADXB92hkJx0+8oPowzI3psqx7GF4mzxcdDHi/3y/FLHtmAB+zSiLyKZJ9BahlLXhf
 zzew==
X-Gm-Message-State: AOAM531/0BwfG8+3QzqB4g0AEMX5jHhtG5WceqXnFiypgB9FvLkb3WrV
 Ukdy1dTcF6RN3DyNE0vuPuWjbByHwbg=
X-Google-Smtp-Source: ABdhPJx/iZPJe66KkJud8vRgLlrZWoZbGAza6Djmu5RihCaMEWYjL9w8CCfYuaPaHqx7Za7bfb+mLw==
X-Received: by 2002:adf:e704:: with SMTP id c4mr16990880wrm.81.1597675068733; 
 Mon, 17 Aug 2020 07:37:48 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 021/150] meson: use coverage option
Date: Mon, 17 Aug 2020 16:35:14 +0200
Message-Id: <20200817143723.343284-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42a.google.com
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
 Makefile               | 14 --------------
 Makefile.target        | 16 ----------------
 configure              |  9 ++-------
 docs/devel/testing.rst |  7 +++----
 meson.build            |  2 +-
 5 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/Makefile b/Makefile
index bf66df5893..578aa99942 100644
--- a/Makefile
+++ b/Makefile
@@ -770,14 +770,6 @@ module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
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
 clean: recurse-clean ninja-clean clean-ctlist
 	-test -f ninjatool && ./ninjatool $(if $(V),-v,) -t clean
 # avoid old build problems by removing potentially incorrect old files
@@ -1284,9 +1276,6 @@ endif
 		echo '')
 	@echo  'Cleaning targets:'
 	$(call print-help,clean,Remove most generated files but keep the config)
-ifdef CONFIG_GCOV
-	$(call print-help,clean-coverage,Remove coverage files)
-endif
 	$(call print-help,distclean,Remove all generated files)
 	$(call print-help,dist,Build a distributable tarball)
 	@echo  ''
@@ -1297,9 +1286,6 @@ endif
 	@echo  ''
 	@echo  'Documentation targets:'
 	$(call print-help,html info pdf txt,Build documentation in specified format)
-ifdef CONFIG_GCOV
-	$(call print-help,coverage-report,Create code coverage report)
-endif
 	@echo  ''
 ifdef CONFIG_WIN32
 	@echo  'Windows targets:'
diff --git a/Makefile.target b/Makefile.target
index ffa2657269..d61a6a978b 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -269,19 +269,3 @@ endif
 
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
index dcdf7312c8..9f20bf1d36 100755
--- a/configure
+++ b/configure
@@ -424,7 +424,6 @@ tcg_interpreter="no"
 bigendian="no"
 mingw32="no"
 gcov="no"
-gcov_tool="gcov"
 EXESUF=""
 DSOSUF=".so"
 LDFLAGS_SHARED="-shared"
@@ -1009,8 +1008,6 @@ for opt do
   ;;
   --meson=*) meson="$optarg"
   ;;
-  --gcov=*) gcov_tool="$optarg"
-  ;;
   --smbd=*) smbd="$optarg"
   ;;
   --extra-cflags=*)
@@ -1817,7 +1814,6 @@ Advanced options (experts only):
   --with-coroutine=BACKEND coroutine backend. Supported options:
                            ucontext, sigaltstack, windows
   --enable-gcov            enable test coverage analysis with gcov
-  --gcov=GCOV              use specified gcov [$gcov_tool]
   --disable-blobs          disable installing provided firmware blobs
   --with-vss-sdk=SDK-path  enable Windows VSS support in QEMU Guest Agent
   --with-win-sdk=SDK-path  path to Windows Platform SDK (to build VSS .tlb)
@@ -6551,8 +6547,7 @@ fi
 write_c_skeleton
 
 if test "$gcov" = "yes" ; then
-  QEMU_CFLAGS="-fprofile-arcs -ftest-coverage -g $QEMU_CFLAGS"
-  QEMU_LDFLAGS="-fprofile-arcs -ftest-coverage $QEMU_LDFLAGS"
+  :
 elif test "$fortify_source" = "yes" ; then
   QEMU_CFLAGS="-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $QEMU_CFLAGS"
   debug=no
@@ -7837,7 +7832,6 @@ echo "TASN1_CFLAGS=$tasn1_cflags" >> $config_host_mak
 echo "POD2MAN=$POD2MAN" >> $config_host_mak
 if test "$gcov" = "yes" ; then
   echo "CONFIG_GCOV=y" >> $config_host_mak
-  echo "GCOV=$gcov_tool" >> $config_host_mak
 fi
 
 if test "$libudev" != "no"; then
@@ -8465,6 +8459,7 @@ NINJA=$PWD/ninjatool $meson setup \
         -Dwerror=$(if test "$werror" = yes; then echo true; else echo false; fi) \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
+        -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index c1ff24370b..a4264691be 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -164,13 +164,12 @@ instrumenting the tested code. To use it, configure QEMU with
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
diff --git a/meson.build b/meson.build
index d3b1f4b503..e6f9dfb070 100644
--- a/meson.build
+++ b/meson.build
@@ -199,7 +199,7 @@ summary_info += {'debug stack usage': config_host.has_key('CONFIG_DEBUG_STACK_US
 summary_info += {'mutex debugging':   config_host.has_key('CONFIG_DEBUG_MUTEX')}
 summary_info += {'crypto afalg':      config_host.has_key('CONFIG_AF_ALG')}
 summary_info += {'GlusterFS support': config_host.has_key('CONFIG_GLUSTERFS')}
-summary_info += {'gcov':              config_host.has_key('CONFIG_GCOV')}
+summary_info += {'gcov':              get_option('b_coverage')}
 summary_info += {'TPM support':       config_host.has_key('CONFIG_TPM')}
 summary_info += {'libssh support':    config_host.has_key('CONFIG_LIBSSH')}
 summary_info += {'QOM debugging':     config_host.has_key('CONFIG_QOM_CAST_DEBUG')}
-- 
2.26.2



