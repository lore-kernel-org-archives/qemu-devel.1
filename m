Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C229C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C757720657
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxcvXdNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C757720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56178 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haeSi-0000r9-35
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 06:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38779)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haePc-0006xd-KQ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haePb-00079d-Hw
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:53:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haePb-00078q-Be
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:53:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id c2so12475471wrm.8
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xvppecsZ94muJindcBii3Utpb+nLFsPXwtatLVkaeiQ=;
 b=QxcvXdNhqcQcxT2TQQpjGemQ5SaPFiwbECfLsnqIhVID2VtK3xrLA/NMK9fOX2mu+J
 hAT1Askxu4DQ6cIDvhpiellL7gVw+ior83riMXg9LX1RyBelpIEkcSjdWFFnxxeYKGPA
 u8d55+tYHzuBV6sloVrX43mIl2W6S55Xu/CpG9lECvAzuYjh6L/KlzmkIap1hrnRLt4S
 hlDv76hktS6RVNgHSnU2rdV3T4dToOC6VUCwTsPRiaaD8/C77obJ2dq0O6ZCtWrb/ZSA
 C14LNJqV2nrCZM429FFP01/EgiqMUW433Nbzisk6miRxSqXjTasJHodWZLrHTTQzp3Eu
 b31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xvppecsZ94muJindcBii3Utpb+nLFsPXwtatLVkaeiQ=;
 b=FZzFMk2emxvHc9383ZxsP4NrOWy/k44GoQgmbewoJSd8YgqcLoP16CdtyeJtYK6VEe
 b2CvBHT5y3cpBN6szWp839qgPSr/T+BSSDqpl2WwG9UAvBy0ycW/Wjb2wFL/jTSO14xE
 yYhRMwdfiw4mL5PhwsH2YLCDkDPCC1tnpsWHDVNCLw+ElwzqkDNmIv80zgqbqxvCt3wd
 oeXQcyPvv2gW/fQFwpDBDJJhGeft3xMEBfRUMYakJY4Irf9OjwvzNsjeteqrHIeAJHhv
 BNcqjl/2ZVE2OLa/loLqS8YAc5cc2+yNHNWzItz9e1nBk4Jg2rm6GT4T/sLs54r13WnT
 jWmw==
X-Gm-Message-State: APjAAAUO14Sfth88FzddlGSm66W/Ss13niaVkGCwPlsmSXoVITxW+yt7
 s6dkqRqe44a6iCxV1hmyzaY4BQ==
X-Google-Smtp-Source: APXvYqzWpPfvpT/LkToSPgdEteTOubeacyq+P+20S4ETdpB3r1SQbydOjQ5EQyD66PE0tzwf45IiXA==
X-Received: by 2002:adf:9dcc:: with SMTP id q12mr24217933wre.93.1560250434374; 
 Tue, 11 Jun 2019 03:53:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.53.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:53:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:10 +0100
Message-Id: <20190611105351.9871-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2 01/42] decodetree: Fix comparison of Field
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Typo comparing the sign of the field, twice, instead of also comparing
the mask of the field (which itself encodes both position and length).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190604154225.26992-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/decodetree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 81874e22cc7..d7a59d63ac3 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -184,7 +184,7 @@ class Field:
         return '{0}(insn, {1}, {2})'.format(extr, self.pos, self.len)
 
     def __eq__(self, other):
-        return self.sign == other.sign and self.sign == other.sign
+        return self.sign == other.sign and self.mask == other.mask
 
     def __ne__(self, other):
         return not self.__eq__(other)
-- 
2.20.1


