Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A705C73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 15:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E2421537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 15:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E2421537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkrxW-0003EM-Nd
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 11:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43275)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hkrvT-0001Rv-4e
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hkrvR-0006xU-7H
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:21:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hkrvP-0006va-3C
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:21:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3927CC02938A;
 Tue,  9 Jul 2019 15:20:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5F957E481;
 Tue,  9 Jul 2019 15:20:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 692BC1138661; Tue,  9 Jul 2019 17:20:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 17:20:53 +0200
Message-Id: <20190709152053.16670-3-armbru@redhat.com>
In-Reply-To: <20190709152053.16670-1-armbru@redhat.com>
References: <20190709152053.16670-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 09 Jul 2019 15:20:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] qapi: Move query-target from misc.json to
 machine.json
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move query-target and its return type TargetInfo from misc.json to
machine.json, where they are covered by MAINTAINERS section "Machine
core".  Also move its implementation from arch_init.c to
hw/core/machine-qmp-cmds, where it is likewise covered.

All users of SysEmuTarget are now in machine.json.  Move it there from
common.json.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 arch_init.c                | 11 ---------
 docs/interop/firmware.json |  2 +-
 hw/core/machine-qmp-cmds.c | 10 ++++++++
 qapi/common.json           | 25 --------------------
 qapi/machine.json          | 48 +++++++++++++++++++++++++++++++++++++-
 qapi/misc.json             | 23 ------------------
 6 files changed, 58 insertions(+), 61 deletions(-)

diff --git a/arch_init.c b/arch_init.c
index 74b0708634..0a1531124c 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -106,14 +106,3 @@ int xen_available(void)
     return 0;
 #endif
 }
-
-
-TargetInfo *qmp_query_target(Error **errp)
-{
-    TargetInfo *info =3D g_malloc0(sizeof(*info));
-
-    info->arch =3D qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME, -1=
,
-                                 &error_abort);
-
-    return info;
-}
diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index ff8c2ce5f2..8ffb7856d2 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -13,7 +13,7 @@
 # =3D Firmware
 ##
=20
-{ 'include' : 'common.json' }
+{ 'include' : 'machine.json' }
 { 'include' : 'block-core.json' }
=20
 ##
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 5bd95b8ab0..ac2dd8b56e 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -247,6 +247,16 @@ CurrentMachineParams *qmp_query_current_machine(Erro=
r **errp)
     return params;
 }
=20
+TargetInfo *qmp_query_target(Error **errp)
+{
+    TargetInfo *info =3D g_malloc0(sizeof(*info));
+
+    info->arch =3D qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME, -1=
,
+                                 &error_abort);
+
+    return info;
+}
+
 HotpluggableCPUList *qmp_query_hotpluggable_cpus(Error **errp)
 {
     MachineState *ms =3D MACHINE(qdev_get_machine());
diff --git a/qapi/common.json b/qapi/common.json
index 99d313ef3b..3083e7005b 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -168,28 +168,3 @@
 ##
 { 'enum': 'PCIELinkWidth',
   'data': [ '1', '2', '4', '8', '12', '16', '32' ] }
-
-##
-# @SysEmuTarget:
-#
-# The comprehensive enumeration of QEMU system emulation ("softmmu")
-# targets. Run "./configure --help" in the project root directory, and
-# look for the *-softmmu targets near the "--target-list" option. The
-# individual target constants are not documented here, for the time
-# being.
-#
-# Notes: The resulting QMP strings can be appended to the "qemu-system-"
-#        prefix to produce the corresponding QEMU executable name. This
-#        is true even for "qemu-system-x86_64".
-#
-# ppcemb: dropped in 3.1
-#
-# Since: 3.0
-##
-{ 'enum' : 'SysEmuTarget',
-  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
-             'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
-             'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
-             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
-             'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
-             'x86_64', 'xtensa', 'xtensaeb' ] }
diff --git a/qapi/machine.json b/qapi/machine.json
index 6db8a7e2ec..de5c742d72 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -7,7 +7,30 @@
 # =3D Machines
 ##
=20
-{ 'include': 'common.json' }
+##
+# @SysEmuTarget:
+#
+# The comprehensive enumeration of QEMU system emulation ("softmmu")
+# targets. Run "./configure --help" in the project root directory, and
+# look for the *-softmmu targets near the "--target-list" option. The
+# individual target constants are not documented here, for the time
+# being.
+#
+# Notes: The resulting QMP strings can be appended to the "qemu-system-"
+#        prefix to produce the corresponding QEMU executable name. This
+#        is true even for "qemu-system-x86_64".
+#
+# ppcemb: dropped in 3.1
+#
+# Since: 3.0
+##
+{ 'enum' : 'SysEmuTarget',
+  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
+             'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
+             'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
+             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
+             'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
+             'x86_64', 'xtensa', 'xtensaeb' ] }
=20
 ##
 # @CpuInfoArch:
@@ -368,6 +391,29 @@
 ##
 { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' =
}
=20
+##
+# @TargetInfo:
+#
+# Information describing the QEMU target.
+#
+# @arch: the target architecture
+#
+# Since: 1.2.0
+##
+{ 'struct': 'TargetInfo',
+  'data': { 'arch': 'SysEmuTarget' } }
+
+##
+# @query-target:
+#
+# Return information about the target for this QEMU
+#
+# Returns: TargetInfo
+#
+# Since: 1.2.0
+##
+{ 'command': 'query-target', 'returns': 'TargetInfo' }
+
 ##
 # @NumaOptionsType:
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index a7fba7230c..6bd11f50e6 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1341,29 +1341,6 @@
 ##
 { 'command': 'query-fdsets', 'returns': ['FdsetInfo'] }
=20
-##
-# @TargetInfo:
-#
-# Information describing the QEMU target.
-#
-# @arch: the target architecture
-#
-# Since: 1.2.0
-##
-{ 'struct': 'TargetInfo',
-  'data': { 'arch': 'SysEmuTarget' } }
-
-##
-# @query-target:
-#
-# Return information about the target for this QEMU
-#
-# Returns: TargetInfo
-#
-# Since: 1.2.0
-##
-{ 'command': 'query-target', 'returns': 'TargetInfo' }
-
 ##
 # @AcpiTableOptions:
 #
--=20
2.21.0


