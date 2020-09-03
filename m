Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F8CC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FE3206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1A+Ihoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FE3206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwZw-0000ia-Jk
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKy-0003Nn-IL; Thu, 03 Sep 2020 17:00:04 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:39211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKw-0007MX-BY; Thu, 03 Sep 2020 17:00:04 -0400
Received: by mail-ot1-x32c.google.com with SMTP id u25so4008283otq.6;
 Thu, 03 Sep 2020 14:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rlfytk/HxGcRvQ43QKeVZDlvKaRhllUNtWQbE6mYVCc=;
 b=U1A+Ihoqs14Ap+tzZ9MDJuzdSwiT12iqB4x2y0I/xN1lTnml1p4BCBFQd0pPbb9isl
 Rk0yhQKklzGWQkJSUCNiVbAv4tPs6Yr47szSYmeCX5azHT7g4iaRdFcfPSKa6PwASEZ0
 Oj5aIuJ9NNWef0vc9MLu1lioL8WLNdr5w0fdiI0ZVDGILDovtByHD1f2arJmd47Dabgt
 Wb8uX9rXtLfIWSsHXT/35BwIVlt37NkMQS36HENFUpAoyg2ZlzbKXM8SJeWxs2UbG68W
 NhDW4WzDTTd53Vyax1PzGP2tZlyBryMUeCJrqPq1uAF7eZCITv3UqPYt1DyWgaWIPnlA
 tFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rlfytk/HxGcRvQ43QKeVZDlvKaRhllUNtWQbE6mYVCc=;
 b=X8HaUSj6IJHCThV0YZoK8R0P6O6wuZZaOcD2ncsAtvULiPgzB0RISLRjgWXoyQh3Ng
 kvmAKylSIxclR3iFRsC8xdUYC2AqQa1wuGo9EIOiNWmWGJe13k9HUmrAu+ZiCPqk1B5k
 cun6vNW20SDOz+lYLqmBraJs4X7sfHPyvpWIHMBD3CjoxEvMyNSXm7xFXDuqPFc7DKGP
 VBQ9nHu2JoR+8YxRfOZ8b2/WM7GPEzO1H7CyAYS6wCotSHDuqvVwiicXYKmzByM7nnmH
 YktI6CO91stxGTeCN3hgnJT8fJCYxtrLMWuRJIRdQMW4o5kne4TntAKbl9wEs8GklIPi
 00Mw==
X-Gm-Message-State: AOAM530sAm8yLsA84mTbaXhHifLRFcUsFS2uM5TBh/imOajAXDQ9Mgu/
 kBvCjjDyhU2IICBxnECTBwSdwlCWZUc=
X-Google-Smtp-Source: ABdhPJzICnhV8rm0nVYYCpfU/wU6GQn/BMzRcIWxPt8YB0OMN0wG6kI5jsAd5BMBN+0kfd+d5W27eA==
X-Received: by 2002:a9d:7f84:: with SMTP id t4mr3163361otp.192.1599166800161; 
 Thu, 03 Sep 2020 14:00:00 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id a75sm709467oii.55.2020.09.03.13.59.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 13:59:59 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/77] ati-vga: check mm_index before recursive call
 (CVE-2020-13800)
Date: Thu,  3 Sep 2020 15:58:34 -0500
Message-Id: <20200903205935.27832-17-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x32c.google.com
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

While accessing VGA registers via ati_mm_read/write routines,
a guest may set 's->regs.mm_index' such that it leads to infinite
recursion. Check mm_index value to avoid such recursion. Log an
error message for wrong values.

Reported-by: Ren Ding <rding@gatech.edu>
Reported-by: Hanqing Zhao <hanqing@gatech.edu>
Reported-by: Yi Ren <c4tren@gmail.com>
Message-id: 20200604090830.33885-1-ppandit@redhat.com
Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit a98610c429d52db0937c1e48659428929835c455)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/display/ati.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 58ec8291d4..9228f1b242 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -285,8 +285,11 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
             if (idx <= s->vga.vram_size - size) {
                 val = ldn_le_p(s->vga.vram_ptr + idx, size);
             }
-        } else {
+        } else if (s->regs.mm_index > MM_DATA + 3) {
             val = ati_mm_read(s, s->regs.mm_index + addr - MM_DATA, size);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "ati_mm_read: mm_index too small: %u\n", s->regs.mm_index);
         }
         break;
     case BIOS_0_SCRATCH ... BUS_CNTL - 1:
@@ -520,8 +523,11 @@ static void ati_mm_write(void *opaque, hwaddr addr,
             if (idx <= s->vga.vram_size - size) {
                 stn_le_p(s->vga.vram_ptr + idx, size, data);
             }
-        } else {
+        } else if (s->regs.mm_index > MM_DATA + 3) {
             ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "ati_mm_write: mm_index too small: %u\n", s->regs.mm_index);
         }
         break;
     case BIOS_0_SCRATCH ... BUS_CNTL - 1:
-- 
2.17.1


