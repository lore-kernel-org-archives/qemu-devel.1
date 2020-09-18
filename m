Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9554C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D44C21707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDjqhXrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D44C21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJKRD-0004dM-BE
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 13:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJKNw-0002nA-50; Fri, 18 Sep 2020 13:41:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJKNu-0000FL-IT; Fri, 18 Sep 2020 13:41:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id w2so6083905wmi.1;
 Fri, 18 Sep 2020 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mHMBZwFybrG3Wb5VMsP3egLDE4ZsHJicDRun+ytDKB4=;
 b=iDjqhXrQBlXTZoroY32efXfJq2RtOCHrjqnSmbeDF/n0kpABMlZfcq+VaLeYzJgCrr
 W3YwbCVHvvj4kmI8qUxc9UZWNwbMf9TXN9rmX5nNGDAjXxako0LMrrKGrSSZyl/mqMYS
 kJ1P1NPL7k72jTlK5YRmMl8xgncf8Qnbl7zVjw82Z7HoSxYBpu55WMl8R18pQ1Sc0QiO
 ATFT9dulauKeQGFWCKaNZD9DGBow4vpjLKwthnggrKtJRDPsvYiYp4PNjJbWmYr72989
 lELbLgt2BaxG3XdDB29Ab31tBmyxxjHnnF7hbEUe9LiL9WelEwu6243XHMn5JCeUjP+1
 a4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mHMBZwFybrG3Wb5VMsP3egLDE4ZsHJicDRun+ytDKB4=;
 b=Gbon1O1FB04x8L6aPJts2/C/g8AsUu3maMx0+paiSfwEv6esuOR11O4yCWYJr4JIUv
 R6thNbN81V7ikx8leg3qqjdes2J1nEURGMINAqpLcLksR+PMQOQQfn0j6gIBwQjZmwOl
 IdBVyR7oY6Y6ssxKc+s6ukSB8kGP44Ug6XDr7YcktcJu0I1rPlPBBYXvVbX/T6fTtFrd
 NVz9xJfJOzhjwqVPC71dJyWioowecVbUZvLFhjWwtQ6QAjHAS8I2b2TJJ8vT6+qxL5qO
 9xdlV/LRBgUUSOY7L9SWgMnwXC4gkuMOSdI/m1CsITWnsiQ9g9eHpt6mMR3lPXQXTo74
 y2MA==
X-Gm-Message-State: AOAM533bbJDs+pXBX99O4C2lhqzV3eIXnRZfN31d62hQ8XmlpqtJsaqW
 rRCjeKyV0DbJrL52S2LSPkJyTJSzouY=
X-Google-Smtp-Source: ABdhPJwHDsIzpBjkWdnd7DvWVfxyk62dE3wOvgXi/8eskd5mdSlb9HoSpi5Sq0rl3Rp41AHWjOzBeg==
X-Received: by 2002:a05:600c:2182:: with SMTP id
 e2mr17103210wme.102.1600450880358; 
 Fri, 18 Sep 2020 10:41:20 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a81sm6356179wmf.32.2020.09.18.10.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 10:41:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/6] hw/sd/sdcard: Add trace event for ERASE command
 (CMD38)
Date: Fri, 18 Sep 2020 19:41:12 +0200
Message-Id: <20200918174117.180057-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918174117.180057-1-f4bug@amsat.org>
References: <20200918174117.180057-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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

Trace addresses provided to the ERASE command.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 2 +-
 hw/sd/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 00128822224..2606b969e34 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -749,7 +749,7 @@ static void sd_erase(SDState *sd)
     uint64_t erase_start = sd->erase_start;
     uint64_t erase_end = sd->erase_end;
 
-    trace_sdcard_erase();
+    trace_sdcard_erase(sd->erase_start, sd->erase_end);
     if (!sd->erase_start || !sd->erase_end) {
         sd->card_status |= ERASE_SEQ_ERROR;
         return;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index a87d7355fb8..96c7ea5e52f 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -46,7 +46,7 @@ sdcard_reset(void) ""
 sdcard_set_blocklen(uint16_t length) "0x%03x"
 sdcard_inserted(bool readonly) "read_only: %u"
 sdcard_ejected(void) ""
-sdcard_erase(void) ""
+sdcard_erase(uint32_t first, uint32_t last) "addr first 0x%" PRIx32" last 0x%" PRIx32
 sdcard_lock(void) ""
 sdcard_unlock(void) ""
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
-- 
2.26.2


