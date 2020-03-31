Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E127C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256BF20675
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cziBRy+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256BF20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJILq-0002Ni-2E
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJIKU-0000By-Mi
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJIKT-0005G4-K7
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23365
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJIKT-0005Fj-FR
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585666645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3H/VwsSTTvhtpNg2QmTT6j5ZuTBdZBFJCOku4RulJDk=;
 b=cziBRy+uqQHgTbEl1vZ1oD0CcDACXQNLgOpzegKU/ejqJVXuWVJ2ZztA8K/LJpuG/wdWO8
 EvGLHIEBezLpqAS2p5jEXWzeVdhGYc60OIJG0BHjueX8b8UNhpqgoS1hSjvPIRB7QbBfEM
 h1s2WMzJcgsGuI7Mw/SEAz89KVRNc2Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-B_AKgg2nPpyJNTrOcIntFQ-1; Tue, 31 Mar 2020 10:57:23 -0400
X-MC-Unique: B_AKgg2nPpyJNTrOcIntFQ-1
Received: by mail-wm1-f71.google.com with SMTP id f9so796422wme.7
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=x+B8mYBE9cPql6HF4nADxpZb0302JvKpESQBouHDOpE=;
 b=NoZDlS/LCntetufih4v95kytRnVRCKgK9BRaBYbd4chcW9DwxfyL408RQGTpAXmJg+
 /PsNEgV1cbC8xfeUVwWLV3pB6+z4OntkkX6WjW0zvcnyJmI31mkDiqj4+MJ7d+BZ1hew
 r5UQ/CbjXuXxa/XKKViB3lse1itJOZrGECit+4L6FQBY3+sQOtw2yUl/NfGpZQlpMhOX
 YRd0f+NoSt3F2Lxx5Flih0039Ob6bQYUw2NDQtWIPEyS//lzTeS8yPIZ2DZ0s3vp/Wqg
 0704KD9V5MXyuDw9YX/qiKo1Gl4X9o7scveXuWM74RK5cicE7IBXJJ7bXcUtk6DL9Lac
 gD/Q==
X-Gm-Message-State: ANhLgQ1vUMLa8NnPQrQn6FMKJkvbpAvMT43bXuCo+rfVMqx92ApbSCFt
 bhrs2Wv9/s21rwdoCMNzZNixR2do20nJBZ2+VNCDEwgiqpiZUCKbgwNbAh/G2LQsrLMMdPP3519
 mo1jworN6EFFIvew=
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr3849892wmd.8.1585666638938; 
 Tue, 31 Mar 2020 07:57:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvVoH4R9vtDDuaLznvDxX/poSm1H3whYVjMA2qNC0MpWjmDebAWhqr97YCe6yT4gD9Y0EKRKg==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr3849882wmd.8.1585666638768; 
 Tue, 31 Mar 2020 07:57:18 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id b7sm25930878wrn.67.2020.03.31.07.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:57:18 -0700 (PDT)
Date: Tue, 31 Mar 2020 10:57:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/10] hw/i386/amd_iommu.c: Fix corruption of log events
 passed to guest
Message-ID: <20200331145631.135630-8-mst@redhat.com>
References: <20200331145631.135630-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200331145631.135630-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-stable@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

In the function amdvi_log_event(), we write an event log buffer
entry into guest ram, whose contents are passed to the function
via the "uint64_t *evt" argument. Unfortunately, a spurious
'&' in the call to dma_memory_write() meant that instead of
writing the event to the guest we would write the literal value
of the pointer, plus whatever was in the following 8 bytes
on the stack. This error was spotted by Coverity.

Fix the bug by removing the '&'.

Fixes: CID 1421945
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200326105349.24588-1-peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index b1175e52c7..fd75cae024 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -181,7 +181,7 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *ev=
t)
     }
=20
     if (dma_memory_write(&address_space_memory, s->evtlog + s->evtlog_tail=
,
-        &evt, AMDVI_EVENT_LEN)) {
+                         evt, AMDVI_EVENT_LEN)) {
         trace_amdvi_evntlog_fail(s->evtlog, s->evtlog_tail);
     }
=20
--=20
MST


