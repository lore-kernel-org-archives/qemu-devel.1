Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5A9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE452076C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Dr4wLiuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE452076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2s5k-0005C4-K2
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s2x-0003Tt-M6; Tue, 04 Aug 2020 04:11:43 -0400
Received: from mout.web.de ([212.227.15.3]:40871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s2v-0006YQ-ED; Tue, 04 Aug 2020 04:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596528695;
 bh=n3bcMhJUMtsuhIlemqKrJB34futb6YIRpTnSTeJBGnI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Dr4wLiuXuzomvgw/qkCKoZWFu6fAY26EbnWSF23e90REUX44mGxSaLa58edhaxCg1
 4V7EeFxXYg8xAZCCVi1nJQdcoY7WGsqUXMN+KBnoY/K8BWntWi0n0H3fMEZE2n+wxE
 LWkuegoFY3EuFCsKhahapPV6WuxP2abnBeNPlhSA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.220]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhFlm-1kh8o11pNy-00eM5N; Tue, 04
 Aug 2020 10:11:35 +0200
Date: Tue, 4 Aug 2020 10:11:34 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v7 1/8] Introduce yank feature
Message-ID: <0092d4fe5f64078a18db3790c46c508416dbdb6b.1596528468.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596528468.git.lukasstraub2@web.de>
References: <cover.1596528468.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cNvt2/QeAA5ULQSLCtEiViN";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Es88qH/Aqvply2anQKFgFbpXzprz9NwL4B6hgl1rTb5kN30bLgE
 oqL31Igh9KVjqNOjcr3G15p9x09+4zx2KP3IK7SviT2Z8V/J4tm+nHLzdGl7QjA5eQLfqTM
 5Ah0P8Gd8AgW5uhk1V9zDZ3PjuDm4MwC0Nxn/j0KOd+EAW/XujfP6QuupEi1SPq6IgUVl2f
 2QiSwrJtYt/wf21HD9/dA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8THhKp3WRXE=:nxZTBFgceZf+bMeyaQrgT4
 4h4GiDSNvfJNNoFEfQJw/MW9HDP0876ew/AUYpQdZKSuwxJij/4Mk9BtwetmN3Qg73/0NkSCH
 XbgfhaOsJtCNUOHvLhuzAl3yXhdeq+qWcjgGyH+RwbTdse8QWKmgz822tdd+sobfscXzKK0HD
 I9D78cc2efzviSRe8sQE4uU2X4FEkU6v5CE+Kyyk/dq31OvYdLtNQvnRUYBC1Frr24W+HqGic
 9Z0Gb6rA9SPb5NwpVFuBGiGh+mx9tTyqnhyi4BbG4RUADn5XZI9ykA5guwSKiWwn868qJujEf
 n8RO58/3IhMxs3EV/TBF6kyWWAmptaeQw1KKqzjo6fxj0pxh+Q2MKlkPrsKS3DUk8fWyD/GcD
 bVGDOrEF5RV/fH8W6RK+8btRmnG0OO8/V/uyvlJeOS7HGn3Uli9PyRh+HsevtVRIr/e7DHjmS
 9RzhV5q3Gm20g6eRU70jY+RQo85stF2CJc/YVNNdwzwIFt+to4/m9rWnqzfb/O15d2EFaMrXe
 5ta9UKo/K5efMV1uKd+YrDk5KG5W88KQArxW9frS2bVTsIOHk/OOmkxJM2mdrcuBZ83ASrhhN
 rVcXYmhP4tiWzRy1YCF4yF/ZeTkz15vfV6yKtWVYAUyX5wIkTB0QI5ST38730Wx6c5UNJkRpU
 7ueyIce3Y2TWNJhOizG8AVG4LmePLSy7RCD6q0OWI00VEScnGt0gLI1Oh20jnR4S6TuGkaVrf
 zNZzlC5AA8KNZduxfuux0nIt1h+8ttgQRp2A1vZ13I/9RJyl+JGa8mb/7D/tl7iazZuwTK4sB
 La6xb4hEbKg4mo4/tvqLPbMA8boSQSh+C1xQZ1CqBmf6NpAuacUS7H6yXiu7r0SxROxed+XVZ
 zxr1Y1khHVHwK59bUZ5u46sTeGkgPGBM36hZxfWmu5BaCHjv9T7jLQF86iO/Zc52dXWQSwYdU
 MgM0XH1ZIw+Eapdn+FZKiK9ob45M73sRBzlmcAp1BqP4kxsh2faKq52etwykhe4HycHr69mXX
 AI5GsujyOUOdCic7wOg9PlGE7QTq6IshomrBeddh9KttJVul0o5bSq92y7KLDo2bhZrx7Kf5B
 HxcyfQsr4TvLmTOfEcVQ1jRYwwq+rk6rwo0P6NsTDil4L16mp0T1jIBrG37C8TXXgJkkBANFo
 AAILCiljug6RRuRy34g4QS3t1tYQfjA3BdSqVVOSN6Pl4mVMbCVxijNyi35Z3VERRWfPVcDdH
 khrdkF4+T59YjvQ+3eMG3/npOHN6tDo8zvy/5OA==
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 04:11:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/cNvt2/QeAA5ULQSLCtEiViN
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
 include/qemu/yank.h |  80 +++++++++++++++++++
 qapi/misc.json      |  45 +++++++++++
 util/Makefile.objs  |   1 +
 util/yank.c         | 184 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 310 insertions(+)
 create mode 100644 include/qemu/yank.h
 create mode 100644 util/yank.c

