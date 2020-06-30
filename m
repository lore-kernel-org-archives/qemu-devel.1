Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0968FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9731206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRQ4E4B9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9731206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGVE-00031U-3P
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTn-0000xF-CP; Tue, 30 Jun 2020 09:39:19 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:36171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTl-0006Hg-TT; Tue, 30 Jun 2020 09:39:19 -0400
Received: by mail-ed1-x543.google.com with SMTP id dg28so16232499edb.3;
 Tue, 30 Jun 2020 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MjRNdoa0rZpF8KkV/ND0ssqMkJTZ9vSTBVaUds1+aIY=;
 b=LRQ4E4B9mhCntLThCwvhzuRdnRTQT6wb556Yxds/8mtYujDx/epvCiTfHqW4Zrto+e
 k+/VMLot5f/ujVjCSPek348c3ufqgFqOah+fbScfmJzVGHKDtUQ74npCkptfL7/nSHrv
 OK/YQGv6R75/hIYdAqWoBFFsSjRfuX/ohzrXibmLF01D3bY2ESkMKhGujynYfK93E1Vw
 Uubzunr3w6Az5RQmpE3UpKSq8SNFKdZv34koVOtB/2Q2GY00SzsJgcNPrs0wjJja3Wzl
 lziI6KVZS8ifdRSmYA/kmcJQ3XbwOXtdUbe7JZLaBr88XmdgA/AD77H5CkE+tjE8yhW0
 KrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MjRNdoa0rZpF8KkV/ND0ssqMkJTZ9vSTBVaUds1+aIY=;
 b=hArqCgWRNyP1LOLVKrD4/u/sjqjyAVQ3PIShRcvXlePHdXk36z+EFfDrHwRwv7SQ6H
 vR6tNzIRlEuxx6krHgIUUXCaSJW208Gfu3R74HSuAQFaNDpaTdvw/4zHTOK2k/GEiZ8T
 Dlbjgg257+4M0ICep8ucpeeFbbdkqNqBZgVwRwXa7CiChFauxe1j18M3pEXH09L7d8x4
 Oc8614ywXVJRn1Xd4UzZ/8Pr0k1DRdd4FMc3MDKsSGcRrfFuCyFKRAhWF9QFOjjgIPRn
 2bT/OxeeYXsyoErzxcfpUQ1KP5rAZQbPKVXdNZqJ1UVL075mFD50sQ9bDGeeYbXxfcYn
 +udw==
X-Gm-Message-State: AOAM533wFIsqDm/l+9AHxp7U1Ehf/ePfX/bKkta1KbF3E4QH6YI+mj4l
 r3o+z58NGZpjdcBQXiFGH+bXvkd5qIc=
X-Google-Smtp-Source: ABdhPJxGtwbRjK9kmKgl1UtrZcORC5uF60RHxNz/zCaFQtqrwM7JCM2lzjyJjoiHO1AxnR7wlLVsZg==
X-Received: by 2002:a05:6402:30b2:: with SMTP id
 df18mr23218583edb.229.1593524356073; 
 Tue, 30 Jun 2020 06:39:16 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 02/17] hw/sd/sdcard: Update coding style to make
 checkpatch.pl happy
Date: Tue, 30 Jun 2020 15:38:56 +0200
Message-Id: <20200630133912.9428-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630133912.9428-1-f4bug@amsat.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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


