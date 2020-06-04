Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A2E206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYGGHM1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A2E206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jguZ1-00011h-Bh
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 14:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jguY6-0000PP-UN; Thu, 04 Jun 2020 14:25:06 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jguY6-0006QZ-1r; Thu, 04 Jun 2020 14:25:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id f5so6683871wmh.2;
 Thu, 04 Jun 2020 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IG8KsUqRxybW9crwLHhOiTQVf0S9F3bZD70HW0W9CWk=;
 b=PYGGHM1bVSL/+WlEKYgf5+zn0mWT35mfgMvh3WlmEpbWU3aa6domMsp4tU9p0qUayS
 VrHE7F+X3CLCqsW5r4B0gxCS6t+yQmjKL5SszyRuj4C5m4eOka78aKtj4DMcHZrYNsKZ
 0nNfIhAnQBXqSvC7r+UZ2lGl8KaHRYWxaNJJJla568DHXgIGZgyQ3FvRvNIMFaPSWWPP
 qhtmHVlOfebyj6Lf6wL5WhrIz/RPeEL59fXC4xLcQtr4zTr7JUsDOROWmvdyzDDSHeGd
 8VTP+KnYTFYUfBHCplkhpHMFJ5WpuUhXgKU8/q5rl7mrKt7/+E67MnZUu5W0mhsm9WqL
 6U7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=IG8KsUqRxybW9crwLHhOiTQVf0S9F3bZD70HW0W9CWk=;
 b=PG0pREMiSOs8yTLiyo/a8YA8MnKRaMEYaDmV+3sjihdXZA8cbOPSklM/a+woRHm5Kz
 URfyOZxj+ST+GuceV8IfP2nWHc4s0XxlvvQ9KJ41s9xeN4q2L/N90z++rOmvf4j1uI9X
 W6UTgdANfr8CHGZ4ZbnYEHjHNhE72mxrQGGUd3iIjrsuH091G3VCSuUPQrxBOrdQGtRJ
 Bm+kB/ic2bXRiVu0X8vrxe0o6NQFkeID49cTU7CJMiXe6IIulBIivo0UuaHNL5Vmn6ZH
 x2DEc+8rCnw2TUbpX2aTrPb5IrzNVZLvYNb7jG59KWh2estPOXeGSsV6R6s+8VoHozio
 SGoA==
X-Gm-Message-State: AOAM531vvVTuF9MCAJCH7bPHie5RL9kG8mUGH/M/kZA4agjGcM0dk8tW
 Mh23+AZpC7UQSfjNaQc3UjxMWjbh
X-Google-Smtp-Source: ABdhPJxB+511rD582kFXj6Hd1YLBqp4zTwGyOhIcEURHsc2K2KVERePwZUNLtU/KYLK7NQmjBfEgZA==
X-Received: by 2002:a1c:f401:: with SMTP id z1mr3493127wma.44.1591295104073;
 Thu, 04 Jun 2020 11:25:04 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id s2sm7904526wmh.11.2020.06.04.11.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 11:25:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/sd/sdcard: Verify CMD24 (Block Write) address is valid
Date: Thu,  4 Jun 2020 20:25:02 +0200
Message-Id: <20200604182502.24228-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 1880822@bugs.launchpad.net,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid OOB access by verifying the requested address belong to
the actual card size. Return ADDRESS_ERROR when not in range.
Only move the state machine to ReceivingData if there is no
pending error.

  "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"

  4.3.4 Data Write

  * Block Write

  Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
  occurred and no data transfer is performed.

Fixes: CVE-2020-13253
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Buglink: https://bugs.launchpad.net/qemu/+bug/1880822
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Prasad J Pandit <pjp@fedoraproject.org>

v2: check for blksz in range, only go to sd_receivingdata_state
    if no error.
---
 hw/sd/sd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3c06a0ac6d..2254dc7acc 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1211,17 +1211,18 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             /* Writing in SPI mode not implemented.  */
             if (sd->spi)
                 break;
-            sd->state = sd_receivingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
-            sd->blk_written = 0;
-
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (addr + sd->blk_len >= sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
-            if (sd_wp_addr(sd, sd->data_start))
+            } else if (sd_wp_addr(sd, sd->data_start)) {
                 sd->card_status |= WP_VIOLATION;
-            if (sd->csd[14] & 0x30)
+            } else if (sd->csd[14] & 0x30) {
                 sd->card_status |= WP_VIOLATION;
+            } else {
+                sd->state = sd_receivingdata_state;
+                sd->data_start = addr;
+                sd->data_offset = 0;
+                sd->blk_written = 0;
+            }
             return sd_r1;
 
         default:
-- 
2.21.3


