Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06C9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7EC22522
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGKEMMme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7EC22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVJd-0002oT-Ht
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5H-0008Fv-2u
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV56-0001kT-T3
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:30 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV55-0001fr-OV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:20 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so17096524wrr.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D3HietXjfaznZQAPpU65SKpjUssafj9P/fN/yGo5EEQ=;
 b=PGKEMMmeArOwLlPUME2g34wQUGoxXCpJC82w96O1sosZA4VxFO6O/aiIOkPZyaB9nj
 EPRexJ/NxcMDP+qHPzFecYlkUoC5TJfhlvGBmpIYUFsVh+xdy93sKl+2j/sqtUGmbXP7
 6fL0XFC8MRqyOtq04aJRQCkbCYIRJquItia19sWlEM/5BIszAuhhhqbC3CKIlKwzB/zD
 utfTHdGohg8uLt9z+r8QahlYHVvRk2a/gswAs85FZllErAHPTuEZdH0mMgewXeuNZd7f
 U2GAs/X8LktdHLKKYe/09zTyYXxOVGhH//TyZ9HnGJ6qsoa5/jxDT/QGBLBIizFYc2Bk
 gp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=D3HietXjfaznZQAPpU65SKpjUssafj9P/fN/yGo5EEQ=;
 b=kNg3tN0IG7AQBViDKsxQN7bMAk1rgNaf6tLEf2PwrBrvvdSPrQVsAcYS2CZIu96TTZ
 iEepJ3jgKeDp66WeqNwJ/H5Aceox42Ldlxuq4RaLfluiVH6kgYCHzpi0vL3PhKa4LCdL
 jgC9GAlTK0hc3PbsIwaRhklVbJT457NbUUNSRJC2wq9OdqZk1Si5dwPWJ0qGxj2wuWaz
 H9z3xuWNT37tj3lXLmtlhYG+3S7/IA9IwwSUybhhSis0OPn2ByHO/nXTZWKq2tcQX08g
 Un1i5ZXjxW0CHXFxPg7ZhNlDUyBFGINJGpH1Uznie1U1ZGtcy9L5ar00fER6dMRC7zSK
 U8Iw==
X-Gm-Message-State: APjAAAWIbdIlz4gnx0fLXKK3LMVwOnYQkROECz83EEpuKhlI1unEaIlV
 PrhMXC9JfWiSmLgx/sLs7vUq9Ry0
X-Google-Smtp-Source: APXvYqwEW064tpeDhlk76iY8uYlqPQLPlF0dQH4GOomNztvKX05+mAtK3X1BghZeP8Gy0OY0nXGWIg==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr30129194wrn.83.1580234117518; 
 Tue, 28 Jan 2020 09:55:17 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 037/142] meson: uncompress edk2 bios
Date: Tue, 28 Jan 2020 18:51:57 +0100
Message-Id: <20200128175342.9066-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile            |  7 -------
 meson.build         |  2 ++
 pc-bios/meson.build | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)
 create mode 100644 pc-bios/meson.build

diff --git a/Makefile b/Makefile
index 3629563bc6..e863250107 100644
--- a/Makefile
+++ b/Makefile
@@ -113,9 +113,6 @@ generated-files-y += module_block.h
 generated-files-y += .git-submodule-status
 
 edk2-decompressed = $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
-pc-bios/edk2-%.fd: pc-bios/edk2-%.fd.bz2
-	$(call quiet-command,bzip2 -d -c $< > $@,"BUNZIP2",$<)
-
 # Don't try to regenerate Makefile or configure
 # We don't generate any of them
 Makefile: ;
@@ -249,9 +246,6 @@ $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
 $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
-ifdef DECOMPRESS_EDK2_BLOBS
-$(SOFTMMU_ALL_RULES): $(edk2-decompressed)
-endif
 
 .PHONY: $(TARGET_DIRS_RULES)
 # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
@@ -350,7 +344,6 @@ clean: recurse-clean
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
-	rm -f $(edk2-decompressed)
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
diff --git a/meson.build b/meson.build
index 08e37fd677..585fc7aca5 100644
--- a/meson.build
+++ b/meson.build
@@ -328,3 +328,5 @@ if have_tools
     subdir('contrib/ivshmem-server')
   endif
 endif
+
+subdir('pc-bios')
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
new file mode 100644
index 0000000000..8a3d335545
--- /dev/null
+++ b/pc-bios/meson.build
@@ -0,0 +1,23 @@
+bzip2 = find_program('bzip2')
+
+if 'DECOMPRESS_EDK2_BLOBS' in config_host
+  fds = [
+    'edk2-aarch64-code.fd',
+    'edk2-arm-code.fd',
+    'edk2-arm-vars.fd',
+    'edk2-i386-code.fd',
+    'edk2-i386-secure-code.fd',
+    'edk2-i386-vars.fd',
+    'edk2-x86_64-code.fd',
+    'edk2-x86_64-secure-code.fd',
+  ]
+
+  foreach f : fds
+    custom_target(f,
+                  output: f,
+                  input: '@0@.bz2'.format(f),
+                  capture: true,
+                  build_by_default: true,
+                  command: [ bzip2, '-dc', '@INPUT0@' ])
+  endforeach
+endif
-- 
2.21.0



