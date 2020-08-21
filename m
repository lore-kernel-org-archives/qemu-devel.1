Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB13C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901C02075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW7F0ENT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901C02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9B6R-0003Dg-S8
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArX-0001uO-6e; Fri, 21 Aug 2020 13:29:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArU-0001Gw-CF; Fri, 21 Aug 2020 13:29:58 -0400
Received: by mail-wr1-x431.google.com with SMTP id w13so2335082wrk.5;
 Fri, 21 Aug 2020 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7MDjqCYoGN9RsgmgtLGjf6jZggXntu+eUZw2U4ch4n0=;
 b=MW7F0ENTmRAsnb35u56Sy4I7+q5C1nGvAV68vJlxQAT2lLQcSrTDTLzTCMcDgxs84p
 wcd2WW24QQpd6254CONOUocMG3gt0ymPzcvfhGOwpIOBZpx9cxmBShRBrblh1ltCLFSv
 PhVTJxWDQyqja2yuhfN04Z3/7xwFve2UsI9NgFqluRF5TCTZ3EjBXLj+HOraG4Ezeswj
 QBjXkf3DWSnhIwIgkVYCzur/0f+eNMGthxmNpMj/n7Dl+KhY09WrCG9YBApxqDlkrMTu
 RaOL+Nje3k+k8ilR1kfSAnghsH7x+oajKFOdVhuvIVBWNs8xTCwu0NRrjhF666fhHIt+
 peHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7MDjqCYoGN9RsgmgtLGjf6jZggXntu+eUZw2U4ch4n0=;
 b=ddSX3nzSU97/CB3QmVRGJcAEoGu99z1qjcb73jMFk/TIy4mZipm9Uq8mebMB/1UDHx
 dj9J7y6Iqf1yqLcF/Qpydm62XJcBk7UTqs66cTa3ScL8YiteXMccpFxXxdZqJ4jnlh2o
 VBW0o/ToHhF+3pUYLNRaxmV/3CSB5cLddAjnqAwVS3oBlsMdMyZQUjwCTzh030hnClXs
 NvzIcrr533rnjBU3s3Yexx52VKCQ5qIXcWu24OuaeqMkIIDeFRT0LxmVYM10qsM3nylO
 SnEBppTbuVDyLh2XRiM6VsCWmcaxKdb/JVdT4AZzPtVip/iJhucXpy8f2O/VFzY/caFe
 Cslw==
X-Gm-Message-State: AOAM530UGvsYVZWKUwpA9gNXeN1uO9d9Kx+TjD9vHqJOdRQ+UsUBCXuP
 GLU3O2DtpCdI7CIOW2N8ifXXUtIg8CQ=
X-Google-Smtp-Source: ABdhPJxBX/2wYha+rIGx/AQJx4hoy7a3lGS+JtbJLmoGscR0j9TxuodKjYsi+xtTrHwS2zRQ0kNT0A==
X-Received: by 2002:adf:ab57:: with SMTP id r23mr1834762wrc.386.1598030993404; 
 Fri, 21 Aug 2020 10:29:53 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/23] hw/sd: Fix incorrect populated function switch status
 data structure
Date: Fri, 21 Aug 2020 19:29:15 +0200
Message-Id: <20200821172916.1260954-23-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org
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
Message-Id: <1598021136-49525-1-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7c9d956f113..805e21fc883 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -807,11 +807,12 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
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
2.26.2


