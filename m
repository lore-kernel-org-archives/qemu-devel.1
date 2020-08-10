Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370C2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFCEC22BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmvRTpp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCEC22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DtX-00033U-2C
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Doh-0000Z6-VK
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:43 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:33502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Doe-0004lX-Ny
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:43 -0400
Received: by mail-wr1-x436.google.com with SMTP id p20so9317104wrf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9f9MZL1OazmNxGdgFSs03UaW8w8TN7a6dCRj95o9ljc=;
 b=OmvRTpp+nYMLejdvqc3tIOO6zTj2pqfsVd+xk+tJBitEuilccljLrfJlTlQokBuCqQ
 yunw5VWHpMUy/mW/+N/HgE869g3B9VPQAhMpA0AMl1gFWH+uWtayBm7nsZJUQ/7aJaUD
 gHMadkZlCw++AcDYZYwfVW4G3NeKFfALgIjMLeqOfvfmPILl07l2mbVCTuSoJtUBH2E4
 PoBp+MoBWQf+s3ZZjiEi+8/08exRWZqyovgXSyz17JK7m6EFwRD8+GLMUUgw10a4ACFA
 54XFCfT6WTU82enE+BcUL23wdgyX3tYMQt5cCQXH19jXgOa4cZ2/VojC7b3pYeGXZ2SZ
 +K4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9f9MZL1OazmNxGdgFSs03UaW8w8TN7a6dCRj95o9ljc=;
 b=i4YaNxwQ2UmCHawsM0NHlp/Cx3niojKr7eX44PrYQtxNDY30AQogp4rgO3vQc+Oj8T
 DFQJu0AZ6A8en5XOUZg5FxsCGVQE6+73Qnx7MTi1bQPNK/iy+fFKb9bWS9aI18Ad59e5
 f1sLvsp+Q4UfrYcH1uXpBoF64NWatm/atn463vimMPpsj2K4dbSaCYDCWeJ7DBow0dOM
 k+n2L41POK+OVyt2tHlj/cc4W5YNflDUcbbWOwx7aPu+HLYd6VHy/eM6KQv+mvEA0Ubw
 Brc7gR/m7XA3huHwq3x5pGxJ6OK/Lpmg2Gi16g7flfPwyM1sxrRU4zqi47kKSNGz8CqB
 fwmA==
X-Gm-Message-State: AOAM531ctYfEqpivEgUl4taJk3Nwpz8UP5bObX1uAVfxZ7Se1FJy9yEO
 5O3E9mqtHoBIwyNnOrV2ZIlIXDrugTrT/w==
X-Google-Smtp-Source: ABdhPJyxoacmqgdGbNjb+b6MWgRSwEC2VkxJTX5UlAaldJfEJJDRA8YeLQgXOsaA0lhetqtQ+B2XOQ==
X-Received: by 2002:a05:6000:1203:: with SMTP id
 e3mr26634978wrx.324.1597089038502; 
 Mon, 10 Aug 2020 12:50:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 10/20] docs/interop: Convert qemu-ga-ref to rST
Date: Mon, 10 Aug 2020 20:50:09 +0100
Message-Id: <20200810195019.25427-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert qemu-ga-ref to rST format. This includes dropping
the plain-text, pdf and info format outputs for this document;
as with all our other Sphinx-based documentation, we provide
HTML and manpage only.

The qemu-ga-ref.rst is somewhat more stripped down than
the .texi was, because we do not (currently) attempt to
generate indexes for the commands, events and data types
being documented.

As the GA ref is now part of the Sphinx 'interop' manual,
we can delete the direct link from index.html.in.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/index.html.in            |  1 -
 docs/interop/conf.py          |  2 +
 docs/interop/index.rst        |  1 +
 docs/interop/qemu-ga-ref.rst  |  4 ++
 docs/interop/qemu-ga-ref.texi | 80 -----------------------------------
 Makefile                      | 42 ++++++++----------
 MAINTAINERS                   |  2 +-
 7 files changed, 25 insertions(+), 107 deletions(-)
 create mode 100644 docs/interop/qemu-ga-ref.rst
 delete mode 100644 docs/interop/qemu-ga-ref.texi

