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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B04C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD002208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxVcXBsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD002208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwLO-0003ms-F7
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwIe-0000gF-7P; Fri, 23 Oct 2020 08:36:04 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:35467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwIX-0003YU-Eo; Fri, 23 Oct 2020 08:36:03 -0400
Received: by mail-pf1-x431.google.com with SMTP id h7so1148627pfn.2;
 Fri, 23 Oct 2020 05:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=agnwUKzL+zyHdH6roUOKcRrSPu8n52OSR+lxRMXby5k=;
 b=QxVcXBsSU2Igyv+u/PRFjpB3atQRBrGFbB6MQkHDqOQbsd8lotzUblU86kmjnrQ44b
 /1Qk8/UjCbBG5H4xhJ0NBIzPoxr5iTu5939yRd3byswW3b8ej0002nO4hQUrNHShx+LA
 GFrd0Lezxn6tcrCvmIdnEPHFK4gWuBFmvpRR7uH2ARrz/cpYhYGUnvTJHb2VW4tZ06zA
 VFOFbuKK4YJstKFASHo0oanzEUvXA8cbpYkX6KvHBP28TNqKw+3WVXPTbXJ42zrluehc
 zF35PZs3kChep1vIs5tADKfBqvMAdUlb00+Rk0Vf4A/BknPZnM8pGsLix7H2/gS2D8Fd
 Kpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=agnwUKzL+zyHdH6roUOKcRrSPu8n52OSR+lxRMXby5k=;
 b=eVWlESstI4kkMH/78VvKOHK3C6Izv92H6dxenuGddg8Jpqo4JZtk4rq5g5wKgS3ydU
 d7jbsHnGnaYqOgeJetz2VhIbkY5Yv2BjMX+QbF+4GWRNzwbAA+dtwMBXilADBMgojV0D
 LSFyLEmCpW/WiqunergXWuHX5vod+WAqudAiQE1/EdFegY225RLZfq4vm14Thu61qVAQ
 rz4hLtjD2Rtlc3+CDStPGDY0X6DDRcdK5yuVvYxnRx/8u2Yq6l5m2ePhCaxONLLOVsPV
 FyrKKdy+afl6Cya5ejyeRfZ/wZbHUv7ktNh0zl+EFQlyhAF4D74r7Fx1UzfELSazCudf
 R9mQ==
X-Gm-Message-State: AOAM530r8lQAthVqSOFZZ5r7zqyLL69jmpwf+QLRYr69pG9CZ6l2ZI53
 YWS6sLT0mZZfpdHH5KH7/TgnqRzv+9Lb2aWt
X-Google-Smtp-Source: ABdhPJzh7tXvAkX+gvGsphu6nRvA+pMOBe7AfZOLiM/l3+ormu9/OYi8+UIEQuCvI2cHeWX60w8hXQ==
X-Received: by 2002:a17:90a:b293:: with SMTP id
 c19mr2341057pjr.122.1603456554642; 
 Fri, 23 Oct 2020 05:35:54 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id c127sm2041114pfc.115.2020.10.23.05.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:35:53 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 23/30] tpm: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:35:16 +0000
Message-Id: <20201023123516.19843-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=chetan4windows@gmail.com; helo=mail-pf1-x431.google.com
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
Cc: Chetan Pant <chetan4windows@gmail.com>, qemu-devel@nongnu.org,
 stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 backends/tpm/tpm_emulator.c    | 2 +-
 backends/tpm/tpm_passthrough.c | 2 +-
 backends/tpm/tpm_util.c        | 2 +-
 hw/tpm/tpm_prop.h              | 2 +-
 include/sysemu/tpm_util.h      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 201cd38..a012adc 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -14,7 +14,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
index 8f6f499..21b7459 100644
--- a/backends/tpm/tpm_passthrough.c
+++ b/backends/tpm/tpm_passthrough.c
@@ -11,7 +11,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index b58d298..e6aeb63 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/tpm/tpm_prop.h b/hw/tpm/tpm_prop.h
index 85e1ae5..d19e40c 100644
--- a/hw/tpm/tpm_prop.h
+++ b/hw/tpm/tpm_prop.h
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/sysemu/tpm_util.h b/include/sysemu/tpm_util.h
index 63e872c..08f0517 100644
--- a/include/sysemu/tpm_util.h
+++ b/include/sysemu/tpm_util.h
@@ -8,7 +8,7 @@
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


