Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DC0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E375B204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0AB1p8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E375B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gdt-0001Ia-2c
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHD-0004j0-Oh
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:52412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHC-0006BB-5w
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id x5so13421687wmi.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qxn44X5m8nCQy0JhLgpfp9kpI6CKBarBDpEvs33icSE=;
 b=p0AB1p8MD3Q/ypkHIKI8bHeGfVHm56DypVJ8U2V8QL0Nv/asRupa66NBPkkQzy1Olf
 nm09dPJJqVLhvcLs0thJBIBITR8gW26MR0wtq0/Id1imvvTc7vzPRFASzObAu6HaWHv1
 6qoQcKBOvM3W5osI0z67qSaZPKpryuGKQYm0OeO4F/2Cwyk/sRgDdPHBWwlMNvuMi6oZ
 ONss6h7KHyqK+1o2VrpRt+trkX8z1q+QdRQZrbY0iu9i+s5QkwBmTFrtepF+5g7pM1HV
 IlSI9c3UqLhm9J4n65oNcIAEk5sfXAUuektczU+YrCgaJiygTlBEjk4YeKvwyQmiJcXF
 mEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qxn44X5m8nCQy0JhLgpfp9kpI6CKBarBDpEvs33icSE=;
 b=a10xDWYrZFjvUHfQQVXqFfzs4qSIjqaVoU6nmWVwGrhm37YZctjsz4S2vQkEaglGtH
 5EoyKy8eNa+dGCBeSRDByzIa6BM97eIR6q3FhL7Lc7pdPRJ3pjs1e+9NfolhndeagOuf
 +oRMDw8eS85pilKZBIPW/lG+fGLxiWk0HSNxVblMQxuxTB80/OMwjd4Sg2oAkkIOez1H
 ctaiohwPeH3p5D1zzKPb8NgRoSB1pFszNbr5LDVjRyCAQh0QK+nwWkMw7Mr0VnqCEBCX
 baxQ2uM93fal9a2wbRGk6U7Z/SeBd/E5slkqu/dO9FQWtqwtv4pS/9w08sNfFNDcarN4
 b2iw==
X-Gm-Message-State: AOAM53024um5/9vBLh2sC65Te50/gJ7jmBT4gliiJwBrZHTrRUx1mlUx
 Uap1dya20Vvct+o9yR4E18Ifj5MpNI0=
X-Google-Smtp-Source: ABdhPJz2ozsp7Ra4gOmnmXQ2EToDgvAq1R5UL9YU8Qcb6JUSLXsxtdKVxPY7SSKSufMoasbxKsVW+Q==
X-Received: by 2002:a1c:3285:: with SMTP id
 y127mr14869069wmy.104.1597675096516; 
 Mon, 17 Aug 2020 07:38:16 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.15 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 052/150] meson: convert check-decodetree
Date: Mon, 17 Aug 2020 16:35:45 +0200
Message-Id: <20200817143723.343284-53-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x330.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build            | 2 ++
 tests/Makefile.include | 8 +-------
 tests/meson.build      | 4 ++++
 3 files changed, 7 insertions(+), 7 deletions(-)
 create mode 100644 tests/meson.build

diff --git a/meson.build b/meson.build
index bb9e918e4c..00b3220fc8 100644
--- a/meson.build
+++ b/meson.build
@@ -6,6 +6,7 @@ not_found = dependency('', required: false)
 keyval = import('unstable-keyval')
 ss = import('sourceset')
 
+sh = find_program('sh')
 cc = meson.get_compiler('c')
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
 
@@ -380,6 +381,7 @@ endif
 
 subdir('tools')
 subdir('pc-bios')
+subdir('tests')
 
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f277d238fb..8e953a24ee 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -894,13 +894,6 @@ check-tests/qapi-schema/frontend: $(addprefix $(SRC_PATH)/, $(check-qapi-schema-
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
@@ -962,6 +955,7 @@ check-block: $(patsubst %,check-%, $(check-block-y))
 endif
 check-build: build-unit build-softfloat build-qtest
 
+check: check-block check-qapi-schema check-unit check-softfloat check-qtest
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y:%=tests/qtest/%$(EXESUF))) $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF)))
diff --git a/tests/meson.build b/tests/meson.build
new file mode 100644
index 0000000000..5c52021dc9
--- /dev/null
+++ b/tests/meson.build
@@ -0,0 +1,4 @@
+test('decodetree', sh,
+     args: [ files('decode/check.sh'), config_host['PYTHON'], files('../scripts/decodetree.py') ],
+     workdir: meson.current_source_dir() / 'decode',
+     suite: 'decodetree')
-- 
2.26.2



