Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA7CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3730B207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VroG3sCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3730B207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorHD-0002sC-4K
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDM-0005VK-0E; Fri, 26 Jun 2020 12:28:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDK-0003L0-FM; Fri, 26 Jun 2020 12:28:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id o11so10071932wrv.9;
 Fri, 26 Jun 2020 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q2Dr1F51NNYfRmDxzHUuA6aQIgYrZuE2BYPtrlUH9Ok=;
 b=VroG3sCX/GnrLSwQZyFwBa0QNsHOJc63q3kMy5xidet/I10niuuHM4+GbfxDY6bPj3
 uVlwbgNnCF9Oc6l9At+TAzInU6KmYaygcwZJTs+x+vcxyNR8EgSmyuDPChNXtMQ/nhRg
 Bss9vYilFCEoGztyEeToLfFSeMj6SRxOVtT/d0YMu8pGJRqyBMlA2/IJiP9nLcQVBSWX
 85h7jC1Z2FdOTzfdAlPy2DH6/wbAqwvODFC9klvOSWRz20gFP03c7UcNbKIQjGROP2cs
 YFYSpdbuudYMb5oWJvzpBDa9/jkGb60sSITvHAt8P1YmTkPC+zckHoiYzmmLyg6MxPkl
 T2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Q2Dr1F51NNYfRmDxzHUuA6aQIgYrZuE2BYPtrlUH9Ok=;
 b=iJXbOfLLLicLS3Jwbc/yiaeu4pIKM8WhStdTCJ7EXDMF/KM1GzXiQN0FQ72dLBKI/C
 fGDgQ5MeEGKkROnrPSt3f4+DkZq59NNOE1ThZx5jGmQXG3YL9TJznjxvzPSfcLgzOgkm
 FQxzltTgkd/45OT18Ck25yYsts3puReU+WSWCppPTX7uZEyqXvEv7FGs7FWFnk/TcpTc
 K8WFj92XurvSEUdkpdKuDKppS7Dlsu2O65c8fa6YfMRVV+1R0RxIydJtFBZTUQuBo5UM
 QNYFiMeXciPgC12aLROTDpm54BjSChXIxF4eXxZsuELa0EBB1JvT7UOfwFLdWZfCvPw/
 Z7pg==
X-Gm-Message-State: AOAM5317kjIussgr2tfXcgouCUboUWc3ppc3wQc+o6LuufeJrKuqW0DT
 ZklO7ipNdXOOoKkqQ/Qw3Z5s7EQs
X-Google-Smtp-Source: ABdhPJyXI1Qx63Ng1eXKV9TBY7Rb3I/mcn0N2ie+3C6ugEEu2TQq2x9NTHMaNNrQXHSdFUB3vB2kHw==
X-Received: by 2002:adf:e38d:: with SMTP id e13mr4561001wrm.304.1593188908619; 
 Fri, 26 Jun 2020 09:28:28 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 12sm4867255wmg.6.2020.06.26.09.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:28:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/14] hw/sd/sdcard: Check address is in range
Date: Fri, 26 Jun 2020 18:28:11 +0200
Message-Id: <20200626162818.25840-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626162818.25840-1-f4bug@amsat.org>
References: <20200626162818.25840-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As a defense, assert if the requested address is out of the card area.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 871c30a67f..0b606e9054 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -539,6 +539,8 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
 
 static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
 {
+    assert(addr < sd->size);
+
     return addr >> (HWBLOCK_SHIFT + SECTOR_SHIFT + WPGROUP_SHIFT);
 }
 
-- 
2.21.3


