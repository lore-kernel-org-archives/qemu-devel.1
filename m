Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B88C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7A2205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tu90EZe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7A2205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7grI-0004hb-Io
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHS-00058R-98
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:34 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHQ-0006DT-SW
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:34 -0400
Received: by mail-wr1-x441.google.com with SMTP id r4so15225494wrx.9
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0hJu4Nz1L7VKg35xvN8iIIF1HPKnw8palwRCJBCZ874=;
 b=tu90EZe4o0mdU3WmUMFbe6V+G6fpABfmEFPbHQjP57lucp1x0CAWeX3gRFZIXHdC+a
 zg5cj/tl6XBmN8plTGBhw70fN5jzg7hoTk8INlwv6L317n0iF40RK/l5QU1mVlOIOAGj
 tnbAK+lLLojZ93OfrT4uwoICUjLFxd0huxZWHocJakqpAjBROBuJCHpso3ARLOdHGwks
 rqEBQnDCtntdnj7vpu8madMiF9HCPJUsiFQNYm5T5KLTElO5tEbCIfBfHl+uVXlWpUME
 i1N0wIqJvVlAiLQ1TL1F6+yNjdkafuGcdQGdKz5UeVF6OctRhoPQaikg12XsOnqJpwEF
 HjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0hJu4Nz1L7VKg35xvN8iIIF1HPKnw8palwRCJBCZ874=;
 b=Op4RV+o+77tJa8EdwS0i3dvZ6lcywIUTBNyUC0xnbc6alSQRDvwdb/OS2zzTJcnmmI
 y8pJjqa90ZTr3YE01eJ1pacwEShGw/YElmpczE3LYdRUQdIFXeegQ3xGHtpIsbNhI70q
 +/AW54/Ru6my+TizwzyLgKIF1+8R1epzyriC0RKfvuuj26vUC6wLLp4cXd+MhaY2fWKv
 f9pzlyFSSmgwN67kalL3z2kXp+/EOdfihcnVicgusSRqQdyw0XW1QNLGnWZM49BwCaku
 JTDDCS+FjH6LR6ubt1Oqm/nYZLy4eY//3Lzn4fOgRnMVkIFHP+WhIlmSFzfs4kwQMRms
 yYKg==
X-Gm-Message-State: AOAM532hkcaVWqjxddFu7XhqRstf1OlG5AT2ORFe0MKUVDvyPmVvCDoa
 3nNoTFSpcnG3FpbeVi8p6wYVAxvK6O8=
X-Google-Smtp-Source: ABdhPJyDPORSldIDe95s81HvRlKr+CLtLwzkwGV/BVrsV5vT9M132+Tk5u3SJOAj52IG2eHx1Bm8Pw==
X-Received: by 2002:adf:e704:: with SMTP id c4mr16993917wrm.81.1597675110742; 
 Mon, 17 Aug 2020 07:38:30 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.30 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 066/150] configure, Makefile;
 remove TOOLS and HELPERS-y variable
Date: Mon, 17 Aug 2020 16:35:59 +0200
Message-Id: <20200817143723.343284-67-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Everything involving tools is now done by meson.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 22 ++--------------------
 configure |  7 -------
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/Makefile b/Makefile
index cd8d9a0b02..135175c5ef 100644
--- a/Makefile
+++ b/Makefile
@@ -127,8 +127,6 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-HELPERS-y =
-
 # Sphinx does not allow building manuals into the same directory as
 # the source files, so if we're doing an in-tree QEMU build we must
 # build the manuals into a subdirectory (and then install them from
@@ -177,7 +175,7 @@ dummy := $(call unnest-vars,, \
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
+all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) recurse-all modules
 
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
@@ -289,7 +287,7 @@ clean: recurse-clean ninja-clean clean-ctlist
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
-	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
+	rm -f TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 
@@ -441,12 +439,6 @@ export DESTDIR
 install: all $(if $(BUILD_DOCS),install-doc) \
 	install-datadir install-localstatedir install-includedir \
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
@@ -706,16 +698,6 @@ endif
 				$(call print-help-run,$(t)/fuzz,Build fuzzer for $(t)); \
 		))) \
 		echo '')
-	@$(if $(HELPERS-y), \
-		echo 'Helper targets:'; \
-		$(foreach t, $(HELPERS-y), \
-		$(call print-help-run,$(t),Build $(shell basename $(t)));) \
-		echo '')
-	@$(if $(TOOLS), \
-		echo 'Tools targets:'; \
-		$(foreach t, $(TOOLS), \
-		$(call print-help-run,$(t),Build $(shell basename $(t)) tool);) \
-		echo '')
 	@echo  'Cleaning targets:'
 	$(call print-help,clean,Remove most generated files but keep the config)
 	$(call print-help,distclean,Remove all generated files)
diff --git a/configure b/configure
index 0262b7b661..a77177f4e2 100755
--- a/configure
+++ b/configure
@@ -6667,12 +6667,6 @@ if [ "$eventfd" = "yes" ]; then
   ivshmem=yes
 fi
 
-tools=""
-if test "$want_tools" = "yes" ; then
-  if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
-    tools="qemu-storage-daemon\$(EXESUF) $tools"
-  fi
-fi
 if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
     if test "$virtfs" != no && test "$cap_ng" = yes && test "$attr" = yes ; then
@@ -7768,7 +7762,6 @@ else
   QEMU_INCLUDES="-iquote ${source_path}/tcg/${ARCH} $QEMU_INCLUDES"
 fi
 
-echo "TOOLS=$tools" >> $config_host_mak
 echo "ROMS=$roms" >> $config_host_mak
 echo "MAKE=$make" >> $config_host_mak
 echo "INSTALL=$install" >> $config_host_mak
-- 
2.26.2



