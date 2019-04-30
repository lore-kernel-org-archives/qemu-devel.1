Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D8EC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42CEF21734
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CEF21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48890 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLV0y-0004ZC-8T
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 11:49:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuo-0007yu-Re
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUum-00023L-Va
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57091)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUuM-0001el-Ei; Tue, 30 Apr 2019 11:43:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7B98D56F1;
	Tue, 30 Apr 2019 15:43:01 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 03C954C7;
	Tue, 30 Apr 2019 15:42:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:22 +0200
Message-Id: <20190430154244.30083-6-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 30 Apr 2019 15:43:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/27] block/vhdx: Remove redundant IEC binary
 prefixes definition
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
Message-ID: <20190430154222.8qxokVCBhGKTuMjqVnu-kS5CwbQp9_JD9tcWqbXxy1I@z>

From: Stefano Garzarella <sgarzare@redhat.com>

IEC binary prefixes are already defined in "qemu/units.h",
so we can remove redundant definitions in "block/vhdx.h".

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vhdx.h | 6 +-----
 block/vhdx.c | 3 ++-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/vhdx.h b/block/vhdx.h
index 1bfb4e4f73..bf72090c8f 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -17,11 +17,7 @@
=20
 #ifndef BLOCK_VHDX_H
 #define BLOCK_VHDX_H
-
-#define KiB              (1 * 1024)
-#define MiB            (KiB * 1024)
-#define GiB            (MiB * 1024)
-#define TiB ((uint64_t) GiB * 1024)
+#include "qemu/units.h"
=20
 #define DEFAULT_LOG_SIZE 1048576 /* 1MiB */
 /* Structures and fields present in the VHDX file */
diff --git a/block/vhdx.c b/block/vhdx.c
index b785aef4b7..7cd1fc3731 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1889,7 +1889,8 @@ static int coroutine_fn vhdx_co_create(BlockdevCrea=
teOptions *opts,
         return -EINVAL;
     }
     if (block_size > VHDX_BLOCK_SIZE_MAX) {
-        error_setg(errp, "Block size must not exceed %d", VHDX_BLOCK_SIZ=
E_MAX);
+        error_setg(errp, "Block size must not exceed %" PRId64,
+                   VHDX_BLOCK_SIZE_MAX);
         return -EINVAL;
     }
=20
--=20
2.20.1


