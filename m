Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7912C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6026205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv68M623"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6026205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gc4-0006VA-0D
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH9-0004Vs-Ex
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:15 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH7-0006AS-Jh
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:15 -0400
Received: by mail-wr1-x432.google.com with SMTP id a15so15234388wrh.10
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TTpH/Amkk5QWW5qv7DGlz5zG9WnvhyPmO7FqAWwRULk=;
 b=bv68M6230nt5T4jVtif3PvbuH7t0inWvCD/bbyQ84N0UEluHgRJdFF6QS/gpGBHfpD
 zNIKczWu5T1HdEGdYu7Yzh6YFIQUnCvL5haAB3+TYY0ihEq73RjG0RBZ40suqMAX7iEm
 6BM6XAgkL4LUsQmCX3/JnaZhOq/MWBBgx/j1jYnVpZbcO1cJW86lXr8kNc+lKUFDbFCv
 8wrJn+X7sTy4f+S4HCGUmFgd+IxK0TkrXSF/ha+5LxQfUHqCESPSb4yRsHSr5r2ZVddw
 9eGtdUefSRSJRY2cyhmW564NhtNHTJNM6/KyiYywYDy8wMCHZnavXx4M7P6vozlhYjTV
 0bwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TTpH/Amkk5QWW5qv7DGlz5zG9WnvhyPmO7FqAWwRULk=;
 b=rboRpVl3r/G66MmGGscQJy+NLOcxtn+2AIDlMCMri/nKgG/4I3r8XrYl70WeZTXlcq
 qQEIs2KR1DPuzA8s3rk+u0usi/s34cggH9DIw2lYcJvxXbDT/cagFXNMAkcTklOMJLQW
 6DAyMyVFeVt/dJsobU2nLW/qavhh9v4zMG7Xnxif+KHeQ6oE3i3kexPI+3+FCQ7R0poP
 WybBvZOCC/wJFvLrweETS3kfEqRovNRUnQYsFOdsKgAYfcdL9j2nFLoUdS3pkc/95CcU
 eAAwEHvzIUvJZBC7n+9piHqwUC/gFsy2orB/lCAPwPswEmu5w1bEKEwc7grohjJDXoPu
 mtXw==
X-Gm-Message-State: AOAM530007yY6pr2g3tsdIjyAr/b1XJe5vPqx44YBI2+EyUyy+8/Gk2E
 UrzipyjsOUviWu0eloqLVw1+jROk2B4=
X-Google-Smtp-Source: ABdhPJxRvSqf18AdhTBWBnMoDqoQxcv4brFC2A+7biRuawhiJ3sseXThjgJtgxvGfTl4dTXu5fPVPw==
X-Received: by 2002:adf:b34a:: with SMTP id k10mr15517788wrd.402.1597675091940; 
 Mon, 17 Aug 2020 07:38:11 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 047/150] meson: keymap-gen
Date: Mon, 17 Aug 2020 16:35:40 +0200
Message-Id: <20200817143723.343284-48-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x432.google.com
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
 Makefile       | 38 --------------------------------------
 meson.build    |  1 +
 ui/meson.build | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 38 deletions(-)
 create mode 100644 ui/meson.build

diff --git a/Makefile b/Makefile
index 2cd3f5862d..f36ff09fd3 100644
--- a/Makefile
+++ b/Makefile
@@ -130,44 +130,6 @@ generated-files-y += module_block.h
 
 generated-files-y += .git-submodule-status
 
-KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
-KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
-
-KEYCODEMAP_FILES = \
-		 ui/input-keymap-atset1-to-qcode.inc \
-		 ui/input-keymap-linux-to-qcode.inc \
-		 ui/input-keymap-qcode-to-atset1.inc \
-		 ui/input-keymap-qcode-to-atset2.inc \
-		 ui/input-keymap-qcode-to-atset3.inc \
-		 ui/input-keymap-qcode-to-linux.inc \
-		 ui/input-keymap-qcode-to-qnum.inc \
-		 ui/input-keymap-qcode-to-sun.inc \
-		 ui/input-keymap-qnum-to-qcode.inc \
-		 ui/input-keymap-usb-to-qcode.inc \
-		 ui/input-keymap-win32-to-qcode.inc \
-		 ui/input-keymap-x11-to-qcode.inc \
-		 ui/input-keymap-xorgevdev-to-qcode.inc \
-		 ui/input-keymap-xorgkbd-to-qcode.inc \
-		 ui/input-keymap-xorgxquartz-to-qcode.inc \
-		 ui/input-keymap-xorgxwin-to-qcode.inc \
-		 ui/input-keymap-osx-to-qcode.inc \
-		 $(NULL)
-
-generated-files-$(CONFIG_SOFTMMU) += $(KEYCODEMAP_FILES)
-
-ui/input-keymap-%.inc: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs
-	$(call quiet-command,\
-	    stem=$* && src=$${stem%-to-*} dst=$${stem#*-to-} && \
-	    test -e $(KEYCODEMAP_GEN) && \
-	    $(PYTHON) $(KEYCODEMAP_GEN) \
-	          --lang glib2 \
-	          --varname qemu_input_map_$${src}_to_$${dst} \
-	          code-map $(KEYCODEMAP_CSV) $${src} $${dst} \
-	        > $@ || rm -f $@, "GEN", "$@")
-
-$(KEYCODEMAP_GEN): .git-submodule-status
-$(KEYCODEMAP_CSV): .git-submodule-status
-
 edk2-decompressed = $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
 pc-bios/edk2-%.fd: pc-bios/edk2-%.fd.bz2
 	$(call quiet-command,bzip2 -d -c $< > $@,"BUNZIP2",$<)
diff --git a/meson.build b/meson.build
index 8319d03730..ded5dba360 100644
--- a/meson.build
+++ b/meson.build
@@ -288,6 +288,7 @@ subdir('trace')
 subdir('util')
 subdir('crypto')
 subdir('storage-daemon')
+subdir('ui')
 
 # Build targets from sourcesets
 
diff --git a/ui/meson.build b/ui/meson.build
new file mode 100644
index 0000000000..daacd2ffbc
--- /dev/null
+++ b/ui/meson.build
@@ -0,0 +1,34 @@
+keymaps = [
+  ['atset1', 'qcode'],
+  ['linux', 'qcode'],
+  ['qcode', 'atset1'],
+  ['qcode', 'atset2'],
+  ['qcode', 'atset3'],
+  ['qcode', 'linux'],
+  ['qcode', 'qnum'],
+  ['qcode', 'sun'],
+  ['qnum', 'qcode'],
+  ['usb', 'qcode'],
+  ['win32', 'qcode'],
+  ['x11', 'qcode'],
+  ['xorgevdev', 'qcode'],
+  ['xorgkbd', 'qcode'],
+  ['xorgxquartz', 'qcode'],
+  ['xorgxwin', 'qcode'],
+  ['osx', 'qcode'],
+]
+
+if have_system
+  foreach e : keymaps
+    output = 'input-keymap-@0@-to-@1@.inc'.format(e[0], e[1])
+    genh += custom_target(output,
+                  output: output,
+                  capture: true,
+                  build_by_default: true, # to be removed when added to a target
+                  input: files('keycodemapdb/data/keymaps.csv'),
+                  command: [python.full_path(), files('keycodemapdb/tools/keymap-gen'),
+                            '--lang', 'glib2',
+                            '--varname', 'qemu_input_map_@0@_to_@1@'.format(e[0], e[1]),
+                            'code-map', '@INPUT0@', e[0], e[1]])
+  endforeach
+endif
-- 
2.26.2



