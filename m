Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C38C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEBA12051A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tM3tqWQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBA12051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNKw2-0008Ll-UN
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 14:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jNKst-00064u-Qs
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jNKss-0003O5-L9
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:29:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:36985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jNKss-0003NM-FT
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:29:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id w10so5803296wrm.4
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K3xopzk9ZlZX+c2ieZ27XJmBTBZ8Z8Hb6pkp8KbVxfo=;
 b=tM3tqWQtJRDv2IXwsoJYlHcQ+FpbV4uKwGDcux9RYRzQt3b9x2Ff8CwuvHsi14p/t3
 vfjqZXUl9WdGMhtgycXJ/6hwuHZQzoqRcR8/eHXo1mQP5dRcPNwB3W/BtaoYfSBQ6N9e
 6LLQUHh97L6QI7kNcLX2sYItUmnALrcEjoF21+GuoIE6nkk/WltzPK3DjYAtm2v5rNL7
 8tl1NneRbFFA5BevQoujKS1CLdB09YhQE7YPuCPHecK0GpmokmG4ICyGe0V6x+oaWrOX
 NYVvLm6fDiJy1Wv+802tw2kqEuXUOTE9SI3UmuHCPQxySAsYr5eIA1pITdVAmp9RdEPD
 mktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K3xopzk9ZlZX+c2ieZ27XJmBTBZ8Z8Hb6pkp8KbVxfo=;
 b=nVZUhecpEMoESfvAzGQfense7n+fOw7Bd1ND3uYY2wm8wmS+fN7QKQY3y319tbMstW
 +904ZsJB3FRMJ3nKJyqus5igIa9W9V1TqA36VQLtLWfTV5ZPCoD2g+mKGVbeemC3ffvD
 ukqvQFuX91moyrYR45q6mJfNCFXyRT720kwnKBH+//4dS2HvWO+g8N8cRytySCdsVv5C
 iFp3+iNUW4jS5nTjsZ+tpqIg1lMDbvQlfcQfoXa0Ye8uvggf49Rw0ka455Q2txnhq4zU
 LaY1sOVgJg5CRBKMDamu9IchwB+8yroMLbHxnuGeDdl0NvZLynuCTVFUI4z5XCzgdPKZ
 BRsw==
X-Gm-Message-State: AGi0PuYzYKpV0q3hhd770qnI4FkDoWVyAwkDhEX9sV6kiF/QB4MvoayK
 zC+Txixz/3o7odibtCs9SMDcFHNKfyvf7A==
X-Google-Smtp-Source: APiQypI/+SgKj1ASs4nHy0fMhJDyL49PvevSzN/SjUq5X/q5cZuRG0tB4oRuTjqAwmCSrtaz2HbsSw==
X-Received: by 2002:adf:df82:: with SMTP id z2mr385664wrl.58.1586629777241;
 Sat, 11 Apr 2020 11:29:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 68sm8910939wrm.65.2020.04.11.11.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2020 11:29:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0? 1/3] configure: Honour --disable-werror for Sphinx
Date: Sat, 11 Apr 2020 19:29:32 +0100
Message-Id: <20200411182934.28678-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411182934.28678-1-peter.maydell@linaro.org>
References: <20200411182934.28678-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we are not making warnings fatal for compilation, make them
non-fatal when building the Sphinx documentation also.  (For instance
Sphinx 3.0 warns about some constructs that older versions were happy
with, which is a build failure if we use the warnings-as-errors
flag.)

This provides a workaround at least for LP:1872113.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 9 ++++++++-
 Makefile  | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 22870f38672..7b9ae0418d0 100755
--- a/configure
+++ b/configure
@@ -4928,6 +4928,12 @@ if check_include sys/kcov.h ; then
     kcov=yes
 fi
 
+# If we're making warnings fatal, apply this to Sphinx runs as well
+sphinx_werror=""
+if test "$werror" = "yes"; then
+    sphinx_werror="-W"
+fi
+
 # Check we have a new enough version of sphinx-build
 has_sphinx_build() {
     # This is a bit awkward but works: create a trivial document and
@@ -4936,7 +4942,7 @@ has_sphinx_build() {
     # sphinx-build doesn't exist at all or if it is too old.
     mkdir -p "$TMPDIR1/sphinx"
     touch "$TMPDIR1/sphinx/index.rst"
-    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
+    "$sphinx_build" $sphinx_werror -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
 }
 
 # Check if tools are available to build documentation.
@@ -7631,6 +7637,7 @@ echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
 echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
+echo "SPHINX_WERROR=$sphinx_werror" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
diff --git a/Makefile b/Makefile
index 84ef8816000..8a9113e6663 100644
--- a/Makefile
+++ b/Makefile
@@ -1076,7 +1076,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
 # Note the use of different doctree for each (manual, builder) tuple;
 # this works around Sphinx not handling parallel invocation on
 # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
-build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" $(SPHINX_BUILD) $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
+build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" $(SPHINX_BUILD) $(if $(V),,-q) $(SPHINX_WERROR) -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst $(SRC_PATH)/docs/$1/*/*.rst) \
               $(SRC_PATH)/docs/defs.rst.inc \
-- 
2.20.1


