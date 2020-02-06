Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CF7C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8934217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fk8ErQbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8934217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgqe-0006EF-UN
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izge7-00053T-Pb
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izge6-0004AM-Ld
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39719
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izge6-000483-GH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1xHCl3bAQTKcUDUesP+Yco3K4wfG9fRT60EVRDWWEY=;
 b=fk8ErQblqqMPf4XuVNssrDf/JJT48QF9TKDaIrRuAHOWW11iroqEGo/Z1kzZPnISz8+rtB
 lyZ0frWwbmYnHkeT9uTxWvetXXLjKHJzCCXNY0Uto9421O3mmpGRjXDZxp19FzrBYdu9UJ
 0zLMOn/tooG0K9RJrLGfDQTma5ZFAP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-9I9vMDC_M9-4o2StY9QsgA-1; Thu, 06 Feb 2020 07:52:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B567418CA240
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 12:52:32 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2AFB5DA7C;
 Thu,  6 Feb 2020 12:52:29 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] docs: Fix typo in qemu-nbd -P replacement
Date: Thu,  6 Feb 2020 06:52:23 -0600
Message-Id: <20200206125224.3819972-3-eblake@redhat.com>
In-Reply-To: <20200206125224.3819972-1-eblake@redhat.com>
References: <20200206125224.3819972-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 9I9vMDC_M9-4o2StY9QsgA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The suggested replacement for the deprecated 'qemu-nbd -P' refers to
'file.backing.opt' instead of 'file.file.opt'; using the example
verbatim results in:

qemu-nbd: Failed to blk_new_open 'driver=3Draw,offset=3D1m,size=3D100m,file=
.driver=3Dqcow2,file.backing.driver=3Dfile,file.backing.filename=3Dfile4': =
A block device must be specified for "file"

Correct this text, prior to actually finishing the deprecation process.

Fixes: 0ae2d54645eb
Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200123164650.1741798-2-eblake@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
---
 qemu-deprecated.texi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index ea3e10bde398..c8ee68a4663a 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -329,7 +329,7 @@ top of any other existing blockdev. For example, if par=
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


