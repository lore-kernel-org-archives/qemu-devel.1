Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82224C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210102076D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIt/qDWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210102076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS7SF-00070q-9R
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 19:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7OQ-00035p-0R; Mon, 12 Oct 2020 19:38:14 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:36955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7OO-00073Y-0H; Mon, 12 Oct 2020 19:38:13 -0400
Received: by mail-pf1-x42f.google.com with SMTP id 144so15243295pfb.4;
 Mon, 12 Oct 2020 16:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L6PNQoyNWpTKNJhBfsEjGJ+daBNStQN7zXzdYI1k/ZU=;
 b=jIt/qDWhnuxApOXOtkUiNpAdl7lLSiUTyKSGPauriZmyYjE/GpKJIqg5audgdjfcWi
 2kqym5Uj2n3B0fYeNArKi9fTFc9gXOqtadK6Mca3Z9MO0OUwf9NDobjThlvAFIpGVScw
 NN5dkSyULw0Mq1A8W2vBXPSy+SCOcJdM7yHCP1mg0jqtLTonNug+/wMmRWGL2Hh8nJXz
 gtupvC3PeplF2IOZUOc3UQW2enuXHjFcsQreCLgSIQeazxtiOwAn2GqHAT1JkTHYbty9
 ftDsVLu7XpUnRR/ZaHGmhlNPsm4KnkA7Kj1BKiOBWRKroOz5f6B+8ljCakZ4rd+zQs4H
 hYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L6PNQoyNWpTKNJhBfsEjGJ+daBNStQN7zXzdYI1k/ZU=;
 b=B+Oaw83uFXp3ojwGvF8JuqA6jIt88DijqvBIZTCGB98F2O6kZygxNCTioUhg9Y6Mqq
 Y3EY31Sc7gWhwZCouTlmExdzkUZERc/OYQSZLvkRHF4n7UUlz/1cX0U979Ev0ZpUxEqU
 DwBjTTNnfPP/T4yb6TdoJS97vbqKSi/65bgQ5x2+eecP8t1nUpTo1dM7JscsR3EKnVZ0
 3jqttVpa8TTqsZmQc/3UdsrIivesk8qWIPyE/hts7ACq4EqBYnSu8CDjxixD5NVIEiwq
 Z9LDWb/wyhsusccy+YqHfIMJkSSqNb4vU10Hgpj+11TyjZYdxmuM9gawAMPCqTNzv0tX
 3lxA==
X-Gm-Message-State: AOAM531BwBstTp++QcIWrCQwKbnhh6MQD5F8t3ASk8UjWi8kbF0CXNfc
 vkoGh0Chq/vYuFALnkbRn8X1awmU+Ut/6g==
X-Google-Smtp-Source: ABdhPJyZYsLCZVcXZWCFW6/YxJathcD31bENolQpBfkxQujNBmDkgmNZU0aQMYf09Ho4DE9CIGUHBA==
X-Received: by 2002:a62:e104:0:b029:152:4f37:99da with SMTP id
 q4-20020a62e1040000b02901524f3799damr25438622pfh.17.1602545889832; 
 Mon, 12 Oct 2020 16:38:09 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 x12sm21975783pfr.156.2020.10.12.16.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 16:38:09 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 3/4] docs: Fixes build docs on msys2/mingw
Date: Tue, 13 Oct 2020 07:37:39 +0800
Message-Id: <20201012233740.190-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201012233740.190-1-luoyonggang@gmail.com>
References: <20201012233740.190-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42f.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
index 1f222a7a13..20a7641af8 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -251,18 +251,19 @@ qapi_doc_out = custom_target('QAPI rST doc',
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


