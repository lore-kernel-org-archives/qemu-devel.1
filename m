Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D945CC352A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC60921741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RA/hdVYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC60921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izl1d-0008KA-Pf
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzL-00063e-B8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzJ-0003q1-Ie
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:51 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:37716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkzH-0003gK-Rm
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:49 -0500
Received: by mail-wm1-x334.google.com with SMTP id f129so995344wmf.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d/ebdcIXrQTTW84jcoWGJHeNN6IFG3QgpgPcIBhY1sQ=;
 b=RA/hdVYl4Su/0rRFK3HyMmx1LC0aj65RCNgTuDAF6SMpz7xCWipxVcbpKgz+tJv2cM
 fjvK+9gTF7gOml7BUw6oyBNc1/WPGgUYM1DIzIKw2fy2BU+cPkOCLrjQXz2fVz3ZVREk
 WZTfEZOZ3ZAAGJbO3QGS7PdVGOTq0k8fmbKzbZ9hTD2NuwIND/osnmFFX74+8k4tQ0rL
 9R/BVnS9mkCdlhjn5Xtk5zmoJhWcuOA+Gbw3HFIv/opRoC11tDFx3z5oAn2dNdsYbHL5
 gyzWFlV9XZPgbKqLmxfb72QqK3aYDXhhAAUvoAZqhe3rI//WNK7hYx7Y0AvBGSPggVrb
 Y8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d/ebdcIXrQTTW84jcoWGJHeNN6IFG3QgpgPcIBhY1sQ=;
 b=MmQxp4gjESyFgWVW0USYbo29dLH3oT72kqDo+/kc04RSldALb9dLPa+bX33nKu8GM+
 pFUT7Dkp2B45YURYQ+XYo7hVH1GzbNnyIG9oO1pITHZM1fEA1z3XYATHZwEEx6oCe2SO
 GJ85Wu2ba7jLrA25iEUjzeVz8WW1wkCwJWH0yWqE1yH/IcCJlvQSBTbs+V5OKFxm+BcP
 ASWab/3479w3OntOJh7U0+iCMCPmT/n0uaSP/PYpvHxhYOkp4eEfaRAVla7zq8Tc/BO2
 LYSCzyDv7te95ofuMwIJilBJQaROWc0R+hoQNtUuY37cCBjBIuCFe4h8M7gbb9v1DgpV
 a2eQ==
X-Gm-Message-State: APjAAAWZ+BD23bB7vsP1AjLG82inNGoOhCxdVYRyT7i2OWj1d4gbMWk3
 TkOwqvTe77pfbOQ+HIpE/aAuJ7L7Rl4=
X-Google-Smtp-Source: APXvYqxdX/xvwv5ISmY4sVwIZfFv7oiDikXkdN+NkKNQGEqBarko7mkDAfxzaX5R8zd6PxTp4ejH4Q==
X-Received: by 2002:a1c:e246:: with SMTP id z67mr6050971wmg.52.1581010246179; 
 Thu, 06 Feb 2020 09:30:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:30:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/29] configure: Allow user to specify sphinx-build binary
Date: Thu,  6 Feb 2020 17:30:12 +0000
Message-Id: <20200206173040.17337-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently we insist on using 'sphinx-build' from the $PATH;
allow the user to specify the binary to use. This will be
more useful as we become pickier about the capabilities
we require (eg needing a Python 3 sphinx-build).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 configure | 10 +++++++++-
 Makefile  |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 115dc38085f..0aceb8e50db 100755
--- a/configure
+++ b/configure
@@ -584,6 +584,7 @@ query_pkg_config() {
 }
 pkg_config=query_pkg_config
 sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
+sphinx_build=sphinx-build
 
 # If the user hasn't specified ARFLAGS, default to 'rv', just as make does.
 ARFLAGS="${ARFLAGS-rv}"
@@ -975,6 +976,8 @@ for opt do
   ;;
   --python=*) python="$optarg"
   ;;
+  --sphinx-build=*) sphinx_build="$optarg"
+  ;;
   --gcov=*) gcov_tool="$optarg"
   ;;
   --smbd=*) smbd="$optarg"
@@ -1677,6 +1680,7 @@ Advanced options (experts only):
   --make=MAKE              use specified make [$make]
   --install=INSTALL        use specified install [$install]
   --python=PYTHON          use specified python [$python]
+  --sphinx-build=SPHINX    use specified sphinx-build [$sphinx_build]
   --smbd=SMBD              use specified smbd [$smbd]
   --with-git=GIT           use specified git [$git]
   --static                 enable static build [$static]
@@ -4799,7 +4803,7 @@ has_sphinx_build() {
     # sphinx-build doesn't exist at all or if it is too old.
     mkdir -p "$TMPDIR1/sphinx"
     touch "$TMPDIR1/sphinx/index.rst"
-    sphinx-build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
+    $sphinx_build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
 }
 
 # Check if tools are available to build documentation.
@@ -6474,6 +6478,9 @@ echo "QEMU_LDFLAGS      $QEMU_LDFLAGS"
 echo "make              $make"
 echo "install           $install"
 echo "python            $python ($python_version)"
+if test "$docs" != "no"; then
+    echo "sphinx-build      $sphinx_build"
+fi
 echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
 if test "$slirp" != "no" ; then
     echo "smbd              $smbd"
@@ -7503,6 +7510,7 @@ echo "INSTALL_DATA=$install -c -m 0644" >> $config_host_mak
 echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
 echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
+echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=$iasl" >> $config_host_mak
diff --git a/Makefile b/Makefile
index 461d40bea6c..20bf0cc771a 100644
--- a/Makefile
+++ b/Makefile
@@ -1024,7 +1024,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
 # Note the use of different doctree for each (manual, builder) tuple;
 # this works around Sphinx not handling parallel invocation on
 # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
-build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
+build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" $(SPHINX_BUILD) $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
               $(wildcard $(SRC_PATH)/docs/$1/*.rst.inc) \
-- 
2.20.1


