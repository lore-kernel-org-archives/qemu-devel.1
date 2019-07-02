Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B4FC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 05:09:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE90C216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 05:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE90C216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiB2e-0003Pr-KF
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 01:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50177)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiB25-000315-VX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 01:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiB23-0006wJ-W6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 01:08:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiB20-0006uA-C5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 01:08:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9ED2D85365
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 05:08:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4086C422C;
 Tue,  2 Jul 2019 05:08:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B1BB01132ABF; Tue,  2 Jul 2019 07:08:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-7-armbru@redhat.com>
Date: Tue, 02 Jul 2019 07:08:36 +0200
In-Reply-To: <20190619201050.19040-7-armbru@redhat.com> (Markus Armbruster's
 message of "Wed, 19 Jun 2019 22:10:39 +0200")
Message-ID: <87o92dowff.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 02 Jul 2019 05:08:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 06/17] qom: Move HMP command handlers to
 qom/
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
Cc: kwolf@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> There are just two HMP commands related to QOM: qom-list and qom-set.
> Move their handlers from monitor/hmp-cmds.c to new qom/qom-hmp-cmds.c,
> where they are covered by MAINTAINERS section QOM.

Actually three: hmp_info_qom_tree().  I'm squashing the obvious movement
into this patch (appended), updating the commit message to

  Move the HMP command handlers related to QOM handlers from
  monitor/hmp-cmds.c and qdev-monitor.c to new qom/qom-hmp-cmds.c, where
  they are covered by MAINTAINERS section QOM.

