Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB29C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B5F020721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLjfWtwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5F020721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybl2-00083q-6N
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iybjS-0006om-Ow
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iybjR-0000LL-IL
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:25:42 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:39294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iybjR-0000KE-By
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:25:41 -0500
Received: by mail-wm1-x336.google.com with SMTP id c84so17056160wme.4
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 05:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CJfpWUmNUfHJ0flee+mwQ9IL4sv3dOkTSa9lfSyOoQc=;
 b=VLjfWtwogLYWLMrhlZ6lXf3zBNcflQWrdAaWb28VQQ28cTfTqFc4ufxyi/R9qfp0FD
 TXSZ/19IjlK4oUi/TFym/tusanJCc44Z3lp0Cx/IGX2vB2M/KvmrldMXAZkKWfOaYhhd
 fpkqWoRVBFfaF4EC6+9vGpGoAgCX9z5EMclTUKp4fKTemkB9BbrQTaZ64yZvJMd70F1T
 IzNZt21tgYrORh0VKs5d5VSixvFxQRQEHnScXaWwpdCgS9uDnVUkDWdd0O3hBowNHGap
 Rvej9WUHRl1hAwQNVuLUlWWAeb+p4yYDNqnW/dj+iIv27uuN1UmyCbESE3hjb7n0d124
 ofeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CJfpWUmNUfHJ0flee+mwQ9IL4sv3dOkTSa9lfSyOoQc=;
 b=VtP7uDdYYobUbbQSLdT4e9gmqjTtSEWJ3ENhqOgV19+gkHyxmnK1gckWcPkbeKdsL1
 f/79byqsPAPI+WZc5Ahd3APbzg9mXtS8vqDU6psWOeYL+G9J5K9JC5tHy1NEUb1+ol2q
 VBWVZ8oFoamiDnmzlrmCAPhDC9vHuc+dSbSpkbxF2wfqW1X1kpHrEYvOsZyePFrJme6R
 rVOgcCfbv/IdpPEN/8QfQ0/6Hw0RIMye3qJuErkChzW5x09rjT//xpjAiBm1sAm9YHP0
 wvSGXC92XeavqzGIAS3y1RtKakWpIKfLs1C/Mbzy41yTxKlk8beF882CmH7DVrF32nOD
 1Y+A==
X-Gm-Message-State: APjAAAV38As3s4QII1ghoQkw9X35lNSAn52R0jmHFmM5WkV2fOJs7XSG
 s2VWKbOwWvqOAW/iIuLwhlRGNpS2kYIicw==
X-Google-Smtp-Source: APXvYqwYPQNzTj6KUzqedUXYMfXI1o7ywQZMhNqwMaHc+tzmByGmM+GQEuIyjoQZ5c0plIYdFTGGzw==
X-Received: by 2002:a05:600c:242:: with SMTP id 2mr28171428wmj.2.1580736338910; 
 Mon, 03 Feb 2020 05:25:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s16sm26100534wrn.78.2020.02.03.05.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 05:25:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] configure: Check that sphinx-build is using Python 3
Date: Mon,  3 Feb 2020 13:25:33 +0000
Message-Id: <20200203132533.21850-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203132533.21850-1-peter.maydell@linaro.org>
References: <20200203132533.21850-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently configure's has_sphinx_build() check simply runs a dummy
sphinx-build and either passes or fails.  This means that "no
sphinx-build at all" and "sphinx-build exists but is too old" are
both reported the same way.

Further, we want to assume that all the Python we write is running
with at least Python 3.5; configure checks that for our scripts, but
Sphinx extensions run with whatever Python version sphinx-build
itself is using.

Add a check to our conf.py which makes sphinx-build fail if it would
be running our extensions with an old Python, and handle this
in configure so we can report failure helpfully to the user.
This will mean that configure --enable-docs will fail like this
if the sphinx-build provided is not suitable:

Warning: sphinx-build exists but it is either too old or uses too old a Python version

ERROR: User requested feature docs
       configure was not able to find it.
       Install texinfo, Perl/perl-podlators and a Python 3 version of python-sphinx

(As usual, the default is to simply not build the docs, as we would
if sphinx-build wasn't present at all.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
At the moment our Sphinx extensions all work under Python 2;
but the one for handling parsing QAPI docs out of the JSON is going
to want to include some of the scripts/qapi Python which is more
complicated and definitely now 3-only.  In any case it's nicer to
fail cleanly rather than let users stumble into corner cases we don't
test and don't want to support even if they happen to work today.
---
 configure    | 12 ++++++++++--
 docs/conf.py | 10 ++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 830f325822a..95055f2e9dd 100755
--- a/configure
+++ b/configure
@@ -4808,11 +4808,19 @@ has_sphinx_build() {
 
 # Check if tools are available to build documentation.
 if test "$docs" != "no" ; then
-  if has makeinfo && has pod2man && has_sphinx_build; then
+  if has_sphinx_build; then
+    sphinx_ok=yes
+  else
+    sphinx_ok=no
+  fi
+  if has makeinfo && has pod2man && test "$sphinx_ok" = "yes"; then
     docs=yes
   else
     if test "$docs" = "yes" ; then
-      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and python-sphinx"
+      if has $sphinx_build && test "$sphinx_ok" != "yes"; then
+        echo "Warning: $sphinx_build exists but it is either too old or uses too old a Python version" >&2
+      fi
+      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and a Python 3 version of python-sphinx"
     fi
     docs=no
   fi
diff --git a/docs/conf.py b/docs/conf.py
index ee7faa6b4e7..7588bf192ee 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -28,6 +28,16 @@
 
 import os
 import sys
+import sphinx
+from sphinx.errors import VersionRequirementError
+
+# Make Sphinx fail cleanly if using an old Python, rather than obscurely
+# failing because some code in one of our extensions doesn't work there.
+# Unfortunately this doesn't display very neatly (there's an unavoidable
+# Python backtrace) but at least the information gets printed...
+if sys.version_info < (3,5):
+    raise VersionRequirementError(
+        "QEMU requires a Sphinx that uses Python 3.5 or better\n")
 
 # The per-manual conf.py will set qemu_docdir for a single-manual build;
 # otherwise set it here if this is an entire-manual-set build.
-- 
2.20.1


