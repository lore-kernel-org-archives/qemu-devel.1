Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCF5C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8AA222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A99V4+Ur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8AA222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2hHH-0000h3-4l
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j2hGM-0007KE-26
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j2hGL-0005KL-0l
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j2hGK-0005Jl-Ti
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581710912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vnZOS2oQ4H/J3ETSQGIB1Fm2xH6tBJ4x5xQUIco+SIc=;
 b=A99V4+UrHqWo3QBmizycXZpTSLvrY8TxzywSlT6PqlBkwtz7A4bjVZTO+lMo4tfEVhLsRh
 CEiuIDHLWlUM6VaaphHcdo+F0ihdP7v6r+3U/vrdlPrI941/YgzmbWRbbkaWj4ICN3Xiti
 JpsCN0nso4r/Jm0x9jSD12eeiNdqF98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-ogWNrckxOhaHxW_zV6tdzQ-1; Fri, 14 Feb 2020 15:08:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40A8113E2;
 Fri, 14 Feb 2020 20:08:29 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 842E85C1C3;
 Fri, 14 Feb 2020 20:08:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/7] qapi: Document meaning of 'ignore' BlockdevOnError for
 jobs
Date: Fri, 14 Feb 2020 21:08:06 +0100
Message-Id: <20200214200812.28180-2-kwolf@redhat.com>
In-Reply-To: <20200214200812.28180-1-kwolf@redhat.com>
References: <20200214200812.28180-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ogWNrckxOhaHxW_zV6tdzQ-1
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is not obvious what 'ignore' actually means for block jobs: It could
be continuing the job and returning success in the end despite the error
(no block job does this). It could also mean continuing and returning
failure in the end (this is what stream does). And it can mean retrying
the failed request later (this is what backup, commit and mirror do).

This (somewhat inconsistent) behaviour was introduced and described for
stream and mirror in commit ae586d6158. backup and commit were
introduced later and use the same model as mirror.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ef94a29686..395d205fa8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1164,7 +1164,10 @@
 #          for jobs, cancel the job
 #
 # @ignore: ignore the error, only report a QMP event (BLOCK_IO_ERROR
-#          or BLOCK_JOB_ERROR)
+#          or BLOCK_JOB_ERROR). The backup, mirror and commit block jobs r=
etry
+#          the failing request later and may still complete successfully. =
The
+#          stream block job continues to stream and will complete with an
+#          error.
 #
 # @enospc: same as @stop on ENOSPC, same as @report otherwise.
 #
--=20
2.20.1


