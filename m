Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A929C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88EA23B18
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkdNomWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88EA23B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ym2-0003NE-3F
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6yko-0002Qj-RS
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:09:58 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6ykn-0002a9-88
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:09:58 -0400
Received: by mail-oi1-x241.google.com with SMTP id z22so10962318oid.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QsaGTiUVfWoR7s1tF95X85Ju0+8PUYwEAqh0P+R84cU=;
 b=NkdNomWEJHvOAJWlQ7t+8+TgCmGLRbkeX5ytcxkQFp1uN+rHhK1sZszsWa6sgHuGrF
 l65YGA8PvL9ZUzjy5qlkYXKcN9ANgkfBIjDRQwZYBE7wb7TLNh+b5SBy1+yy7AitQhBl
 JAlnBvArNkVeeXx0yHx0KKXLw0Szd6fHoyun3BfgsA6Pu0w2a8Xq1zJB5E40y7EdPVqW
 hHe5Nl+xE/Zl1Y+x9itwl7NsJrO8e3vLcn+OP8F4DPBkXQ3hyRtjNb29F5BISBjFPUSw
 Aj9HHyK2LTUNO+gufx7TnUl17fQXo8OXK//N0ELWrQZ93ws+3vTY6m4T6UbAZoIh35Rp
 u5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QsaGTiUVfWoR7s1tF95X85Ju0+8PUYwEAqh0P+R84cU=;
 b=gMBCpn+AV9UD/nWjd6URJfAX5/Wq8C37s8AzremIZfOPyCJyIkSqncdIsPhgZRlE3W
 k/4UnWWyXhywVgxjapLVR6Do1pbLOGN2hB68Ns46LgI2HmOMvAWcvMWtZZIcGHamyjQC
 24nkp2GHSCKguFf8tkz3X9u/mf66jKzmEzf53uaRiBsAY065RvOCF2O4lHwzDe/gMw3E
 0MYXg4oo8pFgvECTDZqy09q73al6ALg8937LwVqJ/0YMe39wdZXj27HPtggjIXLcCsJ6
 MCWqnXPlNsctQb9xFq1Oe6cvyz3QvHhFAV5X8Nj4uJSHnTa6NiXBud44HPMyusQ1ajQ0
 HxOw==
X-Gm-Message-State: AOAM531jPPLVngvDrh/zocueFhVQCqEzDMzO3Yno1z57mvwDDgSy5KlO
 l0Mh/k/TSDDPSJ6wifv+2TGQTTr7z9EkvA==
X-Google-Smtp-Source: ABdhPJzRPdTN9vsm87FUmimSsvSIUAvaQ3ar4GHoJbpkzffMBqdinqivzHZY47PaDkHLICfSsLJ/rA==
X-Received: by 2002:a17:90a:1a42:: with SMTP id 2mr4123152pjl.16.1597455130803; 
 Fri, 14 Aug 2020 18:32:10 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:32:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/20] target/arm: Fix sve_punpk_p vs odd vector lengths
Date: Fri, 14 Aug 2020 18:31:42 -0700
Message-Id: <20200815013145.539409-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wrote too much with punpk1 with vl % 512 != 0.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b8651ae173..c983cd4356 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2104,11 +2104,11 @@ void HELPER(sve_punpk_p)(void *vd, void *vn, uint32_t pred_desc)
             high = oprsz >> 1;
         }
 
-        if ((high & 3) == 0) {
+        if ((oprsz & 7) == 0) {
             uint32_t *n = vn;
             high >>= 2;
 
-            for (i = 0; i < DIV_ROUND_UP(oprsz, 8); i++) {
+            for (i = 0; i < oprsz / 8; i++) {
                 uint64_t nn = n[H4(high + i)];
                 d[i] = expand_bits(nn, 0);
             }
-- 
2.25.1


