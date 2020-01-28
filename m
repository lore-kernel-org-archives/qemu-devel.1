Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1733C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70287214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlxOaWKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70287214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVR7-0004El-IZ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5f-0000Vo-SR
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5e-000327-39
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:55 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5c-0002yM-UX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:54 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so17098584wrr.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DIpao2wiSZrcXVkYxq+H6UyeJnhxpyHCws3dP6NHkE4=;
 b=QlxOaWKZWXAlURUEfvZdKGCV+JtcT4lNDW8x9Mx6N6jzChAjrFPSn9am+TAk7YAAXP
 6b0+ZOOG2GEOeXbRUgI+1Dx9bWq9Z/5kFCD/gBhH/WBKF1FQElQgP5FCNPFlLQPU6Zn/
 P6GoxlCYnItPHnc1Hf06yWTEiKKbY9FiXzgzzLVeKgzL/bLhx8nvC1TuOgpp4w5niJXv
 iloF1WXAxO1XGpzwRndnywXQmrttJnyXeHr/HdgaHCY2jl3aLh4xs27CPVbg8iQsxnR5
 qa+qHQddzVGOb98GQCdLIzpYlgYztmE+NMRvgeXe8Fi0uOOZUycabhGWl0d/l2ppr65L
 3vHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DIpao2wiSZrcXVkYxq+H6UyeJnhxpyHCws3dP6NHkE4=;
 b=LCdCjzzGOvHQ5JkF7N/P7ZMUYDQqGhuxTexxIx9M5IZP0IN8EggdQUgAOVTFxbFP5w
 tG9IWtlUNqT3ezdox5CvPvaxCKpcDl3j/0mbwdf27B0yOO2mwVUtG7Z7oInXrqIzCCUT
 gAW+Y9ZEHI3phgWsVBa1xM4F5LKfzmvR7ay3iCyxJWF+KWbs6sX57WvnabKkmq4OaI7M
 bYBFpCoKJYOmE8WIvTuBIWD2mA9enQIDM58Fx0au5E9z9oVomopbSLVxVEHpKlu19oH7
 TQ7Do+cHJ1X5sua52X+g/s9nX+qhPbDVMZuyofAbH3EKuFUtMiMWrv+aiyJbjGd+IyFb
 s82g==
X-Gm-Message-State: APjAAAVxKEnHzaXe9DhlUWVcDs8yLGwndJBS38hA8jUKvT+X2wEudXGn
 qCC2f/IeWt/AtBwtwsfohIPjZEP0
X-Google-Smtp-Source: APXvYqy5jLAHtBs1NiZ8+/hWuchQF0EGULWU/PpOsczzlDSkIQ3Nyp7wEMYFVjuzTw5lDHtED3YzRA==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr29687093wrs.365.1580234150412; 
 Tue, 28 Jan 2020 09:55:50 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 051/142] configure, Makefile;
 remove TOOLS and HELPERS-y variable
Date: Tue, 28 Jan 2020 18:52:11 +0100
Message-Id: <20200128175342.9066-52-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Everything involving tools is now done by meson.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 12 ++----------
 configure |  2 --
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index ee79c2dbfa..25eb7336cc 100644
--- a/Makefile
+++ b/Makefile
@@ -124,8 +124,6 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-HELPERS-y =
-
 # Sphinx does not allow building manuals into the same directory as
 # the source files, so if we're doing an in-tree QEMU build we must
 # build the manuals into a subdirectory (and then install them from
@@ -165,7 +163,7 @@ dummy := $(call unnest-vars,, \
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
+all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) recurse-all modules
 
 TARGET_DIRS_RULES := $(foreach t, all clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
 SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_DIRS))
@@ -265,7 +263,7 @@ clean: recurse-clean
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
-	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
+	rm -f TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 
@@ -415,12 +413,6 @@ install: all $(if $(BUILD_DOCS),install-doc) \
 	install-datadir install-localstatedir install-includedir \
 	$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
 	recurse-install
-ifneq ($(TOOLS),)
-	$(call install-prog,$(TOOLS),$(DESTDIR)$(bindir))
-endif
-ifneq ($(HELPERS-y),)
-	$(call install-prog,$(HELPERS-y),$(DESTDIR)$(libexecdir))
-endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
 endif
diff --git a/configure b/configure
index 11586bfc20..a9919d5c58 100755
--- a/configure
+++ b/configure
@@ -6203,7 +6203,6 @@ if [ "$eventfd" = "yes" ]; then
   ivshmem=yes
 fi
 
-tools=""
 if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
     if test "$virtfs" != no && test "$cap_ng" = yes && test "$attr" = yes ; then
@@ -7471,7 +7470,6 @@ else
 fi
 QEMU_INCLUDES="-iquote ${source_path}/tcg $QEMU_INCLUDES"
 
-echo "TOOLS=$tools" >> $config_host_mak
 echo "ROMS=$roms" >> $config_host_mak
 echo "MAKE=$make" >> $config_host_mak
 echo "INSTALL=$install" >> $config_host_mak
-- 
2.21.0



