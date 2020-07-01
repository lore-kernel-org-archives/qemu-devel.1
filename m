Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60C3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2682082F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/CFa3Kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2682082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqhSQ-0002FB-2e
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 14:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqhR3-0000Wr-3a
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:26:17 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:42143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqhR1-000490-AE
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:26:16 -0400
Received: by mail-ej1-x642.google.com with SMTP id i14so25999705ejr.9
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 11:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ISobItiQwPLLri4ehEyKGuNT8uzTfaAOep/M1MYjmXg=;
 b=j/CFa3KlSvCTuh449hcpT6j3inUW5r5fnLyqihtw/PiLbZs3o6IfZRGK3WrtGlXESp
 6tF5XNKeGAhlKQomGXql1A/92MPWZlsSi9GvH3kLtwAcebbFtEkCeDd81/L3umGGeSIp
 zNByGfItyBOmc+ckgyNue3vCOqwB37KDXVx30YFfQzd43On4xrqf4gbAvyYt5tyf+Gwv
 JQf0J/wflj/JewqXvzzFzChoSmF9pdFepgO8F4ITMwem7vjptS0XDe5Wp7g3cgagg9EP
 Am79CYCH59cRNtvwgyapura1vePaVWYIqV+4HMQBKq6RbltFXa/n9yr6NbqsIsGdC+kC
 +jvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ISobItiQwPLLri4ehEyKGuNT8uzTfaAOep/M1MYjmXg=;
 b=oEvbwsLABxpil2F8xPyXbAUfauU6pv87ccRiQQUr2rrDquEiKXnTfTxs+Be4wJIz3Y
 0BLXcH11KBdttyQz0/jflNCBDWcGsYAuVGL6ynVNwJc9Dwe0Gc+jehVwROoLLnI4MJCX
 HduQr4FMY+Pd586T9EAsHa0cjlGWkyCWml622OUaLC5w+JhTMeCBM4Fh27V248bvdR02
 bz04IU7oEbdoOmCRe/IWqNfvukrx+dSCmw9gFk31MyIIAjrnzJ92MbI0rwEvNNLN9znb
 Jl9y27CYySE9M6bZoNdKjYfAw+4SKnsZPdUgKpqCTHhzxDnujJM7Mp8HZRwrC30QKHy/
 9Iag==
X-Gm-Message-State: AOAM5320GBfwMI5iEsvJZ0mO5u60f1xI/v0Tnlj5yuOhfYswZG/jgrLK
 uVLN7UP5hhzWew6NatCL9YmmXEdk
X-Google-Smtp-Source: ABdhPJxDG723Py/Mwg+ufKuOW6t4eeIuQGfWeAHI5bxHcW11wjau55WXyoS142RGK43qpChrebPOhQ==
X-Received: by 2002:a17:906:90b:: with SMTP id
 i11mr23670247ejd.343.1593627973802; 
 Wed, 01 Jul 2020 11:26:13 -0700 (PDT)
Received: from localhost.localdomain ([109.245.225.97])
 by smtp.gmail.com with ESMTPSA id y22sm4809333ejf.108.2020.07.01.11.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 11:26:13 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] target/mips: Remove identical if/else branches
Date: Wed,  1 Jul 2020 20:25:57 +0200
Message-Id: <20200701182559.28841-2-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701182559.28841-1-aleksandar.qemu.devel@gmail.com>
References: <20200701182559.28841-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the segment:

      if (other_tc == other->current_tc) {
          tccause = other->CP0_Cause;
      } else {
          tccause = other->CP0_Cause;
      }

Original contributor can't remember what was his intention.

Fixes: 5a25ce9487 ("mips: Hook in more reg accesses via mttr/mftr")
Buglink: https://bugs.launchpad.net/qemu/+bug/1885718
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/cp0_helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index bbf12e4a97..de64add038 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -375,16 +375,9 @@ target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
 target_ulong helper_mftc0_cause(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
-    int32_t tccause;
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc) {
-        tccause = other->CP0_Cause;
-    } else {
-        tccause = other->CP0_Cause;
-    }
-
-    return tccause;
+    return other->CP0_Cause;
 }
 
 target_ulong helper_mftc0_status(CPUMIPSState *env)
-- 
2.20.1


