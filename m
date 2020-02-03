Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DE1C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F46320721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWxdBbOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F46320721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZhl-0001bm-EW
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZfW-0005B0-Gm
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZfU-0000hX-HF
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:30 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:44694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyZfU-0000fq-AB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:28 -0500
Received: by mail-wr1-x433.google.com with SMTP id m16so17446626wrx.11
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=A2PvC/kAxIK7nZ4Xa63lRXD3s09Rrr9teNP3b5zDNc8=;
 b=WWxdBbOchZwKIMT9ti0VvH3qpQqdUU2S00PiEG13sBT8cTtiE3ahfOynPTTZPND7EC
 sW+3+MszCMlhc8KNPl6lIyn+MdI3vfWkj3pgCkVqTq+tFabp3xHo7/DPS5gt58nq4SE/
 NqCVpfpMqfflnm14O1Uh0wyD5V/hbTU+hps7IHrUBAz+J5tDxpRibj4/Om07k0hNE+qk
 sbaJTVIg5R+4klK3zjI4k5GtB3Xht8wToBXJxy/6kaOBvY0WXMaUt9rLkxNgXt9zhF+3
 P/BrB4xs/E6zxH4eSD21B7PmMVYpqZZAbJKhagJCgc7etR78zA/3PuVgwXBSlpYNzmh9
 fmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A2PvC/kAxIK7nZ4Xa63lRXD3s09Rrr9teNP3b5zDNc8=;
 b=XsgnUIb4A/9lo5PRvx11Hl8ogVOp94U92D6BJ26PjlyECYrvHN3j0bzxOC/lOxPbyF
 zTZnNGC9idFM9VLFxh+FR9qPLtb8rB0GDK7r4nCFaV6h22iK0QcJt9vpvA7MqW3QMBs5
 AF8FLQ4Oe4vtoo3VqhrR+BFsagERF97EvOJUsVlqzxCUNM2DzfX10ykTbaG9XQ3LmPz+
 y5RRTqV3SKWhcgNh/kwActFLgES5NPlygvImyMqi/DZnE/I9cYQQcyJ7PVF33GSAoax2
 I6hyxSiWSZoiCU+02YTKb0VKdUhgIFgR9yaYRsdZZw4cROA3GWfzI2zYp50dAXv5tBlG
 kM/g==
X-Gm-Message-State: APjAAAVcVVy1lD1CMb1InSuCNpgZ7OKharbM9EUVJD3UedT80zGtq0dX
 GqxxVBPqZz75pbSa0a/vKjgnqY8nxMJDLA==
X-Google-Smtp-Source: APXvYqwjwdlGrw0FHOqtTMMH8dXPUEUSbo5u2K9Kws52WTscrLjJD9CEVfzj4OrQkPpBKbsVznY0lA==
X-Received: by 2002:a5d:4702:: with SMTP id y2mr6942835wrq.37.1580728405846;
 Mon, 03 Feb 2020 03:13:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm24028917wme.35.2020.02.03.03.13.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 03:13:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] docs/sphinx: Add new hxtool Sphinx extension
Date: Mon,  3 Feb 2020 11:13:13 +0000
Message-Id: <20200203111318.23378-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203111318.23378-1-peter.maydell@linaro.org>
References: <20200203111318.23378-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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

Some of our documentation includes sections which are created
by assembling fragments of texinfo from a .hx source file into
a .texi file, which is then included from qemu-doc.texi or
qemu-img.texi.

For Sphinx, rather than creating a file to include, the most natural
way to handle this is to have a small custom Sphinx extension which
reads the .hx file and process it.  So instead of:
 * makefile produces foo.texi from foo.hx
 * qemu-doc.texi says '@include foo.texi'
we have:
 * qemu-doc.rst says 'hxtool-doc:: foo.hx'
 * the Sphinx extension for hxtool has code that runs to handle that
   Sphinx directive which reads the .hx file and emits the appropriate
   documentation contents

This is pretty much the same way the kerneldoc extension works right
now. It also has the advantage that it should work for third-party
services like readthedocs that expect to build the docs directly with
sphinx rather than by invoking our makefiles.

In this commit we implement the hxtool extension.

Note that syntax errors in the rST fragments will be correctly
reported to the user with the filename and line number within the
hx file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200124162606.8787-4-peter.maydell@linaro.org
---
 docs/conf.py          |   3 +-
 docs/sphinx/hxtool.py | 210 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 212 insertions(+), 1 deletion(-)
 create mode 100644 docs/sphinx/hxtool.py

