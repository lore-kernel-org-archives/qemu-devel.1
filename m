Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CAAC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC02206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC02206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIaoz-0003lK-TR
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 11:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIaKU-0006y9-W2
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIaKT-0004mH-UZ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:26:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIaKR-0004lO-J0; Thu, 10 Oct 2019 11:26:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB94530BCBB4;
 Thu, 10 Oct 2019 15:26:10 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41899194B6;
 Thu, 10 Oct 2019 15:26:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 23/23] iotests: Drop TEST_DIR filter from _filter_nbd
Date: Thu, 10 Oct 2019 17:24:57 +0200
Message-Id: <20191010152457.17713-24-mreitz@redhat.com>
In-Reply-To: <20191010152457.17713-1-mreitz@redhat.com>
References: <20191010152457.17713-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 10 Oct 2019 15:26:10 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sockets should be placed into $SOCK_DIR instead of $TEST_DIR, so remove
the $TEST_DIR filter from _filter_nbd.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.filter | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
index cd42f5e7e3..f870e00e44 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -221,7 +221,6 @@ _filter_nbd()
     # Filter out the TCP port number since this changes between runs.
     $SED -e '/nbd\/.*\.c:/d' \
         -e 's#127\.0\.0\.1:[0-9]*#127.0.0.1:PORT#g' \
-        -e "s#?socket=3D$SOCK_DIR#?socket=3DTEST_DIR#g" \
         -e "s#?socket=3D$SOCK_DIR#?socket=3DSOCK_DIR#g" \
         -e 's#\(foo\|PORT/\?\|.sock\): Failed to .*$#\1#'
 }
--=20
2.21.0


