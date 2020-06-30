Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA78C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6D120663
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZp8w2Uq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6D120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIAB-0003vZ-Uw
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqI8s-0002OC-69
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:25:50 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:37634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqI8q-0000Hl-Kn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:25:49 -0400
Received: by mail-ej1-x643.google.com with SMTP id lx13so2408969ejb.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=upNPHIrMVxywp/ZU0zAWsGAEn/MYe/LdlqvxdOHWF20=;
 b=dZp8w2UqXcH0XG1YEgXrIW8aF6sJyFJSL3f3zbsYf2e84NgvczXk4smWJq8n8RTAnO
 4n6ER8QhErArU+8Ng4l7P/dMtt4R7rTTS420wS9jxZPZYdBdW2yoVn7Dl5cHA44b/eDK
 dX09AV76vB8/WWHp+CQuN3KyPVh/+IJlkT3iyO8emeDtN3rDneca625aZMuzTd47Z5JJ
 S2fgSSe89CNP2DtYP0QqM8+FYirCSmwqvxkotQ2pL3G5kUeeHVpp73CJ3Nr5wUMuZGEe
 3QSaTX5JPTGIMGLy83UmU6Q0l0fyrAEJ5sStZeqemB+5kbCSLSBgr+mKiRxYuhW9yFNk
 oOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=upNPHIrMVxywp/ZU0zAWsGAEn/MYe/LdlqvxdOHWF20=;
 b=ObFfKD+boDOVGiLJJuTaZlzBiclqNtHuorJyWkq2lWJfiel1J7oDBTWwsAwC/D7q3Y
 8jlBUzjR4Kifncgx7rD37Zvy1Fetx47s1kiBORU5/lTgnn1iZnOB41zccMJGLYslKEQd
 nz+uRmb95P7ZwmnuSjkCclSsTCuFqVoatFUSvN42zj/aEYr9hP1o2xVYgrqXW4joaCnk
 yezA+nloIQCRb/pNW61hK4MSS0RRiGvb37LhpQg1aiBggJ+fj5Bfua7xPTlpCd3jRZDp
 VHEuVIp4r0Td8d2t3wKsrT7JLQ70xsrYJ7ATzRAx0s48Ngyd79i2wP9PFPw1s+qp+6yK
 QPPQ==
X-Gm-Message-State: AOAM533lXUTuipgldQGFYhznqEbcKOQ+J4Z8Zy59jL6xdZ5u1WuIyIqq
 6eKVY4b7cflwp+Lf5lQoP8kHsWNO
X-Google-Smtp-Source: ABdhPJy7cKhp9OFlgLgefCndZmJc3VFMDja3U9nT2ZQt7kNlHUAsOXmXI5OrWJvbDlR3A5d2f9SwSw==
X-Received: by 2002:a17:906:b217:: with SMTP id
 p23mr19224854ejz.98.1593530747223; 
 Tue, 30 Jun 2020 08:25:47 -0700 (PDT)
Received: from localhost.localdomain ([109.245.225.97])
 by smtp.gmail.com with ESMTPSA id q21sm2272398ejc.112.2020.06.30.08.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 08:25:46 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/mips: Remove identical if/else branches
Date: Tue, 30 Jun 2020 17:25:30 +0200
Message-Id: <20200630152531.20657-2-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630152531.20657-1-aleksandar.qemu.devel@gmail.com>
References: <20200630152531.20657-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ej1-x643.google.com
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


