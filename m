Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D531C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CAAA206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmPuLGk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAAA206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj1Bo-0000JI-5W
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jj15M-0001rA-Kh
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:48:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jj15B-0004lP-Si
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591796876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=zIHbjAuTXCXAYtFA8fUW6Vwi+20Th0tosizv7lYurWk=;
 b=hmPuLGk5U2HPUelogve8MLCa9Gyd0YPEAJuKtWqLdZSoaVKPSHcfMnJqRSueABrBA0dVcZ
 06P9B98e+NJl4Rnx1diCinDp2JjV9hiVJ41BgoYkctF6TEJgT9SxOt/B8BsTYjIXFFtYKC
 ihfV86dzamHJ6cpECdz0rURV1x/O2H8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-y_4kQJlHPUWVLIFcsfjeFQ-1; Wed, 10 Jun 2020 09:47:54 -0400
X-MC-Unique: y_4kQJlHPUWVLIFcsfjeFQ-1
Received: by mail-wr1-f72.google.com with SMTP id f4so1101841wrp.21
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 06:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=zIHbjAuTXCXAYtFA8fUW6Vwi+20Th0tosizv7lYurWk=;
 b=TCSOtJeVTi6nbGTIGgAwtYGNFh9vCDFTMQprloJ2gLNFSiiquoFvwwZeBPdH8m+ZZC
 Rj70Ab9SoaqORGd2MmFX6VMc9zzsa+jWPUcZcjdLlFH0F0LPaJsqouFgTM9q/UvExxV4
 NzSw4iigR9qRCUxs0UPe+MknYdjdZasEvfauduFCGoYH/WDuTpvWacBG41GmnVMMnqKs
 g/MNQg2JsFwRG+y8qovjXIQ8Yu4M3ueaqmNZtkDgUknnNjA50sm2NnBxG9sKiKlXWj2d
 7stzvRl9dm2nwy1eDNJIa2hAi9E+cDhtAtM+Vvk80oUZeL2zHHxNp+xxr2AKePdevVxp
 Xgbw==
X-Gm-Message-State: AOAM532pEsXKExyUTK7/2tPmcukAa6NtuquqU/k3iPTIPKISW8495OlM
 2V1l+/XN63OLdYCKCj8Ehbiqj8CjVdrqMhE9nxS6bAqLbFWXmUlXMJp/zZP2amT0AswPqwpeTRf
 j8NiA9+GNMKsYxxI=
X-Received: by 2002:a5d:6986:: with SMTP id g6mr3951073wru.27.1591796872999;
 Wed, 10 Jun 2020 06:47:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjEXGrY2vgqUqKgFE1ftCULDYdAP/4IbVwuvn16o80BKIprEbk3mYxJHNOTrjy8TOxivUvuQ==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr3951040wru.27.1591796872619;
 Wed, 10 Jun 2020 06:47:52 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
 by smtp.gmail.com with ESMTPSA id i10sm8095061wrw.51.2020.06.10.06.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 06:47:52 -0700 (PDT)
Date: Wed, 10 Jun 2020 09:47:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] memory: Revert "memory: accept mismatching sizes in
 memory_region_access_valid"
Message-ID: <20200610134731.1514409-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Memory API documentation documents valid .min_access_size and .max_access_size
fields and explains that any access outside these boundaries is blocked.

This is what devices seem to assume.

However this is not what the implementation does: it simply
ignores the boundaries unless there's an "accepts" callback.

Naturally, this breaks a bunch of devices.

Revert to the documented behaviour.

Devices that want to allow any access can just drop the valid field,
or add the impl field to have accesses converted to appropriate
length.

Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <rth@twiddle.net>
Fixes: CVE-2020-13754
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1842363
Fixes: a014ed07bd5a ("memory: accept mismatching sizes in memory_region_access_valid")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 memory.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/memory.c b/memory.c
index 91ceaf9fcf..3e9388fb74 100644
--- a/memory.c
+++ b/memory.c
@@ -1352,35 +1352,24 @@ bool memory_region_access_valid(MemoryRegion *mr,
                                 bool is_write,
                                 MemTxAttrs attrs)
 {
-    int access_size_min, access_size_max;
-    int access_size, i;
+    if (mr->ops->valid.accepts
+        && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
+        return false;
+    }
 
     if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
         return false;
     }
 
-    if (!mr->ops->valid.accepts) {
+    /* Treat zero as compatibility all valid */
+    if (!mr->ops->valid.max_access_size) {
         return true;
     }
 
-    access_size_min = mr->ops->valid.min_access_size;
-    if (!mr->ops->valid.min_access_size) {
-        access_size_min = 1;
+    if (size > mr->ops->valid.max_access_size
+        || size < mr->ops->valid.min_access_size) {
+        return false;
     }
-
-    access_size_max = mr->ops->valid.max_access_size;
-    if (!mr->ops->valid.max_access_size) {
-        access_size_max = 4;
-    }
-
-    access_size = MAX(MIN(size, access_size_max), access_size_min);
-    for (i = 0; i < size; i += access_size) {
-        if (!mr->ops->valid.accepts(mr->opaque, addr + i, access_size,
-                                    is_write, attrs)) {
-            return false;
-        }
-    }
-
     return true;
 }
 
-- 
MST


