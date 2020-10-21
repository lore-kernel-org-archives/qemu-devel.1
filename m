Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1E5C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0BB2242F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJckA9U2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0BB2242F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIEb-0007hD-OL
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1j-0004G3-4j
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:35339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1h-0006IZ-Ok
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id q5so3462708wmq.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+Fm7KbLir3gbzmjKy+27eSKs45PUg9V/AzuCpZDRK/Q=;
 b=BJckA9U2TgiC+CxfBuvijCXXMaUfzkPWmqaDBx8HO6JNH6gaogOPzZLGozrWjTu46x
 XTz0jbJQLeBLigFgBopZdMMy2E+5xv6p9TCrb16908nc1++1fC1wVpp6OhLG0VWLbda5
 5e42Re/cufcyukyEKQj6h7+UUiwq3BrTl0p6ozYbipJ9dLn3WYut1QuBVf+S1B9N+Gk1
 KkQgV/RBgEwpgtH1uDSm5vfI5BI7r9DJfxe9T4gMgMpMGQe92+SMg4z3S4v3L0Qk338I
 d5vhhlW1cnou8N77tkIaOmHeNMehe3389IXkCNTEkp0juq9azyvS3XNuJ/6XwE/ua9xy
 HeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+Fm7KbLir3gbzmjKy+27eSKs45PUg9V/AzuCpZDRK/Q=;
 b=PUXobAKqJFFcPfxf3FVN1nJKY/8DT1JxLjDR00NRV8xdaZwAvSP6FSF72dQ3QsBMJ5
 SAGw3eCVpz8b5fDU+oSPIUIMBMW5TyQZ38yAIMz1XdAPXgBYZvpkty/KqVc/5HLyKDi9
 MXJwhdr+vbmEieg+K3uWH9It4av2RebosMDfeeTVpbz2BGAzrp4UlW3O8X47ZV9xgyTg
 pcY9zWGqz7PZkKrCJ6UHFRkpHNhPymn0ke26v165RYbd7baxiIADfPgWG70aharWDuX+
 9TU33Xfjb4FI4qfywejwyfS8r8sJbVt/WjrAluZRmRqaNZIvXd97MzKljgVELcU1133C
 QXpg==
X-Gm-Message-State: AOAM5304TgQVnttgmz3V4KY4el9JNYxljyxPx2xyTOP1Kk5KJn5NVHAl
 oTakaqh6h/1HiuR0k8hh1D1eXS1V+KY=
X-Google-Smtp-Source: ABdhPJyXZR7NSQEPtzfFgA+cILOxyz/oir9OSDeP9Ffxb2N9bdWfaYwgiQ6vdyLLGtlnl4JBwr9PrA==
X-Received: by 2002:a7b:c418:: with SMTP id k24mr4913652wmi.118.1603301752277; 
 Wed, 21 Oct 2020 10:35:52 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 133sm8735201wmb.2.2020.10.21.10.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:35:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/13] hw/sd/sdcard: Assert if accessing an illegal group
Date: Wed, 21 Oct 2020 19:34:50 +0200
Message-Id: <20201021173450.2616910-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173450.2616910-1-f4bug@amsat.org>
References: <20201021173450.2616910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can not have more group than 'wpgrps_size'.
Assert if we are accessing a group above this limit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20201015063824.212980-7-f4bug@amsat.org>
---
 hw/sd/sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4454d168e2f..c3febed2434 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -780,6 +780,7 @@ static void sd_erase(SDState *sd)
     sd->csd[14] |= 0x40;
 
     for (i = erase_start; i <= erase_end; i++) {
+        assert(i < sd->wpgrps_size);
         if (test_bit(i, sd->wp_groups)) {
             sd->card_status |= WP_ERASE_SKIP;
         }
@@ -794,6 +795,7 @@ static uint32_t sd_wpbits(SDState *sd, uint64_t addr)
     wpnum = sd_addr_to_wpnum(addr);
 
     for (i = 0; i < 32; i++, wpnum++, addr += WPGROUP_SIZE) {
+        assert(wpnum < sd->wpgrps_size);
         if (addr < sd->size && test_bit(wpnum, sd->wp_groups)) {
             ret |= (1 << i);
         }
-- 
2.26.2