diff --git a/include/qemu/yank.h b/include/qemu/yank.h
new file mode 100644
index 0000000000..cd184fcd05
--- /dev/null
+++ b/include/qemu/yank.h
@@ -0,0 +1,80 @@
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
+typedef void (YankFn) (void *opaque);
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
+ * @errp: ...
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
+ * to the yank function as well.
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
+ * yank_unregister_function: Generic yank function for iochannel
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
index 9d32820dc1..0d6a8f20b7 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1615,3 +1615,48 @@
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }

+##
+# @YankInstances:
+#
+# @instances: List of yank instances.
+#
+# Yank instances are named after the following schema:
+# "blockdev:<node-name>", "chardev:<chardev-name>" and "migration"
+#
+# Since: 5.1
+##
+{ 'struct': 'YankInstances', 'data': {'instances': ['str'] } }
+
+##
+# @yank:
+#
+# Recover from hanging qemu by yanking the specified instances.
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
+# Since: 5.1
+##
+{ 'command': 'yank', 'data': 'YankInstances', 'allow-oob': true }
+
+##
+# @query-yank:
+#
+# Query yank instances.
+#
+# Returns: @YankInstances
+#
+# Example:
+#
+# -> { "execute": "query-yank" }
+# <- { "return": { "instances": ["blockdev:nbd0"] } }
+#
+# Since: 5.1
+##
+{ 'command': 'query-yank', 'returns': 'YankInstances', 'allow-oob': true }
diff --git a/util/Makefile.objs b/util/Makefile.objs
index cc5e37177a..13faa98425 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -45,6 +45,7 @@ util-obj-$(CONFIG_GIO) +=3D dbus.o
 dbus.o-cflags =3D $(GIO_CFLAGS)
 dbus.o-libs =3D $(GIO_LIBS)
 util-obj-$(CONFIG_USER_ONLY) +=3D selfmap.o
+util-obj-y +=3D yank.o

 #######################################################################
 # code used by both qemu system emulation and qemu-img
