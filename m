Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0743C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FFA2173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RRii2qO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FFA2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJlf-0002PY-6G
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZP-000458-31
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZM-0007aY-Pj
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:50 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSJZM-0007Zi-JP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:48 -0500
Received: by mail-wr1-x441.google.com with SMTP id j15so4669808wrw.5
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YkY1QSHXx8tcEh42Bbj6ykJYD8SvmEqcbVRa0x3ucZs=;
 b=RRii2qO01P4d996eFNKftljSnF0hFDrKtvwW8xabNlr1GvNP1cUEVVoUP1f39hQbHx
 QRV+o4q2pkap50DTD7Mvml4q72Di7afet65XytMpvbZUl25pnbq2TtdniJq8EqXMORpJ
 JImXVr0SMJB7NZZa1yxunrK4jNXFIku7QIOMricijBVSjQa/5IUZim21vovapFH42W8q
 9esCUGG0lVu+SVwXTAnpdyZx1wa3adk9NJ4fJu1YogIfH8NxvvNQzivkJzds1TV71+mU
 1dsmgw8qzC2+lxhLCpHcer5XnMgOpft/XaZy05OggRxrQWFT14WQkGGDqgPNydemeWO6
 7fFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YkY1QSHXx8tcEh42Bbj6ykJYD8SvmEqcbVRa0x3ucZs=;
 b=cZoAuM7A3qPhe+n/IQyYMur0bUt9S9TlceEODM0pGnOAjJkbd4FYAuBL6sxThRqFxE
 95Bgdr1YdWX6NsQwimuaNraJJbAwyjoFZx28iA3vGB9bOeuDdCaGu0DHXxHhAO50amnh
 +ZsIdvogHuQBqp+a9rApc+X/pbUdnRYa7WwZpRcyBijrIta0j9j241RACkKqVSdij9tW
 dFahjXdERQY1ETA99NsnlUTx6f0i4RW7EwY2euykNA5Xw54HrHL9FMnsGzLRSRv1bkAg
 gQPD/kWsFDM+WtcQdNWDVuFPH8SB2MRDrPbInDFhD0A/2VeE5DCWczHBddMvjFlGmfft
 +RCA==
X-Gm-Message-State: APjAAAVlcf73SkMMC7unWwpLPR1fgVo7VvIrZE8Xjk9jmRCO4zG88t/K
 WwUTQN9YHpEL8Or3FK7yoSczGQJrGkYaFA==
X-Google-Smtp-Source: APXvYqzgD/s1gdInRtGdc+W1FrH6TKTKxzV7y49BmgqOXB3P33d6qDQhC/IEpRdAWPjpKrUdloa7qQ==
X-Received: by 2002:adf:ee10:: with SMTP id y16mr2158630wrn.67.1573040025980; 
 Wed, 06 Nov 2019 03:33:45 -0800 (PST)
Received: from localhost.localdomain
 (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
 by smtp.gmail.com with ESMTPSA id q124sm1776907wme.13.2019.11.06.03.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:33:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/12] linux-user/alpha: Set r20 secondary return value
Date: Wed,  6 Nov 2019 12:33:18 +0100
Message-Id: <20191106113318.10226-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106113318.10226-1-richard.henderson@linaro.org>
References: <20191106113318.10226-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This value is not, as far as I know, used by any linux software,
but it is set by the kernel and is part of the ABI.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191025113921.9412-13-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/alpha/target_cpu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index dd25e18f47..ad408ab5cc 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -27,10 +27,19 @@ static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp,
     }
     env->ir[IR_V0] = 0;
     env->ir[IR_A3] = 0;
+    env->ir[IR_A4] = 1;  /* OSF/1 secondary return: child */
 }
 
 static inline void cpu_clone_regs_parent(CPUAlphaState *env, unsigned flags)
 {
+    /*
+     * OSF/1 secondary return: parent
+     * Note that the kernel does not do this if SETTLS, because the
+     * settls argument register is still live after copy_thread.
+     */
+    if (!(flags & CLONE_SETTLS)) {
+        env->ir[IR_A4] = 0;
+    }
 }
 
 static inline void cpu_set_tls(CPUAlphaState *env, target_ulong newtls)
-- 
2.17.1


