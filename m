Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB359C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21ADF206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5ogGA7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21ADF206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcF2I-0003oa-4Z
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 16:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kcExj-00086R-7Q
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:44:31 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kcExg-0007fI-B2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:44:30 -0500
Received: by mail-wr1-x431.google.com with SMTP id r17so6532272wrw.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 13:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fzmc3z1XyVtlC8j6UQOGeBsOfMBy+uPWsnbCZPZdRu4=;
 b=R5ogGA7glW5hi5hmL0c7mM3XvBYXB3a0GREAYC60MPU36VWlkK00RtrhYPIjDqdUrt
 rbBzZVa0VWX4dz9YeyW9y1v5yg4NREDLG215jmJ6wlmSJvlcRFK1acOThuG5sWWOG/yj
 4Du1+BduCLujC/JqSJmocMn8sPh44X7nQ53VhosIHWrMKQ6j5ImNgdQ2x8lVzSasB+0I
 fAOwAp4j8Vnxt03H5Q6oIn/YpKLljB4osNzZjscFE1BhK+s/BCsKllpZ8caxzJs1dH4z
 k+iuIWygCyNkfIsmT0gg7u7nnl8HtWsurGuJ6BhPl/orfbIWbcCsTJ02Ihi2Jj1ITu9C
 QrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fzmc3z1XyVtlC8j6UQOGeBsOfMBy+uPWsnbCZPZdRu4=;
 b=CKJry1HEAm9aYhJemMzk5ErnbO0mpWTLnUEABZMlS8vjw6L3Gaj4tw3bsUZAqLiNBa
 GIq00Xw1E9URv6H0gJsphPX9Z5YOP5kmzH4tAQ9xdC5q9mOQlDlJnQBA1GYBLGzEjf9u
 tt2sZND7QygpyZzxyNBIEC7ZykNbN6RO6xOULLN5ya9s6zXm7n0UMQHcrHFKOVFNq0tq
 levhPn1b7+bkOhPmiZQuVenMq98Vgh0f481tEwTyqfPsEx1QXaeYjnBXfPTnSq/qnaOn
 9Q3ofxvRl0T8bGxgnJy8pXp08SCAd94r9Sstu8kzQKFduoMZPAIeCZveaA8q2wvKdAhQ
 f2nA==
X-Gm-Message-State: AOAM531//3IaQCb5hMosqa05KRW0ORdZIwPpeyPwQJU/ezeW+Bx03OfY
 iYdiUhdykAIHyB2+5VC/HilQrh1gFY2K9w==
X-Google-Smtp-Source: ABdhPJw+UNMk8BWeivCVUUW0rxTU94Q6gMGWabPsy4zF5xgLezBonZcIvG8R53vptbEWTP4M4jJMdA==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr19629698wrq.236.1604958265296; 
 Mon, 09 Nov 2020 13:44:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e3sm14913252wrn.32.2020.11.09.13.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:44:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC 2/2] docs: Build and install all the docs in a single manual
Date: Mon,  9 Nov 2020 21:44:20 +0000
Message-Id: <20201109214420.32131-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109214420.32131-1-peter.maydell@linaro.org>
References: <20201109214420.32131-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we first converted our documentation to Sphinx, we split it into
multiple manuals (system, interop, tools, etc), which are all built
separately.  The primary driver for this was wanting to be able to
avoid shipping the 'devel' manual to end-users.  However, this is
working against the grain of the way Sphinx wants to be used and
causes some annoyances:
 * Cross-references between documents become much harder or
   possibly impossible
 * There is no single index to the whole documentation
 * Within one manual there's no links or table-of-contents info
   that lets you easily navigate to the others
 * The devel manual doesn't get published on the QEMU website
   (it would be nice to able to refer to it there)

Merely hiding our developer documentation from end users seems like
it's not enough benefit for these costs.  Combine all the
documentation into a single manual (the same way that the readthedocs
site builds it) and install the whole thing.  The previous manual
divisions remain as the new top level sections in the manual.

 * The per-manual conf.py files are no longer needed
 * The man_pages[] specifications previously in each per-manual
   conf.py move to the top level conf.py
 * docs/meson.build logic is simplified as we now only need to run
   Sphinx once for the HTML and then once for the manpages5B
 * The old index.html.in that produced the top-level page with
   links to each manual is no longer needed

