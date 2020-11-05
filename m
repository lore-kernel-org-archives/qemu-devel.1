Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E145C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:04:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A7A20786
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d07ycCyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A7A20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kahkq-0000DF-BC
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 11:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kahk3-0008A3-Lj
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:04:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kahjt-0004LK-J2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604592230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=flqM+zV6fe5yo1fLo+yQwYSAg5M2XYh7T1O+9dBjwuU=;
 b=d07ycCyJACdBRW3WaRqhU/xjBmePy22V2M2KkkUuBoARSU4Hf7tQKIdbSk4LYYgep33t7j
 T3/kyfCczcVWr0KwFBe2Sqd/HwFmTJIIFlWBgsfDtb4lf5sRpQZa4o/hiYfQppRHRJ7IHX
 yQd5YftvQ/Cjm1n6U3KjzLvokJovGWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-2RNteY5iN9-rREMbQ6xYzQ-1; Thu, 05 Nov 2020 11:03:44 -0500
X-MC-Unique: 2RNteY5iN9-rREMbQ6xYzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE301805F00;
 Thu,  5 Nov 2020 16:03:43 +0000 (UTC)
Received: from localhost (unknown [10.36.110.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD61E5D98F;
 Thu,  5 Nov 2020 16:03:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH] RFC: sphinx: adopt kernel readthedoc theme
Date: Thu,  5 Nov 2020 20:03:35 +0400
Message-Id: <20201105160335.1222062-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The default "alabaster" sphinx theme has a couple shortcomings:
- the navbar moves along the page
- the search bar is not always at the same place
- it lacks some contrast and colours

The "rtd" theme from readthedocs.org is a popular third party theme used
notably by the kernel, with a custom style sheet. I like it better,
perhaps others do too. It also has features that may come handy, such as
"Edit on Gitlab".

Tweak the nav header background to match qemu.org style, use the
QEMU logo, and favicon.

The html_theme_options['description'] workaround doesn't seem necessary.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/conf.py                           |  36 +++----
 docs/devel/conf.py                     |   4 -
 docs/interop/conf.py                   |   4 -
 docs/specs/conf.py                     |   5 -
 docs/sphinx-static/theme_overrides.css | 137 +++++++++++++++++++++++++
 docs/system/conf.py                    |   4 -
 docs/tools/conf.py                     |   5 -
 docs/user/conf.py                      |   4 -
 8 files changed, 155 insertions(+), 44 deletions(-)
 create mode 100644 docs/sphinx-static/theme_overrides.css

diff --git a/docs/conf.py b/docs/conf.py
index e584f68393..54c4e1e687 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -150,37 +150,37 @@ with open(os.path.join(qemu_docdir, 'defs.rst.inc')) as f:
 # The theme to use for HTML and HTML Help pages.  See the documentation for
 # a list of builtin themes.
 #
-html_theme = 'alabaster'
+try:
+    import sphinx_rtd_theme
+    html_theme = 'sphinx_rtd_theme'
+except ImportError:
+    sys.stderr.write('Warning: The Sphinx \'sphinx_rtd_theme\' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.\n')
 
 # Theme options are theme-specific and customize the look and feel of a theme
 # further.  For a list of options available for each theme, see the
 # documentation.
-# We initialize this to empty here, so the per-manual conf.py can just
-# add individual key/value entries.
 html_theme_options = {
+    "style_nav_header_background": "#802400",
 }
 
+html_logo = os.path.join(qemu_docdir, "../ui/icons/qemu_128x128.png")
+
+html_favicon = os.path.join(qemu_docdir, "../ui/icons/qemu_32x32.png")
+
 # Add any paths that contain custom static files (such as style sheets) here,
 # relative to this directory. They are copied after the builtin static files,
 # so a file named "default.css" will overwrite the builtin "default.css".
-# QEMU doesn't yet have any static files, so comment this out so we don't
-# get a warning about a missing directory.
-# If we do ever add this then it would probably be better to call the
-# subdirectory sphinx_static, as the Linux kernel does.
-# html_static_path = ['_static']
+html_static_path = [os.path.join(qemu_docdir, "sphinx-static")]
+
+html_context = {
+    'css_files': [
+        '_static/theme_overrides.css',
+    ],
+}
 
 # Custom sidebar templates, must be a dictionary that maps document names
 # to template names.
-#
-# This is required for the alabaster theme
-# refs: http://alabaster.readthedocs.io/en/latest/installation.html#sidebars
-html_sidebars = {
-    '**': [
-        'about.html',
-        'navigation.html',
-        'searchbox.html',
-    ]
-}
+#html_sidebars = {}
 
 # Don't copy the rST source files to the HTML output directory,
 # and don't put links to the sources into the output HTML.
diff --git a/docs/devel/conf.py b/docs/devel/conf.py
index 7441f87e7f..f0905b728b 100644
--- a/docs/devel/conf.py
+++ b/docs/devel/conf.py
@@ -9,7 +9,3 @@ import os
 qemu_docdir = os.path.abspath("..")
 parent_config = os.path.join(qemu_docdir, "conf.py")
 exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
-
-# This slightly misuses the 'description', but is the best way to get
-# the manual title to appear in the sidebar.
-html_theme_options['description'] = u'Developer''s Guide'
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
index 2634ca3410..97d9e8c116 100644
--- a/docs/interop/conf.py
+++ b/docs/interop/conf.py
@@ -10,10 +10,6 @@ qemu_docdir = os.path.abspath("..")
 parent_config = os.path.join(qemu_docdir, "conf.py")
 exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
 
-# This slightly misuses the 'description', but is the best way to get
-# the manual title to appear in the sidebar.
-html_theme_options['description'] = u'System Emulation Management and Interoperability Guide'
-
 # One entry per manual page. List of tuples
 # (source start file, name, description, authors, manual section).
 man_pages = [
diff --git a/docs/specs/conf.py b/docs/specs/conf.py
index 4d56f3ae13..1be2d3bd20 100644
--- a/docs/specs/conf.py
+++ b/docs/specs/conf.py
@@ -9,8 +9,3 @@ import os
 qemu_docdir = os.path.abspath("..")
 parent_config = os.path.join(qemu_docdir, "conf.py")
 exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
-
-# This slightly misuses the 'description', but is the best way to get
-# the manual title to appear in the sidebar.
-html_theme_options['description'] = \
-    u'System Emulation Guest Hardware Specifications'
diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
new file mode 100644
index 0000000000..00bcb40bd7
--- /dev/null
+++ b/docs/sphinx-static/theme_overrides.css
@@ -0,0 +1,137 @@
+/* -*- coding: utf-8; mode: css -*-
+ *
+ * Sphinx HTML theme customization: read the doc
+ * Based on Linux Documentation/sphinx-static/theme_overrides.css
+ */
+
+/* Improve contrast and increase size for easier reading. */
+
+body {
+    font-family: serif;
+    color: black;
+    font-size: 100%;
+}
+
+h1, h2, .rst-content .toctree-wrapper p.caption, h3, h4, h5, h6, legend {
+    font-family: sans-serif;
+}
+
+.wy-menu-vertical li.current a {
+    color: #505050;
+}
+
+.wy-menu-vertical li.on a, .wy-menu-vertical li.current > a {
+    color: #303030;
+}
+
+div[class^="highlight"] pre {
+    font-family: monospace;
+    color: black;
+    font-size: 100%;
+}
+
+.wy-menu-vertical {
+    font-family: sans-serif;
+}
+
+.c {
+    font-style: normal;
+}
+
+p {
+    font-size: 100%;
+}
+
+/* Interim: Code-blocks with line nos - lines and line numbers don't line up.
+ * see: https://github.com/rtfd/sphinx_rtd_theme/issues/419
+ */
+
+div[class^="highlight"] pre {
+    line-height: normal;
+}
+.rst-content .highlight > pre {
+    line-height: normal;
+}
+
+/* Keep fields from being strangely far apart due to inheirited table CSS. */
+.rst-content table.field-list th.field-name {
+    padding-top: 1px;
+    padding-bottom: 1px;
+}
+.rst-content table.field-list td.field-body {
+    padding-top: 1px;
+    padding-bottom: 1px;
+}
+
+@media screen {
+
+    /* content column
+     *
+     * RTD theme's default is 800px as max width for the content, but we have
+     * tables with tons of columns, which need the full width of the view-port.
+     */
+
+    .wy-nav-content{max-width: none; }
+
+    /* table:
+     *
+     *   - Sequences of whitespace should collapse into a single whitespace.
+     *   - make the overflow auto (scrollbar if needed)
+     *   - align caption "left" ("center" is unsuitable on vast tables)
+     */
+
+    .wy-table-responsive table td { white-space: normal; }
+    .wy-table-responsive { overflow: auto; }
+    .rst-content table.docutils caption { text-align: left; font-size: 100%; }
+
+    /* captions:
+     *
+     *   - captions should have 100% (not 85%) font size
+     *   - hide the permalink symbol as long as link is not hovered
+     */
+
+    .toc-title {
+        font-size: 150%;
+        font-weight: bold;
+    }
+
+    caption, .wy-table caption, .rst-content table.field-list caption {
+        font-size: 100%;
+    }
+    caption a.headerlink { opacity: 0; }
+    caption a.headerlink:hover { opacity: 1; }
+
+    /* Menu selection and keystrokes */
+
+    span.menuselection {
+        color: blue;
+        font-family: "Courier New", Courier, monospace
+    }
+
+    code.kbd, code.kbd span {
+        color: white;
+        background-color: darkblue;
+        font-weight: bold;
+        font-family: "Courier New", Courier, monospace
+    }
+
+    /* fix bottom margin of lists items */
+
+    .rst-content .section ul li:last-child, .rst-content .section ul li p:last-child {
+          margin-bottom: 12px;
+    }
+
+    /* inline literal: drop the borderbox, padding and red color */
+
+    code, .rst-content tt, .rst-content code {
+        color: inherit;
+        border: none;
+        padding: unset;
+        background: inherit;
+        font-size: 85%;
+    }
+
+    .rst-content tt.literal,.rst-content tt.literal,.rst-content code.literal {
+        color: inherit;
+    }
+}
diff --git a/docs/system/conf.py b/docs/system/conf.py
index 6251849fef..847cd87fa2 100644
--- a/docs/system/conf.py
+++ b/docs/system/conf.py
@@ -10,10 +10,6 @@ qemu_docdir = os.path.abspath("..")
 parent_config = os.path.join(qemu_docdir, "conf.py")
 exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
 
-# This slightly misuses the 'description', but is the best way to get
-# the manual title to appear in the sidebar.
-html_theme_options['description'] = u'System Emulation User''s Guide'
-
 # One entry per manual page. List of tuples
 # (source start file, name, description, authors, manual section).
 man_pages = [
diff --git a/docs/tools/conf.py b/docs/tools/conf.py
index 9052d17d6d..a11923a786 100644
--- a/docs/tools/conf.py
+++ b/docs/tools/conf.py
@@ -10,11 +10,6 @@ qemu_docdir = os.path.abspath("..")
 parent_config = os.path.join(qemu_docdir, "conf.py")
 exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
 
-# This slightly misuses the 'description', but is the best way to get
-# the manual title to appear in the sidebar.
-html_theme_options['description'] = \
-    u'Tools Guide'
-
 # One entry per manual page. List of tuples
 # (source start file, name, description, authors, manual section).
 man_pages = [
diff --git a/docs/user/conf.py b/docs/user/conf.py
index 4b09aedd45..7b89273d43 100644
--- a/docs/user/conf.py
+++ b/docs/user/conf.py
@@ -9,7 +9,3 @@ import os
 qemu_docdir = os.path.abspath("..")
 parent_config = os.path.join(qemu_docdir, "conf.py")
 exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
-
-# This slightly misuses the 'description', but is the best way to get
-# the manual title to appear in the sidebar.
-html_theme_options['description'] = u'User Mode Emulation User''s Guide'
-- 
2.29.0


