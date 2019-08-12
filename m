Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CADC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 05:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5612085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 05:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5612085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx2qK-0005Rr-CR
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 01:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57134)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hx2oT-0008WS-Qd
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hx2oS-00066N-Bq
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:24:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hx2oS-00065K-46
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:24:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 721853086E23
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 05:24:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16EF363B89;
 Mon, 12 Aug 2019 05:24:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB2331136425; Mon, 12 Aug 2019 07:23:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 12 Aug 2019 07:23:43 +0200
Message-Id: <20190812052359.30071-14-armbru@redhat.com>
In-Reply-To: <20190812052359.30071-1-armbru@redhat.com>
References: <20190812052359.30071-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 12 Aug 2019 05:24:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 13/29] Clean up inclusion of
 exec/cpu-common.h
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

migration/qemu-file.h neglects to include it even though it needs
ram_addr_t.  Fix that.  Drop a few superfluous inclusions elsewhere.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/hw.h                 | 1 -
 include/hw/ppc/ppc4xx.h         | 1 -
 include/migration/misc.h        | 1 -
 include/sysemu/kvm_int.h        | 1 -
 include/sysemu/memory_mapping.h | 1 -
 migration/migration.h           | 1 -
 migration/qemu-file.h           | 1 +
 accel/stubs/tcg-stub.c          | 1 -
 balloon.c                       | 1 -
 hw/smbios/smbios.c              | 1 -
 migration/qemu-file-channel.c   | 1 -
 migration/vmstate-types.c       | 1 -
 qom/cpu.c                       | 1 -
 tcg/optimize.c                  | 1 -
 tcg/tcg-common.c                | 1 -
 tcg/tcg.c                       | 1 -
 16 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/hw/hw.h b/include/hw/hw.h
index 38d2fb1f40..86ff26b712 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -6,7 +6,6 @@
 #error Cannot include hw/hw.h from user emulation
 #endif
=20
-#include "exec/cpu-common.h"
 #include "qom/object.h"
 #include "exec/memory.h"
 #include "migration/vmstate.h"
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 90f8866138..7d82259051 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -26,7 +26,6 @@
 #define PPC4XX_H
=20
 #include "hw/ppc/ppc.h"
-#include "exec/cpu-common.h"
 #include "exec/memory.h"
=20
 /* PowerPC 4xx core initialization */
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 5cdbabd094..b9d8e787af 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -14,7 +14,6 @@
 #ifndef MIGRATION_MISC_H
 #define MIGRATION_MISC_H
=20
-#include "exec/cpu-common.h"
 #include "qemu/notify.h"
 #include "qapi/qapi-types-net.h"
=20
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 787dbc7770..5d341cc29b 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -9,7 +9,6 @@
 #ifndef QEMU_KVM_INT_H
 #define QEMU_KVM_INT_H
=20
-#include "exec/cpu-common.h"
 #include "exec/memory.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/accel.h"
diff --git a/include/sysemu/memory_mapping.h b/include/sysemu/memory_mapp=
ing.h
index 1b440df486..4b20f1a639 100644
--- a/include/sysemu/memory_mapping.h
+++ b/include/sysemu/memory_mapping.h
@@ -15,7 +15,6 @@
 #define MEMORY_MAPPING_H
=20
 #include "qemu/queue.h"
-#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/memory.h"
=20
diff --git a/migration/migration.h b/migration/migration.h
index 1fdd7b21fd..26f01d00f6 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -16,7 +16,6 @@
=20
 #include "qapi/qapi-types-migration.h"
 #include "qemu/thread.h"
-#include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
 #include "hw/qdev.h"
 #include "io/channel.h"
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 13baf896bd..21f3ae4be2 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -26,6 +26,7 @@
 #define MIGRATION_QEMU_FILE_H
=20
 #include <zlib.h>
+#include "exec/cpu-common.h"
=20
 /* Read a chunk of data from a file at the given position.  The pos argu=
ment
  * can be ignored if the file is only be used for streaming.  The number=
 of
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 76ae461749..e2d23edafe 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -14,7 +14,6 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "tcg/tcg.h"
-#include "exec/cpu-common.h"
 #include "exec/exec-all.h"
=20
 void tb_flush(CPUState *cpu)
diff --git a/balloon.c b/balloon.c
index 914b3662db..f104b42961 100644
--- a/balloon.c
+++ b/balloon.c
@@ -26,7 +26,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/atomic.h"
-#include "exec/cpu-common.h"
 #include "sysemu/kvm.h"
 #include "sysemu/balloon.h"
 #include "trace-root.h"
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 7bcd67b098..11d476c4a2 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -28,7 +28,6 @@
 #include "hw/firmware/smbios.h"
 #include "hw/loader.h"
 #include "hw/boards.h"
-#include "exec/cpu-common.h"
 #include "smbios_build.h"
=20
 /* legacy structures and constants for <=3D 2.0 machines */
diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.=
c
index 8e639eb496..78ef248820 100644
--- a/migration/qemu-file-channel.c
+++ b/migration/qemu-file-channel.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-file-channel.h"
-#include "exec/cpu-common.h"
 #include "qemu-file.h"
 #include "io/channel-socket.h"
 #include "qemu/iov.h"
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 845f4649ee..bee658a1b2 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -11,7 +11,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "exec/cpu-common.h"
 #include "qemu-file.h"
 #include "migration.h"
 #include "migration/vmstate.h"
diff --git a/qom/cpu.c b/qom/cpu.c
index f376f782d8..fdc1af8f40 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -25,7 +25,6 @@
 #include "qemu/notify.h"
 #include "qemu/log.h"
 #include "exec/log.h"
-#include "exec/cpu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "sysemu/sysemu.h"
diff --git a/tcg/optimize.c b/tcg/optimize.c
index d2424de4af..cee2a36a60 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "exec/cpu-common.h"
 #include "tcg-op.h"
=20
 #define CASE_OP_32_64(x)                        \
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index 907d58d0f0..97305a3efc 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "exec/cpu-common.h"
 #include "tcg/tcg.h"
=20
 #if defined(CONFIG_TCG_INTERPRETER)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index be2c33c400..2db83ce2e8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -42,7 +42,6 @@
 #define NO_CPU_IO_DEFS
 #include "cpu.h"
=20
-#include "exec/cpu-common.h"
 #include "exec/exec-all.h"
=20
 #if !defined(CONFIG_USER_ONLY)
--=20
2.21.0


