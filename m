Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF178C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED8020693
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hko+fzod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED8020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjVCw-0006ax-WE
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUk9-0004Lc-L9
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUk4-0002nV-1N
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:32826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUjz-0002hF-Rn
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:33 -0400
Received: by mail-wm1-x331.google.com with SMTP id h19so8294532wme.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6hb8qfyahz2ocOwlim+36bgUK6wk1cqH4qWGOP6ftsg=;
 b=Hko+fzodl8+JD8D73EYnXwlYk+GPuXKtCus7vta2/z06DkOljoqZf+KDfoztMdtcvg
 zTnKkGkkuR9JeK6uO95foCLDS85CEpOd4OacedKLXuXJAedBobIU3xGGODI85J0PoNGr
 d6OKPgiwZ/mwVn3SdAxt7YuhVr92K7Yh1ngSmSr43TnROgE3nKjWZ0UOax8eWM1tGaXc
 jQf7+2W4LKgxU51sOtJKVp5NbXjYaVpaT5RGVtP/2+Skx0TepFvpL4nr0anyZLSzr5I7
 zvNkqAo7HVaMCBBdtTTGhMSBYilMa7Do/xi87sn6CNZIJn5korD4ZilJ2h0oeudpOijb
 h1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=6hb8qfyahz2ocOwlim+36bgUK6wk1cqH4qWGOP6ftsg=;
 b=Poam5avqWEoelLoxor1/1MriiLEUp61dCpR4UW7CLVhpjkhnUTIpbFcQcA/z/h4hdI
 YHu9Um3eNmedAZFbZscHxPGURsnZfuJR7xUi4KXf+JVWVXqCnwucXnJCBotkhQXjsVjx
 xx34b51yhyWeDg+0f6cBR9kJic1TB/WfDh8OBvsgqYGD22VdT7UHGXFhfUh0p98BDJgj
 I3bzivk3T/7Vp+rQklew0X6/P19vcF3BtK97X/YsH3KbAEjdLHFnLKG4I2mAJLhzmmsu
 Dv2oYAel93920/o5I25P1aODnTUD2+g6T4AWaMfmJzt48uNs8W5F83mMN7C2iKOF3vKQ
 UmDw==
X-Gm-Message-State: APjAAAXlVMUKEk9HIPltz9/FmPiq+Yuoo5K+WsbagO25//CHoF4Pm4sU
 5FjZfvvrPS19F72hFm9Kf0ZQPm5kxU8=
X-Google-Smtp-Source: APXvYqzelV1hXtG3JdTtXL5MsM7WN2MTxuYvaYY5mr+BK26XZjbx40EdMQPXu0XUMcYk4Bn7Z86O2A==
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr4200674wmd.87.1562358207498; 
 Fri, 05 Jul 2019 13:23:27 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id v23sm3035875wmj.32.2019.07.05.13.23.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:23:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 22:23:14 +0200
Message-Id: <1562358202-28008-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
References: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PULL 04/12] intel_iommu: Fix incorrect "end" for
 vtd_address_space_unmap
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
Cc: Yan Zhao <yan.y.zhao@intel.com>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yan Zhao <yan.y.zhao@intel.com>

IOMMUNotifier is with inclusive ranges, so we should check
against (VTD_ADDRESS_SIZE(s->aw_bits) - 1).

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
[peterx: split from another bigger patch]
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190624091811.30412-2-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/intel_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 44b1231..719ce19 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3379,12 +3379,12 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
      * VT-d spec), otherwise we need to consider overflow of 64 bits.
      */
 
-    if (end > VTD_ADDRESS_SIZE(s->aw_bits)) {
+    if (end > VTD_ADDRESS_SIZE(s->aw_bits) - 1) {
         /*
          * Don't need to unmap regions that is bigger than the whole
          * VT-d supported address space size
          */
-        end = VTD_ADDRESS_SIZE(s->aw_bits);
+        end = VTD_ADDRESS_SIZE(s->aw_bits) - 1;
     }
 
     assert(start <= end);
-- 
1.8.3.1



