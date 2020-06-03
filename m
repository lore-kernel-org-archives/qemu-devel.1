Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD98C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 18:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20812053B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 18:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USbkfOTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20812053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgY1l-0002KF-UQ
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 14:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgY0x-0001qJ-Tl
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 14:21:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgY0x-0003KU-9o
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 14:21:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id j10so3398292wrw.8
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UpblTYIb7jLLVBKdbKT6mj2ST1AGYG3e2qmSQnP4jGQ=;
 b=USbkfOTJyr/Ves5Ezguef/w9N7vq7vKFlv+YuV10kWTRJiRHydiQwoc+bmQgRLp8az
 8q4LpDSoYDYQ/Vewgyzb97H+HwRM4nXL2QSOHK9eXFpxibSPTJIUmBMrbT+WiDEEnHVH
 NkZJ4GPk0YvtwwFPPb3+/S3KhKE8peDB1LXliY+FdvBorTB9s4kOhkwwR2uWmABIDcx+
 bRHGMKcWWzXvDaXu1BwCgYIRKrCdXyTpUDiF6R76nE4UCOGSm+hWni0Kji4CoavbXibQ
 XF/YB0tCfw8aVhDjAnUCqKHTkp6g0SRNXlMBRNzQNBv8dMzH/dx/TdxbRn8Y6iwPidFz
 VC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=UpblTYIb7jLLVBKdbKT6mj2ST1AGYG3e2qmSQnP4jGQ=;
 b=WbUPYEI4cuXIER+87sRlfHsyG5gJFngGAPJpkKuxHnpzNA4vIKr1x0Ch+Dg9W+6she
 0EZiJul4dpqxeBksl5kyHtJ2G4uubwep01OIld+Gxcc0X7aztfouL2vyKXQxc9V9TdeY
 9hWNy6lcu5W+uePcA4Zk5zwzMSUQVxsLX/Umqk99xESJ89jPJ6DrWtPwvcTbIJnwxXvZ
 rLyMpmbOtACSAStTqfmmdAWyJ0KpdhvoqOOQrWIh1o4kWnzkhqm2zlNQmvFUf6fVMP4E
 KAviLmvMwU2kRvBY7aAWE7Cl8sUDO+xdzms7ee3GSvgwbibonVEcwkYJzWCJJTqCJoMS
 I5ig==
X-Gm-Message-State: AOAM5335nmtcl+Z3o42CimUk/wTKYDFndlwFtRoTe2kr4e1Hci1pqnX+
 cEO03B3q3cB5YmpBxD2xU8oSyk+u
X-Google-Smtp-Source: ABdhPJwaKJT9Zjt5yilna8gcb8ueKrpTbMb7HBZEeB8Qwd0POF+LEqr+MSZSSI/gmpKoibcsMbJ6+Q==
X-Received: by 2002:adf:cd08:: with SMTP id w8mr696916wrm.36.1591208481092;
 Wed, 03 Jun 2020 11:21:21 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t7sm4668907wrq.41.2020.06.03.11.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 11:21:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
Date: Wed,  3 Jun 2020 20:21:18 +0200
Message-Id: <20200603182118.14216-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
This patch doesn't fix CVE-2020-13253, but greatly reduce
QEMU exposure to it.
https://bugs.launchpad.net/qemu/+bug/1880822
---
 hw/sd/sd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3c06a0ac6d..da39590f58 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -905,6 +905,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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


