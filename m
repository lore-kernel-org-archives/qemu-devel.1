Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491CAC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122D0208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqzz+CP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122D0208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaf8-0000TQ-7Y
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacS-0003t7-UE
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:24 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacR-0004EA-7E
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:24 -0400
Received: by mail-wm1-x344.google.com with SMTP id t2so305167wma.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LTEVy4NzBC1MZpxWLLBEHRRE7l/hCcwK4UzQ3pQm9hQ=;
 b=aqzz+CP5UfsIRXpEjhb1JVBvGuv7L91WgEP42Q8Gff2863x1n5kufQw8DmB8tTm5Cm
 Pt8LaZLPgfK5UXeK/7OguOWI2s4Hqg4dZ125IkPncV6LopydZfK4a/KcskBnQ+SDqAec
 9CetlFw2Z26UCdNvEdO48agbQFRl5F9iRUIyUs28+xQnjRoSSYoVPOvuJ7FRg3+xJkzx
 3o9WFvLJS4j9fWx7nCxZqXyeiGGiB/pI4bLn55UJsuqLsdz3OYrwwPOpaKoJ7Fo8uGNs
 9GgICF5jJs9dCiC5qYjRoUnZgKcUivkjjn3A/FPI4bwzo+WeWUZ9VHvWTClvUOdkze04
 MO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LTEVy4NzBC1MZpxWLLBEHRRE7l/hCcwK4UzQ3pQm9hQ=;
 b=bfdqXcwebiySY6u329bUUir36VtwEdTPcvbm0GurS6kxzc2oagCCDBa8Jlhv7QOKXz
 W9qOnovKC4CTWqPSzJBYfVC/gOH2YgEskpdEgJ3tzPikBVg9e0cX5lDm6asJAaoICl/H
 v3knHepOnx0UH1Vo137KBWNp3r8Nxa3dNhICnOPWgNI9URw7/1Blm38pyTRWAjyCdZOE
 kSTTF3HojXXqV72vGO+GdIicRdCYMofUjRLA81sAJ6ZIdEYr2HIzXtGoLQAw2+Nk0OWK
 utDOR0qU1P/WIGqH4pfFbTrfcZYAhK0IODDo+Vo5r0DuY88ZOk1MqNqUXhP1roKpDgws
 vOKQ==
X-Gm-Message-State: AOAM533HlNDBIK4rTaLnxJGR63fYtV7r81vmF0OLHgsofB4l6gW0rKTi
 cbca/Ch6neb5HC5o2gwe7mIAbGvoOaDaY6XE
X-Google-Smtp-Source: ABdhPJytQK7S0zr0G+hD8Uwhos3zPihLWm07TLILpiA8cDYaQ5bsAeUs0m/E+SkSw7fJtyDOnJUNXA==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr725930wmh.95.1598606661596;
 Fri, 28 Aug 2020 02:24:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/35] target/arm: Clarify HCR_EL2 ARMCPRegInfo type
Date: Fri, 28 Aug 2020 10:23:44 +0100
Message-Id: <20200828092413.22206-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

In commit ce4afed839 ("target/arm: Implement AArch32 HCR and HCR2")
the HCR_EL2 register has been changed from type NO_RAW (no underlying
state and does not support raw access for state saving/loading) to
type CONST (TCG can assume the value to be constant), removing the
read/write accessors.
We forgot to remove the previous type ARM_CP_NO_RAW. This is not
really a problem since the field is overwritten. However it makes
code review confuse, so remove it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200812111223.7787-1-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6b4f0eb5334..44d666627a8 100644
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
2.20.1