diff --git a/docs/index.html.in b/docs/index.html.in
index 6736fa4360c..99d4d8075fc 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -13,7 +13,6 @@
             <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
             <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
             <li><a href="interop/qemu-qmp-ref.html">QMP Reference Manual</a></li>
-            <li><a href="interop/qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
         </ul>
     </body>
 </html>
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
index 42ce7e3d365..e83632e0108 100644
--- a/docs/interop/conf.py
+++ b/docs/interop/conf.py
@@ -19,4 +19,6 @@ html_theme_options['description'] = u'System Emulation Management and Interopera
 man_pages = [
     ('qemu-ga', 'qemu-ga', u'QEMU Guest Agent',
      ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
+    ('qemu-ga-ref', 'qemu-ga-ref', u'QEMU Guest Agent Protocol Reference',
+     [], 7),
 ]
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index 006f9864208..738cdbe185e 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -18,6 +18,7 @@ Contents:
    live-block-operations
    pr-helper
    qemu-ga
+   qemu-ga-ref
    vhost-user
    vhost-user-gpu
    vhost-vdpa
diff --git a/docs/interop/qemu-ga-ref.rst b/docs/interop/qemu-ga-ref.rst
new file mode 100644
index 00000000000..013eac0bb53
--- /dev/null
+++ b/docs/interop/qemu-ga-ref.rst
@@ -0,0 +1,4 @@
+QEMU Guest Agent Protocol Reference
+===================================
+
+.. qapi-doc:: qga/qapi-schema.json
diff --git a/docs/interop/qemu-ga-ref.texi b/docs/interop/qemu-ga-ref.texi
deleted file mode 100644
index ddb76ce1c2a..00000000000
--- a/docs/interop/qemu-ga-ref.texi
+++ /dev/null
@@ -1,80 +0,0 @@
-\input texinfo
-@setfilename qemu-ga-ref.info
-
-@include version.texi
-
-@exampleindent 0
-@paragraphindent 0
-
-@settitle QEMU Guest Agent Protocol Reference
-
-@iftex
-@center @image{docs/qemu_logo}
-@end iftex
-
-@copying
-This is the QEMU Guest Agent Protocol reference manual.
-
-Copyright @copyright{} 2016 The QEMU Project developers
-
-@quotation
-This manual is free documentation: you can redistribute it and/or
-modify it under the terms of the GNU General Public License as
-published by the Free Software Foundation, either version 2 of the
-License, or (at your option) any later version.
-
-This manual is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this manual.  If not, see http://www.gnu.org/licenses/.
-@end quotation
-@end copying
-
-@dircategory QEMU
-@direntry
-* QEMU-GA-Ref: (qemu-ga-ref).   QEMU Guest Agent Protocol Reference
-@end direntry
-
-@titlepage
-@title Guest Agent Protocol Reference Manual
-@subtitle QEMU version @value{VERSION}
-@page
-@vskip 0pt plus 1filll
-@insertcopying
-@end titlepage
-
-@contents
-
-@ifnottex
-@node Top
-@top QEMU Guest Agent protocol reference
-@end ifnottex
-
-@menu
-* API Reference::
-* Commands and Events Index::
-* Data Types Index::
-@end menu
-
-@node API Reference
-@chapter API Reference
-
-@c for texi2pod:
-@c man begin DESCRIPTION
-
-@include qemu-ga-qapi.texi
-
-@c man end
-
-@node Commands and Events Index
-@unnumbered Commands and Events Index
-@printindex fn
-
-@node Data Types Index
-@unnumbered Data Types Index
-@printindex tp
-
-@bye
diff --git a/Makefile b/Makefile
index 13dd708c4af..f0cca10b427 100644
--- a/Makefile
+++ b/Makefile
@@ -371,7 +371,7 @@ DOCS+=$(MANUAL_BUILDDIR)/tools/virtiofsd.1
 endif
 DOCS+=$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
-DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
+DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-ga-ref.7
 DOCS+=$(MANUAL_BUILDDIR)/system/qemu-cpu-models.7
 DOCS+=$(MANUAL_BUILDDIR)/index.html
 ifdef CONFIG_VIRTFS
@@ -800,11 +800,11 @@ distclean: clean
 	rm -f config.log
 	rm -f linux-headers/asm
 	rm -f docs/version.texi
-	rm -f docs/interop/qemu-ga-qapi.texi docs/interop/qemu-qmp-qapi.texi
-	rm -f docs/interop/qemu-qmp-ref.7 docs/interop/qemu-ga-ref.7
-	rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
-	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
-	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
+	rm -f docs/interop/qemu-qmp-qapi.texi
+	rm -f docs/interop/qemu-qmp-ref.7
+	rm -f docs/interop/qemu-qmp-ref.txt
+	rm -f docs/interop/qemu-qmp-ref.pdf
+	rm -f docs/interop/qemu-qmp-ref.html
 	rm -rf .doctrees
 	$(call clean-manual,devel)
 	$(call clean-manual,interop)
@@ -858,7 +858,7 @@ endif
 # and also any sphinx-built manpages.
 define install-manual =
 for d in $$(cd $(MANUAL_BUILDDIR) && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
-for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name '*.[0-9]' -o -name 'qemu-*-qapi.*' -o -name 'qemu-*-ref.*' ')' ); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
+for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name '*.[0-9]' -o -name 'qemu-*-qapi.*' -o -name 'qemu-qmp-ref.*' ')' ); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
 endef
 
 # Note that we deliberately do not install the "devel" manual: it is
