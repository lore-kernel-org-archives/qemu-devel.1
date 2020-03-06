Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0347C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7962073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ak+8Dvzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7962073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAvR-0001Xq-Gn
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAs5-0003h2-U8
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAs3-00054Y-H1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:24 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:36995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAAs3-00053O-9t
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:23 -0500
Received: by mail-wm1-x331.google.com with SMTP id a141so1929976wme.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=36WlJxN28gc48Y60J//Z9uSs1fFYmCpC1+7HM1dJn9o=;
 b=ak+8DvzhiZvhENdwh5Py4WpFtOc2fUfUCuKIz1BwzJ3Wl4SPuXv2LKIm+GdzaQaOLW
 XUZ3jZIxuIeDubwm0ttYbnhIe1mV2I6cD++MGD/sbTN3yxh6e240JhMk6mwb3BHJZjbF
 yvTa+81Fbk7aUtNm9SvEJuDpcRtuNrwHIrNfH3sUE34PeopWtYxY9aJPceWn6G8t+Dbw
 CiZDymQG8607F5WBBj9SIuxPv6RGZl+vdaAQIEIPKJIs0D2i0WiBZv53qWIVQ8vP7Gp8
 UQcPSqGvmUVT6SYuAM+sMkFXxJDdeMrZyRVJecXmjS8weX36OFnbiGb5G0aPe69Ab18w
 Fzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=36WlJxN28gc48Y60J//Z9uSs1fFYmCpC1+7HM1dJn9o=;
 b=CPfyjjetL+OVEVTuFPnTpqbwmIztuSfqY4sICTm81q3WRaoGArvgMqOfTAa7Y5STgJ
 9z1DIVyqnI17uen1g72IhFBBrqqJZB1Kfix7FORh7CEaBajoirWHbr7qqmTEAetEA0Iu
 LybjLyJMMSy7ASAhyag6hK3T24dPJNk40KwWhu9BgU1/sojRw9jGrLrLxVPAJz31/4MV
 I8nAYvFljMzr1oTrE4Gk/lSaIr0eKG2DyY/KD1K08fHTSbQEG8sIim5xvYnNse8dnLAA
 9/xJ6CJ9i9afnZVKJ4PJVT8r7jE+wt3TT20JYCJpeJ1OvHq9rTgidXHBwsq490owLJ/l
 rItA==
X-Gm-Message-State: ANhLgQ0lLqArEx0n4aDy85Fp3ljoGSAMg94WlYbv+fgTSgM/YTnLDj53
 wTJn76ZFJCKaVF+kz7WA9vGZXrO446UBIg==
X-Google-Smtp-Source: ADFU+vvLfvULZ7Y61jfe0HQbl4kSjd43l8+uP5yecWGPijgkh4NepNKlFWPIyW8x2EiPhGC+2GUgdA==
X-Received: by 2002:a05:600c:404a:: with SMTP id
 j10mr3503256wmm.33.1583493021967; 
 Fri, 06 Mar 2020 03:10:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/33] docs: Create defs.rst.inc as a place to define
 substitutions
Date: Fri,  6 Mar 2020 11:09:40 +0000
Message-Id: <20200306110959.29461-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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

Rather than accumulating generally useful rST substitution
definitions in individual rST files, create a defs.rst.inc where we
can define these.  To start with it has the |qemu_system| definition
from qemu-block-drivers.rst.

Add a comment noting a pitfall where putting literal markup in the
definition of |qemu_system| makes it misrender manpage output; this
means the point-of-use must handle the literal markup (which is
almost always done by having it inside a parsed-literal block).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200228153619.9906-15-peter.maydell@linaro.org
---
 Makefile                           |  1 +
 docs/conf.py                       |  6 ++++++
 docs/defs.rst.inc                  | 11 +++++++++++
 docs/system/qemu-block-drivers.rst |  2 --
 4 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100644 docs/defs.rst.inc

diff --git a/Makefile b/Makefile
index 7e60a435426..26bbd334438 100644
--- a/Makefile
+++ b/Makefile
@@ -1052,6 +1052,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
 build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" $(SPHINX_BUILD) $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
+              $(SRC_PATH)/docs/defs.rst.inc \
               $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
 # Macro to write out the rule and dependencies for building manpages
 # Usage: $(call define-manpage-rule,manualname,manpage1 manpage2...[,extradeps])
diff --git a/docs/conf.py b/docs/conf.py
index 7588bf192ee..960043cb860 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -132,6 +132,12 @@ suppress_warnings = ["ref.option"]
 # style document building; our Makefile always sets the variable.
 confdir = os.getenv('CONFDIR', "/etc/qemu")
 rst_epilog = ".. |CONFDIR| replace:: ``" + confdir + "``\n"
+# We slurp in the defs.rst.inc and literally include it into rst_epilog,
+# because Sphinx's include:: directive doesn't work with absolute paths
+# and there isn't any one single relative path that will work for all
+# documents and for both via-make and direct sphinx-build invocation.
+with open(os.path.join(qemu_docdir, 'defs.rst.inc')) as f:
+    rst_epilog += f.read()
 
 # -- Options for HTML output ----------------------------------------------
 
diff --git a/docs/defs.rst.inc b/docs/defs.rst.inc
new file mode 100644
index 00000000000..ae80d2f35d8
--- /dev/null
+++ b/docs/defs.rst.inc
@@ -0,0 +1,11 @@
+..
+   Generally useful rST substitution definitions. This is included for
+   all rST files as part of the epilogue by docs/conf.py.  conf.py
+   also defines some dynamically generated substitutions like CONFDIR.
+
+   Note that |qemu_system| is intended to be used inside a parsed-literal
+   block: the definition must not include extra literal formatting with
+   ``..``: this works in the HTML output but the manpages will end up
+   misrendered with following normal text incorrectly in boldface.
+
+.. |qemu_system| replace:: qemu-system-x86_64
diff --git a/docs/system/qemu-block-drivers.rst b/docs/system/qemu-block-drivers.rst
index 7ca890ea23a..bd99d4fa8eb 100644
--- a/docs/system/qemu-block-drivers.rst
+++ b/docs/system/qemu-block-drivers.rst
@@ -3,8 +3,6 @@
 QEMU block drivers reference
 ============================
 
-.. |qemu_system| replace:: qemu-system-x86_64
-
 Synopsis
 --------
 
-- 
2.20.1


