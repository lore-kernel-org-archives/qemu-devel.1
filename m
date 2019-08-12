Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62526C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9872070C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHoavZCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9872070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxCGG-0008Rt-GR
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 11:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43472)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hxCFa-0007Z1-Ip
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hxCFZ-0003a2-Np
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:28:46 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1hxCFZ-0003ZX-Dt
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:28:45 -0400
Received: by mail-lf1-x142.google.com with SMTP id j17so20487671lfp.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=wFg29u2sXKe2NgHAWUez4kll7guYehpqsmBui0mrka4=;
 b=BHoavZCGi5HKWFe/RhlXnlwjmXUQzSWbDx6RyX5ukhgwTsArIDMddXtK1ym4tIxSwD
 DEMODUXF8Fe2nyw37DCcQ3DZEKwwv4+E9CoirQO3XUxCdyu538ZRnBHoWlEwexKiZ3OF
 QK6qQp5kPD9PIpX6awz9+Q2low5Z93zWyrBqoL/fBmayfebr0BqsH/JighaC9T+Q5YlG
 ACrS/lPN1rJoyYZAy0e/uPFz7+JBDjzq+7AFgpEru4G7C1WWl62ASfADVV+NHbJT372p
 pMFfoLUyMfWnymzLpvK56THx446ZmFbph+4SOw0Q6YZ9UjS8efQCPHjoE0MJjNIWktXF
 sfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wFg29u2sXKe2NgHAWUez4kll7guYehpqsmBui0mrka4=;
 b=anc0K78eDRQhPYSw37eCY001zuaFjt2/KNF22xY3WSSOkPCOJs8BtGLWhLp3h5tp5g
 Q4nqxIdZyU2mGXpnemDLmBjVb+oRNV9Qe4rG4xsiX/7KjHineXQsnE5SI3AApH7gDMrv
 OXqjMqiP9IKMHxgbppEMsMskCqF2OPdc1wnAn2+kEEmJlENJ/EaVdqj7zmaNXtW9YFrH
 SZvshtHdFFKi1Gg0EBp+P92nnUhJ5kQAcUYzPhc+zBCEiE52j7EkCuli4gYuezaQ/Xts
 SIt4r8FOHabNGmfn6SOJuIjCzx23jEazNTTYeb6FKntdT5+XFi70kQZyq1oBzGeoPKtR
 /KLA==
X-Gm-Message-State: APjAAAVqfYnKT7INFNAj8Mx/rgPzircVdTmgaZc6hCL/wxKfTNV7jaAd
 LdLWensy54UJ5gkxkNSLXCETLs8c
X-Google-Smtp-Source: APXvYqxSvbnjWooKlalY9KKrJNq3OU6iN6/Slp63/iNAclhBqzbumsYvjVN/S5/ud20SSWJUWflwYw==
X-Received: by 2002:a19:8586:: with SMTP id h128mr20773481lfd.62.1565623723091; 
 Mon, 12 Aug 2019 08:28:43 -0700 (PDT)
Received: from localhost.localdomain (31-208-27-151.cust.bredband2.com.
 [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id t25sm19096295lfg.7.2019.08.12.08.28.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 08:28:42 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 12 Aug 2019 17:28:41 +0200
Message-Id: <20190812152841.22908-1-frasse.iglesias@gmail.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: [Qemu-devel] [PATCH] memory: Correct access mask generation in
 access_with_adjusted_size
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
Cc: peter.maydell@linaro.org, edgari@xilinx.com, richard.henderson@linaro.org,
 frasse.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also consider the requested transaction size when generating the access
mask (so that only the requested bytes are returned when those are less
than the memory region's minimum access size).

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index 5d8c9a9234..56a2510836 100644
--- a/memory.c
+++ b/memory.c
@@ -563,7 +563,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
 
     /* FIXME: support unaligned access? */
     access_size = MAX(MIN(size, access_size_max), access_size_min);
-    access_mask = MAKE_64BIT_MASK(0, access_size * 8);
+    access_mask = MAKE_64BIT_MASK(0, MIN(size, access_size) * 8);
     if (memory_region_big_endian(mr)) {
         for (i = 0; i < size; i += access_size) {
             r |= access_fn(mr, addr + i, value, access_size,
-- 
2.11.0


