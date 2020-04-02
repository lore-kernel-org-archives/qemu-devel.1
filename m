Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F57C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318AD2072E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpkEbU6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318AD2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0Cc-0000IB-9e
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jK0Am-0006Xm-TT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jK0Am-00023C-1Q
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:46:20 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:35582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jK0Al-00020w-Q7; Thu, 02 Apr 2020 09:46:19 -0400
Received: by mail-lj1-x243.google.com with SMTP id k21so3325356ljh.2;
 Thu, 02 Apr 2020 06:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+8YyPg1A/CL32UVNeLjMOcghy1faoRoeDPxjhkZR1lM=;
 b=YpkEbU6mz/HHVLXjiZh/5b9VswChu+B4iNYIXIOaXzzB+LXAZBFeoVc2OaB9Bv3Dx8
 7RC8P0USB6f73+ZLWRQK3UQ2zypqXwbNMIovEhJFPMXCibepwPf+sM6PAodyUPgKwYVe
 AGEkUtrVKuKELHpOO9+GrU46HS0US1WeEidy7172nn0ZrR8kfuyFHr+6Ygyh3EFN96q2
 bNqVIUIZngZ0lyOE9Ev/1Z+AQE6Z8D62L+nLK224RXQBLUzclL35BKmUhb76uXE1yBjk
 z4YOCd9UWJ5h+nu1Leq4L2+i9uW/LsRFEC3ufEzixN4TIJIvgANpfCZqO2mh79frfydf
 dbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+8YyPg1A/CL32UVNeLjMOcghy1faoRoeDPxjhkZR1lM=;
 b=HSICFy3uW3gvEbWDp4w4pX2LpHlDEOfPB1KpujapJhAHb2lhzgOzwqluf2Rkp+eL8/
 xqG/iRoTJKP68CA0emx0ROlT3CaLj+CytIbA90/c34IWaYUNQztRENH88POcra/YsvvE
 FVcWvrWIA7tfq4xzVr0PnA726c/TTOVG6cACh3+6FKnjc2FHudX0repbLtU2rdeqh3rq
 RJkPQE3Z2vfwodM+xiEF3yQB9oQS3mHCS5AtdD7qq1f3Ri9Vlxds3vXVwwlFJWRWv4qD
 VTEAQGOuAEeBiztFyro7v63/pFrY/0t1XQ62TF9s4mYD61407j1i429Z+RhekDAebVej
 8zJw==
X-Gm-Message-State: AGi0PuZ05C1tHCLJUE9ixbKlAqW25MhDS5YRwUdFUpAaZWP0W18l1PMs
 3LkCNzOMQbgjLc9hizAmX0E9AmjI2pMtVg==
X-Google-Smtp-Source: APiQypKzVOauBGw1Pch4tcjOsIPAZIrTpCnDyhjftzE4gj1XecMlChisHJNVkio+lPWIGTgv6RMvng==
X-Received: by 2002:a2e:4942:: with SMTP id b2mr2145000ljd.135.1585835177363; 
 Thu, 02 Apr 2020 06:46:17 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id t13sm3846647lfc.68.2020.04.02.06.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 06:46:16 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/5] dma/xlnx-zdma: Advance the descriptor address when
 stopping
Date: Thu,  2 Apr 2020 15:47:20 +0200
Message-Id: <20200402134721.27863-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402134721.27863-1-edgar.iglesias@gmail.com>
References: <20200402134721.27863-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Advance the descriptor address when stopping the channel.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/dma/xlnx-zdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index dd893bc420..e856d233f2 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -514,7 +514,6 @@ static void zdma_process_descr(XlnxZDMA *s)
     if (ptype == PT_REG || src_cmd == CMD_STOP) {
         ARRAY_FIELD_DP32(s->regs, ZDMA_CH_CTRL2, EN, 0);
         zdma_set_state(s, DISABLED);
-        return;
     }
 
     if (src_cmd == CMD_HALT) {
-- 
2.20.1


