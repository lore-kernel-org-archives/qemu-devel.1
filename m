Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41737C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1F2206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UActzBrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1F2206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix94x-0002Y7-6n
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 07:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ix92O-0005bG-QA
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ix92N-0004Zq-EF
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55183
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ix92N-0004Rx-9i
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580387705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mDDYN1526RpxoYeW85lvREBRRxEe2IGN9z2m/v1Qfbk=;
 b=UActzBrPCox55rYSTpS4abVPy+3RqRC2JsuQeQw0EE5+wlYDikgwwQ2QAbyqaMX73NdCUs
 4u6GqAVMNkx1CK2ixXC12Z7Aou104sh8iDl8G3THzdYkVXiMNKCWYKV8K7w1lJDZEOgXUK
 y6o+iB6rtIaT4MUnX3cyiVhjQugDRNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-romJZpZMOJyvZRLSqcNIZw-1; Thu, 30 Jan 2020 07:35:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12148107ACC4;
 Thu, 30 Jan 2020 12:35:02 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06D2E19756;
 Thu, 30 Jan 2020 12:34:59 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/11] monitor/hmp: rename device-hotplug.c to
 block/monitor/block-hmp-cmds.c
Date: Thu, 30 Jan 2020 14:34:40 +0200
Message-Id: <20200130123448.21093-4-mlevitsk@redhat.com>
In-Reply-To: <20200130123448.21093-1-mlevitsk@redhat.com>
References: <20200130123448.21093-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: romJZpZMOJyvZRLSqcNIZw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These days device-hotplug.c only contains the hmp_drive_add
In the next patch, rest of hmp_drive* functions will be moved
there.

Also add block-hmp-cmds.h to contain prototypes of these
functions

License for block-hmp-cmds.h since it contains the code
moved from sysemu.h which lacks license and thus according
to LICENSE is under GPLv2+


Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS                                      |  1 +
 Makefile.objs                                    |  2 +-
 block/Makefile.objs                              |  1 +
 block/monitor/Makefile.objs                      |  1 +
 .../monitor/block-hmp-cmds.c                     |  3 ++-
 include/block/block-hmp-cmds.h                   | 16 ++++++++++++++++
 include/sysemu/sysemu.h                          |  3 ---
 monitor/misc.c                                   |  1 +
 8 files changed, 23 insertions(+), 5 deletions(-)
 create mode 100644 block/monitor/Makefile.objs
 rename device-hotplug.c =3D> block/monitor/block-hmp-cmds.c (97%)
 create mode 100644 include/block/block-hmp-cmds.h

diff --git a/MAINTAINERS b/MAINTAINERS
index efd3f3875f..068051d053 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1884,6 +1884,7 @@ Block QAPI, monitor, command line
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: blockdev.c
+F: blockdev-hmp-cmds.c
 F: block/qapi.c
 F: qapi/block*.json
 F: qapi/transaction.json
diff --git a/Makefile.objs b/Makefile.objs
index f2da7241fc..dc3fd58b24 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -39,7 +39,7 @@ common-obj-y +=3D dump/
 common-obj-y +=3D job-qmp.o
 common-obj-y +=3D monitor/
 common-obj-y +=3D net/
-common-obj-y +=3D qdev-monitor.o device-hotplug.o
+common-obj-y +=3D qdev-monitor.o
 common-obj-$(CONFIG_WIN32) +=3D os-win32.o
 common-obj-$(CONFIG_POSIX) +=3D os-posix.o
=20
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 330529b0b7..3f65544a6b 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -44,6 +44,7 @@ block-obj-y +=3D crypto.o
 block-obj-y +=3D aio_task.o
 block-obj-y +=3D backup-top.o
 block-obj-y +=3D filter-compress.o
+common-obj-y +=3D monitor/
=20
 common-obj-y +=3D stream.o
=20
diff --git a/block/monitor/Makefile.objs b/block/monitor/Makefile.objs
new file mode 100644
index 0000000000..0a74f9a8b5
--- /dev/null
+++ b/block/monitor/Makefile.objs
@@ -0,0 +1 @@
+common-obj-y +=3D block-hmp-cmds.o
diff --git a/device-hotplug.c b/block/monitor/block-hmp-cmds.c
similarity index 97%
rename from device-hotplug.c
rename to block/monitor/block-hmp-cmds.c
index 554e4d98db..bcf35b4b44 100644
--- a/device-hotplug.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -1,5 +1,5 @@
 /*
- * QEMU device hotplug helpers
+ * Blockdev HMP commands
  *
  * Copyright (c) 2004 Fabrice Bellard
  *
@@ -33,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "block/block_int.h"
+#include "block/block-hmp-cmds.h"
=20
=20
 void hmp_drive_add(Monitor *mon, const QDict *qdict)
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.=
h
new file mode 100644
index 0000000000..0db8a889a1
--- /dev/null
+++ b/include/block/block-hmp-cmds.h
@@ -0,0 +1,16 @@
+/*
+ * HMP commands related to the block layer
+ *
+ * Copyright (c) 2020 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * or (at your option) any later version.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef BLOCK_HMP_COMMANDS_H
+#define BLOCK_HMP_COMMANDS_H
+
+void hmp_drive_add(Monitor *mon, const QDict *qdict);
+
+#endif
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 80c57fdc4e..c48635666d 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -68,9 +68,6 @@ extern int nb_option_roms;
 extern const char *prom_envs[MAX_PROM_ENVS];
 extern unsigned int nb_prom_envs;
=20
-/* generic hotplug */
-void hmp_drive_add(Monitor *mon, const QDict *qdict);
-
 /* pcie aer error injection */
 void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
=20
diff --git a/monitor/misc.c b/monitor/misc.c
index 4752150a67..b8f3cce19e 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -66,6 +66,7 @@
 #include "qemu/option.h"
 #include "qemu/thread.h"
 #include "block/qapi.h"
+#include "block/block-hmp-cmds.h"
 #include "qapi/qapi-commands-char.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-commands-misc.h"
--=20
2.17.2


