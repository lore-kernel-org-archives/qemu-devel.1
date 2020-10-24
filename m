Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF30EC4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 01:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB80522272
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 01:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrkpUm+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB80522272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW8i6-0004XP-VW
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 21:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kW8hK-0003yS-36; Fri, 23 Oct 2020 21:50:22 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45854)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kW8hI-00017J-IE; Fri, 23 Oct 2020 21:50:21 -0400
Received: by mail-pf1-x441.google.com with SMTP id e7so2820623pfn.12;
 Fri, 23 Oct 2020 18:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KUa8ua5YuGfWsHWpW7218Ha7emqQTAdJ1paNsVxfgSI=;
 b=CrkpUm+YwLHtPvOvvPfhsgXm57tE5K7hAGJ1RN0CENTu4xVMa12jvIqIv9KLvAdxoh
 gtkHKvnruhmx70fxIRFQLxVlqmDoUCw8w4zeR+2souH6huXOiz6oAhQQXnaU6rxyofxz
 MDCwnoU7vl+bSbFh6h0BWpxQDDypbOQH2Z1OSJDYbtrsYxjyoOVkWK9F2+3F07DWdAPp
 kPRHmPUy57yi8b+ljMonEAls5+7wgtxRnaE2PpHxfuS8hrt5d/IGYB95EAMQ41o0AOH5
 oaQ/wlIRz9eg/DieWIGWClTI004ywsDOIGcoBuWQWf8WMQGF/7ly51GekqUqVaALzPz7
 63GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KUa8ua5YuGfWsHWpW7218Ha7emqQTAdJ1paNsVxfgSI=;
 b=PY3bz7yWp/UZNmJU0aQY8pH1e7JAE8GK+CCsNsr6+JNxIUS6ind5gItkgi5XVZbrcY
 TPi8EuHtB0CwjxpwTg21miM+5RZyEbvA2fPnsJiEjmgGmame6kBEJB0+PxYQpeW/oC44
 o0ZyueyRI3zmF4JfEi/HLiUn1AU/XFpGxjAn/NxPuhOLEusypXhKxGlMf9ycHhQ+OyAy
 z7knnHHThiiwW8d3nVknO4NaULCkIHPkIZUXG5sCdvHHI62kG9MRb8ZfP7gYtCHOys2V
 pS9dSseAfzV/dF04JJVXae7Lim2YM8ewxHFdFZf8ncsxSi6ML/JrP8/kwkkJ9TPnH5c4
 cxOQ==
X-Gm-Message-State: AOAM533ig1FbzO1qbkQGkjYpMdHH13QpY9TRSPsXfIkKWVRrx9rSK2xR
 7iPkhy409iZul9fLSz5iL4k=
X-Google-Smtp-Source: ABdhPJygImpEKZbLAHqEKbMPNY8iZXx0slFSMVy63FJ/wd9yKqBcYi3exEtpNBxiM3zTfKabFkN2Mg==
X-Received: by 2002:aa7:9424:0:b029:15d:5340:83b0 with SMTP id
 y4-20020aa794240000b029015d534083b0mr1890449pfo.73.1603504218737; 
 Fri, 23 Oct 2020 18:50:18 -0700 (PDT)
Received: from Intel.localdomain (144.168.56.201.16clouds.com.
 [144.168.56.201])
 by smtp.gmail.com with ESMTPSA id q13sm3515900pfg.3.2020.10.23.18.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 18:50:18 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] hw/sd: Zero out function selection fields before being
 populated
Date: Sat, 24 Oct 2020 09:49:54 +0800
Message-Id: <20201024014954.21330-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

The function selection fields (399:376) should be zeroed out to
prevent leftover from being or'ed into the switch function status
data structure.

This fixes the boot failure as seen in the acceptance testing on
the orangepi target.

Fixes: b638627c723a ("hw/sd: Fix incorrect populated function switch status data structure")
Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/sd/sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c3febed243..bd10ec8fc4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -824,6 +824,7 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
     sd->data[12] = 0x80;	/* Supported group 1 functions */
     sd->data[13] = 0x03;
 
+    memset(&sd->data[14], 0, 3);
     for (i = 0; i < 6; i ++) {
         new_func = (arg >> (i * 4)) & 0x0f;
         if (mode && new_func != 0x0f)
-- 
2.25.1


