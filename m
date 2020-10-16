Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F68AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B586E2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRAV8B0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B586E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTQsM-0005zS-Nn
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 10:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kTQrR-0005Jj-0n; Fri, 16 Oct 2020 10:37:37 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kTQrO-0001NQ-IU; Fri, 16 Oct 2020 10:37:36 -0400
Received: by mail-pf1-x442.google.com with SMTP id a200so1605590pfa.10;
 Fri, 16 Oct 2020 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zaen85cnGFLYeawoKBay2kRei0Mi2ng8hhULAoIj1B4=;
 b=fRAV8B0udYy1J7ShK5A+GnUqDWlpukECTp7jaejlll4jVZPAMQA1FdgKpNSH6dWYxP
 O9bFpeecavBH7Gz5N6zEbUV43/iRU7ZfX/AfSwfxqQrCseU7FLRJjxbB05xvBzUTwTWg
 WkSP8HYnazh911CzH3d+GQM4shhrFiiof1K5txgH3w6p4P9i14eq5O0O21We/a/JWAOH
 GwaPf48vYTpw9E5kYohPM07o2sKnIkP6zQYh+XBreC+heK3K5vVr2s/a1t2jMi/hSfej
 z9uCmei4XtAnFVUuCJSG1yX5WcqE+cd4XBk1t37nrQx1m1t4l8ZWJZ7WxTCz0k3S64a1
 s8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zaen85cnGFLYeawoKBay2kRei0Mi2ng8hhULAoIj1B4=;
 b=hwvLQDP3ftB6gfcKWiSs/UY2XjaNqJRP5doPsLwuKEJT4EhCuqqrWyFHzXJ4cfGOLS
 DpoAtrxHTuYqqdoI1Lfdgyc7LOI4Dao4Xru9QFJlJk3vTtv/qkj8Dn+pbISq2FCsnLP8
 kuiryb+vwFlTFqvVGYaoujXJbdDalg2aIfHvFtSApQ15KwyDkda3EqmQARyEQpXHB0mN
 C0VyUaPrP/BiObOzjJpO8c3hX2ivXX3KBmYLcJjQr1YFkgCj2zvpzchIQss0ini5XCp9
 5d/Q/F43XfK85BOs2+BxuoOxWJqLeh4K07sLQjvxz5UPbTjKUaTZiVLPpUZ6fGrSo1bF
 YDig==
X-Gm-Message-State: AOAM531cGAS/rdt5aOWjSnvjc+f28j8WsKhbGSseyDoSTTXV5uVSv9fy
 PsPzFB7hIA/VXbOnffPPmzDJ1zbplQif/Jr2
X-Google-Smtp-Source: ABdhPJyNYm9FG5n/+8i8y5nQU52gVngmxE8dKyBuWpDCifmS6cbovxWas9lHVEuLBePYA1a9DXHAKA==
X-Received: by 2002:a63:396:: with SMTP id 144mr3600813pgd.364.1602859051379; 
 Fri, 16 Oct 2020 07:37:31 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id y4sm3245424pgs.0.2020.10.16.07.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 07:37:30 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 5/30] mips tcg: Fix Lesser GPL version number
Date: Fri, 16 Oct 2020 14:35:09 +0000
Message-Id: <20201016143509.26692-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134902.14291-1-chetan4windows@gmail.com>
References: <20201014134902.14291-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=chetan4windows@gmail.com; helo=mail-pf1-x442.google.com
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
Cc: aleksandar.qemu.devel@gmail.com, qemu-devel@nongnu.org,
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
 hw/mips/cps.c                    | 2 +-
 hw/misc/mips_cpc.c               | 2 +-
 hw/misc/mips_itu.c               | 2 +-
 include/hw/mips/cps.h            | 2 +-
 include/hw/misc/mips_cpc.h       | 2 +-
 include/hw/misc/mips_itu.h       | 2 +-
 target/mips/cp0_helper.c         | 2 +-
 target/mips/dsp_helper.c         | 2 +-
 target/mips/fpu_helper.c         | 2 +-
 target/mips/gdbstub.c            | 2 +-
 target/mips/helper.c             | 2 +-
 target/mips/lmmi_helper.c        | 2 +-
 target/mips/mips-semi.c          | 2 +-
 target/mips/msa_helper.c         | 2 +-
 target/mips/op_helper.c          | 2 +-
 target/mips/translate.c          | 2 +-
 target/mips/translate_init.c.inc | 2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 23c0f87..ea58d82 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 2f7b2c9..692c0db 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 3540985..1333995 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 9e35a88..c31d9ac 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/misc/mips_cpc.h b/include/hw/misc/mips_cpc.h
index e5dccea..fcafbd5 100644
--- a/include/hw/misc/mips_cpc.h
+++ b/include/hw/misc/mips_cpc.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index 96347db..50d9611 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index de64add..a950946 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/dsp_helper.c b/target/mips/dsp_helper.c
index 8c58eeb..09b6e5f 100644
--- a/target/mips/dsp_helper.c
+++ b/target/mips/dsp_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 56beda4..ffaac3c 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 98f56e6..e39f8d7 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/helper.c b/target/mips/helper.c
index afd78b1..063b65c 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/lmmi_helper.c b/target/mips/lmmi_helper.c
index 6c645cf..abeb773 100644
--- a/target/mips/lmmi_helper.c
+++ b/target/mips/lmmi_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/mips-semi.c b/target/mips/mips-semi.c
index 10a710c..898251a 100644
--- a/target/mips/mips-semi.c
+++ b/target/mips/mips-semi.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 6865add..249f0fd 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 9552b28..bbd0bf6 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 398edf7..3a6bd1e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/translate_init.c.inc b/target/mips/translate_init.c.inc
index 637cacc..4f24443 100644
--- a/target/mips/translate_init.c.inc
+++ b/target/mips/translate_init.c.inc
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


