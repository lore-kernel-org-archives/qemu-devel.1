Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E762C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA74C21532
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxMs8FGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA74C21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFKCY-00032I-ML
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kFKBQ-0002Ua-Gn
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:39:56 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:39690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kFKBO-0008RL-Nx
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:39:56 -0400
Received: by mail-ej1-x641.google.com with SMTP id p9so18936276ejf.6
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n3B1PcPbtXyRKDvhkufpceOeW+LHKvTC04HSYKxTByM=;
 b=dxMs8FGPTSULW2Y1Unz1o3tMQR2YEhgJjMLBxsLdHU3yJnO5OfxeAGVEVtjvzV+5GQ
 a/gOhWCk5qk/Do9pyeTqwHMhudGORnXY72zvb2M5Dr644s/oLG09me+/+yUIIYDaHri1
 uqvmZq8QWneHVqej6uzH9D9eiZYQ7jFnxl0MjJxyg8xQtcFGMFATe6ZCQmUBVmPzHj0M
 ZKJdI4N+H+3L5QNSUNDtqKeFtUPI4eId2DSHhidKCaGJZIxUBMpchdFuCvhvp1723Pao
 piFEahBAtt3ZjYUVV8M4hVffl0aFOhoVB2aKGdBxflLmN5eW+Ykd8l6+WDWFXC+VxUhk
 pXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=n3B1PcPbtXyRKDvhkufpceOeW+LHKvTC04HSYKxTByM=;
 b=VrzSc3v6TA1CvowTsJsDJhKxlLRG3tstga+dn3R0lVf/ZH+m9oGgS03nFdN4O9sTWw
 UhTDtAcUI4JCrgDkIR7MUjfiuzAa8dAYkzCWJ0utqRIfzN62FJxWZ3cRgr0lEOJZ9Aa0
 xAXI3nDnpwhxwKbvCyxoL5OfWhShAebm2jaJQPCj+ChPeF9nuPRBOL+yj7gfn0aIsuMO
 6zlOjnKtsJX/fD+VfynCowT8ebNapDuMloWyHtdyteVJ+7T3pegwwExRB7rLJHuV8ax0
 wFvSJPCqqy32egLLhpH4qGsmN87nVPWrUuMU5jIgCwg0hMvHz9NNNLBAg2JQwBn+8k7b
 D/dA==
X-Gm-Message-State: AOAM533ta5sBOnKTkZlyrnDRkPhUkPAm0P3L5BBiXSJOYq/R6cpPAeAW
 ye8BY3tgKwulMhNtzB9T4E8xcukTnFI=
X-Google-Smtp-Source: ABdhPJybCaaQLlbZe2vlw+b0XuGpiMSWrwPBMHYZR6e0W6dD2mza9jGsXEyzaX8xhPDjtaw2pUXniA==
X-Received: by 2002:a17:906:b47:: with SMTP id
 v7mr21121237ejg.310.1599496792485; 
 Mon, 07 Sep 2020 09:39:52 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:6891:d6db:f6ec:d1df])
 by smtp.gmail.com with ESMTPSA id y24sm15424308eds.35.2020.09.07.09.39.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 09:39:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs: update build system documentation
Date: Mon,  7 Sep 2020 18:39:53 +0200
Message-Id: <20200907163953.19097-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Most of the Makefile bits are obsolete and can be removed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst | 97 +++++--------------------------------
 1 file changed, 11 insertions(+), 86 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 591e93f4b4..08e85c69e1 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -179,7 +179,7 @@ process for:
 
    - Userspace emulators - qemu-$ARCH
 
-   - Some (but not all) unit tests
+   - Unit tests
 
 2) documentation
 
@@ -204,8 +204,9 @@ are then turned into static libraries as follows::
 
     chardev = declare_dependency(link_whole: libchardev)
 
-The special `.fa` suffix is needed as long as unit tests are built with
-the older Makefile infrastructure, and will go away later.
+As of Meson 0.55.1, the special `.fa` suffix should be used for everything
+that is used with `link_whole`, to ensure that the link flags are placed
+correctly in the command line.
 
 Files linked into emulator targets there can be split into two distinct groups
 of files, those which are independent of the QEMU emulation target and
@@ -221,7 +222,8 @@ only in system emulators, `user_ss` only in user-mode emulators.
 
 In the target-dependent set lives CPU emulation, device emulation and
 much glue code. This sometimes also has to be compiled multiple times,
