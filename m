Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FF0C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E6C206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="GcgBZoPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E6C206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2TK-0003EE-TJ
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2Np-00023W-PU; Tue, 01 Sep 2020 05:15:17 -0400
Received: from mout.web.de ([212.227.17.12]:51301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2Nm-00079z-RO; Tue, 01 Sep 2020 05:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598951709;
 bh=FGVcXS49B3ghj8/SIYCEvRl6W4CeHpT1H1JlfjhaCys=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=GcgBZoPH8O/FGqxdogSiRXICLIdGhlV1/udfhazUwiHjO7AawyqMl/6rukZNUReQo
 gTo59UyEo9SoCqPtK5jRK08Q0FshO/hFgx0tIIToIes3H++DtunREnfx2MBfh05xgy
 tjhkhLZ2oVUh886SnkeHl4JNNqhN51cAfm0UH+ew=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.220]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBjMM-1kIaIL0ptE-00CPAE; Tue, 01
 Sep 2020 11:15:09 +0200
Date: Tue, 1 Sep 2020 11:15:07 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v8 1/8] Introduce yank feature
Message-ID: <ab5c04766f270d53e90f17f76c0af7e5b66f8623.1598951375.git.lukasstraub2@web.de>
In-Reply-To: <cover.1598951375.git.lukasstraub2@web.de>
References: <cover.1598951375.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zYu_kxxZNYSvNzwqWL33vlG";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:xOwm8OxUfjmWV2ElLILfkcf/Vrj61Vlbx4rsBr3aQjWadl4OReg
 vTX6689dN/05SjsWP0NdkcGk4BMxkSF+N8AvIdF/AzpePy9YKPLRu8LmTsE1/J9gPCgMqEE
 OvlBSpVbePAllRfsF0vt1PpOnBAMd0M+4qTdL5kFNRXYFQrZ2kgGSzQKWZ+0vEPrJRs8o33
 vLX+SWeQKS+LPhngnjrpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t7OeT9xk4Ww=:S7BINj6kvjPamrtcuctuS8
 iFN9dG0NQX3HYpd8riBCtXT/K5oVFvmSmItfdKBVs9QSMmXD5SDtlBRcdECgRuJd9nqMzNurl
 GGTOCrIxV8yKBQLjEGk0hbQKX6ype/Fl7iwRvuQi24tSKMca0Bt7rLeLHF4tRL88zUMSy/DTa
 h5VWv/WfHUM87GEvNwi7DqnKB2QxiDokWL8lCAxgfw4iBmf+rqbhH0qo+LUleSW1/eNwYjEmT
 iRfpaw2CH12yGb7+jd0yd+LSL+3AGFhm4WRzriJnmQqVwrabTEy2NSp6mZM0ScyUw5QGILWrh
 dOUtzZln3tsLEjdlYSzERwmTK0iE0TTb8uRQPiLpoaYX1mjMgoDgepn4QZte2zUoLS8Byq8J9
 gNrIH5jAcUpB8XXv3BPpDxrvFeNukXzMORIvla5bUNUlaUwX7knwT63dm8aHx8k5gLWF1tz9n
 UUltiyEtXXyQHWitJmLDHI3Pw8swGTTVsY4DMXi4OgBkVOzpLYlfWkzPxCNcu7bWoFte87x38
 rmAU1XiPorK/uB0AlwnkGM+ra/BwpGBBbnurm5EHFqvxHidddzZPbGjRcwT14CSBNnnhPlRqE
 j1ZeooH4VVJiuMw0kH9pqRwmjsfbwu0YWjOpoesapTJZbbv9FoBCtmkF/GsYveAxIKE/rTKCf
 nd3Io/m4Mr8pW/5tos6GCrrR96ZHlLGfFDGn/cjQetPU0cLDmgw1ZJe0fNuSntWacpB1PgT8M
 kjZFCeL9m2kOh1kUkniT4JBSgVi3/LGaZYdZetLHma6Sm031WhvjEz/aEXhukvBsfDPk4EnfM
 uL4D+C4vIx8VSCcmgvj+4QfLUClJQRmAS9KlihCYRRCt0UaiDvXACvMK/bs3/nCZodqGLva7p
 UrjQPe+dRUaKrIZen9GpUXldm8cvxin1Ph0OCPNO7C+w/F/eF6YrShAyYG9yLu2HGJAUd56zD
 OIadn4bnsYFBaMfZuNPOqwmzNLHqO9mudMwwpgBZV33+oGr/LwYKWoNuqWSDLs9tgQdZl+BUG
 x35Yn0p4ZoTR3xYXGFys4Y7ejdbtGKz3Mp2KPsiW2wD05j2NGx15Z7kVaW1VPAlUoKHgcAU2l
 A2c6l/Ng9gmhPpb2EykKtj01iSuwSxhzRpB4JzIu7/NVqTaGd0ww3kx+Ld7U+cg6Qb8hr9C1h
 ClqVan9Xcno206CMeSfndJWeDNXM18xgbXtQzZeeD4JARZWHoidNiWegeRgqZvy+PbLZv2ptq
 gnrqpxX1DkBbhwvQVMGsdpeXXrHBcE/MpyCbhsQ==
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:15:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/zYu_kxxZNYSvNzwqWL33vlG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

