Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6233FC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C8A20659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C8A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGSP-00069t-52
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51040)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiGJy-0005pt-Ep
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiGJt-0007si-3k
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiGJq-0007mB-G4
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CDA2881DF9
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 10:47:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2857E5D968;
 Tue,  2 Jul 2019 10:47:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F0062111BD5D; Tue,  2 Jul 2019 12:47:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 12:47:13 +0200
Message-Id: <20190702104716.9140-16-armbru@redhat.com>
In-Reply-To: <20190702104716.9140-1-armbru@redhat.com>
References: <20190702104716.9140-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 02 Jul 2019 10:47:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/18] qapi: Split dump.json off misc.json
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move commands dump-guest-memory, query-dump,
query-dump-guest-memory-capability with their types from misc.json to
new dump.json.  Add dump.json to MAINTAINERS section "Dump".

Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190619201050.19040-15-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 MAINTAINERS           |   1 +
 dump.c                |   4 +-
 include/sysemu/dump.h |   2 +-
 monitor/hmp-cmds.c    |   1 +
 qapi/Makefile.objs    |   2 +-
 qapi/dump.json        | 200 ++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json        | 192 ----------------------------------------
 qapi/qapi-schema.json |   1 +
 8 files changed, 207 insertions(+), 196 deletions(-)
 create mode 100644 qapi/dump.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 2eb851cbdd..4dbc9c212c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1855,6 +1855,7 @@ F: hw/misc/vmcoreinfo.c
 F: include/hw/misc/vmcoreinfo.h
 F: include/sysemu/dump-arch.h
 F: include/sysemu/dump.h
+F: qapi/dump.json
 F: scripts/dump-guest-memory.py
 F: stubs/dump.c
=20
diff --git a/dump.c b/dump.c
index e99554628c..c7b2301652 100644
--- a/dump.c
+++ b/dump.c
@@ -24,8 +24,8 @@
 #include "sysemu/memory_mapping.h"
 #include "sysemu/cpus.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-events-misc.h"
+#include "qapi/qapi-commands-dump.h"
+#include "qapi/qapi-events-dump.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "hw/misc/vmcoreinfo.h"
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index d824bc0941..250143cb5a 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -14,7 +14,7 @@
 #ifndef DUMP_H
 #define DUMP_H
=20
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-dump.h"
=20
 #define MAKEDUMPFILE_SIGNATURE      "makedumpfile"
 #define MAX_SIZE_MDF_HEADER         (4096) /* max size of makedumpfile_h=
eader */
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index ea8ae2966e..18ffeb7017 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -31,6 +31,7 @@
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-char.h"
+#include "qapi/qapi-commands-dump.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-net.h"
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index c0be6fcd3e..c5a29e86e2 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -6,7 +6,7 @@ util-obj-y +=3D qmp-event.o
 util-obj-y +=3D qapi-util.o
=20
 QAPI_COMMON_MODULES =3D audio authz block-core block char common crypto
-QAPI_COMMON_MODULES +=3D introspect job machine migration misc net
+QAPI_COMMON_MODULES +=3D dump introspect job machine migration misc net
 QAPI_COMMON_MODULES +=3D qdev qom rdma rocker run-state sockets tpm
 QAPI_COMMON_MODULES +=3D trace transaction ui
 QAPI_TARGET_MODULES =3D machine-target misc-target
