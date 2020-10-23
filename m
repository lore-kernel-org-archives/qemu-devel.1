Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7429DC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EE920829
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T58f6lJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EE920829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwDc-0003SK-KL
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwAh-0001bR-2G; Fri, 23 Oct 2020 08:27:51 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwAf-0002EL-2d; Fri, 23 Oct 2020 08:27:50 -0400
Received: by mail-pf1-x442.google.com with SMTP id h7so1125513pfn.2;
 Fri, 23 Oct 2020 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=f5ifC5c6gbzj9VFV9GIpvBz/BFacwMzYYc1T+6hnyg0=;
 b=T58f6lJt6BE+9pkmNFKS2A0vkmnXPTgPojZJgYbnzSeLEMj8BnEUE6WIGZPaDQ7z3U
 Ja7plhvVqtIoRAwyjKuAg64s7QeHV0QbVLVf7rUXlEEKdWUtAYSpdD8Tvl78mcw1z5nv
 vP2Xu8uJZUv1nmt95tsQorCK8CP45ICH6xFCqVsboVPirK0NVmKeNe3JFbFmbq5lbAa5
 5ZKrHl1tbCe6AFpNghPyXPjMEW+rmPNDL5IRGicLtU0r5NCxAA9KnnN/PDL0pWjGLW+X
 bQrFQQ+yKmtj0BsW8W+z61kWPfNp75mFcyGKNCzflkc+2mJeHBPXn6vdM6HM5skDPeT6
 BcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=f5ifC5c6gbzj9VFV9GIpvBz/BFacwMzYYc1T+6hnyg0=;
 b=IIPPZUrDu/lQk+6+vqZqjmYHr8ZyBpGdkd1zMkEj0uwSE2gvjJZgMvSzcDpqRv4leF
 uzsMoygxrBWfruqLCwCA+xoihPuq8R00uFaQTyUYZ/XqAjmgOOuklyXVjtqkZhONo0dk
 4UwsNKiyrd3EeVtBn2h4K+iizvcN82SuHVSelqjRigtA3bOEmGb7HufT2o6EUd3z+EK4
 FIbPygFyx8jkfa/lb8Rox6DidBUnqYAr1Nq9vvlSqmM1opKIFo8reW89ZBPfrGRCOm0J
 YvOwd/fU60PlPHwHBMZC2og4PuLtwyclgEw6DQrpAExKKmjUbt+GSuYnWyXjpxJmeY5r
 tGEg==
X-Gm-Message-State: AOAM532nZot2u3epVfOdlIu4WhSa6OxeD+XTnnq3TEijETOxS2mJfZZV
 2/5jBSzuy59prWNf1rEJMdDSBmAwEe3sMBtM
X-Google-Smtp-Source: ABdhPJxGeSQG8nKdTz+mNLUV9MWyITDvVkZjJhlngfWwsjUM9NJova4NUECtGQ4TkAwqehjlkpw3lg==
X-Received: by 2002:a62:cd0a:0:b029:160:cf5:7211 with SMTP id
 o10-20020a62cd0a0000b02901600cf57211mr1001894pfg.15.1603456066783; 
 Fri, 23 Oct 2020 05:27:46 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id s141sm2097159pfs.75.2020.10.23.05.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:27:45 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 16/30] boston: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:26:33 +0000
Message-Id: <20201023122633.19466-1-chetan4windows@gmail.com>
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
Cc: qemu-devel@nongnu.org, paulburton@kernel.org,
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
 hw/core/loader-fit.c              | 2 +-
 hw/mips/boston.c                  | 2 +-
 hw/pci-host/xilinx-pcie.c         | 2 +-
 include/hw/pci-host/xilinx-pcie.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index c465921..b7c7b3b 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 1b3f69e..0e9c771 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 3b32142..38d5901 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/pci-host/xilinx-pcie.h b/include/hw/pci-host/xilinx-pcie.h
index f079e50..89be88d 100644
--- a/include/hw/pci-host/xilinx-pcie.h
+++ b/include/hw/pci-host/xilinx-pcie.h
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


