Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D50C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB609207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCb9xuHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB609207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorQY-0001y1-15
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorP0-00009d-FY; Fri, 26 Jun 2020 12:40:34 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorOz-00060y-0S; Fri, 26 Jun 2020 12:40:34 -0400
Received: by mail-wm1-x342.google.com with SMTP id o8so9407571wmh.4;
 Fri, 26 Jun 2020 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MjRNdoa0rZpF8KkV/ND0ssqMkJTZ9vSTBVaUds1+aIY=;
 b=uCb9xuHE8MQXOv+/Ei8FmzjMOikpF/m4fEqifA9IaHPVT3wjFiFBed2XZYcRI2x/+E
 To5p6df7TP0PBYNsl68si/ZZJySD/Uk0l1K4RTzyyjBSZWqaN01ujQT+9AK2w2cnTe2P
 rXiMNd4dw1qtAKyimhT8peXS15LJoKQon8EP9klrDimh2NARdYP7qYZCFBQ9gGRC8rth
 QKUt5II4RJ2uOiS2pvwAVuebrDHOhNj/8Y1S8ZZIKJYupWXnzPgtXfW8wCeMxeFPp2w0
 vJmWfS0SPytUgyxXVSSB0IL1DteuQB9Y4tWM8W2OvhegyalGyvzvfA50ViYYDR1rlg++
 +qpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MjRNdoa0rZpF8KkV/ND0ssqMkJTZ9vSTBVaUds1+aIY=;
 b=Z2nm9HrMH8P5PYoO6sxdW7p1VGjAtKcvZKZlqGRLruhUH0DsGMITX101VexBvmduBO
 VqcZVELta6TmbtsQe54PAAZEiKBWedM3oFhCG4lC6i598faBVKlmWDywqVefwFp/2SC9
 rrLodqb/wKhgH8civ/GjRjYcR4gfCq4ctj1+GvfQ2YrWWOyn+fFwN5eOqKR1WVUVodRw
 NmrBPpeK4bMTuqAlcNOiM5ZEXGIqE5J0/A26NxO5aFVJXS7myQohMc/YS+DWAJBYSud1
 YRtnj1NM3FBLFl0v2raeJKtCIEz3JzUjQFJO2PYWi7mzWc8picdRE4LOT1T/+Xu0Jq3B
 OgQQ==
X-Gm-Message-State: AOAM530Jad6NNhIcbWLdXMU+8G4mFqwZ+yflxC7E8cpcXFTv1MEtUzYj
 GohmYqQnqoGUZJnLmhNDkSSI4ZcS
X-Google-Smtp-Source: ABdhPJzGDnjXwPamD3tuFV8jgjnEpA3RXHctIpg58RG7e/2qrVEKT46DkUGOFy2FEguP26RWk+Rxpw==
X-Received: by 2002:a7b:ce87:: with SMTP id q7mr4541569wmj.39.1593189631138;
 Fri, 26 Jun 2020 09:40:31 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f12sm24623646wrw.53.2020.06.26.09.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:40:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/15] hw/sd/sdcard: Update coding style to make
 checkpatch.pl happy
Date: Fri, 26 Jun 2020 18:40:13 +0200
Message-Id: <20200626164026.766-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626164026.766-1-f4bug@amsat.org>
References: <20200626164026.766-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

To make the next commit easier to review, clean this code first.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/sd/sd.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 97a9d32964..cac8d7d828 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1170,8 +1170,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_start = addr;
             sd->data_offset = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+            }
             return sd_r1;
 
         default:
@@ -1186,8 +1187,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_start = addr;
             sd->data_offset = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+            }
             return sd_r1;
 
         default:
@@ -1232,12 +1234,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_offset = 0;
             sd->blk_written = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
-            if (sd_wp_addr(sd, sd->data_start))
+            }
+            if (sd_wp_addr(sd, sd->data_start)) {
                 sd->card_status |= WP_VIOLATION;
-            if (sd->csd[14] & 0x30)
+            }
+            if (sd->csd[14] & 0x30) {
                 sd->card_status |= WP_VIOLATION;
+            }
             return sd_r1;
 
         default:
@@ -1256,12 +1261,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_offset = 0;
             sd->blk_written = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
-            if (sd_wp_addr(sd, sd->data_start))
+            }
+            if (sd_wp_addr(sd, sd->data_start)) {
                 sd->card_status |= WP_VIOLATION;
-            if (sd->csd[14] & 0x30)
+            }
+            if (sd->csd[14] & 0x30) {
                 sd->card_status |= WP_VIOLATION;
+            }
             return sd_r1;
 
         default:
-- 
2.21.3


