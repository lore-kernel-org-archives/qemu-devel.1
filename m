Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7549C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94295206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8WDJfhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94295206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgtld-0000t4-Tr
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgtkz-0000TJ-Kn
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 13:34:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgtky-0004lv-I9
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 13:34:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id q25so6554844wmj.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 10:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c/njtRoD2PI3vve6feg3VXUYaI7/H7zNIgbrnDw9lnM=;
 b=U8WDJfhuBBsseJLybz7Mv7A2QnRqudlwwgVVhFtl0l5G2ITuIyJPJJlcH4bwJEBSY5
 cpK6xT9idWTCApfHjoi0OG+jiFig+Rr9feFUcYVEqWa+nHD9wIywHa5LCg7JhJnmec9p
 S2yqVW3KpfWiSMV1vgqHQxUywPRRRKBUaUJ5kjKBDnVUtnAD6jDSBMTz67DVSKpNPXxR
 PvARapMRTeFIQ7eisFRxQLLlsg8Q1UMpJ1JJOpOXKWkhXyjen16AdkvaD9HxD1F0WynD
 G2uGTfzU85gScrTAuq9mKpTTtu0iYYJq6m//xff8+Y8dDtb3FuAjMZuiw4E2FYih4CL0
 8Qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=c/njtRoD2PI3vve6feg3VXUYaI7/H7zNIgbrnDw9lnM=;
 b=ZYQq2ilCCoXirJ8Q0boRGKI3QxIju86ePsO5SgSfNVyBD0MdpAtQEyYNYKPaBN+VdW
 YE4JMOx/WkJJ1ONaDpvq/4UA4BgOQhtL5JJDOLoV9HDLrzUddNVR9uUw2t6Mf8m8+m4E
 jOOEsVie20ya5n5UX/2JiBOhU5CM5vpnEFqJRVY6Lgc4TipzsWyH/OXHjj3tH67x3KvW
 Ti7/OhX72P1dg4QU9FibcRTmLHek2S0UfAERVW6JCbZ0hOCDXh1fj9H9mD9NMdwjgzm8
 Er/4AEB/znUSSn6rfGYCkj6warY6f0xTEATCGN2lz+1HNsh/ul3VJr4qKVRNkk+q3GZv
 duWg==
X-Gm-Message-State: AOAM530obcEsWBNlyGIUeLBnbQvdjSXiF5HWsgneg8s9ziiMyfXp3R+J
 9nI8BHYQVg/Q+gHrDSt4Nwv4DTF8
X-Google-Smtp-Source: ABdhPJycOXqyyoiGS3tSf2WEW32x6LEA/60JvZ/oWOKtoUP9rkaMAd7NaUWdpQROHmM6/0DztA8Shw==
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr5342488wmr.49.1591292058246; 
 Thu, 04 Jun 2020 10:34:18 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id l1sm10481640wrb.31.2020.06.04.10.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 10:34:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/sd/sdcard: Verify CMD24 (Block Write) address is valid
Date: Thu,  4 Jun 2020 19:34:10 +0200
Message-Id: <20200604173410.21074-1-f4bug@amsat.org>
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
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 1880822@bugs.launchpad.net, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid OOB access by verifying the requested address belong to
the actual card size. Return ADDRESS_ERROR when not in range.

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
---
 hw/sd/sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3c06a0ac6d..0ced3b5e14 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1211,6 +1211,10 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             /* Writing in SPI mode not implemented.  */
             if (sd->spi)
                 break;
+            if (addr >= sd->size) {
+                sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
+            }
             sd->state = sd_receivingdata_state;
             sd->data_start = addr;
             sd->data_offset = 0;
-- 
2.21.3


