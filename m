Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33486C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B2520716
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPiaiIXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B2520716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVaa-0001WC-5n
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4v-0007kK-H1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4t-0001Jt-6N
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:09 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4s-0001Hc-V0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:07 -0500
Received: by mail-wr1-x42f.google.com with SMTP id c9so17101842wrw.8
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M0HqH7iwd0YbH54NEqXITc/jWWZ/MwBL5OsK9z7h7qk=;
 b=MPiaiIXR3OD0+xU863/5cB+j84K3JLf4NOYDEUCGg5SeBflQJBs2lhRRR545l/zFC7
 w/WhcZO7atPlh/2tbKuz9x6MUosRKsgJiuxGK+8QmTfyTEy+VvzFMS6/LcCHtLkcq6FB
 u8JHnt/WsNc5O9iypTltpk7fuNQx5ToaBQucAEz5Vrol2K6n+oqp9FNDxI9hscgMKJ7k
 0DopDNyYaO8HCN761GxLaOYv+q+kWClv8mj5dwwZZlNL2xp/OFodB46QCChyD03U3GB8
 odXLcDTFVle7uKUaukQ4I0Qtx9e/8TXnzitdAtj3sdo/RaGeFPRawKjEcJ1GM9effNKm
 9okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=M0HqH7iwd0YbH54NEqXITc/jWWZ/MwBL5OsK9z7h7qk=;
 b=p8z83EuPXIqpBY8bIptsQmrsDUG7buWAofH+tH9TpHc5G7w+EtJVgxXA9DbJSN+qxb
 oMWY/5JfJcwU93rlaS8sPQHgwSLwlAu5VVrdptY8CykQNFJOqJjFt1UfCj2Wt/VhqHgW
 z+/ZTscFK9xC4DMNnLdXohlEQTPXm8Go1zZF3OSN66PxCCFR6mPsnNBCu/10VgkP+4Sn
 a9CLGNB0c1PURkOy2ALMGMG0+D1LAXmqmUordkHnYimmMwt6mw0dvXsuM2cSJMy5ASEV
 +KMpuk4d5QpLS6vChx1HLrs6fHOMzA8nJkiNIz/aX29+NTjz2riqi6i8zJqVG35M//4x
 pPSA==
X-Gm-Message-State: APjAAAWA8t4qT7iWkAC+AMVuHN35CdLdKivH3wuFb9AWDIWeQg0OEcBg
 /MWlTwaLa2+ntJXcUk6xGC2omfJi
X-Google-Smtp-Source: APXvYqwWlZW1qNCPxM8NcCTEMPrCL05qdpv0PfCEl47xCrFkdVm6nGjfbnoI7tcMoQ/kcJhqKH0e+g==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr30128441wrn.83.1580234105742; 
 Tue, 28 Jan 2020 09:55:05 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 032/142] meson: keymap-gen
Date: Tue, 28 Jan 2020 18:51:52 +0100
Message-Id: <20200128175342.9066-33-pbonzini@redhat.com>
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
 Makefile       | 38 --------------------------------------
 meson.build    |  1 +
 ui/meson.build | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 38 deletions(-)
 create mode 100644 ui/meson.build

diff --git a/Makefile b/Makefile
index 781d3595ae..54249c6fc2 100644
--- a/Makefile
+++ b/Makefile
@@ -126,44 +126,6 @@ generated-files-y += module_block.h
 
 generated-files-y += .git-submodule-status
 
-KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
-KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
-
-KEYCODEMAP_FILES = \
-		 ui/input-keymap-atset1-to-qcode.c \
-		 ui/input-keymap-linux-to-qcode.c \
-		 ui/input-keymap-qcode-to-atset1.c \
-		 ui/input-keymap-qcode-to-atset2.c \
-		 ui/input-keymap-qcode-to-atset3.c \
-		 ui/input-keymap-qcode-to-linux.c \
-		 ui/input-keymap-qcode-to-qnum.c \
-		 ui/input-keymap-qcode-to-sun.c \
-		 ui/input-keymap-qnum-to-qcode.c \
-		 ui/input-keymap-usb-to-qcode.c \
-		 ui/input-keymap-win32-to-qcode.c \
-		 ui/input-keymap-x11-to-qcode.c \
-		 ui/input-keymap-xorgevdev-to-qcode.c \
-		 ui/input-keymap-xorgkbd-to-qcode.c \
-		 ui/input-keymap-xorgxquartz-to-qcode.c \
-		 ui/input-keymap-xorgxwin-to-qcode.c \
-		 ui/input-keymap-osx-to-qcode.c \
-		 $(NULL)
-
-generated-files-$(CONFIG_SOFTMMU) += $(KEYCODEMAP_FILES)
-
-ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs
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
index 9029821028..5cde258529 100644
--- a/meson.build
+++ b/meson.build
@@ -227,6 +227,7 @@ subdir('stubs')
 subdir('trace')
 subdir('util')
 subdir('crypto')
+subdir('ui')
 
 # Build targets from sourcesets
 
diff --git a/ui/meson.build b/ui/meson.build
new file mode 100644
index 0000000000..cad97635d8
--- /dev/null
+++ b/ui/meson.build
@@ -0,0 +1,34 @@
+keymap_gen = find_program('keycodemapdb/tools/keymap-gen')
+
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
+foreach e : keymaps
+  output = 'input-keymap-@0@-to-@1@.c'.format(e[0], e[1])
+  custom_target(output,
+                output: output,
+                capture: true,
+                build_by_default: true, # to be removed when added to a target
+                input: files('keycodemapdb/data/keymaps.csv'),
+                command: [keymap_gen,
+                          '--lang', 'glib2',
+                          '--varname', 'qemu_input_map_@0@_to_@1@'.format(e[0], e[1]),
+                          'code-map', '@INPUT0@', e[0], e[1]])
+endforeach
-- 
2.21.0



