Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4F6C54E4B
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 15:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8779D2080C
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 15:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h51MAUZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8779D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXnwD-0002aS-Lz
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 11:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXnsn-00069d-Go
 for qemu-devel@nongnu.org; Sun, 10 May 2020 11:28:49 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXnsm-0000yi-TY
 for qemu-devel@nongnu.org; Sun, 10 May 2020 11:28:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id k1so7744795wrx.4
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3fNdIn+8vkXom2UjSJnuRhcE6SsVXVyDMS2MettPTi8=;
 b=h51MAUZX9uFzwwAF1hhLyLpmXvJO1sTnOKllqyl7pw4p53EfCzvRHO9Uc8MOC7arfv
 iZguT9JjUziMGHuU8ErE6katwJlgSAVYU42wGxY2x98pZHd9WktcgyEXGlAgQAX2uQ1T
 QYT611ZUzjw2jta6c2nd0ulwMcxz0hX7o+ETLOZfBkcyl9+KetloMEMG/4pGe417e0EP
 Y89nHmAYK5zGsn8HLzghXnCjH4qMYhksZ3lTfUYcuidORiinIdmV5SKxfsS+cbApzeWb
 FjZFV+EGv2Kt3F6U/DEil3aj/+ofDTa8g84RdU39rWcjvtzgtZ4EWeHxCHrx8KLMAcms
 723w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3fNdIn+8vkXom2UjSJnuRhcE6SsVXVyDMS2MettPTi8=;
 b=qGzw1WxZij+z2PoS1gkAFDb+bHH2bnl+1P7UTPnNnPOCOUokd6/rSHAuXAGpFisDTG
 lJOnK1IvLIMFdIq0A4n1RwIm2/DR0y+wDeZ6G5g/t6EbqZK17xhFClUuCryB3Oob1jCr
 U/iVglTPAUeRsjsiYpMLd88cN1PFAisJt71qxploVvtoo5pppchsQIN4EAQGzXtc5WOa
 T4qhNh0Q8qLHDjonA+LTESVY+W2vgJbsxqowhsEJnGmRC9MaYiZ25yRGbEow7a86qBV6
 c8FSqCHSHupgmjBAFKmaWleLj+cRMzDXqMpLIxXAv6+2Rlo2xRI4Z4yOaeXzMkOEo36+
 uZlg==
X-Gm-Message-State: AGi0PuaKxLUPeJKzYQyZbDjiJ69/fMOCjknswNk4NEYFqoE20fcRmfPM
 q+6T1sR6UobUJZnEQrD4JkcUGzpkaRA=
X-Google-Smtp-Source: APiQypJCyPF63FjgsoVgU66F4M6tfVUV/O0MYDveuraEQAuLLaQ+Es5MikjgA/XjpqQw7+yB932Lvg==
X-Received: by 2002:a05:6000:12c2:: with SMTP id
 l2mr2279794wrx.133.1589124527291; 
 Sun, 10 May 2020 08:28:47 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a67sm24186702wmc.30.2020.05.10.08.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 08:28:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] hw/misc/empty_slot: Lower address space priority
Date: Sun, 10 May 2020 17:28:35 +0200
Message-Id: <20200510152840.13558-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510152840.13558-1-f4bug@amsat.org>
References: <20200510152840.13558-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Empty slots model RAZ/WI access on a bus. Since we can still
(hot) plug devices on the bus, lower the slot priority, so
device added later is accessed first.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/empty_slot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index 3ba450e1ca..5ab426e965 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -67,7 +67,7 @@ void empty_slot_init(hwaddr addr, uint64_t slot_size)
 
         qdev_init_nofail(dev);
 
-        sysbus_mmio_map(s, 0, addr);
+        sysbus_mmio_map_overlap(s, 0, addr, -10000);
     }
 }
 
-- 
2.21.3


