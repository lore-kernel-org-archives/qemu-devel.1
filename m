Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91477C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6642071C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nXl9ZO2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6642071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMHF-0005EG-Gw
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 07:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMGA-0003Wh-UW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMG9-00023F-TM
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCMG9-00022u-NW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id 11so5737592wmo.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 04:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ltLfBMZsG49hGD8i/lFgQSG60+4ZbaBAO10u35X5v7U=;
 b=nXl9ZO2/NU9Ipw5vX47dYtVkxvhwp3GGVJDfeykzaYQs6fpusUq+/A9bCBWSo5ip+W
 lNK9myjarjl1xhI4tx/SEFj7szMOqO1azuJsTs/VCNNSbketTQFxgfCCbeNW2mkG3O89
 hFzju4Y0BLKjmAf3246Fqcub/pHKZXWmqA8/5/gpqVmstVO1pMKS3drwES5tqgJxzZb5
 MjSknq5W05YWY8gMDLTUN4uOEQdGNMBwntEO214CcCu1PRFqzv/DM14U9BdOyxXL91JB
 RP88B4/4CwYM7kIXsILLnDooK24mmzrtSthPc1CSYxI4LYgr6GGmDHiUUelMk3r79I5Q
 SNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ltLfBMZsG49hGD8i/lFgQSG60+4ZbaBAO10u35X5v7U=;
 b=WogOw3ZmcAIRTFrb8kY5wxilf+jsQA+eG9T75ztwEueje0R7rR5E8vzOiXKHILUe9G
 zs8QRprDScun1dxxNg0Dh3Yl8LdPuVw1ewUGLIWEQSNOfNApGE8P7JRQ6jFkXY85Sz/S
 rFH6Q8BjFQQfvA+RejohNkB08CPIPIxbQQ7LP5hGcxu8ftBaN6jwXFC+Pl1Hv1satA9r
 I2NE/SUwHMq09OPIuClX6KHAavyZZiD7bdrypjta//CdPZ1AOMDh1ktZQSSVIoP2DTk1
 WHo4t7iCojcu6jUZDQxhig0KY8At/G3xo1etgAwQGMSUdcDJNleEamvbFdj7VWH7hrVY
 TMEw==
X-Gm-Message-State: ANhLgQ1Jp91XVdMDSQ4mpHNrOzZkVwXrCQAwItJyCKk37J5imF/O0KgH
 0SK4+XwZeUNMBNMoBxg+0HR+4ykVMEQz6A==
X-Google-Smtp-Source: ADFU+vvnaQlAIUHzpX1LvLmxKHZhKjDiA1Dkl3mNJj3t2RLLDlLsNcRYpqik1qZWoqgxNhHKXx1MDg==
X-Received: by 2002:a7b:c8d5:: with SMTP id f21mr4478630wml.60.1584013456452; 
 Thu, 12 Mar 2020 04:44:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p16sm2688564wmg.22.2020.03.12.04.44.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 04:44:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] Makefile: Make all Sphinx documentation depend on the
 extensions
Date: Thu, 12 Mar 2020 11:44:01 +0000
Message-Id: <20200312114408.16891-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312114408.16891-1-peter.maydell@linaro.org>
References: <20200312114408.16891-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

Add the Python source files of our Sphinx extensions to the
dependencies of the Sphinx manuals, so that if we edit the
extension source code the manuals get rebuilt.

Adding this dependency unconditionally means that we'll rebuild
a manual even if it happens to not use the extension whose
source file was changed, but this is simpler and less error
prone, and it's unlikely that we'll be making frequent changes
to the extensions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200306171749.10756-6-peter.maydell@linaro.org
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index fae4ce181ea..65e89b5095a 100644
--- a/Makefile
+++ b/Makefile
@@ -1080,7 +1080,8 @@ build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" $(SPHINX_BUILD) $(
 # We assume all RST files in the manual's directory are used in it
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
               $(SRC_PATH)/docs/defs.rst.inc \
-              $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
+              $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py \
+              $(SRC_PATH)/docs/sphinx/*.py
 # Macro to write out the rule and dependencies for building manpages
 # Usage: $(call define-manpage-rule,manualname,manpage1 manpage2...[,extradeps])
 # 'extradeps' is optional, and specifies extra files (eg .hx files) that
-- 
2.20.1


