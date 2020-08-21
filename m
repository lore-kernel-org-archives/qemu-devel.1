Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FB9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301A32075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VprKKmB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301A32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k98Ku-0001w7-F4
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k98Im-00007i-0K; Fri, 21 Aug 2020 10:45:56 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k98Ik-0000xE-9X; Fri, 21 Aug 2020 10:45:55 -0400
Received: by mail-pj1-x1044.google.com with SMTP id nv17so910307pjb.3;
 Fri, 21 Aug 2020 07:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vHcIytiPc8HOMvFjqE6nlfonDNLr38E8RDfJfGsnFtY=;
 b=VprKKmB+XJlTiOCtWnroEMICyLOu4Vc+KepDof0zHhF3gkpCHFb1eQ9zhhuRXutppK
 VS1gMgUSIkrv0zDJ/pucRBceYYcWnsL/hu7SKXBz/HsKvtzN05HgVyVXrLxgStpt/ehx
 xCCmA6O8012WjD2IVKAu7m+2KzHsdYXBacuymdgmkVXl7z9iqt5XrGXrA9KofFSjX+2R
 1ytgFjvG0/pP6AuWpEMwtbq2JtvVNscugZfn9dmd6y8pKxrtMCRNVZmA0yI0jA/cXZ0h
 0UgZFno3Zhi+xTO9ZtWSV8Zj27QQm8m3RRMWFLQUHi+X49xXefOUFy5smJdBsLGw6GKy
 YQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vHcIytiPc8HOMvFjqE6nlfonDNLr38E8RDfJfGsnFtY=;
 b=h3nIxWB0QS5K2E/TTXvEWB5yTBrXjUCLn3LHgmWYXgtQrYMkRuRVgEGJDQoWXd/CgR
 i7OqCUsvttrPUp3+jxbn6Nx88QtANvt8+fAMe/vxobK0vpZ6tux5PMk6TUU6FA1tmQkw
 NSYgwEr0PYn3KfMCIj1RphhfviOAilj9fSBWw3BHNsl/XU3hbRgUeSeUhMtnW4P1kZkg
 MWtrDScGTXJP16WxRo7FnP2qKjPnuHbWyj4PjYeypk1w0GWfsDRk7HJxr2jWfGeFBGGI
 g21ddURowP24lXl/EAxsxnVW86xCWiXjqXibGwWIpvd3J9rJYaPepFkVLY66zhVgIboW
 cU5A==
X-Gm-Message-State: AOAM533Rmg4q2UCJr8rfSB9VhCWoF5H0l+VQmoZjqJsSaWMZ9Krf6Dax
 6R2RE+kurnPRHo0gFPLNYKE=
X-Google-Smtp-Source: ABdhPJxPpJK7TfjOyIvFnc3aed8DRkFRIiVMdUdU+YMhmBuUX8TFCLHzqJjJrSPj2bKFqkK2b98DEw==
X-Received: by 2002:a17:902:6a8c:: with SMTP id
 n12mr2719851plk.124.1598021152294; 
 Fri, 21 Aug 2020 07:45:52 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id s125sm2785702pfc.63.2020.08.21.07.45.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Aug 2020 07:45:51 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v3 2/2] hw/sd: sd: Correct the maximum size of a Standard
 Capacity SD Memory Card
Date: Fri, 21 Aug 2020 22:45:36 +0800
Message-Id: <1598021136-49525-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598021136-49525-1-git-send-email-bmeng.cn@gmail.com>
References: <1598021136-49525-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1044.google.com
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Per the SD spec, Standard Capacity SD Memory Card (SDSC) supports
capacity up to and including 2 GiB.

Fixes: 2d7adea4fe ("hw/sd: Support SDHC size cards")
Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

---

Changes in v3:
- add Reviewed-by tag from Philippe Mathieu-Daudé
- add Tested-by tag from Sai Pavan Boddu

Changes in v2:
- fix SDSC size check in sd_set_csd() too

 hw/sd/sd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3226404..254d713 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -50,6 +50,8 @@
 
 //#define DEBUG_SD 1
 
+#define SDSC_MAX_CAPACITY   (2 * GiB)
+
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
@@ -313,7 +315,7 @@ static void sd_ocr_powerup(void *opaque)
     /* card power-up OK */
     sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_POWER_UP, 1);
 
-    if (sd->size > 1 * GiB) {
+    if (sd->size > SDSC_MAX_CAPACITY) {
         sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_CAPACITY, 1);
     }
 }
@@ -385,7 +387,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
     uint32_t sectsize = (1 << (SECTOR_SHIFT + 1)) - 1;
     uint32_t wpsize = (1 << (WPGROUP_SHIFT + 1)) - 1;
 
-    if (size <= 1 * GiB) { /* Standard Capacity SD */
+    if (size <= SDSC_MAX_CAPACITY) { /* Standard Capacity SD */
         sd->csd[0] = 0x00;	/* CSD structure */
         sd->csd[1] = 0x26;	/* Data read access-time-1 */
         sd->csd[2] = 0x00;	/* Data read access-time-2 */
-- 
2.7.4


