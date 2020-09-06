Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769D7C433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 17:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D2520738
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 17:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owHJobD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D2520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEys1-0000XH-R1
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 13:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kEyrM-0008SK-Mh
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 13:53:48 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:44411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kEyrL-00006V-1A
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 13:53:48 -0400
Received: by mail-ej1-x629.google.com with SMTP id r7so1600676ejs.11
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 10:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=erHg1O2JCTO2/SYxSVLGlHkOAZtacIgBnE6wTX/f1TY=;
 b=owHJobD39XnZguUuEj4Rh5T5JHs4chfFJJgBhSNLPdcZILxg0ya8XnYZkXqjFgvBn8
 01Zge+bahud+3XdVX7SLKgIwcl/lMWsSkeTTDW4BMg7/5YbOal2w/TFiaUUnnAoun53r
 J6ylhwgytNNAbhCKGVZYKdCo4ZQZMb+mUre75yvkML+QViYQkr1wVmayXJyJQ3DlaRUI
 tlasFC7PqnqtfJxjwXGOGqau6Rvk6O542naMLI+TUexU6MCodK5MaWWcu7mJIRaxEolB
 mxFqWAf6TGjMxlXE+icuPHxm7pAAQilamSI0SUhQDY/R1U68cNd/PUBqgm6m7Jq7KgDL
 mkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=erHg1O2JCTO2/SYxSVLGlHkOAZtacIgBnE6wTX/f1TY=;
 b=eIsicf3WMVFDiGAI2j7GGFlPnDfu2z4H/dIEwk/U1sfvXVNe6CNueR/8A51tOecmmn
 tP3I6ubPJlxs8Cu/ZRZWla1RNXKx5LiKBeF3Da3aWEu0WeCOlJyJJGxJyfeUxh/U7iNe
 Tx5Wwg5LHZBuSwSuvDi2nbsHHqcN1Iz+ZrdcxG/B4ruj4ilkUh4drT+W2nXomOJrQLXf
 cYkCWsxtJEzgdLES8kjvlEwpQ0EhXfy2+ngcoPeFOxL/HlDHWwCS42uZ1np05wd4sbQt
 yuu6WExzPYL5YoJqbWnrmMi0ndKt2V83CO6nO9Bixw6568rD6jzGNGgN7CxBS5QS+ooe
 PVqA==
X-Gm-Message-State: AOAM5331ARLYDaev1BxyIJBwiJs3HOJUon/7e3ADa2JxSE9C+5+8RLKy
 YAsfu6A2bxV5TjR33cuv4kq79MSPiTg=
X-Google-Smtp-Source: ABdhPJxd0gBwAeySNgbplif4wsFHLU60sKhcQ5G+rbgCR0hSL2u1TK+ZT2Ch8JlzJWzTcsztN9GLQQ==
X-Received: by 2002:a17:906:fb97:: with SMTP id
 lr23mr3348840ejb.257.1599414825000; 
 Sun, 06 Sep 2020 10:53:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:b2e3:b609:246c:e7e8])
 by smtp.gmail.com with ESMTPSA id m4sm13680390ejn.31.2020.09.06.10.53.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 10:53:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/46] qemu-iotests: move check-block back to Makefiles
Date: Sun,  6 Sep 2020 19:53:44 +0200
Message-Id: <20200906175344.5042-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200906175344.5042-1-pbonzini@redhat.com>
References: <20200906175344.5042-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ej1-x629.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

check-block has its own test harness, unlike every other test.  If
we capture its output, as is in general nicer to do without V=1,
there will be no sign of progress.  So for lack of a better option
just move the invocation of the test back to Makefile rules.

As a side effect, this will also fix "make check" in --disable-tools
builds, as they were trying to run qemu-iotests without having
made qemu-img before.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                    |  1 -
 tests/Makefile.include         | 15 ++++++++++++---
 tests/qemu-iotests/meson.build |  4 ----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index 5aaa364730..85f3c01b98 100644
--- a/meson.build
+++ b/meson.build
@@ -1097,7 +1097,6 @@ if have_tools
              dependencies: [block, qemuutil], install: true)
   qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
                dependencies: [block, qemuutil], install: true)
-  qemu_block_tools += [qemu_img, qemu_io, qemu_nbd]
 
   subdir('storage-daemon')
   subdir('contrib/rdmacm-mux')
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9ac8f5b86a..08301f5bc9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -468,7 +468,6 @@ check-tcg: $(RUN_TCG_TARGET_RULES)
 .PHONY: clean-tcg
 clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 
-
 # Python venv for running tests
 
 .PHONY: check-venv check-acceptance
@@ -523,8 +522,18 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 # Consolidated targets
 
 .PHONY: check-block check-unit check check-clean get-vm-images
-check-block:
-check-build: build-unit
+check:
+
+ifeq ($(CONFIG_TOOLS)$(CONFIG_POSIX),yy)
+QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
+check: check-block
+check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
+		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
+		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
+	@$<
+endif
+
+check-build: build-unit $(QEMU_IOTESTS_HELPERS-y)
 
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 3de09fb8fa..60470936b4 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -4,7 +4,3 @@ if 'CONFIG_LINUX' in config_host
 else
     socket_scm_helper = []
 endif
-test('qemu-iotests', sh, args: [files('../check-block.sh')],
-     depends: [qemu_block_tools, emulators, socket_scm_helper],
-     suite: 'block', timeout: 10000)
-
-- 
2.26.2

