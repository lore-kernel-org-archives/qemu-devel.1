Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA703C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F71420872
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="Oho8NbbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F71420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6PR-0007h8-5F
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kQ6MU-0005Sh-UG
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:07:54 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kQ6MS-0004Uh-Nt
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:07:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id l11so1679698wmh.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 03:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BqNDRb2steS2WJ2AjGexGDlC3vfLL/j0O8907rJNfVY=;
 b=Oho8NbbXTyjx5t4FLG772eAwBA2m1fV66DeXs0Tg/JNLXXXFsfyfIXPk55/hZNq7Aj
 cqikVdYp3Ch+Xevkhvb+/l2yZSo2yVFa69iYbUcf+qSIVVbSUMrHURyp7mVjyCnIOPjW
 80pb1TTQarflWzj0iYrarqu4/Lg2uVcxAThymXxNsgFNQUvz8wocvYt1m7bdmxzT2hOz
 M1WROjqtgSlnTqYXargelQImOCIsJgfblJA5RvokddpAJgbUSp0dYFQMKiVKO5rCvETm
 Qz+O+ISE8JEaGgT1MHMJHUmwYEtTNKA80owNMiW97aS/sC2QX2llJbiMgALa7JKkZ+dW
 UFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BqNDRb2steS2WJ2AjGexGDlC3vfLL/j0O8907rJNfVY=;
 b=eAVawoUT41jFyobqmQeIZqyfJpjYMTcqfVcpd9mnoF7AZtRYGjJMD7nsN2xKnlLmD5
 9cJ5s3TX3udd1p/jZcjwWkc2k094mF2PC2VvxbI76O8XysySGUnd6qBy/b6Jo/F5F7CJ
 XGja1+wvzfp+8UjCn94yybYh8VUcFdmL7jmbVMSMWMGi9WQuHAeWLcMet1EBxOTLopwF
 058ACJM4XYRdSz9Jlozy+ZUPbO8VMYOkp1IQWxzbOGX2A2QNx6U/uP1rGHgHs9mgJ5Ia
 PqU/ST1+L00WQ6W02rG0DwnvR1jxbQFSLyj9XRkNjmh3WcwiMKCosaYDlF9gIs0KGRNU
 4nKA==
X-Gm-Message-State: AOAM533QbDQCYdQkgMFKEvpT6cZywpNcW7CXNEgZS5kOj+lVzfQKDhgy
 rgbOaIx9q6Lx38uSq4yDnDVfKA==
X-Google-Smtp-Source: ABdhPJw0PJmJYTNDF5TtDVDDiekJmgLEevdt131BwUG11ZuHrSiF/6LPVtiWDhqUxW4g/l25A6WoAw==
X-Received: by 2002:a1c:bbc6:: with SMTP id l189mr2588480wmf.52.1602065271293; 
 Wed, 07 Oct 2020 03:07:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id y6sm2208504wrt.80.2020.10.07.03.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 03:07:50 -0700 (PDT)
From: Graeme Gregory <graeme@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: [PATCH v2 2/2] hw/arm/sbsa-ref : allocate IRQs for SMMUv3
Date: Wed,  7 Oct 2020 11:07:32 +0100
Message-Id: <20201007100732.4103790-3-graeme@nuviainc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201007100732.4103790-1-graeme@nuviainc.com>
References: <20201007100732.4103790-1-graeme@nuviainc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=graeme@nuviainc.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Graeme Gregory <graeme@nuviainc.com>, peter.maydell@linaro.org,
 rad@semihalf.com, f4bug@amsat.org, qemu-devel@nongnu.org, leif@nuviainc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Original commit did not allocate IRQs for the SMMUv3 in the irqmap
effectively using irq 0->3 (shared with other devices). Assuming
original intent was to allocate unique IRQs then add an allocation
to the irqmap.

Fixes: e9fdf453240 ("hw/arm: Add arm SBSA reference machine, devices part")
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
---
 hw/arm/sbsa-ref.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 65e64883b5..01863510d0 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -133,6 +133,7 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_SECURE_UART_MM] = 9,
     [SBSA_AHCI] = 10,
     [SBSA_EHCI] = 11,
+    [SBSA_SMMU] = 12, /* ... to 15 */
 };
 
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
-- 
2.25.1


