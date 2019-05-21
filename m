Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD5AC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BCB2217D7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woYXkPI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCB2217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52679 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT3rm-0002Yz-Bc
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:27:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3py-0001P4-3i
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3pw-0005Fr-Tm
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:40122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT3pw-00055e-M6
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id 15so2679193wmg.5
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/E+PaSgrUlg3SFZHIuAu/lXW6yDb2qBLwoSSs8XJ8AE=;
	b=woYXkPI33taUXzNCellJQiMx4dJlvYOHYHquJieBhU0SL6NDBJHRELujQpegBSR5P6
	2vjq5ZnHbtyYWTbYtfOJ9t2jrQWrN9PaqMzxDMeCqkGznCsgybv7gmOG478DTDBIKrpj
	DJGh41W2kwiOPLhUfG5CVneJNQ/l0T0jwXHvlsXHcOtStQILelU/HHcL7+9n0HWCCr0A
	T5sDarpB3Exsco8HL2s3Vju3xHPsKYKMXDH2/660JwsDiaHhzk16T7iTdnLihOs78zF5
	04aFwTB0B+Gdnv00x4PKGX+leVmsXCdIJVCFvz/J7fLQ6KQxKdPqY1ilb5XgVrdFfaT/
	GgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/E+PaSgrUlg3SFZHIuAu/lXW6yDb2qBLwoSSs8XJ8AE=;
	b=Xqcz4ZTtGrclnJMbi6KFxlAZWHPJtURTvclZriUxrcXLUt8KvdCyBkrURU/XBozfRq
	HnLK5tGbLXKoz8nvE8yDPIp67es3W7nPV9wOYv9I8xTFoajT7HFKXJz3xTUKOEs1ek8x
	ab3OGphkM1LHOJlR8LP787x0kPRTuua6I9hJZiLN85enO2HoxCvuvtykudOjHb9AQSPx
	GaUkyz304qwbnL7LaLzfsRb44CQctukYGLEo7E6h1l2aa6/KDomeD34TloYxb/76sY4C
	O+gMvN8z0cftUWiIFre3+Nf4sGiM59hfeGHa1gCDlHnlmOe56MpLjBgryMEN/N3yK9xY
	bTZw==
X-Gm-Message-State: APjAAAUgH+ZTBcImwi7B8zegjVWK0ek8zj4iDCYZt1e5jZ0T0jxsEEmi
	jgAbllED8yjVFEblUWhXzZo6FTRmkr0=
X-Google-Smtp-Source: APXvYqxO8+EW8HKLAFM03N7tLOE32wY+OeT6QDl2JfVv/zPiDCHnJ9cS5Jv57LIh5U4QEfkSS1/rgA==
X-Received: by 2002:a7b:c301:: with SMTP id k1mr2727972wmj.43.1558441527480;
	Tue, 21 May 2019 05:25:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	u11sm12233393wrn.1.2019.05.21.05.25.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 05:25:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 13:25:12 +0100
Message-Id: <20190521122519.12573-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521122519.12573-1-peter.maydell@linaro.org>
References: <20190521122519.12573-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [RFC 03/10] docs/conf.py: Enable use of kerneldoc
 sphinx extension
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	"Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/conf.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index befbcc6c3e1..9109edbcb97 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -41,8 +41,7 @@ except NameError:
 # add these directories to sys.path here. If the directory is relative to the
 # documentation root, use an absolute path starting from qemu_docdir.
 #
-# sys.path.insert(0, os.path.join(qemu_docdir, "my_subdir"))
-
+sys.path.insert(0, os.path.join(qemu_docdir, "sphinx"))
 
 # -- General configuration ------------------------------------------------
 
@@ -54,7 +53,7 @@ needs_sphinx = '1.3'
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = []
+extensions = ['kerneldoc']
 
 # Add any paths that contain templates here, relative to this directory.
 templates_path = ['_templates']
@@ -213,4 +212,10 @@ texinfo_documents = [
 ]
 
 
+# -- Options for configuring kerneldoc extension  -------------------------
 
+# We use paths starting from qemu_docdir here so that you can run
+# sphinx-build from anywhere and the kerneldoc extension can still
+# find everything.
+kerneldoc_bin = os.path.join(qemu_docdir, '../scripts/kernel-doc')
+kerneldoc_srctree = os.path.join(qemu_docdir, '..')
-- 
2.20.1


