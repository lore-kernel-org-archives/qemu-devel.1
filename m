Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46091C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B415121789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wuqsaS5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B415121789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQX1O-0007Cs-Ql
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWry-0004CK-7P
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:10 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:55618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWrw-0005yj-Gz
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:09 -0400
Received: by mail-wm1-x336.google.com with SMTP id d4so6649573wmd.5
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Cib7h5O8hVbj+spr2llldc/VxswC85k/oqNZL/L3+bw=;
 b=wuqsaS5Og1u/eW9LszG31h+NHB5rtFm1sm747FDgLlMdpXRhlGKbtkbcPH5f/QrbOb
 3KEc+hFhfcywF7+FjmcYoSzadN21ECEv5oPLK3g4EAiN74CK16DnuRHNMGrYr/vT+4a7
 yvs20zt+4DanpJVR8vLDPcOzSj0kFBkRCjs97lblwkGSnw1+liv8vMc8TuYxIlL14z+9
 EIy4wBLMRKakzSOFEtwzO14Umio0RF4ZAauzSld8y7kf5/fNkyZ2qg1OS61Kvd37OmWa
 gjYu+hJXGI7cQ7aMJNWp8Ffl7avKWSduil6wBWjSP5/25/uuSZR19sYTMd6YMV3yHLZT
 mDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cib7h5O8hVbj+spr2llldc/VxswC85k/oqNZL/L3+bw=;
 b=c/OWRPOWe5p9owCdaqTePKJ9SK5NxtnB+cd3ebUhsZoSjj/Mu02uH2a/cr9qKrP50n
 h+HFieT1C4UuJSj57HCDvdJZbMJO+g2wxZ9DUZB9ZGR6Zm5WbqT0L8MGju0DIrFKvSOJ
 6Ez11YR0UGbr39C4ATv87L8Xzvffl1+micKPZJUlM6JUex0muXQM5ionCW64cYa3c2jG
 uCwDTM1IxuJeFrN/znrDi9YPzgrZOBhldEGpXkhtscooVAY8mzxxgQtQOo/BMGawlCNN
 SH2TtDtBtXB2NqI7wlSTb8FHmdolOYlDpA1QV2JxCC23hFbIjWLZZECUF1DbeCMXgxrB
 LHHg==
X-Gm-Message-State: AOAM530KpRBipOJlxpXl3r5TCv3gQRBbJd7sH9ST8AgAwNPygV44rRlk
 6LNzVLBrheEp+pLmHYH16symF6hvwQrLdXTH
X-Google-Smtp-Source: ABdhPJyaA+NOFA9UvQHBfpBWGYoFUk8Cvi5jc2e9EnVOGjnlRbAsLwovsHDldtd3zLWSDZIf/VqQZw==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr9082696wmr.179.1602167166653; 
 Thu, 08 Oct 2020 07:26:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j1sm7905104wrc.28.2020.10.08.07.26.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 07:26:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/12] linux headers: sync to 5.9-rc7
Date: Thu,  8 Oct 2020 15:25:51 +0100
Message-Id: <20201008142557.9845-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008142557.9845-1-peter.maydell@linaro.org>
References: <20201008142557.9845-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Andrew Jones <drjones@redhat.com>

Update against Linux 5.9-rc7.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-id: 20201001061718.101915-2-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-headers/linux/kvm.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 6683e2e1b0a..43580c767c3 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -790,9 +790,10 @@ struct kvm_ppc_resize_hpt {
 #define KVM_VM_PPC_HV 1
 #define KVM_VM_PPC_PR 2
 
-/* on MIPS, 0 forces trap & emulate, 1 forces VZ ASE */
-#define KVM_VM_MIPS_TE		0
+/* on MIPS, 0 indicates auto, 1 forces VZ ASE, 2 forces trap & emulate */
+#define KVM_VM_MIPS_AUTO	0
 #define KVM_VM_MIPS_VZ		1
+#define KVM_VM_MIPS_TE		2
 
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
@@ -1035,6 +1036,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_LAST_CPU 184
 #define KVM_CAP_SMALLER_MAXPHYADDR 185
 #define KVM_CAP_S390_DIAG318 186
+#define KVM_CAP_STEAL_TIME 187
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.20.1


