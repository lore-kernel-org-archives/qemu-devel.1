Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FCBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B3521D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKx8QWEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B3521D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhPY-0003dr-6J
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iufdO-0004No-B6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iufdN-0006FI-7A
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35477
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iufdN-0006Es-3m
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+N2ILZDin8GOdXB65wGNUmmr6lnSmgjBQ5cUgYbEZgU=;
 b=GKx8QWEjv8ppRmrAf3w6Q30GHaCCBkG0feNF/sKPf5/dj6GwGbpKOfc4edt46kvs2OdG8c
 6IwRpDy0rOrB0DqzHN3g94ZnflNX2sixCF6W21DgbFyp3neMKls3P0lvZj6PoTBZbfVZBJ
 cVtl+S6AA8yaPkwZL4rJxtB93jYTeDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-_p8FWUb-PyCQft7OpaA3LQ-1; Thu, 23 Jan 2020 11:47:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89A49106C0A8;
 Thu, 23 Jan 2020 16:47:02 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 149ED5C554;
 Thu, 23 Jan 2020 16:46:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] docs: Fix typo in qemu-nbd -P replacement
Date: Thu, 23 Jan 2020 10:46:49 -0600
Message-Id: <20200123164650.1741798-2-eblake@redhat.com>
In-Reply-To: <20200123164650.1741798-1-eblake@redhat.com>
References: <20200123164650.1741798-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: _p8FWUb-PyCQft7OpaA3LQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 peter.maydell@linaro.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The suggested replacement for the deprecated 'qemu-nbd -P' referw to
'file.backing.opt' instead of 'file.file.opt'; using the example
verbatim results in:

qemu-nbd: Failed to blk_new_open 'driver=3Draw,offset=3D1m,size=3D100m,file=
.driver=3Dqcow2,file.backing.driver=3Dfile,file.backing.filename=3Dfile4': =
A block device must be specified for "file"

Correct this text, prior to actually finishing the deprecation process.

Fixes: 0ae2d54645eb
Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-deprecated.texi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 0968d37c745a..358eb6deebdc 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -335,7 +335,7 @@ top of any other existing blockdev. For example, if par=
tition 1 is

 can be rewritten as:

-@code{qemu-nbd -t --image-opts driver=3Draw,offset=3D1M,size=3D100M,file.d=
river=3Dqcow2,file.backing.driver=3Dfile,file.backing.filename=3Dfile.qcow2=
}
+@code{qemu-nbd -t --image-opts driver=3Draw,offset=3D1M,size=3D100M,file.d=
river=3Dqcow2,file.file.driver=3Dfile,file.file.filename=3Dfile.qcow2}

 Alternatively, the @code{nbdkit} project provides a more powerful
 partition filter on top of its nbd plugin, which can be used to select
--=20
2.24.1


