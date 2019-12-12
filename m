Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB76C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5270206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIaz2ieI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5270206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59231 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifORF-0006iI-9y
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyG-0003ML-9j
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyF-0006Wa-4Z
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:32 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34261)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyE-0006Ul-T4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:31 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so2644495wrr.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=09ICg9D+Dn1VQ8tTw8DePRqwSVhY2gWWE2lvsGgxM/A=;
 b=uIaz2ieIEnBqcrjVllovt/9qWH9KD2xjr98j8JEm3fzVJgjIqJZGONyOG3ugCqOzkC
 d0h72eAezo+tsnnoV/JI1CUXUV8b31/5ygT7WbSKVCywdM+5nXNirEajZ0THFQW4P5sQ
 9HOIvUJO9oeyl/OpvxUGr3jZtP27FXKts4u7qFWQ7yiQsD/uWCjiSloOoDUc18KvXvFL
 0+JqUhqqgh1WU/Gb6ulhhVP09+mygqrT2HwxQPhaz7r7oRREPKA1fboFqxOuNDvnkRHt
 3vNeTR7/666Spnebvom1ab+aK1ZLeG0cZzsLonFAN3Pe+2IKCZ7oSwrOudC7os86CoeZ
 7F1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=09ICg9D+Dn1VQ8tTw8DePRqwSVhY2gWWE2lvsGgxM/A=;
 b=O0IputYuR5wInPGU7oMqEcY29w37NtYwmpvWZoQA1Db1+PQok3ovMu93ZR3MDReZft
 cnyU/AKWUIoHC+sSmmk0G5Qp0MxpM32I/sVlGg6DDLfW4FX99Fy/NAjF95zFmFdvxU9I
 uGOj/UMEcOzEUTBkeljg29xST8w/bO3PHR5RKtZ05ySEutw1CnBDAcOoh9OBbEOFIYER
 V3eO4wiT8lfUBboxIKv37dnEdyUJrILxm/BAlAsbyWQ7Ps/ud7zrqa9+qN6AT7tmgsLM
 uXgyZ3PdeuWR25PcbpWeA+0pYj5Ndj5xL01JjgIA3E+KRrtP+zOChUB7KaPhNU++2BZ9
 I3ig==
X-Gm-Message-State: APjAAAWq9gHqmOuhTP1F4mLy01UoaWa84AG+8Az6j7t6cY5DXbfZKirT
 bE9+SAxIb6O24H/nFOwItWDv1xNh
X-Google-Smtp-Source: APXvYqzLe44TG31SEJ6wxMi9v0jCtYgOjapmwA5l86ZyMYWIk/xYPQzQ8Mr93j8orO+psQDnmXQOWQ==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr6102272wru.65.1576155209765; 
 Thu, 12 Dec 2019 04:53:29 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 032/132] meson: uncompress edk2 bios
Date: Thu, 12 Dec 2019 13:51:16 +0100
Message-Id: <1576155176-2464-33-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 Makefile            |  4 ----
 meson.build         |  2 ++
 pc-bios/meson.build | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 4 deletions(-)
 create mode 100644 pc-bios/meson.build

diff --git a/Makefile b/Makefile
index 0a6615c..b880265 100644
--- a/Makefile
+++ b/Makefile
@@ -103,9 +103,6 @@ generated-files-y += module_block.h
 generated-files-y += .git-submodule-status
 
 edk2-decompressed = $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
-pc-bios/edk2-%.fd: pc-bios/edk2-%.fd.bz2
-	$(call quiet-command,bzip2 -d -c $< > $@,"BUNZIP2",$<)
-
 # Don't try to regenerate Makefile or configure
 # We don't generate any of them
 Makefile: ;
@@ -226,7 +223,6 @@ $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
 $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
-$(SOFTMMU_ALL_RULES): $(edk2-decompressed)
 
 .PHONY: $(TARGET_DIRS_RULES)
 # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
diff --git a/meson.build b/meson.build
index de5a26e..00c0767 100644
--- a/meson.build
+++ b/meson.build
@@ -312,3 +312,5 @@ if have_tools
     subdir('contrib/ivshmem-server')
   endif
 endif
+
+subdir('pc-bios')
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
new file mode 100644
index 0000000..5524b95
--- /dev/null
+++ b/pc-bios/meson.build
@@ -0,0 +1,21 @@
+bzip2 = find_program('bzip2')
+
+fds = [
+  'edk2-aarch64-code.fd',
+  'edk2-arm-code.fd',
+  'edk2-arm-vars.fd',
+  'edk2-i386-code.fd',
+  'edk2-i386-secure-code.fd',
+  'edk2-i386-vars.fd',
+  'edk2-x86_64-code.fd',
+  'edk2-x86_64-secure-code.fd',
+]
+
+foreach f : fds
+  custom_target(f,
+                output: f,
+                input: '@0@.bz2'.format(f),
+                capture: true,
+                build_by_default: true,
+                command: [ bzip2, '-dc', '@INPUT0@' ])
+endforeach
-- 
1.8.3.1



