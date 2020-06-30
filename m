Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AC5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4F22073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZc2yj3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4F22073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDCY-00047O-Re
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7K-0002Tn-Aw; Tue, 30 Jun 2020 06:03:54 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:37885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7I-0004dI-Lj; Tue, 30 Jun 2020 06:03:53 -0400
Received: by mail-ej1-x641.google.com with SMTP id lx13so1241187ejb.4;
 Tue, 30 Jun 2020 03:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2FehWZv489g7gLp1IpuJgAw0ELgG4HGTfqwfreEPxtg=;
 b=CZc2yj3rRHmUKsdZ8q5lEUQ9/BSmJRv4oTy85kFlRGlTFpmcKj7Gl9WJGTKGAKAbu0
 UPrINk+k2ucWASQo6917Lqnwm2e+lsnkJkv32Fed6JfV9eJWdwivnWiihMNTn+znAteQ
 oITiMFz1ct6B/s4jSRyhtpRte4t5oym1sqAp0YKV0tou4BEZ3Hz0KLpb3QWzk6ExspjT
 CP3lIUY1p0dPiWgJgTxAt5t8g+e2+hM3lgd88vRV6W0aR/0STnI9VjTmYoFFzt5Uktja
 KJhnjRNEiYHSjXIdsg8YrjAfKEUmBqgarvqSICAfILK3oug6nROK4lv+xmEA5W7lR/H5
 0BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2FehWZv489g7gLp1IpuJgAw0ELgG4HGTfqwfreEPxtg=;
 b=BB3LVOfSeCeadDuMTC1egTyMTALlZSl0t8gC6tjxTUNgdolkT3ibq9byRpqQD7CQwn
 hXKi/mHJZenPb7tnHR1Asvz2/80lInDNMhTYLOptW0gnLYz/zAn+FnCnvlBVpPo45GvF
 Vxh0d4IPv9JuORRcicHGCazcoTBzoMIInPXELeeXK0zljEGPuKPK1UF9Ie/zH9zjlP4A
 LIgL2juZ/3EKdaf3JCEAH+TZqoXMq4EtK2e7ut4S8MVNL6RD0KToY6/jej0GOMauc4IL
 jtvNtYSm9MT4KInyAb0T+PYIiToQpYRLoKZvonZDzA9GqaC8HvXooTpZW5Vp0NKVdD6j
 +Faw==
X-Gm-Message-State: AOAM530jSB8PlKdLj2/TPFCea+yBfsLh9VLgneLF/03b3kyLPflX0mzE
 mrOOlQ4BrrIL8bICRMACoBRCoKdJmpY=
X-Google-Smtp-Source: ABdhPJzCL+AIs9+afEjc2reah4gGN0cmZG8vo2l/C6RU1HKPjXu6wemJ0JbVRICYCyOpiDqf8Lf6gg==
X-Received: by 2002:a17:907:1059:: with SMTP id
 oy25mr18817818ejb.90.1593511430847; 
 Tue, 30 Jun 2020 03:03:50 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h2sm2304697edk.54.2020.06.30.03.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:03:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/15] hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
Date: Tue, 30 Jun 2020 12:03:33 +0200
Message-Id: <20200630100342.27625-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630100342.27625-1-f4bug@amsat.org>
References: <20200630100342.27625-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
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


