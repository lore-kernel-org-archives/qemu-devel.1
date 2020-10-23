Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80015C8301D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01FB02168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfNmH0QG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FB02168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVw6q-0006IK-Th
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVw4k-0004tL-Vz; Fri, 23 Oct 2020 08:21:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:46098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVw4j-0001N7-Cd; Fri, 23 Oct 2020 08:21:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id t4so747188plq.13;
 Fri, 23 Oct 2020 05:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=n4QDti4vRx17oXnzc6q69gHNnWPoEkyA83OEyqCk3+0=;
 b=WfNmH0QGQtPQFK0lfMR+daTksw4ZvCemSB8fM+QYPr9qXheyx2h9nZII1Y2C3Tco5/
 MDMfgkw6Fa+mQpyV4mF4gHxrNuiEcpLfN8/LIGT3Dp5Siclvf8sK4+YkRUeIEeqB0gTS
 pZBIsZ6v3ZjElq5BLb5zfar0m2fT7Lpo6uHtL8exJ8kWxnck6hQn/nOB6nG96kaXQjrA
 szaTn7N6spXPRztJb5S1J1pl/NT7LNUhenNQBTguiWrCj8jECDLNpHKmYkf1ruTEYJ+9
 80AMIcZK8+CDdYptcAVMVVBikO6e78XTs2fYo67c4PgUnO8Sn9+rAPtQMvMfktg0WV/5
 jRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=n4QDti4vRx17oXnzc6q69gHNnWPoEkyA83OEyqCk3+0=;
 b=cScls8pvnnlheaWGuBmH0R8ShNMWwaT/D8vQ5EqPbibcFxKf/NxJ6neQsLoero3RdT
 f7YFdhQ8EUhtiQYi/3kj8ttLm5oicro/YpNjFKsH0QRd00G5Q+Njj+jVxfWyCQfBxYyK
 8rZDSiMO2x20g3AP/jH1vDzJXGdbOfYOeTmpiRMDpWihkuxzdx6zHDP2qPSbKsg4SFWV
 Loqe5Nu9b3Jjw3IBikNk9EnS4Rt4oqDYgw1EsG7xXhcFvCQebFewM6cYuykXv1kA/9Uj
 EQmirqbUAj7yQirLOnsJJVrcSXVdhsjfXPZ1Nk640mWzkpgypkbYB2ZmRbJeTvIccaQr
 A3DA==
X-Gm-Message-State: AOAM530Ce0n4C+ypL08tiezeRxNDyZjq6UOzbmszpyO1P/Pua56q3iCA
 5MBclWe6zoOjENnUnqw7wUGPWa1dhiUClLyg
X-Google-Smtp-Source: ABdhPJxVGJM8j459Gfs5GTDMUvCMivZt4KpMiiAI4gzlBtzVo8IrD1K+mHQFrPSg6ztJYECjgq9I+Q==
X-Received: by 2002:a17:902:7fcd:b029:d3:f037:d9dc with SMTP id
 t13-20020a1709027fcdb02900d3f037d9dcmr2132036plb.79.1603455699221; 
 Fri, 23 Oct 2020 05:21:39 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id il17sm1930133pjb.39.2020.10.23.05.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:21:38 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 12/30] xtensa tcg cpus: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:20:51 +0000
Message-Id: <20201023122051.19274-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=chetan4windows@gmail.com; helo=mail-pl1-x632.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jcmvbkbc@gmail.com, qemu-devel@nongnu.org,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 target/xtensa/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index 4d43f13..b669606 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.17.1


