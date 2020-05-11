Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A570C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0158D206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OTdle7p2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0158D206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8aw-0003sb-1H
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zc-0001s1-Ae
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:24 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zb-00071K-1L
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:24 -0400
Received: by mail-wr1-x42b.google.com with SMTP id s8so10983463wrt.9
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fXod/8ZHLxKpq+52Y123DpffxkGp4HAChW55s9+pKU8=;
 b=OTdle7p24DW+Fk5tHYE5R5vWtn6I0F7FIzwf6+RZb3jesPa4qX/fBO0UD9X4i0Hz+Y
 solb6dqlJFbWcb8TF4t4hG8cS/Z8ZrWnbfhKd0enbc+mg7yk9xXGZmbFLcrujYyQoC80
 xRjA7NrBM+ZwUMvHmtiZjvyf7zSAQnn5cEeAqzJeXZ2gDk9lJ8s7xOkrZ79BCdksQxxy
 SyR0eNeoffoEdiskNV3XXDY3To92L1yt8XEghdsiF2SXlIlPk/e4KCxV5iyidGrU+ojY
 o6gbtnwzGgNxcUNRV9QaYK3xUEHzN0RnHLNEdTSPWy9PS6kDvqoRFZhwpr/FB+Bdku5Q
 88hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fXod/8ZHLxKpq+52Y123DpffxkGp4HAChW55s9+pKU8=;
 b=VKLMhudsPhy6gpq+m73QicTWTUT/9S8rK3AfGNA+euV3eDH57fEvmYtwJMSGIPG21J
 BhI8fLQ21UpWwSlGVDFvU8NMepD03rfi/ZKKTcDs8Pp/dS9XXBcGwcNM1HwBZZZXbTHc
 iDY0dWJThtnq0gM2LfyHG5Bn3KOCAPwrkaE+/HCjRdUfrLSlS9gdsdiSPZBrKqMNMOEW
 1j+SaGGrV00VcbMORjJ6WyM73GA1jN2rLJ4FFD3uPFIeDt8Yzs0KXz9dWitfGmw3epQV
 jayaWXVA/xG+njeBQ2LQuTLtGIbNpTbBAqugr0Aik0pdYPBO665ZCv5P5TgpL27lxD7c
 nnfQ==
X-Gm-Message-State: AGi0PuYxNjvtt7JKPl9hCOSUOKsr5XL/uH/bd3NlJeRGmIIpGuWAYCLO
 gMCg1yFqueenR+1CgMX9Od9dkL+D48nheg==
X-Google-Smtp-Source: APiQypIFMyuWZxCC4mQuxEl05Zv3r+ByRyFwJQskfUtqSCJBjyFk7HGZA1PrN97qF3xq9q3FMykIIQ==
X-Received: by 2002:a5d:69c3:: with SMTP id s3mr18592871wrw.305.1589204059836; 
 Mon, 11 May 2020 06:34:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/34] accel/tcg: Adjust probe_access call to page_check_range
Date: Mon, 11 May 2020 14:33:42 +0100
Message-Id: <20200511133405.5275-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

We have validated that addr+size does not cross a page boundary.
Therefore we need to validate exactly one page.  We can achieve
that passing any value 1 <= x <= size to page_check_range.

Passing 1 will simplify the next patch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200508154359.7494-5-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/user-exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 4be78eb9b38..03538e2a389 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -211,7 +211,7 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
         g_assert_not_reached();
     }
 
-    if (!guest_addr_valid(addr) || page_check_range(addr, size, flags) < 0) {
+    if (!guest_addr_valid(addr) || page_check_range(addr, 1, flags) < 0) {
         CPUState *cpu = env_cpu(env);
         CPUClass *cc = CPU_GET_CLASS(cpu);
         cc->tlb_fill(cpu, addr, size, access_type, MMU_USER_IDX, false,
-- 
2.20.1


