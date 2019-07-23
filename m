Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0679C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE17C2081B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSqoa7a6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE17C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsGi-0001IV-1Y
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39669)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpsF4-0002PA-0u
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpsF1-0004CV-SN
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:41:57 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:35986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpsEz-00049f-Mr
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:41:55 -0400
Received: by mail-wr1-x430.google.com with SMTP id n4so42696076wrs.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P+AkiWgOwKZ1xCT/g5RPhLJYhV52/2n2S8V90CRgCWk=;
 b=MSqoa7a6+VitNCJNIkf8ZJ79pdMB/vcNY7xmw9y/32OFTLNECUTfhhbv2Fk/IL0s54
 p06+NG0OxcdK0PS9u8OjUJGehII8senthBre4JblKVOzRS+TSQhWqqABLcAZatmsAa7A
 w9+bqoFP1JRjcyJOmz81x3HiOkPQa1tvUAM+G03NYGyNamkGr2tg7TstOYJg3T4b858R
 8KyImdDKtrwPg5ZHAISY/2AwrjGxz/v4hy4BJJ9/ccDyyxAd8G0INZ0wtYDmlQWB8Qab
 s+pmblIVjccsVIzFzVq/qyy3I7HroxkLY4WQ+LUgA0AeqOuI82Eq2sXGwRLM+ftAIgBK
 Z3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P+AkiWgOwKZ1xCT/g5RPhLJYhV52/2n2S8V90CRgCWk=;
 b=PRraOXNcKRKB6fEZr0PooulKPzi7TUdTFpDXNVy1zNygyKG7jpQtuDzeKY7ayKQVdX
 yKjZRpp0a/lOYpzl+Kmaiglvj1Jo2B0F7H2Qoy0Xu+0N5EbI0IVs7tUpGfSY1Gaz/Tx1
 1B60yLOXmOR7zFDu7M/hmDZ8dyD6UK5u0k/Po9JQ+LTJ7/2x5imTr+VhBtlF2W8plOpC
 GJlDICuXVnNNfVmdH50gRx4BXUykpug7eXfeU5SNEM5tQPD1RWypuVIJtjI0Zd1va0Av
 T5yDKgmDGSatmsW8JgkcisIFb2WFJMdiVxgpKfnvq9KcbyPpYqShSpx4XoTuVLWcQsXD
 InKg==
X-Gm-Message-State: APjAAAXZY7RwT6+KnaSufkmWXNqbhAnWhocuW5HP/j3ILzeTCQGDHaEu
 MblOVUwbdTxUSmDf6BwyMouU9A==
X-Google-Smtp-Source: APXvYqxRQ8h0alpbfTy4fFmQnDta2Ofg1zguGWL/Jyc0pEZdStH0RM5jKHdZ4J//qbBjQmBpQ6N9ng==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr4642277wrp.188.1563878512123; 
 Tue, 23 Jul 2019 03:41:52 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t13sm52112246wrr.0.2019.07.23.03.41.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:41:48 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4DA8D1FFAA;
 Tue, 23 Jul 2019 11:36:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:36:11 +0100
Message-Id: <20190723103612.5600-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL 22/23] tests: Run the iotests during "make
 check" again
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

People often forget to run the iotests before submitting patches or pull
requests - this is likely due to the fact that we do not run the tests
during our mandatory "make check" tests yet. Now that we've got a proper
"auto" group of iotests that should be fine to run in every environment,
we can enable the iotests during "make check" again by running the "auto"
tests by default from the check-block.sh script.

Some cases still need to be checked first, though: iotests need bash and
GNU sed (otherwise they fail), and if gprof is enabled, it spoils the
output of some test cases causing them to fail. So if we detect that one
of the required programs is missing or that gprof is enabled, we still
have to skip the iotests to avoid failures.

And finally, since we are using check-block.sh now again, this patch also
removes the qemu-iotests-quick.sh script since we do not need that anymore
(and having two shell wrapper scripts around the block tests seems rather
confusing than helpful).

Signed-off-by: Thomas Huth <thuth@redhat.com>
[AJB: -makecheck to check-block.sh, move check-block to start and gate it]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190717111947.30356-4-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/Makefile.include b/tests/Makefile.include
index fd7fdb86586..6f02dfcc019 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -142,7 +142,7 @@ check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
 check-unit-y += tests/test-qapi-util$(EXESUF)
 
-check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
+check-block-$(call land,$(CONFIG_POSIX),$(CONFIG_SOFTMMU)) += tests/check-block.sh
 
 # All QTests for now are POSIX-only, but the dependencies are
 # really in libqtest, not in the testcases themselves.
@@ -1092,8 +1092,10 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 
 QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
 
-.PHONY: check-tests/qemu-iotests-quick.sh
-check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$(EXESUF) qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
+.PHONY: check-tests/check-block.sh
+check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) \
+		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
+		$(patsubst %,%/all,$(filter %-softmmu,$(TARGET_DIRS)))
 	$<
 
 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
@@ -1167,7 +1169,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
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