diff --git a/qapi/dump.json b/qapi/dump.json
new file mode 100644
index 0000000000..2b35409a7b
--- /dev/null
+++ b/qapi/dump.json
@@ -0,0 +1,200 @@
+# -*- Mode: Python -*-
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+# See the COPYING file in the top-level directory.
+
+##
+# =3D Dump guest memory
+##
+
+##
+# @DumpGuestMemoryFormat:
+#
+# An enumeration of guest-memory-dump's format.
+#
+# @elf: elf format
+#
+# @kdump-zlib: kdump-compressed format with zlib-compressed
+#
+# @kdump-lzo: kdump-compressed format with lzo-compressed
+#
+# @kdump-snappy: kdump-compressed format with snappy-compressed
+#
+# @win-dmp: Windows full crashdump format,
+#           can be used instead of ELF converting (since 2.13)
+#
+# Since: 2.0
+##
+{ 'enum': 'DumpGuestMemoryFormat',
+  'data': [ 'elf', 'kdump-zlib', 'kdump-lzo', 'kdump-snappy', 'win-dmp' =
] }
+
+##
+# @dump-guest-memory:
+#
+# Dump guest's memory to vmcore. It is a synchronous operation that can =
take
+# very long depending on the amount of guest memory.
+#
+# @paging: if true, do paging to get guest's memory mapping. This allows
+#          using gdb to process the core file.
+#
+#          IMPORTANT: this option can make QEMU allocate several gigabyt=
es
+#                     of RAM. This can happen for a large guest, or a
+#                     malicious guest pretending to be large.
+#
+#          Also, paging=3Dtrue has the following limitations:
+#
+#             1. The guest may be in a catastrophic state or can have co=
rrupted
+#                memory, which cannot be trusted
+#             2. The guest can be in real-mode even if paging is enabled=
. For
+#                example, the guest uses ACPI to sleep, and ACPI sleep s=
tate
+#                goes in real-mode
+#             3. Currently only supported on i386 and x86_64.
+#
+# @protocol: the filename or file descriptor of the vmcore. The supporte=
d
+#            protocols are:
+#
+#            1. file: the protocol starts with "file:", and the followin=
g
+#               string is the file's path.
+#            2. fd: the protocol starts with "fd:", and the following st=
ring
+#               is the fd's name.
+#
+# @detach: if true, QMP will return immediately rather than
+#          waiting for the dump to finish. The user can track progress
+#          using "query-dump". (since 2.6).
+#
+# @begin: if specified, the starting physical address.
+#
+# @length: if specified, the memory size, in bytes. If you don't
+#          want to dump all guest's memory, please specify the start @be=
gin
+#          and @length
+#
+# @format: if specified, the format of guest memory dump. But non-elf
+#          format is conflict with paging and filter, ie. @paging, @begi=
n and
+#          @length is not allowed to be specified with non-elf @format a=
t the
+#          same time (since 2.0)
+#
+# Note: All boolean arguments default to false
+#
+# Returns: nothing on success
+#
+# Since: 1.2
+#
+# Example:
+#
+# -> { "execute": "dump-guest-memory",
+#      "arguments": { "protocol": "fd:dump" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'dump-guest-memory',
+  'data': { 'paging': 'bool', 'protocol': 'str', '*detach': 'bool',
+            '*begin': 'int', '*length': 'int',
+            '*format': 'DumpGuestMemoryFormat'} }
+
+##
+# @DumpStatus:
+#
+# Describe the status of a long-running background guest memory dump.
+#
+# @none: no dump-guest-memory has started yet.
+#
+# @active: there is one dump running in background.
+#
+# @completed: the last dump has finished successfully.
+#
+# @failed: the last dump has failed.
+#
+# Since: 2.6
+##
+{ 'enum': 'DumpStatus',
+  'data': [ 'none', 'active', 'completed', 'failed' ] }
+
+##
+# @DumpQueryResult:
+#
+# The result format for 'query-dump'.
+#
+# @status: enum of @DumpStatus, which shows current dump status
+#
+# @completed: bytes written in latest dump (uncompressed)
+#
+# @total: total bytes to be written in latest dump (uncompressed)
+#
+# Since: 2.6
+##
+{ 'struct': 'DumpQueryResult',
+  'data': { 'status': 'DumpStatus',
+            'completed': 'int',
+            'total': 'int' } }
+
+##
+# @query-dump:
+#
+# Query latest dump status.
+#
+# Returns: A @DumpStatus object showing the dump status.
+#
+# Since: 2.6
+#
+# Example:
+#
+# -> { "execute": "query-dump" }
+# <- { "return": { "status": "active", "completed": 1024000,
+#                  "total": 2048000 } }
+#
+##
+{ 'command': 'query-dump', 'returns': 'DumpQueryResult' }
+
+##
+# @DUMP_COMPLETED:
+#
+# Emitted when background dump has completed
+#
+# @result: final dump status
+#
+# @error: human-readable error string that provides
+#         hint on why dump failed. Only presents on failure. The
+#         user should not try to interpret the error string.
+#
+# Since: 2.6
+#
+# Example:
+#
+# { "event": "DUMP_COMPLETED",
+#   "data": {"result": {"total": 1090650112, "status": "completed",
+#                       "completed": 1090650112} } }
+#
+##
+{ 'event': 'DUMP_COMPLETED' ,
+  'data': { 'result': 'DumpQueryResult', '*error': 'str' } }
+
+##
+# @DumpGuestMemoryCapability:
+#
+# A list of the available formats for dump-guest-memory
+#
+# Since: 2.0
+##
+{ 'struct': 'DumpGuestMemoryCapability',
+  'data': {
+      'formats': ['DumpGuestMemoryFormat'] } }
+
+##
+# @query-dump-guest-memory-capability:
+#
+# Returns the available formats for dump-guest-memory
+#
+# Returns:  A @DumpGuestMemoryCapability object listing available format=
s for
+#           dump-guest-memory
+#
+# Since: 2.0
+#
+# Example:
+#
+# -> { "execute": "query-dump-guest-memory-capability" }
+# <- { "return": { "formats":
+#                  ["elf", "kdump-zlib", "kdump-lzo", "kdump-snappy"] }
+#
+##
+{ 'command': 'query-dump-guest-memory-capability',
+  'returns': 'DumpGuestMemoryCapability' }
diff --git a/qapi/misc.json b/qapi/misc.json
index d7db863c81..31427d45a6 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1117,198 +1117,6 @@
 ##
 { 'command': 'xen-set-global-dirty-log', 'data': { 'enable': 'bool' } }
