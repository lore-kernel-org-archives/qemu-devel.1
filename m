Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960DDC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5372A208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="e8V465pn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5372A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1RMf-00012U-DF
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJL-0007bD-5p; Fri, 31 Jul 2020 05:26:43 -0400
Received: from mout.web.de ([212.227.15.4]:39459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJI-0003Fv-Uu; Fri, 31 Jul 2020 05:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596187595;
 bh=e7XrG0q0BggR4NGeAWzNMkAErCEdihn+gE4jYSP5rWc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=e8V465pnppyUEPGK4GWEKL3urJQn5QNNRLAEeQUWYYSbB6uBb+4HKns4AvXUlMXcP
 8I3cZ4XTgwXFmkAbEqdGXyKwwFZSDkJK4Mn5leZni4tjk6g50VotGusHB7f/6R9qnx
 JHL5n8G7oyoDPkXhnlJDSK1lhNdZMpDibjNiwHO8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.42]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LpOKb-1kfkD81cKj-00fDVF; Fri, 31
 Jul 2020 11:26:35 +0200
Date: Fri, 31 Jul 2020 11:26:34 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 1/9] Introduce yank feature
Message-ID: <48e682c12802af768f99a6fbc32f2a163d7f508f.1596184200.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596184200.git.lukasstraub2@web.de>
References: <cover.1596184200.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bUXGgOT1pVO197B9gkCwjnK";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:EmEr73zI2BFlut3t2aFjGkVd+p1oq3kCqhgyzrNfaNGeI9QavkX
 OOv/C4YFP5SHb8uLVij91vnLlbXKfeO0u9bjMfYItVSj5b8oTQuaGaveQESmbrd2K1awZAS
 pWJgMfI44n9Yc1kcYyt4ODAvud8grWaBul5IRgIivONPAXsWdWFp7PV6Tb8n5+3WBbX4DCS
 6+2fpmUuXfffH1uVJR3BA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R/PyQxy+cUQ=:15BeITMb+itL+pMtixCrkk
 Z2OoUrur26MSjnQogPHjHsqIIk/oAJZmA2j0lYTvHWwJjeCYSDHGvCjETW9QLuK49ovkK0DvI
 lFU9WEuIh9GdDexxLxa0ZE+u52W8ViwHe3/pg1z9V4x2++jDDq2JZz0JDfqutQwiPnjbhXiK9
 5umfccqXXF5ge7ca+bizBpSVlLtdtky4vANIIjNmO2pPG/BQvbP8I+804K6FzbcixNSCYtYpV
 1wYIsIoCxXCMS84GJ9YkUQE//IStqYv6IFJ0/fWwtEej525Mx4dbksFTh5SNYv+WUVq98U4zx
 PpcPzjLt1AHwZnYrD2jBX9ZsiOsu9bk8HGh1sGu2zGgu3vi5Gr/pfhQ7bVUN/USMv4toeV0YS
 O/bSj/WYy6gtXEaR3PqnpUBWTr5G1JXekGdzmKExMNStQbs3Bb88HsCYp9ByI07/BRA7FdOpW
 FuJiIl87rYmhkuNSjt/ph3Rl3aF+7FHy7Kf+9RQr6LDK+BiM5kIzcD8Wd0dRziz6TZSzJUO5e
 oDlGViUnkY4Nj5Is0GgA+zy+2Tk0s3wMvy2j373p4DLbTXsUP9ljgoLtQfuBkTW1OnlWuDt5P
 9N5S/aIjaWu/DguSQNRqsRbL0NbgSUTrM8vib8dKHvy4pbDrgW/DpiLAJjbKUTG7DX23aLt22
 WzEEAeE4Kc2XLJZ2/vUswJSadws14npa1Y8/36ZQOrvu81YjUuCQmI+Qn34KzBv6LUDnQz9Bo
 g2x7nErxOnW9xDq0a2CDHQ/RqOpt7iRlRxFhmv5ZyQM0umHaAR0GToVDnbpoXB+c0HS2R4ni5
 DtP6OgzQNQqQvCbfL+8O6L79hZWeKO02DZ8dXagDH5lXrKN0MS4HJng6KTue3e/upMgelvtzw
 Oj6L2X54iNGkWtP4fGXtuTY+ZWebJNYmvz0dpxAiZd4FKYyZYCijnGQ5RY0GnJ8rLG2PsYeeK
 XTzuGNUFg7IlcWm4KTh7+gN5hvOeTRxuO/pUhzzWgpGnEoURVK7ImU+ZFMCP22jRBz+eS3Ge1
 65B9cPawfiXC4D+RE5ZTKyHX7D+5PXmNpIsyZf3g+OSy2FA702WXeynvJkLmefwI+mQiyv6Ug
 8CASvn/wjQgTwEwTpo9YQzFgywMoET4gMoqNHx36lIPnQHv3xS49W8pvoLPc0oXwSeNj6TA2l
 DdHXtU9hQVtJ13o1x3IbPcZV9IUX+ftuwffOd4tf70yBOfTlLjGHUqTX/UUnqbimFO23XBZWk
 Rh8hsqJ/DcphqPYx3lNpKNUDsPMRDAPfaw9YHMA==
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 05:26:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

