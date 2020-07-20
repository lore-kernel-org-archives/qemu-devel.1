Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057E1C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47B322B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7sQeBkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47B322B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVNp-0007DX-Uh
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 08:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLK-0002I9-W3
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLJ-0007IM-BY
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id r12so17645931wrj.13
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 05:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UtZqvEbX3cxeC7NPk3wMM6IqqBBRLSdFGXelit5rqZ4=;
 b=R7sQeBkB4v7fJwN+D9EW7ZFwHRDfIeEkd+AMoWDwU4hiahRueL1VdHb0V3dMpeBLNR
 cNeD2tQt3iONyzdRyHlnS/ncALh2o0SuFsRTwzH2CqvLr6OKf/U4iML2t1rM/z2amhm2
 HwGFEPWU5rrqc4hGVDnMLdXWKlXZ05LaK/dV4rPXWEZ/xjagGAe+Oy/7ZZenMIZo8gWw
 h2a85FhHcWLodHLQVsHYfTt2sWFHmSDEr+/eFEFjaGjPS7bZDnvZ4YGfeiNVaTohaZGw
 H4CM27tm2KGC1l0I69jBdpPRRal5P1L/NyN46//P7405rD0LLdo+zI14hzVq6+aQRbzg
 t0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UtZqvEbX3cxeC7NPk3wMM6IqqBBRLSdFGXelit5rqZ4=;
 b=LAt5jpUYvAdq++ViOGD5BJAE9kszAjZ8Ne0uAlsgncma8gKuyp8xP31GBiZZo6D1T+
 FPELxg4too31mThW79Td9qDKv6cZKlVS250WytbCYMKVeKtWgmGnObPsbHtNiXR6GroH
 eGBhbmPHOsbhVoNQI2BVlCHahFRN1nGbP9+5a2cxpfbyTEvu2a9vFxhIxHVkhzF6NKaP
 TiG80vUmsEhSIMatX4BFOGsYMnKrJK41dLfYqfB/BDZP9XyOBkaLQpOdBWQr8lnLVrzi
 OIwFof/5Ivo7bBvI4O1qky0npa59JEpKgd5OQ+jBPi0yz7Qsr6Hqws/PxwQn2DLlkrIo
 gJ3w==
X-Gm-Message-State: AOAM5323YylZTOBTBh/aiKOlBoR5vJ/pVJadk25n4uTx3I+p76sha7bD
 F7bBOwF3udU2XLuQw/xrVKCKT0cFa3gREw==
X-Google-Smtp-Source: ABdhPJyLpz9kOwfw+cL4JkKDOX6uJzETp4PRwUBWam5DwAB8L+B6Pj9YpWsaSVXxuJXg5o4dcYGzvQ==
X-Received: by 2002:adf:e690:: with SMTP id r16mr22802wrm.249.1595249787528;
 Mon, 20 Jul 2020 05:56:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p29sm34025403wmi.43.2020.07.20.05.56.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 05:56:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] hw/arm/virt: Disable memory hotplug when MTE is enabled
Date: Mon, 20 Jul 2020 13:56:12 +0100
Message-Id: <20200720125621.13460-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720125621.13460-1-peter.maydell@linaro.org>
References: <20200720125621.13460-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

When MTE is enabled, tag memory must exist for all RAM.

It might be possible to simultaneously hot plug tag memory
alongside the corresponding normal memory, but for now just
disable hotplug.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200713213341.590275-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a7f3d442db3..ecfee362a18 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2194,6 +2194,11 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
+    if (vms->mte) {
+        error_setg(errp, "memory hotplug is not enabled: MTE is enabled");
+        return;
+    }
+
     if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
         error_setg(errp, "nvdimm is not enabled: add 'nvdimm=on' to '-M'");
         return;
-- 
2.20.1


