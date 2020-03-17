Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224CAC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2415206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3UfIIp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2415206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAgB-0002bj-VF
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAad-0000dq-UA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAac-0003bf-HR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:34621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEAac-0003UM-9f
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id z15so25170769wrl.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jyfKZxmYAbu3IZ0cWkZdHudvDWFaFVhw3+dbnWWC1P0=;
 b=q3UfIIp7vASNk/GfuZbbPGOXx8m7+J21JZgDlIDB6f1F1+jU0Uc2pUIWv5jVu6jrbE
 ZviW5EIrfwzFhk+6bBcvq8kQ/B9jEhGs6pNUw0sdGldg2N77WjNOSJKIc0MUGNT7w3AC
 JY6tAHhrhw/EtYPtniODBOq7tKs6ZTrjn2HpN9lUMFNGgt6yKnD7ELCnFBUp+9ldyT/F
 Q5Fkl5RBc2fvYp6Y/gEoXbDSiCePNKHxpsvA6lgtPc3EHVg2h939fArIJB+Iwr5oXqfR
 Sx5Bp7ebqSJPrjp/jTtT9TbdR/51DCkIbZJliC0/n6sVlUXAbc856a+dR5OB6FgyeDpb
 CEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jyfKZxmYAbu3IZ0cWkZdHudvDWFaFVhw3+dbnWWC1P0=;
 b=p0T0UDvJkPtBCGDeSGB6foO27prFZd5v7CWtVs97ybhn7oq6h1+YSsa68oM5Nq47Tr
 FoKiiahec384qVTsuSkWCe4HE1FYLNCkf06rWlva40IIFr/tKNV2TlEd5sKvYBfnCciT
 UNp8UdLrKIPdTsko+aY+YpWoPXCJ9FR/we3FkLdnPBU3841uPB3WCr1LZ3Gu62fiRxIo
 5zj+zcU4F1U9Ng+nLDOww2CAf69n9gGR3uXXdVTPzHaKi2l0rWVPrIrYCmfu1PvAajzR
 7lZRKf4686Ov9f64WVCZycvhVFhL34HEbPXqObdqjdeWeKhDl6md0BMBq6wBA48K39Fh
 jy6Q==
X-Gm-Message-State: ANhLgQ0vqWXeRhKKXK2PZBTNHP7Yz9IvCsLAAWkiqyHO/VyVUmwKl2S2
 oM9WY0gLgkuwth58ZnnpvbrYijHwzdqHZw==
X-Google-Smtp-Source: ADFU+vvr+Bfz1g4ME5uN8GlXGCH+Qpo5uyumGDbl576JhV8w8eP3bT0s24oYMGWOkuZszVKfXFeLaA==
X-Received: by 2002:adf:f0cb:: with SMTP id x11mr955379wro.13.1584445253034;
 Tue, 17 Mar 2020 04:40:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a186sm3577443wmh.33.2020.03.17.04.40.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 04:40:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] aspeed/smc: Fix number of dummy cycles for FAST_READ_4
 command
Date: Tue, 17 Mar 2020 11:40:38 +0000
Message-Id: <20200317114039.26914-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317114039.26914-1-peter.maydell@linaro.org>
References: <20200317114039.26914-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guenter Roeck <linux@roeck-us.net>

The Linux kernel recently started using FAST_READ_4 commands.
This results in flash read failures. At the same time, the m25p80
emulation is seen to read 8 more bytes than expected. Adjusting the
expected number of dummy cycles to match FAST_READ fixes the problem.

Fixes: f95c4bffdc4c ("aspeed/smc: snoop SPI transfers to fake dummy cycles")
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 32be2a02b0e..9d5c696d5a1 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -788,11 +788,11 @@ static int aspeed_smc_num_dummies(uint8_t command)
     case FAST_READ:
     case DOR:
     case QOR:
+    case FAST_READ_4:
     case DOR_4:
     case QOR_4:
         return 1;
     case DIOR:
-    case FAST_READ_4:
     case DIOR_4:
         return 2;
     case QIOR:
-- 
2.20.1


