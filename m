Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8DEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5477122226
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/8zIpP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5477122226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQcKT-00080y-3K
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 16:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQcIq-0006wH-TF
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:14:16 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:40557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQcIo-00044U-ML
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:14:16 -0400
Received: by mail-pg1-x52b.google.com with SMTP id i2so5263762pgh.7
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mg39he2ihF2KQD3pRXZcx4vq8zLMJm3/bTiO7l/IBtU=;
 b=M/8zIpP7VEyw8mzw1EyOIceJUekijiMUbG5DiosrjFsU2xJqoPEXHJMhrshROH4f7H
 3hSTAfMNK5QO4UV+CNzd8CcxslJCt7vbu7ZUuXHwA8AeDjOEUq5Lamg3rNPwml/VOme3
 m7Rdx/IzigDp0jZFNco0Vg7Xpzx+O+Qlmy3ps+cAfbb5iD5aD4XtBXIRUP+jyKy7LDv9
 xskaJGl0LKzu+874dxqWI6KK1jmOm9h0nINI0e9PLReZ8jkI/hRK6qqBFAdweyzQhGXn
 e5IfyZyt1qPD5IXEcAu0ph668/lgNgtbjb1S/NfyV7IncdwFFUvvpfHZHuUzMnP4iILv
 uxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mg39he2ihF2KQD3pRXZcx4vq8zLMJm3/bTiO7l/IBtU=;
 b=kJZe3NFcbDxhxwqxKMoQKiJSLIJdGpVUyMJ9HGk/jtkzNkf2LegqpG/Mm0lkQA/10Q
 uTOx8vMES/bSWCr85N9nPrgbi9cVnNsyQv5GOTMn4kKiPPSKqagVHawgwokW8RwWrZ52
 DSjJiELreHIJjxSYrGU6JJLabIA4un7ERrxlKN9sy3NZDz8glDo1UnN9mrKBiA53BeyJ
 5HBo/oueVG0d8z19zGjB8QS+hpnVeZoA6zFEkut8QPf8ZdzwLKTC30UGLf9i8uUN9LZj
 tTIzw1aUdNhiX5ZRXMPNtMApYTvc3qjdkrR3SoafCBfPcolSwLcPW8nlCBNwedsU+dZ3
 PQLw==
X-Gm-Message-State: AOAM531XClRuHi4GgTnA24IugRLgisZrY1Ms9KRwvoueq/dOghV56s0x
 vQmxVKliUxvJMR8cWrjuQBWyZFLInxBVrg==
X-Google-Smtp-Source: ABdhPJwAd09VWCj4PRhyBrtSXDYBE87QDiBNvBYcZKKBvEzL1W1qwLJMsusM8e3lJ2rKbzHr7L1bYQ==
X-Received: by 2002:a17:90b:4a0c:: with SMTP id
 kk12mr570448pjb.207.1602188052660; 
 Thu, 08 Oct 2020 13:14:12 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id s24sm8008454pjp.53.2020.10.08.13.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 13:14:11 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] docs: Fixes build docs on msys2/mingw
Date: Fri,  9 Oct 2020 04:13:52 +0800
Message-Id: <20201008201353.465-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201008201353.465-1-luoyonggang@gmail.com>
References: <20201008201353.465-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 docs/conf.py                  |  2 +-
 docs/sphinx/kerneldoc.py      |  2 +-
 scripts/rst-sanitize.py       | 21 +++++++++++++++++++++
 tests/qapi-schema/meson.build |  5 +++--
 4 files changed, 26 insertions(+), 4 deletions(-)
 create mode 100644 scripts/rst-sanitize.py

diff --git a/docs/conf.py b/docs/conf.py
index 00e1b750e2..e584f68393 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -241,7 +241,7 @@ texinfo_documents = [
 # We use paths starting from qemu_docdir here so that you can run
 # sphinx-build from anywhere and the kerneldoc extension can still
 # find everything.
-kerneldoc_bin = os.path.join(qemu_docdir, '../scripts/kernel-doc')
+kerneldoc_bin = ['perl', os.path.join(qemu_docdir, '../scripts/kernel-doc')]
 kerneldoc_srctree = os.path.join(qemu_docdir, '..')
 hxtool_srctree = os.path.join(qemu_docdir, '..')
 qapidoc_srctree = os.path.join(qemu_docdir, '..')
diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py
index 3e87940206..3ac277d162 100644
--- a/docs/sphinx/kerneldoc.py
+++ b/docs/sphinx/kerneldoc.py
@@ -67,7 +67,7 @@ class KernelDocDirective(Directive):
 
     def run(self):
         env = self.state.document.settings.env
-        cmd = [env.config.kerneldoc_bin, '-rst', '-enable-lineno']
+        cmd = env.config.kerneldoc_bin + ['-rst', '-enable-lineno']
 
         filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
         export_file_patterns = []
diff --git a/scripts/rst-sanitize.py b/scripts/rst-sanitize.py
new file mode 100644
index 0000000000..26060f1208
--- /dev/null
+++ b/scripts/rst-sanitize.py
@@ -0,0 +1,21 @@
+#!/usr/bin/env python3
+
+#
+# Script for remove cr line ending in file
+#
+# Authors:
+#  Yonggang Luo <luoyonggang@gmail.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2
+# or, at your option, any later version.  See the COPYING file in
+# the top-level directory.
+
+import sys
+
+def main(_program, file, *unused):
+    with open(file, 'rb') as content_file:
+        content = content_file.read()
+        sys.stdout.buffer.write(content.replace(b'\r', b''))
+
+if __name__ == "__main__":
+    main(*sys.argv)
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index f08c902911..a6832634b3 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -250,18 +250,19 @@ qapi_doc_out = custom_target('QAPI rST doc',
 # using an explicit '\' character in the command arguments to
 # a custom_target(), as Meson will unhelpfully replace it with a '/'
 # (https://github.com/mesonbuild/meson/issues/1564)
+rst_sanitize_cmd = [find_program('../../scripts/rst-sanitize.py'), '@INPUT@']
 qapi_doc_out_nocr = custom_target('QAPI rST doc newline-sanitized',
                                   output: ['doc-good.txt.nocr'],
                                   input: qapi_doc_out[0],
                                   build_by_default: build_docs,
-                                  command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
+                                  command: rst_sanitize_cmd,
                                   capture: true)
 
 qapi_doc_ref_nocr = custom_target('QAPI rST doc reference newline-sanitized',
                                   output: ['doc-good.ref.nocr'],
                                   input: files('doc-good.txt'),
                                   build_by_default: build_docs,
-                                  command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
+                                  command: rst_sanitize_cmd,
                                   capture: true)
 
 if build_docs
-- 
2.28.0.windows.1


