Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B298BC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 15:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A862071B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 15:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmOaOEu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A862071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCPXI-0002uA-Lq
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 11:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kCPWR-0002So-33
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 11:45:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kCPWP-0008IK-H8
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 11:45:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id e11so712693wme.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=X/Fax2FNyxBxy5u0eoIHCfhXtcAhzrgVnFOsa7MwnFk=;
 b=rmOaOEu0RI+uVvALl77NNXq1xqxskodPauGS1HcIQWhhB2BjHRvNAyexFo/kcXHY+9
 chkEJAXYlPw5FvcPQ/HAZtRC2K2f2+mORvR1ZY26Dm45CPMOVKZnGQiJnEhJvZAyCsZS
 Cc8CSP7UbnSURBmGj5xZm6tNSm80sXbsfBLiwPa0mdRYIAZmTOmz9YZYHWwIKnG72fJv
 CJ2RdBJSNLpDrYCxyVkW96tD9Kgi0ijH/lt7z7h6CKDLpLkCRaPWBLpflOC/HGyFujOG
 GBI3JHD3pSCtkYn9QlL1fbpuoTnwUNRi8s73O0AIm4vt6v5rlqrU0Ou0/loJM04lad6f
 7SDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=X/Fax2FNyxBxy5u0eoIHCfhXtcAhzrgVnFOsa7MwnFk=;
 b=PO+GZJLfod0p8YLmiesaDB3rNfmKZiGdMB5NjdENuzZ7H0afWKL1Q7t9TEL0SsVzBE
 skAG7FJMRoUIkyL1nxAH3hITZNxdoShi0S+nZ+ID2J0uPx9s66vOA87CpY57UjrczEbD
 IK3ck/bIuW4TZ1PzEGwmO+3BGIluPpXzj+bqkJfABS2ASg2kMyiaGW6nsxZG/uMm0/9L
 eGSbxMVYUn8Ca4/SE4TlueMD1CYnSX0UU+GAVYA03BOz6A+RtKUTjXCIfPQTaRB+zt/g
 mfKG8ZEFibqjJ2V4Rhni5N3Lceeeqb8yHli2E70G+4KxSF+J8ZD2WupRCNn0cl1j5wEv
 e60g==
X-Gm-Message-State: AOAM533E87n+VnhjsIrEp8tf38Z1tdkw7YGiw5AHEmBYguG/r/EBbtu7
 W4ugJseLQ1Y0otuXxxlYA2HM6JdOl8g=
X-Google-Smtp-Source: ABdhPJw2+6q8kBs1KvadcIIToaEJb8ykwx9fWCxdB2Nu7XZbYP52sZMZnwFIEGCNix7SpXNcyewLQg==
X-Received: by 2002:a05:600c:296:: with SMTP id
 22mr7915733wmk.154.1598802329846; 
 Sun, 30 Aug 2020 08:45:29 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:5983:fbc9:7f6f:b2b6])
 by smtp.gmail.com with ESMTPSA id z8sm7194332wmf.42.2020.08.30.08.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2020 08:45:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: add pixman dependency to UI modules
Date: Sun, 30 Aug 2020 17:45:39 +0200
Message-Id: <20200830154539.240902-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pixman used to be included directly in QEMU_CFLAGS and therefore the
include path was added to every compiler invocation.  Now that (just
like basically everything else) it is a separate dependency, we
need to add it to all build target, especially UI modules that need
it due to their including ui/console.h.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/meson.build b/ui/meson.build
index aa8aa31516..82f60756d9 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -40,7 +40,7 @@ ui_modules = {}
 
 if config_host.has_key('CONFIG_CURSES')
   curses_ss = ss.source_set()
-  curses_ss.add(when: [curses, iconv], if_true: files('curses.c'))
+  curses_ss.add(when: [curses, iconv], if_true: [files('curses.c'), pixman])
   ui_modules += {'curses' : curses_ss}
 endif
 
@@ -48,7 +48,7 @@ if config_host.has_key('CONFIG_GTK')
   softmmu_ss.add(when: 'CONFIG_WIN32', if_true: files('win32-kbd-hook.c'))
 
   gtk_ss = ss.source_set()
-  gtk_ss.add(gtk, vte, files('gtk.c'))
+  gtk_ss.add(gtk, vte, pixman, files('gtk.c'))
   gtk_ss.add(when: [x11, 'CONFIG_X11'], if_true: files('x_keymap.c'))
   gtk_ss.add(when: [opengl, 'CONFIG_OPENGL'], if_true: files('gtk-egl.c'))
   gtk_ss.add(when: [opengl, 'CONFIG_GTK_GL'], if_true: files('gtk-gl-area.c'))
@@ -71,7 +71,7 @@ endif
 
 if config_host.has_key('CONFIG_SPICE') and config_host.has_key('CONFIG_GIO')
   spice_ss = ss.source_set()
-  spice_ss.add(spice, gio, files('spice-app.c'))
+  spice_ss.add(spice, gio, pixman, files('spice-app.c'))
   ui_modules += {'spice-app': spice_ss}
 endif
 
-- 
2.26.2


