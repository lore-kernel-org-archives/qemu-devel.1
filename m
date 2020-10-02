Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADF3C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708B7206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNzO/eOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708B7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOG9K-0003CQ-79
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 04:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOG8M-0002LG-9I; Fri, 02 Oct 2020 04:09:42 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOG8K-0008HQ-S3; Fri, 02 Oct 2020 04:09:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id o5so714698wrn.13;
 Fri, 02 Oct 2020 01:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T2KAyG9+GcnWb+hQJRM2BaLdbK3udo5BOAO1tzVT6Qg=;
 b=PNzO/eOGDc7X3YLvqMbuE/63cB5ZTHcUJXofMZ9/m2QgSUT1VNQZDbMQxvW2hRapkW
 FOB42j/7MsC8q4AUWOyk0LXjBL3kAqshH6a1lviDCkDAaOSwrAe7rL3LwXoCUkIRbCQr
 jks3ZuKYu1+ASEAKOmJ692WNcLhWHOWxfnKvKpIgYDViSJucKyX/HU9thN/cpSS8uKep
 bOYO21tUyb+T2hd89Eb+P1y4gBBtXOafMMfuqhzQLl2b3mnbCL54CpCs6Qsy0s7Km30m
 pDyNmZdS2/cCeTf0FwnxZmub189Oe+K87D2z0pyTwZy+SDcPw+Rp/pRWKueQQmC+SWGh
 s7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=T2KAyG9+GcnWb+hQJRM2BaLdbK3udo5BOAO1tzVT6Qg=;
 b=FxsYhc5LX1D8isyQfBc8haQVrE1WNkfSnuR7csFd6c9joYTWjIxKbkrOFHZxFroMRq
 a4aPgDl920bHK7L8H+YFcj90nAA5iw5z6GVWX+0S7MQtscEVcOHeHvEsdwfTq3eW+im9
 GpzNbBKN5dUAt6ElitcmWR75nUswdxeXAUm9NTjqy3syUAKifTL2niM+CMwSwGUv8wLt
 uSVXRqKWYB57LilPd22kxhsWUEWhLJSAyJrkxUEYvoWqyC21Zv5WZYs7DcfWAeYV8fIN
 7EqWkmgtPFmVm4+qrUSOolzuouXneIU/kAMOT3YuB8AA6jQtuyxtYlB6nn4cVrkUjQdI
 PibA==
X-Gm-Message-State: AOAM530Mk7Mu84CKH0QaB7KuqUHgwrQ9xVhOZsId82vom/weY2UP8Dzx
 XiHFzh4X394IJit3O2cxRtZeB+QPyvg=
X-Google-Smtp-Source: ABdhPJzEM8ZFvjX/uiTI27DM16nhmTSh4YFta/YMDG9oNLM6c629d5QCpD8AXCSGdBYdfrOWMiH6OQ==
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr1554020wro.362.1601626178249; 
 Fri, 02 Oct 2020 01:09:38 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id t203sm838508wmg.43.2020.10.02.01.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 01:09:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/fsl-imx25: Fix a typo
Date: Fri,  2 Oct 2020 10:09:35 +0200
Message-Id: <20201002080935.1660005-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/fsl-imx25.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 971f35dd16..c1603b2ac2 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -179,7 +179,7 @@ struct FslIMX25State {
  * 0xBB00_0000 0xBB00_0FFF 4 Kbytes     NAND flash main area buffer
  * 0xBB00_1000 0xBB00_11FF 512 B        NAND flash spare area buffer
  * 0xBB00_1200 0xBB00_1DFF 3 Kbytes     Reserved
- * 0xBB00_1E00 0xBB00_1FFF 512 B        NAND flash control regisers
+ * 0xBB00_1E00 0xBB00_1FFF 512 B        NAND flash control registers
  * 0xBB01_2000 0xBFFF_FFFF 96 Mbytes (minus 8 Kbytes) Reserved
  * 0xC000_0000 0xFFFF_FFFF 1024 Mbytes  Reserved
  */
-- 
2.26.2


