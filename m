Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4E5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9728F222F2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YD5cGgEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9728F222F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX3eG-00056L-9k
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 08:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bk-0003Lq-TM
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bj-0004A8-8j
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:52 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX3bj-00049Z-2y
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:51 -0500
Received: by mail-wr1-x42d.google.com with SMTP id b3so23833973wrs.13
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 05:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TuuysipQCj49mLVP6qzC24BBiVXuGGfeJLuCpI9AXuw=;
 b=YD5cGgEC/OkOSVmkZ1yo0OuIvaOwk+Pp8QliQXnLEi8EI+f7DDACuqSehWNZ3ccUDM
 nFEoyDBH9R0EmWtiHm6LrpFZNGtT8Bp8Cxl8PPl6Xvin047n+DL24DcZGFbhInwPigQ6
 2Rwgt1GiqQWX35GPHbcewMLcicihyBpJPQBsPYJEhxJg5UQe4kk09yrjDcULfu3H0vOo
 PqVj+veBeWLtUZ7Bm4A8VCjCdGdenwUEozEH4a5cuATem/spcD3+X4zowNptAI4w5FZT
 2LoTMGgxpmDjDeDClhwOM2puW8kUl9cJG30BDP973RP1uA/Gb8gDzV9wBm5DHigxKFhr
 Q98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TuuysipQCj49mLVP6qzC24BBiVXuGGfeJLuCpI9AXuw=;
 b=HNNULutLRsoLZTVA+eLJuheDxOhdVvMRBvrSB6UwsNp3/QXzxj+qRiztmHKA3f2qgL
 KBGHvsy3cwVc+EgmedKXP5jb/kfITNKnZoPyRAFMMFVm0cvkTs/ulzNgMD4z/jSj9wk1
 f03F9SlBtSS+TmD7fJsfR96ssdT+FpxfweqN0FgIXIJaIxuuhfwlFiRLpa6p6/12wDZw
 bvzC3GnsPyKKNbBTw2K3dNLwZoqHirEETDrzrMcNFd59Q5UaeINrWe3zoH9xv0GuBZ0k
 c+jnzDpYrCuRJmCVyhZ27KkAuAr17Y9NBZ5t49FfTjSHJPC/RLWccKy2esm0N8lz2nSL
 FmBw==
X-Gm-Message-State: APjAAAUC5ra7j8QycRE9KQV1GOGIdryhUXo/q6s9wF1oNXHP2JbvphCV
 J/FTq7lfNNzKL8qa2+BqSCQNB+/I9b1kfA==
X-Google-Smtp-Source: APXvYqyWU9/XGM8wQr/ueYcig80RIt3MNw/lDI+LXnQI5slm2sQol+v5A/Y3dgY04uv38uuYQ9NkOw==
X-Received: by 2002:adf:fe81:: with SMTP id l1mr27430510wrr.207.1574170309642; 
 Tue, 19 Nov 2019 05:31:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g8sm3094905wmk.23.2019.11.19.05.31.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 05:31:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/7] pl031: Expose RTCICR as proper WC register
Date: Tue, 19 Nov 2019 13:31:39 +0000
Message-Id: <20191119133145.31466-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119133145.31466-1-peter.maydell@linaro.org>
References: <20191119133145.31466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Graf <graf@amazon.com>

The current PL031 RTCICR register implementation always clears the
IRQ pending status on a register write, regardless of the value the
guest writes.

To justify that behavior, it references the ARM926EJ-S Development
Chip Reference Manual (DDI0287B) and indicates that said document
states that any write clears the internal IRQ state.  It is indeed
true that in section 11.1 this document says:

  "The interrupt is cleared by writing any data value to the
   interrupt clear register RTCICR".

However, later in section 11.2.2 it contradicts itself by saying:

  "Writing 1 to bit 0 of RTCICR clears the RTCINTR flag."

The latter statement matches the PL031 TRM (DDI0224C), which says:

  "Writing 1 to bit position 0 clears the corresponding interrupt.
   Writing 0 has no effect."

Let's assume that the self-contradictory DDI0287B is in error, and
follow the reference manual for the device itself, by making the
register write-one-to-clear.

Reported-by: Hendrik Borghorst <hborghor@amazon.de>
Signed-off-by: Alexander Graf <graf@amazon.com>
Message-id: 20191104115228.30745-1-graf@amazon.com
[PMM: updated commit message to note that DDI0287B says two
 conflicting things]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/rtc/pl031.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index 3a982752a2a..c57cf83165d 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -149,11 +149,7 @@ static void pl031_write(void * opaque, hwaddr offset,
         pl031_update(s);
         break;
     case RTC_ICR:
-        /* The PL031 documentation (DDI0224B) states that the interrupt is
-           cleared when bit 0 of the written value is set.  However the
-           arm926e documentation (DDI0287B) states that the interrupt is
-           cleared when any value is written.  */
-        s->is = 0;
+        s->is &= ~value;
         pl031_update(s);
         break;
     case RTC_CR:
-- 
2.20.1


