Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747E1C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2202075B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GoWNCFiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2202075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzHD-0008Ba-GB
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAq-00052F-Vo
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAp-0006ce-7H
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:16 -0400
Received: by mail-wm1-x342.google.com with SMTP id g10so106962wmc.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ICNTYUZ+6iVasEsw6L8KUA+znBCjot8guAjkE9Kicjw=;
 b=GoWNCFivx2NFrt54e2DPNo9TtDxMDOjUPHahT2l7uNnCdWxO5wROXPXfoiyUuVvVnj
 gaqkr3pK5U7S7KeULm01wTrkBWTzmYLkvu/O+wWXg/cWP3BxCCurNdmvDo8fDRRfIiG0
 7p0Ns8cUhhyQlUewqk7fM7EQmaWRPFXAgXPFpA/UHU9qrYNeRptJ4w7eKS7ARy2jDhDo
 NhB0ZTitstc4ANUvyj5LDsvCHgdEI6vSvs28YKktjgpkN/le2ojTZl3HEP5hbqOribNm
 vIiTQkJkNMc7vwmORGsojBdxmlf7jTeJpdONLpoMfEM05UjlfZFZPb346Ag1efjtehDp
 QqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ICNTYUZ+6iVasEsw6L8KUA+znBCjot8guAjkE9Kicjw=;
 b=mZKHXp/vRVuBQK9jJ8Q3YA6hP0RpT+umjnMyIVnSmLCMEu/obotpVkK+s+eBxrINE0
 LJe/TCw169/hmZx5pTFODIj1/IBi3s7RcrulAdLghSvqJ0qVxGNcO0B6Cg1cSK0Z/yq8
 fa+K+3vbqFbcSFLn/6Rgb73H6zNbyca0ugZexvbzjHZT8wft6mMhWiuPClIy/HWEp7WT
 yaxyHHexNta9FOg8RILK8HgxBCMmOowieL4sLIQzSxL3t+A1uyxdtT0+nNLl/uB57IOg
 XgZVFI4C7oYg5J5fk0gSMgUp7qEj5SCiyJ/Jz6FncmZDldOaW+J+X26nlHleU4jqZlE2
 ufHA==
X-Gm-Message-State: AOAM532v8F+EHnt62XIJHswzU+BrWNSd1rLf9o8B/SDQhLTR4TnG7pD6
 WJMK32OwHd9E6MpVh8Q2fohQPRPrUm5p4g==
X-Google-Smtp-Source: ABdhPJyosjo0/LB0jv60SnliLdt8ERRhhHVm3sfdbcJTqVYOTtb9VuE1vJFGTM9yttLJZ4HloB922Q==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr137567wmb.53.1594649473455;
 Mon, 13 Jul 2020 07:11:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/25] target/arm: Don't do raw writes for PMINTENCLR
Date: Mon, 13 Jul 2020 15:10:45 +0100
Message-Id: <20200713141104.5139-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

From: Aaron Lindsay <aaron@os.amperecomputing.com>

Raw writes to this register when in KVM mode can cause interrupts to be
raised (even when the PMU is disabled). Because the underlying state is
already aliased to PMINTENSET (which already provides raw write
functions), we can safely disable raw accesses to PMINTENCLR entirely.

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Message-id: 20200707152616.1917154-1-aaron@os.amperecomputing.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index dc9c29f998f..c69a2baf1d3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2269,13 +2269,13 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .resetvalue = 0x0 },
     { .name = "PMINTENCLR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tpm,
-      .type = ARM_CP_ALIAS | ARM_CP_IO,
+      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
       .writefn = pmintenclr_write, },
     { .name = "PMINTENCLR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tpm,
-      .type = ARM_CP_ALIAS | ARM_CP_IO,
+      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
       .writefn = pmintenclr_write },
     { .name = "CCSIDR", .state = ARM_CP_STATE_BOTH,
-- 
2.20.1