--Sig_/bUXGgOT1pVO197B9gkCwjnK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The yank feature allows to recover from hanging qemu by "yanking"
at various parts. Other qemu systems can register themselves and
multiple yank functions. Then all yank functions for selected
instances can be called by the 'yank' out-of-band qmp command.
Available instances can be queried by a 'query-yank' oob command.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/yank.h |  79 +++++++++++++++++++
 qapi/misc.json      |  45 +++++++++++
 util/Makefile.objs  |   1 +
 util/yank.c         | 179 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 304 insertions(+)
 create mode 100644 include/qemu/yank.h
 create mode 100644 util/yank.c

diff --git a/include/qemu/yank.h b/include/qemu/yank.h
new file mode 100644
index 0000000000..294094ba74
--- /dev/null
+++ b/include/qemu/yank.h
@@ -0,0 +1,79 @@
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
+ */
+void yank_register_instance(const char *instance_name);
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
index 149c925246..4bd17270ed 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1614,3 +1614,48 @@
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
index 0000000000..4e66d5a2c2
--- /dev/null
+++ b/util/yank.c
@@ -0,0 +1,179 @@
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
+void yank_register_instance(const char *instance_name)
+{
+    struct YankInstance *instance;
+
+    qemu_mutex_lock(&lock);
+    assert(!yank_find_instance(instance_name));
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


--Sig_/bUXGgOT1pVO197B9gkCwjnK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8j48oACgkQNasLKJxd
slgj2Q//Tfd9aaKcsEA7KaYNJ9aFEz1HdsAJATRYThVEYyZpH7ZmbFIqDDJ5WEOk
gjTGgtSfIL4hCaDR2UEtRDMI1sH8nnsJ0Jf7GSdzf/6frNtqton7V7ul6/9eQH4X
k9/Ws+mSvnW9LFDcWivOBAYDp7gsVUOykBsWyg0+UbkNKc8DlGr4Ac4zXg8QXeI6
l3qQGULf96X63RvUF/CMe8QiMI0Y7Rl5qZ9xphMXeTdsP5EuvC+ZdrAPOALSFMfC
Qu8hHuRGtvCqhKMBzYHW1VGx1kUxEc65jPO4ks9iWPMdTENXSVlLON/eQ+/VvZuX
f9E2hgizqsr9tEzmLnKmsnNE4ULlBsKD8qLiT8Jg20o/OdauwBMDT4MIi9HI3427
x1ptPxdSooPIDN6qk5rlSnx3qLwLATyaWjvxJwnqB5iBit09cKb3oSWz+voUSq6L
KP4spv++zX68cecN4N+2WD9nPqbseVGSBxttVzMUAKrEWzGOji5sITxO6Eoj2zl0
ywHT8rmdEPaTPj/OYsNQOKdfQ83KMQrrnyTzsLNYkVoWB00DA5k9jDVwJqhxOunZ
onQ6tEXBP9FsXc7vFyZLoD1G+72kPUVqzz7iM6PV/1fL7oISYVF4crUVgBcemhZZ
6h3mvmiXAXxkqAWKp7CRtWf6NW0S+P7rM7Wpjc2BodPKxDKGme0=
=BBCh
-----END PGP SIGNATURE-----

--Sig_/bUXGgOT1pVO197B9gkCwjnK--

