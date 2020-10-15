Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22451C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E9121D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOcBZ4mX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E9121D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSwxK-0007YP-Bw
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 02:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwug-0005RY-Gj; Thu, 15 Oct 2020 02:39:01 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwue-0006zN-LH; Thu, 15 Oct 2020 02:38:57 -0400
Received: by mail-wm1-x342.google.com with SMTP id a72so1892654wme.5;
 Wed, 14 Oct 2020 23:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9kcH0QEir+isSyR2eHUJqmP++6hsLCDL3S99R+ttmDk=;
 b=uOcBZ4mXVTJ9XkvFcrq3r2Bnv15i4xKLWGrZtNTz55Ne6+skMlh+oqPF5ARR5mQEiN
 4GQCnKYDtS8SFb5xPfPnuCRgDTOBlW/8jSgLXwKVNHPk9spePYlgA+NlZ/A2Q9UOuJOP
 gwkVuzyRBNUuxPoVpU+e6+mC40z4DZhRh0xXJPAalovJDjRFTXosnOfsyTFa7csKJqtz
 yTVh8TqvB5Hxs6O2p4Pp6Am+Q70j8/B5OJIWzJAsJUXUGzemRfdCxZhhY61qPduml9Hj
 PEjxmwvU4moRD0ItnIKfq0YwS4wKQYPeP5BZCQth5AAwsfK25tqVZebmI6hPAZTZRbXZ
 wOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9kcH0QEir+isSyR2eHUJqmP++6hsLCDL3S99R+ttmDk=;
 b=SmdTQMK+I5U7JvHB+oATuoDX26rAzrQYaLDZC39VGpeWRYPYpSlWqoWxAP91XVcSXL
 ITmg1Ftiq72DAfrTrGIoCcyOZV0N8+2xrJbs/qacNyACx0meICd6WdR3FTAtI+7Zm1kr
 ScIYE9jPedqrpIai8ZXLFm8Qi0LhpoKNhkT7DClNYaQL2VEO2JxgMdKPcA4qU1hsde/0
 7QI3GJ5LBFyWOKP42AS2qu9eVa+UyTv2+FKmdVyi2gi8IgmdhXwL1qgqqdxNM1BdliPF
 UsPFpJCh0QE4aTNEAly6fRw220KoN3Y5l3t+8mlUhCjlcxw7j/QHiaJ2OL9OTyv4Qcka
 1g3g==
X-Gm-Message-State: AOAM532n/XtdSmPA9VTTRTCSnzx9UTWhIAZez5zQzceUMZoYHpP5SkEE
 ijDXyGHJxiTdij2yPKTbbb/ZHwP9bjc=
X-Google-Smtp-Source: ABdhPJy5vBlWQffFEgxoiXD7GLKfpNW4ySbn6pKwnjyNBei3SG8fGfteivcXUWl3xY6glO2FHZWsHA==
X-Received: by 2002:a1c:2d8f:: with SMTP id t137mr2279825wmt.26.1602743934280; 
 Wed, 14 Oct 2020 23:38:54 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c21sm2751483wme.36.2020.10.14.23.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 23:38:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] hw/sd/sdcard: Assert if accessing an illegal group
Date: Thu, 15 Oct 2020 08:38:24 +0200
Message-Id: <20201015063824.212980-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015063824.212980-1-f4bug@amsat.org>
References: <20201015063824.212980-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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


