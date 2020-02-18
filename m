Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8B4C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA35A2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBALEtia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA35A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42Ic-0004yz-2T
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42Ej-00074q-9y
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42Ei-0001qF-8O
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:44:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42Ei-0001q8-5L
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9ohRgucKFrjUPBiXOO6Cr0R65d/o4m/1ZQYnPhrDPE=;
 b=UBALEtiakU0AtIq7pmJlTvzj0pfYGJoTt9EAKVpInYpIsWQfXv6DVB9LNM/UdIzAnK01Wb
 f4opUu4QWSrpS7+/SGt0NMYviG+Vn3RTA5g5NO+atqJCwMlvJmbqVymAjF3r5EeQbmm+TC
 inrwD+x2PMCZ9HnSSiT7phzYTtGxQ7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-7dUJEBnXPjGKDczP40iNFw-1; Tue, 18 Feb 2020 07:44:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11B998014CA;
 Tue, 18 Feb 2020 12:44:19 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82BCD100194E;
 Tue, 18 Feb 2020 12:44:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 29/33] block: Make bdrv_filter_default_perms() static
Date: Tue, 18 Feb 2020 13:42:38 +0100
Message-Id: <20200218124242.584644-30-mreitz@redhat.com>
In-Reply-To: <20200218124242.584644-1-mreitz@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 7dUJEBnXPjGKDczP40iNFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c                   | 17 +++++++++++------
 include/block/block_int.h | 10 ----------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/block.c b/block.c
index d3beed1819..a7c2ad6c5b 100644
--- a/block.c
+++ b/block.c
@@ -2216,12 +2216,17 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, =
BdrvChild *c, Error **errp)
     return bdrv_child_try_set_perm(c, perms, shared, errp);
 }
=20
-void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildClass *child_class,
-                               BdrvChildRole role,
-                               BlockReopenQueue *reopen_queue,
-                               uint64_t perm, uint64_t shared,
-                               uint64_t *nperm, uint64_t *nshared)
+/*
+ * Default implementation for .bdrv_child_perm() for block filters:
+ * Forward CONSISTENT_READ, WRITE, WRITE_UNCHANGED, and RESIZE to the
+ * filtered child.
+ */
+static void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
+                                      const BdrvChildClass *child_class,
+                                      BdrvChildRole role,
+                                      BlockReopenQueue *reopen_queue,
+                                      uint64_t perm, uint64_t shared,
+                                      uint64_t *nperm, uint64_t *nshared)
 {
     *nperm =3D perm & DEFAULT_PERM_PASSTHROUGH;
     *nshared =3D (shared & DEFAULT_PERM_PASSTHROUGH) | DEFAULT_PERM_UNCHAN=
GED;
diff --git a/include/block/block_int.h b/include/block/block_int.h
index ab64a5ccea..c2fb6b8899 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1253,16 +1253,6 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t p=
erm, uint64_t shared,
  */
 int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **e=
rrp);
=20
-/* Default implementation for BlockDriver.bdrv_child_perm() that can be us=
ed by
- * block filters: Forward CONSISTENT_READ, WRITE, WRITE_UNCHANGED and RESI=
ZE to
- * all children */
-void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildClass *child_class,
-                               BdrvChildRole child_role,
-                               BlockReopenQueue *reopen_queue,
-                               uint64_t perm, uint64_t shared,
-                               uint64_t *nperm, uint64_t *nshared);
-
 /* Default implementation for BlockDriver.bdrv_child_perm() that can be us=
ed by
  * (non-raw) image formats: Like above for bs->backing, but for bs->file i=
t
  * requires WRITE | RESIZE for read-write images, always requires
--=20
2.24.1


