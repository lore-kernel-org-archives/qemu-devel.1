Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DE6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6268207DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBHkjwcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6268207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2gJ1-0007Tu-VN
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 15:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2gE1-0001fg-36
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:34:21 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:35803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2gDz-0003au-8i
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:34:20 -0400
Received: by mail-wr1-x430.google.com with SMTP id f1so34716375wro.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=p3Oj1hHYVSfEnmzR1MqlL9GNka397sl/NrXlR449zEg=;
 b=EBHkjwcZniqt2OC4srTa97XVJ1EeN8RbgN4nAsqUrRhiMaOQM0HEtqDwNsXsg+gyjj
 hUBCWBygTQJP1JVVawlECAzFpluBf4aW3Zx3uztRxvS5fLSv2RcTWrjEnD3UFCsCttJy
 AZRTJa4pTy6EbyYJrs4BhuWq+LoQgAzjR6IU4tUhDZIzKQG3b/nNP1bfystH1Sv0loGw
 3NSVdowVAFKvVDwRqBDHjMduUvtPwe7+2SV9Ehexvtt+YfRp/BngIobfl6bEaNvDYiWW
 VHFO4vYgDt7niaVunzjYOGSC9sIKO/yPXt9u+u8xJfvzK2MoOT+Mp7CBElh0sHQfOhBJ
 AjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p3Oj1hHYVSfEnmzR1MqlL9GNka397sl/NrXlR449zEg=;
 b=fD55cCKuvr2OxcmxGHheLcZhYqm3RBNt0oBzVQlwmXXMeWDIJ3+Xtzhe7wTy63lVGx
 EWGWqcZe0hPm/VkUktVeawMF5wt7SgNWKI9N3aADzGJ56yN+IUUnjyJFkt8b/t1dtOeg
 dcwqRhK9fuJQuF6+i96FhFi4I/gh3+pOnmMyoKSzKKzARL9lWBCsZYkj3fd0D93IxUgx
 17XQBHfFtylVLckkHxeEfr00n9PmCGYys4qWqcsXpHpRskVENQAl1TSjHYEi3i6GIGxm
 Li30OqLWOORRUzGQ9TEKBAPBoIe6vWq56iigSHRCGkc7ahbZTrK/6/jdnUMsQOIz70HS
 hYjA==
X-Gm-Message-State: AOAM532S1WCvQao+NzmibkU+sp58qigg2D0RYuKTXKhtB13K6uu3eI1w
 wzi0BZCP1kweL92kto8APw53rb2AJQFvBQ==
X-Google-Smtp-Source: ABdhPJy4iJeumKA6Hoe3tZrF2vYF/WxXZNJSHg99q0V3BIPEr8FboBhm9Yoyx0noRqtoOirbjHSBWg==
X-Received: by 2002:a5d:544f:: with SMTP id w15mr16428537wrv.208.1596483257125; 
 Mon, 03 Aug 2020 12:34:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r206sm985565wma.6.2020.08.03.12.34.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 12:34:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] hw/timer/imx_epit: Avoid assertion when CR.SWR is written
Date: Mon,  3 Aug 2020 20:33:59 +0100
Message-Id: <20200803193359.12936-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803193359.12936-1-peter.maydell@linaro.org>
References: <20200803193359.12936-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The imx_epit device has a software-controllable reset triggered by
setting the SWR bit in the CR register. An error in commit cc2722ec83ad9
means that we will end up assert()ing if the guest does this, because
the code in imx_epit_write() starts ptimer transactions, and then
imx_epit_reset() also starts ptimer transactions, triggering
"ptimer_transaction_begin: Assertion `!s->in_transaction' failed".

The cleanest way to avoid this double-transaction is to move the
start-transaction for the CR write handling down below the check of
the SWR bit.

Fixes: https://bugs.launchpad.net/qemu/+bug/1880424
Fixes: cc2722ec83ad944505fe
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200727154550.3409-1-peter.maydell@linaro.org
---
 hw/timer/imx_epit.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index baf6338e1a6..ebd58254d15 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -199,15 +199,22 @@ static void imx_epit_write(void *opaque, hwaddr offset, uint64_t value,
 
     switch (offset >> 2) {
     case 0: /* CR */
-        ptimer_transaction_begin(s->timer_cmp);
-        ptimer_transaction_begin(s->timer_reload);
 
         oldcr = s->cr;
         s->cr = value & 0x03ffffff;
         if (s->cr & CR_SWR) {
             /* handle the reset */
             imx_epit_reset(DEVICE(s));
-        } else {
+            /*
+             * TODO: could we 'break' here? following operations appear
+             * to duplicate the work imx_epit_reset() already did.
+             */
+        }
+
+        ptimer_transaction_begin(s->timer_cmp);
+        ptimer_transaction_begin(s->timer_reload);
+
+        if (!(s->cr & CR_SWR)) {
             imx_epit_set_freq(s);
         }
 
-- 
2.20.1


