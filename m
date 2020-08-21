Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F97C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28D020702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLcG7w90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28D020702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9AwA-00024s-1R
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Ar9-0001QU-07; Fri, 21 Aug 2020 13:29:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Ar7-0001C7-9Y; Fri, 21 Aug 2020 13:29:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id p14so2654141wmg.1;
 Fri, 21 Aug 2020 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FL3RGx9So1PYwbmJZxkxf3xii197YkK6iJeT4N72p9Y=;
 b=oLcG7w90YGFmB9a2Vm9a/Yw5jIUcEzd5Nsng1cl0rlJ3x/iwTDhABGLHLsrbLw7wYu
 MpOcDbg1xxQWmHcySiGu3B0GENJfa9MK6Rh4lqO6AA+5vFO2ik+yCS1y32hpbl45qcTl
 bEnT0HM4TTYyG6Nt8Gz2qFipQQ9vRVhgUTHm3d+eggnTBYLmfy+KJmKiK4e+Z3H23jQs
 TNOx050PCZPcSeXJb3fv1hyjrJb7n1VN/TgahsTbgXlKCiUmyu+sXIiychVco1Axs+Mj
 BB6gZuZid0ZJtPBJGOqa8SCNaMBdyhDpu460D5v/q2MTE9+5hB74T+dANsMWaFNg6o0q
 yjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=FL3RGx9So1PYwbmJZxkxf3xii197YkK6iJeT4N72p9Y=;
 b=FpJH7eNSDtub4iriUqTt7DYB1dRR+ZK4y0/JxNg3OeIyEt2dmyuSO3wvwrqc0VVyzf
 DHH+q/36moez6AxXTblta7GKRU/Dd9aSUr5Lb8m83l7umyOEr5ErU4LPSKs9aNkCnFSX
 9NaJGPJMJwKgpITf9vUVgRtzUWe9Sti23gjPFxgh0Yo17ZEwfF+qgJ1uBViLbemHpwxi
 fdUt6eQ6m7ivyPpu/EpETqqKU1Dr2R1MV5A2I993f58ciUjmlOanwc5y+hF2rNfgXVD0
 bBG3W53D+RG+vgqi2dvmg6d5VzxXBnKeyM63R5szpQf1NZpk6gSpRkUal+ZXgIj9A8hs
 FcKA==
X-Gm-Message-State: AOAM530NU8c08jtnKs4RbzYYJ+A+2I+Eb4Jt/pDeVOq9/5+eGiQeDkcm
 RegFyOK16zlBpRPeai44rGocAViSRZ8=
X-Google-Smtp-Source: ABdhPJwgXE6ppeAyUl1pmNq/eugkNGT9B3qua0qCyzyAuBLtbiFQ7nMQxTNNpqS9tu+vJKZWf0QXyw==
X-Received: by 2002:a7b:c7d6:: with SMTP id z22mr327094wmk.186.1598030970826; 
 Fri, 21 Aug 2020 10:29:30 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/23] hw/sd/pl181: Add TODO to use Fifo32 API
Date: Fri, 21 Aug 2020 19:29:01 +0200
Message-Id: <20200821172916.1260954-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add TODO to use Fifo32 API from "qemu/fifo32.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200705204630.4133-4-f4bug@amsat.org>
---
 hw/sd/pl181.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 3fc2cdd71a1..86219c851d3 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -57,7 +57,7 @@ typedef struct PL181State {
        http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=4446/1
      */
     int32_t linux_hack;
-    uint32_t fifo[PL181_FIFO_LEN];
+    uint32_t fifo[PL181_FIFO_LEN]; /* TODO use Fifo32 */
     qemu_irq irq[2];
     /* GPIO outputs for 'card is readonly' and 'card inserted' */
     qemu_irq cardstatus[2];
-- 
2.26.2


