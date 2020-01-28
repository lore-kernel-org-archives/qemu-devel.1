Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC300C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7EB22522
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q31iRRZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7EB22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWMo-0000i0-Q1
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV90-0005WY-CW
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8z-0002M4-54
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:22 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:46955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8y-0002JG-St
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:21 -0500
Received: by mail-wr1-x42a.google.com with SMTP id z7so17076518wrl.13
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BsvmsxmleEbjOmvGS8CkV+fAGWb3vdJv9HQTmSX6BZQ=;
 b=Q31iRRZwd3tFNjkcKjkVwipi1IQK/lq+1yc+0YUiprPAI8UmNGvAXY7Wbq/bLu9o3Q
 4lJvYrp0gUyZNAz1czWP683CdZd3BGZgWl0ghjM/7hyrAmtUOudpweCsyhOPtgBr4CU3
 mjlnryYOL29Xaj10fqSF8LKuC7mxWlX6EHcFrrC5fSU1s5K0lVfyeGjQG05gV200PrQ0
 ItMjgul1G+TTOc0+bghUaPlWIje5PVCKT0k8ivChBH8iy04Enx+Y4wPbkBThCAjZIk+W
 x1LDxILT4xXkhZZza+yhBxmvmNCQGbjyzdl40xuv4jIsYaDo+TuPvP23Oq0gcpFOZAaK
 N1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BsvmsxmleEbjOmvGS8CkV+fAGWb3vdJv9HQTmSX6BZQ=;
 b=pYgVDW4KlF0x5GVbo5dwWByc/LDlT3BWSsEmMd4AkCaeGpauHs3N3SrXS17p8rCFIJ
 C2RKLESdJzw4hEfNxGK22JhJX6N3/fCpJ8X4lB5BqrL+GmCpbI+hBJ7fkfr/j+is5V7I
 VBnIodfrDBA8SsrOmvOmbIDR3Xqj+FZLflQ9s21uV/KfzCRJwN0W8+W2Uc/4k4ekYGwo
 QTDm2epWuIr3doNTSD8YKLUY0X9Fn628kPatKInSZZ6M3wZoHeZOQkEnyqzpz3WSMhve
 +yC2jlme3UHrgnuPHDHKFB5ZviPebxTBtdnVdLOz2D+hG/7ZLXGwOGfOwQFqVlZyKJ9p
 iZZw==
X-Gm-Message-State: APjAAAUl/Rrb0/3+3ATy/HaZJfuyzCrQthoOf4E0rCCrtUMGk3JUo1FK
 qfGCyNUV+ZlQXgNoXzYkMavHg0Cc
X-Google-Smtp-Source: APXvYqza6whU/xmz44OqJKhSs4dTnSmm2s6JxZEEeeMBOYeGi9O3IxFZwoIH2OxIVPHxr6eOUR9I0Q==
X-Received: by 2002:a5d:67c7:: with SMTP id n7mr29455411wrw.319.1580234358502; 
 Tue, 28 Jan 2020 09:59:18 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.59.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:59:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 140/142] meson: convert check-decodetree
Date: Tue, 28 Jan 2020 18:53:40 +0100
Message-Id: <20200128175342.9066-141-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---
 tests/Makefile.include | 9 +--------
 tests/meson.build      | 5 +++++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 86da369aa0..76bf33bb74 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1125,13 +1125,6 @@ check-tests/qapi-schema/frontend: $(addprefix $(SRC_PATH)/, $(check-qapi-schema-
 check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
 	@diff -u $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
 
-.PHONY: check-decodetree
-check-decodetree:
-	$(call quiet-command, \
-	  cd $(SRC_PATH)/tests/decode && \
-          ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py", \
-          TEST, decodetree.py)
-
 # Python venv for running tests
 
 .PHONY: check-venv check-acceptance
@@ -1174,7 +1167,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 .PHONY: check-qapi-schema check-qtest check-unit check check-clean
 check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
-check: check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
+check: check-qapi-schema check-unit check-softfloat check-qtest
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
diff --git a/tests/meson.build b/tests/meson.build
index a546d91c17..b742188436 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -1,3 +1,8 @@
 if have_system and 'CONFIG_POSIX' in config_host
   subdir('qemu-iotests')
 endif
+
+test('decodetree', files('decode/check.sh'),
+     args: [ config_host['PYTHON'], files('../scripts/decodetree.py') ],
+     workdir: meson.current_source_dir() / 'decode',
+     suite: 'decodetree')
-- 
2.21.0



