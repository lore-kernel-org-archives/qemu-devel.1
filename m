Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306C4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFEF021655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeZdfFUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEF021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOCt-00041I-LL
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyB-0003DB-UM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyA-0006My-J4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:27 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:37435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyA-0006L2-B3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:26 -0500
Received: by mail-wm1-x32e.google.com with SMTP id f129so2383371wmf.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g0Za0/5ts6UEf1IGGG8fGTwyEDqYKTDtKmkQ6EBfNWw=;
 b=aeZdfFUe7OxJt+koW/79QA2hya2LXE/Sztk4bu2Mvs5O9iqhFbKns5hmxCCcbFHLvv
 ueKFS5Yd8aBeVjYSTNhfrtK1TjmVX69+/cv66vb56nBHT//H9E+NiwfuQCzyfsN+w+OW
 w+cl8dFtEk/o2dcqHZ4DmUujJCuUkkNC2TBZj0nwuvwnXJnP94PZBSWaN7YeaL3BiwNL
 pHuM5N/qBxNRcRF9CXskDFotuelmJRWajj8Ug54sod7C0VJUi6ZcwMxXpuVQyrGqLDjy
 NJ2JE++eSJcQl/4l2jor2Zx/QP28q55uRBMC/HMynuDH9cArMOlrcG2z0uJAm4ZwqBYg
 eF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=g0Za0/5ts6UEf1IGGG8fGTwyEDqYKTDtKmkQ6EBfNWw=;
 b=BtKADrRvrnoEUNNb+92GsRx9+eOMglro9spKMRX0kAYLRYCM1FVrPT6Su+RcA7XTta
 Rlm7Q4c2PKk0HBIr+1GtGmIC5xIodM933eR5nyEx9Aa5gdiiF21oaitl0z4hzBUljULN
 AyItPji7HqAHWyRKSgca5LxtR8KfhOWiEA3WYZ6RdwtXb5pIeJvdEzao/6AvFHWpH4Qj
 yOBNSJYE9aiV1fdLNB+OjwezEsfc+GkNnrCT7nm53CxCH565w7e1G7Y/SJHXpgkYHgey
 znkXRjNjii7ljfo++xjoWNiDtpk4hN67iahW4NsuId8xcHvDvLVdUd6KH6KuMGzWn0R0
 9qvw==
X-Gm-Message-State: APjAAAVMkRw+qsRpr8pZE0ZeNO4ZPv6+hcBbhleCMU8mPBeTjMss1VnX
 Rgu3Qlzre5dGXOFAsdkLNvrhrxpH
X-Google-Smtp-Source: APXvYqwZnBgipFLkD4UrraBax1CpB73ymi+qa55yrB1StGpErhrkNELeiRVengz4WcI9Fk12uV8GxQ==
X-Received: by 2002:a1c:9903:: with SMTP id b3mr6256518wme.139.1576155205069; 
 Thu, 12 Dec 2019 04:53:25 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 027/132] meson: keymap-gen
Date: Thu, 12 Dec 2019 13:51:11 +0100
Message-Id: <1576155176-2464-28-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
index 9110115..d4ebbbf 100644
--- a/Makefile
+++ b/Makefile
@@ -116,44 +116,6 @@ generated-files-y += module_block.h
 
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
index b53c2dc..8a4a90b 100644
--- a/meson.build
+++ b/meson.build
@@ -211,6 +211,7 @@ subdir('stubs')
 subdir('trace')
 subdir('util')
 subdir('crypto')
+subdir('ui')
 
 # Build targets from sourcesets
 
diff --git a/ui/meson.build b/ui/meson.build
new file mode 100644
index 0000000..cad9763
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
1.8.3.1



