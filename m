Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660C1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F309214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuFp133s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F309214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaMz-0004U2-7S
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaLW-0002c4-Dg
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaLV-0004IY-H3
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28292
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaLV-0004IC-E3
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYMN4/fJJtaeioiL4a/PkGI8sWoRPSVQYwn4SQ5i6MU=;
 b=RuFp133sicr6oJTjNf0syXSxWpryMOuspJych9mKSy6pDKZ+jy0sLt7eW58nzHcmwESnjX
 5FrbsWKR02Jo4OQDDK/qdwrcwFgnxTO5fqIb0kmoQiZS5rsnTxEpfY6USqwEQjcxg5pKeE
 i0AtQbhFaAjwCyGFZieGkGEqmLZQmT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-Vd7cCsdFMfOmNuSr9ew7AQ-1; Fri, 31 Jan 2020 12:44:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8F87800D48;
 Fri, 31 Jan 2020 17:44:39 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51D28811E3;
 Fri, 31 Jan 2020 17:44:39 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/17] qcow2: Comment typo fixes
Date: Fri, 31 Jan 2020 11:44:20 -0600
Message-Id: <20200131174436.2961874-2-eblake@redhat.com>
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Vd7cCsdFMfOmNuSr9ew7AQ-1
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Various trivial typos noticed while working on this file.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index cef9d72b3a16..30fd3d13032a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -174,7 +174,7 @@ static ssize_t qcow2_crypto_hdr_write_func(QCryptoBlock=
 *block, size_t offset,
 }


-/*=20
+/*
  * read qcow2 extension and fill bs
  * start reading from start_offset
  * finish reading upon magic of value 0 or when end_offset reached
@@ -3251,7 +3251,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options=
, Error **errp)
      * inconsistency later.
      *
      * We do need a refcount table because growing the refcount table mean=
s
-     * allocating two new refcount blocks - the seconds of which would be =
at
+     * allocating two new refcount blocks - the second of which would be a=
t
      * 2 GB for 64k clusters, and we don't want to have a 2 GB initial fil=
e
      * size for any qcow2 image.
      */
@@ -3495,7 +3495,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options=
, Error **errp)
         goto out;
     }

-    /* Want a backing file? There you go.*/
+    /* Want a backing file? There you go. */
     if (qcow2_opts->has_backing_file) {
         const char *backing_format =3D NULL;

--=20
2.24.1


