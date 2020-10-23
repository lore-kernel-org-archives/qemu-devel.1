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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0A4C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756B021D43
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVly7Lgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756B021D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwLB-0003Zc-FF
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwE8-0004ZV-6C; Fri, 23 Oct 2020 08:31:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:45944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwE6-0002wH-D0; Fri, 23 Oct 2020 08:31:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id e7so1104220pfn.12;
 Fri, 23 Oct 2020 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zUo9CXXWWX8Nd2/DHJoc7p9XRUxdjGA6KuHpwg4iNDI=;
 b=JVly7LgdSgHuLm6M0j4Zo6tys77qDZYDZ+9JF5uYze5jPzflZjwVvomBx1ojutmZmC
 zUdRTJPncmyfYancRYRexL43eC5cHQdi329mqvCF+QDYOgx2yunXqBR02ka/h19pmUKX
 isC1xFPpeQAVBAHh1IEgOJcwZ6W441nwUNxA4CEg1t2/Oz2Xc66WXJPrdahTZd3L/dMn
 oC2RKGEkCGM7TZUAkEIRyv3zAr0EXBwmqK7wWASwFbnHP4ybXeqR5lRzb+dF+jdwx0iR
 Ff8Xxv2IcFUu09g4ppUdhezN1YIkzMCZ2QIrc/qOO3pnOXM/LoC9w4H1ZGjRy7196j4O
 g1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zUo9CXXWWX8Nd2/DHJoc7p9XRUxdjGA6KuHpwg4iNDI=;
 b=FgHQHc2t5IAuaMtLN7d6bWd+oPrjeuAzE+7GrbVDVyMCTZMxQIMf0iUepTfEq/v/sF
 mOaZRl9Bo7ACJdmzQ+/tmvQctIRvh8N+Pz5z9ahv/4uYeG8kNr+dWBHiZtyt38CDbr97
 3yl7xlzEyr3H0e3zNemZ/b930Jgnny3gQcCLXV2dUkPnP0TKv9gJzg/Q1qoBf0L5YgmJ
 u3OhPXAaCFYf8WkG5KoWBXrK6h16PgNXGHqElSWzhQ5N7xKJPoh2rxVJyeh+zuD1chH/
 0OXFSLa2bG9GiUP6mcJpMHmj83RAedQNu7AjHdVZeOVuaQdw999V7Oh6W3RmM/37U9Bl
 D+YQ==
X-Gm-Message-State: AOAM533PRD9ndzFCLQXAzr8xS+PhpFOi5PeRaaCH14dUcVx9MC1E337U
 y+KBMEowGudZSogIcNT6J5bp8hCL+j+4hBD+
X-Google-Smtp-Source: ABdhPJw0gB8q2O7Jeph+A/XHyFnoV6WcfCLrvYdrfcBWyo2JMlFRtNCjINKP7BjmEiWUZKUhRDyNNw==
X-Received: by 2002:a17:90b:110b:: with SMTP id
 gi11mr2177451pjb.25.1603456280235; 
 Fri, 23 Oct 2020 05:31:20 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id l3sm2256472pju.28.2020.10.23.05.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:31:19 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 19/30] parallel nor flas...: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:30:34 +0000
Message-Id: <20201023123034.19609-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=chetan4windows@gmail.com; helo=mail-pf1-x433.google.com
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org,
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
 hw/block/pflash_cfi01.c | 2 +-
 hw/block/pflash_cfi02.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index f0fcd63..daae965 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index eb02fcc..1b3d94e 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -6,7 +6,7 @@
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


