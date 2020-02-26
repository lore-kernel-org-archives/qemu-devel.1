Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC228C4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A913C21556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guXvnQVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A913C21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6z1T-00047j-TR
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 10:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j6z0F-0002RZ-7A
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j6z0B-0002OQ-6f
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27860
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j6z0B-0002NO-2t
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582732414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u4+w8Dl/8EJ3e5XX4k6et7mBYqdEHtW545t5121MYbE=;
 b=guXvnQVVd3ts9ZktAk4AftKWi7mrTw2wWWtmc69mekttfXzJzeRZI7zDy87+Oycyd/2vc4
 Zb1dPVETEhLyaqOntiIRNYSNamyYkNXPetD+B2gR/fFRkgK5rzKZYcU+h0TW0HiHzsh8Ah
 gEPkPQ0hipTRtCUdRkmgU9YP6+5AXvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-cm8NNNWBMK6FYiV-8Pb7CA-1; Wed, 26 Feb 2020 10:53:32 -0500
X-MC-Unique: cm8NNNWBMK6FYiV-8Pb7CA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EAE8107ACC7;
 Wed, 26 Feb 2020 15:53:31 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1197101D482;
 Wed, 26 Feb 2020 15:53:24 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/13] stubs/ram-block: Remove stubs that are no longer
 needed
Date: Wed, 26 Feb 2020 16:52:53 +0100
Message-Id: <20200226155304.60219-3-david@redhat.com>
In-Reply-To: <20200226155304.60219-1-david@redhat.com>
References: <20200226155304.60219-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Current code no longer needs these stubs to compile. Let's just remove
them.

Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 stubs/ram-block.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/stubs/ram-block.c b/stubs/ram-block.c
index 73c0a3ee08..10855b52dd 100644
--- a/stubs/ram-block.c
+++ b/stubs/ram-block.c
@@ -2,21 +2,6 @@
 #include "exec/ramlist.h"
 #include "exec/cpu-common.h"
=20
-void *qemu_ram_get_host_addr(RAMBlock *rb)
-{
-    return 0;
-}
-
-ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
-{
-    return 0;
-}
-
-ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
-{
-    return 0;
-}
-
 void ram_block_notifier_add(RAMBlockNotifier *n)
 {
 }
@@ -24,8 +9,3 @@ void ram_block_notifier_add(RAMBlockNotifier *n)
 void ram_block_notifier_remove(RAMBlockNotifier *n)
 {
 }
-
-int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
-{
-    return 0;
-}
--=20
2.24.1


