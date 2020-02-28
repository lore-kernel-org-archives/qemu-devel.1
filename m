Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1ECC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19DB2469D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbgMcmQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19DB2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hn4-0004Kf-RK
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hh2-0000ts-D6
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hh1-0004vy-7v
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:48 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:40578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hh1-0004tw-0W
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:47 -0500
Received: by mail-wr1-x435.google.com with SMTP id r17so3419902wrj.7
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2CrKzOLXegxkCSm3B7uStBknOAUSCC2J5ztyfqF/dF8=;
 b=tbgMcmQ5o1b7NV7NmTDfwXLN1wh1m4VKuLKv2MSwn5EZwr2I3oEVHm7Scy2xf3Rdh/
 0iFrEO4lCoawo0cWTWVHNnoEJWCBc60A1Yks6wMsKCJl+ps+Daw9Q72nN2WGIzov7S0X
 5uuP3Kas2W3e10BGq+nbI2VABqeyKzOejouJtlsCiXQ8TwO1raSwhifHteIBD1BtPDen
 GCyM+EVX0g1G7eElZxCFqe+wktGrkxIGE5v78kisIFZdTuPJTOrXBkKD0GsCmTN2XCK2
 9WKJa06s9mz0gEZhO9CYH5eQBK3ifJFIFGBDqp/os6r0hiHLzx9QsDiJMmWUrk0OT3/l
 MYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2CrKzOLXegxkCSm3B7uStBknOAUSCC2J5ztyfqF/dF8=;
 b=DWamWupkgaZMDatNOi2kPB3MDcdhNDQI3UAijvo0pV8Jv112dHsOGJMP/hvzAD98lB
 qcum54EPrLifKPnMbw1l8/ppqvojIxomoLvNv2qJBLqIBdbjl3zyEvTH2YA/EJnjPQ2V
 zkgXOhk3VXnnYyX7XDGWuvK+FOK0IIpJ3ZF68W+sgG0LjJ9ELvcLC6flmi0StoVy4nmh
 +MeQCi9BLAsorxZrvefLkfL3pB9w3HbhHPLEYRN3lZs8mMYI+56ASDsxI5xIVF/llNhv
 iersOT7JYAXG7NuptZn413lzdp6IT3VZgLXbU2WXF8MpB9kJh4FCD5s0AQbzdPMq/rWL
 +Eng==
X-Gm-Message-State: APjAAAWQ3lF/v8S2IoQK8WAcBOic5WUIRk7Jvn7+W3j06wnY4wg5fXvY
 N9pFOKjqnQHfpdwEGX2AV8W6i8au4RTZGQ==
X-Google-Smtp-Source: APXvYqxp1Ne6wRf/vUsm3GWCIkUzvHE7n6uQ6RBp/YlFPrnANVim6iySnbXqLLhbIzlBUxE8R+Z07w==
X-Received: by 2002:a5d:4d04:: with SMTP id z4mr5808736wrt.157.1582904205041; 
 Fri, 28 Feb 2020 07:36:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:36:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/33] docs: Create defs.rst.inc as a place to define
 substitutions
Date: Fri, 28 Feb 2020 15:36:00 +0000
Message-Id: <20200228153619.9906-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
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


