Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FA7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22236207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Ms1jlobG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22236207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbVyu-0005oX-3j
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 17:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVuP-0002Gi-CX; Wed, 20 May 2020 17:05:49 -0400
Received: from mout.web.de ([212.227.17.11]:51459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVuO-0002S2-4a; Wed, 20 May 2020 17:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590008742;
 bh=tqkhTpmFcfXP/udx2L1FFDKOb54iXy6N2msQCYMji5Y=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Ms1jlobGBOHIjoUuD2sCRdDMWkdz8UtsEP0LOKhBoIOACAquLgkDK9db3HmFj/8Kw
 1wCY9xYbQ/5V++/D40iyesHJAa4eUiX+JOMAhz3lao9d2jIEGXNm5FHkzpo/7vy4fa
 94F7z4kfd3NlSn2K3dr2I0E6WTARwkev1YtQDALA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.105]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRCnT-1jUBWV3meN-00UWX2; Wed, 20
 May 2020 23:05:41 +0200
Date: Wed, 20 May 2020 23:05:39 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 1/4] Introduce yank feature
Message-ID: <20005a15c708fbda983f9be602c55fc0b1979a18.1590008051.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590008051.git.lukasstraub2@web.de>
References: <cover.1590008051.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Uq9WSy+EEtHGcXwwYRvj6V3";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:YGPfmkpSDnW8lNP4O/ZXcylaYIeQqOBkBTY+EERF6pj/7GGo5d3
 zAD8nu/K4eSW4U3p+aMYi2AKxhbY9BgTk98SSAVdR2tqbgilxoLKx77fGQUQO3ZiNgYzI33
 mPOAUzp48e6z1xmaVbqPz8qdzsQD/ztzwFlvhwXLm+d7ByBnldL02cvDzhUslawoQLCFa0Q
 roEkQxL/0Oi/as0xRpVXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ShOSo1su23Q=:LTyuxCXuKUHicytMKr1HX7
 xOlBkbhjLRW3GjscR0nLUV6X2Ag5HWQ6xYu/TDsnEsJCyiU3nSQ+RmWuCNL0EJIhWennvlfuA
 4adD3FwgU1YDWencb559v+WFJKAo7ac+Uvv4BXwPP03+kmiJu44YIW5GsNjn25M/hqXIRGjXH
 3ZOzOVD8HJTK93j0T1nKWSNdv9+FYzLtZk7rUQ044S37Jk3JAeyibOGqhDH28CxGML5aDmWCI
 5vWjJM0XESKNdHxusQdBwKrTmScuzttrkNQWfEjFIWq/Ij5vRPfB+7qbACFIfQNp/rbwMbE9R
 V1KFKTSNzJZynZQTCdE7bHI4qEc/1+Sb2L5dWVreXDBsdrZplbNiE8x9+Ysv/Qm5fCuF+N4aj
 RsPPPwcVwTaiyEZ3agoK/04MxVEVsjZQHwfzRwcWQZ6kLnlCmBxqCtMOJfVo0a20/6UyxOQLT
 V6J3wJcN/duR8532XzuGE0Jqq/RLzk29BhIJyig3bHsrGVL+OZjkeX1FKKP5FzA3fuIXIAF2D
 Tv+Xc8ZtMBFO+DGYm10341DX3QJokPvKm9sFp5BzCeD2Ij+IznBl2J2GQ9P9VLy5vxLN0A3Il
 6yAKi903+/G/ZsqbAgXZZhlSVAmr57mo8Bs7v+cs43hmlALosHN75l7tWmA6/P9Gi0cyKZmEl
 BvK3nGc9tMGm6uWCrRrM/YA7vOEQ8sEFNZSQNPW9QmFyWDO3I2qRHni3Z/CFnuwjertX2oBmT
 q1FwQWu/M5GB8S3zxvFWb2R4NkjLgYfk6XOLgSvAywa9Y69M2vD4B0c6xreMW+Y0Qe3rWbx6f
 v0CTWzeaA4uz4xtEZUlVP5bnDwpBsNx7kQJewtN/SsKifO7l2mbvLluJtBcOQJ0TgPTmPulGn
 AHEeUprC8+LhX34HtrXhyilFJRRUmTj3I2ZrV5Hww1S3uXrYDh8GTNiXhvsTKQgjN9QfOVaio
 sYtlr7GPl6+e0+58fBs6J44ploRQjJhvr0xwKdYd5i35L1ilDZBi2OgcrgUsmyfkJ3qTT5p7Z
 itAK3rpULjccKoB7j3NiA7onJSPubRoVUAk2NKUNOXIUuwiDZoPumELmZCFR5+Fysycspbn2x
 kdNS34dbYNgG0RtELlstkyUvl7t61/6yWfvhLsBIy6/oINYNPOT5fSmMGrhXM6IF8bB8GRJjc
 8CtI64pmeZyTJ8CjzhpNI4y8Vkre+1wTu1b24+biEJYEM2VQdj/aKOP9TIijobAWumrZXdapn
 H/sMGL++pvG/qpTAp
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 16:42:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--Sig_/Uq9WSy+EEtHGcXwwYRvj6V3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

