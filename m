Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0244FC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C081B20776
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNnlXawQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C081B20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIucJ-00065F-Pr
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jIub2-0004P5-MD
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jIub1-00019X-CF
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:56 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:42090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jIub1-00017M-6G
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:55 -0400
Received: by mail-wr1-x431.google.com with SMTP id h15so21634380wrx.9
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8Wj6cmPD0bD0MBYEZwMRUoxGz/ny5iBWvlp9JF8e2Ro=;
 b=tNnlXawQLbjcI51+4CWmIFK6SnKx4Kz/PwHCv1ccMmgbiMNZweaWpdaBhl/AK+2IdW
 lb3xupZd4I52NEvapfp+SkMJORhpt8a1jeNS5Zj453nyw9kSeIS/Usdqr9X5cwd7FS7X
 +XL6bkEt69w5urgGYLgyoaKdHIP7fbaFmCTATUZ9Wn5XhvHMRFvb0rhwQAw0Y7LZcS1I
 cRqb7v+WxgCvD7I4fh8JzlFQa90rP1lGfB2TmFM84MHujcN4+2CH1i9HrBtoEEi8fjeK
 VjzJwh9DwjBQjdQ8tWhmoo9aXEmOX2ZgZ+kTjuyJPePcqBc+nCqjJc7uPu8xbnLuhVN7
 Q1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8Wj6cmPD0bD0MBYEZwMRUoxGz/ny5iBWvlp9JF8e2Ro=;
 b=OoROX+4abKEUb+IE0bWZrLxPQZqbQAxAef7YIVAsYpsqtq7ZXevSQ6F3OUbFNyMzyy
 Rl2bhMjIx1BWMJBv2Fxc2knILXgD8U9OU5URzPEm305WsZIt1gxMfDvzyGXG3eAtXqRJ
 01W5AOOIz/v8h2VmKHcOOYMmPrCh4XAO0Y7aXBovQ1/7FtggWU6FpoA/cS0EcSnTV6gp
 pNQWfbJS7asps/coqRwlT+uwYRpJw53CBjkEBq+4JAzzA2hDr7TdBeJye/Y1Ij+y/pZs
 Ilav1KswT1AopRgxI6LldwhZJu1+xdLs+pUBtiv8ZcCo/zwbpwItzjC2IXBlbfnFB18a
 w/lA==
X-Gm-Message-State: ANhLgQ1u7oi+ltRwAbH/IHBI2eJQYPwyTTUt+z0D1aWlgFoscJfwwNNc
 iz8qL/SceyAWGiwh1knZjrMatVT/aGnYow==
X-Google-Smtp-Source: ADFU+vsDW0uMapJpkdBFIctmCGWTqo9B3c4AiazDAXYWGlJE0Cm4QeK/P1cBpOGdUs/qOsQ5/u6UDQ==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr14658575wrq.62.1585575413812; 
 Mon, 30 Mar 2020 06:36:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o14sm20756504wmh.22.2020.03.30.06.36.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 06:36:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] docs/conf.py: Raise ConfigError for bad Sphinx Python
 version
Date: Mon, 30 Mar 2020 14:36:45 +0100
Message-Id: <20200330133648.22297-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330133648.22297-1-peter.maydell@linaro.org>
References: <20200330133648.22297-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

Raise ConfigError rather than VersionRequirementError when we detect
that the Python being used by Sphinx is too old.

Currently the way we flag the Python version problem up to the user
causes Sphinx to print an unnecessary Python stack trace as well as
the information about the problem; in most versions of Sphinx this is
unavoidable.

The upstream Sphinx developers kindly added a feature to allow
conf.py to report errors to the user without the backtrace:
  https://github.com/sphinx-doc/sphinx/commit/be608ca2313fc08eb842f3dc19d0f5d2d8227d08
but the exception type they chose for this was ConfigError.

Switch to ConfigError, which won't make any difference with currently
deployed Sphinx versions, but will be prettier one day when the user
is using a Sphinx version with the new feature.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20200313163616.30674-1-peter.maydell@linaro.org
---
 docs/conf.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index af55f506d5d..7768611e89c 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -29,14 +29,15 @@
 import os
 import sys
 import sphinx
-from sphinx.errors import VersionRequirementError
+from sphinx.errors import ConfigError
 
 # Make Sphinx fail cleanly if using an old Python, rather than obscurely
 # failing because some code in one of our extensions doesn't work there.
-# Unfortunately this doesn't display very neatly (there's an unavoidable
-# Python backtrace) but at least the information gets printed...
+# In newer versions of Sphinx this will display nicely; in older versions
+# Sphinx will also produce a Python backtrace but at least the information
+# gets printed...
 if sys.version_info < (3,5):
-    raise VersionRequirementError(
+    raise ConfigError(
         "QEMU requires a Sphinx that uses Python 3.5 or better\n")
 
 # The per-manual conf.py will set qemu_docdir for a single-manual build;
-- 
2.20.1


