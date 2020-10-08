Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EF8C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E5B204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mj6EG3yT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E5B204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZYY-0006Im-2W
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZXB-0004h6-Jr
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:16:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZX9-0006eB-U8
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:16:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id m6so7473181wrn.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gIAtQOZ+zrlWQfjLRgAdZMIze9gG8ZgbjrmwZekQ+1A=;
 b=mj6EG3yT0yJc/G6ZQvoBaj4avhGX07sIpd+W4SBW+osrHKGbtvS47H/hVgf8QyfUHe
 A0auhOk72VcwzoVaK00/aISFnJryUfozXWqiWS7B/5m5Zjgf3i/PhZcT9HyhB2f+vDQy
 XgoRYwtXVuE+6G8TKL7KbxrBauOpsVJFOqvC0wD+RllsoWfeb+Jd8syWJhIfKEVQ3cNC
 LFkKzwpLCqRSyp8A8UNzjXlbnJExQ+eSTYRoTa1RFPuYaPHFumI7h6hBfvi+ldhWo3wX
 opZoiY+DINBx/YqI/6S6l5uutKSUWpgKurJYu/YIG4J7VdbfNNLBZ4TTbb3j+mc5AMXm
 BvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gIAtQOZ+zrlWQfjLRgAdZMIze9gG8ZgbjrmwZekQ+1A=;
 b=cgHChoJVAnP63htJE6jXWvofaZxunEIi6Ogn8t7Hg1fbd+l6pZFWFADqlhJVswSB2Y
 2WofPacnHwTrtlV821gPIxUDcWm9Lc3vinuxdfHU5fzihp/BjWEPDOKvfZXNIGJEwFG3
 OiftpqB+VAJWZNOcHna58sVI6VKrBBg8qwbA4cvG2Zw0fPULg1gdWS4VLdSPZH78krb1
 gVThSYVk1xidOnguwsQxRChney3ptDEQjF0UYm14jgDzmZ+K+PJKpjORvlojfbReIwSO
 RxforAA5ZP3PXW4Xz0/MbSZkIf7M74tsPnEfeGaCvGhVaJgywTbVl0mOVhv41o/tTpo3
 v9cg==
X-Gm-Message-State: AOAM533nOk85rgTgSqL4Jj6npmsbjLG8izUYqKs41EKKlUky/hLb+A03
 CynYhf4JAoeS2FeSvzNlkjT94Q==
X-Google-Smtp-Source: ABdhPJyF/1ViTi2qRMbTXgKqpTpGV0nnp1HpSKSEeLboXZzCr42byYjowas4ASKTAXN5tJjxEFJ+8A==
X-Received: by 2002:adf:f3c4:: with SMTP id g4mr11146586wrp.207.1602177410647; 
 Thu, 08 Oct 2020 10:16:50 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x1sm719413wrl.41.2020.10.08.10.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 10:16:49 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v10 02/10] virtio-iommu: Store memory region in endpoint struct
Date: Thu,  8 Oct 2020 19:15:50 +0200
Message-Id: <20201008171558.410886-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008171558.410886-1-jean-philippe@linaro.org>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, pbonzini@redhat.com,
 bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Store the memory region associated to each endpoint into the endpoint
structure, to allow efficient memory notification on map/unmap.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Not super confident about the reconstruct_endpoint() change since I
haven't tested migration yet. Does it make sense?
---
 hw/virtio/virtio-iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 543fbbb24fb..33115e82186 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -49,6 +49,7 @@ typedef struct VirtIOIOMMUDomain {
 typedef struct VirtIOIOMMUEndpoint {
     uint32_t id;
     VirtIOIOMMUDomain *domain;
+    IOMMUMemoryRegion *iommu_mr;
     QLIST_ENTRY(VirtIOIOMMUEndpoint) next;
 } VirtIOIOMMUEndpoint;
 
@@ -137,16 +138,19 @@ static VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
                                                       uint32_t ep_id)
 {
     VirtIOIOMMUEndpoint *ep;
+    IOMMUMemoryRegion *mr;
 
     ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
     if (ep) {
         return ep;
     }
-    if (!virtio_iommu_mr(s, ep_id)) {
+    mr = virtio_iommu_mr(s, ep_id);
+    if (!mr) {
         return NULL;
     }
     ep = g_malloc0(sizeof(*ep));
     ep->id = ep_id;
+    ep->iommu_mr = mr;
     trace_virtio_iommu_get_endpoint(ep_id);
     g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
     return ep;
@@ -927,9 +931,14 @@ static gboolean reconstruct_endpoints(gpointer key, gpointer value,
     VirtIOIOMMU *s = (VirtIOIOMMU *)data;
     VirtIOIOMMUDomain *d = (VirtIOIOMMUDomain *)value;
     VirtIOIOMMUEndpoint *iter;
+    IOMMUMemoryRegion *mr;
 
     QLIST_FOREACH(iter, &d->endpoint_list, next) {
+        mr = virtio_iommu_mr(s, iter->id);
+        assert(mr);
+
         iter->domain = d;
+        iter->iommu_mr = mr;
         g_tree_insert(s->endpoints, GUINT_TO_POINTER(iter->id), iter);
     }
     return false; /* continue the domain traversal */
-- 
2.28.0


