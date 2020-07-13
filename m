Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0D3C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F262076D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOYJFU2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F262076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3KG-0002Y9-9m
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FX-0002As-TM; Mon, 13 Jul 2020 14:32:23 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:39006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FW-0004Hm-8U; Mon, 13 Jul 2020 14:32:23 -0400
Received: by mail-ej1-x62d.google.com with SMTP id w6so18425359ejq.6;
 Mon, 13 Jul 2020 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NesnoNVp8mV726mwx9/wPWtnd6LQdD+PlLDlGLZ9HWI=;
 b=rOYJFU2RGFhHMsYarEeYkwV6i2BnjZ4R/9zefMmzON2/jxgmkY9mvXdG3okNQOsxx7
 Ow64FiMyWiOqn7YkM6jdMWJrkrUHeIet8gepIlQ1lU4RljejuDwpvqUdQFrcR0Bz9aYq
 TS0aggWkXDP7HzCLUar9B9WXSmnWICmcDnzNTbfFJY2emOXDW6zQGt6jz7HhQBCEtMuC
 ULj+It4Lc7Gxm2sXi8YCzUjq7cTH4afUgmdPRkZdlFvdxRBHcava6omoqzxZpmS8xIjM
 t9ZfQBuDQ+QmO79e3bn5vLsB2bpP7gG0m0LgTMhEkF8hTyFpGJERNbjvsP4hhsZ3s6Gk
 w0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NesnoNVp8mV726mwx9/wPWtnd6LQdD+PlLDlGLZ9HWI=;
 b=p+qDCT5GKLnynl7WRvR8IGBTLQV0EYDmwR76a7gatbVZc//g3+hr6OScivn7xkWiKA
 1Wb79EXGkBEZ/ImZwFBsRwnFs28EJTiNThwEMeda+i1HKHxJWXH3tLMPh/3a+Am5a3DZ
 5p/9jkBXxgffiKBYmudAGdU6GBGR5tg4E4fcx91Er89ZeGz/aRHVF0AjU5h62gTwh/SZ
 Tb/4bJb7KEb/DpUV7aKKatXgBi9PCzalYqafdP39cFEDLY3Y+xjOuNfpE7KoP0j2iW/s
 KfNmXLsAm4m5b+HTn4zYrrBbrtg63k9Cdun4kcv4xky/t38TNCFf3vMhymxWCoH5N/1B
 10vA==
X-Gm-Message-State: AOAM531WBqdyCtIn5KZDxymXLat3Q11o82w5wxucyKM56rg2DwuIwo28
 4ygDcXV/954/nMr7hVNLPg6QEw7KRMI=
X-Google-Smtp-Source: ABdhPJwTWTfC0FfKrws8ySY0SAa3FrmHcfKJgKroe1DsIXEwZ1f/NoSNqIBoESPRq4osKsWPNMycOQ==
X-Received: by 2002:a17:907:1114:: with SMTP id
 qu20mr1024365ejb.41.1594665140185; 
 Mon, 13 Jul 2020 11:32:20 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id ce12sm4353148edb.4.2020.07.13.11.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 11:32:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/9] hw/sd/sdcard: Simplify realize() a bit
Date: Mon, 13 Jul 2020 20:32:06 +0200
Message-Id: <20200713183209.26308-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200713183209.26308-1-f4bug@amsat.org>
References: <20200713183209.26308-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62d.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need to check if sd->blk is set twice.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200630133912.9428-18-f4bug@amsat.org>
---
 hw/sd/sd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1cc16bfd31..edd60a09c0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2105,12 +2105,12 @@ static void sd_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (sd->blk && blk_is_read_only(sd->blk)) {
-        error_setg(errp, "Cannot use read-only drive as SD card");
-        return;
-    }
-
     if (sd->blk) {
+        if (blk_is_read_only(sd->blk)) {
+            error_setg(errp, "Cannot use read-only drive as SD card");
+            return;
+        }
+
         ret = blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
                            BLK_PERM_ALL, errp);
         if (ret < 0) {
-- 
2.21.3


