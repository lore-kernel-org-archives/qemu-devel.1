Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A2CC33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66D5205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDYWcW9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66D5205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixycA-0006Cq-0s
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySs-0007rC-F4
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySr-00073S-GA
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:58 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySq-00072N-Ow
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:57 -0500
Received: by mail-pg1-x544.google.com with SMTP id q127so5484362pga.4
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6o/uTqZDgskKImMCIDRtOPtsiJkqQrRQkaycCllMO/w=;
 b=nDYWcW9qbUqnb9DTbtrc4hGb0pgHjRIT6uFUczq6Wcg559NmlA+ARDjPXVy184fIP7
 7m6Ju7sGc1v1U0rLPtAV4whOQ49SovByILP/agSBY21caYg1uR/ypCvmzsYWNLDROejO
 +nlcWL+XuJY3v3YMLOLneJNqd4HF5dls3sbdbL4DZZZMODX4iZaH1mxb0zlKOu5U5vl2
 iJplUhruQ57voy4Z9c+aLTJObPPi7bV+bwq5h09UdKjDQOPYchffjMkkU6yEQwk0MT2+
 gY9Q+TP8BiVdbIIjwmyF50h2UvMJmfgxB2KYTe6YqTcnmafb5yS7ttCebD+2EfEY/h/t
 36cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6o/uTqZDgskKImMCIDRtOPtsiJkqQrRQkaycCllMO/w=;
 b=fXCSiOd340ZsLHef8brosolaOt6CByLQVbz9f4/hMoXVIIkgNbAkFt9mNApi8p5ams
 d42/Bo0UlDz45aI55/ZcDHkL9JZAUVK2psTxIo51Ikm+8COFh/Ue5REu2fK+BYfxUyxU
 UHE/gt5kseG6+QBNLPp3zyK2HGeXXd0S/Qi1Pa8zliwSXvlIsYS0vmIGAPcNBFv44U6D
 5br04VTDIfMJemuxUvjzly546iMqBEAtfw8tQxnZxq6yjK+jEEoemE8b5lCn4+tA0ztn
 Izp3s5KLOeSFzWdAPq3he2MvbLLj2mWoFF298vFetdW1G78Q8i4Laea66M6RaKoF8T6m
 nbUw==
X-Gm-Message-State: APjAAAVwozSz7CFIU01yeH2uJSGQ7mChz2lQMPQJl9JaTUMKFM03kuLm
 Gq4M0TODvIDCu8oia96aOYcR8YspkLM=
X-Google-Smtp-Source: APXvYqy/1J+wgRC/8xLqd0OH8RbrboBYKxgBxyCL7IG07kEGGUqgCuCwDWbnbu7ggNb2TnfAe24+ew==
X-Received: by 2002:a63:4b24:: with SMTP id y36mr16677131pga.176.1580585395499; 
 Sat, 01 Feb 2020 11:29:55 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 32/41] target/arm: Update arm_phys_excp_target_el for TGE
Date: Sat,  1 Feb 2020 11:29:07 -0800
Message-Id: <20200201192916.31796-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The TGE bit routes all asynchronous exceptions to EL2.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0e2278b5aa..c239711641 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8455,6 +8455,12 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
         break;
     };
 
+    /*
+     * For these purposes, TGE and AMO/IMO/FMO both force the
+     * interrupt to EL2.  Fold TGE into the bit extracted above.
+     */
+    hcr |= (hcr_el2 & HCR_TGE) != 0;
+
     /* Perform a table-lookup for the target EL given the current state */
     target_el = target_el_table[is64][scr][rw][hcr][secure][cur_el];
 
-- 
2.20.1