The yank feature allows to recover from hanging qemu by "yanking"
at various parts. Other qemu systems can register themselves and
multiple yank functions. Then all yank functions for selected
instances can be called by the 'yank' out-of-band qmp command.
Available instances can be queried by a 'query-yank' oob command.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/yank.h |  81 +++++++++++++++++++
 qapi/misc.json      |  62 +++++++++++++++
 util/meson.build    |   1 +
 util/yank.c         | 187 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 331 insertions(+)
 create mode 100644 include/qemu/yank.h
 create mode 100644 util/yank.c

diff --git a/include/qemu/yank.h b/include/qemu/yank.h
new file mode 100644
index 0000000000..c5ab53965a
--- /dev/null
+++ b/include/qemu/yank.h
@@ -0,0 +1,81 @@
+/*
+ * QEMU yank feature
+ *
+ * Copyright (c) Lukas Straub <lukasstraub2@web.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef YANK_H
+#define YANK_H
+
+typedef void (YankFn)(void *opaque);
+
+/**
+ * yank_register_instance: Register a new instance.
+ *
+ * This registers a new instance for yanking. Must be called before any ya=
nk
+ * function is registered for this instance.
+ *
+ * This function is thread-safe.
+ *
+ * @instance_name: The globally unique name of the instance.
+ * @errp: Error object.
+ */
+void yank_register_instance(const char *instance_name, Error **errp);
+
+/**
+ * yank_unregister_instance: Unregister a instance.
+ *
+ * This unregisters a instance. Must be called only after every yank funct=
ion
+ * of the instance has been unregistered.
+ *
+ * This function is thread-safe.
+ *
+ * @instance_name: The name of the instance.
+ */
+void yank_unregister_instance(const char *instance_name);
+
+/**
+ * yank_register_function: Register a yank function
+ *
+ * This registers a yank function. All limitations of qmp oob commands app=
ly
+ * to the yank function as well. See docs/devel/qapi-code-gen.txt under
+ * "An OOB-capable command handler must satisfy the following conditions".
+ *
+ * This function is thread-safe.
+ *
+ * @instance_name: The name of the instance
+ * @func: The yank function
+ * @opaque: Will be passed to the yank function
+ */
+void yank_register_function(const char *instance_name,
+                            YankFn *func,
+                            void *opaque);
+
+/**
+ * yank_unregister_function: Unregister a yank function
+ *
+ * This unregisters a yank function.
+ *
+ * This function is thread-safe.
+ *
+ * @instance_name: The name of the instance
+ * @func: func that was passed to yank_register_function
+ * @opaque: opaque that was passed to yank_register_function
+ */
+void yank_unregister_function(const char *instance_name,
+                              YankFn *func,
+                              void *opaque);
+
+/**
+ * yank_generic_iochannel: Generic yank function for iochannel
+ *
+ * This is a generic yank function which will call qio_channel_shutdown on=
 the
+ * provided QIOChannel.
+ *
+ * @opaque: QIOChannel to shutdown
+ */
+void yank_generic_iochannel(void *opaque);
+#endif
diff --git a/qapi/misc.json b/qapi/misc.json
index 9d32820dc1..7de330416a 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1615,3 +1615,65 @@
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }

