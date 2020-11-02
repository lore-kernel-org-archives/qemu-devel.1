Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19508C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9770821D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZd8NMuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9770821D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdU9-0004lK-MG
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLu-0000zg-Ra
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:42 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:33263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLr-0006bn-Kt
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:42 -0500
Received: by mail-wm1-x331.google.com with SMTP id p19so1682060wmg.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bsOcsFLrF4fremZGGn3w83VG5q1zGI8Vc4YzNY5qHV0=;
 b=mZd8NMuIp7Y8uEC7FswrXDeZmqhrNudvI8saNzmXLja17vqXxGb70SGeJ5zPjE2Ny+
 I0i7vrUVXz+pyDbHAj4h1hGrynJxjo5QBm7PiEyONkNM25/5O9+dQQX1a64Rv76+bxkI
 AvnDnDEHAdyXlCLEOHOFmyAn3Mr5Qy6v4ChgeqWWl9xHyLcN5Qut8ARZaAgZQWj0SuH+
 do3Q9LDAjyFt6nFlZnAYRp7EHeSxbUBgBKJTTtrWIwEgaM6yX91luJzyuxUS6huwfN89
 7iEfG2w79azKuSxE3m17Hc6p1/HYzb/CdLzSgOVzgvwHCHxj97AA/Mm9D4NehtwW66Yl
 3M6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bsOcsFLrF4fremZGGn3w83VG5q1zGI8Vc4YzNY5qHV0=;
 b=ogDZ+IDMUrT1fciXRuuYPGDqwscvFwyn3l8Ci89e2/9bYhaL8v5mUP88CSIrniMU17
 laek17PhzjdzF+pwoJbiDhsQRGF6CQAnR/6ILGEyIuJp5j6bA4LwJaxB3lwRIYGoWmSz
 43j+QD7ebxabe8g8Fw5oKFJ9D4hrEG0D9OsMRf59rytkHsz519RIYA2zj3TmW/7w+oGG
 ER8pLL2O49QttQgKvLziXLC5c0YWhTvjz0xBJVkSlclNneHjW8mlYAy5DcG7bztje0Tq
 69/Xor5YySKlZmoHJHvjbQrlzVevqJu7qfqzgVLxsPndEVIRRiAjUX85tXWKTpveru28
 mhXQ==
X-Gm-Message-State: AOAM531OqTfvcW6HjumEzldtoHOF5GP1+0gN8qkePX3rE64UKDtlocbR
 ZT8HAJD68X50yijhedqF27UmMCcj73ATzA==
X-Google-Smtp-Source: ABdhPJxcTF40fn/fDUopkWFpxLfLL7gDtXCdecYKosuK0A9/gbWxGX7oHNq5AQE5SROfm3RH7zHRuA==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr8239989wmi.42.1604337037641;
 Mon, 02 Nov 2020 09:10:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/26] hw/arm/smmuv3: Fix potential integer overflow (CID
 1432363)
Date: Mon,  2 Nov 2020 17:09:56 +0000
Message-Id: <20201102171005.30690-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Use the BIT_ULL() macro to ensure we use 64-bit arithmetic.
This fixes the following Coverity issue (OVERFLOW_BEFORE_WIDEN):

  CID 1432363 (#1 of 1): Unintentional integer overflow:

  overflow_before_widen:
    Potentially overflowing expression 1 << scale with type int
    (32 bits, signed) is evaluated using 32-bit arithmetic, and
    then used in a context that expects an expression of type
    hwaddr (64 bits, unsigned).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20201030144617.1535064-1-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2017ba7a5a7..22607c37841 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -17,6 +17,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
@@ -864,7 +865,7 @@ static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
         scale = CMD_SCALE(cmd);
         num = CMD_NUM(cmd);
         ttl = CMD_TTL(cmd);
-        num_pages = (num + 1) * (1 << (scale));
+        num_pages = (num + 1) * BIT_ULL(scale);
     }
 
     if (type == SMMU_CMD_TLBI_NH_VA) {
-- 
2.20.1


