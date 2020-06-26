Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87B7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9529020781
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFpqFS17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9529020781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorUX-0002jm-Nt
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorP5-0000EJ-5Z; Fri, 26 Jun 2020 12:40:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorP2-00064P-Sv; Fri, 26 Jun 2020 12:40:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id f18so2051158wrs.0;
 Fri, 26 Jun 2020 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0q3fvINBMewfm4ouk0ChZ+kON+bgL7uzrdyA1Uly1X8=;
 b=sFpqFS17yQY79QZJMC3kh2U9izuekgcjP82dQoSZ/wCDhEqUPF0ztyG4JEgyv/pKDy
 WLKTt/AUhN2GzIQuXJNtY1XWDpbblALFqJu7rN32OXinwFZE9gD6VxpCbuTszk9tFE/f
 NdZlNS/pwQBAD7ss+VTdu6dT38xXiBW1ysO4VPEqw46WNgl3dE4VqkJYQZWw7LWHAnjG
 D11CriLzCs05Xh0+gXIhZn3EnV0PiEi14wrTJLEnCYY5Ki8XmtPS3dnSI3y0Rq4sWUba
 +Oa52s3Jsv2OyARs66W8XCIRXLz3MNJkDYNpHhlkMzWMcG1MPvl3Ge7NUJ6c2B35c1VU
 j51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0q3fvINBMewfm4ouk0ChZ+kON+bgL7uzrdyA1Uly1X8=;
 b=VZ/hrtGN01/+cp4N1goitstJR3GiaTCtPwh4ZBRKWjigbHmlg8fxKhi4dguT5T34dk
 l11sBEjtZH9tcG1/G63AngawF/AvvQMYynml8miBicMUtUdzRZi+abimLvJADAnbg8rN
 yb0VgCn17re6pQw5BTk/+cPuLNzF5EC/BCDgrLCKH+veFBMWha1v0Aco+lVxOjrfWvVj
 c+yBRIB7TbpQuVo5ZeuXPiNv27TYRb3D1Czn8m/HrdhFbxgrTyelWaFFIBsItTd+/7O4
 k6K4/R1c6r2ShOz5qXEWHl4va5URhVo6uGCmLV1fx0V073T8J8gG+6+m+fDCfZ+GvwUV
 u80g==
X-Gm-Message-State: AOAM531GGBmnZr3b++IZ/zZKBBBlJOs6RJpI/9afQWXIlGrskyTVPqkT
 p1mcY6n5JaalW3rtdlwUm/v4VG38
X-Google-Smtp-Source: ABdhPJx0C6QgEFKTkcI8cBFl7F6ZZ9L4w1OVnliVkgzuQ97DLvG/cn1Xn592mb0DKG/1fzf7y36dhQ==
X-Received: by 2002:a5d:6b08:: with SMTP id v8mr4885683wrw.2.1593189634749;
 Fri, 26 Jun 2020 09:40:34 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f12sm24623646wrw.53.2020.06.26.09.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:40:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/15] hw/sd/sdcard: Do not switch to ReceivingData if
 address is invalid
Date: Fri, 26 Jun 2020 18:40:16 +0200
Message-Id: <20200626164026.766-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626164026.766-1-f4bug@amsat.org>
References: <20200626164026.766-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only move the state machine to ReceivingData if there is no
pending error. This avoids later OOB access while processing
commands queued.

  "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"

  4.3.3 Data Read

  Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
  occurred and no data transfer is performed.

  4.3.4 Data Write

  Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
  occurred and no data transfer is performed.

WP_VIOLATION errors are not modified: the error bit is set, we
stay in receive-data state, wait for a stop command. All further
data transfer is ignored. See the check on sd->card_status at the
beginning of sd_read_data() and sd_write_data().

Fixes: CVE-2020-13253
Cc: Prasad J Pandit <pjp@fedoraproject.org>
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Buglink: https://bugs.launchpad.net/qemu/+bug/1880822
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v4: Only modify ADDRESS_ERROR, not WP_VIOLATION (pm215)
---
 hw/sd/sd.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 04451fdad2..7e0d684aca 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1167,13 +1167,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 17:	/* CMD17:  READ_SINGLE_BLOCK */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
 
             if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
             }
+
+            sd->state = sd_sendingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
             return sd_r1;
 
         default:
@@ -1184,13 +1186,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 18:	/* CMD18:  READ_MULTIPLE_BLOCK */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
 
             if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
             }
+
+            sd->state = sd_sendingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
             return sd_r1;
 
         default:
@@ -1230,14 +1234,17 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             /* Writing in SPI mode not implemented.  */
             if (sd->spi)
                 break;
+
+            if (sd->data_start + sd->blk_len > sd->size) {
+                sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
+            }
+
             sd->state = sd_receivingdata_state;
             sd->data_start = addr;
             sd->data_offset = 0;
             sd->blk_written = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size) {
-                sd->card_status |= ADDRESS_ERROR;
-            }
             if (sd_wp_addr(sd, sd->data_start)) {
                 sd->card_status |= WP_VIOLATION;
             }
@@ -1257,14 +1264,17 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             /* Writing in SPI mode not implemented.  */
             if (sd->spi)
                 break;
+
+            if (sd->data_start + sd->blk_len > sd->size) {
+                sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
+            }
+
             sd->state = sd_receivingdata_state;
             sd->data_start = addr;
             sd->data_offset = 0;
             sd->blk_written = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size) {
-                sd->card_status |= ADDRESS_ERROR;
-            }
             if (sd_wp_addr(sd, sd->data_start)) {
                 sd->card_status |= WP_VIOLATION;
             }
-- 
2.21.3


