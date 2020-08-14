Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36291C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED266204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/6H4pwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED266204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6cvH-0007PK-22
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6clr-0007X6-Pc; Fri, 14 Aug 2020 12:41:35 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6clq-0002fS-6w; Fri, 14 Aug 2020 12:41:35 -0400
Received: by mail-pj1-x1042.google.com with SMTP id l60so4661744pjb.3;
 Fri, 14 Aug 2020 09:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OQuHkgiSAag0FaRCedSN1Lrezlh8zBNDZa5YbEmYI+E=;
 b=b/6H4pwDjKf3Bn0itTfx55DAd5teyk8GKzf2tQvYVcGzV8R2M8VzshOnEa2mTCurub
 DKspAI09nCUbyodbg2GOWposA+BRuxSqK2HRuitWh3ZoAI3AzxEIQnaFcAf8a8vVLbwT
 3YPh7ODQoDMuvOzJ7xNYPJkHoz6US/I7VLdzpUnE6qchL39/uBqn1BFGkXAFsBK0GQiF
 OoLkrR4PknrLmizI6SJwTXtc6EqsK2P6dkK5tgRWAfLitkAGVQxzMbEPf6C5j4U0R8hi
 uKvI/SLHZcAjjdQWPd9Cy077BCVc8B7+SEGdUbbNMaJ+tJRUIF/KYGPDAV3mOhgWV55p
 phYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OQuHkgiSAag0FaRCedSN1Lrezlh8zBNDZa5YbEmYI+E=;
 b=po28C0nc6tLetKfFqTZHnKDxWwSOHg+HoEESNGiHyuHS1yPENcWL3fv98YfpA9X9Vw
 pA3DfnY8Q5wZpCOko1IFz4N4AUJwAN7bIjag9GcjfQnBpILlMX3fiPCRYWVjFFe0CUR+
 Rhjr/X/TyAOzZVKvryM8wM0Z5e3v67E+OVD/+djsnOf4njaj7IO04i5akdFsHwdHDSvX
 NKyf3sr5t/8/Aug7ZBFDlRg6Nj9WkZ3uFI1I1QQHJX5RzT5X9rosVSgyc915xiuXJcki
 YxiR+XqEoY5cgjheLbrZZuoT8Vcbvri7MUBrUJZb+JcsXgC8+xa1WnBSVYLNocDMrj36
 NYFg==
X-Gm-Message-State: AOAM530WTfn4/92GUldCWcWZf6+mnu3LGsEq9UzUX/G5Ozfv+6piOKqb
 JOtjIcz3opv6rkdG8SfemPulO0QeLhdTmYws
X-Google-Smtp-Source: ABdhPJxT50zYt27U7Nqafr+aS32iFqx3WmA2xpLflK6DYnJVZ7Ynt+2Ny2Ifvy02ZauecKvGg8O9Ew==
X-Received: by 2002:a17:902:523:: with SMTP id
 32mr2536567plf.176.1597423292358; 
 Fri, 14 Aug 2020 09:41:32 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id 16sm9836332pfi.161.2020.08.14.09.41.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:41:31 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 07/18] hw/sd: sd: Fix incorrect populated function switch
 status data structure
Date: Sat, 15 Aug 2020 00:40:45 +0800
Message-Id: <1597423256-14847-8-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1042.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/sd/sd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index fad9cf1..51f5900 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -806,11 +806,15 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
     sd->data[11] = 0x43;
     sd->data[12] = 0x80;	/* Supported group 1 functions */
     sd->data[13] = 0x03;
+
+    sd->data[14] = 0;
+    sd->data[15] = 0;
+    sd->data[16] = 0;
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


