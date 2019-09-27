Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE8C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D24217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D24217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDsD7-0007EE-Dk
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 11:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iDqWX-0006DX-66
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iDqWV-0005Q2-OF
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:43:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35884)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iDqWV-0005Pn-FK
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:43:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B5C4D301A3AE
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 13:43:02 +0000 (UTC)
Received: from localhost (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22C1710018F8;
 Fri, 27 Sep 2019 13:42:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/7] util: add dbus helper unit
Date: Fri, 27 Sep 2019 17:42:21 +0400
Message-Id: <20190927134224.14550-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190927134224.14550-1-marcandre.lureau@redhat.com>
References: <20190927134224.14550-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 27 Sep 2019 13:43:02 +0000 (UTC)
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
Cc: berrange@redhat.com, quintela@redhat.com, mprivozn@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS         |  2 ++
 include/qemu/dbus.h | 18 +++++++++++++++
 util/Makefile.objs  |  3 +++
 util/dbus.c         | 55 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+)
 create mode 100644 include/qemu/dbus.h
 create mode 100644 util/dbus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 219a76f0a1..dccea79d48 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2160,6 +2160,8 @@ F: qapi/migration.json
 D-Bus
 M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
 S: Maintained
+F: util/dbus.c
+F: include/qemu/dbus.h
 F: docs/interop/dbus.rst
=20
 Seccomp
diff --git a/include/qemu/dbus.h b/include/qemu/dbus.h
new file mode 100644
index 0000000000..efd74bef96
--- /dev/null
+++ b/include/qemu/dbus.h
@@ -0,0 +1,18 @@
+/*
+ * Helpers for using D-Bus
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef DBUS_H
+#define DBUS_H
+
+#include <gio/gio.h>
+
+GStrv qemu_dbus_get_queued_owners(GDBusConnection *connection,
+                                  const char *name);
+
+#endif /* DBUS_H */
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 41bf59d127..f435cfbd64 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -54,5 +54,8 @@ util-obj-$(CONFIG_INOTIFY1) +=3D filemonitor-inotify.o
 util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
 util-obj-$(CONFIG_POSIX) +=3D drm.o
 util-obj-y +=3D guest-random.o
+util-obj-$(CONFIG_GIO) +=3D dbus.o
+dbus.o-cflags =3D $(GIO_CFLAGS)
+dbus.o-libs =3D $(GIO_LIBS)
=20
 stub-obj-y +=3D filemonitor-stub.o
diff --git a/util/dbus.c b/util/dbus.c
new file mode 100644
index 0000000000..bb51870e54
--- /dev/null
+++ b/util/dbus.c
@@ -0,0 +1,55 @@
+/*
+ * Helpers for using D-Bus
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/dbus.h"
+#include "qemu/error-report.h"
+
+/*
+ * qemu_dbus_get_queued_owners() - return the list of queued unique name=
s
+ * @connection: A GDBusConnection
+ * @name: a service name
+ *
+ * Return: a GStrv of unique names, or NULL on failure.
+ */
+GStrv
+qemu_dbus_get_queued_owners(GDBusConnection *connection, const char *nam=
e)
+{
+    g_autoptr(GDBusProxy) proxy =3D NULL;
+    g_autoptr(GVariant) result =3D NULL;
+    g_autoptr(GVariant) child =3D NULL;
+    g_autoptr(GError) err =3D NULL;
+
+    proxy =3D g_dbus_proxy_new_sync(connection, G_DBUS_PROXY_FLAGS_NONE,=
 NULL,
+                                  "org.freedesktop.DBus",
+                                  "/org/freedesktop/DBus",
+                                  "org.freedesktop.DBus",
+                                  NULL, &err);
+    if (!proxy) {
+        error_report("Failed to create DBus proxy: %s", err->message);
+        return NULL;
+    }
+
+    result =3D g_dbus_proxy_call_sync(proxy, "ListQueuedOwners",
+                                    g_variant_new("(s)", name),
+                                    G_DBUS_CALL_FLAGS_NO_AUTO_START,
+                                    -1, NULL, &err);
+    if (!result) {
+        if (g_error_matches(err,
+                            G_DBUS_ERROR,
+                            G_DBUS_ERROR_NAME_HAS_NO_OWNER)) {
+            return g_new0(char *, 1);
+        }
+        error_report("Failed to call ListQueuedOwners: %s", err->message=
);
+        return NULL;
+    }
+
+    child =3D g_variant_get_child_value(result, 0);
+    return g_variant_dup_strv(child, NULL);
+}
--=20
2.23.0


