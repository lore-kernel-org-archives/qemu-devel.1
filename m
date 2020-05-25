Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2575C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9997B2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="iGNf9bwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9997B2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdFSz-0002CX-LX
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jdFHC-0004ya-KV; Mon, 25 May 2020 11:44:30 -0400
Received: from mout.web.de ([212.227.15.4]:43089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jdFHB-0006cj-ET; Mon, 25 May 2020 11:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590421464;
 bh=MpS5nTcWOHXIi2EaTcyTwqG+3V2LQAXwFT5hRywBgQQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=iGNf9bwRQLIqEP1Mj5Il6TNmFkN7K2SrudELejOFb9rOubqNyjeZZjOaPC8cSRkLf
 03+J5ZH7BwsR3RdegRXlj1GjFApqipt8ohS5z8WJhLXUCj8p5tFiS6NlUbi94mntFr
 mJK3U6PV5hPaHx1hnKGr27fPioGYN+c0lBBHKqJI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.22]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lu5BO-1ivYBq1dcU-011QrO; Mon, 25
 May 2020 17:44:24 +0200
Date: Mon, 25 May 2020 17:44:23 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v4 1/4] Introduce yank feature
Message-ID: <dc2724aead900db8fb3bed0a066f7c7e2654edb0.1590421341.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590421341.git.lukasstraub2@web.de>
References: <cover.1590421341.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5+G_vpkG.hfj4LxfLguwYAj";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:uO5EXCVTxC9hgMvxGWeRc3B9toqiS8jW+mdam3UStknHQyNmHAE
 ydPVyXeFCU1Ijho8B/Z1Y004SxezGBwnoq6CEKrn4b0SNNzwBXR7M7Ku/Xt0SeQ1lmoDTGG
 BjcQJy2djT//63EO7ww9bClnc0B8nq+3hhzAmY9Em7BjKZqbuDc35oECJgRTKncGLm6IyBb
 uha+AyzmQe66XIgIOdt1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qc8KxK+S/JU=:6juDCBc3GNi9MIwJYGH8Ly
 SyzPFRf+rPgFSt/MDowJVR6VDQIV40reqPf8WAo6yC9goyPqKYBAjKlAmz+3t36ELqna+rihG
 dY8lJicPrgD02k2wSuiY9eqjBJLbi18ZxyfaB6tjU+Y5wGSOUrvcjRFAjKAlVnlIoJ8KlZmuW
 bstfAJHtQ3D2SfGBkT8SjlsLJ4J6aNmdAxEdvmd3j7iFGXazO3v39tg1ZSqV/y4oY4NSQ9n4t
 QWxwcb4FJLbRy9PjYEYuUyVSJLT/3QtbUsY8JiMRcPfbIhS2pitjuUmkFvRzyB3N87zwT7o8T
 Ncq87GL1detdHFuKepE/vSyrlA57WtRh4irtfGXL4bDAR0TogA1d8cXScm9UqwKzltRhe5hl3
 lMmx95DudzsYP8gvulkhaycayVMAu6aIh3aDXL8VoqHWFzQ7k45KZ6T/Avu/H6E5EQrkm6YT0
 MfYF876ep+LgpUkVBo8nUtKUGVOaKE4T5e4pDHWO7/m6vJ7mEipNqo2JrMydIn2gjIqcAkeEP
 LI3n1ZHHLexurwlj88EXBZ6XjOxNUCFP6LpLngcxaOjJRjzcll++qqB8NbX1f/G2Ih5r0GhZJ
 h/Z63B6aZcjM67YJAC7L4dOpoKT1/QzzWg43Rz3T23Ojm3fhWDIVCS3/c6veVH8oPoYV5BjKh
 n8oJAC427txAWEmcIvNViIhVSSRiMLJbK+RqbWNliBH7krHjn5wJnT0HbHiUCkZkmgbg+FzpR
 kNcWuD/MYSCakfg+w0bsngoGZDJQth7JK/JjFU0DVGGOdyPOW2P+504spOVq6o2kI4Htq2rby
 qotYpngfXPHqhvqPSsjeyF5yzjgdT7lO6idlsftGYRpXbRzGO4XQaac6kqNnDmXvkKu/hrOlB
 Sl/f7dtrcIMtpGfgG9liheRaHgY+ODu9BcV1KpCliYrLMbKmmsiLxl8YMvVzWuexylYtcQe2+
 p7AtnEQf8+wFcHZFMsUHp7bnLDfswLdrmT72nMoNWAQi7h4dVCKtC4B8mkjPiEsnVrdBHpkgU
 WHrN/oi8Hlq6cYsw1F55IhvAR22XYO28GL6XSV/GLoPw1i4tqQvNmCcybB5lwyFFAyIsCuuPI
 4FBHbuk4QyOlU3RKA1abq4j7bUPgIp5lEITkFDAAHu8HS50Bg0hNOn6/3ecB3Q/IscXXMQJWD
 xrfvn7fUha8+OJ/y7i+LQTsWNsmYwjZZEfA4v+zP98RfZmxOC312yBbRBZ5Im/CN0CQEhnbDO
 ebz2eAL44MSJMyNTj
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 11:44:28
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

