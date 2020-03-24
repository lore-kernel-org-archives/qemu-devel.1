Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B989EC41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B532206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1nw7wgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B532206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnc7-0007pe-K5
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jGnZZ-0004Zy-6t
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jGnZY-0007Tr-83
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:42:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jGnZY-0007Ta-4Y
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585071759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pUcEpHT8Uzfw8y4D8iDNs1gTxjJECUDULaSvlQH1DRI=;
 b=f1nw7wgrwisarRP1mts41fOnZ5oueaDywpVooPY/DBnZaeSHDdTORIMzvmV/Ykt6DDkhOV
 /S+kkTNBX43+gDjDNxL/qnT8rglPazNI1RATsQ73B1VjxjXRhV8PwJVE8eASfH9y+dMCey
 Yqnn3hORUY6dhPwNn6gQLVbqMBwDris=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-awxce53kPHWYXXm3CcT-Ng-1; Tue, 24 Mar 2020 13:42:38 -0400
X-MC-Unique: awxce53kPHWYXXm3CcT-Ng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C02B107ACC4;
 Tue, 24 Mar 2020 17:42:37 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 696FC1001B0B;
 Tue, 24 Mar 2020 17:42:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] qcow2: Comment typo fixes
Date: Tue, 24 Mar 2020 12:42:30 -0500
Message-Id: <20200324174233.1622067-2-eblake@redhat.com>
In-Reply-To: <20200324174233.1622067-1-eblake@redhat.com>
References: <20200324174233.1622067-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Various trivial typos noticed while working on this file.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index d1da3d91db21..5a7f30e692a2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -177,7 +177,7 @@ static ssize_t qcow2_crypto_hdr_write_func(QCryptoBlock=
 *block, size_t offset,
 }


-/*=20
+/*
  * read qcow2 extension and fill bs
  * start reading from start_offset
  * finish reading upon magic of value 0 or when end_offset reached
@@ -3255,7 +3255,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options=
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
@@ -3500,7 +3500,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options=
, Error **errp)
         goto out;
     }

-    /* Want a backing file? There you go.*/
+    /* Want a backing file? There you go. */
     if (qcow2_opts->has_backing_file) {
         const char *backing_format =3D NULL;

--=20
2.26.0.rc2


