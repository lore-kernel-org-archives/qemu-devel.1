Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F92C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B9520748
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyGS5lmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B9520748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94QK-0002ZS-46
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94DK-0001BA-98
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94DF-0001UE-Oa
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKo52PK5p1bO40zhuGmPQ5R+Z9GhxAohp/4Q73YBYHs=;
 b=TyGS5lmMsbLJW40JpQzpYCy/NqB5ASFgQJLQnEvjDvjNpbO6GO7t4RFEq9Xc5OKTteBYDq
 MMDfnoEWpcN3wCJzoZEL/sU8WjeG/k6wSsa1MCqNkHC/OhATYcTOoEatadkd0a3BuYkp9s
 WPL/k/Souc5BpCLCslnTnzzffAhfQNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-J2oQ4BxTPne7Sx5t9Ithmg-1; Fri, 21 Aug 2020 06:23:55 -0400
X-MC-Unique: J2oQ4BxTPne7Sx5t9Ithmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38AF11DE1F
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:23:54 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAC637AEC5;
 Fri, 21 Aug 2020 10:23:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 023/152] meson: use coverage option
Date: Fri, 21 Aug 2020 06:21:20 -0400
Message-Id: <20200821102329.29777-24-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
index b726e7d8d2..ba8413d809 100644
--- a/Makefile
+++ b/Makefile
@@ -777,14 +777,6 @@ module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
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
@@ -1291,9 +1283,6 @@ endif
 		echo '')
 	@echo  'Cleaning targets:'
 	$(call print-help,clean,Remove most generated files but keep the config)
-ifdef CONFIG_GCOV
-	$(call print-help,clean-coverage,Remove coverage files)
-endif
 	$(call print-help,distclean,Remove all generated files)
 	$(call print-help,dist,Build a distributable tarball)
 	@echo  ''
@@ -1304,9 +1293,6 @@ endif
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
index 7c2a46ade0..b2c498a0bf 100755
--- a/configure
+++ b/configure
@@ -466,7 +466,6 @@ tcg_interpreter="no"
 bigendian="no"
 mingw32="no"
 gcov="no"
-gcov_tool="gcov"
 EXESUF=""
 DSOSUF=".so"
 LDFLAGS_SHARED="-shared"
@@ -1054,8 +1053,6 @@ for opt do
   ;;
   --meson=*) meson="$optarg"
   ;;
-  --gcov=*) gcov_tool="$optarg"
-  ;;
   --smbd=*) smbd="$optarg"
   ;;
   --extra-cflags=*)
@@ -1862,7 +1859,6 @@ Advanced options (experts only):
   --with-coroutine=BACKEND coroutine backend. Supported options:
                            ucontext, sigaltstack, windows
   --enable-gcov            enable test coverage analysis with gcov
-  --gcov=GCOV              use specified gcov [$gcov_tool]
   --disable-blobs          disable installing provided firmware blobs
   --with-vss-sdk=SDK-path  enable Windows VSS support in QEMU Guest Agent
   --with-win-sdk=SDK-path  path to Windows Platform SDK (to build VSS .tlb)
@@ -6596,8 +6592,7 @@ fi
 write_c_skeleton
 
 if test "$gcov" = "yes" ; then
-  QEMU_CFLAGS="-fprofile-arcs -ftest-coverage -g $QEMU_CFLAGS"
-  QEMU_LDFLAGS="-fprofile-arcs -ftest-coverage $QEMU_LDFLAGS"
+  :
 elif test "$fortify_source" = "yes" ; then
   QEMU_CFLAGS="-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $QEMU_CFLAGS"
   debug=no
@@ -7882,7 +7877,6 @@ echo "TASN1_CFLAGS=$tasn1_cflags" >> $config_host_mak
 echo "POD2MAN=$POD2MAN" >> $config_host_mak
 if test "$gcov" = "yes" ; then
   echo "CONFIG_GCOV=y" >> $config_host_mak
-  echo "GCOV=$gcov_tool" >> $config_host_mak
 fi
 
 if test "$libudev" != "no"; then
@@ -8515,6 +8509,7 @@ NINJA=$PWD/ninjatool $meson setup \
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
index c47cd74571..1a56ac8b26 100644
--- a/meson.build
+++ b/meson.build
@@ -207,7 +207,7 @@ summary_info += {'debug stack usage': config_host.has_key('CONFIG_DEBUG_STACK_US
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



