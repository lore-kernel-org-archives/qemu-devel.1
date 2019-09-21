Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396FBC49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04A220C01
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6TlkkmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04A220C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBXE3-0003Bb-17
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 00:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX5K-0003R9-0h
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX5F-0006Xt-42
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:25 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBX5E-0006R7-HU
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:20 -0400
Received: by mail-pl1-x644.google.com with SMTP id t10so4136681plr.8
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 21:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZAz7iFPOWkaueNLTk5914u9zAUBjebd4K9tG0kc56ik=;
 b=W6TlkkmRUo8U+sKO+9O8huqeCjEkeVuFYHPwo1VRE8I61vhfsMZyE81CNh5nXf7SuO
 QSGuWaIm/HZsHpLkX21TygExtQi0MwQo0zTyfw+pfmdq7VsgpIAFXE1PhP/CcqHFt4dG
 yLVRleLCnNdjQecZPR9jSm/T5yinzn2QqpxH62gGckopHa1pvNxyD47xol+buMzBNtfI
 PcvPXOMVHd3UjUFx8UvqoMjigQyJoDhpFjtcZs4vi/rAyHTJE7vTml58eVPzbSzuhKc9
 ssOOTL2ZY3GAKK57+cE2ruwd0fI5RotF+phYxpljhXhtXZzpXrh08UQNGAE1seP3HQLy
 306w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZAz7iFPOWkaueNLTk5914u9zAUBjebd4K9tG0kc56ik=;
 b=XHmrMak2wq8cM3/dlm8NMM/2bm3azqLz65ztcjZuth8NV55jzJYIJM9uRDAdQePn46
 GpqriLMbg3NYvYxFPUUJaUcdkGWX/DVdqr5uPJvN15UBihTSdwqBHjKd7ceU0ICpTK7B
 9AV0+bUxagVYOChHt3hqRV+EiIl9ekffOmuB809rdTR8+6f8n45WJvCjzQ6rM+PFgE5B
 s9HMA3XJIuYYzxukTD4io5O2g8oY9Se9sdkrUA3yKHG3XRam5GLjMVb29/Tg2MUohv6L
 32XZa0b7dRO00XbHz0GN/LI9EZltwS6i2rosxN88QVscljWoonylydFoPEzwlbtO3wqO
 xu4Q==
X-Gm-Message-State: APjAAAXfrdEBTnJzC27hez1b2rWOBCvhX06+4eUvRWLd343OT87P2brQ
 Bi3+f2M3xd6wzRguaIUa5KgrZUOuRNs=
X-Google-Smtp-Source: APXvYqyhXN29OIOLcB/QAYkPoberrx+FTOZNo8vt0tIzRbQunVzmOhO6HjmrrE52MgfsRLTtmgfT6w==
X-Received: by 2002:a17:902:ac98:: with SMTP id
 h24mr21012369plr.64.1569040388609; 
 Fri, 20 Sep 2019 21:33:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 193sm4179986pfc.59.2019.09.20.21.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 21:33:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] target/alpha: Mask IOV exception with INV for user-only
Date: Fri, 20 Sep 2019 21:32:55 -0700
Message-Id: <20190921043256.4575-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190921043256.4575-1-richard.henderson@linaro.org>
References: <20190921043256.4575-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel masks the integer overflow exception with the
software invalid exception mask.  Include IOV in the set
of exception bits masked by fpcr_exc_enable.

Fixes the new float_convs test.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 1b3479738b..55d7274d94 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -58,6 +58,13 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
      */
     uint32_t soft_fpcr = alpha_ieee_swcr_to_fpcr(env->swcr) >> 32;
     fpcr |= soft_fpcr & (FPCR_STATUS_MASK | FPCR_DNZ);
+
+    /*
+     * The IOV exception is disabled by the kernel with SWCR_TRAP_ENABLE_INV,
+     * which got mapped by alpha_ieee_swcr_to_fpcr to FPCR_INVD.
+     * Add FPCR_IOV to fpcr_exc_enable so that it is handled identically.
+     */
+    t |= CONVERT_BIT(soft_fpcr, FPCR_INVD, FPCR_IOV);
 #endif
 
     t |= CONVERT_BIT(fpcr, FPCR_INED, FPCR_INE);
-- 
2.17.1


