Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C4CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B33820899
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJDpU28e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B33820899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzU5-00024C-No
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqzOu-0001Nc-0s
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:37:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqzOs-0004IE-1b
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:37:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id b6so28402994wrs.11
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fVjN3LL/J1872T899HpKN9bRkXDYAZGvYMXeS2DZvT8=;
 b=cJDpU28e0C52a84QY2Q6baDWJpShDpWFnJAswD713VJsA/IVAzV3/IqL/IixinS7Z7
 jFx2gYNF0C9m94abBC6dgXBVwz+IxL80ior6RDI9q6znX7Ur3K7Fu3NLm6ASUSVkkWCm
 bPoPaJ8md0zmPp63jWtaN0RxEZxmJQxw320zMoAqT/4WFr09DBemRrVQMO5c1FnUbiOE
 iCtuTCYhREEbfG6+K0As9GsndUMjs4TirdPg9zCj+cIsIFa4hC2jfdBaJNfUWIxijGFs
 1OF3E0qgR9SpNdPvLhUI5UPv2+feoiQiaaBn/gXsmYR7OCpq2r01uuxQgXqtRspn5DQI
 i36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fVjN3LL/J1872T899HpKN9bRkXDYAZGvYMXeS2DZvT8=;
 b=pj7Srm4IjJJcevFEfG9/Ji7ppq5XG8QpqpGgeZ0qBPZM6WAkAsY1eX+Kyb18qXl39I
 wYT+m6mQygf7/i8quc0MQHIHZrlIyN7PmJkqpRYsViZgWXPFw/zM6Vh4X/AJIUbxUOIM
 I/kDmLAtCX0mOY/VI/ybFCGXGgEkTKtcujHP+2/bQ7u+qG7t0u6n9l4qL7u9DmLiqvmf
 muKdbdhoL9E1sC6FXvCfzxh90n/AnZaiJrGNYz9soW+UrCBx/gx+keS5lQ0fL9oqH4yx
 cI0V9pVD/4psByD1ba6v44PvF9yZS8DdrmxNhVZWycilQGsbH2TIknPiLKQJNboz7G2x
 je5g==
X-Gm-Message-State: AOAM530cSFsrD32fE671BtUAJchwHmvCvhP2TtHYyKzrE7u5nbDb9hMa
 fKq/DCf3bCU7CbzHx9zQkIiP2j1NGQA=
X-Google-Smtp-Source: ABdhPJw66W2qjJGlNahVw4v2/4c3lIrWB8JBz76IHx2xjG9O7IK8BowL0TOh8yeHJtwkkOivLxBnsA==
X-Received: by 2002:a5d:4845:: with SMTP id n5mr30804785wrs.353.1593697032461; 
 Thu, 02 Jul 2020 06:37:12 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p17sm10190511wma.47.2020.07.02.06.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 06:37:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] target/mips: Remove identical if/else branches
Date: Thu,  2 Jul 2020 15:36:58 +0200
Message-Id: <20200702133701.25237-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702133701.25237-1-f4bug@amsat.org>
References: <20200702133701.25237-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Bug 1885718 <1885718@bugs.launchpad.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

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
Message-Id: <20200701182559.28841-2-aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Bug 1885718 <1885718@bugs.launchpad.net>

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
2.21.3


