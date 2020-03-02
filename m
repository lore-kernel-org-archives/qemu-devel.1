Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9989C3F2D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D4A21D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vPXh7Anc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D4A21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pNw-0003j9-Sb
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pL3-0006oq-Ly
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pL1-0007cq-La
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:44 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8pL1-0007cU-Ga
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:43 -0500
Received: by mail-pf1-x441.google.com with SMTP id l184so80819pfl.7
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gv99y10Tw9XL58AqjJTwfCMl/voN1k409rbwq+MWA5w=;
 b=vPXh7AncUP+qc6FKFOOg3QTRlXQp5E8M6BNaOrA4SyMqan7IpVsh983mYcn0jU5e0B
 wjaqjkgSO6EuIE6o3U9h3Pn2yiIByI4Zi+2dwTL4w7I0vJtvJJ4+NNhysmJBOJ4jwuU3
 7vgw+1BfT0iN2b0iu2ZVGtuGAv2B4jKJfP3RsyDOZFBUjcLPvMPapKjbG3w18uhsGsNB
 ZVHGGnPGqlHfhZx3ORTqwMyxc5x3HKTXtmv8ZscPkGzL2TfEl9NHfNZEuavC/3UO4F68
 52A4wOGEXa9mLjRSsqDlQKiopwcBr8C4xcOFifgy0+4olCzVb3B1tBrzOUhcwRsXq6R4
 Q9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gv99y10Tw9XL58AqjJTwfCMl/voN1k409rbwq+MWA5w=;
 b=UW9eL2Esb8cfZkJIBn3sUlXggQ3FgNlVrKtZt3MrnevsUUaR0/q2rni6/AwLo3HPxe
 S6Cin4IB+Aaa0Q+DTljCo03/pjo4URc6tss9pFcz7fALkPKm+51rj8+NKX+HiZCqO291
 PUav/yWUPSARrr/MTC7sLgN8jgDwN7Q4fVWYRcFj3VRmtQuMuSVmMAmgmrXcX40ph6XT
 7PLOGmef2tTgCpQojfPei39PDbXPVIfGlAWuclaFeTwNQ8bx+nb7B/Y7a9dfdBuFzADz
 0p30Tc0CxcNzXJ1xHiaimGs+4RIKlO9CVPBxZtq5l4YTrNr1pp1x8bk0o2jXKw0NjbYC
 Dc+Q==
X-Gm-Message-State: ANhLgQ0jrfgwOzs88nckA3a3CjJOhl4NI7PuQlDQAAq/9ss51L0rWrix
 p1zs5PPWp3q/wkjzYtYczcXBj5fqMFU=
X-Google-Smtp-Source: ADFU+vuouO0WKGbJ+JJfaW15w08/tNX/qLJLt3Ruw103x6u5aUX5XvPrBB338CbhUgDLq4nVxDjZ3Q==
X-Received: by 2002:a63:385e:: with SMTP id h30mr109747pgn.230.1583171922325; 
 Mon, 02 Mar 2020 09:58:42 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id s18sm99510pjp.24.2020.03.02.09.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 09:58:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 9/9] target/arm: Disable clean_data_tbi for system mode
Date: Mon,  2 Mar 2020 09:58:29 -0800
Message-Id: <20200302175829.2183-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302175829.2183-1-richard.henderson@linaro.org>
References: <20200302175829.2183-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We must include the tag in the FAR_ELx register when raising
an addressing exception.  Which means that we should not clear
out the tag during translation.

We cannot at present comply with this for user mode, so we
retain the clean_data_tbi function for the moment, though it
no longer does what it says on the tin for system mode.  This
function is to be replaced with MTE, so don't worry about the
slight misnaming.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fefe8af7f5..8fffb52203 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -228,7 +228,18 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
 static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
 {
     TCGv_i64 clean = new_tmp_a64(s);
+    /*
+     * In order to get the correct value in the FAR_ELx register,
+     * we must present the memory subsystem with the "dirty" address
+     * including the TBI.  In system mode we can make this work via
+     * the TLB, dropping the TBI during translation.  But for user-only
+     * mode we don't have that option, and must remove the top byte now.
+     */
+#ifdef CONFIG_USER_ONLY
     gen_top_byte_ignore(s, clean, addr, s->tbid);
+#else
+    tcg_gen_mov_i64(clean, addr);
+#endif
     return clean;
 }
 
-- 
2.20.1


