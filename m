Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71020C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1FD2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EF6KphAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1FD2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSlZ-0000ct-6b
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSc0-0006TD-QY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbz-0007AF-Hk
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:36 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSbz-00079m-BH
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:35 -0500
Received: by mail-wr1-x441.google.com with SMTP id d16so22922393wre.10
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=aGWtB9UH19COcWMMvKkPVSBWPGm7CEQmDN4rSUNlND0=;
 b=EF6KphAzQO3fkApaFQGEtwbhBtB98NRUsuCDlwZz0qEtcvZerOL3wqYmqFbcslE8En
 eXtMIcb2EePX3ZS2+eK4v9NQuB3qKtMY9l5Xyx/cEPS5G/vNaHBj3h2gqT/iFHyyaaPZ
 z0AOy56pTX/ZRPfPb6XYklQcaCECEzfUHytAVLJXExDeZW7Sn2h4yIGzMTKxusZ3dWqW
 I1YWlU2hjtufcFvL0T7DKCKeQ75qS5eKhpl3JGKpQmIALvRvrzWkieMeZs/ySRvbosHP
 zj+KQcQGvBsJPqFnT7dbctsMXoqP3Wa/VRX5SAQzoAfDXbfqak0Jcbfr1/OSQ+imY/Qo
 Cizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aGWtB9UH19COcWMMvKkPVSBWPGm7CEQmDN4rSUNlND0=;
 b=aBD51bCrji2hRXud8VkWd8vPumKJIJ+WYFEJ1/T0KQHuabnzfldXfht0OlSyCtDjhf
 8yLbIj4de5eAIg4SXCV1TW9+Hzwfay2Dkyu9e/FjF9qutm6W8gJdO95tmYN3/Xc/GzgL
 Ukv3DA52foE1qGRB63yDq0aaFisZisy2k0PA6ctTKAnhMwXN47TXcda/v/D1sGxxxJug
 ua9W0eQYj49ktj0A5SWuwdoQGtOl2Ij0fSwLEHrgoDCTV5FRMysEuRTrqACBMSOrIeO2
 lTN5UOd3LWpEqRzVemiL2E1vk6vjxylUf4CIyapxFGyatqyI8d/Aw/FJIeZWfuMvR6n7
 EKpg==
X-Gm-Message-State: APjAAAW4eEh2l7Kv9ULVR0u2XMfmeDU/GbTdRJppHABvlC1dhN2a3DjD
 pTFQ90lMHPujaA5c+Ed5RY3wLfRpQUA0LQ==
X-Google-Smtp-Source: APXvYqyRiqp0D92R3bBAgA05A+J7MVZ+f8rDoh6gRsubisHfzXo/g/xDsBDe5eSBe1kQz9hO3VFO8g==
X-Received: by 2002:adf:eb09:: with SMTP id s9mr3358325wrn.61.1579271314127;
 Fri, 17 Jan 2020 06:28:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/15] arm/gicv3: update virtual irq state after IAR register
 read
Date: Fri, 17 Jan 2020 14:28:14 +0000
Message-Id: <20200117142816.15110-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
References: <20200117142816.15110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jeff Kubascik <jeff.kubascik@dornerworks.com>

The IAR0/IAR1 register is used to acknowledge an interrupt - a read of the
register activates the highest priority pending interrupt and provides its
interrupt ID. Activating an interrupt can change the CPU's virtual interrupt
state - this change makes sure the virtual irq state is updated.

Signed-off-by: Jeff Kubascik <jeff.kubascik@dornerworks.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200113154607.97032-1-jeff.kubascik@dornerworks.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index a254b0ce875..08e000e33c6 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -664,6 +664,9 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
 
     trace_gicv3_icv_iar_read(ri->crm == 8 ? 0 : 1,
                              gicv3_redist_affid(cs), intid);
+
+    gicv3_cpuif_virt_update(cs);
+
     return intid;
 }
 
-- 
2.20.1


