Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC12EC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0825B2224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0g9hs6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0825B2224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUZAW-000447-LV
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 13:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUZ88-0003LN-Jj
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUZ86-0006V2-Gv
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603129168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VCxst2M00Sz2RCvcuZWuILpK3YzfgioEzr92Dyzp1IU=;
 b=T0g9hs6GKe6xc/CjuaVePYk89EUxGMNZXMGoKlv8JQK74hgJsd4wddXnR5uLwgQONWrAsr
 biXi27f/bq43PzVuIgAIz7nT1ozUdzdWNr977bPmYI3OiIZlc2eLimwG/kkWS5enHF5zIw
 /W1uqox67wx6M80fQ9fzCG9cEgbb8aQ=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-gZUmv4HVOjqshIM0aP11Ow-1; Mon, 19 Oct 2020 13:39:26 -0400
X-MC-Unique: gZUmv4HVOjqshIM0aP11Ow-1
Received: by mail-il1-f199.google.com with SMTP id i14so652973ils.21
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 10:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VCxst2M00Sz2RCvcuZWuILpK3YzfgioEzr92Dyzp1IU=;
 b=cqTmOs0rMrEfFFdWc4yeI/jNW1YFku1F35gIXBlffH3ACBkyrTLGWjWt6U6Dyjufr/
 y1R36+yXLnSiK4Lp/gdrbNdPKtyzx5pjsiMf0h3c+c2Cb5nKOinF6NBv1TfKGp+lqMnG
 iZsOU+vqRCpWrt+8+6Z1+4gDrBILuLNKbCasnc4JhaR+mHQprtlXq9VoAPQVbd2Fbq1v
 0vs4VOp18jHjVkW8vi3NxLSk2sN0lqpTaobtijL6cZEu19RsV9WEWX/GgcYmLoEnku/C
 KqYOzY1Xo9czfbQaJKEU7oNdaRPN+CUfmJbWrlblGbIekJLl+W7ub83IJ4tVHTC49mae
 +BKA==
X-Gm-Message-State: AOAM5320X3EMkv0W+CGlbE26D70a6skF98suFElVrvau5lKcXVKbf5LP
 iEpp1/kAfmqrKcNfO804YP7p6uCuErDDJwVQvZSDgSe7miHADX/1pIvlVWEDyhkYAyfG1Tuq+oe
 ZlCvTnQEQLq+n+kQ=
X-Received: by 2002:a92:b503:: with SMTP id f3mr960930ile.23.1603129165860;
 Mon, 19 Oct 2020 10:39:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygmz4+FZw27+T4r8tSdXD9clS0jm1X9djv4oxYaaiUBeKXLi4Z5aqNb4ePlZ/mMV40FZ/xwA==
X-Received: by 2002:a92:b503:: with SMTP id f3mr960917ile.23.1603129165627;
 Mon, 19 Oct 2020 10:39:25 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id t12sm329300ilq.76.2020.10.19.10.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 10:39:24 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] intel_iommu: Fix two misuse of "0x%u" prints
Date: Mon, 19 Oct 2020 13:39:22 -0400
Message-Id: <20201019173922.100270-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Jason Wang <jasowang@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dave magically found this.  Fix them with "0x%x".

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 749eb6ad63..70ac837733 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2665,7 +2665,7 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
 
     if (addr + size > DMAR_REG_SIZE) {
         error_report_once("%s: MMIO over range: addr=0x%" PRIx64
-                          " size=0x%u", __func__, addr, size);
+                          " size=0x%x", __func__, addr, size);
         return (uint64_t)-1;
     }
 
@@ -2716,7 +2716,7 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     if (addr + size > DMAR_REG_SIZE) {
         error_report_once("%s: MMIO over range: addr=0x%" PRIx64
-                          " size=0x%u", __func__, addr, size);
+                          " size=0x%x", __func__, addr, size);
         return;
     }
 
-- 
2.26.2


