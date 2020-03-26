Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105B0C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE63620714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikP4a7x4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE63620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHTXP-0005cx-Tw
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 10:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jHTW7-0003ac-OD
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jHTW6-0002q5-M2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:29:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jHTW6-0002py-In
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585232994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBnmGeaUQCJAeuFYy5ArB2o45KS6HxFcxk0FV9/tfMc=;
 b=ikP4a7x4Qs++y+CPNkh5xLbzz5NZTdQnT29AvQxwv5Nf/dqeck/ZveCCyNxwOKGVtAmqrE
 MqWnx4mSiVsi5HZas8LsHHs8+Q4/cFO2r/oR65bqoXANsnsoIKs05gcm0egmAE+ZzUN59r
 w9msZkPZza1s3nNrFuxKhm8brRKjZvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-p-Z_b7xIP8GTMskZ9YImFQ-1; Thu, 26 Mar 2020 10:29:50 -0400
X-MC-Unique: p-Z_b7xIP8GTMskZ9YImFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDE20800D48;
 Thu, 26 Mar 2020 14:29:48 +0000 (UTC)
Received: from localhost (ovpn-112-132.ams2.redhat.com [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A6BC7E311;
 Thu, 26 Mar 2020 14:29:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/10] qcow2: Comment typo fixes
Date: Thu, 26 Mar 2020 15:29:27 +0100
Message-Id: <20200326142933.625037-5-mreitz@redhat.com>
In-Reply-To: <20200326142933.625037-1-mreitz@redhat.com>
References: <20200326142933.625037-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

Various trivial typos noticed while working on this file.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20200324174233.1622067-2-eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 5f65fce924..b565cf912e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -177,7 +177,7 @@ static ssize_t qcow2_crypto_hdr_write_func(QCryptoBlock=
 *block, size_t offset,
 }
=20
=20
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
=20
-    /* Want a backing file? There you go.*/
+    /* Want a backing file? There you go. */
     if (qcow2_opts->has_backing_file) {
         const char *backing_format =3D NULL;
=20
--=20
2.25.1


