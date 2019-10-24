Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7494ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E50D205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z40pSTqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E50D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgny-0002AS-3c
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfy2-0007px-Je
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfy1-0000vC-Ht
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:06 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:36438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfy1-0000ug-Bs
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:05 -0400
Received: by mail-wr1-x434.google.com with SMTP id w18so26261015wrt.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OpXzWlpJhscet03TTtHAiTy/AAuzQKIKHX9oxfpPCRA=;
 b=Z40pSTqONB80Oqdhm67lCCdlNQ71V4OZzAWYdURlvvQdRJ3d4cQRGYAAbJnUQZNyv/
 m0qOqHaXil+e6Ovw7s/rkERoEvJ4E3vOx+7zkKA7y7NbyOXTY2f1HTNOvaCNJ1LjD3TQ
 UFPmwXk74jfu5KndmJjPqAfzeE4+H14GY+1+nGGJhily+/tOJWYJNjEMyq6CRsGzwOGZ
 90Gc75W0Q5Jp4lFXv9GTMyz4TJ7avq6xXqIh8BTmALg8VEBEjfgedhr5RsPzz9djwMAj
 n+tC6i5kolSakty4vi3dtImeI1x3GUr7iqNN+vOC/bJpjx+tJmsfiTPmDxva8v95T6hK
 ziMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OpXzWlpJhscet03TTtHAiTy/AAuzQKIKHX9oxfpPCRA=;
 b=cep53tLO/w6n0dGk0xvjv+mh92O3jtmnI67OwH+L/O/yz9Sd8uKPItYbrJhY4t27WU
 XCTXeZ3+Dz7c5NYophgOxqGI9brc550GGstoDVYhNQhPV0AciL+BvwldEgsmL/J1qu18
 FCNF6Gi/8IExpHtANeXSKSdqy3P7kkU8QlrmiNdaog3cCwLYu8ZJmIUoFnSWYdaYkrLK
 roNWmmBBQBi/AiHWdPK94wQIzMncTBo1z55hO3B6SfvQL2tTHi1Dhhg2dPx77nM3SE+b
 ablo0Ytf1oYuXl0U6fKa+AAo3vw+sxN567RE1M99xjcZqDo0oCVyjUaSMXxt4jLPMvE9
 etZA==
X-Gm-Message-State: APjAAAV/dD3xSAzFQdQV0ZF5dXwW+AHLQzkkRx1LfvudxtASEqa0eNHp
 fnPe00eUkpdVX5MMzue4jXE4HGIQJHg=
X-Google-Smtp-Source: APXvYqxVMBfIW8io26v6Le+ppyea6QBlGE77MmLFS0XBReN9BlvMVDKo7w7qyr0P50kjpMMozb77Ew==
X-Received: by 2002:a05:6000:34f:: with SMTP id
 e15mr5074847wre.232.1571934484111; 
 Thu, 24 Oct 2019 09:28:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/51] hw/timer/slavio_timer: Remove useless check for NULL
 t->timer
Date: Thu, 24 Oct 2019 17:27:03 +0100
Message-Id: <20191024162724.31675-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

In the slavio timer devcie, the ptimer TimerContext::timer is
always created by slavio_timer_init(), so there's no need to
check it for NULL; remove the single unneeded NULL check.

This will be useful to avoid compiler/Coverity errors when
a subsequent change adds a use of t->timer before the location
we currently do the NULL check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191021134357.14266-2-peter.maydell@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/slavio_timer.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 692d213897d..890dd53f8d8 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -227,13 +227,11 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
             // set limit, reset counter
             qemu_irq_lower(t->irq);
             t->limit = val & TIMER_MAX_COUNT32;
-            if (t->timer) {
-                if (t->limit == 0) { /* free-run */
-                    ptimer_set_limit(t->timer,
-                                     LIMIT_TO_PERIODS(TIMER_MAX_COUNT32), 1);
-                } else {
-                    ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(t->limit), 1);
-                }
+            if (t->limit == 0) { /* free-run */
+                ptimer_set_limit(t->timer,
+                                 LIMIT_TO_PERIODS(TIMER_MAX_COUNT32), 1);
+            } else {
+                ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(t->limit), 1);
             }
         }
         break;
-- 
2.20.1


