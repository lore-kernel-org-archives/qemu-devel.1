Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D1BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D602173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxXvylsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D602173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWII-0000Kr-2b
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8a-00059b-HR
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8V-0001Yp-Ez
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:56 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:54072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8V-0001TN-7C
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:51 -0500
Received: by mail-wm1-x32b.google.com with SMTP id s10so3527307wmh.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JbeZl8G2hVERJ1+vh/C+PluJnq1SmmDcr55TtlNTIbg=;
 b=GxXvylsfb1wHJRUFFouIYV25hyYAyjxqHz2IXrWz16znmbAFU/nNu18dBhbC/bXvHF
 oKGorTYgXoZnWIgxkAG8s9/Kiiz7oSHTDAeRI4KIlOyQqR8d5SC+UdvQsu9PiiEAqJ0H
 +g5yMhDuVN3kDvA0+dXsHSNgbOo2931emqCWEgQP1GFv0mIPEMtfImBCb8VNu6pklvCg
 x0AQeHnhXnBi2g3vLMDPU7gxV4r6qUWSFdljnIEEfDOpCayrRdghUYfQo3VNwRlyVxtN
 +dhxCH8vinBGsLY3jJZeE+cH2tn3rIs22NiG2mAymLHlbUj9Fq4S1SnZk5ac+hQSYnVK
 0ExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JbeZl8G2hVERJ1+vh/C+PluJnq1SmmDcr55TtlNTIbg=;
 b=JqoLJz6hqEF1CK0bwlPfqx2skxZ1IYVSp90WT8BjmE2+AUrIb8L7bBEgfrsTpxCMDX
 OzsKSBA/Ba6IP6mIjSrunsYKGqMMI7J5jds3cUtW23RpMmAQ1XEHq8deOogbDuolyiMA
 LS2CCFoXz2d/MlNYgEFBbDlW4RtI+wHq5mlFWr7RMGbdQA9jsvADQe1kgozEK6bKbuSB
 801qVlNci8M+8QtcOrjBoyXycq+EuboMGuNTzda7RLWVMIJ9U5izawlJTHOfhOPErRaf
 yNBV0MKR3CYzuE1wQuGKFNgQnoX7rtyyPqAiVkB5MDr6BLZGwTGTiu/kK3hizhJExn8z
 YTNQ==
X-Gm-Message-State: APjAAAWjZGn8ndSLzR01vAhTSJUB98gZfjzRl4Odld05jlH2ZolJo7p+
 C0TyMAqvTYp1WK6Gs5CshPbsFDgf
X-Google-Smtp-Source: APXvYqw9qB3kKY8FRin4anxlZvlmDP3XFUqyZh8cGz18A3wstMlMCG/XCOHACNuVM9odhd1/BFgfMg==
X-Received: by 2002:a1c:9dcb:: with SMTP id g194mr6200482wme.53.1580234328875; 
 Tue, 28 Jan 2020 09:58:48 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 127/142] meson: install some scripts
Date: Tue, 28 Jan 2020 18:53:27 +0100
Message-Id: <20200128175342.9066-128-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
---
 Makefile            | 3 ---
 meson.build         | 1 +
 scripts/meson.build | 3 +++
 3 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 scripts/meson.build

diff --git a/Makefile b/Makefile
index 7c1e6d9e9c..98582518a8 100644
--- a/Makefile
+++ b/Makefile
@@ -265,9 +265,6 @@ ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 
 install: all install-datadir install-localstatedir \
 	$(if $(INSTALL_BLOBS),$(edk2-decompressed))
-ifdef CONFIG_TRACE_SYSTEMTAP
-	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
-endif
 ifneq ($(BLOBS),)
 	set -e; for x in $(BLOBS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
diff --git a/meson.build b/meson.build
index 6d1fc2fb19..cd6e41b6d0 100644
--- a/meson.build
+++ b/meson.build
@@ -968,6 +968,7 @@ if have_tools
   endif
 endif
 
+subdir('scripts')
 subdir('pc-bios')
 subdir('docs')
 
diff --git a/scripts/meson.build b/scripts/meson.build
new file mode 100644
index 0000000000..e8cc63896d
--- /dev/null
+++ b/scripts/meson.build
@@ -0,0 +1,3 @@
+if 'CONFIG_TRACE_SYSTEMTAP' in config_host
+  install_data('qemu-trace-stap', install_dir: get_option('bindir'))
+endif
-- 
2.21.0



