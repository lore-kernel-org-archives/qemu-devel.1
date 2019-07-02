Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781F3C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505E3208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505E3208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGNe-0008Lo-FI
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50903)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiGJm-0005nT-Fv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiGJk-0007ea-JA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiGJk-0007bp-Ac
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82F08309265A
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 10:47:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29AC437D6;
 Tue,  2 Jul 2019 10:47:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AFFF611329C7; Tue,  2 Jul 2019 12:47:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 12:47:02 +0200
Message-Id: <20190702104716.9140-5-armbru@redhat.com>
In-Reply-To: <20190702104716.9140-1-armbru@redhat.com>
References: <20190702104716.9140-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 02 Jul 2019 10:47:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/18] hmp: Move hmp.h to include/monitor/
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190619201050.19040-4-armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.h =3D> include/monitor/hmp.h | 0
 monitor/hmp-cmds.c             | 2 +-
 monitor/misc.c                 | 2 +-
 target/i386/monitor.c          | 2 +-
 target/nios2/monitor.c         | 2 +-
 target/ppc/monitor.c           | 2 +-
 target/sh4/monitor.c           | 2 +-
 target/sparc/monitor.c         | 2 +-
 target/xtensa/monitor.c        | 2 +-
 9 files changed, 8 insertions(+), 8 deletions(-)
 rename hmp.h =3D> include/monitor/hmp.h (100%)

diff --git a/hmp.h b/include/monitor/hmp.h
similarity index 100%
rename from hmp.h
rename to include/monitor/hmp.h
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index c283dde0e9..5082fcd016 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -14,7 +14,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hmp.h"
+#include "monitor/hmp.h"
 #include "net/net.h"
 #include "net/eth.h"
 #include "chardev/char.h"
diff --git a/monitor/misc.c b/monitor/misc.c
index bf9faceb86..2fb6896e84 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -56,13 +56,13 @@
 #include "qom/object_interfaces.h"
 #include "trace/control.h"
 #include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
 #ifdef CONFIG_TRACE_SIMPLE
 #include "trace/simple.h"
 #endif
 #include "exec/memory.h"
 #include "exec/exec-all.h"
 #include "qemu/option.h"
-#include "hmp.h"
 #include "qemu/thread.h"
 #include "block/qapi.h"
 #include "qapi/qapi-commands.h"
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 56e2dbece7..1f3b532fc2 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -26,11 +26,11 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
 #include "qapi/qmp/qdict.h"
 #include "hw/i386/pc.h"
 #include "sysemu/kvm.h"
 #include "sysemu/sev.h"
-#include "hmp.h"
 #include "qapi/error.h"
 #include "sev_i386.h"
 #include "qapi/qapi-commands-misc.h"
diff --git a/target/nios2/monitor.c b/target/nios2/monitor.c
index d5e3393716..6646836df5 100644
--- a/target/nios2/monitor.c
+++ b/target/nios2/monitor.c
@@ -25,7 +25,7 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
-#include "hmp.h"
+#include "monitor/hmp.h"
=20
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 7f8360d903..a5a177d717 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -27,7 +27,7 @@
 #include "monitor/monitor.h"
 #include "qemu/ctype.h"
 #include "monitor/hmp-target.h"
-#include "hmp.h"
+#include "monitor/hmp.h"
=20
 static target_long monitor_get_ccr(const struct MonitorDef *md, int val)
 {
diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
index 4c7f36c9cc..918a5ccfc6 100644
--- a/target/sh4/monitor.c
+++ b/target/sh4/monitor.c
@@ -25,7 +25,7 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
-#include "hmp.h"
+#include "monitor/hmp.h"
=20
 static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
 {
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 3ec3b51a3d..a7ea287cbc 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -25,7 +25,7 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
-#include "hmp.h"
+#include "monitor/hmp.h"
=20
=20
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index cf7957bb63..608173c238 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -25,7 +25,7 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
-#include "hmp.h"
+#include "monitor/hmp.h"
=20
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
--=20
2.21.0


