Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F730C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA70207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXDcmHWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA70207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorJa-0006u1-Ip
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDL-0005Sm-1h; Fri, 26 Jun 2020 12:28:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDJ-0003Km-83; Fri, 26 Jun 2020 12:28:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id a6so10090591wrm.4;
 Fri, 26 Jun 2020 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2FehWZv489g7gLp1IpuJgAw0ELgG4HGTfqwfreEPxtg=;
 b=vXDcmHWou/Bj8r0kvmNmPomx7yO6hR73iJaBzyHMZTu3VQxDsQChcnbyiL0M+WBzSe
 1Zh84v7azNUqHyWG+faFWp4tlWFpQDonagRDY966Tsk8MH+B71gz//zuTY5Ud8ORyrcM
 c/ICK6BcEbmAV2MsxxnUX2RmDhDYDcMP4DAt/gwk5DvRvRelI//EEv+8XojRUeRzQcfz
 CwR9kv5xJb4T1D10uzKyzzhU1uMfmeI4O+THdbB/IUuLFgvbjuVRpkn/dDwZe42EHWvs
 dyfAicZEJtm++fA2CcqLVy5TOCyRFSX4waKlwQXKHEFMTBXTzDfU4heVwe+M30uVatVx
 sy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2FehWZv489g7gLp1IpuJgAw0ELgG4HGTfqwfreEPxtg=;
 b=s6IiQuDRMsG0OOD/lH3YRETq20lwrDVyYS+xkJcmSC3A1PxOKpdVBI7ij+QqK7dh4/
 StUpr0ZaWC8sRVkCF0PEl29sa57ajBQEcr9lPH+bfZOIuAYhNMGpbJCBP9NN8HYBBBIp
 Kup0h8fxtRyC0lX0BpaRSAnf0t2pIz40ZtKNUk2MN1+Aq+lVWc8sG/cYOMk1Whk468Xk
 XtXZ9G9eYVSeymX6lpn5YlUf4BcxQNHGR/a9nPtZKyNcTENRnMC9FOw8mjx+UbVUEF6L
 cV9XpHlc6T2pjSoLqKS1mfblcfpc++lCq6MknGC2VeDzjRT8zfjIzSbRYaUluQA4E6B8
 SW8Q==
X-Gm-Message-State: AOAM5326rqXXntJG5/qAbwOPDcmmXmn5N2zcs8FfOnwL1gE79DFztXyt
 DCNSWstsKHw2ZQukj8TfhfgMg4+T
X-Google-Smtp-Source: ABdhPJyQZWOj7gN5p9VbLJrviZQT9fLo53LhR3zYdorhxD8yZi8UXmcJoKYEQKy+soR9Jt/e1JNWcQ==
X-Received: by 2002:a5d:5270:: with SMTP id l16mr4567462wrc.122.1593188907361; 
 Fri, 26 Jun 2020 09:28:27 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 12sm4867255wmg.6.2020.06.26.09.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:28:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/14] hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
Date: Fri, 26 Jun 2020 18:28:10 +0200
Message-Id: <20200626162818.25840-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626162818.25840-1-f4bug@amsat.org>
References: <20200626162818.25840-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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

Only SCSD cards support Class 6 (Block Oriented Write Protection)
commands.

  "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"

  4.3.14 Command Functional Difference in Card Capacity Types

  * Write Protected Group

  SDHC and SDXC do not support write-protected groups. Issuing
  CMD28, CMD29 and CMD30 generates the ILLEGAL_COMMAND error.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7e0d684aca..871c30a67f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -922,6 +922,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         sd->multi_blk_cnt = 0;
     }
 
+    if (sd_cmd_class[req.cmd] == 6 && FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
+        /* Only Standard Capacity cards support class 6 commands */
+        return sd_illegal;
+    }
+
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
     case 0:	/* CMD0:   GO_IDLE_STATE */
-- 
2.21.3


