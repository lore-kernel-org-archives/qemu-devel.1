Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D142C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1BB2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZH+HN4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1BB2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k98Jq-0000wt-8B
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k98Ij-000072-5L; Fri, 21 Aug 2020 10:45:53 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k98Ih-0000wm-Cp; Fri, 21 Aug 2020 10:45:52 -0400
Received: by mail-pg1-x542.google.com with SMTP id s15so1093666pgc.8;
 Fri, 21 Aug 2020 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kw0/yVwW5HOT9VWz8EEeWR+3L1WvMdNlQltiSWoKsAA=;
 b=EZH+HN4UTAkyucRHh8zt2c1WxVspdxTV3VKJXmLu53h1Ye8goiqC6t/INRuA0HhVfk
 mYbM042/enxCHkVLyn0jG87BnGqFUGdhaaJuHfBwkPAfBQQgs7rA0547dksiTd+61B54
 9BF2viSqkSo/HKNGJr8oiLLrCBtg2fFc0uTCPiDJmgk/175PxdWp65drYVQCC9laN3tR
 8NSwIFtk4IKQQhpZNQIyS+OlzQkOpMzmaV+4IRZ0GWJi9kx9LJnHogptYSy1zdI/1w0F
 Ikg28f5B0etMs3jdlDh+ICh7GsbgYrNbAbb8u97ws0MTyrBCiF2xS7crc/O8DEjM+3cF
 TQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kw0/yVwW5HOT9VWz8EEeWR+3L1WvMdNlQltiSWoKsAA=;
 b=F3R8yQnLvzIASFgKPkuK0542cBXjwewE0Y61SwGBLB3tKdUjOuousdK07MT7EW4HBu
 JbC+wcnU1B7S7BaqALvjm32lVy1lum2XpvhUTlm2ydjleo7WO/k+sMONNvuvh0f2mAXT
 2xkBwlboPIjsKdMI2Xvsti9YYFDOicgRrhWbPoINum4lQmyZ6Mad2ycBpQsjS5acXqTY
 P+4LvqDFHY59cCgvRnsf4f78ufTtbwRZg3nuDGe3jpC1MNRvD3geq4lIGVIP6sGhTn0d
 LlZ8uptVSmlnFTnaKls4qoJ73TXl7XTFOywxYJ6+tq4qFpM9FvPAsvbbLV8MnoELhrwG
 eM2w==
X-Gm-Message-State: AOAM530huxJTMH7NL7uLF2uZSQ6QTS89aGAtV2Ugzvq/nzp02lnSQbyF
 eXBVcMtK3x47vhCJZr7BsMc=
X-Google-Smtp-Source: ABdhPJyO9YnsRjGdksFLDeEkRECNAJCsepV2QJic6uJ0hlUtD7yRsuMnIYJFgL+s3O0vePobR8CoAw==
X-Received: by 2002:a63:f913:: with SMTP id h19mr2616268pgi.427.1598021149579; 
 Fri, 21 Aug 2020 07:45:49 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id s125sm2785702pfc.63.2020.08.21.07.45.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Aug 2020 07:45:48 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v3 1/2] hw/sd: sd: Fix incorrect populated function switch
 status data structure
Date: Fri, 21 Aug 2020 22:45:35 +0800
Message-Id: <1598021136-49525-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

At present the function switch status data structure bit [399:376]
are wrongly pupulated. These 3 bytes encode function switch status
for the 6 function groups, with 4 bits per group, starting from
function group 6 at bit 399, then followed by function group 5 at
bit 395, and so on.

However the codes mistakenly fills in the function group 1 status
at bit 399. This fixes the code logic.

Fixes: a1bb27b1e9 ("SD card emulation (initial implementation)")
Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

---

Changes in v3:
- add Tested-by tag from Sai Pavan Boddu

Changes in v2:
- remove the pointless zero initialization

 hw/sd/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index fad9cf1..3226404 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -806,11 +806,12 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
     sd->data[11] = 0x43;
     sd->data[12] = 0x80;	/* Supported group 1 functions */
     sd->data[13] = 0x03;
+
     for (i = 0; i < 6; i ++) {
         new_func = (arg >> (i * 4)) & 0x0f;
         if (mode && new_func != 0x0f)
             sd->function_group[i] = new_func;
-        sd->data[14 + (i >> 1)] = new_func << ((i * 4) & 4);
+        sd->data[16 - (i >> 1)] |= new_func << ((i % 2) * 4);
     }
     memset(&sd->data[17], 0, 47);
     stw_be_p(sd->data + 64, sd_crc16(sd->data, 64));
-- 
2.7.4


