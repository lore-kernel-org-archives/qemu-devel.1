Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C943C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8F3256ED
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZupICCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8F3256ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50557 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWI96-00043M-AR
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:18:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6U-0002ZK-Np
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6T-0006Sm-BU
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI6T-0006RX-2u
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:09 -0400
Received: by mail-wr1-x442.google.com with SMTP id l17so3799857wrm.10
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=PPLFa9NHnZbGHQDGEn1CiaHDLKyObQdBVLbTqFMD65I=;
	b=XZupICCADA9sZPbFCDZJlSNr9kqu2xsEr+tj1nHOnTeTYPzkB480cWgVdleix5zmas
	JvIk5yWG41IWcMH/K5H+Z5c45S6byrH4FHF+8CSnq1b8AzO0VQ9e2W31i7qOwNxc2NnS
	wCPDuXtIU1X33cUaXT5ZTkUZrrHBptHCx3fmSeCLhpP6GTgaVctqMczHqSxiE/U3zEqD
	j/Y//Qb2mpJAO1zaOh1odCA3T8c+4GR9tWv5OOYdLt4qeEpZOiT8d2L9gdmOnZlTnSFK
	MiwnQWNOP97g9OTG8idvD3rAs1A7sthtVktWQZjPBU0OYX2FRI1hOnkL8Hvn1wv3SG0K
	AfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=PPLFa9NHnZbGHQDGEn1CiaHDLKyObQdBVLbTqFMD65I=;
	b=oDpgCtsQ0jeiMswVddCeIWdAlBD0tXQmy9a8eSzNSu4pFp/9eiifqvBUi/8AM0PJ84
	wb/Oz3KL7wtq72Wte4KC7ctxn/rdP/vZ59Ksc/kp/39eKBrjhOIQSn0NsE3eL62+Mt9e
	A5u7YRDPDjEOfE47I/58xw0Px9bktICP4E27gwy396/5qZ7OQqd8mRpQ4Xj1SKXnZT6+
	/K9/XfsFrFIbdG0KhbFZ/yCS9KviIgj6+Qdtw+zIt0YtTRlFnQSMSkTFzd53t6twkR53
	zMjs3z/uugbj/e9ZVl+cGOrGBww3xQHMLBH7Cpp/fRMHBLT5iVZu8m0nZ9DRkrHTjw1w
	g1Ig==
X-Gm-Message-State: APjAAAXVdy7SNx48mEhE5jOg4jzKG1W0s/NtQ5I23h+ypJxbnHw3YL3f
	jL8LKJn3UrOvfBQW2YmAzU6SMA==
X-Google-Smtp-Source: APXvYqxHRtR09B5lWkb0xxaM07QHWeATVvSEuoLJ9UEw0Dx6P+9cwcsksNAYMYad7/C7IpGdsuooiw==
X-Received: by 2002:adf:e7c5:: with SMTP id e5mr2018623wrn.107.1559211367918; 
	Thu, 30 May 2019 03:16:07 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	y17sm4609255wrg.18.2019.05.30.03.16.04
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:16:04 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 49ADE1FF90;
	Thu, 30 May 2019 11:16:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:40 +0100
Message-Id: <20190530101603.22254-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v1 03/26] tests: Run the iotests during "make
 check" again
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

People often forget to run the iotests before submitting patches or
pull requests - this is likely due to the fact that we do not run the
tests during our mandatory "make check" tests yet. Now that we've got
a proper "auto" group of iotests that should be fine to run in every
environment, we can enable the iotests during "make check" again by
running the "auto" tests by default from the check-block.sh script.

Some cases still need to be checked first, though: iotests need bash
and GNU sed (otherwise they fail), and if gprof is enabled, it spoils
the output of some test cases causing them to fail. So if we detect
that one of the required programs is missing or that gprof is enabled,
we still have to skip the iotests to avoid failures.

