Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223C4C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E8F206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8LGnh84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E8F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2gzw-0000dU-33
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 14:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2gvN-00037Y-0r
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2gvM-0003jT-1N
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:52 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36556)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2gvL-0003hr-SR
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:51 -0500
Received: by mail-pf1-x443.google.com with SMTP id 185so5369074pfv.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 11:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i9ICx5m4aSdGj4L1nDxzhVPY7OzLfpXf253QffS8JKA=;
 b=K8LGnh84Nrrd3nE298GCfMR7/6BL24/VIp8w9aPH9mR54ArbMql3BGbqShY8hNjdCY
 ZwPold/9ESpz9ACocA8pwtBe/+DpQ0R2iDc3yLlBidS+++0WNM/NUW+UFW+7xuvtp+4I
 rYt2gCDOkLgr7oB/gni0wkskQBbIVuqI01OvnKPehAOAEnKjZiNv9PzDqNdwjWMh7eML
 Sv/vsO8RucydO1QXf7WDY6mQXXAZxLriZT0aSqf63vUdIIlUaW5YsevK+KRKGB+ACvvN
 yl2SwHtChrEi2iltQzi/HaPQ10bAApuK9fVFHIugVPDjMKDSyRsF6S08GacRkfQyo7jE
 BdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i9ICx5m4aSdGj4L1nDxzhVPY7OzLfpXf253QffS8JKA=;
 b=BrCUqvx42boK6AHE13DOzBs20y+r8UhLuz67iTOp1glEsGQA8co/Eza3TiPoEQezlx
 wXC27n532H+lHqaVGp1vbW4iITksRdbTVdterO8pik+sXXvRE1jPGMZ8Z8ZpRtUz/NN9
 98PY5ogcAlzes9fFMRGzjKNaxaEU8htojUpGq1vWLJx2dKp69FIFbZSNLqzAZ93euRGe
 lpbFE+31sF88yUjRNiob5mcZ8XCKHmniSry0cPAAhn1FkDR56rzdZUV9ecIPUR9qJgnq
 MhRDHhSVLItLMXg4Mt7CQ5Aann1juayfGYSFSmogR+rhSvMsNW5kqzaWvRlh9IvgBDXx
 9RWA==
X-Gm-Message-State: APjAAAW0FE5IP9tcl1ImT3uPkDnGeMkyVqYDAUV9waITUXRQtLprAVV+
 XUPOr9jqh8Z0U+v1llOCTK+QIIYCE6M=
X-Google-Smtp-Source: APXvYqzJJRcmIeYlJ1UsjYDZFzcnh1yoQwNU6q2FDjvSfC39dpubmI0xdsg3DSLi2Egldkr0WJjKxQ==
X-Received: by 2002:a63:b047:: with SMTP id z7mr5172631pgo.431.1581709610587; 
 Fri, 14 Feb 2020 11:46:50 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g13sm7558851pfo.169.2020.02.14.11.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 11:46:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] target/arm: Flush high bits of sve register after AdvSIMD
 INS
Date: Fri, 14 Feb 2020 11:46:43 -0800
Message-Id: <20200214194643.23317-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214194643.23317-1-richard.henderson@linaro.org>
References: <20200214194643.23317-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

Writes to AdvSIMD registers flush the bits above 128.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b83d09dbcd..bd68588a71 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7412,6 +7412,9 @@ static void handle_simd_inse(DisasContext *s, int rd, int rn,
     write_vec_element(s, tmp, rd, dst_index, size);
 
     tcg_temp_free_i64(tmp);
+
+    /* INS is considered a 128-bit write for SVE. */
+    clear_vec_high(s, true, rd);
 }
 
 
@@ -7441,6 +7444,9 @@ static void handle_simd_insg(DisasContext *s, int rd, int rn, int imm5)
 
     idx = extract32(imm5, 1 + size, 4 - size);
     write_vec_element(s, cpu_reg(s, rn), rd, idx, size);
+
+    /* INS is considered a 128-bit write for SVE. */
+    clear_vec_high(s, true, rd);
 }
 
 /*
-- 
2.20.1


