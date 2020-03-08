Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECF9C10F28
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 09:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A7F206D7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 09:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnpOjKGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A7F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAsDJ-0006iP-23
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 05:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jAsB9-0002gr-Dr
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jAsB8-0008RT-54
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:24:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32887
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jAsB8-0008RD-1x
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583659497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRtG3JhmvyvgF+sHtipO5m+XE6oaJdutYEaSju2JbUk=;
 b=HnpOjKGUNbfy9OchrLQFAZSb3Ce6e8uBAxwcDEmYC97qF14mD/ChL1YV1ho3QoaI3gPpE7
 vedx2E0aeXK+qzVlNXa+OvFPHgGN6+2KmAa8r5gNw2W0apjYw/nVwmp/DmhO3BhWixXjvl
 f40l55WTllBBi0FMF3neNpSZXJMFdxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-Hg4-Qw0xPOq-e9AMt5Cs_Q-1; Sun, 08 Mar 2020 05:24:56 -0400
X-MC-Unique: Hg4-Qw0xPOq-e9AMt5Cs_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0C05107ACCA;
 Sun,  8 Mar 2020 09:24:54 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B28C6100E805;
 Sun,  8 Mar 2020 09:24:52 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/11] monitor/hmp: rename device-hotplug.c to
 block/monitor/block-hmp-cmds.c
Date: Sun,  8 Mar 2020 11:24:32 +0200
Message-Id: <20200308092440.23564-4-mlevitsk@redhat.com>
In-Reply-To: <20200308092440.23564-1-mlevitsk@redhat.com>
References: <20200308092440.23564-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
index 36d0c6887a..d881ba7d9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1920,6 +1920,7 @@ Block QAPI, monitor, command line
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: blockdev.c
+F: blockdev-hmp-cmds.c
 F: block/qapi.c
 F: qapi/block*.json
 F: qapi/transaction.json
diff --git a/Makefile.objs b/Makefile.objs
index e288663d89..40d3a1696c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -48,7 +48,7 @@ common-obj-y +=3D dump/
 common-obj-y +=3D job-qmp.o
 common-obj-y +=3D monitor/
 common-obj-y +=3D net/
-common-obj-y +=3D qdev-monitor.o device-hotplug.o
+common-obj-y +=3D qdev-monitor.o
 common-obj-$(CONFIG_WIN32) +=3D os-win32.o
 common-obj-$(CONFIG_POSIX) +=3D os-posix.o
=20
diff --git a/block/Makefile.objs b/block/Makefile.objs
index cb36ae2503..3635b6b4c1 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -45,6 +45,7 @@ block-obj-y +=3D crypto.o
 block-obj-y +=3D aio_task.o
 block-obj-y +=3D backup-top.o
 block-obj-y +=3D filter-compress.o
+common-obj-y +=3D monitor/
=20
 block-obj-y +=3D stream.o
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
index 479d90bcea..ef81302e1a 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -63,9 +63,6 @@ extern int nb_option_roms;
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
index 1748ab3911..c3bc34c099 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -66,6 +66,7 @@
 #include "qemu/option.h"
 #include "qemu/thread.h"
 #include "block/qapi.h"
+#include "block/block-hmp-cmds.h"
 #include "qapi/qapi-commands-char.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-migration.h"
--=20
2.17.2


