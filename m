Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB111C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3512133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rW3L7fRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3512133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUKw-0005Ya-N1
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 15:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55616)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEL-0005MT-IP
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEK-00047d-JB
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:39337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUEK-000474-Bj
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:48 -0400
Received: by mail-wm1-x331.google.com with SMTP id z23so10740026wma.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6hb8qfyahz2ocOwlim+36bgUK6wk1cqH4qWGOP6ftsg=;
 b=rW3L7fRubvpVyJ/ynb3Q1h5xKG34MgHZ2fdUbY9ZWFxIHfb3wXqHjAeCEfKigIMel9
 pncBY0xig6WO9ZDTDT280twf9HnpJMwW68glEr1mWSMugzzN+YNRSdCiBjjAjKmJsNKD
 NiYBNeCyJv51RkuCidfjb2BjoPESL+CS/CyCTdgeCGd+NrTt50BumIoVZQuf0we+BOQ5
 oTTvftRPdPlLkjmiJNiO1f2h9WP1Ixq9qcm3GNtlWoN2rgFfN2UAbag6tNzSy+A4aeb1
 0mjacAqnMt+2Ubg5XcV0Awooggv4BF2IdYtQcaG/v3aRyg2q6NJM8xTYlRdr2BBXOoZo
 SSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=6hb8qfyahz2ocOwlim+36bgUK6wk1cqH4qWGOP6ftsg=;
 b=LfsAHYsN52/I9+bXaanKnJHjAsRCcFxJhdAy61NGqL090H/1EMyfBvW5ATBUdf8EID
 60ngMPJEzwYr7b1d7Ned4DN32UUtlAaD0Nkx8rbkOMqWCbkNIlM7wSk/ajIJT/63nhwD
 7IOhXXcFrgAn3oCNeGEW9SIzATfYZoW61aY7rnde8HfY1f4mwgJTy51iZvH6zNEf7uas
 Blw5ftYB5rtFIGCETWgmIERwhZ64gTt08BXRGJn9X8s1njhoutgrHgFkDr0gOWuz283T
 YdJuJ9QYXc8GB9f/d4NO3zyPVu3cBeCEq58KGsgPa+E7dV4tel4Dv1KpHe0rvy321EbS
 Y0fw==
X-Gm-Message-State: APjAAAVN+F0g+UL8xNbUynDkMcY1c/XAHMbbwcWNWk2MIJuIV2hz8pSy
 hjs6NwAcg1pkdqwcQ38W1/y3bDb5jO8=
X-Google-Smtp-Source: APXvYqwfL1UWqriwB0vdH/n1KdL+XTAIsYbVV+KdYMEOSvhyFSrHSOOP3cmH77+YVFxlhmUTfMo4Rg==
X-Received: by 2002:a7b:c7cb:: with SMTP id z11mr272229wmk.24.1562356247207;
 Fri, 05 Jul 2019 12:50:47 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d10sm11478625wro.18.2019.07.05.12.50.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 12:50:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 21:50:31 +0200
Message-Id: <1562356239-19391-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
References: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
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



