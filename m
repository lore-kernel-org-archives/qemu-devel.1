Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC86C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:25:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFCE20882
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFCE20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46251 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8Ko-0004XK-QM
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:25:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP8Ca-0004Og-EI
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP8CY-0000DE-13
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:16:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hP8CT-0008QB-7y; Fri, 10 May 2019 12:16:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F8F63082A4C;
	Fri, 10 May 2019 16:16:44 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-183.ams2.redhat.com
	[10.36.116.183])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 257CA17791;
	Fri, 10 May 2019 16:16:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 10 May 2019 18:16:06 +0200
Message-Id: <20190510161614.23236-8-kwolf@redhat.com>
In-Reply-To: <20190510161614.23236-1-kwolf@redhat.com>
References: <20190510161614.23236-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 10 May 2019 16:16:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 07/15] qemu-img: Use IEC binary prefixes for
 size constants
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

Using IEC binary prefixes in order to make the code more readable.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e6ad5978e0..71c92f142a 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -37,6 +37,7 @@
 #include "qemu/option.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/units.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
@@ -1216,7 +1217,7 @@ static int compare_buffers(const uint8_t *buf1, con=
st uint8_t *buf2,
     return res;
 }
=20
-#define IO_BUF_SIZE (2 * 1024 * 1024)
+#define IO_BUF_SIZE (2 * MiB)
=20
 /*
  * Check if passed sectors are empty (not allocated or contain only 0 by=
tes)
@@ -2960,7 +2961,7 @@ static int img_map(int argc, char **argv)
         int64_t n;
=20
         /* Probe up to 1 GiB at a time.  */
-        n =3D MIN(1 << 30, length - offset);
+        n =3D MIN(1 * GiB, length - offset);
         ret =3D get_block_status(bs, offset, n, &next);
=20
         if (ret < 0) {
--=20
2.20.1


