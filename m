Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3F9C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB99D20659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB99D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGTu-0007Hm-8Q
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50995)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiGJu-0005p7-CX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiGJp-0007nt-Rm
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiGJo-0007gA-09
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4EB2D30C1323
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 10:47:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBFD517253;
 Tue,  2 Jul 2019 10:47:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9091111BD5C; Tue,  2 Jul 2019 12:47:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 12:47:12 +0200
Message-Id: <20190702104716.9140-15-armbru@redhat.com>
In-Reply-To: <20190702104716.9140-1-armbru@redhat.com>
References: <20190702104716.9140-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 02 Jul 2019 10:47:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/18] qapi: Rename target.json to
 misc-target.json
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190619201050.19040-14-armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/ppc/spapr_rtc.c                     | 2 +-
 hw/s390x/s390-skeys.c                  | 2 +-
 hw/timer/mc146818rtc.c                 | 4 ++--
 qapi/Makefile.objs                     | 2 +-
 qapi/{target.json =3D> misc-target.json} | 4 ----
 qapi/qapi-schema.json                  | 2 +-
 target/arm/monitor.c                   | 2 +-
 target/i386/sev_i386.h                 | 2 +-
 8 files changed, 8 insertions(+), 12 deletions(-)
 rename qapi/{target.json =3D> misc-target.json} (99%)

diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index af1ef30a53..6cf0113b34 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -32,7 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/ppc/spapr.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-target.h"
+#include "qapi/qapi-events-misc-target.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
=20
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index daac936698..e5bd92c0c7 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -14,7 +14,7 @@
 #include "hw/boards.h"
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-target.h"
+#include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 0d79e000d2..ce4550b6f2 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -33,8 +33,8 @@
 #include "sysemu/replay.h"
 #include "hw/timer/mc146818rtc.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-target.h"
-#include "qapi/qapi-events-target.h"
+#include "qapi/qapi-commands-misc-target.h"
+#include "qapi/qapi-events-misc-target.h"
 #include "qapi/visitor.h"
 #include "exec/address-spaces.h"
=20
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 4e87bef6e1..c0be6fcd3e 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -9,7 +9,7 @@ QAPI_COMMON_MODULES =3D audio authz block-core block char=
 common crypto
 QAPI_COMMON_MODULES +=3D introspect job machine migration misc net
 QAPI_COMMON_MODULES +=3D qdev qom rdma rocker run-state sockets tpm
 QAPI_COMMON_MODULES +=3D trace transaction ui
-QAPI_TARGET_MODULES =3D machine-target target
+QAPI_TARGET_MODULES =3D machine-target misc-target
 QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
=20
 util-obj-y +=3D qapi-builtin-types.o
diff --git a/qapi/target.json b/qapi/misc-target.json
similarity index 99%
rename from qapi/target.json
rename to qapi/misc-target.json
index e0a73581d8..a00fd821eb 100644
--- a/qapi/target.json
+++ b/qapi/misc-target.json
@@ -1,10 +1,6 @@
 # -*- Mode: Python -*-
 #
=20
-##
-# =3D Target-specific commands & events
-##
-
 ##
 # @RTC_CHANGE:
 #
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 8dc82fde31..bcfac85074 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -102,5 +102,5 @@
 { 'include': 'machine.json' }
 { 'include': 'machine-target.json' }
 { 'include': 'misc.json' }
-{ 'include': 'target.json' }
+{ 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 41b32b94b2..6ec6dd04ac 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/boards.h"
 #include "kvm_arm.h"
-#include "qapi/qapi-commands-target.h"
+#include "qapi/qapi-commands-misc-target.h"
=20
 static GICCapability *gic_cap_new(int version)
 {
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index c0f9373beb..55313441ae 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -19,7 +19,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sev.h"
 #include "qemu/error-report.h"
-#include "qapi/qapi-commands-target.h"
+#include "qapi/qapi-commands-misc-target.h"
=20
 #define SEV_POLICY_NODBG        0x1
 #define SEV_POLICY_NOKS         0x2
--=20
2.21.0


