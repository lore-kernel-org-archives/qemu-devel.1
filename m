Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1735CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF5C2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qih+ofFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF5C2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7c3e-00082y-3W
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 06:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7c1E-0004K1-GR; Mon, 17 Aug 2020 06:05:32 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7c1C-0005vJ-QF; Mon, 17 Aug 2020 06:05:32 -0400
Received: by mail-pg1-x542.google.com with SMTP id s15so7874424pgc.8;
 Mon, 17 Aug 2020 03:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Uf7YMX8aHpkB8MRW3xqp8Xl9vshgONc70gJ+XmLT41w=;
 b=qih+ofFGQlUmWGCmLyMjl4RCWfmEX1D/hmUYaJu3dJaxBd7XbiqQqP7f94Lj57ZtsW
 ekV+t+rKZ5gXzmccVXDRhrAcD6ONFQ4HP8IIXQh44chBLmxav+SX+0z9sm/ZSzKptpI0
 CgdmVVPGl6c/H5vAd8gk6+pJpEuQhWJQMB6L3QFhefNbFim+GrOUp6h+WUfjI0Qo5z4c
 U1e47my1WGAZ9pm6exk6YwcD/cSWZRWlkY7vT66IKHCUuJTwX9esJ34W/ZAkd330RWse
 bbeCg7P9t+n7rq9z02lkUPYV/1/TmWzXQk9xLHudjqPkLTyHjOHfIaIq/T98xYY8qdmd
 mb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Uf7YMX8aHpkB8MRW3xqp8Xl9vshgONc70gJ+XmLT41w=;
 b=uaNQx/gBxMMN2lE07iE+byWX7T7YJnGBzVFBq0tzSVrprA0b0QdwLH8LmGl4qNppGK
 RJhiNVql7mFtRKzO5NCbopy52oz5sfop3SEAtHOXw0rghMCJZo5PjfabfczCM94pU8Bz
 9WVLo4a88VsXUgnYnTqdLgMfeRUt8KWjDE5GHOUWMsdJr0SQrWW0sf9c7Ys+JkfORcfj
 hiuRRqQyE6CfWDLtF4B/4kfjuwAfCGbF4J/AVK8nlRITRZaoFqxMzHCPQPgtOzXKitAZ
 GC1eJvOCt+Xt8WfRlXSCXRIPfZcic6nlUY1+9qLgd07i7+pdH3Z/CbHduw7oVjQUyhrP
 FThw==
X-Gm-Message-State: AOAM532lNCqglMUR7VSsTJqhCJLaSYbKfFnrdLjqhJBaVr1Ybgvdia5N
 aoNyDMOZIc/xr6PgUND8h6UMEHVgkMY=
X-Google-Smtp-Source: ABdhPJw/5ZKrsdbz7veRRxC+7wq0uevgmAObp5pt+Bspm1T1BPFXW1WBwyhC4FKlFv1gx3Zn2ZQsIA==
X-Received: by 2002:a65:6644:: with SMTP id z4mr9649047pgv.391.1597658729154; 
 Mon, 17 Aug 2020 03:05:29 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id e20sm17036743pjr.28.2020.08.17.03.05.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Aug 2020 03:05:28 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
X-Google-Original-From: Bin Meng <bin.meng@windriver.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: [PATCH v2 1/3] hw/sd: sd: Fix incorrect populated function switch
 status data structure
Date: Mon, 17 Aug 2020 18:05:20 +0800
Message-Id: <1597658722-12922-2-git-send-email-bin.meng@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597658722-12922-1-git-send-email-bin.meng@windriver.com>
References: <1597658722-12922-1-git-send-email-bin.meng@windriver.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

---

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


