Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7454C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6056F20782
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQoIjRXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6056F20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNvw-0005tK-Ap
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjq-0001hS-Jg
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjo-00026L-SH
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aTAjTe4Celzp7fll7OULoNskonibl44hj9qWQyy3thE=;
 b=SQoIjRXbQ6Uh/8XWadbgGEUveuDhsE8SB+2ln6aIIzOCk73zE68xlPIpEhxfJCS57MLHuG
 6rs57VTGCpAvfJaoTfK97Y/qT0sYus9cW6gBvjxdFM5YwufnMAAwPFpuCQihun+fr6n5FL
 Ebo7kPh6Qktn9GZR7T2WS7oQD0H448s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-1MVJBzloPo6tdpQ6epLBcA-1; Wed, 04 Nov 2020 13:42:24 -0500
X-MC-Unique: 1MVJBzloPo6tdpQ6epLBcA-1
Received: by mail-wm1-f72.google.com with SMTP id t201so1564981wmt.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aTAjTe4Celzp7fll7OULoNskonibl44hj9qWQyy3thE=;
 b=pKppiBxpbgttSCLLghSXzhc0b/iIZ9/JRAhpdpoLbIhLMgurR9xjXqt+MWflds6Noq
 vHTaGD1lvfC3B7GZ2usnMy02b8dSyQKk2Z6LlGEiQBBdlMFqp5AzwP092QEqeTnMP181
 L8G/hWzmsXHv18uFxa/mDHgZVehFPil8+OP/l2PzMvZhv3Fg889YKo0DfBSqXGotAiFq
 WfOJI/DNNN9Uo+ijVljMzta7jt9dwuqCxBwToCF2NLAWFknDU+IW6sajffOM9veXU0Tu
 llF1QkhlDcSjffzhKzScZBYsZIHtjWir2VSdWX3X0HgJ+hyL92WMkxBTomMy7LgYQo3w
 LPUQ==
X-Gm-Message-State: AOAM533JfL3qxzFI8hSqMwiGzdPdkOE07PZzR9E9ZNhLKj0rI6IIa/lX
 xr1drqBTLRQkO+TNEKlFx9Ap5nUcAromGGpKfDo+vRjEIy2yg32BMrXitPs5IqpvOgmOjuaW/11
 q8SUZR8k5QToBryY=
X-Received: by 2002:adf:f10e:: with SMTP id r14mr32276638wro.337.1604515342311; 
 Wed, 04 Nov 2020 10:42:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0Ew60B9saI0kYYayGu9/3Anp3j/v1iSPyR3GKSxJsWsdXpXlyFoeEojgO6wYahTIY/9mEvQ==
X-Received: by 2002:adf:f10e:: with SMTP id r14mr32276620wro.337.1604515342162; 
 Wed, 04 Nov 2020 10:42:22 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id t23sm3284378wmn.13.2020.11.04.10.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:42:21 -0800 (PST)
Date: Wed, 4 Nov 2020 13:42:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 22/31] vfio: Don't issue full 2^64 unmap
Message-ID: <20201104184040.285057-23-mst@redhat.com>
References: <20201104184040.285057-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104184040.285057-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

IOMMUs may declare memory regions spanning from 0 to UINT64_MAX. When
attempting to deal with such region, vfio_listener_region_del() passes a
size of 2^64 to int128_get64() which throws an assertion failure.  Even
ignoring this, the VFIO_IOMMU_DMA_MAP ioctl cannot handle this size
since the size field is 64-bit. Split the request in two.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-Id: <20201030180510.747225-11-jean-philippe@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/vfio/common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 35895b18a6..c1fdbf17f2 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -950,6 +950,17 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (try_unmap) {
+        if (int128_eq(llsize, int128_2_64())) {
+            /* The unmap ioctl doesn't accept a full 64-bit span. */
+            llsize = int128_rshift(llsize, 1);
+            ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
+            if (ret) {
+                error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
+                             "0x%"HWADDR_PRIx") = %d (%m)",
+                             container, iova, int128_get64(llsize), ret);
+            }
+            iova += int128_get64(llsize);
+        }
         ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
         if (ret) {
             error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
-- 
MST


