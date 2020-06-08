Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0DFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1FC204EF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvZ07wCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1FC204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIiB-0003La-4n
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbb-0001Dl-Ff; Mon, 08 Jun 2020 10:18:27 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIba-0004V9-KJ; Mon, 08 Jun 2020 10:18:27 -0400
Received: by mail-pf1-x442.google.com with SMTP id a127so8588024pfa.12;
 Mon, 08 Jun 2020 07:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=b35v0KP1s9AjIF9HvJezGHZtrCpDZpVSHPfkMiThnkk=;
 b=pvZ07wCunCmhMVtDdajtNK7blyXfjEaZS+HgsQZ78xQVQhY1Z5qPUC2FtaqmOixWEx
 1+nhqJOgOJz/3OLC9vgJChcSVV9VjmHWY5AxKqe6+wtz8GfphlCr7cQScdgYElDlDHOy
 Q/Oa8kSYtoTovHzOiMgflm9+RO32tv3PHWGWKWjWsuMrnKp2ohcRjzqFTvnYl3qV66As
 6E3agBjMKSuZNyjM0c4zIucI+XvNyMiil97TSwOjp14DqA4nZWZEC/Dco5YU+9v8KNXb
 BLlc/Q+vvpWNNWF52JPYGkN1LjtI0ZSEzU+q6hWmaFTZD8rgUQGgCyDUxNGybudNc3BF
 UMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=b35v0KP1s9AjIF9HvJezGHZtrCpDZpVSHPfkMiThnkk=;
 b=aH5q4lnk4rQ+Ovuft2H7wa2uuVtyhaElRSHhsDsV96NjYJiTV7iJJZVLOwjD840jMX
 mT6jHkrVFbv9MZuZclWCmeB0bKro0WpwsFlmyuzVKFdp1mFqynrg5QtUUVTcqafdDS/e
 IccW8buGpRAtS3zdfYdpPCMQ3jNtSHZg9Q6Kp/9hYJmyeDGc8wKxyBfzCvdpZO1fm1qy
 /Rp6D3maKURoZv+2/LYkkTUPxXxZK9tOX/XGvzSA8FnsVsXkIWPuPblu663r25mdZEbc
 YX4gNkZQvEDg25LSqG9g6Gzs9g0OVAH8gIpOgWr8oyYw5E51Ru2s6z4uhxouPZK5qVFK
 g72A==
X-Gm-Message-State: AOAM5306/VD+3To5x7gzWzLrKScF0VIyQHFlhl8AiEf62lX6p5nh/OQO
 xC2if4TZZ58Y5FnfAS5ryeU=
X-Google-Smtp-Source: ABdhPJzkCf7PEciRd+bdNfHQDY7H0HGHxNCvdhaqEhGDvUwfTWGj8q++WbYHaEKbeP5PrMsmvWNh6g==
X-Received: by 2002:aa7:972b:: with SMTP id k11mr22038690pfg.299.1591625905071; 
 Mon, 08 Jun 2020 07:18:25 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id b19sm7292575pft.74.2020.06.08.07.18.24
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 08 Jun 2020 07:18:24 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 08/15] hw/riscv: sifive_gpio: Do not blindly trigger output
 IRQs
Date: Mon,  8 Jun 2020 07:17:37 -0700
Message-Id: <1591625864-31494-9-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

At present the GPIO output IRQs are triggered each time any GPIO
register is written. However this is not correct. We should only
trigger the output IRQ when the pin is configured as output enable.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/sifive_gpio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_gpio.c b/hw/riscv/sifive_gpio.c
index 0d0fd2b..aac6b44 100644
--- a/hw/riscv/sifive_gpio.c
+++ b/hw/riscv/sifive_gpio.c
@@ -76,7 +76,9 @@ static void update_state(SIFIVEGPIOState *s)
             actual_value = pull;
         }
 
-        qemu_set_irq(s->output[i], actual_value);
+        if (output_en) {
+            qemu_set_irq(s->output[i], actual_value);
+        }
 
         /* Input value */
         ival = input_en && actual_value;
-- 
2.7.4