Unfortunately this means that we now have to build the HTML
documentation into docs/manual in the build tree rather than directly
into docs/; otherwise it is too awkward to ensure we install only the
built manual and not also the dependency info, stamp file, etc.  The
manual still ends up in the same place in the final installed
directory, but anybody who was consulting documentation from within
the build tree will have to adjust where they're looking.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/conf.py         | 37 ++++++++++++++++++++++++-
 docs/devel/conf.py   | 15 -----------
 docs/index.html.in   | 17 ------------
 docs/interop/conf.py | 26 ------------------
 docs/meson.build     | 64 +++++++++++++++++---------------------------
 docs/specs/conf.py   | 16 -----------
 docs/system/conf.py  | 28 -------------------
 docs/tools/conf.py   | 33 -----------------------
 docs/user/conf.py    | 15 -----------
 9 files changed, 61 insertions(+), 190 deletions(-)
 delete mode 100644 docs/devel/conf.py
 delete mode 100644 docs/index.html.in
 delete mode 100644 docs/interop/conf.py
 delete mode 100644 docs/specs/conf.py
 delete mode 100644 docs/system/conf.py
 delete mode 100644 docs/tools/conf.py
 delete mode 100644 docs/user/conf.py

diff --git a/docs/conf.py b/docs/conf.py
index e584f683938..3bc9b35872a 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -223,7 +223,42 @@ latex_documents = [
 
 # -- Options for manual page output ---------------------------------------
 # Individual manual/conf.py can override this to create man pages
-man_pages = []
+man_pages = [
+    ('interop/qemu-ga', 'qemu-ga',
+     'QEMU Guest Agent',
+     ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
+    ('interop/qemu-ga-ref', 'qemu-ga-ref',
+     'QEMU Guest Agent Protocol Reference',
+     [], 7),
+    ('interop/qemu-qmp-ref', 'qemu-qmp-ref',
+     'QEMU QMP Reference Manual',
+     [], 7),
+    ('system/qemu-manpage', 'qemu',
+     'QEMU User Documentation',
+     ['Fabrice Bellard'], 1),
+    ('system/qemu-block-drivers', 'qemu-block-drivers',
+     'QEMU block drivers reference',
+     ['Fabrice Bellard and the QEMU Project developers'], 7),
+    ('system/qemu-cpu-models', 'qemu-cpu-models',
+     'QEMU CPU Models',
+     ['The QEMU Project developers'], 7),
+    ('tools/qemu-img', 'qemu-img',
+     'QEMU disk image utility',
+     ['Fabrice Bellard'], 1),
+    ('tools/qemu-nbd', 'qemu-nbd',
+     'QEMU Disk Network Block Device Server',
+     ['Anthony Liguori <anthony@codemonkey.ws>'], 8),
+    ('tools/qemu-trace-stap', 'qemu-trace-stap',
+     'QEMU SystemTap trace tool',
+     [], 1),
+    ('tools/virtfs-proxy-helper', 'virtfs-proxy-helper',
+     'QEMU 9p virtfs proxy filesystem helper',
+     ['M. Mohan Kumar'], 1),
+    ('tools/virtiofsd', 'virtiofsd',
+     'QEMU virtio-fs shared file system daemon',
+     ['Stefan Hajnoczi <stefanha@redhat.com>',
+      'Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>'], 1),
+]
 
 # -- Options for Texinfo output -------------------------------------------
 
diff --git a/docs/devel/conf.py b/docs/devel/conf.py
deleted file mode 100644
index 7441f87e7f5..00000000000
--- a/docs/devel/conf.py
+++ /dev/null
@@ -1,15 +0,0 @@
-# -*- coding: utf-8 -*-
-#
-# QEMU documentation build configuration file for the 'devel' manual.
-#
-# This includes the top level conf file and then makes any necessary tweaks.
-import sys
-import os
-
-qemu_docdir = os.path.abspath("..")
-parent_config = os.path.join(qemu_docdir, "conf.py")
-exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
-
-# This slightly misuses the 'description', but is the best way to get
-# the manual title to appear in the sidebar.
-html_theme_options['description'] = u'Developer''s Guide'
diff --git a/docs/index.html.in b/docs/index.html.in
deleted file mode 100644
index 33db4396ac8..00000000000
--- a/docs/index.html.in
+++ /dev/null
@@ -1,17 +0,0 @@
-<!DOCTYPE html>
-<html lang="en">
-    <head>
-        <meta charset="UTF-8">
-        <title>QEMU @VERSION@ Documentation</title>
-    </head>
-    <body>
-        <h1>QEMU @VERSION@ Documentation</h1>
-        <ul>
-            <li><a href="system/index.html">System Emulation User's Guide</a></li>
-            <li><a href="user/index.html">User Mode Emulation User's Guide</a></li>
-            <li><a href="tools/index.html">Tools Guide</a></li>
-            <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
-            <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
-        </ul>
-    </body>
-</html>
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
deleted file mode 100644
index 2634ca3410a..00000000000
--- a/docs/interop/conf.py
+++ /dev/null
@@ -1,26 +0,0 @@
-# -*- coding: utf-8 -*-
-#
-# QEMU documentation build configuration file for the 'interop' manual.
-#
-# This includes the top level conf file and then makes any necessary tweaks.
-import sys
-import os
-
-qemu_docdir = os.path.abspath("..")
-parent_config = os.path.join(qemu_docdir, "conf.py")
-exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
-
-# This slightly misuses the 'description', but is the best way to get
-# the manual title to appear in the sidebar.
-html_theme_options['description'] = u'System Emulation Management and Interoperability Guide'
-
-# One entry per manual page. List of tuples
-# (source start file, name, description, authors, manual section).
-man_pages = [
-    ('qemu-ga', 'qemu-ga', u'QEMU Guest Agent',
-     ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
-    ('qemu-ga-ref', 'qemu-ga-ref', 'QEMU Guest Agent Protocol Reference',
-     [], 7),
-    ('qemu-qmp-ref', 'qemu-qmp-ref', 'QEMU QMP Reference Manual',
-     [], 7),
-]
diff --git a/docs/meson.build b/docs/meson.build
index bf8204a08fa..b2aa885a351 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -46,70 +46,56 @@ if build_docs
                           meson.source_root() / 'docs/sphinx/qmp_lexer.py',
                           qapi_gen_depends ]
 
-  configure_file(output: 'index.html',
-                 input: files('index.html.in'),
-                 configuration: {'VERSION': meson.project_version()},
-                 install_dir: qemu_docdir)
-  manuals = [ 'devel', 'interop', 'tools', 'specs', 'system', 'user' ]
   man_pages = {
-    'interop' : {
         'qemu-ga.8': (have_tools ? 'man8' : ''),
         'qemu-ga-ref.7': 'man7',
         'qemu-qmp-ref.7': 'man7',
-    },
-    'tools': {
         'qemu-img.1': (have_tools ? 'man1' : ''),
         'qemu-nbd.8': (have_tools ? 'man8' : ''),
         'qemu-trace-stap.1': (config_host.has_key('CONFIG_TRACE_SYSTEMTAP') ? 'man1' : ''),
         'virtfs-proxy-helper.1': (have_virtfs_proxy_helper ? 'man1' : ''),
         'virtiofsd.1': (have_virtiofsd ? 'man1' : ''),
-    },
-    'system': {
         'qemu.1': 'man1',
         'qemu-block-drivers.7': 'man7',
         'qemu-cpu-models.7': 'man7'
-    },
   }
 
   sphinxdocs = []
   sphinxmans = []
-  foreach manual : manuals
-    private_dir = meson.current_build_dir() / (manual + '.p')
-    output_dir = meson.current_build_dir() / manual
-    input_dir = meson.current_source_dir() / manual
 
-    this_manual = custom_target(manual + ' manual',
+  private_dir = meson.current_build_dir() / 'manual.p'
+  output_dir = meson.current_build_dir() / 'manual'
+  input_dir = meson.current_source_dir()
+
+  this_manual = custom_target('QEMU manual',
                 build_by_default: build_docs,
-                output: [manual + '.stamp'],
-                input: [files('conf.py'), files(manual / 'conf.py')],
-                depfile: manual + '.d',
+                output: 'docs.stamp',
+                input: files('conf.py'),
+                depfile: 'docs.d',
                 depend_files: sphinx_extn_depends,
                 command: [SPHINX_ARGS, '-Ddepfile=@DEPFILE@',
                           '-Ddepfile_stamp=@OUTPUT0@',
                           '-b', 'html', '-d', private_dir,
                           input_dir, output_dir])
-    sphinxdocs += this_manual
-    if build_docs and manual != 'devel'
-      install_subdir(output_dir, install_dir: qemu_docdir)
-    endif
+  sphinxdocs += this_manual
+  install_subdir(output_dir, install_dir: qemu_docdir, strip_directory: true)
 
-    these_man_pages = []
-    install_dirs = []
-    foreach page, section : man_pages.get(manual, {})
-      these_man_pages += page
-      install_dirs += section == '' ? false : get_option('mandir') / section
-    endforeach
-    if these_man_pages.length() > 0
-      sphinxmans += custom_target(manual + ' man pages',
-                         build_by_default: build_docs,
-                         output: these_man_pages,
-                         input: this_manual,
-                         install: build_docs,
-                         install_dir: install_dirs,
-                         command: [SPHINX_ARGS, '-b', 'man', '-d', private_dir,
-                                   input_dir, meson.current_build_dir()])
-    endif
+  these_man_pages = []
+  install_dirs = []
+  foreach page, section : man_pages
+    these_man_pages += page
+    install_dirs += section == '' ? false : get_option('mandir') / section
   endforeach
+
+  sphinxmans += custom_target('QEMU man pages',
+                              build_by_default: build_docs,
+                              output: these_man_pages,
+                              input: this_manual,
+                              install: build_docs,
+                              install_dir: install_dirs,
+                              command: [SPHINX_ARGS, '-b', 'man', '-d', private_dir,
+                                        input_dir, meson.current_build_dir()])
+
   alias_target('sphinxdocs', sphinxdocs)
   alias_target('html', sphinxdocs)
   alias_target('man', sphinxmans)
diff --git a/docs/specs/conf.py b/docs/specs/conf.py
deleted file mode 100644
index 4d56f3ae13c..00000000000
--- a/docs/specs/conf.py
+++ /dev/null
@@ -1,16 +0,0 @@
-# -*- coding: utf-8 -*-
-#
-# QEMU documentation build configuration file for the 'specs' manual.
-#
-# This includes the top level conf file and then makes any necessary tweaks.
-import sys
-import os
-
-qemu_docdir = os.path.abspath("..")
-parent_config = os.path.join(qemu_docdir, "conf.py")
-exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
-
-# This slightly misuses the 'description', but is the best way to get
-# the manual title to appear in the sidebar.
-html_theme_options['description'] = \
-    u'System Emulation Guest Hardware Specifications'
diff --git a/docs/system/conf.py b/docs/system/conf.py
deleted file mode 100644
index 6251849fefc..00000000000
--- a/docs/system/conf.py
+++ /dev/null
@@ -1,28 +0,0 @@
-# -*- coding: utf-8 -*-
-#
-# QEMU documentation build configuration file for the 'system' manual.
-#
-# This includes the top level conf file and then makes any necessary tweaks.
-import sys
-import os
-
-qemu_docdir = os.path.abspath("..")
-parent_config = os.path.join(qemu_docdir, "conf.py")
-exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
-
-# This slightly misuses the 'description', but is the best way to get
-# the manual title to appear in the sidebar.
-html_theme_options['description'] = u'System Emulation User''s Guide'
-
-# One entry per manual page. List of tuples
-# (source start file, name, description, authors, manual section).
-man_pages = [
-    ('qemu-manpage', 'qemu', u'QEMU User Documentation',
-     ['Fabrice Bellard'], 1),
-    ('qemu-block-drivers', 'qemu-block-drivers',
-     u'QEMU block drivers reference',
-     ['Fabrice Bellard and the QEMU Project developers'], 7),
-    ('qemu-cpu-models', 'qemu-cpu-models',
-     u'QEMU CPU Models',
-     ['The QEMU Project developers'], 7)
-]
diff --git a/docs/tools/conf.py b/docs/tools/conf.py
deleted file mode 100644
index 9052d17d6d4..00000000000
--- a/docs/tools/conf.py
+++ /dev/null
@@ -1,33 +0,0 @@
-# -*- coding: utf-8 -*-
-#
-# QEMU documentation build configuration file for the 'tools' manual.
-#
-# This includes the top level conf file and then makes any necessary tweaks.
-import sys
-import os
-
-qemu_docdir = os.path.abspath("..")
-parent_config = os.path.join(qemu_docdir, "conf.py")
-exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
-
-# This slightly misuses the 'description', but is the best way to get
-# the manual title to appear in the sidebar.
-html_theme_options['description'] = \
-    u'Tools Guide'
-
-# One entry per manual page. List of tuples
-# (source start file, name, description, authors, manual section).
-man_pages = [
-    ('qemu-img', 'qemu-img', u'QEMU disk image utility',
-     ['Fabrice Bellard'], 1),
-    ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
-     ['Anthony Liguori <anthony@codemonkey.ws>'], 8),
-    ('qemu-trace-stap', 'qemu-trace-stap', u'QEMU SystemTap trace tool',
-     [], 1),
-    ('virtfs-proxy-helper', 'virtfs-proxy-helper',
-     u'QEMU 9p virtfs proxy filesystem helper',
-     ['M. Mohan Kumar'], 1),
-    ('virtiofsd', 'virtiofsd', u'QEMU virtio-fs shared file system daemon',
-     ['Stefan Hajnoczi <stefanha@redhat.com>',
-      'Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>'], 1),
-]
diff --git a/docs/user/conf.py b/docs/user/conf.py
deleted file mode 100644
index 4b09aedd454..00000000000
--- a/docs/user/conf.py
+++ /dev/null
@@ -1,15 +0,0 @@
-# -*- coding: utf-8 -*-
-#
-# QEMU documentation build configuration file for the 'user' manual.
-#
-# This includes the top level conf file and then makes any necessary tweaks.
-import sys
-import os
-
-qemu_docdir = os.path.abspath("..")
-parent_config = os.path.join(qemu_docdir, "conf.py")
-exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
-
-# This slightly misuses the 'description', but is the best way to get
-# the manual title to appear in the sidebar.
-html_theme_options['description'] = u'User Mode Emulation User''s Guide'
-- 
2.20.1


