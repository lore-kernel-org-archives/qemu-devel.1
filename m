Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291B9C3A5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024E322D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024E322D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0URQ-0000Mz-9i
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPM-0006Ki-5b
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPL-000527-2Q
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0UPK-00051Z-T0
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3511530860A5
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:28:26 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D47160E1C
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:28:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 19:28:09 +0200
Message-Id: <1566408501-48680-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
References: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 21 Aug 2019 17:28:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/13] qemu-ga: clean up TOOLS variable
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

qemu-ga is included in the TOOLS variable without the .exe suffix, and this is
then worked around twice in the Makefile.  Do the right thing in configure
instead.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 4 ++--
 configure | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 85862fb..00825cd 100644
--- a/Makefile
+++ b/Makefile
@@ -681,7 +681,7 @@ clean: recurse-clean
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
 	rm -f $(edk2-decompressed)
-	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga$(EXESUF) TAGS cscope.* *.pod *~ */*~
+	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
@@ -845,7 +845,7 @@ install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstated
 	$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
 	recurse-install
 ifneq ($(TOOLS),)
-	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDIR)$(bindir))
+	$(call install-prog,$(TOOLS),$(DESTDIR)$(bindir))
 endif
 ifneq ($(CONFIG_MODULES),)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_moddir)"
diff --git a/configure b/configure
index 942a73b..e96981b 100755
--- a/configure
+++ b/configure
@@ -6129,7 +6129,7 @@ if [ "$guest_agent" != "no" ]; then
   if [ "$softmmu" = no -a "$want_tools" = no ] ; then
       guest_agent=no
   elif [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" -o "$mingw32" = "yes" ] ; then
-      tools="qemu-ga $tools"
+      tools="qemu-ga\$(EXESUF) $tools"
       guest_agent=yes
   elif [ "$guest_agent" != yes ]; then
       guest_agent=no
-- 
1.8.3.1



