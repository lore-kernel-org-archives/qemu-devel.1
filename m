Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA56AC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846CC206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlUw0mvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846CC206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaOK-0003xA-JN
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHm-0008U9-ES
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:26 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:40556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHl-0000qx-JL
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id u16so8806042wmc.5
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zmzHGE57MukSIkxK2mquJ8on6NKtjOsBN0YXeedCzVs=;
 b=RlUw0mvBNdW2pse5ZDT4I8BFCa/MUCC9crqP82770Toa3mu4csgSsfGPkB23Jn+ncF
 Hu742pV4hIVmWaSemYcuOP9zsNgKF6IQHDWG50wOWLTSvvJBg5g0LmfQyxxJ1e+Vtftc
 W4Rd1bfSOc/b81tRxWhEzWNckqjFvckg7MuBYe1Lw4BUmDCYbdPxg6btbyVfWgx/0yYN
 su0WMPHLbma/jTjvQDkFm4U6J0ktlKIYb2FWx2XgXjIHr6XtX/O3D8/5QLGyMOMYcZq6
 MJ78/VUZRHRursGKEfY167//b+MjlsWL12BRCUNo1nxeA8njUrgpXc/HqFc6JJh/2pHw
 NpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zmzHGE57MukSIkxK2mquJ8on6NKtjOsBN0YXeedCzVs=;
 b=XX/AjiehDvRZ1tFXbwS1VOW2Lm+zYepgBn701+iFHWbTLjtFGXh7dIn+rsc7KK3f1E
 cJgHM0DUSkJUA7Crqe2Q7yuQnvM5bL123EmerN0bAedtpB5Fu0EdR+3L9jxaK3XX1Ddg
 ne2JqOYNCxcdBB7lSFzwPdNiWYxYgEH9Um6sc7O7qSPqsC7nVLlIXi+M84NsO0gHRTcm
 8/RiLQtmsfT1S5W75cq2nlwwIDgKxrNmdqLMFMfz1icomsoLcELw4OfmFsux4adD6ikj
 fpZxrW7VnOGq4bQGSg3p3QTtN6TmumkmftHFURp1LXg6UlDhVLq/SN2NyVhoiJADCjTR
 FSFg==
X-Gm-Message-State: AGi0Puai2jGvr2f8CzQkaT3mkBr1Wrc4203pbMK0X05aqUj1YtV8gtsK
 CeLXeSPLd47uA/j1fDgKlAC9ehGYwe7ExA==
X-Google-Smtp-Source: APiQypJpwDU1J5eCS1QDdhpT50YhqE/Idc5mFD1ZJRDPPzrNp1Qr7NGpMjdTZZPoiJr6wWf/SaTt+w==
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr14206276wml.82.1588595603974; 
 Mon, 04 May 2020 05:33:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/39] hw/arm: versal-virt: Fix typo xlnx-ve -> xlnx-versal
Date: Mon,  4 May 2020 13:32:41 +0100
Message-Id: <20200504123309.3808-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Fix typo xlnx-ve -> xlnx-versal.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20200427181649.26851-4-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal-virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 878a2751400..8a608074d15 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -440,7 +440,7 @@ static void versal_virt_init(MachineState *machine)
         psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     }
 
-    sysbus_init_child_obj(OBJECT(machine), "xlnx-ve", &s->soc,
+    sysbus_init_child_obj(OBJECT(machine), "xlnx-versal", &s->soc,
                           sizeof(s->soc), TYPE_XLNX_VERSAL);
     object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
                              "ddr", &error_abort);
-- 
2.20.1


