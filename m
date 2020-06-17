Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BD9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411322166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjGWNyK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411322166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfaT-0000h1-FR
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEd-0004IZ-Q5
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:41 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:36374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEY-0000MT-78
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:39 -0400
Received: by mail-qk1-x741.google.com with SMTP id 205so3521153qkg.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E/tQbITHc97dgORFyK3tE34tNsNJB0LGdPZMzeOAZ2A=;
 b=gjGWNyK1fJl5+QdDcTtGkUHu0bKZupTYgIu+ikmiZPdtkwH1bKpmzZMkekHfQOqcyp
 j6iTEhdp4xVVerBTq6iuPTwCNjRVTkX9kkrFWnklf5AhvoU+PSlfMRuaeNZCJdObue4J
 rDMKy4yeH1BSyTEBqEVx9/0u6l2UcRkl1xVXG4U/yZ3a1FNwPiV1oshvaEuxn9RKCpR1
 o6wBIxf1pmtmQS3jLQBLgp3a2PITVnVJCpXl6NWjnCgiujBnlahisTEGpqOpvcCXAhlB
 GGd06yOrXzXNLBgbvFarwTz773YM9k7IpsMSSxeggM7MpD+rE+1vUauIuUv3gHPwEuzK
 FsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E/tQbITHc97dgORFyK3tE34tNsNJB0LGdPZMzeOAZ2A=;
 b=tHvKO3iyVC1WPUEI5z2oCQeYbDzVuIuWMN7u7tOTVkibB4lLAoxIqEs704u2rm32bg
 ZG/cMKb+UHdJKVqGb9rBBHJkTUFkPmnWYqdtKs/ZkJ2BllhoMopnjr61+PKF2SnTGmWL
 I4zRDeWF/2J6CiP+MNcrATCR+DisqOFuOMmS6ibZvqqRLPcqBuPOX9sbrtdlIgeeK9Dn
 T2Ix/tQMySktzJOdwSGZ9g//+XTzbu0aGjtiBzsp4+aBSTRu4DYUfk1AiB4UmdSpKo6L
 VEm+MRCDoH1VKCKDLFIgd8JFu8dFsbdG5EN/rddZ3kjDHp/qyFKCX7/nat3g6iFJKpjr
 cdHg==
X-Gm-Message-State: AOAM532AX38n954tASMmrXsumE5R0e5DqzEjPT3Z3/vgWciVb1Pp5WUt
 OMderKbsZQQNxv/nem9SOrLB05flI96EMw==
X-Google-Smtp-Source: ABdhPJyZimv7dIPy8hBowq7zQvT/g30LHqCOD6SLjPxun950vDmvnc9XckquUOklTVlMA3HyYU7uEw==
X-Received: by 2002:a37:4ed2:: with SMTP id c201mr607695qkb.138.1592427873025; 
 Wed, 17 Jun 2020 14:04:33 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:32 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 53/73] alpha: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:11 -0400
Message-Id: <20200617210231.4393-54-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x741.google.com
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, Richard Henderson <rth@twiddle.net>
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


