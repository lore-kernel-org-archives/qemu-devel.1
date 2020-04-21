Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148E2C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C28206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJPO3eHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C28206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQoia-0003Le-20
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 04:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jQofP-0007Uv-MA
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jQof7-00009Z-LI
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55656
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jQof7-00008L-8Z
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587459228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjRWKBNyfsv6ykwqaQYS3rdIlYVkKXEACYGSeD/NfqE=;
 b=UJPO3eHfgjeYObwg7ZtE8JQ80kVgo3XV2VA3c6YvhpP2IPOVtzeuxpztAKuQmdXLn/vpho
 IszbGH9m9Nk+a3x8dTxm1QCVR7vEusMixk/e16v3P9lnlz6R7uDwt4xtUsiQKYicZ5TMSx
 sF1RxKsm+eGDwAqW7iuv8aHxTwLhq5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-T_WkhvcOPQa0PGQNtIHyHg-1; Tue, 21 Apr 2020 04:53:46 -0400
X-MC-Unique: T_WkhvcOPQa0PGQNtIHyHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E84921922023;
 Tue, 21 Apr 2020 08:53:45 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-245.ams2.redhat.com [10.36.113.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 436211059102;
 Tue, 21 Apr 2020 08:53:41 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/13] stubs/ram-block: Remove stubs that are no longer
 needed
Date: Tue, 21 Apr 2020 10:52:49 +0200
Message-Id: <20200421085300.7734-3-david@redhat.com>
In-Reply-To: <20200421085300.7734-1-david@redhat.com>
References: <20200421085300.7734-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
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
2.25.1