+##
+# @YankInstances:
+#
+# @instances: List of yank instances.
+#
+# A yank instance can be yanked with the "yank" qmp command to recover fro=
m a
+# hanging qemu.
+#
+# Yank instances are named after the following schema:
+# "blockdev:<node-name>" refers to a block device. Currently only nbd block
+# devices are implemented.
+# "chardev:<chardev-name>" refers to a chardev. Currently only socket char=
devs
+# are implemented.
+# "migration" refers to the migration currently in progress.
+#
+# Currently implemented yank instances:
+#  -nbd block device:
+#   Yanking it will shutdown the connection to the nbd server without
+#   attempting to reconnect.
+#  -socket chardev:
+#   Yanking it will shutdown the connected socket.
+#  -migration:
+#   Yanking it will shutdown all migration connections.
+#
+# Since: 5.2
+##
+{ 'struct': 'YankInstances', 'data': {'instances': ['str'] } }
+
+##
+# @yank:
+#
+# Recover from hanging qemu by yanking the specified instances. See
+# "YankInstances" for more information.
+#
+# Takes @YankInstances as argument.
+#
+# Returns: nothing.
+#
+# Example:
+#
+# -> { "execute": "yank", "arguments": { "instances": ["blockdev:nbd0"] } }
+# <- { "return": {} }
+#
+# Since: 5.2
+##
+{ 'command': 'yank', 'data': 'YankInstances', 'allow-oob': true }
+
+##
+# @query-yank:
+#
+# Query yank instances. See "YankInstances" for more information.
+#
+# Returns: @YankInstances
+#
+# Example:
+#
+# -> { "execute": "query-yank" }
+# <- { "return": { "instances": ["blockdev:nbd0"] } }
+#
+# Since: 5.2
+##
+{ 'command': 'query-yank', 'returns': 'YankInstances', 'allow-oob': true }
diff --git a/util/meson.build b/util/meson.build
index e6b207a99e..f3989a1869 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -50,6 +50,7 @@ endif

 if have_system
   util_ss.add(when: 'CONFIG_GIO', if_true: [files('dbus.c'), gio])
+  util_ss.add(files('yank.c'))
 endif

 if have_block
diff --git a/util/yank.c b/util/yank.c
new file mode 100644
index 0000000000..f63bfdca50
--- /dev/null
+++ b/util/yank.c
@@ -0,0 +1,187 @@
+/*
+ * QEMU yank feature
+ *
+ * Copyright (c) Lukas Straub <lukasstraub2@web.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/thread.h"
+#include "qemu/queue.h"
+#include "qapi/qapi-commands-misc.h"
+#include "io/channel.h"
+#include "qemu/yank.h"
+
+struct YankFuncAndParam {
+    YankFn *func;
+    void *opaque;
+    QLIST_ENTRY(YankFuncAndParam) next;
+};
+
+struct YankInstance {
+    char *name;
+    QLIST_HEAD(, YankFuncAndParam) yankfns;
+    QLIST_ENTRY(YankInstance) next;
+};
+
+/*
+ * This lock protects the yank_instance_list below.
+ */
+static QemuMutex yank_lock;
+
+static QLIST_HEAD(, YankInstance) yank_instance_list
+    =3D QLIST_HEAD_INITIALIZER(yank_instance_list);
+
+static struct YankInstance *yank_find_instance(const char *name)
+{
+    struct YankInstance *instance;
+
+    QLIST_FOREACH(instance, &yank_instance_list, next) {
+        if (!strcmp(instance->name, name)) {
+            return instance;
+        }
+    }
+    return NULL;
+}
+
+void yank_register_instance(const char *instance_name, Error **errp)
+{
+    struct YankInstance *instance;
+
+    qemu_mutex_lock(&yank_lock);
+
+    if (yank_find_instance(instance_name)) {
+        error_setg(errp, "duplicate yank instance name: '%s'",
+                   instance_name);
+        qemu_mutex_unlock(&yank_lock);
+        return;
+    }
+
+    instance =3D g_slice_new(struct YankInstance);
+    instance->name =3D g_strdup(instance_name);
+    QLIST_INIT(&instance->yankfns);
+    QLIST_INSERT_HEAD(&yank_instance_list, instance, next);
+
+    qemu_mutex_unlock(&yank_lock);
+}
+
+void yank_unregister_instance(const char *instance_name)
+{
+    struct YankInstance *instance;
+
+    qemu_mutex_lock(&yank_lock);
+    instance =3D yank_find_instance(instance_name);
+    assert(instance);
+
+    assert(QLIST_EMPTY(&instance->yankfns));
+    QLIST_REMOVE(instance, next);
+    g_free(instance->name);
+    g_slice_free(struct YankInstance, instance);
+
+    qemu_mutex_unlock(&yank_lock);
+}
+
+void yank_register_function(const char *instance_name,
+                            YankFn *func,
+                            void *opaque)
+{
+    struct YankInstance *instance;
+    struct YankFuncAndParam *entry;
+
+    qemu_mutex_lock(&yank_lock);
+    instance =3D yank_find_instance(instance_name);
+    assert(instance);
+
+    entry =3D g_slice_new(struct YankFuncAndParam);
+    entry->func =3D func;
+    entry->opaque =3D opaque;
+
+    QLIST_INSERT_HEAD(&instance->yankfns, entry, next);
+    qemu_mutex_unlock(&yank_lock);
+}
+
+void yank_unregister_function(const char *instance_name,
+                              YankFn *func,
+                              void *opaque)
+{
+    struct YankInstance *instance;
+    struct YankFuncAndParam *entry;
+
+    qemu_mutex_lock(&yank_lock);
+    instance =3D yank_find_instance(instance_name);
+    assert(instance);
+
+    QLIST_FOREACH(entry, &instance->yankfns, next) {
+        if (entry->func =3D=3D func && entry->opaque =3D=3D opaque) {
+            QLIST_REMOVE(entry, next);
+            g_slice_free(struct YankFuncAndParam, entry);
+            qemu_mutex_unlock(&yank_lock);
+            return;
+        }
+    }
+
+    abort();
+}
+
+void yank_generic_iochannel(void *opaque)
+{
+    QIOChannel *ioc =3D QIO_CHANNEL(opaque);
+
+    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+}
+
+void qmp_yank(strList *instances,
+              Error **errp)
+{
+    strList *tail;
+    struct YankInstance *instance;
+    struct YankFuncAndParam *entry;
+
+    qemu_mutex_lock(&yank_lock);
+    for (tail =3D instances; tail; tail =3D tail->next) {
+        instance =3D yank_find_instance(tail->value);
+        if (!instance) {
+            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+                      "Instance '%s' not found", tail->value);
+            qemu_mutex_unlock(&yank_lock);
+            return;
+        }
+    }
+    for (tail =3D instances; tail; tail =3D tail->next) {
+        instance =3D yank_find_instance(tail->value);
+        assert(instance);
+        QLIST_FOREACH(entry, &instance->yankfns, next) {
+            entry->func(entry->opaque);
+        }
+    }
+    qemu_mutex_unlock(&yank_lock);
+}
+
+YankInstances *qmp_query_yank(Error **errp)
+{
+    struct YankInstance *instance;
+    YankInstances *ret;
+
+    ret =3D g_new0(YankInstances, 1);
+    ret->instances =3D NULL;
+
+    qemu_mutex_lock(&yank_lock);
+    QLIST_FOREACH(instance, &yank_instance_list, next) {
+        strList *entry;
+        entry =3D g_new0(strList, 1);
+        entry->value =3D g_strdup(instance->name);
+        entry->next =3D ret->instances;
+        ret->instances =3D entry;
+    }
+    qemu_mutex_unlock(&yank_lock);
+
+    return ret;
+}
+
+static void __attribute__((__constructor__)) yank_init(void)
+{
+    qemu_mutex_init(&yank_lock);
+}
--
2.20.1


