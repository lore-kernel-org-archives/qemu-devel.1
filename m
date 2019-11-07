Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ABCC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9792085B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E51b5mXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9792085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkxJ-0007MU-1u
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSkmt-00032T-7M
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSkms-0005eZ-4Z
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56254
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSkms-0005eH-11
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573144653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G1Mof4/5yOU7Hg4qqOK6NddTA0wgtwjhznEDPYeXaNY=;
 b=E51b5mXaSVJ7r2myfJcxoCFw36+MSxBBFUk73GZF1XzInpM2hX5lHkqvaOWSUA3ecMMra5
 zdVHuT3+eKYtANWPUc3LzE/pm6qmGuDtvN9HWzajd7Gskcce7ASwEM+bn3doQqneVSXSQU
 /5b1lYbBBq6GY8H8rmj4xxX/22Fo8NM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-KnQTdlNcO42gEq5shOtmsg-1; Thu, 07 Nov 2019 11:37:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4540E1800D6B;
 Thu,  7 Nov 2019 16:37:31 +0000 (UTC)
Received: from localhost (ovpn-117-149.ams2.redhat.com [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF89B600D1;
 Thu,  7 Nov 2019 16:37:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 10/22] iotests: Inject space into -ocompat=0.10 in 051
Date: Thu,  7 Nov 2019 17:36:56 +0100
Message-Id: <20191107163708.833192-11-mreitz@redhat.com>
In-Reply-To: <20191107163708.833192-1-mreitz@redhat.com>
References: <20191107163708.833192-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: KnQTdlNcO42gEq5shOtmsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It did not matter before, but now that _make_test_img understands -o, we
should use it properly here.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/051 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 53bcdbc911..9cd1d60d45 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -157,7 +157,7 @@ echo
 echo =3D=3D=3D With version 2 images enabling lazy refcounts must fail =3D=
=3D=3D
 echo
=20
-_make_test_img -ocompat=3D0.10 $size
+_make_test_img -o compat=3D0.10 $size
=20
 run_qemu -drive file=3D"$TEST_IMG",format=3Dqcow2,lazy-refcounts=3Don
 run_qemu -drive file=3D"$TEST_IMG",format=3Dqcow2,lazy-refcounts=3Doff
--=20
2.23.0


