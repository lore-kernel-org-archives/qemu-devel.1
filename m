Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8950BC54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB3F206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3X+W+9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB3F206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvik-0007Cu-SU
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveU-00017t-U0
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveT-0004EF-9V
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46842
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jQveS-0004Dr-SK
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587486096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDz7lahVpSsYjchGZFQF0Q24z99LRn1XXRfOl+p2CyQ=;
 b=J3X+W+9Y15776KKxo6upsaAB5rsb385JVHyMtCoezerUHcQ09eua1ttQh6GouyCmXgxFN6
 L2Y/usn9pWRAqYUfZXu+B6q/svfsf555vh1RWVQM86le9i0rnEEa6HTX/C8nhr7aGQkLIA
 Dx/ZB5y4urN3kP23HXJtCl2AqTGaOQM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-U_NGFeJjPsevu8n8VQpUKQ-1; Tue, 21 Apr 2020 12:21:34 -0400
X-MC-Unique: U_NGFeJjPsevu8n8VQpUKQ-1
Received: by mail-qv1-f71.google.com with SMTP id ck5so14259883qvb.18
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 09:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xr430nT3TegA7cHuep87EtnygKrdKqkDIQZx40c9Vks=;
 b=EcukyQoAEHZ9oplOhnfFWtB/eeBtlX4CEreNrsHIPldAr6DBaWRydF9UQj5cV0M77A
 qo5X4EeFuhfxJ+ltPIFAR9H4PqVvNLDbaZ/K1SDMUiSAHi5cPHrkekWIIl5HOxPyKddS
 7R4lPFw4BZQiuAx2xxaKIktGlWgFoeWK+em6V+WMVGr79l1cyIV3jzuu782aHkAbUbX1
 gXebepDQcWsS2QGW26i3y4+qKvyJBlRuhYB8V6IDsLp8OyIORvAZ564vY3pb0PXbdX90
 mScUHL8WdrUZa68YUJwCGODwMbUF63vtpjTWvXZMMCqwXrAFnK18BmjEwrZDgvwc5YNf
 znhQ==
X-Gm-Message-State: AGi0PuajuppigOyXOkIuMOLF6ojvzwAQivI4jZAymPJts0bVklToUii0
 xn6A/v+NuPYyPwJr3XAoaTa6/okErlE4Q8G5SwihjPoMll4xw1r7QROFg+zBqNBpKIeBmmqKtFS
 zcyhEcbWIcjeHcn8=
X-Received: by 2002:a37:8a87:: with SMTP id m129mr7695450qkd.250.1587486093605; 
 Tue, 21 Apr 2020 09:21:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypIwFZPkauDJAzhQKNhpSqCPX+CMXXtH4VIYb3UHXOy6bqkE6uZXNcrK9yZf1DZEY9lEM/ex6g==
X-Received: by 2002:a37:8a87:: with SMTP id m129mr7695432qkd.250.1587486093386; 
 Tue, 21 Apr 2020 09:21:33 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id i42sm2106688qtc.83.2020.04.21.09.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 09:21:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] memory: Assert on no ongoing memory transaction before
 release BQL
Date: Tue, 21 Apr 2020 12:21:07 -0400
Message-Id: <20200421162108.594796-8-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200421162108.594796-1-peterx@redhat.com>
References: <20200421162108.594796-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make sure we don't have any more ongoing memory transaction when releasing =
the
BQL.  This will trigger an abort if we misuse the QEMU memory model, e.g., =
when
calling run_on_cpu() during a memory commit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 cpus.c                         | 2 ++
 include/exec/memory-internal.h | 1 +
 memory.c                       | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/cpus.c b/cpus.c
index 48aa295fea..8c82556ff4 100644
--- a/cpus.c
+++ b/cpus.c
@@ -43,6 +43,7 @@
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
 #include "exec/exec-all.h"
+#include "exec/memory-internal.h"
=20
 #include "qemu/thread.h"
 #include "qemu/plugin.h"
@@ -1834,6 +1835,7 @@ void qemu_mutex_lock_iothread_impl(const char *file, =
int line)
=20
 static void qemu_mutex_unlock_iothread_prepare(void)
 {
+    assert(!memory_region_has_pending_transaction());
 }
=20
 void qemu_mutex_unlock_iothread(void)
diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.=
h
index 9fcc2af25c..3124b91c4b 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -35,6 +35,7 @@ static inline AddressSpaceDispatch *address_space_to_disp=
atch(AddressSpace *as)
=20
 FlatView *address_space_get_flatview(AddressSpace *as);
 void flatview_unref(FlatView *view);
+bool memory_region_has_pending_transaction(void);
=20
 extern const MemoryRegionOps unassigned_mem_ops;
=20
diff --git a/memory.c b/memory.c
index fea427f43f..2f8dc9721f 100644
--- a/memory.c
+++ b/memory.c
@@ -177,6 +177,12 @@ static bool memory_region_has_pending_update(void)
     return memory_region_update_pending || ioeventfd_update_pending;
 }
=20
+bool memory_region_has_pending_transaction(void)
+{
+    return memory_region_transaction_depth ||
+        memory_region_has_pending_update();
+}
+
 static bool memory_region_ioeventfd_before(MemoryRegionIoeventfd *a,
                                            MemoryRegionIoeventfd *b)
 {
--=20
2.24.1