=20
-##
-# @DumpGuestMemoryFormat:
-#
-# An enumeration of guest-memory-dump's format.
-#
-# @elf: elf format
-#
-# @kdump-zlib: kdump-compressed format with zlib-compressed
-#
-# @kdump-lzo: kdump-compressed format with lzo-compressed
-#
-# @kdump-snappy: kdump-compressed format with snappy-compressed
-#
-# @win-dmp: Windows full crashdump format,
-#           can be used instead of ELF converting (since 2.13)
-#
-# Since: 2.0
-##
-{ 'enum': 'DumpGuestMemoryFormat',
-  'data': [ 'elf', 'kdump-zlib', 'kdump-lzo', 'kdump-snappy', 'win-dmp' =
] }
-
-##
-# @dump-guest-memory:
-#
-# Dump guest's memory to vmcore. It is a synchronous operation that can =
take
-# very long depending on the amount of guest memory.
-#
-# @paging: if true, do paging to get guest's memory mapping. This allows
-#          using gdb to process the core file.
-#
-#          IMPORTANT: this option can make QEMU allocate several gigabyt=
es
-#                     of RAM. This can happen for a large guest, or a
-#                     malicious guest pretending to be large.
-#
-#          Also, paging=3Dtrue has the following limitations:
-#
-#             1. The guest may be in a catastrophic state or can have co=
rrupted
-#                memory, which cannot be trusted
-#             2. The guest can be in real-mode even if paging is enabled=
. For
-#                example, the guest uses ACPI to sleep, and ACPI sleep s=
tate
-#                goes in real-mode
-#             3. Currently only supported on i386 and x86_64.
-#
-# @protocol: the filename or file descriptor of the vmcore. The supporte=
d
-#            protocols are:
-#
-#            1. file: the protocol starts with "file:", and the followin=
g
-#               string is the file's path.
-#            2. fd: the protocol starts with "fd:", and the following st=
ring
-#               is the fd's name.
-#
-# @detach: if true, QMP will return immediately rather than
-#          waiting for the dump to finish. The user can track progress
-#          using "query-dump". (since 2.6).
-#
-# @begin: if specified, the starting physical address.
-#
-# @length: if specified, the memory size, in bytes. If you don't
-#          want to dump all guest's memory, please specify the start @be=
gin
-#          and @length
-#
-# @format: if specified, the format of guest memory dump. But non-elf
-#          format is conflict with paging and filter, ie. @paging, @begi=
n and
-#          @length is not allowed to be specified with non-elf @format a=
t the
-#          same time (since 2.0)
-#
-# Note: All boolean arguments default to false
-#
-# Returns: nothing on success
-#
-# Since: 1.2
-#
-# Example:
-#
-# -> { "execute": "dump-guest-memory",
-#      "arguments": { "protocol": "fd:dump" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'dump-guest-memory',
-  'data': { 'paging': 'bool', 'protocol': 'str', '*detach': 'bool',
-            '*begin': 'int', '*length': 'int',
-            '*format': 'DumpGuestMemoryFormat'} }
-
-##
-# @DumpStatus:
-#
-# Describe the status of a long-running background guest memory dump.
-#
-# @none: no dump-guest-memory has started yet.
-#
-# @active: there is one dump running in background.
-#
-# @completed: the last dump has finished successfully.
-#
-# @failed: the last dump has failed.
-#
-# Since: 2.6
-##
-{ 'enum': 'DumpStatus',
-  'data': [ 'none', 'active', 'completed', 'failed' ] }
-
-##
-# @DumpQueryResult:
-#
-# The result format for 'query-dump'.
-#
-# @status: enum of @DumpStatus, which shows current dump status
-#
-# @completed: bytes written in latest dump (uncompressed)
-#
-# @total: total bytes to be written in latest dump (uncompressed)
-#
-# Since: 2.6
-##
-{ 'struct': 'DumpQueryResult',
-  'data': { 'status': 'DumpStatus',
-            'completed': 'int',
-            'total': 'int' } }
-
-##
-# @query-dump:
-#
-# Query latest dump status.
-#
-# Returns: A @DumpStatus object showing the dump status.
-#
-# Since: 2.6
-#
-# Example:
-#
-# -> { "execute": "query-dump" }
-# <- { "return": { "status": "active", "completed": 1024000,
-#                  "total": 2048000 } }
-#
-##
-{ 'command': 'query-dump', 'returns': 'DumpQueryResult' }
-
-##
-# @DUMP_COMPLETED:
-#
-# Emitted when background dump has completed
-#
-# @result: final dump status
-#
-# @error: human-readable error string that provides
-#         hint on why dump failed. Only presents on failure. The
-#         user should not try to interpret the error string.
-#
-# Since: 2.6
-#
-# Example:
-#
-# { "event": "DUMP_COMPLETED",
-#   "data": {"result": {"total": 1090650112, "status": "completed",
-#                       "completed": 1090650112} } }
-#
-##
-{ 'event': 'DUMP_COMPLETED' ,
-  'data': { 'result': 'DumpQueryResult', '*error': 'str' } }
-
-##
-# @DumpGuestMemoryCapability:
-#
-# A list of the available formats for dump-guest-memory
-#
-# Since: 2.0
-##
-{ 'struct': 'DumpGuestMemoryCapability',
-  'data': {
-      'formats': ['DumpGuestMemoryFormat'] } }
-
-##
-# @query-dump-guest-memory-capability:
-#
-# Returns the available formats for dump-guest-memory
-#
-# Returns:  A @DumpGuestMemoryCapability object listing available format=
s for
-#           dump-guest-memory
-#
-# Since: 2.0
-#
-# Example:
-#
-# -> { "execute": "query-dump-guest-memory-capability" }
-# <- { "return": { "formats":
-#                  ["elf", "kdump-zlib", "kdump-lzo", "kdump-snappy"] }
-#
-##
-{ 'command': 'query-dump-guest-memory-capability',
-  'returns': 'DumpGuestMemoryCapability' }
-
 ##
 # @getfd:
 #
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index bcfac85074..38af54d6b3 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -86,6 +86,7 @@
 { 'include': 'crypto.json' }
 { 'include': 'block.json' }
 { 'include': 'char.json' }
+{ 'include': 'dump.json' }
 { 'include': 'job.json' }
 { 'include': 'net.json' }
 { 'include': 'rdma.json' }
--=20
2.21.0


