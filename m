Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D111CC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C66A2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CF4eudNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C66A2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52743 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT3ud-0005d4-MN
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:30:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3q2-0001SE-QV
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3px-0005Gc-4B
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:48 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT3pw-00054z-RB
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id i3so2779151wml.4
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=oe3qCNAnptAvVIC38GAVxc3L66obGAOTbhJyLwNyUsk=;
	b=CF4eudNmr6WNenANAk9BDzK92mUD19XDIbKNqR4P2QmMTZGqVr/pLLjulaDg61s8lg
	AdgTNuLX8LSGw81aGyax7xYjb2SLTbATEWEzOTXBozCS1IwHtt1f6LCFctYzWzAHlWh4
	7sCuPjaHXhlom/o7K7yTgbu72i4+MEsIL4TdMmXBQQln00mKtzABS0hSBpROLo1WTFB3
	RsJ1MMfoc0uRldtvY/iNwD7e315bklA2xAIQBhCGcbiFDT26Y+m3eyKaMGcxCfEZLgHy
	Zoalc8X53EJEWorJ/1CtRV5ftZJVeG/F95tbi/e5PWn7ZcPueQd39da8YoMUVtSC8FJh
	BP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=oe3qCNAnptAvVIC38GAVxc3L66obGAOTbhJyLwNyUsk=;
	b=RpIUwOV6/BhbP1OhkkiheKtk6+5v8vt5emG7ItwLdjdduu4TTVZW/ndR6cIYgeJwXl
	5IgaOiB2p6VKOeMNEQ2uOJWNRtktvPcp7pZrjrVMNu/43mfe6TZcUon2REpkCiyYTazZ
	R+KPAc+ILotlJVg6wV1ZsSSDwWM+1mIO04gaHAol6JC58BA6EqBAhl1OPsRXFdE+qANM
	sC44WISTtSMoT2CtfA3jeJoW9uRJdzhQcl3nghXGW2I/eOXoWyku7kr/Pzdog05aIAl/
	huOVFrzeAqP251hIoGALrV5nMUoEfK/EvJZu+RGCcEzLTfns+ev9u2+wGRcbBwBSrHLP
	F6GA==
X-Gm-Message-State: APjAAAVcDRcASF8HqLXWA9JuwL96R7nqkGLD17hw8c834Z+5XwBqCDYc
	cNgYcJYZqj6PjJmVEOgkKUuwj6Dwe+s=
X-Google-Smtp-Source: APXvYqwuLb8YfEb9TPWKzw7772xmS0I1GlT7mEYiMX1Ok1kglqTqSGrmnNJ/ezOtmLjbFmgIHXUz+g==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr3240982wmc.69.1558441526093; 
	Tue, 21 May 2019 05:25:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	u11sm12233393wrn.1.2019.05.21.05.25.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 05:25:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 13:25:11 +0100
Message-Id: <20190521122519.12573-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521122519.12573-1-peter.maydell@linaro.org>
References: <20190521122519.12573-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [RFC 02/10] docs: Add kerneldoc sphinx module from
 Linux
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	"Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the kerneldoc sphinx module from Linux kernel
commit 30bac164aca750892.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/sphinx/kerneldoc.py | 150 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 docs/sphinx/kerneldoc.py

diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py
new file mode 100644
index 00000000000..9d0a7f08f93
--- /dev/null
+++ b/docs/sphinx/kerneldoc.py
@@ -0,0 +1,150 @@
+# coding=utf-8
+#
+# Copyright © 2016 Intel Corporation
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice (including the next
+# paragraph) shall be included in all copies or substantial portions of the
+# Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+# IN THE SOFTWARE.
+#
+# Authors:
+#    Jani Nikula <jani.nikula@intel.com>
+#
+# Please make sure this works on both python2 and python3.
+#
+
+import codecs
+import os
+import subprocess
+import sys
+import re
+import glob
+
+from docutils import nodes, statemachine
+from docutils.statemachine import ViewList
+from docutils.parsers.rst import directives, Directive
+from sphinx.ext.autodoc import AutodocReporter
+
+__version__  = '1.0'
+
+class KernelDocDirective(Directive):
+    """Extract kernel-doc comments from the specified file"""
+    required_argument = 1
+    optional_arguments = 4
+    option_spec = {
+        'doc': directives.unchanged_required,
+        'functions': directives.unchanged,
+        'export': directives.unchanged,
+        'internal': directives.unchanged,
+    }
+    has_content = False
+
+    def run(self):
+        env = self.state.document.settings.env
+        cmd = [env.config.kerneldoc_bin, '-rst', '-enable-lineno']
+
+        filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
+        export_file_patterns = []
+
+        # Tell sphinx of the dependency
+        env.note_dependency(os.path.abspath(filename))
+
+        tab_width = self.options.get('tab-width', self.state.document.settings.tab_width)
+
+        # FIXME: make this nicer and more robust against errors
+        if 'export' in self.options:
+            cmd += ['-export']
+            export_file_patterns = str(self.options.get('export')).split()
+        elif 'internal' in self.options:
+            cmd += ['-internal']
+            export_file_patterns = str(self.options.get('internal')).split()
+        elif 'doc' in self.options:
+            cmd += ['-function', str(self.options.get('doc'))]
+        elif 'functions' in self.options:
+            functions = self.options.get('functions').split()
+            if functions:
+                for f in functions:
+                    cmd += ['-function', f]
+            else:
+                cmd += ['-no-doc-sections']
+
+        for pattern in export_file_patterns:
+            for f in glob.glob(env.config.kerneldoc_srctree + '/' + pattern):
+                env.note_dependency(os.path.abspath(f))
+                cmd += ['-export-file', f]
+
+        cmd += [filename]
+
+        try:
+            env.app.verbose('calling kernel-doc \'%s\'' % (" ".join(cmd)))
+
+            p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+            out, err = p.communicate()
+
+            out, err = codecs.decode(out, 'utf-8'), codecs.decode(err, 'utf-8')
+
+            if p.returncode != 0:
+                sys.stderr.write(err)
+
+                env.app.warn('kernel-doc \'%s\' failed with return code %d' % (" ".join(cmd), p.returncode))
+                return [nodes.error(None, nodes.paragraph(text = "kernel-doc missing"))]
+            elif env.config.kerneldoc_verbosity > 0:
+                sys.stderr.write(err)
+
+            lines = statemachine.string2lines(out, tab_width, convert_whitespace=True)
+            result = ViewList()
+
+            lineoffset = 0;
+            line_regex = re.compile("^#define LINENO ([0-9]+)$")
+            for line in lines:
+                match = line_regex.search(line)
+                if match:
+                    # sphinx counts lines from 0
+                    lineoffset = int(match.group(1)) - 1
+                    # we must eat our comments since the upset the markup
+                else:
+                    result.append(line, filename, lineoffset)
+                    lineoffset += 1
+
+            node = nodes.section()
+            buf = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
+            self.state.memo.reporter = AutodocReporter(result, self.state.memo.reporter)
+            self.state.memo.title_styles, self.state.memo.section_level = [], 0
+            try:
+                self.state.nested_parse(result, 0, node, match_titles=1)
+            finally:
+                self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = buf
+
+            return node.children
+
+        except Exception as e:  # pylint: disable=W0703
+            env.app.warn('kernel-doc \'%s\' processing failed with: %s' %
+                         (" ".join(cmd), str(e)))
+            return [nodes.error(None, nodes.paragraph(text = "kernel-doc missing"))]
+
+def setup(app):
+    app.add_config_value('kerneldoc_bin', None, 'env')
+    app.add_config_value('kerneldoc_srctree', None, 'env')
+    app.add_config_value('kerneldoc_verbosity', 1, 'env')
+
+    app.add_directive('kernel-doc', KernelDocDirective)
+
+    return dict(
+        version = __version__,
+        parallel_read_safe = True,
+        parallel_write_safe = True
+    )
-- 
2.20.1


