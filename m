Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB619C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F45B206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSRR2Ohw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F45B206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvfR-0001xM-Tw
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveI-0000mf-Gl
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveD-00046X-EP
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55633
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jQveD-00046F-2x
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587486080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWARAODmBStGiYrFPvbCFJNkPOytrLfsKcpWRULN7JI=;
 b=PSRR2OhwcWkW6Ig5qrCmQqUmw9Ac/ckFRA0kCEzHQybdY8/xo05oyNDTV5Vb4jnozQAaVC
 oyQsHd57ppccsob/okAC5uGDvZbJmYc8+H+qRp4RnnjkATWIJkCktiUjGCMruZBhcfpoBH
 NrO/6YOXTItzhD7ARi88LTZHPC6lJ54=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-w_v2Gy5NPiOCpfR1i78Bcg-1; Tue, 21 Apr 2020 12:21:18 -0400
X-MC-Unique: w_v2Gy5NPiOCpfR1i78Bcg-1
Received: by mail-qk1-f200.google.com with SMTP id a187so14579401qkg.18
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 09:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O9l/BvBydUlEJUjD9a9P0sgBp3L6+LGe0OTTKmSjbXg=;
 b=bKus1GnmzFSuur0nj5DTS/UNgZAA/uxRJ7jz8BTSXQpPdLulOPNlpPQ7kjTeU9eNdL
 glomsxa7cEvz9IIxiKfEZ3GYalr7lZUo3IcaAeKeFOUZmwXqIWhO5z1w6TQaATTRZhiB
 k21wGwWtVrS6/Qd3iq84XGkXCgEMz6e56Aft7dLX1O/o4SXHZtmfDx+EGWuTCa4oIZe2
 X1OrUNd3fRW3/M7sTBAVD7AO8MbJzNqKgg3aBoq5iNNPwb0sXE+EjN4fBnil0FI4rQ0G
 MFihFhX7UzmYmXMWX+gA2fxq2QJvtrQZD2TMo881Le4dHr/i/l2I0oqbgmVzZ+kUOqiI
 lwUw==
X-Gm-Message-State: AGi0PuYvhzRjHxr6tERzUGOBoJosO6wJ+aleRSD3RFUB21ccq28p8/4a
 FE6XnI8KzsZQkptwyNduuCdSVI9gOdAdJJ8fOdw27GFDLbZtS5fUUBMEv0Fq36EfwFtBBscVdch
 8Qu0kamf5GLA8PjI=
X-Received: by 2002:a05:620a:228:: with SMTP id
 u8mr22773764qkm.309.1587486077885; 
 Tue, 21 Apr 2020 09:21:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypJwmIMZM1MbMcC9Qf5/Wp3f7cgLATEQeVTID+i/5dJRNXJOjG/HWTnMlDs5xF3EQ1P+tlfhWA==
X-Received: by 2002:a05:620a:228:: with SMTP id
 u8mr22773736qkm.309.1587486077630; 
 Tue, 21 Apr 2020 09:21:17 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id h2sm2043688qkh.91.2020.04.21.09.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 09:21:17 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/8] memory: Don't do topology update in memory finalize()
Date: Tue, 21 Apr 2020 12:21:02 -0400
Message-Id: <20200421162108.594796-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200421162108.594796-1-peterx@redhat.com>
References: <20200421162108.594796-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Topology update could be wrongly triggered in memory region finalize() if
there's bug somewhere else.  It'll be a very confusing stack when it
happens (e.g., sending KVM ioctl within the RCU thread, and we'll observe i=
t
only until it fails!).

Instead of that, we use the push()/pop() helper to avoid memory transaction
commit, at the same time we use assertions to make sure there's no pending
updates or it's a nested transaction, so it could fail even earlier and in =
a
more explicit way.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index e5d634d648..fea427f43f 100644
--- a/memory.c
+++ b/memory.c
@@ -171,6 +171,12 @@ struct MemoryRegionIoeventfd {
     EventNotifier *e;
 };
=20
+/* Returns whether there's any pending memory updates */
+static bool memory_region_has_pending_update(void)
+{
+    return memory_region_update_pending || ioeventfd_update_pending;
+}
+
 static bool memory_region_ioeventfd_before(MemoryRegionIoeventfd *a,
                                            MemoryRegionIoeventfd *b)
 {
@@ -1730,12 +1736,25 @@ static void memory_region_finalize(Object *obj)
      * and cause an infinite loop.
      */
     mr->enabled =3D false;
-    memory_region_transaction_begin();
+
+    /*
+     * Use push()/pop() instead of begin()/commit() to make sure below blo=
ck
+     * won't trigger any topology update (which should never happen, but i=
t's
+     * still a safety belt).
+     */
+    memory_region_transaction_push();
     while (!QTAILQ_EMPTY(&mr->subregions)) {
         MemoryRegion *subregion =3D QTAILQ_FIRST(&mr->subregions);
         memory_region_del_subregion(mr, subregion);
     }
-    memory_region_transaction_commit();
+    memory_region_transaction_pop();
+
+    /*
+     * Make sure we're either in a nested transaction or there must have n=
o
+     * pending updates due to memory_region_del_subregion() above.
+     */
+    assert(memory_region_transaction_depth ||
+           !memory_region_has_pending_update());
=20
     mr->destructor(mr);
     memory_region_clear_coalescing(mr);
--=20
2.24.1


