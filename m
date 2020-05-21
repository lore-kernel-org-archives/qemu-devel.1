Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78064C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B9420759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xo2yYsbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B9420759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboja-0002VF-94
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJ2-0004Ie-O1
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:29 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:38477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJ1-0006hF-WA
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:28 -0400
Received: by mail-qv1-xf44.google.com with SMTP id fb16so3366126qvb.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E/tQbITHc97dgORFyK3tE34tNsNJB0LGdPZMzeOAZ2A=;
 b=xo2yYsbXMAYWcZxDsNeGRW8GPlpUHMnVUMqE+npgdAvvBTMJ4zLTNBUeognUwKOa9/
 v/HIbnYn5Bn6AwN050T3TEZhj48pBqOUh3gcAwQFluN6qt4dTnyOSO841BOvSNk7odn/
 WfpcB+Z8qVUKrsHjOE6eWLk6KsIQZiu0RGKcyrOYCgUxweZRZwc9VAG0/NnmbQxuTinY
 cElnvomWcGhm1jbv720+BxZRNKMET/FATNZhYODBDYUQsYjeQTRY48Vo4oRs1OCRCwnS
 pLD01f4u3P2LQwO3NPs9Y5Ys8PurP8bM+fHCJGCdDYfBKjfthe7+Oagmmlez8K+HuYAU
 5RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E/tQbITHc97dgORFyK3tE34tNsNJB0LGdPZMzeOAZ2A=;
 b=ddqNINA2qshbT3rZAVP/57jzw7iTynsupgZzRgn6oP4X61+f1AQG0Qmym6a0ysTOaN
 E13pZj9KKAzPpuPG9js2nJVVlzxUhk0iaxTntbjmBjR46d4xHVhiBCV22qRFQopP0CBC
 KcbCMnr6EiEj8We2EKhfYUXcFA1kgQnaTMTxc5TzDZbcrF9BU0Soe1bGDfb5pnFSyP/H
 7tV0DlkWmX8jKW3paalf5yk+YXb3KJ9i10Vx+wY1rLP1OVEMGMAtzTOyn1AOWdDalgFZ
 9IkiwyqokbQaZlr6iD03URhOPrREVpZjm4gFE1AITABou4MFLWHDVWosBGp2KY2LwFPv
 p8og==
X-Gm-Message-State: AOAM5311A7NdmX0/eQKpygCeOQuSF/L+oie/B6Ls1z2zOr2okocK/iD6
 eKdopbwKFkIMbwacbRD7OANe5s6Dd8gc3w==
X-Google-Smtp-Source: ABdhPJwto4RstkhwO2dZaQUBcN7/lRGVXAsx4K+KaMtCaTG01RIU/7xnCwC6LeP+nX387ko7L9yD4A==
X-Received: by 2002:a0c:b2c5:: with SMTP id d5mr10934829qvf.36.1590079466923; 
 Thu, 21 May 2020 09:44:26 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:26 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 54/74] alpha: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:51 -0400
Message-Id: <20200521164011.638-55-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f44;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf44.google.com
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/alpha/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b3fd6643e8..09677c6c44 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -42,10 +42,10 @@ static bool alpha_cpu_has_work(CPUState *cs)
        assume that if a CPU really wants to stay asleep, it will mask
        interrupts at the chipset level, which will prevent these bits
        from being set in the first place.  */
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD
-                                    | CPU_INTERRUPT_TIMER
-                                    | CPU_INTERRUPT_SMP
-                                    | CPU_INTERRUPT_MCHK);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD
+                                        | CPU_INTERRUPT_TIMER
+                                        | CPU_INTERRUPT_SMP
+                                        | CPU_INTERRUPT_MCHK);
 }
 
 static void alpha_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
-- 
2.17.1


