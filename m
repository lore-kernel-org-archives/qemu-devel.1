Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C535C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADB42224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbqb3u28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADB42224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVI7W-0000H5-Ld
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI18-0003DZ-W5
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:19 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:38587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI17-00067O-J9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:18 -0400
Received: by mail-wr1-x42a.google.com with SMTP id n18so4023102wrs.5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/ytGsokUFsJElQ21X2X5EL4wzQhSW3vyhSdpuBM3Iy0=;
 b=nbqb3u28VHRphmKZEzSFjsdEdoWb6g510uG/iCvddSmNhxu0cAi71HdNQtp486yHFg
 6Wj7B5GJrJTFwn9RAIVi1ymprnLRIAYv1T4bqrAwRv1UqcxZgAG21dUxvtQ8oweWAfnP
 YKAk6NjgNzWn6ZR9gp/YwYtB2O35FLeMkW+DCgBX7FrKPtOSLR7+Kjn93ZNNHYIURQ2g
 tW61TFHYTGy1K7Z8A0Wk+7xtDgedGmVR/mtLAZ4dAhFi2ETCYSGJeDBNK61qiA5wqo1+
 yffuZeUumRsDjez4FOitRw8p+RmOC2MwJKecNK+NtZajJEHZvY/O1aRblFJ+Wvdabrfl
 jNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/ytGsokUFsJElQ21X2X5EL4wzQhSW3vyhSdpuBM3Iy0=;
 b=QEsvIcmGqUTdeiYYOhVy1wfHwu+yJpv1m6pkcgJQfDnCF/JPt3Aqa5LqRD4zemO7yM
 hf0td+/kyYbCuhliHUOnmu3jWttrowYjsmyT9slmms0C57w3Ai9Y7h7kXQ8p09Efr5YU
 C1pm3n/fuFqaTWjoTfGghs3z2wGfv9595YaX0mOIOR5D1vNDdPHROBixtetbwZ79vtCy
 GMfLgqvS/6lO8pv/LrigLeWpWmfslwiDjVllNgx5aIPWxa5CzF5hbqGVgmucNqEUWjk8
 i5j6p0QECMz/wxGWNEPY2aAB7wQOk9jKfPRqQtMVv8BA+hQGXXi/b4lZ3+6cWYIXzns0
 Nm4Q==
X-Gm-Message-State: AOAM532wIvAhPbjecqk5zCMOwbr+kqIqcByB2h+2Z2Vy8hGue5cdzaR0
 de7xK2MwYAq5kawS9I8bpvDzeVQRm+o=
X-Google-Smtp-Source: ABdhPJw3Ykui0kKbtPN1zUJZUG2Lfz3PHxhrCmEw/cYAMRh3lABSC4TWJVB9VWK/qq2adF9/6VbPcA==
X-Received: by 2002:adf:f810:: with SMTP id s16mr5758443wrp.424.1603301716086; 
 Wed, 21 Oct 2020 10:35:16 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id b63sm4643367wme.9.2020.10.21.10.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:35:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/13] hw/sd/sdhci: Resume pending DMA transfers on MMIO
 accesses
Date: Wed, 21 Oct 2020 19:34:42 +0200
Message-Id: <20201021173450.2616910-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173450.2616910-1-f4bug@amsat.org>
References: <20201021173450.2616910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we have pending DMA requests scheduled, process them first.
So far we don't need to implement a bottom half to process them.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200903172806.489710-3-f4bug@amsat.org>
---
 hw/sd/sdhci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 61e469bd32f..4db77decf87 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -948,11 +948,21 @@ sdhci_buff_access_is_sequential(SDHCIState *s, unsigned byte_num)
     return true;
 }
 
+static void sdhci_resume_pending_transfer(SDHCIState *s)
+{
+    timer_del(s->transfer_timer);
+    sdhci_data_transfer(s);
+}
+
 static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
 {
     SDHCIState *s = (SDHCIState *)opaque;
     uint32_t ret = 0;
 
+    if (timer_pending(s->transfer_timer)) {
+        sdhci_resume_pending_transfer(s);
+    }
+
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
         ret = s->sdmasysad;
@@ -1096,6 +1106,10 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     uint32_t value = val;
     value <<= shift;
 
+    if (timer_pending(s->transfer_timer)) {
+        sdhci_resume_pending_transfer(s);
+    }
+
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
         s->sdmasysad = (s->sdmasysad & mask) | value;
-- 
2.26.2


