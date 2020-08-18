Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6085C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9388F207DE
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgINbhfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9388F207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82tI-00082k-NQ
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82L2-0004Yx-0d
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Ku-0007TU-LR
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I6xP8/Duu/tVrACwdy4HLYOabdOO1oOw9holu0fd0Ig=;
 b=WgINbhfDBYWAZWfQ9LTBRhVuNaPnkeR8C3LYksMNgqL+XGAY8k/SYE86kNXRpYljlHaOgd
 SRw4/b2QMmJKi4nmbBAhcWawl52RaF2eAutZCXYkbwDIrtCJoHZBTON4tMDwrCuulqyVZk
 pH8N5vKOM/+y4CIo+KVrQJE2DlIDrFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-_k_3M3MEMqW2UyfTOYAaeg-1; Tue, 18 Aug 2020 10:11:30 -0400
X-MC-Unique: _k_3M3MEMqW2UyfTOYAaeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D38232FD0A
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:11:29 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98E9D5D757
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:11:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 067/150] configure, Makefile;
 remove TOOLS and HELPERS-y variable
Date: Tue, 18 Aug 2020 10:09:02 -0400
Message-Id: <20200818141025.21608-68-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 414c631aee..4ce2f4b2de 100644
--- a/Makefile
+++ b/Makefile
@@ -129,8 +129,6 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-HELPERS-y =
-
 # Sphinx does not allow building manuals into the same directory as
 # the source files, so if we're doing an in-tree QEMU build we must
 # build the manuals into a subdirectory (and then install them from
@@ -179,7 +177,7 @@ dummy := $(call unnest-vars,, \
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
+all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) recurse-all modules
 
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
@@ -291,7 +289,7 @@ clean: recurse-clean ninja-clean clean-ctlist
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
-	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
+	rm -f TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 
@@ -443,12 +441,6 @@ export DESTDIR
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
@@ -708,16 +700,6 @@ endif
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
index cca4ed382e..e47a3acc3a 100755
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



