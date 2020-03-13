Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E756C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267F5206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2mHRIr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267F5206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33915 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCnJL-0003sX-AY
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 12:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCnIM-0002Vy-R8
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCnIL-00028W-Gd
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:36:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:51500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCnIL-00025I-9O
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:36:21 -0400
Received: by mail-wm1-x32a.google.com with SMTP id a132so10703112wme.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PjPArpij9CHiSdkRHfeUwTYaHoGk21oZ1d/rkTCBO/k=;
 b=o2mHRIr3Z9240oZZXcmfkkYVA5+CUvcofcMeIrZGZVXLb9s0vUvvXW9HJsfwpg+psT
 62Y1OS9yjvFkhxmcMxcIGh/CxQbzui0HIEt+OQDrD/pTefoRxVlcrFt/woqmgT1nEdS9
 /5qDnOp95B+XrSa/OMNW8PCerso73ohzKtMWhBGvYIAaj+QUaV65UqcOgQyt9pmJ0W3U
 W7i3CxbCt/p/iiU7rvkzZ2by7iTRphNN5MSaks3lV7CuZ3EjFwKaobErwSStldNbeMar
 omHQqeH7UxoqmhetNYnGC+YHuUhMJ2dX828pemg85GUN9ADKUBhK+abOSFG8IJ2FxEbd
 Wvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PjPArpij9CHiSdkRHfeUwTYaHoGk21oZ1d/rkTCBO/k=;
 b=WXgvMXWXsJXLchXX2s3VrGIlVFqcp/srznG5dlvTUhxvzkl99TfLLGpXCYRVgDdGIw
 MqoVrvqPkWQ/xUf13zaE232khiCDfNZcF4xWEYTMZTWvhbgs2rHVDsZC1iXlj/+51EJZ
 BWECN8LSYXuAYbqBSS6D78qUFHueXsSsk5EZLA1wGC2IefjawgwbSfPRK3vFywkoURzr
 s/DnjXlj2Lys2Us6xagNZHe8VnFe2OuofJpTnsOnxZmmC8B4Z8tPaDGfRV8bJ84viRSm
 g8An8OCc+Yxv52cyNwCOvoNTzm0VwamBxxajq+oprPiDqpsgHJq4T8FLZRc56ev+RMuV
 ebtw==
X-Gm-Message-State: ANhLgQ0C0y3ncwWexmWswHHLVubC/SfevmjFaILaJs0JPA//esAlgs4l
 P6dzR6Im0Spr6DbzzZ7vxrRZfYi5/ytiQg==
X-Google-Smtp-Source: ADFU+vtEVt0uSD0WZl3x20TmVwATojPjuM5PnfaOn2f0vGGRzdN6sOMErW5OlSISYyQPsPbT6WCULg==
X-Received: by 2002:a1c:ac88:: with SMTP id v130mr7755493wme.34.1584117378392; 
 Fri, 13 Mar 2020 09:36:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z19sm18210993wma.41.2020.03.13.09.36.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 09:36:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs/conf.py: Raise ConfigError for bad Sphinx Python version
Date: Fri, 13 Mar 2020 16:36:16 +0000
Message-Id: <20200313163616.30674-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
---
I don't think that commit is in a released Sphinx yet.
---
 docs/conf.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index 960043cb860..87b5f07f589 100644
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


