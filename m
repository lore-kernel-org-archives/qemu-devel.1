Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCE0C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C6A217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVO+IU7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C6A217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Ikx-00021k-9a
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 12:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2IjP-0008W9-N7
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2IjO-0002IX-1z
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:56:55 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:46094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2IjN-0002GO-Q1
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:56:53 -0500
Received: by mail-wr1-x435.google.com with SMTP id z7so7788253wrl.13
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bNrhvkUv2TO4FrpIdTAVSOaQ1Nd3Ip9jUXQiwdMHf3E=;
 b=MVO+IU7TLrNzOQMOBVXUYyAYHNCX0Raac3P92MIQ0SK+N+6uFx2mYQsFYkTxRTbdXL
 IQ20OlkDIoZbE1GBCTcw3xddGo2D6nigt34rk0B0610Rs2nTkY8ZUHWu2+EA9es0mezb
 CSQOEBHyv9EzkTDWqTKwsFECHFLf3R+VbDQ/k7x0gQGqEaB8QI687jn0pbq8nNANQdgo
 TWJA7RUT0V4pxgNg0WjJF+ee7zon+nhlJku9O7dzXxnHzVnxDaELd//IR/uMgrLdy3t7
 u6GuNignHSol4M3dUuFTgO7+knsAXkJLc+kL+4aoHSrA5zId701u05i/MGTM6LF/YxOe
 xyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bNrhvkUv2TO4FrpIdTAVSOaQ1Nd3Ip9jUXQiwdMHf3E=;
 b=pvhukesc9Ea0bNNheovexnCtVPW6xHVXq/QF1z6ocrYICDrX7oMr3SaW08tCoXzdTy
 hxFErw5BDfPWT8iOvNmU7KDzXzWKONTx9K7DxbTCk9LrrjKUH9tL6BzElBBKoKNAdDEo
 mYcbLgl7AXJtDyUQIjQANglTj762Lzml5A/0thhUJoSMc2CmlMIFho/XjPwnlFHS46Vg
 fAhiW5tfP2jR81A6AIJjpkiw6ZwGodfLmx8qbKCoh+DwYeVzrzMweAbHji62qsin5sXo
 GryPbo3iR6QqdFpp5E5oDdQlYgZcqglDGy3tnSgNO114iPt1JO2TFEtWcQVHdOKFtUph
 YmPw==
X-Gm-Message-State: APjAAAXj7eKCB49Gjgo8oKbYQrIyXvFNAn3F25v5OiwCU3idcNZezqf4
 rMCC9O581Cbh1VO/9wrcwUe4wcdkOtg=
X-Google-Smtp-Source: APXvYqywKPn91NGIhyfCtdzGY7rOfxc3X75BgpjEC8sKIXamZVXJk1+/U8iWFTJFe7KXYcviDv/ICQ==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr22530913wrp.321.1581616612367; 
 Thu, 13 Feb 2020 09:56:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:56:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/30] configure: Allow user to specify sphinx-build binary
Date: Thu, 13 Feb 2020 17:56:18 +0000
Message-Id: <20200213175647.17628-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index f0e1a2fc1dc..430bbad0557 100644
--- a/Makefile
+++ b/Makefile
@@ -1030,7 +1030,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
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


