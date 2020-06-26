Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E175C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE98F206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7qHoavy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE98F206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jougZ-0005gb-4y
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 16:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jouff-0004MH-P0
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:09:59 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joufe-000443-5Q
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:09:59 -0400
Received: by mail-pf1-x442.google.com with SMTP id b16so5060093pfi.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SW802rsBjyjH3nSM8zwvWR8Kt24bL/tDHyeHn/2Y6L4=;
 b=N7qHoavy76cIFRRnP7H8p2TP83RVrVKT4yO7yN3Hg85MvuXYyNU91RAGg4g6RJMjUq
 9UiS/9BG5IO2nfY4OA6Gq+5Gc9667D1p+DCxWjtCBD6Bc59Q5r+G1JU1SRjJiyZ95TW0
 HWgIRYzhpCchKvuT/69134fepgDiQSsf8I7XkePCga8MJAMtSf/TWY5fknSG7hM1m71Q
 Q+4PaBB6ZiWSDCBZZCeBz2/L4Axzv2pixXMqkLxyVoXbiH6WE56ZM7Ihfru49fCrIhOa
 1XWhH5enJkSd9NoW/AZuhQLg5TDJnNN2SvDK5k7tfsIip4+Dhd1z/wK0dGCFZQDJUzWE
 7TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SW802rsBjyjH3nSM8zwvWR8Kt24bL/tDHyeHn/2Y6L4=;
 b=Mk/2Q2Nm6oS5bQBwQAvxxJyg2LGXMBMkUHjaRbP29h9DiQs/wcaUTp9fFweI2r+k45
 vMmyHHrulbif0LBpzLoznQmOJiCU/jJmhTGB+NzL6b6THTRxtxQIEEPNM1ee9uuXLYY3
 Yrl9GQI5CKdh+tOlnQyQzA7ZswIfc3JZrcSjX3WuhzzAwKAWRNfrKDMhWFKE6arkivkR
 ZOHeozVJrmxm3jzevHwTHcEZyJ8MjubVOWhNp/rTSNvjza0U5VEtValXty69YjBOsoGn
 WxbLmW3Q3d/w0PHX8cmf07InbUbasbp7ZMeYr4IecMUEVyQ9N4D+yu7mMP5Fxa44Dz6f
 xGOA==
X-Gm-Message-State: AOAM531cxfLkjzSxJvrlzK5lxOwICR3NO00J9m+7rLtKYwXn49eGG/Go
 +BOCDJSQqsFWjuQycDADzU4jlUTES0k=
X-Google-Smtp-Source: ABdhPJxwx1bqsjUFmUaJMqD7eI0VJ6arOGJwYBAk3Vx3zJmmhqFdqSw4cvnrC+nc8BOiiBF94tMczw==
X-Received: by 2002:aa7:9289:: with SMTP id j9mr4573050pfa.124.1593202196355; 
 Fri, 26 Jun 2020 13:09:56 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id n8sm23879405pgi.18.2020.06.26.13.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 13:09:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] tests/qht-bench: Adjust threshold computation
Date: Fri, 26 Jun 2020 13:09:50 -0700
Message-Id: <20200626200950.1015121-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626200950.1015121-1-richard.henderson@linaro.org>
References: <20200626200950.1015121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: cota@braap.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In 06c4cc3660b3, we split the multiplication in two parts to avoid
a clang warning.  But because double still rounds to 53 bits, this
does not provide additional precision beyond multiplication by
nextafter(0x1p64, 0), the largest representable value smaller
than 2**64.

However, since we have eliminated 1.0, mutiplying by 2**64 produces
a better distribution of input values to the output values.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/qht-bench.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index ad885d89d0..362f03cb03 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -289,11 +289,25 @@ static void pr_params(void)
 
 static void do_threshold(double rate, uint64_t *threshold)
 {
+    /*
+     * For 0 <= rate <= 1, scale to fit in a uint64_t.
+     *
+     * Scale by 2**64, with a special case for 1.0.
+     * The remainder of the possible values are scattered between 0
+     * and 0xfffffffffffff800 (nextafter(0x1p64, 0)).
+     *
+     * Note that we cannot simply scale by UINT64_MAX, because that
+     * value is not representable as an IEEE double value.
+     *
+     * If we scale by the next largest value, nextafter(0x1p64, 0),
+     * then the remainder of the possible values are scattered between
+     * 0 and 0xfffffffffffff000.  Which leaves us with a gap between
+     * the final two inputs that is twice as large as any other.
+     */
     if (rate == 1.0) {
         *threshold = UINT64_MAX;
     } else {
-        *threshold = (rate * 0xffff000000000000ull)
-                   + (rate * 0x0000ffffffffffffull);
+        *threshold = rate * 0x1p64;
     }
 }
 
-- 
2.25.1


