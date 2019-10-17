Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F11FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6B020640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6B020640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5Ui-0003z6-7c
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5S1-0000aI-D6
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5S0-0008OY-D3
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5Ru-0008Ks-EZ; Thu, 17 Oct 2019 09:04:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B3D9F308429D;
 Thu, 17 Oct 2019 13:04:13 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 342B51001B11;
 Thu, 17 Oct 2019 13:04:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 04/18] stubs: Add blk_by_qdev_id()
Date: Thu, 17 Oct 2019 15:01:50 +0200
Message-Id: <20191017130204.16131-5-kwolf@redhat.com>
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 17 Oct 2019 13:04:13 +0000 (UTC)
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

blockdev.c uses the blk_by_qdev_id() function, so before we can use the
file in tools (i.e. outside of the system emulator), we need to add a
stub for it. The function always returns an error.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 stubs/blk-by-qdev-id.c | 9 +++++++++
 stubs/Makefile.objs    | 1 +
 2 files changed, 10 insertions(+)
 create mode 100644 stubs/blk-by-qdev-id.c

diff --git a/stubs/blk-by-qdev-id.c b/stubs/blk-by-qdev-id.c
new file mode 100644
index 0000000000..0b6160fefa
--- /dev/null
+++ b/stubs/blk-by-qdev-id.c
@@ -0,0 +1,9 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "sysemu/block-backend.h"
+
+BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
+{
+    error_setg(errp, "qdev IDs/QOM paths exist only in the system emulat=
or");
+    return NULL;
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 9f4eb25e02..77fbf72576 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,5 +1,6 @@
 stub-obj-y +=3D arch_type.o
 stub-obj-y +=3D bdrv-next-monitor-owned.o
+stub-obj-y +=3D blk-by-qdev-id.o
 stub-obj-y +=3D blk-commit-all.o
 stub-obj-y +=3D blockdev-close-all-bdrv-states.o
 stub-obj-y +=3D clock-warp.o
--=20
2.20.1