-once for each target being built.
+once for each target being built.  Target-dependent files are included
+in the `specific_ss` sourceset.
 
 All binaries link with a static library `libqemuutil.a`, which is then
 linked to all the binaries.  `libqemuutil.a` is built from several
@@ -300,84 +302,9 @@ The resulting build system is largely non-recursive in nature, in
 contrast to common practices seen with automake.
 
 Tests are also ran by the Makefile with the traditional `make check`
-phony target.  Meson test suites such as `unit` can be ran with `make
-check-unit` too.  It is also possible to run tests defined in meson.build
-with `meson test`.
-
-The following text is only relevant for unit tests which still have to
-be converted to Meson.
-
-All binaries should link to `libqemuutil.a`, e.g.:
-
-   qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a
-
-On Windows, all binaries have the suffix `.exe`, so all Makefile rules
-which create binaries must include the $(EXESUF) variable on the binary
-name. e.g.
-
-   qemu-img$(EXESUF): qemu-img.o ..snip..
-
-This expands to `.exe` on Windows, or an empty string on other platforms.
-
-Variable naming
----------------
-
-The QEMU convention is to define variables to list different groups of
-object files. These are named with the convention $PREFIX-obj-y.  The
-Meson `chardev` variable in the previous example corresponds to a
-variable 'chardev-obj-y'.
-
-Likewise, tests that are executed by `make check-unit` are grouped into
-a variable check-unit-y, like this:
-
-  check-unit-y += tests/test-visitor-serialization$(EXESUF)
-  check-unit-y += tests/test-iov$(EXESUF)
-  check-unit-y += tests/test-bitmap$(EXESUF)
-
-When a test or object file which needs to be conditionally built based
-on some characteristic of the host system, the configure script will
-define a variable for the conditional. For example, on Windows it will
-define $(CONFIG_POSIX) with a value of 'n' and $(CONFIG_WIN32) with a
-value of 'y'. It is now possible to use the config variables when
-listing object files. For example,
-
-  check-unit-$(CONFIG_POSIX) += tests/test-vmstate$(EXESUF)
-
-On Windows this expands to
-
-  check-unit-n += tests/vmstate.exe
-
-Since the `check-unit` target only runs tests included in `$(check-unit-y)`,
-POSIX specific tests listed in `$(util-obj-n)` are ignored on the Windows
-platform builds.
-
-
-CFLAGS / LDFLAGS / LIBS handling
---------------------------------
-
-There are many different binaries being built with differing purposes,
-and some of them might even be 3rd party libraries pulled in via git
-submodules. As such the use of the global CFLAGS variable is generally
-avoided in QEMU, since it would apply to too many build targets.
-
-Flags that are needed by any QEMU code (i.e. everything *except* GIT
-submodule projects) are put in $(QEMU_CFLAGS) variable. For linker
-flags the $(LIBS) variable is sometimes used, but a couple of more
-targeted variables are preferred.
-
-In addition to these variables, it is possible to provide cflags and
-libs against individual source code files, by defining variables of the
-form $FILENAME-cflags and $FILENAME-libs. For example, the test
-test-crypto-tlscredsx509 needs to link to the libtasn1 library,
-so tests/Makefile.include defines some variables:
-
-  tests/crypto-tls-x509-helpers.o-cflags := $(TASN1_CFLAGS)
-  tests/crypto-tls-x509-helpers.o-libs := $(TASN1_LIBS)
-
-The scope is a little different between the two variables. The libs get
-used when linking any target binary that includes the curl.o object
-file, while the cflags get used when compiling the curl.c file only.
-
+phony target, while benchmarks are run with `make bench`.  Meson test
+suites such as `unit` can be ran with `make check-unit` too.  It is also
+possible to run tests defined in meson.build with `meson test`.
 
 Important files for the build system
 ====================================
@@ -402,10 +329,8 @@ number of dynamically created files listed later.
   other meson.build files spread throughout the QEMU source tree.
 
 `tests/Makefile.include`
-  Rules for building the unit tests. This file is included directly by the
-  top level Makefile, so anything defined in this file will influence the
-  entire build system. Care needs to be taken when writing rules for tests
-  to ensure they only apply to the unit test execution / build.
+  Rules for external test harnesses. These include the TCG tests,
+  `qemu-iotests` and the Avocado-based acceptance tests.
 
 `tests/docker/Makefile.include`
   Rules for Docker tests. Like tests/Makefile, this file is included
-- 
2.26.2


