Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F0EC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0F92075A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REaIfO7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0F92075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioTx9-0001AA-RP
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioTay-0006Lu-PS
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioTax-0000Gp-OY
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45932
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioTax-0000Gj-Kt
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9OkpeVzkzlcztCw+WGFva69O4o2CJxWuJHyMhqELkI=;
 b=REaIfO7dVWn0Amv5D2gj/eBbjaIqUKL7/9/cs2GQA+Rr9afVYUWox76Ykt/Tptjrxb0C7a
 sO4jw++VcwlPB2S4qqAuInnFNcKM59ePHVyYM0r35O4Kh1KcdvsjwvHJMIXVUp3hB49KiI
 3sC/Mrv8z9SGAu7Uqq90l1DP06UVpgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-EMJqrB09PVi_e1kGkNkdsA-1; Mon, 06 Jan 2020 09:43:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C40258E3BDD;
 Mon,  6 Jan 2020 14:42:58 +0000 (UTC)
Received: from localhost (ovpn-117-91.ams2.redhat.com [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4022950A8F;
 Mon,  6 Jan 2020 14:42:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 14/34] iotests: Drop compat=1.1 in 050
Date: Mon,  6 Jan 2020 15:41:46 +0100
Message-Id: <20200106144206.698920-15-mreitz@redhat.com>
In-Reply-To: <20200106144206.698920-1-mreitz@redhat.com>
References: <20200106144206.698920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: EMJqrB09PVi_e1kGkNkdsA-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

IMGOPTS can never be empty for qcow2, because the check scripts adds
compat=3D1.1 unless the user specified any compat option themselves.
Thus, this block does not do anything and can be dropped.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-id: 20191107163708.833192-8-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/050 | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index 211fc00797..272ecab195 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -41,10 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2 qed
 _supported_proto file
=20
-if test "$IMGFMT" =3D qcow2 && test $IMGOPTS =3D ""; then
-  IMGOPTS=3Dcompat=3D1.1
-fi
-
 echo
 echo "=3D=3D Creating images =3D=3D"
=20
--=20
2.24.1