@@ -894,10 +894,7 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 endif
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/interop"
-	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)/interop"
-	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)/interop"
-	$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
 endif
 endif
 ifdef CONFIG_VIRTFS
@@ -1090,7 +1087,7 @@ endef
 $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
 	$(call build-manual,devel,html)
 
-$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
+$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
 	$(call build-manual,interop,html)
 
 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
@@ -1105,7 +1102,10 @@ $(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools) $(SRC_PATH)/qemu-
 $(MANUAL_BUILDDIR)/user/index.html: $(call manual-deps,user)
 	$(call build-manual,user,html)
 
-$(call define-manpage-rule,interop,qemu-ga.8)
+$(call define-manpage-rule,interop,\
+       qemu-ga.8 qemu-ga-ref.7,\
+       $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/qga/qapi-schema.json \
+       $(qapi-py))
 
 $(call define-manpage-rule,system,qemu.1 qemu-block-drivers.7 qemu-cpu-models.7)
 
@@ -1122,18 +1122,10 @@ $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
 docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 	@cp -p $< $@
 
-docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
-	@cp -p $< $@
-
-html: docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
-info: docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
-pdf: docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
-txt: docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
-
-docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
-    docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
-    docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7: \
-	docs/interop/qemu-ga-ref.texi docs/interop/qemu-ga-qapi.texi
+html: docs/interop/qemu-qmp-ref.html sphinxdocs
+info: docs/interop/qemu-qmp-ref.info
+pdf: docs/interop/qemu-qmp-ref.pdf
+txt: docs/interop/qemu-qmp-ref.txt
 
 docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-ref.html \
     docs/interop/qemu-qmp-ref.info docs/interop/qemu-qmp-ref.pdf \
diff --git a/MAINTAINERS b/MAINTAINERS
index fdd38f412d7..6eae3625733 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2394,9 +2394,9 @@ M: Michael Roth <mdroth@linux.vnet.ibm.com>
 S: Maintained
 F: qga/
 F: docs/interop/qemu-ga.rst
+F: docs/interop/qemu-ga-ref.rst
 F: scripts/qemu-guest-agent/
 F: tests/test-qga.c
-F: docs/interop/qemu-ga-ref.texi
 T: git https://github.com/mdroth/qemu.git qga
 
 QOM
-- 
2.20.1


