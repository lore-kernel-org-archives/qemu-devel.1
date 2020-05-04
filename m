Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A586C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2571E206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWGBCQgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2571E206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaIX-0001Vw-An
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHd-0008FH-4q
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:17 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:33024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHb-0000j2-7E
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id v8so15468448wma.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lZ2EWhoMVecpL6ZkENj7WznZRxce4vuIoxgEVc92JjU=;
 b=hWGBCQgQZyuVbAXc8gpOr+Jm2q/AGMS9jpW2012linYYKMGqoiSsXzLAlAr5WAcO2q
 9uYbv/lUEV6gZutiJv7bFJKEsKpctDngneIiRKzweZjpLzLmmPqjCDhMq8p2AfobqziX
 QVuRvlAzdCCNWVhWjocZvLJKE4VUkyYINifQHxvX/ibEpcGomgH/EHIcKgOpWm3Vjanm
 Z9RzcaeZse92Q6UMUripf8flq/SofBsEk4wqEueAuHQgjB9doxu+iHW1cLvTZdU+ZYAH
 r9DXCSqqH0XdYSK4JS7rFkr0NuxvF+V10JRMIQyKWxeQoI79KLgmQqf48dKugH/RpNVD
 Qa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lZ2EWhoMVecpL6ZkENj7WznZRxce4vuIoxgEVc92JjU=;
 b=jWAhjQih9FBfkysiwqf0sZO3GntMRn0XHsHksXkVHwwMbHs4Xk1OGNactTKoQa4WhH
 gTT1xmnbSNdpcgZg8a7P7qLxLFJ8EZAlrVyjO4lcX+FnBMI+hujyoknpPTuZr2sJHPBr
 KScd6DSgqJI5Z3F7jYHnDXkOzalxv/gUN2KJSg7rbMX7yw+jxj5R+zMVZdK9B8mwYgZ3
 r8OhNQ0B1RGdZspqD29B51FbJwwDhpjg/cw3znhC0yNGFaqTSe74wzZpJJBoy2fayIhk
 l6YsHUwLG6Y/O644BD4Ktd64jdi7PmBOwBjRmG9HprAkN0QIpEKjsUziDucUP39KdnjY
 wgIw==
X-Gm-Message-State: AGi0PuYE5kiKq9gb7zWZEgMJkhfsxd7VS77j01qDQwdsGjw+UkJ6YBw6
 0Txe4IpVv1HOGWK8fRose7L9uOAab0htAQ==
X-Google-Smtp-Source: APiQypKeNVlAVtCQGP17Lm/ILxW/xRuKoFImitVUWo+VxVqzqbwUJYiRNDCNkVJ0QKQsCUqOAIGXew==
X-Received: by 2002:a1c:5448:: with SMTP id p8mr13988660wmi.173.1588595593432; 
 Mon, 04 May 2020 05:33:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/39] target/arm: Make VQDMULL undefined when U=1
Date: Mon,  4 May 2020 13:32:31 +0100
Message-Id: <20200504123309.3808-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

From: Fredrik Strupe <fredrik@strupe.net>

According to Arm ARM, VQDMULL is only valid when U=0, while having
U=1 is unallocated.

Signed-off-by: Fredrik Strupe <fredrik@strupe.net>
Fixes: 695272dcb976 ("target-arm: Handle UNDEF cases for Neon 3-regs-different-widths")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d4ad2028f12..e3fc7924428 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6016,7 +6016,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     {0, 0, 0, 0}, /* VMLSL */
                     {0, 0, 0, 9}, /* VQDMLSL */
                     {0, 0, 0, 0}, /* Integer VMULL */
-                    {0, 0, 0, 1}, /* VQDMULL */
+                    {0, 0, 0, 9}, /* VQDMULL */
                     {0, 0, 0, 0xa}, /* Polynomial VMULL */
                     {0, 0, 0, 7}, /* Reserved: always UNDEF */
                 };
-- 
2.20.1


