Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31557ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03AFD20640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AFD20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5U1-0002lz-NK
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5S3-0000d2-Mf
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5Ry-0008NU-JQ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5Rs-0008JC-Kz; Thu, 17 Oct 2019 09:04:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE74D10F2E84;
 Thu, 17 Oct 2019 13:04:11 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DA421001B11;
 Thu, 17 Oct 2019 13:04:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 03/18] stubs: Add arch_type
Date: Thu, 17 Oct 2019 15:01:49 +0200
Message-Id: <20191017130204.16131-4-kwolf@redhat.com>
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 17 Oct 2019 13:04:11 +0000 (UTC)
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

blockdev.c uses the arch_type constant, so before we can use the file in
tools (i.e. outside of the system emulator), we need to add a stub for
it. A new QEMU_ARCH_NONE is introduced for this case.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/sysemu/arch_init.h | 2 ++
 stubs/arch_type.c          | 4 ++++
 stubs/Makefile.objs        | 1 +
 3 files changed, 7 insertions(+)
 create mode 100644 stubs/arch_type.c

diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 62c6fe4cf1..01392dc945 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -24,6 +24,8 @@ enum {
     QEMU_ARCH_NIOS2 =3D (1 << 17),
     QEMU_ARCH_HPPA =3D (1 << 18),
     QEMU_ARCH_RISCV =3D (1 << 19),
+
+    QEMU_ARCH_NONE =3D (1 << 31),
 };
=20
 extern const uint32_t arch_type;
diff --git a/stubs/arch_type.c b/stubs/arch_type.c
new file mode 100644
index 0000000000..fc5423bc98
--- /dev/null
+++ b/stubs/arch_type.c
@@ -0,0 +1,4 @@
+#include "qemu/osdep.h"
+#include "sysemu/arch_init.h"
+
+const uint32_t arch_type =3D QEMU_ARCH_NONE;
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 4a50e95ec3..9f4eb25e02 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,3 +1,4 @@
+stub-obj-y +=3D arch_type.o
 stub-obj-y +=3D bdrv-next-monitor-owned.o
 stub-obj-y +=3D blk-commit-all.o
 stub-obj-y +=3D blockdev-close-all-bdrv-states.o
--=20
2.20.1


