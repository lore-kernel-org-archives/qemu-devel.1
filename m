Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63DAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B8520663
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZT0kiUc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B8520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgHzT-0005dY-QO
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHy6-0003HL-Oq
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:22 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:33855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHy5-0003U9-MN
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:22 -0400
Received: by mail-pg1-x52e.google.com with SMTP id m1so586101pgk.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OzobXxmD62KwDEFdjrZjAAighBDtrTCRu38jKjN27BM=;
 b=ZT0kiUc1Ujlo87PPHi9f6LpaacySTV6JqK01cnZQbuxrdlllwF9L9JfwR+IPMtpQo9
 eXepl4920HFBg9PcADbYfdDMUiWrkAwB7miHPLicJPYoAfuA5uS+IBaNwiIz2GEfyY1N
 4eRMidlP2GNbGI9eliSbGzrbmGcDK7vInBFbC+LRLj6jICk16fXlncNUg+S6sNQ5/9pv
 xNRQTzxw5/TyCq7H9UFqX0eN+Ytnwn/pF/qHy/jc0iQ/HkwY2g32D/17tWj11D1Mo/CI
 YJrw1KFUk4VPlKKYqqi2PAIdVi7RY4DsjNQYdB9lSH4/EuHR8td81wRKHGHoA/adcsX8
 AWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OzobXxmD62KwDEFdjrZjAAighBDtrTCRu38jKjN27BM=;
 b=o4rhejfAeFClj0kSvyfi5RKNWS8cc1oOscy1XNLH0qunjlEgJLqLyhFTf8BVZnxu9l
 5GJcWxWO4wC8or9IT2hAmjLkjr7LhefgL0jMcgtx9Lxam0oR/w/nAlpG5/x+s6DXucu7
 uIIDuYGPq8y31EwDhAkQI/jQqHYG7AdSO96SjSdLjNmo+hhEOm7XoNYWGJ+SSD8KRWb1
 zgLv4tH/mRacJ2BzA5O/TQ2/ZsrXChfk5UijCj8E0wN26Wm+1ruJRIJ7QC+OynOlkzEj
 yev22gSmrRoiDpDHKvaBTatNtoqxHmMCBSCP5CS1sGUsRjFiw/ehggL3uI0rM3gV1xYw
 Zx+w==
X-Gm-Message-State: AOAM5323P+XBqa9CwkAPMfyZPNQhheCEUby4qWHKA1Sve7qi/i0urs5S
 MBVRRj/gpnRdX/HcvklGH3PeTa9ePGU=
X-Google-Smtp-Source: ABdhPJzhAOKkxgSbSgyALawtkt0ttK+FmQGpB3x30s4TMGOISjzFEePc2/MGopqxNXk6ID9ZIXA6ag==
X-Received: by 2002:aa7:8b56:: with SMTP id i22mr20028587pfd.63.1591146800024; 
 Tue, 02 Jun 2020 18:13:20 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 01/42] target/arm: Add isar tests for mte
Date: Tue,  2 Jun 2020 18:12:36 -0700
Message-Id: <20200603011317.473934-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 677584e5da..f8ac11e73b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3814,6 +3814,16 @@ static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
 }
 
+static inline bool isar_feature_aa64_mte_insn_reg(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) != 0;
+}
+
+static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
+}
+
 static inline bool isar_feature_aa64_pmu_8_1(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 4 &&
-- 
2.25.1


