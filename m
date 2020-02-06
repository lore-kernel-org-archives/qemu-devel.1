Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D93C352A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E60D20659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nUwyO0VS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E60D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlDn-0005n4-DO
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izl06-0006oa-Bt
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izl05-0006oP-Bo
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:38 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izl03-0006Rl-DW
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:35 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so908314wmb.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l4qwnnNC9N66e0pcxFV0qqg5LdHM/vrVq/qnQK+MWZg=;
 b=nUwyO0VSxMPmn82rGODiQTG7gI6JE3jJJ5Y2EWw0Z2e+XMdE9/iTKdhZM05J5EkWJS
 C6GbcrUlfIpShV46fGms0C487ETRrr0iwNhRyHzHAcwkxP9WTa+iCNigKjTFIdCCGLV3
 YBxpkTJtVSoV+FwHS4eaVVbRJcD+d7Uf7YGT0CONqCB/ia/SXXjIPwkiWhDtiDKECDxc
 y1h4+wlbVcclxY3FhPCLgGi/EiSLZkO+sA9Ke6w1xPSaveOSnJaC1uO6GBySuYbHNR+V
 gIfH5rIiGD9uDYPOYVxHD60cAyPsvQX1Srn2xJEeGGoqNueSk3EtsoSUjpr0puf8MOvH
 dFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l4qwnnNC9N66e0pcxFV0qqg5LdHM/vrVq/qnQK+MWZg=;
 b=iKQT3fZh7mV12FsdgEYAo6DXKWROnezMfr1wEghowmCmitM7E69N1atBCdVIWgJRmQ
 +1pqoB5jpoiMo+LIf8Q8jihowMk3WDAWii+G2IyWKs8uYajmHpWsF8MyD7JaprwhHDbb
 apkf4LoOC1ZEXgrOcYIf5AwrvlBfWYJQsv0zKpZi/XGT1wSjRP65q8LhVGdN3YMvyx/k
 74WaV2RiW8+MN1P5FG/sD9BGZ9gxall5JFCZWvymsbMiOx2gqa2RlatbPn/Luhn99L+6
 pOxWGXucpWGYgrE093xiLLIjuc8PCKlI5nQc3ZP3lJ/CwnnsJe1jt1RDW++66WxBQ9d7
 fLNA==
X-Gm-Message-State: APjAAAXLV1y+6oAnsgvZWCSAHKrKDg6Dkv1aW0/WhPz7PAbCQzLtHHJ7
 YeUL9hyLK70V7ZJ24xF0atPO6y4L8uI=
X-Google-Smtp-Source: APXvYqw7iFK595WeNQPs8cwLtVkVvByr+GY+aho5KJAN2SRLHNRpkLXXRoAC4IySnSl0l5tww+ajqg==
X-Received: by 2002:a1c:e007:: with SMTP id x7mr5589690wmg.3.1581010290350;
 Thu, 06 Feb 2020 09:31:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/29] qapi/machine.json: Escape a literal '*' in doc comment
Date: Thu,  6 Feb 2020 17:30:31 +0000
Message-Id: <20200206173040.17337-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

For rST, '*' is a kind of inline markup (for emphasis), so
"*-softmmu" is a syntax error because of the missing closing '*'.
Escape the '*' with a '\'.

The texinfo document generator will leave the '\' in the
output, which is not ideal, but that generator is going to
go away in a subsequent commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/machine.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 51ffa96be98..a83a7b56b14 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -12,7 +12,7 @@
 #
 # The comprehensive enumeration of QEMU system emulation ("softmmu")
 # targets. Run "./configure --help" in the project root directory, and
-# look for the *-softmmu targets near the "--target-list" option. The
+# look for the \*-softmmu targets near the "--target-list" option. The
 # individual target constants are not documented here, for the time
 # being.
 #
-- 
2.20.1


