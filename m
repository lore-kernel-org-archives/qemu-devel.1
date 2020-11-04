Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0DCC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311EE20BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bA2879TM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311EE20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAqz-00063O-4a
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 23:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAld-00062f-Cl
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAlZ-0004XT-7b
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yb0+hTu/cI4h7Se3wHsf9S5j6pZCfXhlBpQERrIdWig=;
 b=bA2879TM+kId/TDhzvzT7iY/+TTHKe35+WxYLPV/BjqnA5+FE9pM8/sS1y1B/8FkUtafLJ
 XKKwAS7YOBgSCRZT2kWkimqvxRQdxsfT7jZv4iKUUFjlDuSQgYmHuogbW/hyU5S92OZLOm
 VV5iqKylNrypWbIpM8FYsTwtmSPQn54=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-sa79lTsPMouyet9jeOpn4g-1; Tue, 03 Nov 2020 23:51:21 -0500
X-MC-Unique: sa79lTsPMouyet9jeOpn4g-1
Received: by mail-wr1-f70.google.com with SMTP id v5so8788509wrr.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yb0+hTu/cI4h7Se3wHsf9S5j6pZCfXhlBpQERrIdWig=;
 b=IT5HmwRO48utmBytAHynZH0rStpHMR+aFOg3FT99+crIneQ7JesSSCbXsZAx18LIl7
 298HaT/d61tCqIzyxezm7lqsR1rlefJB150U+m+ZUQIjPEHB/pWZfXP8HBDJ7iTfS9us
 kLfDCcAZ1IVZfHUzh+MeJoLa+1asYN4xHGICzckWpqU1u9lROW3DXw4qKad8WCks2fiL
 pkk2F9VqKUYVtoJ273oTo04cO4JxwzSWMmdzO/84YmyxoGmXwMFJ3eBsvrkl3YbEVaBW
 W0dwhSpcnyRUl8WEhu01wcam9/j24lUSxkFRxijawt6f0ZuITD+ecrflA5Yvs77y3qIa
 rp+A==
X-Gm-Message-State: AOAM532B6aQu6+/iv0FLP2SiQiZkGxfhhwRAESqVxf/1BL+ynZk+doBW
 zUiF7WlARf7vULd9/khzmE8YHRaFU/ogXxnisql+S/gQPl/d+lUZpLUTaKerpPU009RCsDBzgKr
 Yfp2BpOQav3SktdE=
X-Received: by 2002:a1c:a145:: with SMTP id k66mr2409639wme.177.1604465480283; 
 Tue, 03 Nov 2020 20:51:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7tJ5ajwMwbMv+jApvK1qMSLLpp6GStq0zFfUuVIYnSbc/9I0aoLydYKboHlyceWdmZmvanQ==
X-Received: by 2002:a1c:a145:: with SMTP id k66mr2409626wme.177.1604465480145; 
 Tue, 03 Nov 2020 20:51:20 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id s12sm839406wmc.6.2020.11.03.20.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:19 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 13/38] virtio-iommu: Fix virtio_iommu_mr()
Message-ID: <20201104044937.226370-14-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 QEMU Stable <qemu-stable@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Due to an invalid mask, virtio_iommu_mr() may return the wrong memory
region. It hasn't been too problematic so far because the function was
only used to test existence of an endpoint, but that is about to change.

Fixes: cfb42188b24d ("virtio-iommu: Implement attach/detach command")
Cc: QEMU Stable <qemu-stable@nongnu.org>
Acked-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-Id: <20201030180510.747225-2-jean-philippe@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 21ec63b108..4c8f3909b7 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -101,7 +101,7 @@ static IOMMUMemoryRegion *virtio_iommu_mr(VirtIOIOMMU *s, uint32_t sid)
     bus_n = PCI_BUS_NUM(sid);
     iommu_pci_bus = iommu_find_iommu_pcibus(s, bus_n);
     if (iommu_pci_bus) {
-        devfn = sid & PCI_DEVFN_MAX;
+        devfn = sid & (PCI_DEVFN_MAX - 1);
         dev = iommu_pci_bus->pbdev[devfn];
         if (dev) {
             return &dev->iommu_mr;
-- 
MST


