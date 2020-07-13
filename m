Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D509CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42902072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wo6TEw2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42902072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzF1-0004i3-Ro
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB4-0005Z8-Sn
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:38396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB2-0006f4-EK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id f18so13314488wml.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XA7EtZ0Jb+HkGsgLo2baaKD+l0umSsxaqLrlSb4bGaw=;
 b=wo6TEw2zsJzv0qwyJjyck04dx/CEfRVOcu6q2WbEUNQaWi36DKpDvad1BicRchd8SB
 5ewbi7yscmM6cjsj/285AGLORJf0oKtNSA7vrPyOrm/P5SsDqx5yjfKoPtaSub0P0bTb
 y+Dh8SMn0xAYtgBNWiXObh1JuRsBpGpyHjNDsoYfJ+cLfIQCenfZ6j9ecBxHq7wq+CYG
 Z13q7a5F3LFhoxmfTx3UKMb4ZN2jH1VJ9v2JQXF2e59+9Tmjbixnyqr/0sD8Uie46SR3
 SAVQRHT5pzEdCJ6EddiG26yTEN11e8tNZUWsUVbFI2PEu7mHBoIv8TndxGji7XsuRs3B
 8S4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XA7EtZ0Jb+HkGsgLo2baaKD+l0umSsxaqLrlSb4bGaw=;
 b=HymhnwIp8h/rjXXzq94n23RzOzX0BBOU8dd52WnCSF5ofTMdXBGbIGfrxm2CiDFAfj
 jC01LjgDc0s6RiDyyJAZgltkfk3nLb0t1wxuKUX0b4uAWKTy+GF7xJRyfoCVvDozLwIv
 KDj+s/R3l/FN2098deGk+QaKYGwGI99lyB/4T7fIWoK7DYMkhun7y7st1uDC453j5UxB
 R7cFc8e6zm4VilTf6iEQ1eozwJILHaVrzWircITNnknewoLbnKb8YR6t22Hb5iin4UdQ
 04L5yCaBVzCdAou8InRZJY/jOJbXXE8GxHjcaWjbVcQAz+IeRpJchCdMWZx/o8wVk1PN
 qt3w==
X-Gm-Message-State: AOAM532RLpCTK0texpBc+0JhJry+FVh+V9WqUOfj/toPTSRX2k414tMI
 VRfYG3y1mIA+qReNDhUYYEDsGPilU8H7gA==
X-Google-Smtp-Source: ABdhPJx0QDldgipL4zxkG7woCoVRxY1qbQLWR15sMhjtlQtLvxELfEzoGYrQL/+Ktow+kcJ+WuRUxg==
X-Received: by 2002:a1c:6246:: with SMTP id w67mr178584wmb.42.1594649486743;
 Mon, 13 Jul 2020 07:11:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/25] target/nios2: in line the semantics of DISAS_UPDATE with
 other targets
Date: Mon, 13 Jul 2020 15:10:57 +0100
Message-Id: <20200713141104.5139-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wentong Wu <wentong.wu@intel.com>

In line the semantics of DISAS_UPDATE on nios2 target with other targets
which is to explicitly write the PC back into the cpu state before doing
a tcg_gen_exit_tb().

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Message-id: 20200710233433.19729-2-wentong.wu@intel.com
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/nios2/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 00b591cc298..c2a134f932d 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -865,6 +865,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     /* Indicate where the next block should start */
     switch (dc->is_jmp) {
     case DISAS_NEXT:
+    case DISAS_UPDATE:
         /* Save the current PC back into the CPU register */
         tcg_gen_movi_tl(cpu_R[R_PC], dc->pc);
         tcg_gen_exit_tb(NULL, 0);
@@ -872,7 +873,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 
     default:
     case DISAS_JUMP:
-    case DISAS_UPDATE:
         /* The jump will already have updated the PC register */
         tcg_gen_exit_tb(NULL, 0);
         break;
-- 
2.20.1


