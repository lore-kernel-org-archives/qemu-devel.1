Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62087C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B202224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFCZPQqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B202224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVI8I-0001CR-Kz
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1Z-000421-VG
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:35336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1Y-0006Hv-Ef
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id q5so3462258wmq.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nLgO4iC9rtoBp7o///HfhJ9kAvL116nD5opOCzZ6+ao=;
 b=jFCZPQqJ209NEKWXn0BkP4Wuv7Qtgx/48M0Jz/CsKKETc+CqIBhLa339Fpbdy/hlvF
 VgjHiK20NVHJfvo8PWP0+sbBzOe36FIoOFTPb9ymmkGukT/Mii5obS1Dbv00ZXYnuqqp
 O5GHuRL5zKuaJCXUIGvqthSrspQUSwccfGD4qilJYf8loPbt8Ds22KDouYhYVFl4wpyq
 sfj0a7CsBrtUTH2Km2MKe66TQmo3ZK94YavP4Cb4jQfXhrlnw20OByIhDfdPMHnxONeJ
 igCrnOqKt8HZP3Ph9BpUjEs49PGAVFNn3kSLIInAJ0X3p/y7XWTqUL05BI44uJTuxMgV
 z2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nLgO4iC9rtoBp7o///HfhJ9kAvL116nD5opOCzZ6+ao=;
 b=HSORUFX8x84cRHNTt0T/VvQ9RHVFWGTrp3AAdWqTsv44vBru5fOqUEiHSE9nb9Hmgb
 KW47SLSkmfvyPqwOt1g7apXRiqzNW6qunpkI16G720IsvQfA/m7eUmLVIi0YMLZxk3n2
 manSSpFLgBBYculDpdWysdsdFBQqzycuqNn/xN6GSA2gMjb4tGdtKW2sSy3yOuVdaG0m
 tjnJeG0zVnXchcgPGNKRqq+g778Vwp12S4FBXVNs8TmlEY/QLMQIxPanaWimmsps7Db6
 jFVKab+KUcCdSrSP8CFE1Q6NsO1T1rAXGfc5Zo35uJ47a1y39TYQz9fHRPdFQqyFAo/9
 lAkw==
X-Gm-Message-State: AOAM532QTh+urm4ZyYA/h6EZINQ05mGAEo76SBXqIKH2sMSpdYvH/4SV
 zDHSAcIKGpwxoy3QmrCUbzWpibVq0Nw=
X-Google-Smtp-Source: ABdhPJxXoJ2CcbAWr0w4/cwwBibCbVaK1KDBdRv5MXEg5zmw9vDYjk5LsVSQ87yiPgVxsx/MXTlgRA==
X-Received: by 2002:a1c:3d7:: with SMTP id 206mr4828393wmd.155.1603301742991; 
 Wed, 21 Oct 2020 10:35:42 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id t5sm5109398wrb.21.2020.10.21.10.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:35:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/13] hw/sd/sdcard: Reset both start/end addresses on error
Date: Wed, 21 Oct 2020 19:34:48 +0200
Message-Id: <20201021173450.2616910-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173450.2616910-1-f4bug@amsat.org>
References: <20201021173450.2616910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From the Spec "4.3.5 Erase":

  The host should adhere to the following command
  sequence: ERASE_WR_BLK_START, ERASE_WR_BLK_END and
  ERASE (CMD38).

  If an erase (CMD38) or address setting (CMD32, 33)
  command is received out of sequence, the card shall
  set the ERASE_SEQ_ERROR bit in the status register
  and reset the whole sequence.

Reset both addresses if the ERASE command occured
out of sequence (one of the start/end address is
not set).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20201015063824.212980-5-f4bug@amsat.org>
---
 hw/sd/sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4c05152f189..ee7b64023aa 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -755,6 +755,8 @@ static void sd_erase(SDState *sd)
     if (sd->erase_start == INVALID_ADDRESS
             || sd->erase_end == INVALID_ADDRESS) {
         sd->card_status |= ERASE_SEQ_ERROR;
+        sd->erase_start = INVALID_ADDRESS;
+        sd->erase_end = INVALID_ADDRESS;
         return;
     }
 
-- 
2.26.2


