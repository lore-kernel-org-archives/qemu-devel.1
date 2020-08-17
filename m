Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F3EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4DF204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT8Vjg+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4DF204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ggW-0005us-DQ
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHB-0004aH-2Y
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:35619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH9-0006Af-AJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:16 -0400
Received: by mail-wm1-x334.google.com with SMTP id 184so14108350wmb.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+zP6tQrjmoss35OlaN/EolS+2AafGwaPfZK6CLHt+xI=;
 b=iT8Vjg+74pLOdmmVZtaLInuqXuUMjjKtWyqPr6tXXX8UhSRk/b4kRNgUoNuAEGu1r2
 uoESAbd8Iwg4GKNQq5LAllo5Me8AFQM82Sa9ac4A0vWRAj6pp8dYsg+c2ss0aHmrKgQp
 Q35xD+zOJoUUPtbLWo4KZAuaFjIboLXLtoBpHubQd3EDAKz8UejgPmXM16KS6zZkY09A
 pMR48B47RahEZCXPDSPV22Y+SCxnADRaVxryuL3ECS30UH1OfELSGzzjYdr1NuD3A9CZ
 iEp41wO09xfsOoAVRXgq+Vy8MDlGv58vs6ZfLG65VqOUDE2WgE3PC51UWr8M/zYs3Kbi
 HBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+zP6tQrjmoss35OlaN/EolS+2AafGwaPfZK6CLHt+xI=;
 b=oNmo7F2IVnZurrolEb71FHG1cwRI8x7mpmVVpkNRHe89K8T2VSiFWZlMkGs23+akgb
 fzn9uVX+gyxA2T9odHrpUPZKqybiPaA9qCcint99guNTHQlX0SNGuLeFnvoYhKp9BM22
 D6jOSm4Q5wk3rIxKpxGY7hm4gcVil2T0g3Sa/JbFSNncD6sOzy1hgkHDPi5JyeAHiChb
 kE6CQVjCHX4cSam1fVcRwNfohEIR0JsutdJRZXsApLdOAkEMCn4V6oM2XlAHesASx/Ls
 HbXjv54Cf6H+t8T50Lxsi+HRNPxxy21fYeULbHNNdGXl6B/HfdhuR6BjBYLTbuINPkBz
 ylNw==
X-Gm-Message-State: AOAM5324Ebm65Vakae6QZh5JxLwYAf7I2z7xSZe43Rx2RtWLGu9gfp33
 EC9FwPvx0qJBBK1nz+Pdv89uqvq5TJo=
X-Google-Smtp-Source: ABdhPJyGDr5uqZesDSixS+Cc4BcxoWuf0bLO4ixGSg/UB/epVJWHEZJFcWDgr0B+qCEcBGgk3CLSDg==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr14642428wmh.20.1597675093621; 
 Mon, 17 Aug 2020 07:38:13 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 049/150] meson: generate shader headers
Date: Mon, 17 Aug 2020 16:35:42 +0200
Message-Id: <20200817143723.343284-50-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x334.google.com
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
 Makefile              | 19 -------------------
 meson.build           |  1 +
 ui/meson.build        |  2 ++
 ui/shader/meson.build | 15 +++++++++++++++
 4 files changed, 18 insertions(+), 19 deletions(-)
 create mode 100644 ui/shader/meson.build

diff --git a/Makefile b/Makefile
index 64255b9d32..11f1845196 100644
--- a/Makefile
+++ b/Makefile
@@ -382,7 +382,6 @@ clean: recurse-clean ninja-clean clean-ctlist
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f qemu-img-cmds.h
-	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 	rm -f config-all-devices.mak
 	rm -f $(SUBDIR_DEVICES_MAK)
@@ -607,24 +606,6 @@ endif
 	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
         done
 
-# opengl shader programs
-ui/shader/%-vert.h: $(SRC_PATH)/ui/shader/%.vert $(SRC_PATH)/scripts/shaderinclude.pl
-	@mkdir -p $(dir $@)
-	$(call quiet-command,\
-		perl $(SRC_PATH)/scripts/shaderinclude.pl $< > $@,\
-		"VERT","$@")
-
-ui/shader/%-frag.h: $(SRC_PATH)/ui/shader/%.frag $(SRC_PATH)/scripts/shaderinclude.pl
-	@mkdir -p $(dir $@)
-	$(call quiet-command,\
-		perl $(SRC_PATH)/scripts/shaderinclude.pl $< > $@,\
-		"FRAG","$@")
-
-ui/shader.o: $(SRC_PATH)/ui/shader.c \
-	ui/shader/texture-blit-vert.h \
-	ui/shader/texture-blit-flip-vert.h \
-	ui/shader/texture-blit-frag.h
-
 # documentation
 MAKEINFO=makeinfo
 MAKEINFOINCLUDES= -I docs -I $(<D) -I $(@D)
diff --git a/meson.build b/meson.build
index c6b13e1999..f9bcf04533 100644
--- a/meson.build
+++ b/meson.build
@@ -155,6 +155,7 @@ have_block = have_system or have_tools
 # Generators
 
 genh = []
+shaderinclude = find_program('scripts/shaderinclude.pl')
 qapi_gen = find_program('scripts/qapi-gen.py')
 qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
                      meson.source_root() / 'scripts/qapi/commands.py',
diff --git a/ui/meson.build b/ui/meson.build
index daacd2ffbc..8cf070c130 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -32,3 +32,5 @@ if have_system
                             'code-map', '@INPUT0@', e[0], e[1]])
   endforeach
 endif
+
+subdir('shader')
diff --git a/ui/shader/meson.build b/ui/shader/meson.build
new file mode 100644
index 0000000000..f69e44ed89
--- /dev/null
+++ b/ui/shader/meson.build
@@ -0,0 +1,15 @@
+shaders = [
+  ['texture-blit', 'frag'],
+  ['texture-blit', 'vert'],
+  ['texture-blit-flip', 'vert'],
+]
+
+foreach e : shaders
+  output = '@0@-@1@.h'.format(e[0], e[1])
+  genh += custom_target(output,
+                output: output,
+                capture: true,
+                build_by_default: true, # to be removed when added to a target
+                input: files('@0@.@1@'.format(e[0], e[1])),
+                command: [shaderinclude, '@INPUT0@'])
+endforeach
-- 
2.26.2



