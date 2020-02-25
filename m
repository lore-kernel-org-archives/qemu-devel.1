Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8D1C35DFB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6893A218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKz3Vnx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6893A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Xzl-0005rT-J3
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Xyk-0004tA-N0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:02:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Xyg-00077X-Pi
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:02:18 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:52396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6Xyg-000761-IB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:02:14 -0500
Received: by mail-wm1-x32c.google.com with SMTP id p9so2527324wmc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=pdxIq/NO+K6PV8qogHqN82Q6uuaSbpCxqiilOGy4s0U=;
 b=MKz3Vnx+GIRe3qVZhciHc5WbP36mXDpYkTb1Ptwf2SEULnboLci3I+pEQ1wNGYdvd2
 KAm4lVadZ4V3GU0mFVJPr0V423kzE+jpvGG0LhxkcEznAixj/keIxi+/BAEXVyGet9ZW
 JSIo050uTi05Y/UFsPMqng0qt2AyKq4gawEQWt0hKa0LkaZLBPPIrtvQC6HIReccNT19
 IsI3HymxAugAXzfZ3WRqsyYffvcTOG8ibZhsu7WB6b4SscDVXshQbIDJX9ByhBXJwNvH
 mB4VyhJ61ERFP1/RZTa+hcm5G4jQ6veZD2TnvH4XSJL4CffcW6hq6Z9FwQWgmTa69dYG
 K/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pdxIq/NO+K6PV8qogHqN82Q6uuaSbpCxqiilOGy4s0U=;
 b=Bw5y9ySPtUiRt9vaPyiAHmFPKDUMRZKH8ehXmrX8t+J353MhX5KxmwQGJn11Bjvqzd
 7lbXaNqCT+syt8iI6mrrH02O2AZqdRYWw7vTdrXsdzRNVtPo5TpNST+6GQtrXiw+/TLF
 kk8HFsBNu6Qa7HD4E2JG3f/waoU3d0P0uswGDTlFahIltmoRy795xlC9JMZlFNFrRNjx
 nkwZVn3P3puAYll1HvnvMhwiN7r9F5qts6mzzdxkCy0HldCU3Lu6eAxSxKnBco070bzU
 39RQZP0MTFvFMpHnl3fOczUQt4NWKHvdl0bGgUbjuwqVbbE6VgiABFGdINnxZlbxS/Ls
 59/A==
X-Gm-Message-State: APjAAAUebJbaamVr7riTHwxycixMec9PspDZHocT1ELFQvXWQdWltOiD
 z9CbJyQEnDeQDokkun/3hEc65whkPNWrLg==
X-Google-Smtp-Source: APXvYqzNy0eZLkU35MNy4I8URmfdMYgXMytQwZAsiilfW8Bk4Dc1jpKU/+ouF/9xCKJxcu6KGzF5fw==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr5041242wmk.68.1582628529119; 
 Tue, 25 Feb 2020 03:02:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id n8sm22483092wrx.42.2020.02.25.03.02.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 03:02:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] docs: Create new 'tools' manual
Date: Tue, 25 Feb 2020 11:02:02 +0000
Message-Id: <20200225110204.30662-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225110204.30662-1-peter.maydell@linaro.org>
References: <20200225110204.30662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

Some of the documentation for QEMU "tools" which are standalone
binaries like qemu-img is an awkward fit in our current 5-manual
split. We've put it into "interop", but they're not really
about interoperability.

Create a new top level manual "tools" which will be a better
home for this documentation. This commit creates an empty
initial manual; we will move the relevant documentation
files in a subsequent commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20200217155415.30949-2-peter.maydell@linaro.org
---
 Makefile             |  8 +++++++-
 docs/index.html.in   |  1 +
 docs/index.rst       |  1 +
 docs/tools/conf.py   | 16 ++++++++++++++++
 docs/tools/index.rst | 11 +++++++++++
 5 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 docs/tools/conf.py
 create mode 100644 docs/tools/index.rst

diff --git a/Makefile b/Makefile
index 15f8e53d050..c4c2eba7a7c 100644
--- a/Makefile
+++ b/Makefile
@@ -786,6 +786,7 @@ distclean: clean
 	$(call clean-manual,interop)
 	$(call clean-manual,specs)
 	$(call clean-manual,system)
+	$(call clean-manual,tools)
 	for d in $(TARGET_DIRS); do \
 	rm -rf $$d || exit 1 ; \
         done
@@ -843,6 +844,7 @@ install-sphinxdocs: sphinxdocs
 	$(call install-manual,interop)
 	$(call install-manual,specs)
 	$(call install-manual,system)
+	$(call install-manual,tools)
 
 install-doc: $(DOCS) install-sphinxdocs
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
@@ -1036,7 +1038,8 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
 sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
             $(MANUAL_BUILDDIR)/interop/index.html \
             $(MANUAL_BUILDDIR)/specs/index.html \
-            $(MANUAL_BUILDDIR)/system/index.html
+            $(MANUAL_BUILDDIR)/system/index.html \
+            $(MANUAL_BUILDDIR)/tools/index.html
 
 # Canned command to build a single manual
 # Arguments: $1 = manual name, $2 = Sphinx builder ('html' or 'man')
@@ -1069,6 +1072,9 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
 $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
 	$(call build-manual,system,html)
 
+$(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools)
+	$(call build-manual,tools,html)
+
 $(call define-manpage-rule,interop,\
        qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
        virtiofsd.1 virtfs-proxy-helper.1,\
diff --git a/docs/index.html.in b/docs/index.html.in
index 8512933d145..cf61b1cf448 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -13,6 +13,7 @@
             <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
             <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
             <li><a href="system/index.html">System Emulation User's Guide</a></li>
+            <li><a href="tools/index.html">Tools Guide</a></li>
         </ul>
     </body>
 </html>
diff --git a/docs/index.rst b/docs/index.rst
index 46405d4f077..acd604fa8a9 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -14,3 +14,4 @@ Welcome to QEMU's documentation!
    devel/index
    specs/index
    system/index
+   tools/index
diff --git a/docs/tools/conf.py b/docs/tools/conf.py
new file mode 100644
index 00000000000..56461110b9d
--- /dev/null
+++ b/docs/tools/conf.py
@@ -0,0 +1,16 @@
+# -*- coding: utf-8 -*-
+#
+# QEMU documentation build configuration file for the 'tools' manual.
+#
+# This includes the top level conf file and then makes any necessary tweaks.
+import sys
+import os
+
+qemu_docdir = os.path.abspath("..")
+parent_config = os.path.join(qemu_docdir, "conf.py")
+exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
+
+# This slightly misuses the 'description', but is the best way to get
+# the manual title to appear in the sidebar.
+html_theme_options['description'] = \
+    u'Tools Guide'
diff --git a/docs/tools/index.rst b/docs/tools/index.rst
new file mode 100644
index 00000000000..c5a4a13ec7a
--- /dev/null
+++ b/docs/tools/index.rst
@@ -0,0 +1,11 @@
+.. This is the top level page for the 'tools' manual
+
+
+QEMU Tools Guide
+================
+
+
+Contents:
+
+.. toctree::
+   :maxdepth: 2
-- 
2.20.1


