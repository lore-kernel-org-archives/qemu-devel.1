Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86BFC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6305720789
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbCx2HLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6305720789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gSa-0000oz-IN
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGp-0003wI-Lq
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:55 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:56085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGn-00064x-V7
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:55 -0400
Received: by mail-wm1-x336.google.com with SMTP id 9so13413446wmj.5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0br65Kmn5xpB8GRXasSxYgnYWTwyOEOqVF8R8HtK98c=;
 b=LbCx2HLR0BYds77O0AViDe85vyUxkpoKveStiZKaTJ3ekKxt7bNdzvDr3zKIvP78pn
 liDFPo8Y/pd3ppgB3n/1u8VfVgaAwwkbSR1QSBO0M/c38JN3+IOgOqabxCJKtlfOGjbB
 Oks7IWGfnZyANtms2HSdBfrXGY0hEzqzLrRSr83JFhwCYngZpBCHaSh58MKZayJl0jDu
 wY84fDbrajwXj2CWfmF+gLbZs926khLEnWm3gONNguAxYUNx7Ut2iLobBk4B0byxur5y
 Gb1cToVjPOBnSRnnBG779Yento+KXIOlVDkVL/ICQa+NrsNrBy/cYLNrHWPnPEAoIQgH
 kd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0br65Kmn5xpB8GRXasSxYgnYWTwyOEOqVF8R8HtK98c=;
 b=EBdE7IY4jnIS0NLPGevOMoXg5qAOKeInC8iaav+x4n3qhwlMfofopxUB4JQdJOoYRl
 bkGKTQtHnkXuThhtA9v8lwQYhqOs41i2i39eREgGiURpSqQZy51BpOsTBMKhpUu73Ilk
 ojVBUIFhaVdoPmSDvI/FYVmr06c77mb+8oAn70W1/bJKP/jSIVEuKF1leKnpL3AlxWvf
 yQYWy4Ie508LqzOEHgXkdFSDvdSLGKJSeOUmvmrID2SQq8S/4JNeyeDAUfL8LmiaD2Ya
 qug/Y2cDa1cgcTwIiOA+w2Au51NL2arvqZ1MeNcnzt69UGREqzD5PH6tdsfwcJCSXTEA
 95KQ==
X-Gm-Message-State: AOAM531IHxr9FZoAxQQLYTUto0jaHlSRdg+op7CwAhMCHJUyfhKR35OI
 Ba59ycrcjXMY7PRFQJ99lftB1QI/h1s=
X-Google-Smtp-Source: ABdhPJwIUOXyOOgGOnHtGJL9fp0hs8AdAVA5nHznfE4ygO9uXr+s3ic9UWJTCWlNPEMf7aQFCxZpjg==
X-Received: by 2002:a05:600c:258e:: with SMTP id
 14mr14508968wmh.141.1597675072273; 
 Mon, 17 Aug 2020 07:37:52 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 025/150] meson: add remaining generated tcg trace helpers
Date: Mon, 17 Aug 2020 16:35:18 +0200
Message-Id: <20200817143723.343284-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x336.google.com
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
 Makefile          | 51 -----------------------------------------------
 trace/meson.build | 14 +++++++++++++
 2 files changed, 14 insertions(+), 51 deletions(-)

diff --git a/Makefile b/Makefile
index 777d9f8e13..973e932869 100644
--- a/Makefile
+++ b/Makefile
@@ -126,61 +126,10 @@ FULL_VERSION := $(if $(QEMU_PKGVERSION),$(VERSION) ($(QEMU_PKGVERSION)),$(VERSIO
 
 generated-files-y = qemu-version.h config-host.h qemu-options.def
 
-generated-files-y += trace/generated-tcg-tracers.h
-
-generated-files-y += trace/generated-helpers-wrappers.h
-generated-files-y += trace/generated-helpers.h
-generated-files-y += trace/generated-helpers.c
-
 generated-files-y += module_block.h
 
 generated-files-y += .git-submodule-status
 
-tracetool-y = $(SRC_PATH)/scripts/tracetool.py
-tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
-
-trace/generated-helpers-wrappers.h: trace/generated-helpers-wrappers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace/generated-helpers-wrappers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	@mkdir -p $(dir $@)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-wrapper-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-trace/generated-helpers.h: trace/generated-helpers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace/generated-helpers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	@mkdir -p $(dir $@)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-trace/generated-helpers.c: trace/generated-helpers.c-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace/generated-helpers.c-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	@mkdir -p $(dir $@)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-c \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-trace/generated-helpers.o: trace/generated-helpers.c
-
-trace/generated-tcg-tracers.h: trace/generated-tcg-tracers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	@mkdir -p $(dir $@)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
 KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
 KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
 
diff --git a/trace/meson.build b/trace/meson.build
index f0a8d1c2e2..cab36a248b 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -55,6 +55,20 @@ custom_target('trace-events-all',
               install: true,
               install_dir: config_host['qemu_datadir'])
 
+foreach d : [
+  ['generated-tcg-tracers.h', 'tcg-h'],
+  ['generated-helpers.c', 'tcg-helper-c'],
+  ['generated-helpers.h', 'tcg-helper-h'],
+  ['generated-helpers-wrappers.h', 'tcg-helper-wrapper-h'],
+]
+  custom_target(d[0],
+                output: d[0],
+                input: meson.source_root() / 'trace-events',
+                command: [ tracetool, '--group=root', '--format=@0@'.format(d[1]), '@INPUT@' ],
+                build_by_default: true, # to be removed when added to a target
+                capture: true)
+endforeach
+
 if 'CONFIG_TRACE_UST' in config_host
   trace_ust_all_h = custom_target('trace-ust-all.h',
                                   output: 'trace-ust-all.h',
-- 
2.26.2