--Sig_/5+G_vpkG.hfj4LxfLguwYAj
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
 yank.c         | 174 +++++++++++++++++++++++++++++++++++++++++++++++++
 yank.h         |  67 +++++++++++++++++++
 3 files changed, 286 insertions(+)
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
diff --git a/yank.c b/yank.c
new file mode 100644
index 0000000000..36d8139d4d
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
+static void __attribute__((__constructor__)) yank_init(void)
+{
+    qemu_mutex_init(&lock);
+}
diff --git a/yank.h b/yank.h
new file mode 100644
index 0000000000..f1c8743b72
--- /dev/null
+++ b/yank.h
@@ -0,0 +1,67 @@
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
+#endif
--
2.20.1


--Sig_/5+G_vpkG.hfj4LxfLguwYAj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7L59cACgkQNasLKJxd
sljPmg/7BiKgsvpZmYRc8+8ga5jxgETmLcZatq8n6+mog6qhwQkOyxepldcsJRUY
C1bwQJ7Jnr7mm9pHT1FnfMM/q5/jqM/EiitS1bMt4q1BMa2tYFl9VVVQ6/IS23nX
0e0rhcx/6gnxouWbrIChQAvTrMVHtk6U2sd1UF1pO7gzJBEO9pz9Nhm2HXubnpek
WFVSCUBDPVS46b1mn0nnQNdnaG5/0ixiITWj7uQWOpZWmunFKGt0zQYoP4xlXeqP
9QW7KDbih/hbkLeBEvcdmigZR2gshOSFcUO9ZDT/tjQnAJ1AYGNjKSL0twiVP7cA
+vbz6GzBkzMY5GfhrTLUrf5UaD+UmP9rN4dBPaVyDA65iWl8R7/HdfQjamH6Bm4E
ICoUqNhYNVYTjf8cajbIagPLss2IkW746iDPvliVmxS2TPexCo0G+U3cVwRfUnjP
Agdz2DkHZcKSyyOQop4yjif6GvkJX7BnZQr4tZUzK0+8TI3ocA5jiD5cwbKFkC2o
6Jt6a1yjjFDX3JM3RvKGsmNWejVvjaaOgQkSLMumtulINXPBhr7I9hgtGq+kz2MF
0lPaZPzRpfvQx8PXDoTZs/IkGMV1aoUABzMmg2Lm/7m/SG8NBiuFe06qub1TqSO9
sckTNESfMFCdwCO1GIjiqp9v0jD5QU7uMaTzFIok7ATO1OfKEWg=
=3/G0
-----END PGP SIGNATURE-----

--Sig_/5+G_vpkG.hfj4LxfLguwYAj--

