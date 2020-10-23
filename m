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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783B0C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C58A20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBtC16NM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C58A20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwPJ-0001ZG-2i
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwL7-00045B-W2; Fri, 23 Oct 2020 08:38:38 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwL6-0003oP-95; Fri, 23 Oct 2020 08:38:37 -0400
Received: by mail-pf1-x442.google.com with SMTP id h7so1155669pfn.2;
 Fri, 23 Oct 2020 05:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TTiABXpMy3dKcm+gxwkchOjD+jaxZwCHChua0Wmh0zc=;
 b=iBtC16NMEwAWF0Ckuwiwh+M1NK5hKPE0ormEIqnFF9XJhf/wy8h6dRAOgAv5PtlKHk
 k+9NLd8UnA/rm6I4UsY/H7TQAhwES3A5aQATDunXQ5m1kScUgYE4ampUT5Kebq8E9AmW
 c9DxMHFaSdmpLCTCWeRWBefGafnSxhH1+Qj9etuK7P9/0A+pFWKkN7LUmvJfn99kkBLm
 vjdXRCK7Ajat/cF9x6KArpesEPqSgBw/hOcQKH+ts2j+cSq8A9qR1ius51xejn5tBA+3
 x4wRJ3nPwgWw5wmdxQ1YOfLCc6Rha9kFbpxsI0njKM7FNcM9OnAQLr1AU/Puv5WQY+WY
 pHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TTiABXpMy3dKcm+gxwkchOjD+jaxZwCHChua0Wmh0zc=;
 b=EYqQlCzxUDOzKmIpAbdvLVqNuCNrBqhIwo7VUePxxeRhJvNKdJ5K167WCpROtlOrbd
 C5YhWU4lQqOvtjSlffLZt2ZB33IHJS0p5AW3IIk5x4xTRLL0S0JOq3aNxpM6D2pjFy0t
 w8AqE/WjCvls0Aqznxd64GR4HHEHMOdlGIpSsgalML9rW/swOrjhor4aKy7fAwTEKFG+
 JqM8FkylLCS7Ih1ueHXvFVTyCEee2DzRE/k1TKlHYEjplneCguZGS4SDjG25ykELjvTu
 8FfcaKquEkk2ZrGCry5nGz9cu8l3rv+THi1RIUWGEXY1/Na+DVbPI19z6yEGXCHFbGfQ
 MXMw==
X-Gm-Message-State: AOAM531+pJB6lWTHoNRvM9xnLGcBNbkWIo/GL78IFCzVS7SaySqyLA+x
 t4+Y/j7E1ig4F67PVmWIpOaZtrjcRH7yAe7E
X-Google-Smtp-Source: ABdhPJzC/rMKPQgRKbndGW3XzTabzDdJIMatvL5vQ9Arf2Say/W92FwcLiREuQyZbran4keMncTWBA==
X-Received: by 2002:a63:3202:: with SMTP id y2mr1847341pgy.97.1603456714425;
 Fri, 23 Oct 2020 05:38:34 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id o13sm2298791pjq.19.2020.10.23.05.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:38:33 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 25/30] nvdimm: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:37:49 +0000
Message-Id: <20201023123749.19941-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
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
Cc: Chetan Pant <chetan4windows@gmail.com>, qemu-devel@nongnu.org,
 xiaoguangrong.eric@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 hw/acpi/nvdimm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8f7cc16..e17734d 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -15,7 +15,7 @@
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