diff --git a/util/yank.c b/util/yank.c
new file mode 100644
index 0000000000..b0cd27728b
--- /dev/null
+++ b/util/yank.c
@@ -0,0 +1,184 @@
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
+static QemuMutex lock;
+static QLIST_HEAD(yankinst_list, YankInstance) head
+    =3D QLIST_HEAD_INITIALIZER(head);
+
+static struct YankInstance *yank_find_instance(const char *name)
+{
+    struct YankInstance *tmp, *instance;
+    instance =3D NULL;
+    QLIST_FOREACH(tmp, &head, next) {
+        if (!strcmp(tmp->name, name)) {
+            instance =3D tmp;
+        }
+    }
+    return instance;
+}
+
+void yank_register_instance(const char *instance_name, Error **errp)
+{
+    struct YankInstance *instance;
+
+    qemu_mutex_lock(&lock);
+
+    if (yank_find_instance(instance_name)) {
+        error_setg(errp, "duplicate yank instance name: '%s'", instance_na=
me);
+        qemu_mutex_unlock(&lock);
+        return;
+    }
+
+    instance =3D g_slice_new(struct YankInstance);
+    instance->name =3D g_strdup(instance_name);
+    QLIST_INIT(&instance->yankfns);
+    QLIST_INSERT_HEAD(&head, instance, next);
+
+    qemu_mutex_unlock(&lock);
+}
+
+void yank_unregister_instance(const char *instance_name)
+{
+    struct YankInstance *instance;
+
+    qemu_mutex_lock(&lock);
+    instance =3D yank_find_instance(instance_name);
+    assert(instance);
+
+    assert(QLIST_EMPTY(&instance->yankfns));
+    QLIST_REMOVE(instance, next);
+    g_free(instance->name);
+    g_slice_free(struct YankInstance, instance);
+
+    qemu_mutex_unlock(&lock);
+}
+
+void yank_register_function(const char *instance_name,
+                            YankFn *func,
+                            void *opaque)
+{
+    struct YankInstance *instance;
+    struct YankFuncAndParam *entry;
+
+    qemu_mutex_lock(&lock);
+    instance =3D yank_find_instance(instance_name);
+    assert(instance);
+
+    entry =3D g_slice_new(struct YankFuncAndParam);
+    entry->func =3D func;
+    entry->opaque =3D opaque;
+
+    QLIST_INSERT_HEAD(&instance->yankfns, entry, next);
+    qemu_mutex_unlock(&lock);
+}
+
+void yank_unregister_function(const char *instance_name,
+                              YankFn *func,
+                              void *opaque)
+{
+    struct YankInstance *instance;
+    struct YankFuncAndParam *entry;
+
+    qemu_mutex_lock(&lock);
+    instance =3D yank_find_instance(instance_name);
+    assert(instance);
+
+    QLIST_FOREACH(entry, &instance->yankfns, next) {
+        if (entry->func =3D=3D func && entry->opaque =3D=3D opaque) {
+            QLIST_REMOVE(entry, next);
+            g_slice_free(struct YankFuncAndParam, entry);
+            qemu_mutex_unlock(&lock);
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
+    strList *tmp;
+    struct YankInstance *instance;
+    struct YankFuncAndParam *entry;
+
+    qemu_mutex_lock(&lock);
+    tmp =3D instances;
+    for (; tmp; tmp =3D tmp->next) {
+        instance =3D yank_find_instance(tmp->value);
+        if (!instance) {
+            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+                      "Instance '%s' not found", tmp->value);
+            qemu_mutex_unlock(&lock);
+            return;
+        }
+    }
+    tmp =3D instances;
+    for (; tmp; tmp =3D tmp->next) {
+        instance =3D yank_find_instance(tmp->value);
+        assert(instance);
+        QLIST_FOREACH(entry, &instance->yankfns, next) {
+            entry->func(entry->opaque);
+        }
+    }
+    qemu_mutex_unlock(&lock);
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
+    qemu_mutex_lock(&lock);
+    QLIST_FOREACH(instance, &head, next) {
+        strList *entry;
+        entry =3D g_new0(strList, 1);
+        entry->value =3D g_strdup(instance->name);
+        entry->next =3D ret->instances;
+        ret->instances =3D entry;
+    }
+    qemu_mutex_unlock(&lock);
+
+    return ret;
+}
+
+static void __attribute__((__constructor__)) yank_init(void)
+{
+    qemu_mutex_init(&lock);
+}
--
2.20.1


--Sig_/cNvt2/QeAA5ULQSLCtEiViN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8pGDYACgkQNasLKJxd
slg3zg/7B+renSS3D7WPrjnMPARgEtYDm1wQ6sDgOED0eq+KfUn09yhg/vDXIxOC
7muHlg7AqkOyZs3IEkyE4C03wTwi2ED0UTx8H5lrHisMs9x84R/tR8aqmhXmaqb6
u41izjUR4/gphToLVibxfXjU6nOsiWQ8l3mvWK50fuZBIIRo6UaZV/x2RxqxfXua
Thz4FbQxfqYgcqeWhixnVrVxPC3+JvVzGwKOVp+cEA83n39is8LTQ8p3RPu0Hz1w
ZjCsX959+NQXSqiHI4Y+NbxhWc/gzPHG4MSY0+UcvPObVqq58S5eSXQxnPVSrUIb
91SOcgeeP1QPc4BtYNC6Rh4kZdppydYICy6aS8WtmdNBiheoC/J3K/KsunjTVWc9
QEbggZIQlaUugnSGCuQ8PD2uhiFhxebnzTui1ehaLf+EW4fZwZhEbSSKM6e4g+nE
vIGwv911fJRstG3FlLZZnqLlu5hFj/geTWq21l72inlZDaXr2jpR5QLAkUTWDur7
3zNxP/B1kIvDZlpb09gEqM45AIESnlYJkHnEFx/Ehn4X2qNIlzUlbK2E0dFMEhKg
WRkakLtTFq3YEm4/ofPm/qKpxxmuzMXZJWuJvneruYDSNMidmHMNnzj3WdYkZxZB
/IpVJwtYITDYycUAtjkFlLL2c5FSS0qSsu8SAFBmdQoc1+5NR1Q=
=vVSP
-----END PGP SIGNATURE-----

--Sig_/cNvt2/QeAA5ULQSLCtEiViN--