diff --git a/docs/conf.py b/docs/conf.py
index 259c6049da7..ee7faa6b4e7 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -54,7 +54,7 @@ needs_sphinx = '1.3'
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = ['kerneldoc', 'qmp_lexer']
+extensions = ['kerneldoc', 'qmp_lexer', 'hxtool']
 
 # Add any paths that contain templates here, relative to this directory.
 templates_path = ['_templates']
@@ -221,3 +221,4 @@ texinfo_documents = [
 # find everything.
 kerneldoc_bin = os.path.join(qemu_docdir, '../scripts/kernel-doc')
 kerneldoc_srctree = os.path.join(qemu_docdir, '..')
+hxtool_srctree = os.path.join(qemu_docdir, '..')
diff --git a/docs/sphinx/hxtool.py b/docs/sphinx/hxtool.py
new file mode 100644
index 00000000000..5d6736f3002
--- /dev/null
+++ b/docs/sphinx/hxtool.py
@@ -0,0 +1,210 @@
+# coding=utf-8
+#
+# QEMU hxtool .hx file parsing extension
+#
+# Copyright (c) 2020 Linaro
+#
+# This work is licensed under the terms of the GNU GPLv2 or later.
+# See the COPYING file in the top-level directory.
+"""hxtool is a Sphinx extension that implements the hxtool-doc directive"""
+
+# The purpose of this extension is to read fragments of rST
+# from .hx files, and insert them all into the current document.
+# The rST fragments are delimited by SRST/ERST lines.
+# The conf.py file must set the hxtool_srctree config value to
+# the root of the QEMU source tree.
+# Each hxtool-doc:: directive takes one argument which is the
+# path of the .hx file to process, relative to the source tree.
+
+import os
+import re
+from enum import Enum
+
+from docutils import nodes
+from docutils.statemachine import ViewList
+from docutils.parsers.rst import directives, Directive
+from sphinx.errors import ExtensionError
+from sphinx.util.nodes import nested_parse_with_titles
+import sphinx
+
+# Sphinx up to 1.6 uses AutodocReporter; 1.7 and later
+# use switch_source_input. Check borrowed from kerneldoc.py.
+Use_SSI = sphinx.__version__[:3] >= '1.7'
+if Use_SSI:
+    from sphinx.util.docutils import switch_source_input
+else:
+    from sphinx.ext.autodoc import AutodocReporter
+
+__version__ = '1.0'
+
+# We parse hx files with a state machine which may be in one of three
+# states: reading the C code fragment, inside a texi fragment,
+# or inside a rST fragment.
+class HxState(Enum):
+    CTEXT = 1
+    TEXI = 2
+    RST = 3
+
+def serror(file, lnum, errtext):
+    """Raise an exception giving a user-friendly syntax error message"""
+    raise ExtensionError('%s line %d: syntax error: %s' % (file, lnum, errtext))
+
+def parse_directive(line):
+    """Return first word of line, if any"""
+    return re.split('\W', line)[0]
+
+def parse_defheading(file, lnum, line):
+    """Handle a DEFHEADING directive"""
+    # The input should be "DEFHEADING(some string)", though note that
+    # the 'some string' could be the empty string. If the string is
+    # empty we ignore the directive -- these are used only to add
+    # blank lines in the plain-text content of the --help output.
+    #
+    # Return the heading text
+    match = re.match(r'DEFHEADING\((.*)\)', line)
+    if match is None:
+        serror(file, lnum, "Invalid DEFHEADING line")
+    return match.group(1)
+
+def parse_archheading(file, lnum, line):
+    """Handle an ARCHHEADING directive"""
+    # The input should be "ARCHHEADING(some string, other arg)",
+    # though note that the 'some string' could be the empty string.
+    # As with DEFHEADING, empty string ARCHHEADINGs will be ignored.
+    #
+    # Return the heading text
+    match = re.match(r'ARCHHEADING\((.*),.*\)', line)
+    if match is None:
+        serror(file, lnum, "Invalid ARCHHEADING line")
+    return match.group(1)
+
+class HxtoolDocDirective(Directive):
+    """Extract rST fragments from the specified .hx file"""
+    required_argument = 1
+    optional_arguments = 1
+    option_spec = {
+        'hxfile': directives.unchanged_required
+    }
+    has_content = False
+
+    def run(self):
+        env = self.state.document.settings.env
+        hxfile = env.config.hxtool_srctree + '/' + self.arguments[0]
+
+        # Tell sphinx of the dependency
+        env.note_dependency(os.path.abspath(hxfile))
+
+        state = HxState.CTEXT
+        # We build up lines of rST in this ViewList, which we will
+        # later put into a 'section' node.
+        rstlist = ViewList()
+        current_node = None
+        node_list = []
+
+        with open(hxfile) as f:
+            lines = (l.rstrip() for l in f)
+            for lnum, line in enumerate(lines, 1):
+                directive = parse_directive(line)
+
+                if directive == 'HXCOMM':
+                    pass
+                elif directive == 'STEXI':
+                    if state == HxState.RST:
+                        serror(hxfile, lnum, 'expected ERST, found STEXI')
+                    elif state == HxState.TEXI:
+                        serror(hxfile, lnum, 'expected ETEXI, found STEXI')
+                    else:
+                        state = HxState.TEXI
+                elif directive == 'ETEXI':
+                    if state == HxState.RST:
+                        serror(hxfile, lnum, 'expected ERST, found ETEXI')
+                    elif state == HxState.CTEXT:
+                        serror(hxfile, lnum, 'expected STEXI, found ETEXI')
+                    else:
+                        state = HxState.CTEXT
+                elif directive == 'SRST':
+                    if state == HxState.RST:
+                        serror(hxfile, lnum, 'expected ERST, found SRST')
+                    elif state == HxState.TEXI:
+                        serror(hxfile, lnum, 'expected ETEXI, found SRST')
+                    else:
+                        state = HxState.RST
+                elif directive == 'ERST':
+                    if state == HxState.TEXI:
+                        serror(hxfile, lnum, 'expected ETEXI, found ERST')
+                    elif state == HxState.CTEXT:
+                        serror(hxfile, lnum, 'expected SRST, found ERST')
+                    else:
+                        state = HxState.CTEXT
+                elif directive == 'DEFHEADING' or directive == 'ARCHHEADING':
+                    if directive == 'DEFHEADING':
+                        heading = parse_defheading(hxfile, lnum, line)
+                    else:
+                        heading = parse_archheading(hxfile, lnum, line)
+                    if heading == "":
+                        continue
+                    # Put the accumulated rST into the previous node,
+                    # and then start a fresh section with this heading.
+                    if len(rstlist) > 0:
+                        if current_node is None:
+                            # We had some rST fragments before the first
+                            # DEFHEADING. We don't have a section to put
+                            # these in, so rather than magicing up a section,
+                            # make it a syntax error.
+                            serror(hxfile, lnum,
+                                   'first DEFHEADING must precede all rST text')
+                        self.do_parse(rstlist, current_node)
+                        rstlist = ViewList()
+                    if current_node is not None:
+                        node_list.append(current_node)
+                    section_id = 'hxtool-%d' % env.new_serialno('hxtool')
+                    current_node = nodes.section(ids=[section_id])
+                    current_node += nodes.title(heading, heading)
+                else:
+                    # Not a directive: put in output if we are in rST fragment
+                    if state == HxState.RST:
+                        # Sphinx counts its lines from 0
+                        rstlist.append(line, hxfile, lnum - 1)
+
+        if current_node is None:
+            # We don't have multiple sections, so just parse the rst
+            # fragments into a dummy node so we can return the children.
+            current_node = nodes.section()
+            self.do_parse(rstlist, current_node)
+            return current_node.children
+        else:
+            # Put the remaining accumulated rST into the last section, and
+            # return all the sections.
+            if len(rstlist) > 0:
+                self.do_parse(rstlist, current_node)
+            node_list.append(current_node)
+            return node_list
+
+    # This is from kerneldoc.py -- it works around an API change in
+    # Sphinx between 1.6 and 1.7. Unlike kerneldoc.py, we use
+    # sphinx.util.nodes.nested_parse_with_titles() rather than the
+    # plain self.state.nested_parse(), and so we can drop the saving
+    # of title_styles and section_level that kerneldoc.py does,
+    # because nested_parse_with_titles() does that for us.
+    def do_parse(self, result, node):
+        if Use_SSI:
+            with switch_source_input(self.state, result):
+                nested_parse_with_titles(self.state, result, node)
+        else:
+            save = self.state.memo.reporter
+            self.state.memo.reporter = AutodocReporter(result, self.state.memo.reporter)
+            try:
+                nested_parse_with_titles(self.state, result, node)
+            finally:
+                self.state.memo.reporter = save
+
+def setup(app):
+    """ Register hxtool-doc directive with Sphinx"""
+    app.add_config_value('hxtool_srctree', None, 'env')
+    app.add_directive('hxtool-doc', HxtoolDocDirective)
+
+    return dict(
+        version = __version__,
+        parallel_read_safe = True,
+        parallel_write_safe = True
+    )
-- 
2.20.1


