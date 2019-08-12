Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692CEC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 05:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8B42087B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 05:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8B42087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx2pE-0001zS-Hq
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 01:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57074)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hx2oQ-0008W3-U7
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hx2oP-00063D-Iz
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:24:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hx2oP-00061r-Ac
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:24:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2DF0C806D2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 05:24:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 730B5196BA;
 Mon, 12 Aug 2019 05:24:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C6B2D113860E; Mon, 12 Aug 2019 07:23:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 12 Aug 2019 07:23:33 +0200
Message-Id: <20190812052359.30071-4-armbru@redhat.com>
In-Reply-To: <20190812052359.30071-1-armbru@redhat.com>
References: <20190812052359.30071-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 12 Aug 2019 05:24:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 03/29] qapi: Split error.json off common.json
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

In my "build everything" tree, changing a type in qapi/common.json
triggers a recompile of some 3600 out of 6600 objects (not counting
tests and objects that don't depend on qemu/osdep.h).

One common dependency is QapiErrorClass: it's used only in in
qapi/error.h, which uses nothing else, and is widely included.

Move QapiErrorClass from common.json to new error.json.  Touching
common.json now recompiles only some 2900 objects.

Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qapi/common.json      | 24 ------------------------
 qapi/error.json       | 29 +++++++++++++++++++++++++++++
 qapi/qapi-schema.json |  1 +
 include/qapi/error.h  |  2 +-
 MAINTAINERS           |  2 ++
 qapi/Makefile.objs    |  2 +-
 6 files changed, 34 insertions(+), 26 deletions(-)
 create mode 100644 qapi/error.json

diff --git a/qapi/common.json b/qapi/common.json
index 99d313ef3b..3d4e8de1e0 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -4,30 +4,6 @@
 # =3D Common data types
 ##
=20
-##
-# @QapiErrorClass:
-#
-# QEMU error classes
-#
-# @GenericError: this is used for errors that don't require a specific e=
rror
-#                class. This should be the default case for most errors
-#
-# @CommandNotFound: the requested command has not been found
-#
-# @DeviceNotActive: a device has failed to be become active
-#
-# @DeviceNotFound: the requested device has not been found
-#
-# @KVMMissingCap: the requested operation can't be fulfilled because a
-#                 required KVM capability is missing
-#
-# Since: 1.2
-##
-{ 'enum': 'QapiErrorClass',
-  # Keep this in sync with ErrorClass in error.h
-  'data': [ 'GenericError', 'CommandNotFound',
-            'DeviceNotActive', 'DeviceNotFound', 'KVMMissingCap' ] }
-
 ##
 # @IoOperationType:
 #
diff --git a/qapi/error.json b/qapi/error.json
new file mode 100644
index 0000000000..3fad08f506
--- /dev/null
+++ b/qapi/error.json
@@ -0,0 +1,29 @@
+# -*- Mode: Python -*-
+
+##
+# =3D QMP errors
+##
+
+##
+# @QapiErrorClass:
+#
+# QEMU error classes
+#
+# @GenericError: this is used for errors that don't require a specific e=
rror
+#                class. This should be the default case for most errors
+#
+# @CommandNotFound: the requested command has not been found
+#
+# @DeviceNotActive: a device has failed to be become active
+#
+# @DeviceNotFound: the requested device has not been found
+#
+# @KVMMissingCap: the requested operation can't be fulfilled because a
+#                 required KVM capability is missing
+#
+# Since: 1.2
+##
+{ 'enum': 'QapiErrorClass',
+  # Keep this in sync with ErrorClass in error.h
+  'data': [ 'GenericError', 'CommandNotFound',
+            'DeviceNotActive', 'DeviceNotFound', 'KVMMissingCap' ] }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 38af54d6b3..920b03b0aa 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -80,6 +80,7 @@
 # stable order, it's best to include each sub-schema just once, or
 # include it first right here.
=20
+{ 'include': 'error.json' }
 { 'include': 'common.json' }
 { 'include': 'sockets.json' }
 { 'include': 'run-state.json' }
diff --git a/include/qapi/error.h b/include/qapi/error.h
index 51b63dd4b5..3f95141a01 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -119,7 +119,7 @@
 #ifndef ERROR_H
 #define ERROR_H
=20
-#include "qapi/qapi-types-common.h"
+#include "qapi/qapi-types-error.h"
=20
 /*
  * Overall category of an error.
diff --git a/MAINTAINERS b/MAINTAINERS
index d6de200453..adc64cfe33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1874,6 +1874,7 @@ M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: include/qapi/error.h
 F: include/qemu/error-report.h
+F: qapi/error.json
 F: util/error.c
 F: util/qemu-error.c
=20
@@ -2062,6 +2063,7 @@ F: monitor/monitor-internal.h
 F: monitor/qmp*
 F: monitor/misc.c
 F: monitor/monitor.c
+F: qapi/error.json
 F: docs/devel/*qmp-*
 F: docs/interop/*qmp-*
 F: scripts/qmp/
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index c5a29e86e2..dd3f5e6f94 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -6,7 +6,7 @@ util-obj-y +=3D qmp-event.o
 util-obj-y +=3D qapi-util.o
=20
 QAPI_COMMON_MODULES =3D audio authz block-core block char common crypto
-QAPI_COMMON_MODULES +=3D dump introspect job machine migration misc net
+QAPI_COMMON_MODULES +=3D dump error introspect job machine migration mis=
c net
 QAPI_COMMON_MODULES +=3D qdev qom rdma rocker run-state sockets tpm
 QAPI_COMMON_MODULES +=3D trace transaction ui
 QAPI_TARGET_MODULES =3D machine-target misc-target
--=20
2.21.0


