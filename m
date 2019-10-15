Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435F4C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180F92064A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180F92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKNqs-0000i8-Qv
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iKNnm-0006eu-FG
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iKNnl-0008Pf-Eq
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:27:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30987)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iKNnh-0008N1-0s; Tue, 15 Oct 2019 10:27:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 45A9312A2;
 Tue, 15 Oct 2019 14:27:48 +0000 (UTC)
Received: from localhost (ovpn-117-226.ams2.redhat.com [10.36.117.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAA545DA8D;
 Tue, 15 Oct 2019 14:27:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 06/21] iotests: Drop compat=1.1 in 050
Date: Tue, 15 Oct 2019 16:27:14 +0200
Message-Id: <20191015142729.18123-7-mreitz@redhat.com>
In-Reply-To: <20191015142729.18123-1-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 15 Oct 2019 14:27:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

IMGOPTS can never be empty for qcow2, because the check scripts adds
compat=3D1.1 unless the user specified any compat option themselves.
Thus, this block does not do anything and can be dropped.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
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
2.21.0


