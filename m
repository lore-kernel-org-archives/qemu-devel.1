Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F51CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1EAD207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4bgSEXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EAD207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboXt-0000Pm-3A
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIi-0003Wz-Sp
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:08 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:38186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIh-0006at-Pb
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:08 -0400
Received: by mail-qk1-x742.google.com with SMTP id f189so7858946qkd.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UAoGpC+tFU+Lrmci3F+3S0Zh/4YRyJd+sLsoLGG3MBc=;
 b=e4bgSEXXYU4jtFQ+KAAONNIwceOG1mUgyJ1Ijww2v8IqnZ75dWoxmC3vc7sg10DIOY
 59VDaLq9hcQnoVctSL+c6jjX+iu25CSkbIp0HyIRf958oqFyAXfpoY12bQQOhh4rw0vD
 tWStt+y7reh0SO+ZduntebBpRYejvrdF3FhcOZfCHeyZLmcRK8XSnqHKDUcJcKLhhAOH
 qzLRggIu5pI5/ndS3RQOAWu3m+FX+o3spCE4CIrwUJiXo5cbyOdko1FbHdIIPnxyOEgc
 9IA++nfbtQQysJ5oH5phH93HnBJJBl9v4hD38X08yWa3xQ+QnuGvwud6KVOyYQ/NDd1E
 KCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UAoGpC+tFU+Lrmci3F+3S0Zh/4YRyJd+sLsoLGG3MBc=;
 b=phpP1M1y5FG2ZJORwZaxXSqNuoyycbqq5A69Dmpa/Wg12VyQtAIY6opx2T2FU5s6ZV
 2irdni9xkWsBeyzapJWm1eImalIjYQ8NvGzrMz7YFqOONyB2Ahx2i5BKCCZ/2k7xcBBa
 wlwPh2LpIX9JvY64rVO7PO2RPEQR0DAo9sQYF/xhyyVqWCii7jAQpaIQhS0kn2Rap7+V
 +r3MVkzogv/eM5gDOZPS+qFjmTIdx8+ZrbF/heigWAQiBNgKyN897m0NSVPeuQnP6G9N
 aa4o8fNWKY8U2aQFOHwjQ5DdqrdPitmUb/R1wSw7U74AD9lkv1iCIa5SwB1E+Z87Uf+a
 ttaQ==
X-Gm-Message-State: AOAM531NVFBNQNGqZGQYJU4iM0Og2q/9faFv7Q1XoCWYwEUdUUNoylPd
 NrUMUTc9eMlQWdSohnAYrRxC4V4TzXlZMA==
X-Google-Smtp-Source: ABdhPJyGea4nAk26guwW5skWogXSPm2ospbnn0HCF2jnL3+uXpVxewMm8FPaptpP2Na3/Ymj/vGigg==
X-Received: by 2002:a37:9e06:: with SMTP id h6mr10566458qke.400.1590079445614; 
 Thu, 21 May 2020 09:44:05 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:05 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 38/74] openrisc: use cpu_reset_interrupt
Date: Thu, 21 May 2020 12:39:35 -0400
Message-Id: <20200521164011.638-39-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
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
 peter.puhov@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stafford Horne <shorne@gmail.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Cc: Stafford Horne <shorne@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/openrisc/sys_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 2615571ce7..e54c148d4f 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -167,7 +167,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
                 env->ttmr = (rb & ~TTMR_IP) | ip;
             } else {    /* Clear IP bit.  */
                 env->ttmr = rb & ~TTMR_IP;
-                cs->interrupt_request &= ~CPU_INTERRUPT_TIMER;
+                cpu_reset_interrupt(cs, CPU_INTERRUPT_TIMER);
             }
 
             cpu_openrisc_timer_update(cpu);
-- 
2.17.1


