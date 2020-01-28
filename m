Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2510BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DCC2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg2XOctw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DCC2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVFL-0004We-4Q
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV53-0007rl-1n
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV51-0001ZP-8K
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:16 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:37422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4z-0001TH-AY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:14 -0500
Received: by mail-wr1-x42f.google.com with SMTP id w15so17137435wru.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D5LxvnY5IZc28SYdcZboPCuIF0vRTrcCTrJo+qmKr0I=;
 b=Hg2XOctw1OZr91UFnR7vGHQo+mqz/GyXjAN8MO33StKUfVO+gjygKdKyKkKMcyIUmr
 krLwHQEJB/YNlO65b27l8Clk9tYFcrnyUB2lBA3gsXsk24kl5iC3WbsY4DHg+t/M8C8E
 52+HFrH/NTPVian0DwrptB/hLAqjwFWsg4KWOWaEywdmUXB0WhzaItkn3QJm+LlVtv8L
 HizoumxIN/CuercxV9iBM1DSgI6xvCr2EcxogzuOOqHyFJZC7+YLpXSS4w5oBjlx39I9
 5kugQp916G9nvaX9cnUEhY9m56zpTsAk0WppCg5UxSMDTRFF8Q/4447WcT6bL/WHaIBW
 Qgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=D5LxvnY5IZc28SYdcZboPCuIF0vRTrcCTrJo+qmKr0I=;
 b=ZDvnOpkTGWCwIo9r+C8C0JiZm/xGWER01EuPnkY08BDH4QJLSjE0y6xLor0Z7LazdB
 gxFY5m9eW3UeNL6+qNB0mUZFDnX1SdNwOgbX65UdhndJZwVuhFUw+NBR0xvZ3rjbMbh2
 VzgkOuGwX4FZEYEgaHcFqRuTNShiNUxFdV3QiJ3cPD9hXz1IkLOp+9Kwq/Fv/qfEVxWG
 Wu36HHo4atbsjjYZjF1yOWLmwsXaYpJ8uxV27n+wqLVWd9qoEGecez87Mf6mMFLQP0mr
 MuxGljTVDfjFLFXX5ZPBdvzTrwDEFq/w2H6lHya3AWMByGdZm8Kmdwj6cyxFPb91qCs/
 fw3w==
X-Gm-Message-State: APjAAAWcKFszkRbbyYFrcm4SInkNmYucuWI3C6Nvg3AMZXf5qmMYDIBn
 x5E4VjFtGtFfex51grpZEriAsUPS
X-Google-Smtp-Source: APXvYqxVXadD06BS9Ggz3M1UKyXw54Rs7nKz4YLd6RiI0/7FAdCiKqpkguQgj4zK/NMv5QXod9Gkvw==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr28433800wrt.136.1580234110944; 
 Tue, 28 Jan 2020 09:55:10 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 034/142] meson: generate shader headers
Date: Tue, 28 Jan 2020 18:51:54 +0100
Message-Id: <20200128175342.9066-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
index b77014faa4..a1cddb8476 100644
--- a/Makefile
+++ b/Makefile
@@ -364,7 +364,6 @@ clean: recurse-clean
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f qemu-img-cmds.h
-	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 	rm -f config-all-devices.mak
 
@@ -586,24 +585,6 @@ endif
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
index afa53bee00..c0122a1ab9 100644
--- a/meson.build
+++ b/meson.build
@@ -117,6 +117,7 @@ have_block = have_system or have_tools
 
 # Generators
 
+shaderinclude = find_program('scripts/shaderinclude.pl')
 qapi_gen = find_program('scripts/qapi-gen.py')
 qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
                      meson.source_root() / 'scripts/qapi/commands.py',
diff --git a/ui/meson.build b/ui/meson.build
index cad97635d8..81577546e0 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -32,3 +32,5 @@ foreach e : keymaps
                           '--varname', 'qemu_input_map_@0@_to_@1@'.format(e[0], e[1]),
                           'code-map', '@INPUT0@', e[0], e[1]])
 endforeach
+
+subdir('shader')
diff --git a/ui/shader/meson.build b/ui/shader/meson.build
new file mode 100644
index 0000000000..26c7a187b0
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
+  custom_target(output,
+                output: output,
+                capture: true,
+                build_by_default: true, # to be removed when added to a target
+                input: files('@0@.@1@'.format(e[0], e[1])),
+                command: [shaderinclude, '@INPUT0@'])
+endforeach
-- 
2.21.0



