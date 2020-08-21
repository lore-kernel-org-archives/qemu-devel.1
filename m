Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55161C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246772063A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yg9dj3/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246772063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k992G-0000hm-FH
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 11:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k991T-0008Fx-0u
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k991R-0006Qa-Fc
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598023923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hlkdlpuLwgIna/UKj+y6wdSkzPoctNh3j/Kz+JXFBIU=;
 b=Yg9dj3/lkphRvAtONYnq/mnUxomRug/pEJi3eU4X0BXjg4xEzKg+XC1sedqrEGUaOHsA0H
 U/oE90xg72ocwT0Rw2WbUR4Ka/3T0DhRmoX8jE2u+rprrlUSsm5z8+A5PGxgXLe14RvJEA
 ap/MssmxdmOZmhe2yUbf8m3iaiqfZvE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-JEjMchzBNDOQuxdp6gMJIA-1; Fri, 21 Aug 2020 11:31:59 -0400
X-MC-Unique: JEjMchzBNDOQuxdp6gMJIA-1
Received: by mail-wr1-f72.google.com with SMTP id s23so650008wrb.12
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 08:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hlkdlpuLwgIna/UKj+y6wdSkzPoctNh3j/Kz+JXFBIU=;
 b=dpUVR5BsE/rjHgXvJQm8+lfHkD39/R+028H4Ow1g/o9/lgq4IY0es+R+F3r5oKdaKq
 rN8QhKTHWXFOCjRyA5KnhHkDM5aCDJhW+uDyvJUJUkAZYbeoTuiZT84KuzZR8M9NNYCn
 n+szFmkmd294BdxUhRnYr1e8m72jFVm9gqai6pzMtKwOYq8fG0CuNyc25si1czfw7N/Y
 +/sYeq6SpYLgLZEDp5p7LzIo39oUPb+fseOax4hLlQiteGHc9VO/ob7ujGMu42UtTFBl
 DebOQEfmX1ZuQXjG9swUY+DeiSHPJstPtLyWBYbGCsFVa9Va1DDKXUVeIrmrpjDu8CQw
 NSlA==
X-Gm-Message-State: AOAM531phABeNvUOkgq2YSRiJns7RWsaE7XRPS95wzSeT03eIcH9Wb8v
 0/sK599CoieyiVu4mqFid/gSg4QsKk4sOvsfi9Dl5M0cD1yYl9hNkWULCB5IlKD8nAe2vOabF4B
 3dYtUa7eknDMfi4Q=
X-Received: by 2002:a1c:4b17:: with SMTP id y23mr3801291wma.143.1598023918309; 
 Fri, 21 Aug 2020 08:31:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwS0EH8eM4rXMJXMsSUkAdR7TvHqbIoqF8pHhdUYeloX8+IXGvZqSIk6msPeXP9Dhx/ZqR1UQ==
X-Received: by 2002:a1c:4b17:: with SMTP id y23mr3801275wma.143.1598023918095; 
 Fri, 21 Aug 2020 08:31:58 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y84sm6008112wmg.38.2020.08.21.08.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 08:31:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] meson: Do not consider qemu-keymap a 'tool'
Date: Fri, 21 Aug 2020 17:31:55 +0200
Message-Id: <20200821153155.1247675-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need qemu-keymap to generate the keymaps.

This fixes when configuring with --disable-tools:

  Compiling C object qemu-keymap.p/qemu-keymap.c.o
  Compiling C object qemu-keymap.p/ui_input-keymap.c.o
  Compiling C object qemu-edid.p/qemu-edid.c.o
  ../ui/input-keymap.c:7:49: fatal error: ui/input-keymap-atset1-to-qcode.c.inc: No such file or directory
  compilation terminated.
  Makefile.ninja:688: recipe for target 'qemu-keymap.p/ui_input-keymap.c.o' failed
  make: *** [qemu-keymap.p/ui_input-keymap.c.o] Error 1

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: Move to ui/ (Paolo)
---
 meson.build    | 5 -----
 ui/meson.build | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 808f50b07ef..709d7e6ccc2 100644
--- a/meson.build
+++ b/meson.build
@@ -1078,11 +1078,6 @@ if have_tools
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
-  if 'CONFIG_XKBCOMMON' in config_host
-    executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c'),
-               dependencies: [qemuutil, xkbcommon], install: true)
-  endif
-
   executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c'),
              dependencies: qemuutil,
              install: true)
diff --git a/ui/meson.build b/ui/meson.build
index 6f74d30ea06..2b7861073ff 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -96,6 +96,11 @@ keymaps = [
 ]
 
 if have_system
+  if 'CONFIG_XKBCOMMON' in config_host
+  executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c'),
+             dependencies: [qemuutil, xkbcommon], install: true)
+  endif
+
   foreach e : keymaps
     output = 'input-keymap-@0@-to-@1@.c.inc'.format(e[0], e[1])
     genh += custom_target(output,
-- 
2.26.2


