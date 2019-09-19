Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41750C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101F221929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjNW3GJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101F221929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0L6-0005nx-Hz
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB06t-0008Kv-5M
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iB05m-0000Oy-Uv
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:19:44 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iB05m-0000OX-NN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:19:42 -0400
Received: by mail-wm1-x343.google.com with SMTP id 7so5580577wme.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9KzFKDieUQ0ZocRaEPSFD2NAIupLGWoORjl8U1JZy58=;
 b=JjNW3GJjd7o4+WlIbaiGLZfdMPRuwsOPRbOE/dILPFjnjCA+xUhajV/gk0RnJjKRu4
 BeorQ5tYCCB7ozP9g+JHrgQzUXfXlGm5LLTM7ygD9ymIHglJARq2qNt84Oo+p0Zn5gvw
 yhKl4jPhhjD/ITzHRVWpuG1s5BEyfQUWc0hImXFrlPVjFcHHLRuwmn1pr6s/CORob0nW
 h0L3keq2bYf1uS+HxYoGR8PRPnsFiNYYfLczl2blHT5gHNMmZpEAPlzSBjXlfb1XwzAx
 6ZcCXLgyAGSk6gsM01V5vwK04OIR47Q1a+XWMQS8BwPjlq1mkkpHOkYU9KdSvhR6Yfe/
 zu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9KzFKDieUQ0ZocRaEPSFD2NAIupLGWoORjl8U1JZy58=;
 b=MtUI88rI4r2cZx0QyA5DmnjQbsXevEFsrIAA9uAXo9VUdfU9HT+LQosPVuOZDYUWrk
 tR9fUcfuKMaungVOcOFTCSs2XmfqwFZIOVHIL0rfMAerWQrUW7DJm4yrwgUAYYYeGwOk
 G1R/XwQrSQw64FDK087kwX1sTJcnd+mzpmseXIniRxp32x6qT3l6zHBIpCsvIumr/yXg
 a92JgDWAszUE6FY44Ca9c4hTL5pyb4IrBTYoNY/u61GXB16CdPXUi/AG+WziRb7vZzFo
 jqDQjSMXyaPQtLx+kK501BCVn9jLRT4NdyIjgbHF6KRiBsbcYeyVW+dc+bXPTEcrsD/b
 Ivjw==
X-Gm-Message-State: APjAAAXrnD0RdF67j+G/5/H8rhiWfCJZgIrHhqSTJ3bzj1IFDlPXZh+r
 RgoQ9P365AS8XrSepJwjYUGuwfFyzFM=
X-Google-Smtp-Source: APXvYqyvashH4wJKjB8lrKIEttfiI5bDbWGrp085lEOxhE/co9aOnMaeYvuYqVZzd+zH2c9I95Lc9g==
X-Received: by 2002:a05:600c:204a:: with SMTP id
 p10mr3977039wmg.175.1568913581547; 
 Thu, 19 Sep 2019 10:19:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j26sm16970160wrd.2.2019.09.19.10.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:19:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3D8211FF9F;
 Thu, 19 Sep 2019 18:10:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/16] Makefile: fix-up qemu-ga.8 paths to take in-src
 builds into account
Date: Thu, 19 Sep 2019 18:10:15 +0100
Message-Id: <20190919171015.12681-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919171015.12681-1-alex.bennee@linaro.org>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We tweak MANUAL_BUILDIR for in-src builds because sphinx won't build
documents inside a source tree. This was causing the document build to
fail on things like shippable which were using in-tree builds.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 3cf5b1e7539..8da33595edd 100644
--- a/Makefile
+++ b/Makefile
@@ -324,8 +324,19 @@ endif
 endif
 endif
 
+# Sphinx does not allow building manuals into the same directory as
+# the source files, so if we're doing an in-tree QEMU build we must
+# build the manuals into a subdirectory (and then install them from
+# there for 'make install'). For an out-of-tree build we can just
+# use the docs/ subdirectory in the build tree as normal.
+ifeq ($(realpath $(SRC_PATH)),$(realpath .))
+MANUAL_BUILDDIR := docs/built
+else
+MANUAL_BUILDDIR := docs
+endif
+
 ifdef BUILD_DOCS
-DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 docs/interop/qemu-ga.8
+DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 $(MANUAL_BUILDDIR)/interop/qemu-ga.8
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
 DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
 DOCS+=docs/qemu-block-drivers.7
@@ -703,17 +714,6 @@ dist: qemu-$(VERSION).tar.bz2
 qemu-%.tar.bz2:
 	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.bz2,%,$@)"
 
-# Sphinx does not allow building manuals into the same directory as
-# the source files, so if we're doing an in-tree QEMU build we must
-# build the manuals into a subdirectory (and then install them from
-# there for 'make install'). For an out-of-tree build we can just
-# use the docs/ subdirectory in the build tree as normal.
-ifeq ($(realpath $(SRC_PATH)),$(realpath .))
-MANUAL_BUILDDIR := docs/built
-else
-MANUAL_BUILDDIR := docs
-endif
-
 define clean-manual =
 rm -rf $(MANUAL_BUILDDIR)/$1/_static
 rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUILDDIR)/$1/searchindex.js $(MANUAL_BUILDDIR)/$1/*.html
@@ -823,7 +823,7 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
 endif
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
-	$(INSTALL_DATA) docs/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
-- 
2.20.1


