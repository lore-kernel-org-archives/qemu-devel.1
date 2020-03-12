Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9640CC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5612C206E7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/7Qr1rD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5612C206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMMP-0000um-Hw
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 07:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMGE-0003eu-Si
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMGC-000252-MN
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:38150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCMGC-00024R-F3
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:20 -0400
Received: by mail-wm1-x335.google.com with SMTP id h83so2363329wmf.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=m0cla1H6G0wBqhsK9L8mT4+s11Rs4vOjgckaETpe09k=;
 b=c/7Qr1rDqHNjw2CjtQiduELxARnS8C8tp6Yag+UXQw7EvJrtKQ3jIQWWmGqU1E5+aj
 TREp7mnE84Y0Eg5VVVBKfKouCprZ9W3kj1/sQCeziYhgM5BwsMKWFwV5XeVML0LGpakW
 DD3pi1oBPF2kTGL93KxYozO6QOO1lK31R71AKHoTr3ivYeaVF22bTQ4pkIhMn7YPfpup
 GRLliNjhmr69QfOcmXTvjg+Lsi0+bNrh8YuI7Mz3huNE0prpULD/OQc3Vo5KBWekQnOE
 gLHsYyEW8cIMBH5ClF2PT8wqzJDiHsDkgrBe2hVWewZG3W0w7QZ6L5WjaJCZYYAav258
 zvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m0cla1H6G0wBqhsK9L8mT4+s11Rs4vOjgckaETpe09k=;
 b=c/qLFJkpesyqP65Rs4q3ceuGQy8m+GcGVtdCGqWvydj0wH077MRZ0We37RkZ+eCXcC
 e/UPhLLSLJEe2j619mJ8HE4ImNy1Ksc+6IqoUMwudwwREigvb6j10Y0AjUcXuc4Y66S9
 xuWDywsdj7GWuNIsAglPQnVIgC+YIbRsYrWutPNHHdxtqHm2NDBmX4KZoArvwWWZ/snT
 f53ctYdwLIpWCiJ+jGe3PSSieK8Ohh7txsllhVBF32TWPyTyn49MzlJmNcd8hhiz8cbf
 7LGC8DQNMaNEGGi+6CI7gOs2PvuwB30JUPc7gy28hzkac0RDfd1dU5Ou6ORbduXCpNPA
 Kotg==
X-Gm-Message-State: ANhLgQ0gEWLudOoG4iDrJcRmp/ZPvSJh2we+RXYybvDKa9CJgPPou/Ha
 euUeSdQil0anZS6v1Rtpi8BCfAnwPPk8CQ==
X-Google-Smtp-Source: ADFU+vtqGVtIjO+IbCrPyNF+Ie8z1jkeC8txFLJ9mcCmZU/Nf1rL++CaLFC82uJBWTLYNzcbXx6iMQ==
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr4272715wmj.157.1584013459185; 
 Thu, 12 Mar 2020 04:44:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p16sm2688564wmg.22.2020.03.12.04.44.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 04:44:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] Makefile: Allow for subdirectories in Sphinx manual
 dependencies
Date: Thu, 12 Mar 2020 11:44:04 +0000
Message-Id: <20200312114408.16891-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312114408.16891-1-peter.maydell@linaro.org>
References: <20200312114408.16891-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

Currently we put 'docs/foo/*.rst' in the Make list of dependencies
for the Sphinx 'foo' manual, which means all the files must be
in the top level of that manual's directory. We'd like to be
able to have subdirectories inside some of the manuals, so add
'docs/foo/*/*.rst' to the dependencies too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200309215818.2021-2-peter.maydell@linaro.org
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 65e89b5095a..7df22fcc5da 100644
--- a/Makefile
+++ b/Makefile
@@ -1078,7 +1078,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
 # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
 build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" $(SPHINX_BUILD) $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
-manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
+manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst $(SRC_PATH)/docs/$1/*/*.rst) \
               $(SRC_PATH)/docs/defs.rst.inc \
               $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py \
               $(SRC_PATH)/docs/sphinx/*.py
-- 
2.20.1


