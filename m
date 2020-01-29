Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1546C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89EA420716
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOWXnEw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EA420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxK8-0007c8-OH
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCX-0004Ix-P6
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCW-0008S2-Qr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:53 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCW-0008Ni-Kp
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:52 -0500
Received: by mail-pl1-x641.google.com with SMTP id g6so599044plt.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rf+65vsQqdbcns6mvhek5Z7lsX4mZFUKdS0F0TT2zM0=;
 b=eOWXnEw2h/DqCCnWmJPnX6LTIx9uQPoJ4gQd6V5geZUNZKtRHHLW4izdPkbbHd2IUJ
 yvDdh4MjAXC05JPtDFNOTZuB78N72els126z+yq94uqyK4kzZcOB2/VrcsS0k3iRZbWn
 UdiZ2sPGi2K/tfbj4zh0MGwYHRedK6XhGg5xruJgg/rMtokKbVLiujnaNQrbNlZDnHdF
 Vt2wm5XjyinYkJv6h/J7L+ZD5H3KQFYzmy1reApb6+xjINnAdoAWH5l9hvExZYQHqFei
 B0YtGC8YktKTtTi5zIX90Ji2vfTn5CnHx1uWBhOl8qCfy+J5D3Yz+zUWLx+DtIZVrKZN
 yZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rf+65vsQqdbcns6mvhek5Z7lsX4mZFUKdS0F0TT2zM0=;
 b=flS1ajbBPDJRzbgUsZLImkuw/m8Bzs99yWokZkpVZ7ypv/soBov49sKeHwM50kGo8K
 Ro7juoudYQcvdgv2c8DVoafPNLM4io0+B+BF9AVtx6g9cbZfO1aQNB/YRH5gSvrDnNHT
 y8IJsT74JVwQBafnNlUP0/qD6ItB/EX1Gkfw13zNbrErjJsIB+0vaEfD8Ddx7EzKp0WL
 afcW1Nx4dXFb1I5Z0K/FWlcOoLr5oehMPZ16ws3ZH7w1IigcSP8LQl7egL8ZGz+N8s4H
 AShBiFp05pu+xx2jqytEa2fr3XPfcErjLIYmcufu4nqpjzPopnlbsxv2K3UkkMhQVfAt
 VVIA==
X-Gm-Message-State: APjAAAVIRA9g393SG/DtCRIUzKOBrtAJZg2Hat4i+cUWUwAT5o/lBH6e
 NIBudTBhIIh+Gi71o/rQ52QFhHF6Evo=
X-Google-Smtp-Source: APXvYqw6URq0c/1GKx6BJctafWs7PkS4L9VFiAlpB/o8Frc7AAtQaBsXqwZFTzuk11cw8g3oLS6e3g==
X-Received: by 2002:a17:90a:bc41:: with SMTP id
 t1mr2480499pjv.137.1580342210405; 
 Wed, 29 Jan 2020 15:56:50 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 27/41] target/arm: Update define_one_arm_cp_reg_with_opaque
 for VHE
Date: Wed, 29 Jan 2020 15:56:00 -0800
Message-Id: <20200129235614.29829-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For ARMv8.1, op1 == 5 is reserved for EL2 aliases of
EL1 and EL0 registers.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 37e8bf4949..64cdf337c2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7586,13 +7586,10 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
             mask = PL0_RW;
             break;
         case 4:
+        case 5:
             /* min_EL EL2 */
             mask = PL2_RW;
             break;
-        case 5:
-            /* unallocated encoding, so not possible */
-            assert(false);
-            break;
         case 6:
             /* min_EL EL3 */
             mask = PL3_RW;
-- 
2.20.1


