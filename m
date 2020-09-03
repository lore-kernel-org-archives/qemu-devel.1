Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9327CC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA8020716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UclCLAR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA8020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDt2o-0002gG-GZ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 13:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDt1z-0000s8-Oa; Thu, 03 Sep 2020 13:28:15 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDt1y-0002Vb-29; Thu, 03 Sep 2020 13:28:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id t10so4135320wrv.1;
 Thu, 03 Sep 2020 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oW6XvxZuE1zKD54bo18SFHuDRJFc1R7THevACoTqgkM=;
 b=UclCLAR7ukADVGhNA2HNAojA6SmIcNm9cl64vWhssP/TJgxEjb/Dre40PT6j1zRVJz
 b1jmNs+ajxvVpK/B3+M3YnDLeo2oN4W3O0NX5uLJSPXLrkd4Dn3JFAassBF2smNIs2N7
 M+7Ne82EAHw7vtlwNfPC0kpMng65TwEpbMO4OtrcqOr0WBmBcsD9A/KsOW0sJ1t977bF
 KtWvXBN+hMHkBZBqVx2yCLzV6OFSgAGg5M07rJqBybgVM6ftJ/y2RfR0qML2XJUsapRj
 y6BUD74UFJJUHcuCeQhaPwMrhU2lOjf8VpWo6bkRwCO+ESTLbBA93f18yIT3Vz19tgW9
 7eWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oW6XvxZuE1zKD54bo18SFHuDRJFc1R7THevACoTqgkM=;
 b=j0ggyhR8PqknYO3k2jZzjO5wkA21n7cW+xLqyTdrwyWbqRaki2grzsL/SYkoz5jiIi
 Vf4wTKs91zUnYh6Pox8im8hbhtKDs/H7D3LtDcj7nuGiD8epxOLWmxhtSF52G56uhEsL
 MvlwIJtwb/t9CVrF4JOt2xhwli2qb+kGYGc3n+HoPsQwC1VZJpb1hGYrz9xY5IPftYq1
 D1IKKmKSioDDS6lLanGI+SNFT1HpvG1vZbx6D+iqA4vcKcTT57zybkcm+nJVHi/mfFWF
 qEocUnmvQE+DS9bxlZhJ3fEBu7LWoqLeUOjKOAwrbDASImaMoZMMg486sGjClxOGe6vh
 +b/g==
X-Gm-Message-State: AOAM532KlCVapeUG+cw6ucRwOBmbnBmFnoTF/J2Bg8GXWF88In24haSs
 5SxYNQncVovxBFPMI9xs72RJE5bTFes=
X-Google-Smtp-Source: ABdhPJxD/eT6l2vFol7VZU2Jyo5/WQJgbylf3v9Kt/NGmTML055BK2l8qA9Um3yZQ8pwfkfEf9Uzlw==
X-Received: by 2002:adf:8445:: with SMTP id 63mr3451049wrf.375.1599154091708; 
 Thu, 03 Sep 2020 10:28:11 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id b2sm5325802wmh.47.2020.09.03.10.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 10:28:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] hw/sd/sdhci: Resume pending DMA transfers on MMIO accesses
Date: Thu,  3 Sep 2020 19:28:04 +0200
Message-Id: <20200903172806.489710-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903172806.489710-1-f4bug@amsat.org>
References: <20200903172806.489710-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 Ruhr-University <bugs-syssec@rub.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we have pending DMA requests scheduled, process them first.
So far we don't need to implement a bottom half to process them.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 703357e94a7..2b197631870 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -945,11 +945,21 @@ sdhci_buff_access_is_sequential(SDHCIState *s, unsigned byte_num)
     return true;
 }
 
+static void sdhci_resume_pending_transfer(SDHCIState *s)
+{
+    timer_del(s->transfer_timer);
+    sdhci_data_transfer(s);
+}
+
 static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
 {
     SDHCIState *s = (SDHCIState *)opaque;
     uint32_t ret = 0;
 
+    if (timer_pending(s->transfer_timer)) {
+        sdhci_resume_pending_transfer(s);
+    }
+
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
         ret = s->sdmasysad;
@@ -1093,6 +1103,10 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     uint32_t value = val;
     value <<= shift;
 
+    if (timer_pending(s->transfer_timer)) {
+        sdhci_resume_pending_transfer(s);
+    }
+
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
         s->sdmasysad = (s->sdmasysad & mask) | value;
-- 
2.26.2