--Sig_/zYu_kxxZNYSvNzwqWL33vlG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl9OERsACgkQNasLKJxd
slhnag/+Ms32VzsWhfcvXUNfln4sVViHITgFs5rT7qIizozAxBMeJX36NrhmChrG
MSfEVijkRs9uLz7DN8ekqKVeZtypq3wq4qDAuopXl1jwhcEF/WOK6Ryt8+rGyd/I
n0V/89fmPvp/N1egixVHQCLo4v/6TyEfO6QuqlWHtFCqcuV47kAxkL2KoYFDvZC/
XDY7WhZbYpNDS/ZTm9l5zBjqpfObusBnlrRadmcfcJaI6K53vPSM7EFyrNMS+MVf
uoYYIBnWyydDPxOQql8jmg9AZbjC/cBgGBze5LE4aUcwQXsinS+74Nn5lBuppmf1
s2eEE3PBI8IVIP/x/0roAMa0oBbPi9yqoTOthNEcbFL+dRIJ1AHqWpvquUHOpkzB
LU6eAoJlVDvrYvBd+ZDMkKf7oFILcAkMAeiVCJov+3VfnDcaH/u5+P9jeuEdyvrB
TWee34wHiXuE2FWxM0tuSvXE8PdaguY0bNT9w3xRJ8RsyIsAIl3BhhxRDnkIiH6Q
sebDIOx7zsjut+ZfZiNaVyV9hwwGcvonqLHLds8CYDxn42JV0moN/UIFq6nzJ9E6
iaXWQmpCN82F8J5gm0W4ogdtmG8C/On9fERFMTueKYwYYgnn/vyH22JiCg4AQFL8
Fge5oXpEHZGpI4zhNiRC+r45rJhvlsdBIfyL6jkUBU1vooPNrj8=
=wEBD
-----END PGP SIGNATURE-----

--Sig_/zYu_kxxZNYSvNzwqWL33vlG--

