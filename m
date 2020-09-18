Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4CFC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5407921707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp8nqvXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5407921707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJKRB-0004XM-3M
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 13:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJKNx-0002nS-6a; Fri, 18 Sep 2020 13:41:25 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJKNv-0000Fg-IO; Fri, 18 Sep 2020 13:41:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id z4so6443834wrr.4;
 Fri, 18 Sep 2020 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BM7THxJfGf+b7XY8piPM2aMZEPnFkfmBjlshGc2heOo=;
 b=Kp8nqvXCh2AozmISeyeO6RDwlKAzJSL4/UIlyk4KnMmav9o4SkaNSVkr13F7XiSFOT
 Jrbhvq8ydOxDF2UgXw4fKkgVy1fQlgTYA8UIl7OhUxICJhHtC9I3xeU1CVjR22DEjAPs
 LVHvRmFovAJw0EHBHDTizsxz2Iu04wkd5G/jHvG/70dzTebvNlfiDMzGDlQO25TZZEVm
 TRTRpDVVoKXFjXM1lzeQU0OxkY33oyd9UTuHkkP3vrqK8DUm1+WnX+CDb7/jhaQtFbDd
 QQwbYMU6QSX7IhGBGBlqRIZvNGlY374yJJ/ZtE1lyq9IGpRiIwCk9K1HckLVKdI/YRXI
 LPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BM7THxJfGf+b7XY8piPM2aMZEPnFkfmBjlshGc2heOo=;
 b=plAlL4m2uQQkFDH+GtL/3N3ZJLooGmOqe5K4jcCrOE47kbIvgJAtq8kIr52RX/63Gi
 NY1QrRzbVpv4iDLf7WKNOQh3DkA/0HkrY1byOvpfVpsCQsSkAAomx9XFAPjpZIesttr1
 DRtShcGOmfzmUJtmrgTXyi1nlzC+VtdDatVX2maQgHnYCv90nTvyDmcVgtRd/Fl9VM4a
 SChVzAVchhYoYGq4iZT9IBOkkNuO9XUewfMBA3mi3QQX59YrOwL70JWDH4cx20kERCWX
 8oO8dkTf55H94d480gvV8KOHHtxI0mT7W1AiHgtsMGPoKSXObC9uDA3la3kqlis6rcsn
 WjeA==
X-Gm-Message-State: AOAM533IvKqPKce4hceyUnfUQmfdPy8t2GAKx1XOVkfCX4EpZ1L/rr/r
 rEcuWJC57kVbR7CaR5L+174eu6pJlQo=
X-Google-Smtp-Source: ABdhPJwFXUqbCrZ1defHjZOJmBn1tgb4uX6EPPvWCEpo2HGADi8/i2q75eKBcz3ouS3xDJeiroJ/BA==
X-Received: by 2002:adf:df05:: with SMTP id y5mr42456744wrl.39.1600450881480; 
 Fri, 18 Sep 2020 10:41:21 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a81sm6356179wmf.32.2020.09.18.10.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 10:41:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/6] hw/sd/sdcard: Introduce the INVALID_ADDRESS definition
Date: Fri, 18 Sep 2020 19:41:13 +0200
Message-Id: <20200918174117.180057-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918174117.180057-1-f4bug@amsat.org>
References: <20200918174117.180057-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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

'0' is used as a value to indicate an invalid (or unset)
address. Use a definition instead of a magic value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2606b969e34..30ae435d669 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -53,6 +53,8 @@
 
 #define SDSC_MAX_CAPACITY   (2 * GiB)
 
+#define INVALID_ADDRESS     0
+
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
@@ -575,8 +577,8 @@ static void sd_reset(DeviceState *dev)
     sd->wpgrps_size = sect;
     sd->wp_groups = bitmap_new(sd->wpgrps_size);
     memset(sd->function_group, 0, sizeof(sd->function_group));
-    sd->erase_start = 0;
-    sd->erase_end = 0;
+    sd->erase_start = INVALID_ADDRESS;
+    sd->erase_end = INVALID_ADDRESS;
     sd->size = size;
     sd->blk_len = 0x200;
     sd->pwd_len = 0;
@@ -750,7 +752,8 @@ static void sd_erase(SDState *sd)
     uint64_t erase_end = sd->erase_end;
 
     trace_sdcard_erase(sd->erase_start, sd->erase_end);
-    if (!sd->erase_start || !sd->erase_end) {
+    if (sd->erase_start == INVALID_ADDRESS
+            || sd->erase_end == INVALID_ADDRESS) {
         sd->card_status |= ERASE_SEQ_ERROR;
         return;
     }
@@ -763,8 +766,8 @@ static void sd_erase(SDState *sd)
 
     erase_start = sd_addr_to_wpnum(erase_start);
     erase_end = sd_addr_to_wpnum(erase_end);
-    sd->erase_start = 0;
-    sd->erase_end = 0;
+    sd->erase_start = INVALID_ADDRESS;
+    sd->erase_end = INVALID_ADDRESS;
     sd->csd[14] |= 0x40;
 
     for (i = erase_start; i <= erase_end; i++) {
-- 
2.26.2


