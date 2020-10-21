Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB09C5517A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 05:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAABB20936
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 05:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NnrzgUgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAABB20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV6Ff-0002Yw-Rc
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 01:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66Y-0000bB-8a
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:06 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66V-0005jC-Jf
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:05 -0400
Received: by mail-pg1-x543.google.com with SMTP id n9so729819pgt.8
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 21:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uN9ozTRkXRLbdO9UnXnEYOQQpsYxGDATtPNPp1/R6rI=;
 b=NnrzgUgb8vmZVOOppFrxjfS+FEOu1enFJ15bBOtcw5qh34QV69FefGoY054PgGJH98
 0/o0qJpgoT3gXP21FBAYXnpQ1ea4h8Nm8cpONz6tnlboYBRSfWzpbbV9STgh6mxC/pPB
 Y4rpfPKvdeUUzFbKjvyqrYTdWWD7uQMn14QN058R09wZ2hVgfQ6tDjfnBMQY9z3oWqFV
 uVxyRKu0MXGFJC9SPLaKXu9UCEUWgEHo+Egm/ZccUnH015p3nVRR32GmAQKOmk5WzfpD
 qPn9ZGK98k4OIXf6c6/U9NLZo0ejCidQSL4S+R5aL3pH+ZOsLgFzCS8MaojuybhBHTNM
 p1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uN9ozTRkXRLbdO9UnXnEYOQQpsYxGDATtPNPp1/R6rI=;
 b=gnJSfcSstCRaBBSwMgKUABwA1OTOkixtg8iU8X4f725I9mFgxDjsye36u5YfEUbDtl
 acfK8DYzIZytEI/Xv+wIZ5wPDUTB883oUKtR/qKhm/stXtadmDMEjkNedLJQ8OWoHncj
 QRRrdlV5QdsqynUrPNFOFwY801GdNd9v19ebxb1jTaDHKfiVEuNJG8CnYcBqRTgGpQC9
 BpytZ90U82n1KFgQD5DZl1lY7TUUtu9uT84xHFH+5N/TGXEV6GXPDUYbfEf1LxeETYhg
 lPPU9NKT4fqOp+ze2k1EgSxyQL4DqDaEJZuNa90ZnOuGFISdayQNug9ekWgrlZSluXKn
 A2IQ==
X-Gm-Message-State: AOAM533RaurGWuXTbeXJ49RYp9vOkRnbnXG7mXO5EV22WFDPMpgjfeS/
 qRZyVRRa7T6Hsbd6TC0Sh5zqjqXCoN9FtA==
X-Google-Smtp-Source: ABdhPJyib66YxomdLwAsHQRR1YMuksUchH6P6Z5Q8mTAUksnzpRnlbUgDIIg8x24lUoM6zrY+Wf88Q==
X-Received: by 2002:a62:1d52:0:b029:152:3cf6:e2a8 with SMTP id
 d79-20020a621d520000b02901523cf6e2a8mr1518957pfd.46.1603255922022; 
 Tue, 20 Oct 2020 21:52:02 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm620070pfh.143.2020.10.20.21.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 21:52:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 08/15] softfloat: Tidy a * b + inf return
Date: Tue, 20 Oct 2020 21:51:42 -0700
Message-Id: <20201021045149.1582203-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021045149.1582203-1-richard.henderson@linaro.org>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No reason to set values in 'a', when we already
have float_class_inf in 'c', and can flip that sign.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 67cfa0fd82..9db55d2b11 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1380,9 +1380,8 @@ static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
             s->float_exception_flags |= float_flag_invalid;
             return parts_default_nan(s);
         } else {
-            a.cls = float_class_inf;
-            a.sign = c.sign ^ sign_flip;
-            return a;
+            c.sign ^= sign_flip;
+            return c;
         }
     }
 
-- 
2.25.1


