Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30BEC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7022071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDryJzrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7022071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9GH-0002JJ-Pg
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95o-0005a4-AT
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:44 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95m-0004pl-JD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:43 -0400
Received: by mail-wr1-x435.google.com with SMTP id x7so1932707wro.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4SpG6X894Q08xJg7KSl0Dqp09v2NXNEz0pss3dMzgp4=;
 b=SDryJzrrqIRbdWqq1fnufgMPdIvdmsoR6/eXYe4fwhicUkA5/3KCzT4WIfgpnxySbg
 8s5wwD12s/GvXKpYQbfVaMXdWGjTneq7wWZ1eJfanUdBh9w5J+cjCvPzXYDLLIK3G2lU
 bNvep2MduoAIjG1pLrBJlJwFxpq0oOKN4i8+DvptDYEgJkeEptgAGqOwxlb3tFFswFko
 h+g4HRjsAluHXjLDN9yfqCrClO5Mr8ysc1ccnGCZ3y0akGqSBrKH3IqSjmwRsjyNGXP7
 ZduMk2I/nlO2NA91xzEB0brTIC6xjJdJANiiLab4LFK8pDHscb6pZt/EH5kF8TgZH9Gw
 3I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4SpG6X894Q08xJg7KSl0Dqp09v2NXNEz0pss3dMzgp4=;
 b=eDc1TIWKOWSQtw9rMQPSJvUgxGaRQRdI6zmgbBI1ZerV7bAxhqTioxn3fgEDz0XdLO
 TFCfPUtKuXI2NCjyxqHJr/69b4yrO1UrSl020uIyMn+cGbLkT8UzXU5jTW4QPsePlLPf
 flz/KdwFaU6f9qzYdbViodOXinvJY4sZtlMguen4LRH3L4LD+WTnO/uGyT0lfIGj0fxR
 z56Cw08JJIHu7MjIXaQe7Rbua2KG2df655c+YR4VZb5haIsrZZVGgd87GLawTyEcU9g9
 1rQXr+arG/q1nsM8nsfFEV4C0TkXL3m47c1I3WC7tIySzz2J4rerMCVH2JJW6wti11dP
 bR/Q==
X-Gm-Message-State: AOAM533ZZzVBEjDbWkvbLgvH5btnSk9m4aOjyt7LFUcF/Ox1/pLB3w7c
 W5919DPG4/AP+VpUBr/t+LDT/9K73x1k4+bO
X-Google-Smtp-Source: ABdhPJza1kiL+5sRTQdw5IezXmTA94KzD0yX/RVTkDgkXr8vGiISXqDfm0h3bG3pyZxs/ihD+ne3Vw==
X-Received: by 2002:adf:f007:: with SMTP id j7mr4746688wro.195.1598262520893; 
 Mon, 24 Aug 2020 02:48:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/27] target/arm: Delete unused ARM_FEATURE_CRC
Date: Mon, 24 Aug 2020 10:48:07 +0100
Message-Id: <20200824094811.15439-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

In commit 962fcbf2efe57231a9f5df we converted the uses of the
ARM_FEATURE_CRC bit to use the aa32_crc32 isar_feature test
instead. However we forgot to remove the now-unused definition
of the feature name in the enum. Delete it now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200805210848.6688-1-peter.maydell@linaro.org
---
 target/arm/cpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9e8ed423ea1..9d2845c1797 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1950,7 +1950,6 @@ enum arm_features {
     ARM_FEATURE_V8,
     ARM_FEATURE_AARCH64, /* supports 64 bit mode */
     ARM_FEATURE_CBAR, /* has cp15 CBAR */
-    ARM_FEATURE_CRC, /* ARMv8 CRC instructions */
     ARM_FEATURE_CBAR_RO, /* has cp15 CBAR and it is read-only */
     ARM_FEATURE_EL2, /* has EL2 Virtualization support */
     ARM_FEATURE_EL3, /* has EL3 Secure monitor support */
-- 
2.20.1


