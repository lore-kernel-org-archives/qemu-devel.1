Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89156C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5831820720
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7bBfv30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5831820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshmL-0001cj-HU
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshjJ-000564-G1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:34552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshjH-00046y-Lk
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:25 -0400
Received: by mail-wr1-x42c.google.com with SMTP id f7so40960368wrw.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nRniERkDA/6Hi4fEHIqm7Z1ve7b/ehRoLpBF7hXj1y4=;
 b=W7bBfv30QS5YuvhsI5vWd2Nuyn86nV6VZ2jgWgWG7BA5OwbEU9amvj/s8BFCznBo8r
 ScOjAa9/Xbk0w/3LpKvE07OD6+eajF8WJees7f8+8aEQXa6CPY7QphQoxq7vWdBW+KGd
 Ah7RCunCq0OJDRJR/dSCGAdIbvh6XI2xZFgsrqlOL8eeC1nHVNZ65LyKnrrv1mGJ+TCq
 Ks8vj2L8cnswfUtoLCrSXlj/+875fReZd4eGuEJvtKhubXRQslN9YfAjXq23Jo4RsYWM
 b3KcfSvb3W6JCflA7A4pXt8lNKGPOjkT5QEnTta1LvlzHrnvhemv8cXJ1/1lNuKYU1hb
 mdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nRniERkDA/6Hi4fEHIqm7Z1ve7b/ehRoLpBF7hXj1y4=;
 b=C0GuVVI5BPaVGH8x6b1KHtN7tH8g1r7uM7ytlVaivH/jn/Dnf8XstwoMG0teNYbTGS
 fwUSHCQ4cwiI8rSYhqlv4al2gxsBQb3RYEY2jZ1Mut284ZMkJHbp9wNEKVuFb/s66Zr6
 3Y1CiXvtEXcJ8iEiQ/4H6DYfBEBtyJrflnKxKJIUdfsKbFUtW4C6DiWJebLsrARezsvf
 214o2EV5ZRY1A8HIIoN5akG6WVUnB9S4z68IXLYpeDP8pVU8h1tvJr4ipVQS/tm/uz4v
 hRi+hPKjbu7jMNBOUN0btqcYgAjW9q8A9z5dnWPqYawC9lujafTXIXaMQ0RLbmpibaw+
 lLkg==
X-Gm-Message-State: AOAM532lmIOF7lSSwSqzYAZRw08bhzZqj3Y7qx3Ya6lMBf31rhEeGt/v
 SIjT7X4rFGws0/BX2ter9cYajw==
X-Google-Smtp-Source: ABdhPJwbtjUO0gmSivoEkhz2v7qG7p8ympalBzzl1R0yrwC2cjlaxub4Ld2qXpuvwGdi0UZBi97spw==
X-Received: by 2002:adf:fa81:: with SMTP id h1mr52813021wrr.266.1594105761843; 
 Tue, 07 Jul 2020 00:09:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j4sm22550758wrp.51.2020.07.07.00.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:09:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 87C7D1FFC2;
 Tue,  7 Jul 2020 08:09:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 41/41] tests/qht-bench: Adjust threshold computation
Date: Tue,  7 Jul 2020 08:08:58 +0100
Message-Id: <20200707070858.6622-42-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

In 06c4cc3660b3, we split the multiplication in two parts to avoid
a clang warning.  But because double still rounds to 53 bits, this
does not provide additional precision beyond multiplication by
nextafter(0x1p64, 0), the largest representable value smaller
than 2**64.

However, since we have eliminated 1.0, mutiplying by 2**64 produces
a better distribution of input values to the output values.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200626200950.1015121-3-richard.henderson@linaro.org>

diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index ad885d89d054..362f03cb0370 100644
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
2.20.1