Hope that's okay.

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/monitor/hmp.h |  2 ++
>  monitor/hmp-cmds.c    | 50 +---------------------------------
>  qom/Makefile.objs     |  2 +-
>  qom/qom-hmp-cmds.c    | 62 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+), 50 deletions(-)
>  create mode 100644 qom/qom-hmp-cmds.c
>
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 1d095d5837..f46ccdaa35 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -16,6 +16,8 @@
>  
>  #include "qemu/readline.h"
>  
> +void hmp_handle_error(Monitor *mon, Error **errp);
> +
>  void hmp_info_name(Monitor *mon, const QDict *qdict);
>  void hmp_info_version(Monitor *mon, const QDict *qdict);
>  void hmp_info_kvm(Monitor *mon, const QDict *qdict);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index d94ab7563e..5641036dc3 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -60,7 +60,7 @@
>  #include <spice/enums.h>
>  #endif
>  
> -static void hmp_handle_error(Monitor *mon, Error **errp)
> +void hmp_handle_error(Monitor *mon, Error **errp)
>  {
>      assert(errp);
>      if (*errp) {
> @@ -2714,54 +2714,6 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
>      qapi_free_IOThreadInfoList(info_list);
>  }
>  
> -void hmp_qom_list(Monitor *mon, const QDict *qdict)
> -{
> -    const char *path = qdict_get_try_str(qdict, "path");
> -    ObjectPropertyInfoList *list;
> -    Error *err = NULL;
> -
> -    if (path == NULL) {
> -        monitor_printf(mon, "/\n");
> -        return;
> -    }
> -
> -    list = qmp_qom_list(path, &err);
> -    if (err == NULL) {
> -        ObjectPropertyInfoList *start = list;
> -        while (list != NULL) {
> -            ObjectPropertyInfo *value = list->value;
> -
> -            monitor_printf(mon, "%s (%s)\n",
> -                           value->name, value->type);
> -            list = list->next;
> -        }
> -        qapi_free_ObjectPropertyInfoList(start);
> -    }
> -    hmp_handle_error(mon, &err);
> -}
> -
> -void hmp_qom_set(Monitor *mon, const QDict *qdict)
> -{
> -    const char *path = qdict_get_str(qdict, "path");
> -    const char *property = qdict_get_str(qdict, "property");
> -    const char *value = qdict_get_str(qdict, "value");
> -    Error *err = NULL;
> -    bool ambiguous = false;
> -    Object *obj;
> -
> -    obj = object_resolve_path(path, &ambiguous);
> -    if (obj == NULL) {
> -        error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
> -                  "Device '%s' not found", path);
> -    } else {
> -        if (ambiguous) {
> -            monitor_printf(mon, "Warning: Path '%s' is ambiguous\n", path);
> -        }
> -        object_property_parse(obj, value, property, &err);
> -    }
> -    hmp_handle_error(mon, &err);
> -}
> -
>  void hmp_rocker(Monitor *mon, const QDict *qdict)
>  {
>      const char *name = qdict_get_str(qdict, "name");
> diff --git a/qom/Makefile.objs b/qom/Makefile.objs
> index 5fb43b842c..aae478fc21 100644
> --- a/qom/Makefile.objs
> +++ b/qom/Makefile.objs
> @@ -2,4 +2,4 @@ qom-obj-y = object.o container.o qom-qobject.o
>  qom-obj-y += object_interfaces.o
>  
>  common-obj-y = cpu.o
> -common-obj-$(CONFIG_SOFTMMU) += qom-qmp-cmds.o
> +common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> new file mode 100644
> index 0000000000..2028a21052
> --- /dev/null
> +++ b/qom/qom-hmp-cmds.c
> @@ -0,0 +1,62 @@
> +/*
> + * HMP commands related to QOM
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "monitor/hmp.h"
> +#include "qapi/qapi-commands-qom.h"
> +#include "qapi/qmp/qdict.h"
> +#include "monitor/monitor.h"
> +#include "qom/object.h"
> +#include "qapi/error.h"
> +
> +void hmp_qom_list(Monitor *mon, const QDict *qdict)
> +{
> +    const char *path = qdict_get_try_str(qdict, "path");
> +    ObjectPropertyInfoList *list;
> +    Error *err = NULL;
> +
> +    if (path == NULL) {
> +        monitor_printf(mon, "/\n");
> +        return;
> +    }
> +
> +    list = qmp_qom_list(path, &err);
> +    if (err == NULL) {
> +        ObjectPropertyInfoList *start = list;
> +        while (list != NULL) {
> +            ObjectPropertyInfo *value = list->value;
> +
> +            monitor_printf(mon, "%s (%s)\n",
> +                           value->name, value->type);
> +            list = list->next;
> +        }
> +        qapi_free_ObjectPropertyInfoList(start);
> +    }
> +    hmp_handle_error(mon, &err);
> +}
> +
> +void hmp_qom_set(Monitor *mon, const QDict *qdict)
> +{
> +    const char *path = qdict_get_str(qdict, "path");
> +    const char *property = qdict_get_str(qdict, "property");
> +    const char *value = qdict_get_str(qdict, "value");
> +    Error *err = NULL;
> +    bool ambiguous = false;
> +    Object *obj;
> +
> +    obj = object_resolve_path(path, &ambiguous);
> +    if (obj == NULL) {
> +        error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
> +                  "Device '%s' not found", path);
> +    } else {
> +        if (ambiguous) {
> +            monitor_printf(mon, "Warning: Path '%s' is ambiguous\n", path);
> +        }
> +        object_property_parse(obj, value, property, &err);
> +    }
> +    hmp_handle_error(mon, &err);
> +}

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 9d558e9d78..a0e9511440 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -121,6 +121,7 @@ void hmp_info_numa(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_devices(Monitor *mon, const QDict *qdict);
 void hmp_qom_list(Monitor *mon, const QDict *qdict);
 void hmp_qom_set(Monitor *mon, const QDict *qdict);
+void hmp_info_qom_tree(Monitor *mon, const QDict *dict);
 void object_add_completion(ReadLineState *rs, int nb_args, const char *str);
 void object_del_completion(ReadLineState *rs, int nb_args, const char *str);
 void device_add_completion(ReadLineState *rs, int nb_args, const char *str);
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index 0ff3331284..084799e4d9 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -7,7 +7,6 @@
 
 void hmp_info_qtree(Monitor *mon, const QDict *qdict);
 void hmp_info_qdm(Monitor *mon, const QDict *qdict);
-void hmp_info_qom_tree(Monitor *mon, const QDict *dict);
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
 
 int qdev_device_help(QemuOpts *opts);
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 63a87e9632..58222c2211 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -739,63 +739,6 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict)
     qdev_print_devinfos(true);
 }
 
-typedef struct QOMCompositionState {
-    Monitor *mon;
-    int indent;
-} QOMCompositionState;
-
-static void print_qom_composition(Monitor *mon, Object *obj, int indent);
-
-static int print_qom_composition_child(Object *obj, void *opaque)
-{
-    QOMCompositionState *s = opaque;
-
-    print_qom_composition(s->mon, obj, s->indent);
-
-    return 0;
-}
-
-static void print_qom_composition(Monitor *mon, Object *obj, int indent)
-{
-    QOMCompositionState s = {
-        .mon = mon,
-        .indent = indent + 2,
-    };
-    char *name;
-
-    if (obj == object_get_root()) {
-        name = g_strdup("");
-    } else {
-        name = object_get_canonical_path_component(obj);
-    }
-    monitor_printf(mon, "%*s/%s (%s)\n", indent, "", name,
-                   object_get_typename(obj));
-    g_free(name);
-    object_child_foreach(obj, print_qom_composition_child, &s);
-}
-
-void hmp_info_qom_tree(Monitor *mon, const QDict *dict)
-{
-    const char *path = qdict_get_try_str(dict, "path");
-    Object *obj;
-    bool ambiguous = false;
-
-    if (path) {
-        obj = object_resolve_path(path, &ambiguous);
-        if (!obj) {
-            monitor_printf(mon, "Path '%s' could not be resolved.\n", path);
-            return;
-        }
-        if (ambiguous) {
-            monitor_printf(mon, "Warning: Path '%s' is ambiguous.\n", path);
-            return;
-        }
-    } else {
-        obj = qdev_get_machine();
-    }
-    print_qom_composition(mon, obj, 0);
-}
-
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
 {
     Error *local_err = NULL;
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 2028a21052..a268e01eb4 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -6,12 +6,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/qdev-core.h"
 #include "monitor/hmp.h"
+#include "monitor/monitor.h"
+#include "qapi/error.h"
 #include "qapi/qapi-commands-qom.h"
 #include "qapi/qmp/qdict.h"
-#include "monitor/monitor.h"
 #include "qom/object.h"
-#include "qapi/error.h"
 
 void hmp_qom_list(Monitor *mon, const QDict *qdict)
 {
@@ -60,3 +61,60 @@ void hmp_qom_set(Monitor *mon, const QDict *qdict)
     }
     hmp_handle_error(mon, &err);
 }
+
+typedef struct QOMCompositionState {
+    Monitor *mon;
+    int indent;
+} QOMCompositionState;
+
+static void print_qom_composition(Monitor *mon, Object *obj, int indent);
+
+static int print_qom_composition_child(Object *obj, void *opaque)
+{
+    QOMCompositionState *s = opaque;
+
+    print_qom_composition(s->mon, obj, s->indent);
+
+    return 0;
+}
+
+static void print_qom_composition(Monitor *mon, Object *obj, int indent)
+{
+    QOMCompositionState s = {
+        .mon = mon,
+        .indent = indent + 2,
+    };
+    char *name;
+
+    if (obj == object_get_root()) {
+        name = g_strdup("");
+    } else {
+        name = object_get_canonical_path_component(obj);
+    }
+    monitor_printf(mon, "%*s/%s (%s)\n", indent, "", name,
+                   object_get_typename(obj));
+    g_free(name);
+    object_child_foreach(obj, print_qom_composition_child, &s);
+}
+
+void hmp_info_qom_tree(Monitor *mon, const QDict *dict)
+{
+    const char *path = qdict_get_try_str(dict, "path");
+    Object *obj;
+    bool ambiguous = false;
+
+    if (path) {
+        obj = object_resolve_path(path, &ambiguous);
+        if (!obj) {
+            monitor_printf(mon, "Path '%s' could not be resolved.\n", path);
+            return;
+        }
+        if (ambiguous) {
+            monitor_printf(mon, "Warning: Path '%s' is ambiguous.\n", path);
+            return;
+        }
+    } else {
+        obj = qdev_get_machine();
+    }
+    print_qom_composition(mon, obj, 0);
+}

