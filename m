Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D9FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E366D20656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hRWEUNjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E366D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy8IL-0003Yl-6O
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 02:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Ff-00077Z-7k
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:15 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fd-0006v4-MF
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:14 -0400
Received: by mail-wr1-x441.google.com with SMTP id r12so676771wrj.13
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 23:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wrFjogpJXlZ8LOQmtibpdguwXtzA6ik1VNS/5s1gAM8=;
 b=hRWEUNjqFBP8p5+ZNl8s0EYl7uuSwwoO9YMjiG7lWAPH0Tc2v1EMZr0GOmChzGkVNh
 lnCAw6oLFnsEJ3roFRYkzXYYh/jNwKjHg0ZNAiAJPS+Hz+WbkX5uLcbyFKS4zV44nLzi
 DG+6PcsPdAr4l9x4MXyuouAtj6nJ/DXOOFp7bUCm5NGuzEQ6G6xYIkxO7GJ4cLy/3BUv
 fThc2YHKb+u9Bs//8m2QcxwbeEomnhO5DtAA8DBiEVxLjcdasZyBXv8u3191SHFWlxeC
 bmFk8eMKwuSVEXXhVWa6FEXnBkPJVbQTmc++eF6yXoXesYeigr7Tp7xCeuXco9x3vRmw
 pTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wrFjogpJXlZ8LOQmtibpdguwXtzA6ik1VNS/5s1gAM8=;
 b=daYGmU5hRCtl1FTWxA/qk0xNOwR12OVPVLycLylXowyOIFogkbvxqpLAGgaNgFV9mM
 Hs96yPNgLtl++rkQ+MrzkgGGHI97f5KxjaqLkd32LutcaD6fBLpwDXnj1YipXHfzEdHz
 R2VXkv45ndjR6U6hXuw/z0FvveS2e9GRowWxYshwspd4Ti8yLMTD9jnPlxENgsonIDy4
 tEhjDqe1gdC/SELoWOFOMwzcK1zGJPGj8soxOB3iG38648bVBcw53C1W3EwPDx9Zsx6V
 mm9IXPqQfCkW1gK4A0uYbTxmDUeZlvM4NhdHgunVQUHwrEf7Fu/V+zch8emO7ZVjnLdQ
 vxmQ==
X-Gm-Message-State: AOAM533Fu95WKuwJc1UhF/5ul4zYPYNO6+ITKQYHrbtvKL60qYI7TV0t
 r+ga6pxzoX3Y3nap6lczptfzcg==
X-Google-Smtp-Source: ABdhPJwBZuHuioDSq4Uh41Ngc8FuZgbRE/c46PCq0SgpYwEVXo2TRpaMOMG39WHPJSAuNX71sxChrQ==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr28136859wrs.270.1595399352430; 
 Tue, 21 Jul 2020 23:29:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f17sm6701806wme.14.2020.07.21.23.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 23:29:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8882A1FF92;
 Wed, 22 Jul 2020 07:29:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/12] accel/tcg: better handle memory constrained systems
Date: Wed, 22 Jul 2020 07:28:56 +0100
Message-Id: <20200722062902.24509-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200722062902.24509-1-alex.bennee@linaro.org>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It turns out there are some 64 bit systems that have relatively low
amounts of physical memory available to them (typically CI system).
Even with swapping available a 1GB translation buffer that fills up
can put the machine under increased memory pressure. Detect these low
memory situations and reduce tb_size appropriately.

Fixes: 600e17b261
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Message-Id: <20200717105139.25293-6-alex.bennee@linaro.org>

---
v2
  - /4 to /8 as suggested by Christian
---
 accel/tcg/translate-all.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2afa46bd2b1..3fe40ec1710 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -976,7 +976,12 @@ static inline size_t size_code_gen_buffer(size_t tb_size)
 {
     /* Size the buffer.  */
     if (tb_size == 0) {
-        tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
+        size_t phys_mem = qemu_get_host_physmem();
+        if (phys_mem > 0 && phys_mem < (2 * DEFAULT_CODE_GEN_BUFFER_SIZE)) {
+            tb_size = phys_mem / 8;
+        } else {
+            tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
+        }
     }
     if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
         tb_size = MIN_CODE_GEN_BUFFER_SIZE;
-- 
2.20.1


