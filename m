Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0797C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACC6207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxrzIb3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACC6207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVlr-00011V-GM
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5N-0008U5-AN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5M-0002P2-6d
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:37 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:34273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5L-0002Nn-Vc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:36 -0500
Received: by mail-wm1-x335.google.com with SMTP id s144so2319378wme.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HFNCZ7pWzXAToecUolMwlXj4aONy0IJRYuCUtjLrwXI=;
 b=gxrzIb3yH8BP2IU7zZG5gjMT+IqsKMqfOdK/RQnd89DC5VLwd4oJ+O/t5EQg58RGY7
 +Rb4QE/PLVb6lCVcYZfhrJlkQdaDqUm22e0N+898vm92ofUNrOvOdI9e0RQbZh2FCudY
 HUB9dJEOvn2jCmdEbap6KfrQlvxYs05yDBEZec4LlHUyHRdgGBd7UyWtKMCFCvLlqp4L
 9icxyFITs37IQIHvh2dJLk6sORxjEix0Q223vd2vVZyqHF5VTfk3a6v7STewpJtcgAme
 BPL7BcuMHHj5fLMgK+n1KY2qZkSAcAqsclDi7ZVYLVots9QJ1kerquSHeFwXXCCanVYw
 F8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HFNCZ7pWzXAToecUolMwlXj4aONy0IJRYuCUtjLrwXI=;
 b=DuAr0sxRtNvpwr1snmbDPt56gMKU+vivFXuSIGXDHVF+BbhlRErhiv0d4kKnKzf0ut
 DZPpQ5iWXP2i7M61afxe0Wd6AxEhrHMmhhwUSgXoChCxYGwYasDGqT6TlFwY+TCbDlsO
 szAVJ1kVxbGlc3IGmKvu3Rzm0EJbwdJvb8OvN6gxRZMitPG7gqA5VVlih8w/aUCtxQt4
 hkTVucWHXQOw7ZGp+6CI3XuCLooF0zdtu4mTAthniVnx9aNS3RdYdC5uasB0XlfI8x+w
 ciO3tV1rHyqLsDvSy4Wtt1cKxCwH46ql63tKcwqgq4a6WKD7CPqzufo7wzWQTTUA8W6H
 o07Q==
X-Gm-Message-State: APjAAAUq0AQVXN4Hjbx4X2zakdO8FbUFlfo1/bxmNokUNT3cL+18O5PT
 z0DApXYFSlIqcoYYliyAmfcr77Rk
X-Google-Smtp-Source: APXvYqygPSBapjuvOQd1q4Y5wQafNPcs5vU8zCn43/hgwx6uvQuSQU0aagq64FfFDHklb8qdyYX0Hw==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr6421449wmi.89.1580234134658;
 Tue, 28 Jan 2020 09:55:34 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 045/142] meson: add macos dependencies
Date: Tue, 28 Jan 2020 18:52:05 +0100
Message-Id: <20200128175342.9066-46-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

There is no probing in configure, so no need to pass them as
variables to meson. Do a regular meson dependency() instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 06f531d2b7..3c398d1bf5 100644
--- a/meson.build
+++ b/meson.build
@@ -9,7 +9,7 @@ config_all_disas = kconfig.load(meson.current_build_dir() / 'config-all-disas.ma
 add_project_arguments(config_host['CFLAGS'].split(),
                       language: ['c', 'objc'])
 add_project_arguments(config_host['QEMU_CFLAGS'].split(),
-                      language: 'c')
+                      language: ['c', 'objc'])
 add_project_arguments(config_host['QEMU_CXXFLAGS'].split(),
                       language: 'cpp')
 add_project_link_arguments(config_host['LDFLAGS'].split(),
@@ -17,7 +17,7 @@ add_project_link_arguments(config_host['LDFLAGS'].split(),
 add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
                            language: ['c', 'cpp', 'objc'])
 add_project_arguments(config_host['QEMU_INCLUDES'].split(),
-                      language: ['c', 'cpp'])
+                      language: ['c', 'cpp', 'objc'])
 
 qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
                     meson.current_source_dir(),
@@ -37,6 +37,10 @@ m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
 socket = []
 version_res = []
+coref = []
+iokit = []
+cocoa = []
+hvf = []
 if host_machine.system() == 'windows'
   socket = cc.find_library('ws2_32')
 
@@ -44,6 +48,12 @@ if host_machine.system() == 'windows'
   version_res = win.compile_resources('version.rc',
                                       depend_files: files('pc-bios/qemu-nsis.ico'),
                                       include_directories: include_directories('.'))
+elif host_machine.system() == 'darwin'
+  add_languages('objc', required: false)
+  coref = dependency('appleframeworks', modules: 'CoreFoundation')
+  iokit = dependency('appleframeworks', modules: 'IOKit')
+  cocoa = dependency('appleframeworks', modules: 'Cocoa')
+  hvf = dependency('appleframeworks', modules: 'Hypervisor')
 endif
 glib = declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split(),
                           link_args: config_host['GLIB_LIBS'].split())
-- 
2.21.0