And finally, since we are using check-block.sh now again, this patch also
removes the qemu-iotests-quick.sh script since we do not need that anymore
(and having two shell wrapper scripts around the block tests seem
rather confusing than helpful).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190502084506.8009-8-thuth@redhat.com>
[AJB: -makecheck to check-block.sh, move check-block to start&gate it]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include      |  8 +++----
 tests/check-block.sh        | 44 ++++++++++++++++++++++++++++---------
 tests/qemu-iotests-quick.sh |  8 -------
 3 files changed, 38 insertions(+), 22 deletions(-)
 delete mode 100755 tests/qemu-iotests-quick.sh

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1865f6b3222..0c6d8c75941 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -140,7 +140,7 @@ check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
 check-unit-y += tests/test-qapi-util$(EXESUF)
 
-check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
+check-block-$(call land,$(CONFIG_POSIX),$(CONFIG_SOFTMMU)) += tests/check-block.sh
 
 # All QTests for now are POSIX-only, but the dependencies are
 # really in libqtest, not in the testcases themselves.
@@ -1077,8 +1077,8 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 
 QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
 
-.PHONY: check-tests/qemu-iotests-quick.sh
-check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$(EXESUF) qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
+.PHONY: check-tests/check-block.sh
+check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
 	$<
 
 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
@@ -1152,7 +1152,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-block: $(patsubst %,check-%, $(check-block-y))
-check: check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
+check: check-block check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
diff --git a/tests/check-block.sh b/tests/check-block.sh
index f3d12fd602d..c8b6cec3f68 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -1,24 +1,48 @@
 #!/bin/sh
 
-FORMAT_LIST="raw qcow2 qed vmdk vpc"
+# Honor the SPEED environment variable, just like we do it for the qtests.
+if [ "$SPEED" = "slow" ]; then
+    format_list="raw qcow2"
+    group=
+elif [ "$SPEED" = "thorough" ]; then
+    format_list="raw qcow2 qed vmdk vpc"
+    group=
+else
+    format_list=qcow2
+    group="-g auto"
+fi
+
 if [ "$#" -ne 0 ]; then
-    FORMAT_LIST="$@"
+    format_list="$@"
+fi
+
+if grep -q "TARGET_GPROF=y" *-softmmu/config-target.mak 2>/dev/null ; then
+    echo "GPROF is enabled ==> Not running the qemu-iotests."
+    exit 0
 fi
 
-export QEMU_PROG="$PWD/x86_64-softmmu/qemu-system-x86_64"
-export QEMU_IMG_PROG="$PWD/qemu-img"
-export QEMU_IO_PROG="$PWD/qemu-io"
+if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
+    echo "No qemu-system binary available ==> Not running the qemu-iotests."
+    exit 0
+fi
+
+if ! command -v bash >/dev/null 2>&1 ; then
+    echo "bash not available ==> Not running the qemu-iotests."
+    exit 0
+fi
 
-if [ ! -x $QEMU_PROG ]; then
-    echo "'make check-block' requires qemu-system-x86_64"
-    exit 1
+if ! (sed --version | grep 'GNU sed') > /dev/null 2>&1 ; then
+    if ! command -v gsed >/dev/null 2>&1; then
+        echo "GNU sed not available ==> Not running the qemu-iotests."
+        exit 0
+    fi
 fi
 
 cd tests/qemu-iotests
 
 ret=0
-for FMT in $FORMAT_LIST ; do
-    ./check -T -nocache -$FMT || ret=1
+for fmt in $format_list ; do
+    ./check -makecheck -$fmt $group || ret=1
 done
 
 exit $ret
diff --git a/tests/qemu-iotests-quick.sh b/tests/qemu-iotests-quick.sh
deleted file mode 100755
index 0e554bb9724..00000000000
--- a/tests/qemu-iotests-quick.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-
-cd tests/qemu-iotests
-
-ret=0
-TEST_DIR=${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g quick || ret=1
-
-exit $ret
-- 
2.20.1


