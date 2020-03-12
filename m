Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A49C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1974E20737
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8sxkGwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1974E20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMIo-0000Au-7P
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 07:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMGC-0003bU-O5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMGB-00024M-Nl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:20 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCMGB-00023r-I8
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:19 -0400
Received: by mail-wm1-x336.google.com with SMTP id a132so5755253wme.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 04:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kIrs/GOk+WKpm4yG/696Rd9JAkkZId6KrwVFZGgBAtM=;
 b=y8sxkGwiO2ZnG1jCr02BqlZROxL9XJibObQQYvCFvfzEevNj0HOeWm6GH0pWlfo1Ze
 tRd8lU3OGr4eMFtkk1M+J9BWqPmUMxOVhpmdr6ZNS2BHvotx4OhX9dr7pLZs+eDGR0ju
 kTXiVKcpVvWufyqAIMbp0J9eh59kYwSbehCLSiKJwcwiwJ7J+7YtrMFSgiEhq5soD6lk
 DHKjJRNnwSRtOO5OQY9XO+UcIcqXD4k152SeiTcYVZvH5AT15piTEiqivnmFBhjpaZME
 arbYBPErAW4c243mbQvQmR4jxmJJZgD/As5ebrJ8i1rt8mgqRbUf5sMK6cMtPR8FhhAp
 kS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kIrs/GOk+WKpm4yG/696Rd9JAkkZId6KrwVFZGgBAtM=;
 b=SPSxX43ZuSMB6AIwI5camHr4y4BfV0e4uxDrVHAFOKA1wAp/xfPhIyfg1cDfoMna6W
 evQYzLEXvo+fTNCiAzodhnRsAlpm0Xsc2LPXO+lQUg7K3BPvxdqrCyDGY8MVpzItYFF8
 csNrrPs+R3ftLJ6E+YgORd2khbTcLWWEcoFXwrh7XWPvMYCeJYbqG5hYfCTiFEthJFNU
 urdQ6xvrM5u4n6ecomSg6xPw9ntQ8K6KWWAQamtqo1TzjzVrnqVqdx88uuRaeyNb34OC
 Ywo0ER5thRowM32BYkBpAUhVVz9qMlsK1e3Qrk1GZeDXY7+djwh79UR81b4ODjy7vo9u
 cgmQ==
X-Gm-Message-State: ANhLgQ2UHdj7AjkyhrwaMVK6sV/QhfZ3v0H/9cDBuYtyKqiqVTWGOifl
 UKgLuAb+vCrJKGpN5B+WesJ8o86K0SiWmw==
X-Google-Smtp-Source: ADFU+vukG809PYg0htZPr4b9ZHrlrWMpAdzDgViBNLiyzU8hBjdYf0lEphW23rVyosDOeSo1vcTf1w==
X-Received: by 2002:a05:600c:22d9:: with SMTP id
 25mr4623627wmg.41.1584013458327; 
 Thu, 12 Mar 2020 04:44:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p16sm2688564wmg.22.2020.03.12.04.44.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 04:44:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] docs/qemu-option-trace.rst.inc: Remove redundant comment
Date: Thu, 12 Mar 2020 11:44:03 +0000
Message-Id: <20200312114408.16891-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312114408.16891-1-peter.maydell@linaro.org>
References: <20200312114408.16891-1-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Texinfo version of the tracing options documentation has now
been deleted, so we can remove the now-redundant comment at the top
of the rST version that was reminding us that the two should be
kept in sync.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200306171749.10756-8-peter.maydell@linaro.org
---
 docs/qemu-option-trace.rst.inc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/docs/qemu-option-trace.rst.inc b/docs/qemu-option-trace.rst.inc
index 23cfcb48537..7e09773a9c5 100644
--- a/docs/qemu-option-trace.rst.inc
+++ b/docs/qemu-option-trace.rst.inc
@@ -1,7 +1,3 @@
-..
-  The contents of this file must be kept in sync with qemu-option-trace.texi
-  until all the users of the texi file have been converted to rst and
-  the texi file can be removed.
 
 Specify tracing options.
 
-- 
2.20.1


