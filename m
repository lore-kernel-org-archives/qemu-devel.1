Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428C1C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14605207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZAYsfq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14605207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBMvk-0007b0-UH
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 13:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBMtg-0006Q9-Gp
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBMte-000089-Vj
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:40:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBMte-00007m-OM
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:40:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so7611735wrx.5
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pd1d+il4V+KkThmMTERSYGXdeHgQGOjSI8wZb/+55zM=;
 b=dZAYsfq3BnTXrhPNXwWj5FbwPIBkonMcemnzkmg4/rgJAoO630LTjjjv3kwwa2qH51
 suIC05jyge/GygtOfpnFLSikuGu5SbOERB5N2DFSkkRXNHrAhVM9t6dAlYyg7wtl4Ogh
 y7MkRvoNK3aeDK7E5bftNOV/UmlBoWAauKelqK3lwf93q+bClN0g0PH7A7hb5ugC3lhh
 yMfqw4JPUtfSqBCsEUkNGwuNbHzO8+C0HyNckz6sLhacbYzoLikm9t5dWoHOt/uYgw2g
 cdBkibvaM8E3VWfUBQybbtlNYLnE21+a9BpPI8Mt/hGDCMrBEC6K46kSy/X3YAj0YKHw
 M2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pd1d+il4V+KkThmMTERSYGXdeHgQGOjSI8wZb/+55zM=;
 b=etXXaOHE+sGL0UvILHaEyfN6Ug2655duUR5QAB7QII9f8hpjnszXE8rtODWgZRFJMP
 +PpNBNx7m+K16+Ol4Z2m/qKdg0RMN5H91g4cuA3gi5TbWK9eXsPoktdo5sOC9ALxB0TS
 W4hcEVJaAzcAH8GtTq8GD03J2/K4AdGffVt9BaTBmR43wnL30NFeG/LuFhtcs/Tz+Nmb
 0IT1QN/MQu5d96C55gWqLkU/6mywi5L2Zbia8Ruej6dDG98LG4bbMjJQRW9OO/S9JdA3
 //YkpuW2XSa1skBBzLoX0mHiuzzvFPvOOkd+iixUNCc4H/2l6DVFvugVBDMwTsV+3b3A
 6VMA==
X-Gm-Message-State: APjAAAVc7lNVBedzpqtexVvvrxurikGW+GSjpIispiQHCaINdlvsxeba
 Gd8+WJ19jjwWGMiGtibUxiO0mQ==
X-Google-Smtp-Source: APXvYqyMFMR4rs5pk6xG8O7id19l7PsfwdPQOS4PO5bxKErk0S5EPVHI68IkwxeXyRVmLZkwuzIbfQ==
X-Received: by 2002:adf:a350:: with SMTP id d16mr12503364wrb.326.1569001241540; 
 Fri, 20 Sep 2019 10:40:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b144sm2710547wmb.3.2019.09.20.10.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 10:40:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/boot.c: Set NSACR.{CP11,CP10} for NS kernel boots
Date: Fri, 20 Sep 2019 18:40:39 +0100
Message-Id: <20190920174039.3916-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

If we're booting a Linux kernel directly into Non-Secure
state on a CPU which has Secure state, then make sure we
set the NSACR CP11 and CP10 bits, so that Non-Secure is allowed
to access the FPU. Otherwise an AArch32 kernel will UNDEF as
soon as it tries to use the FPU.

It used to not matter that we didn't do this until commit
fc1120a7f5f2d4b6, where we implemented actually honouring
these NSACR bits.

The problem only exists for CPUs where EL3 is AArch32; the
equivalent AArch64 trap bits are in CPTR_EL3 and are "0 to
not trap, 1 to trap", so the reset value of the register
permits NS access, unlike NSACR.

Fixes: fc1120a7f5
Fixes: https://bugs.launchpad.net/qemu/+bug/1844597
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index bf97ef3e339..25422660545 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -754,6 +754,8 @@ static void do_cpu_reset(void *opaque)
                     (cs != first_cpu || !info->secure_board_setup)) {
                     /* Linux expects non-secure state */
                     env->cp15.scr_el3 |= SCR_NS;
+                    /* Set NSACR.{CP11,CP10} so NS can access the FPU */
+                    env->cp15.nsacr |= 3 << 10;
                 }
             }
 
-- 
2.20.1


