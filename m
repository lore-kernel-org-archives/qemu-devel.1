Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F17C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB40420786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa65ZW/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB40420786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCar-0004w9-5N
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPY-00020e-2j; Tue, 16 Jun 2020 10:18:01 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPW-0006ct-Jc; Tue, 16 Jun 2020 10:17:59 -0400
Received: by mail-oi1-x242.google.com with SMTP id d67so19349814oig.6;
 Tue, 16 Jun 2020 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mm6Vzeu6v4Wn/c8RqfvMPXPL7u7lWwdQ4IQrVXI00+I=;
 b=Fa65ZW/HIlqMjjHRO84ugLMbA76D7/zKO5Bom9gEvwMOSfD+Je57sdDMPZs3BJyd7u
 LKlIBHqAQZ/GbX5Ug56KQu1F/pnhNvZmg+DNqpm5Z5NioN/vaRcZzPjCC54t9qixuYXF
 DC3EeXlzfRQg1yfiyuNu0gvMc/3yJU353AB8g659McpF/u6Xj9HiwwLF6lLDxLK2N1E9
 nLdE5U6DPo6StI710iRX5BbRifLCCrSY0us23fSW2rrp0aTgoCFUnMGPZxpZAsTOVyS8
 Hg4Kbm27xJ2GSoiP/jsXXcdXqbt/bFS1qrXFxRcsjN/U35VPAOCYQl1t9sRn1XjzIjPI
 c8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=mm6Vzeu6v4Wn/c8RqfvMPXPL7u7lWwdQ4IQrVXI00+I=;
 b=YjqT7QBSJLc4dj6bw5+xJDGMRj6/Gx0QylChMEnERqhSSvvXcmyYQMywHEnAH9x9Ut
 1jnzPHs3arM1A9w57eq9SMVT2DK0ubrVJDrrs1miGG/ZwpwdPnVwjXNCoEAIgLWOF9T1
 HQp6fxI+fyvr7oh4/8Z/fg1ZQzQ9TSme2h+q6wYHlub9Ts7UXMA3Vg3HD5Eh7lC2rh5Z
 ezfU4fKpmKN0dTPWI91nK1N1XchGARqAFE3drBTjHvch1uBGh+g+IOFR2n6aTDNVizki
 t3ZrAFsPHZJV15uE+G8jj1nX2uX9Nbq5x/envwi9sTP2Dyjsk5xRzApYylNeQyVqVCh6
 fGUA==
X-Gm-Message-State: AOAM530w2hzEzaIOVJHjUOCWSeB7DtUDGlNLyrI/D+wtAF5d9eG62kli
 bwkrkdFu4nCaIlRCAQB3OWnYhptm
X-Google-Smtp-Source: ABdhPJymWhxwiBRQHRpVsZqSB3GBhki+JIzheCMvbmzjKIPTLeVNCghC+7AuTKU8R0zfI2LfizfEeg==
X-Received: by 2002:aca:4e0c:: with SMTP id c12mr3482764oib.145.1592317076892; 
 Tue, 16 Jun 2020 07:17:56 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g51sm4041470otg.17.2020.06.16.07.17.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:17:56 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/78] intel_iommu: a fix to vtd_find_as_from_bus_num()
Date: Tue, 16 Jun 2020 09:14:52 -0500
Message-Id: <20200616141547.24664-24-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Tian <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 Peter Xu <peterx@redhat.com>, Liu Yi L <yi.l.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Yi L <yi.l.liu@intel.com>

Ensure the return value of vtd_find_as_from_bus_num() is NULL by
enforcing vtd_bus=NULL. This would help caller of vtd_find_as_from_bus_num()
to decide if any further operation on the returned vtd_bus.

Cc: qemu-stable@nongnu.org
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Message-Id: <1578058086-4288-2-git-send-email-yi.l.liu@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit a2e1cd41ccfe796529abfd1b6aeb1dd4393762a2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/intel_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 43c94b993b..00ebae4863 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -948,6 +948,7 @@ static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_num)
                 return vtd_bus;
             }
         }
+        vtd_bus = NULL;
     }
     return vtd_bus;
 }
-- 
2.17.1


