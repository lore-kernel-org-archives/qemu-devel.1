Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F55C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8CC2070C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsWVHAC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8CC2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huta4-0005Eu-Rf
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 03:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39118)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hutZ3-00037C-4L
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hutZ2-0008UZ-7W
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:07:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hutZ2-0008U9-1s
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:07:20 -0400
Received: by mail-wr1-x441.google.com with SMTP id p17so86713433wrf.11
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 00:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=B7jGggRJo9D2VuMgtcdSGsa/EIgx9yxFf4WgNNIcVso=;
 b=lsWVHAC3Q2t2jyz2+q+JukaX2sHSa+sHt0jVvfuulN/5tV25ibQs6G1slFuP/w+cMH
 CO808+hHEQ2nT8oPVg/G5+n4u/xG5/0QFqiddSYMiPpm5VK7VYnSirVktMfDtKo0jKuu
 Mw4EeZqSDNkbdVhM4BpJ7gLMmsNb3ru8fFA28qnr+i0Tf34+vKDSLzf+8HoJmxNGshvo
 YrKAauLZxffLO2CSGD8/0GxcCZ50f8PdVTe5e9IAslqmZkjRGp424r+LF8VtKMHcTnYT
 Q6eZw8hPcvuz9lNNGQRtLyGgazX2IhGlx+24GS1oxLmTuJB6M0EMQejUCD5sYxXAEG0M
 lT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=B7jGggRJo9D2VuMgtcdSGsa/EIgx9yxFf4WgNNIcVso=;
 b=CCKwwVvoJbVnvMAgi+arMN/2LDHoHnAWuXbzrtlavGjAeKsTEjlzmFOv+TOt/HhHBw
 h3sQ08dx7zAIIWyLq+g9LjUpNJUj1ScVu0voBPXOaSILm+AtpAzIcnlwDauqqV3I+ks6
 xJDiycSgrGwqk9+Z7g32WTKq39Psdjpttduu7fa5Ob4h1AXuZ6+h6p2iS1sN7HxJ1+PJ
 KGjzne724Th2KsNYsr/46VriyOV/9Fds+waU5bg02dnJ2lK03afug6QuPnKOC6wPfmkC
 YiF3cNmolE3LUJ6GKDlzeLuT6z9oYf6ULpK02SOOl6iaCKGsFo2HOICZMLLFZHvYjYxw
 V12g==
X-Gm-Message-State: APjAAAV23Q0K0MXqjgiJzzzG/XxIdXToTngISqjYrj+EVNVOi4cwRno/
 KeYHr0DbdkU0w1f6GSkdQsKRJCo8
X-Google-Smtp-Source: APXvYqw81DTuoMoXw1uqJa3h5fW6gblVW4wBSmoRoxaMdXJHildTU2uc6Ulv6bmQwp5BLu+xEDYg+A==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr2718168wrq.340.1565075238788; 
 Tue, 06 Aug 2019 00:07:18 -0700 (PDT)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id t13sm103637009wrr.0.2019.08.06.00.07.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 00:07:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 09:07:13 +0200
Message-Id: <1565075233-10882-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565075233-10882-1-git-send-email-pbonzini@redhat.com>
References: <1565075233-10882-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 2/2] configure: define CONFIG_TOOLS here
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

Defining CONFIG_TOOLS on the basis of $(TOOLS) has the disadvantage
of including it also if e.g. qemu-ga is requested.  The correct
information is available in configure, define it there.

This also has the benefit of not installing the manpages for block layer
tools if the only "tool" being built is the guest agent.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 5 ++---
 configure | 3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index e532043..dfd158c 100644
--- a/Makefile
+++ b/Makefile
@@ -87,8 +87,7 @@ endif
 
 include $(SRC_PATH)/rules.mak
 
-# notempy and lor are defined in rules.mak
-CONFIG_TOOLS := $(call notempty,$(TOOLS))
+# lor is defined in rules.mak
 CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 
 # Create QEMU_PKGVERSION and FULL_VERSION strings
@@ -797,7 +796,7 @@ ifdef CONFIG_POSIX
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
-ifneq ($(TOOLS),)
+ifeq ($(CONFIG_TOOLS),y)
 	$(INSTALL_DATA) qemu-img.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
 	$(INSTALL_DATA) qemu-nbd.8 "$(DESTDIR)$(mandir)/man8"
diff --git a/configure b/configure
index 8e17f44..c5a5b44 100755
--- a/configure
+++ b/configure
@@ -6597,6 +6597,9 @@ fi
 if test "$profiler" = "yes" ; then
   echo "CONFIG_PROFILER=y" >> $config_host_mak
 fi
+if test "$want_tools" = "yes" ; then
+  echo "CONFIG_TOOLS=y" >> $config_host_mak
+fi
 if test "$slirp" != "no"; then
   echo "CONFIG_SLIRP=y" >> $config_host_mak
   echo "CONFIG_SMBD_COMMAND=\"$smbd\"" >> $config_host_mak
-- 
1.8.3.1


