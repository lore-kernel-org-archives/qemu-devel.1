Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C67FC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D3C20826
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jI1QZvIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D3C20826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboVq-0005A7-HL
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIc-0003NF-Qm
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:02 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33]:46682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIb-0006Zr-CF
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:02 -0400
Received: by mail-qv1-xf33.google.com with SMTP id dh1so3333586qvb.13
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=roYFUSuiQ9xl45PTniWtLw6l9xYhMo+mP3mKLillljc=;
 b=jI1QZvIP/2Bpw307VN07UNtsqAg6EkOf8nJKGGeG32k11YuTdf7Os/MAxIVfm0V8UW
 FfGeCrvyUTlYcpKcw6Y4A3p5C8XI7/+kdJ+J4Z8uY/UEjv6a0gzYvrNhg4EOtyFfcjd6
 mPjHKTu5RlWjlOdDA7Tq5Q89E1FZCO9cOLNP3lWNmcy3Q8loqXV63cGCnFsKoLGn8qh0
 c9o6sRRcTFZZ/LMY8BfZvTELcQHHHY8+mQMobqmPk4FPV6lQVlsmeD3CcCOb9+8JiVsY
 PZgTWKiPcNsUXuWXPLSKDa5OY6Y5LmubHO8fny797VpTnVL+UX6xBUdIvHgXHQ+PVJ6b
 1iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=roYFUSuiQ9xl45PTniWtLw6l9xYhMo+mP3mKLillljc=;
 b=KB7pS3DsnSXW1N9UJF4PHMpl+ML8nzZ3I7cqRT3Jna3K7hPI/m4ozMrwsV/pKLqnYR
 eVhL/giAQpA4xM6OYuPSDQbR35BE95tBiggucfi99Fit7Lyp632V8gM7HeFuB1bn32r2
 6H0PGDs4P241gorXTsvOq2FEFdyEwQFnqAhlXI39mczjc33aqstpRqzOnzkonI4ke3ZX
 8DmsOx1sYaro5uQwTVDEE03AmCDxyvV2JEmYcTvoBau0IUyZ2TNyfzIPnYMliHTAzEqD
 DewIer4HmJOnLvAUEIPlpXsrfj0WD9f2Vl94svISyk+rwB4/zPmHA8CH1LnFIs4DRP5M
 EsYg==
X-Gm-Message-State: AOAM532YIpCtY6qAthphFLMmT935gxHiyIaVCgqPBIQRZYH8fHv2AlXJ
 23sRkhoxowB22D6HO1x/HWCvII0+wqhA3A==
X-Google-Smtp-Source: ABdhPJyZ54sjvjK0vD1kZTsDKqIvPhZgn1FlG5g7K56vOKlZpnsy5Qss9emH0R4JZXIhXEFjhd8mJg==
X-Received: by 2002:a0c:e488:: with SMTP id n8mr10324642qvl.172.1590079440158; 
 Thu, 21 May 2020 09:44:00 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:59 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 34/74] ppc: use cpu_reset_interrupt
Date: Thu, 21 May 2020 12:39:31 -0400
Message-Id: <20200521164011.638-35-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf33.google.com
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org, cota@braap.org,
 qemu-ppc@nongnu.org, peter.puhov@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Cc: qemu-ppc@nongnu.org
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/ppc/excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 4c7da88682..5fee92c310 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1021,7 +1021,7 @@ bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         ppc_hw_interrupt(env);
         if (env->pending_interrupts == 0) {
-            cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
         }
         return true;
     }
-- 
2.17.1