The yank feature allows to recover from hanging qemu by "yanking"
at various parts. Other qemu systems can register themselves and
multiple yank functions. Then all yank functions for selected
instances can be called by the 'yank' out-of-band qmp command.
Available instances can be queried by a 'query-yank' oob command.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 qapi/misc.json |  45 +++++++++++++
 softmmu/vl.c   |   2 +
 yank.c         | 174 +++++++++++++++++++++++++++++++++++++++++++++++++
 yank.h         |  69 ++++++++++++++++++++
 4 files changed, 290 insertions(+)
 create mode 100644 yank.c
 create mode 100644 yank.h

diff --git a/qapi/misc.json b/qapi/misc.json
index 99b90ac80b..f5228b2502 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1550,3 +1550,48 @@
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
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 32c0047889..5d99749d29 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -112,6 +112,7 @@
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
 #include "qemu/guest-random.h"
+#include "yank.h"

 #define MAX_VIRTIO_CONSOLES 1

@@ -2906,6 +2907,7 @@ void qemu_init(int argc, char **argv, char **envp)
     precopy_infrastructure_init();
     postcopy_infrastructure_init();
     monitor_init_globals();
+    yank_init();

     if (qcrypto_init(&err) < 0) {
         error_reportf_err(err, "cannot initialize crypto: ");
diff --git a/yank.c b/yank.c
new file mode 100644
index 0000000000..bfce19185e
--- /dev/null
+++ b/yank.c
@@ -0,0 +1,174 @@
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
+#include "yank.h"
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
+static struct YankInstance *yank_find_instance(char *name)
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
+void yank_register_instance(char *instance_name)
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
+void yank_unregister_instance(char *instance_name)
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
+void yank_register_function(char *instance_name, YankFn *func, void *opaqu=
e)
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
+void yank_unregister_function(char *instance_name, YankFn *func, void *opa=
que)
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
+void qmp_yank(strList *instances, Error **errp)
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
+void yank_init(void)
+{
+    qemu_mutex_init(&lock);
+}
diff --git a/yank.h b/yank.h
new file mode 100644
index 0000000000..f01b370999
--- /dev/null
+++ b/yank.h
@@ -0,0 +1,69 @@
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
+void yank_register_instance(char *instance_name);
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
+void yank_unregister_instance(char *instance_name);
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
+void yank_register_function(char *instance_name, YankFn *func, void *opaqu=
e);
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
+void yank_unregister_function(char *instance_name, YankFn *func, void *opa=
que);
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
+
+void yank_init(void);
+#endif
--
2.20.1


--Sig_/Uq9WSy+EEtHGcXwwYRvj6V3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7Fm6MACgkQNasLKJxd
slhK5A//QHB0Uhth4ZlChlBTMDRBFz3uyGYOAaK1mnB+hKuFkMx/j88c497nQe5M
X6GN+SFnwvIrFvLERGwnwNlwGheVFabqjBWj3SXHJFQSciuAfV7T3U3oPL8v2uyg
ZOvatLR41pW2WetVko0JiRvyOfxmf10eBwk7I8jnODCCDpD+yQ59L/lTVB/MoHK3
Fb+05KWh/AlXtClqvI0x0Swf8ihRPto5pddPRZ3Qke4yggQw4v3O78uJsxzZbFXn
JGaR3FtBkDVBTJ4q0I+6x5AjzDNbcRokJnyaTzVkjPMKYPsWi2ULRvbpssTw3w6L
TQI42cq9CKTM+j1mm0vMpXjemR5WIN3pdC4k4q9TAksgVvmjqDpbXbhdguk6j3gp
DJ+Nbv1/ietTpBBLYo5BbPIRN18yuniDdhhJYz3qMrBkUv7NrHqZaoJ54HJd3Q6X
4AyvI4fBEP2uO9KhQt9hT179uMkOx1KP+lFDzZUZ9Gp6lvC1fT4bnSO+9NhsaHOp
SK9rCQVCGJOLJVoYkdcBPKWia+fxjMu5jrH58pZgPPf+kIXkWg3zVVMlRDf9EfIt
65tr9M4oyakdx6CMpSNJqcML18gZLqJ9M4N0LapDxRZKDacm/yvDv8UcJH326LPe
/1NkRctGw2m3T0EWuKsojHmff5tpvEOJhwSP+NM/jWa8PW66X7Y=
=PyAF
-----END PGP SIGNATURE-----

--Sig_/Uq9WSy+EEtHGcXwwYRvj6V3--

