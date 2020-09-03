Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97667C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53880206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORoJUkCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53880206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwk3-0003Ck-IZ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKz-0003QG-Qz; Thu, 03 Sep 2020 17:00:05 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:39605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKx-0007Nh-Lu; Thu, 03 Sep 2020 17:00:05 -0400
Received: by mail-oo1-xc42.google.com with SMTP id m4so1126893oos.6;
 Thu, 03 Sep 2020 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lEZNnKO9GNhaKz9yEgVcPyYgxdyKZQb+4Kbbi2ont1w=;
 b=ORoJUkCP18n5CA8qn/xcmNJ4nPw8c7zyG2zl3XQzYyhQWgSTcAZ36spSzTfoiCFi3U
 fkhzIKYRVPVdVnTG2OfqkOiMa3rNwyIwI9ykCet+BRFiiZp+FcDctdmMa14FfZ6VJJXg
 WvRfTA9W7JloRmRpH/Ro0YDyfTr5AU47UdQfOvGR7cSDftXFfhq611O8v53tcqGg2YOI
 XeuGf1oLBDxg+fp9oljuB+Yjaig/AzTs1o8hni6wSII57KyOPvUhs0TKmEQ0ic8SuDhg
 bh8obQGi6V8ZXzyAb8uKvlqwiEYF+0Cl/LfFntxFInjlGG3HE4QTIsFUTiDniD0IZhTv
 17vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=lEZNnKO9GNhaKz9yEgVcPyYgxdyKZQb+4Kbbi2ont1w=;
 b=bocVLuA8PBl80QHMOwjFfutI1kB/Ch6JaeRyaVasOoG0SQrPgy72ndRHHBwtZ7lex1
 L+aPwdi8oTGCo1c1HAsF95hvSEyCFAQq0woAE3uYmVBogLy8jIfZ1pcVxveMiCnJiCKd
 KpUARHkJKw4ElkpxQjL2oSzyOcyKlDQLlupiVPBCcwirQ8hLB7FfpqheToI3vb/YqChI
 8I3zPGMsSvt0lhNdAnObn6KJ2BO3asiu7Nu3nkM7/gI3nMupZTIL5emVAbhVtopOb5fs
 Mw+YCNtSobFUdzPLWa9C6YOedssqEpQlFif7npb3FvQsVjrSAMOs7II/CRoRU25C2hKF
 Cd1A==
X-Gm-Message-State: AOAM532zaN7vyZduFUGLRFStjSjCCdXCxGIRh9C+xTXjCoUN2CwPy7OT
 EAiIBO477Es3p8vpJMjpTlsgC1qkMeg=
X-Google-Smtp-Source: ABdhPJzuuAdkGdnNqY/27WYME5ji4tDb2hojvGZMo5k1rgYqPxMR2ZhtHSY+GoqKNMfj4+meLm5Wdw==
X-Received: by 2002:a4a:bb05:: with SMTP id f5mr3353415oop.5.1599166801381;
 Thu, 03 Sep 2020 14:00:01 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g21sm829342oos.36.2020.09.03.14.00.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:00 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/77] es1370: check total frame count against current frame
Date: Thu,  3 Sep 2020 15:58:35 -0500
Message-Id: <20200903205935.27832-18-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

A guest user may set channel frame count via es1370_write()
such that, in es1370_transfer_audio(), total frame count
'size' is lesser than the number of frames that are processed
'cnt'.

    int cnt = d->frame_cnt >> 16;
    int size = d->frame_cnt & 0xffff;

if (size < cnt), it results in incorrect calculations leading
to OOB access issue(s). Add check to avoid it.

Reported-by: Ren Ding <rding@gatech.edu>
Reported-by: Hanqing Zhao <hanqing@gatech.edu>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-id: 20200514200608.1744203-1-ppandit@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 369ff955a8497988d079c4e3fa1e93c2570c1c69)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/audio/es1370.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 89c4dabcd4..5f8a83ff56 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -643,6 +643,9 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     int csc_bytes = (csc + 1) << d->shift;
     int cnt = d->frame_cnt >> 16;
     int size = d->frame_cnt & 0xffff;
+    if (size < cnt) {
+        return;
+    }
     int left = ((size - cnt + 1) << 2) + d->leftover;
     int transferred = 0;
     int temp = MIN (max, MIN (left, csc_bytes));
@@ -651,7 +654,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     addr += (cnt << 2) + d->leftover;
 
     if (index == ADC_CHANNEL) {
-        while (temp) {
+        while (temp > 0) {
             int acquired, to_copy;
 
             to_copy = MIN ((size_t) temp, sizeof (tmpbuf));
@@ -669,7 +672,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     else {
         SWVoiceOut *voice = s->dac_voice[index];
 
-        while (temp) {
+        while (temp > 0) {
             int copied, to_copy;
 
             to_copy = MIN ((size_t) temp, sizeof (tmpbuf));
-- 
2.17.1


