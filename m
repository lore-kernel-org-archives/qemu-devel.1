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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5DCC55179
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7544121527
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ua8troac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7544121527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVw9t-0000IQ-C4
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVw7b-0007QI-G8; Fri, 23 Oct 2020 08:24:39 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:39657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVw7Y-0001lf-H4; Fri, 23 Oct 2020 08:24:39 -0400
Received: by mail-pg1-x52d.google.com with SMTP id o7so1116861pgv.6;
 Fri, 23 Oct 2020 05:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yrHLQqtBgcnQgqjS774ys+OQHdF6Whk1dHKigZsXCSo=;
 b=ua8troacuw+EHNIDDuXvdLozzszR+IAma/yn4cWCSVAFSDsY3OcMWj7NC66IPIFl14
 /fTRZ9rz1HFc7+dlPW65tYHHgD1M50ZV6s8eULUbMSs8fD7y1nTTzIQDMhBQ0rgXt0tK
 HQe46UR8MMCJpSU6jKaG33DodHaeJ2yka7sPK/9yv+OIWNiBaOmm0wTaQTo1S56GzTm5
 kN/vm8Sl9JtOLrkhf/RbWuVFR6BwQIo/fIELFW1aI+9uzh8jsEWAfQuCB+rMvZvbIYyE
 v5mwR5tydFemfebZ0F0QycrNWr3+GE6ZNvsU8T6mwAqn3yXc/OwS5KbnAkJrx+VaUUGN
 2sEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yrHLQqtBgcnQgqjS774ys+OQHdF6Whk1dHKigZsXCSo=;
 b=uSyjxOWt6vIZwg+uoY605YeLF7g4EOmcLVLO3iONTONt0GS4M2aAYVuqmS4uYpEdch
 sjxoR53TyaJtdg+gpHqAHihjxdomzG3kMfHCJjYXVYFeRD4/UIaI2dmeiAH0Vp7+JIY/
 DS6wujHbbGHzsiSIC5UCFaXZGjon5sq+nWiDrljwIvRB7AmigMdmFCXMqR5CwKtkLo+o
 ILRm6QpkLqGp/DsMZbMUgRpPUtdMMH8wGM9rzBi6hjo4UaVmcVZX6Y95I8LoBebXPtG9
 gDEZeUlwNDXfTwaMS+iX9k1Ru2E2Gphu9C0YdbK4/zg53csMObKiuJyXWbgjQ+h7mE2U
 8rCA==
X-Gm-Message-State: AOAM533pTJ7//Xt4npAth2IFCT+X4mVTJNa8iqLvhFOJODFRzUg1tFpF
 BlX8KQG32N6Je2WfJiygS8braw+zzIAbGwq/
X-Google-Smtp-Source: ABdhPJxMH9+oXAhqIFMaLoRXOxowTHO7yS79t7TEzmDS0zTpeRmt5p54HaVFGYMPuAFx3MAS/JIz/g==
X-Received: by 2002:a17:90a:c208:: with SMTP id
 e8mr2215497pjt.142.1603455874408; 
 Fri, 23 Oct 2020 05:24:34 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id z26sm2243220pfq.131.2020.10.23.05.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:24:33 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 14/30] usb: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:23:32 +0000
Message-Id: <20201023122332.19369-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=chetan4windows@gmail.com; helo=mail-pg1-x52d.google.com
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
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 hw/usb/hcd-ohci.c     | 2 +-
 hw/usb/hcd-xhci-nec.c | 2 +-
 hw/usb/hcd-xhci-pci.c | 2 +-
 hw/usb/hcd-xhci-pci.h | 2 +-
 hw/usb/hcd-xhci.c     | 2 +-
 hw/usb/hcd-xhci.h     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 8b912e9..f8c64c8 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 2efa6fa..65fde63 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index a6d746e..3920099 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -12,7 +12,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
index aa2e890..c193f79 100644
--- a/hw/usb/hcd-xhci-pci.h
+++ b/hw/usb/hcd-xhci-pci.h
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 5e8bed9..e68ae2a 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index f859a17..fbe9981 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
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


