Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A0DC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FFF20678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPl9B5Fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FFF20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDx9w-0001P5-Am
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwM8-00052Y-9l; Thu, 03 Sep 2020 17:01:17 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:33364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwM6-0007tE-Dh; Thu, 03 Sep 2020 17:01:15 -0400
Received: by mail-ot1-x332.google.com with SMTP id m12so1037932otr.0;
 Thu, 03 Sep 2020 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Y3yC2SOnzE11vtRpT71Fc4IxJOCN3PFXC+OmZRbaviY=;
 b=ZPl9B5Fzq1R/hqw20AxD3H4qqtKxTa/lXYm+Tmk3eExvwymvFoyTzut0dC1WfLjIqD
 K5wDHLxDx81YFqSPJcGveId3LcCEop0Q2w8BjfDLsctbgcF1z6y/dS5klMyPi8zodpsP
 JlQWhGUDnbnkHZev6g0PHiZMcpOU/qAZoqCIbZ7O7LL7fSEzmdXsgK6KLa7/6g67jSBl
 6hAps7dnF1RdSW6wrTNjDiO/L2YnOKC9hW3Srm5xSg9j8w9nSalo+zJe/+iqbZGHeHqQ
 xWdUbQwNJzp+tfLsX4X0GgshRo8GS0rAIUIFmLVmUtVQ9R7Yebv3S/VrPjqmOZg/S38z
 QUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Y3yC2SOnzE11vtRpT71Fc4IxJOCN3PFXC+OmZRbaviY=;
 b=GvXGnC4ZzGS6WGWzI3wIuuJ0/U6/xJYJTPJpLIA6vNGghqLTKQuBzZM2VEReyXttsc
 vyEPj8ZYeWfM+i1aYNHmvOtU3rfyaYUoBN6stowTWXN6zaOy3Z8tE6XmkeWu6DpryccM
 /0Xfc2vagBCr049dBVTAnLnrAkPzU6dnAVR5cXpO2l4axfN7xXGJhkYfyfkhBG8mPhNc
 rnTlE7xp3RZQjZZJkfemog/jpPcOlR5LBxRin9OajJ6vaft0KymFbkdA9lLHJJ3EcgFe
 4nPPUuPUDUv1dLsnBgw1NpY54hjgJvBfDZcupvIQf+wlPyB0gZ6d05SKsNfFBKrQnMU8
 gEfQ==
X-Gm-Message-State: AOAM531mna+6QwhMRIih45ty0fkZYtWBFnuefs0LA1+5Akrj9CtQ19+p
 IYGZIb61nS0rZ6SQMsVq0oC4IscqSQVRSQ==
X-Google-Smtp-Source: ABdhPJxG8u0OcMNMEtQmHDl6WeqW/hTeDfHWLIldHXVV70RparNQ/X3+VWRVJ+ggemRtRuUZ6/IvGA==
X-Received: by 2002:a05:6830:13d7:: with SMTP id
 e23mr3098746otq.98.1599166872334; 
 Thu, 03 Sep 2020 14:01:12 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id t1sm855106ooi.27.2020.09.03.14.01.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:11 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 67/77] intel_iommu: Use correct shift for 256 bits qi
 descriptor
Date: Thu,  3 Sep 2020 15:59:25 -0500
Message-Id: <20200903205935.27832-68-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Liu Yi L <yi.l.liu@intel.com>, qemu-stable@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Yi L <yi.l.liu@intel.com>

In chapter 10.4.23 of VT-d spec 3.0, Descriptor Width bit was introduced
in VTD_IQA_REG. Software could set this bit to tell VT-d the QI descriptor
from software would be 256 bits. Accordingly, the VTD_IQH_QH_SHIFT should
be 5 when descriptor size is 256 bits.

This patch adds the DW bit check when deciding the shift used to update
VTD_IQH_REG.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Message-Id: <1593850035-35483-1-git-send-email-yi.l.liu@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit a4544c45e109ceee87ee8c19baff28be3890d788)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/intel_iommu.c          | 7 ++++++-
 hw/i386/intel_iommu_internal.h | 3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index df7ad254ac..8703a2da42 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2549,6 +2549,11 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
 /* Try to fetch and process more Invalidation Descriptors */
 static void vtd_fetch_inv_desc(IntelIOMMUState *s)
 {
+    int qi_shift;
+
+    /* Refer to 10.4.23 of VT-d spec 3.0 */
+    qi_shift = s->iq_dw ? VTD_IQH_QH_SHIFT_5 : VTD_IQH_QH_SHIFT_4;
+
     trace_vtd_inv_qi_fetch();
 
     if (s->iq_tail >= s->iq_size) {
@@ -2567,7 +2572,7 @@ static void vtd_fetch_inv_desc(IntelIOMMUState *s)
         }
         /* Must update the IQH_REG in time */
         vtd_set_quad_raw(s, DMAR_IQH_REG,
-                         (((uint64_t)(s->iq_head)) << VTD_IQH_QH_SHIFT) &
+                         (((uint64_t)(s->iq_head)) << qi_shift) &
                          VTD_IQH_QH_MASK);
     }
 }
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 862033ebe6..3d5487fe2c 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -230,7 +230,8 @@
 #define VTD_IQA_DW_MASK             0x800
 
 /* IQH_REG */
-#define VTD_IQH_QH_SHIFT            4
+#define VTD_IQH_QH_SHIFT_4          4
+#define VTD_IQH_QH_SHIFT_5          5
 #define VTD_IQH_QH_MASK             0x7fff0ULL
 
 /* ICS_REG */
-- 
2.17.1


