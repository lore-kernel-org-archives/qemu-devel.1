Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44993C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B272070C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw/kKQf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B272070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hutZV-0003xn-CY
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 03:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39101)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hutZ2-00036y-Cx
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hutZ1-0008UF-Gt
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:07:20 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hutZ1-0008Ts-8D
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:07:19 -0400
Received: by mail-wm1-x341.google.com with SMTP id x15so77032045wmj.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 00:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=oqNyddmJ8F1AiMMSUZkMF5QKSdRh9MnwV5yqwAOZnYU=;
 b=Lw/kKQf5eSbn4xX6IeL3LSttPESHipjI/17puzNU9RcamCbWSYdPzlZexscPxrP4Jr
 4h2qV2oTwZBe2gCdBLetT+IquUxEqaU10fiu6tMtJWM7C3vnICvLSMFyKHh+xFuTL7+H
 BaSzd9c9+mL/KgLvavQFbtdeU4aARYEKvkYyOHqfbhQysRaO+hv7k/O7jooemHW5Zn1T
 w04pqVCEaG6OUNrLAQmwIdQKk/NK5DKeqPVip1dTsQ1yxKmPO9GcSzEgHDJRyw48ppYT
 /ZqLkeVDIxAHzx4edpOqu/+Zzf55DnqAzJwTn2ILFE5EHFAvKdULVF3GTKYBfZ6162mL
 Wp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=oqNyddmJ8F1AiMMSUZkMF5QKSdRh9MnwV5yqwAOZnYU=;
 b=AUiF65Cm88AunEu78BdpHKjjQFW1+kXESpW2Ra32/gdlgemW2URGTEgjiLBOxmmEsc
 +C3aQqqH2SV3UQiFgjxlZaWVdSgXNVGlXr9fYYdWJVM3p+DU6ZDs+rDWsTNt29x5iopO
 HTxse+kAXrHqbhn615Q/j1pLs9s2rGKIYoek7HlXCDGmSH3ysLy9uwkYcoP/5zyhzRD7
 +oJQG98HRxEy7U3gcz/OTqtc6V/5i/SvrEzox0Lw81n+63pQ4Qu+f4MsGx/6eRL/7cpN
 15B1o8fu5T6sSY0fjWDqWogiwjl9ar0578Zm5k49ZHzlrUKEcOwRukgB6JEryGUGreBl
 RB6A==
X-Gm-Message-State: APjAAAVo0Pkr/TeRf6yLjZ25p1xSMLsSgHchol7TeUUMv48niLciWqQa
 TVPX11Qs2zXqwfPU1UgCrqcaaDvF
X-Google-Smtp-Source: APXvYqw0eoxdrj7p4QCqQDD7lRepjqi+sTpQO9bAgi34Ra9GS0zxydjHwTeQlyjrLM9tVQ0bdUmTcQ==
X-Received: by 2002:a1c:c5c2:: with SMTP id v185mr2966258wmf.161.1565075237892; 
 Tue, 06 Aug 2019 00:07:17 -0700 (PDT)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id t13sm103637009wrr.0.2019.08.06.00.07.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 00:07:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 09:07:12 +0200
Message-Id: <1565075233-10882-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565075233-10882-1-git-send-email-pbonzini@redhat.com>
References: <1565075233-10882-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 1/2] qemu-ga: clean up TOOLS variable
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
index cfb18f1..e532043 100644
--- a/Makefile
+++ b/Makefile
@@ -669,7 +669,7 @@ clean:
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
 	rm -f $(edk2-decompressed)
-	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga$(EXESUF) TAGS cscope.* *.pod *~ */*~
+	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
@@ -832,7 +832,7 @@ ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstatedir \
 	$(if $(INSTALL_BLOBS),$(edk2-decompressed))
 ifneq ($(TOOLS),)
-	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDIR)$(bindir))
+	$(call install-prog,$(TOOLS),$(DESTDIR)$(bindir))
 endif
 ifneq ($(CONFIG_MODULES),)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_moddir)"
diff --git a/configure b/configure
index 5c79145..8e17f44 100755
--- a/configure
+++ b/configure
@@ -6118,7 +6118,7 @@ if [ "$guest_agent" != "no" ]; then
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



