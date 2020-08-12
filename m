Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6658C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 11:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81EAB20781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 11:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="og42ESaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EAB20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5oh9-0005E2-PO
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 07:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5ogI-0004Fv-7K; Wed, 12 Aug 2020 07:12:30 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5ogG-0001Uf-L6; Wed, 12 Aug 2020 07:12:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id k20so1538934wmi.5;
 Wed, 12 Aug 2020 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FhTHvpnUXP1ndPbvcSrcqLf5KiVFTnMie13cYX3/Hjw=;
 b=og42ESaTyCiuuFEx5ZkMRuQQWcQJblhMCq2/jX5WJdnZdaX9fvDcSkhYDf3xjafvCY
 KjIVThWTmJXFnZp4d3OYrNc5VCOJEWg7oCqslQokktI1YFveOFTAOI+Pl8CfQp2hQ7rs
 MoiVHRga/sLpXIPDlNmOSD5MtQSAbQZB9IJnOPdGfZs6wm2wPs8lWi5JinaLztu7xEjT
 jWRLWwiS6qdgp2uh3fKvddaTnmzjwY8pt9gUKUYtaz74kOqdV8zGUTKbk1+Bwlzxx+oi
 noUuvQ59WHRoX8G9ehhWZ2/M372cUaPDVs0zQb0KuVbJA+98fcpNGEUjkCCfjV1dXU5U
 AMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=FhTHvpnUXP1ndPbvcSrcqLf5KiVFTnMie13cYX3/Hjw=;
 b=dxPPuoFnLYA80VacTxPkI6VZpVdJXNg3GwKhclP2T7oXiegWaLP/QIxTmkICLO+cpm
 aL1E5gCNwlkzX2cwPD9ltFIKV+z4Z5OKh7nXmMD0QgzUBaqKBEbIPBIRb3z462CgcLdN
 xkdIRDrCkwj78zc9NOSQhkhInRzsWk3dO+TWJsZ++oMXdaTKrZCOPCuVpw1kVzln/Cmf
 zpYBdPR8pwZq2RMnbB+kukroBcBGPnaYs06KTAiQRKBgjh933GZsORQWP4vCP9VGsfAg
 iLAeSkIOel4X0US92pWRj6lbTpN6xFtp7KZuRG2HzFAJdGi9WqpoLPkkQJuMKF0PUSpn
 r1yQ==
X-Gm-Message-State: AOAM5312WHp2XDQpPwwVuaWj/wRKzgHPu972a4/mHo36WE9B2X3g6iSB
 PxmZJy5Sdep+ldwI9EaKccWEK8Cz
X-Google-Smtp-Source: ABdhPJxN4gLnn69uMHcNSkiVYXzxx0DxM1o+Wm6a0nQVqkjZR9jlUfUxvWwfjaX1rokWYnXZNzQN2A==
X-Received: by 2002:a05:600c:2112:: with SMTP id
 u18mr7756645wml.7.1597230745649; 
 Wed, 12 Aug 2020 04:12:25 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id f63sm3342159wmf.9.2020.08.12.04.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 04:12:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Clarify HCR_EL2 ARMCPRegInfo type
Date: Wed, 12 Aug 2020 13:12:23 +0200
Message-Id: <20200812111223.7787-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit ce4afed839 ("target/arm: Implement AArch32 HCR and HCR2")
the HCR_EL2 register has been changed from type NO_RAW (no underlying
state and does not support raw access for state saving/loading) to
type CONST (TCG can assume the value to be constant), removing the
read/write accessors.
We forgot to remove the previous type ARM_CP_NO_RAW. This is not
really a problem since the field is overwritten. However it makes
code review confuse, so remove it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/arm/helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 455c92b891..9aeb8ebfa9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5105,7 +5105,6 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
       .access = PL2_RW,
       .readfn = arm_cp_read_zero, .writefn = arm_cp_write_ignore },
     { .name = "HCR_EL2", .state = ARM_CP_STATE_BOTH,
-      .type = ARM_CP_NO_RAW,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW,
       .type = ARM_CP_CONST, .resetvalue = 0 },
-- 
2.21.3


