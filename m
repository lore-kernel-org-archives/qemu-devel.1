Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE1AC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC5D21707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5DP95l9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC5D21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJKWJ-0001Aa-LI
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 13:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJKO2-0002oY-I5; Fri, 18 Sep 2020 13:41:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJKNz-0000H6-Sv; Fri, 18 Sep 2020 13:41:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id s12so6432090wrw.11;
 Fri, 18 Sep 2020 10:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9kcH0QEir+isSyR2eHUJqmP++6hsLCDL3S99R+ttmDk=;
 b=J5DP95l9Z6YtITaZsBXMvA5zs9c6XNvkGG9iYEiiO0+mGUcnYjU11RkaSVFCRrwanu
 aTIVZ69APuXvTddh+zKnmbmqS58NLRD4Jg02xJNDbOYLjHUU03jg7JgKQroTNrY4PRAj
 +1n5Iaaqdl2WSTFpmL330WBcUwABfObP2D2K+WbVeh8Gq8vhv1DalRYvNBph6b7VrYGA
 2x4n12sStSAa18cyCbwnYmL625Sk0uDPHgH9Hs+xHSCl3W+8lgFnKi9QmvdCJ5ulPNRg
 soY8qdzX4q75f2pMgY4W4DDKeW2FuefX2ScgQKbX+MXpipU4ukn5/1TnSZFPY7AixTuf
 k7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9kcH0QEir+isSyR2eHUJqmP++6hsLCDL3S99R+ttmDk=;
 b=Fu+Jp8pxzcQDIG1jbPoInRJb2hwd7YUWr4LSMRydQSZKsxYEozIglfGC3Z2OSPDHtT
 4h54VHQkKkya+2sVbDzfDk9/YS44vV9LcED+gUdppcgMo/tPc+4NYGMHt/YRVUJV6D/G
 k6yQuYKrnuNS4kZR7bz3IXZqm+uRMBT40qbwaFHRSxNq9G82pBtYRjCMwhi3C/hWlu9K
 DEq5jZbRspaERe317BWG/zu6PzB41EIGNoi6yCMGp+41iskjalMCQhwDIPrCXHCwM04Z
 fl/941EhHUpTUa9qI5r0HOhWOWXrblvS+kc1x/5xEmhbbuOvFNlevKGJoan+qu6pkdNS
 GlYw==
X-Gm-Message-State: AOAM5338AgOvMQUPLnAAQ+E7NqCOewe5eB0SCKklPyhXZWty6c54C1kf
 IxCAmVwBoUljxu+0FOaYKIOXvGnsuKA=
X-Google-Smtp-Source: ABdhPJyMeIFAEVZTdOzB0Pw8v/FaiviAtUokePHmYKA14Cy0LXKynCoXlxQ0mOM+17jsj/hxbXpcqg==
X-Received: by 2002:adf:f04c:: with SMTP id t12mr39660598wro.121.1600450886130; 
 Fri, 18 Sep 2020 10:41:26 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a81sm6356179wmf.32.2020.09.18.10.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 10:41:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 6/6] hw/sd/sdcard: Assert if accessing an illegal group
Date: Fri, 18 Sep 2020 19:41:17 +0200
Message-Id: <20200918174117.180057-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918174117.180057-1-f4bug@amsat.org>
References: <20200918174117.180057-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can not have more group than 'wpgrps_size'.
Assert if we are accessing a group above this limit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


