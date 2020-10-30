Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A867C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060342076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRkobOkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060342076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVJ9-00070X-0z
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8n-0003kb-27
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8e-0007GP-5o
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604067137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qvybBCIE1Zjv+mt4qBhgbngIyzXePj4i5BwfD1rO8Y=;
 b=fRkobOkCOuLtGRwVoTJ09pOtj9QZ23IegeDvX1AJrDf1im1NB3XbMdiesi6qLg3WuBrUiO
 cPBn0URkX/x2fRAuPKqT/CWjctH/ZjW3B50noUwJzx1OQYcHCdnAYIsaaUi4Q9dVlPdPPI
 tZgUXy1akFDqmCtGzFVesEyezt2l/vY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-W60H11_yMPqhqjjq6OPXeQ-1; Fri, 30 Oct 2020 10:12:15 -0400
X-MC-Unique: W60H11_yMPqhqjjq6OPXeQ-1
Received: by mail-wm1-f69.google.com with SMTP id s25so1288277wmj.7
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2qvybBCIE1Zjv+mt4qBhgbngIyzXePj4i5BwfD1rO8Y=;
 b=UazhQq/dLbYlSyZGGAV6/WnBbH2hwgKJXTrKXYMb/Gui/pyi7iL585Y06qNLj1NP7p
 JA6R10jsT8ZJ3HAfPy1oR2jIQJ2Ndnan/wzZeOQav6f0NWQ98rQG1afuJNwz16S2pp7w
 7ndlBwUieUJLtGRuFSZKyQSXbCouoa2rSsDrz0ybfr+/tZC6Z/LJpgGorzMjpSIUmcoT
 Oeye3qffPRtwRhCBFK7xD11ENGOZ92GM6aroPmklc7QWwHBA6qwII6PBGf9A2qtu23es
 LT08BK6Ts9krrX8CT+GoPKpD4Z7MDLL8cCA0PX5abyzXe5UdBm9arFZDwjsMO7NoImes
 /Ovg==
X-Gm-Message-State: AOAM533YXz2T3hCKf8mcKuXE0oJ/ehGLBmLRUjt5HnQ+Uj+XajewIXGi
 4uNiY7BLkLYP4U1I3uSPDx7WaUPmNIzRkl2qQotrcd3fyHKYT8ZbpjtY0brDpXJxPSd1+IPobxH
 tRMC/8KNoDexQHCY=
X-Received: by 2002:adf:f3d2:: with SMTP id g18mr3385102wrp.367.1604067134045; 
 Fri, 30 Oct 2020 07:12:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN5kYZwPcNmSF7+TOoJ8g7ZuWgR9u7nQCz4L3ssK5qlCIn5bV6VWcBJQDRJiNcTgeL3C38Uw==
X-Received: by 2002:adf:f3d2:: with SMTP id g18mr3385078wrp.367.1604067133852; 
 Fri, 30 Oct 2020 07:12:13 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id m1sm4744210wmm.34.2020.10.30.07.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:12:13 -0700 (PDT)
Date: Fri, 30 Oct 2020 10:12:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/15] pci: advertise a page aligned ATS
Message-ID: <20201030141136.1013521-11-mst@redhat.com>
References: <20201030141136.1013521-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030141136.1013521-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

After Linux kernel commit 61363c1474b1 ("iommu/vt-d: Enable ATS only
if the device uses page aligned address."), ATS will be only enabled
if device advertises a page aligned request.

Unfortunately, vhost-net is the only user and we don't advertise the
aligned request capability in the past since both vhost IOTLB and
address_space_get_iotlb_entry() can support non page aligned request.

Though it's not clear that if the above kernel commit makes
sense. Let's advertise a page aligned ATS here to make vhost device
IOTLB work with Intel IOMMU again.

Note that in the future we may extend pcie_ats_init() to accept
parameters like queue depth and page alignment.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20200909081731.24688-1-jasowang@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 5b48bae0f6..d4010cf8f3 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -971,8 +971,9 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset)
 
     dev->exp.ats_cap = offset;
 
-    /* Invalidate Queue Depth 0, Page Aligned Request 0 */
-    pci_set_word(dev->config + offset + PCI_ATS_CAP, 0);
+    /* Invalidate Queue Depth 0, Page Aligned Request 1 */
+    pci_set_word(dev->config + offset + PCI_ATS_CAP,
+                 PCI_ATS_CAP_PAGE_ALIGNED);
     /* STU 0, Disabled by default */
     pci_set_word(dev->config + offset + PCI_ATS_CTRL, 0);
 
-- 
MST


