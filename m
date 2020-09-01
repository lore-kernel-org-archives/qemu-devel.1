Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB533C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC2020684
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDZUTtiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC2020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6tU-0003d6-Kl
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6qw-00085W-Hb; Tue, 01 Sep 2020 10:01:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6qt-0002Uu-Qk; Tue, 01 Sep 2020 10:01:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id a65so1267763wme.5;
 Tue, 01 Sep 2020 07:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IACbjPDFBmwQpji6CF0wwL/53xVgGp9xNZwMZtgSUrg=;
 b=aDZUTtiv+t4GlDVqnyuPRsG2ZKip/MB1GI6IjSqhwx8Uki5y9x7IYnbTBzXBH9UKXq
 4AsPYi1qurw+1IXSqIf6N/CPMSJVt6mdv2lNusSE+5T5GCHjF1+qkyRuvybzKVahxAm7
 NT1YJl3tarXRGb0NbyPcLjrafUw/JBuCnTW5Sajs5/BJ3CZnqnve7UuKDN/rUAt2MKY5
 /tS0tFMvYKZJMitVREcA0fCy1DbdL9b5cqHrYhy61wzphF2L6VoGAUf0tvZtDvtNuvsH
 yRxo2jK23s0QoWdhfemY4mcYe6ieMXMxX12D4cRoOtI6ZcP5ufWe0mGMaLGDRI/XAqxa
 APog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IACbjPDFBmwQpji6CF0wwL/53xVgGp9xNZwMZtgSUrg=;
 b=WTerz078JHY372KLAzlmiOe8zZ2XLR1PvkgiU6g2f//N0MO4uq3JAg3vTREms6Y1Iq
 +bVZOl8vZn937fd5M9l7vYg2RRwPadKvd85/B9iQIv/1YB0y1+tftsz4eErROEzb+jGT
 +rbut7SXePn9K5vFOH0s5MgL72YjexEIcp0a1JJUYH5K+bPj13kG7/GreTFXaSAwE0nL
 23KeQZn836Vx0/NGzj1xsUH86vLW8x7l3SiLOm3isyUoOEY4FWBSAnKY0ihdw4lwoowf
 jpK3esBOkwzIiYWC1aC6WZYX01YWFIiDV/sh0lJkRO1OAmNfXsRwzPqp0MWqacoYOKpo
 O5vQ==
X-Gm-Message-State: AOAM530GSONLl9mGCmkcOCz8wGllSZAy6+PNqTyjy3UYscxyKsbjzC5W
 wk5l44q5mcHzndHi4jU/AOF9HW4XmZ0=
X-Google-Smtp-Source: ABdhPJzNkn6wObGk0wVOJi/AmTr2wHxQnYLXUl4rvdQPALAZoqFSdVunNGtv1C/Zh4fA5AB1guFj4w==
X-Received: by 2002:a1c:b60b:: with SMTP id g11mr1990066wmf.48.1598968893483; 
 Tue, 01 Sep 2020 07:01:33 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id m13sm1492107wrr.74.2020.09.01.07.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:01:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/sd/sdhci: Fix DMA Transfer Block Size field
Date: Tue,  1 Sep 2020 16:01:27 +0200
Message-Id: <20200901140127.111454-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140127.111454-1-f4bug@amsat.org>
References: <20200901140127.111454-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 1892960@bugs.launchpad.net, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>, bugs-syssec@rub.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'Transfer Block Size' field is 12-bit wide.

See section '2.2.2. Block Size Register (Offset 004h)' in datasheet.

Cc: qemu-stable@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1892960
Fixes: d7dfca0807a ("hw/sdhci: introduce standard SD host controller")
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: 1892960@bugs.launchpad.net
---
 hw/sd/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 60f083b84c1..beb7b7ea092 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1104,7 +1104,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         break;
     case SDHC_BLKSIZE:
         if (!TRANSFERRING_DATA(s->prnsts)) {
-            MASKED_WRITE(s->blksize, mask, value);
+            MASKED_WRITE(s->blksize, mask, extract32(s->blksize, 0, 12));
             MASKED_WRITE(s->blkcnt, mask >> 16, value >> 16);
         }
 
-- 
2.26.2


