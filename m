Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B256DC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B94F21D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoYehuFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B94F21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43bw-000871-I4
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Xm-00071P-GO
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Xk-0001TL-Cr
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58519
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Xk-0001Sm-8L
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d7S2d+3om2VnkrcCcQqTvf0X+MbL2QGBHNwkfpfEfZc=;
 b=AoYehuFUS9Vnfo5K1D1K+i7M2L0IoruduETM4DGRa/SrFpuzIuMWqHEZSXyJmN+BQalv9G
 19ainzcYzcdIyFN+OzcAhYXUimMnMQhsZ45UMfPiKdfa2T/dy7/vqZVDO72pJ5kNlj5JMS
 nD4m+STlcMCbaaiyy69J05eEhwSGG4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-ZAIsixZMOESwZcgZw20LIA-1; Tue, 18 Feb 2020 09:08:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5F1D107ACC7;
 Tue, 18 Feb 2020 14:08:03 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEA0019E9C;
 Tue, 18 Feb 2020 14:08:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 09/36] qapi: Document meaning of 'ignore' BlockdevOnError for
 jobs
Date: Tue, 18 Feb 2020 15:06:55 +0100
Message-Id: <20200218140722.23876-10-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ZAIsixZMOESwZcgZw20LIA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is not obvious what 'ignore' actually means for block jobs: It could
be continuing the job and returning success in the end despite the error
(no block job does this). It could also mean continuing and returning
failure in the end (this is what stream does). And it can mean retrying
the failed request later (this is what backup, commit and mirror do).

This (somewhat inconsistent) behaviour was introduced and described for
stream and mirror in commit 32c81a4a6ec. backup and commit were
introduced later and use the same model as mirror.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200214200812.28180-2-kwolf@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 13dad62f44..1c32158d11 100644
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


