Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E20C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A77720720
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="bXzkphMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A77720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkCy-0007TI-2r
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8R-0003qd-Cu; Tue, 23 Jun 2020 10:42:51 -0400
Received: from mout.web.de ([212.227.15.3]:37811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8P-0002QF-5k; Tue, 23 Jun 2020 10:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592923363;
 bh=WQjew8LLrt3aWMP88f9M+wX6YZ9r9PowMOGkCX0pAyU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=bXzkphMr3sOhsFlI0T1MxqGd2GMlQc+s/fDx2qT2MDn7it6yAWv3Mo1R905z0F0Oh
 RJ5eCmhsDzQYzEFuG1R2vxteXmZtBHqaosYex1xg7yn+GR6yoFwBGytUoaeSBprXQS
 HfRAEYyYIr1qCI9BUsyihgpEvoL0zAwoRVjq3YXw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.8]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSry9-1jOoqt3mBJ-00RsRu; Tue, 23
 Jun 2020 16:42:42 +0200
Date: Tue, 23 Jun 2020 16:42:41 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 1/7] Introduce yank feature
Message-ID: <e804217c5aea9f0139169f22c01943b4e87db051.1592923201.git.lukasstraub2@web.de>
In-Reply-To: <cover.1592923201.git.lukasstraub2@web.de>
References: <cover.1592923201.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1sBqL_tEK44pnZF+0.SL2.N";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Vl4nklLUS5lBfyNzs5mFRO9b1G9jdX6WmxcaAlcE4KCLRBrX4mS
 gabCHwIdj9jRQekwqo4C0359rxzj5WpQ2xq1RSVFi8e/JmcjeBp+w7JOgJAL4jaDlQNN0U/
 UYfImkDEIiWCqMAVgPAx0RnuDa9VC8H7tdhiTj3hoyt3FKsd6SEBuWUlO+Tns/Clvsi2V7e
 rJVTerGgXUa2Eh1ANbNXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i2CJ/5jf+Z4=:sJ9SsnjGso6svbpBfx4Tfn
 W/H4N2ogGxRl+MWpGGcx1ubP9PtDJnx3Z7y7mi6MFIcjFkkkAMLUVJSanK9iaPZ+ZgnlA0uo7
 uwVyInhXnW+Q8Bae/sDitzkU5LQwOiujU2xvrR4k2uJUFquwd02xPNOLlnbq25jQZLkP/O7jJ
 ZDsbQttzF2g56hAlUjblYL7LqB0kzx7jszNDtWHtbGI2UerNa/e3+Z1uvVnr9iWMi1zBK/njr
 8f+2Gno46wLUMP+ij4ZEES9npf6FdWe3A7eQ++5SPzrP/SQMSMLKX9PDW6klXo/X7LPJPN+Ak
 anso1YY63k7qbM3r0fNziLdxezteVPkHHbADQMWh+BjX85v2cNwGGG92dqYMA98NEp5thlleV
 6Aq7uxEL4GiYiuCbSg7TyCL7Ad+QkpyVuz5SxHKBiZOYa/8LgZ4DgWNvbm3iUV4e6AoRORgT3
 zzdAEuyzS0+3ZmZ354j4fcu3qVdwJ7cm7cHbpmr+sdWpQhbMlJnBi/XTCxC8x3MVGnlbBPv3I
 foIYZhfHj1JchbWj60MfMPAtT5q2vXGaoSMHldjg0+goaeAOlmwYW2GPvyPFCXZilhZ7FyuOW
 C6+2rHVqgyneQrG0Jp0cdNbRIE0DQH2AEuVrBr8H9pwMUKtEcd3HGQ9FZKysNsTL6vZn2UGrm
 decU20z48Ix4FsodpGRT18v9XHwR/2z3GTEIwCiyyYMWQz9I+ZQ1El13RRje75skKLqX89MY0
 oVIbeqbR8tzSedvFZywdML33zaVaDP8cOkSDlilA2EuJK8aLkMgs8/PAnsCf3tTFdFvOLk+VZ
 z3Vw5KpqpVJUkZGecIz2riZ2eVEoEPyFj9qxQyKS/HmRSYtD0OWYTWCfv3d8jtFM3zfNbnSfx
 bdB54qxgthC5CgOGom/gBrbIctRDVa/Q0PzoYCmf0x7f7ASyTYSz5rjOUsj3QkUxjWh5NnJsE
 aUMdffW8DSVckat3VD0Hr+Z3F+1lK7M7C8Q/45Qjk0Df9Qm1JQuWMgRQlk3KkZ+oKju8P7xSE
 UKLdTtGWryav6ytdbokVmltayaNENQ0JSKs3+qCkCLQDopDGvctGSqm7Bq+RgjaqWBA6v0a6d
 sGwx2iaPNGuov3EYU4RqfoKOzY2+sX9j5+2xtNDoCJx+seM2H4XyPuCGwnhxkSGsAg7OtBcXW
 +SwYeEuk3W34bTcyU2VcUoQDbFTjIlWbsnKJae+LikC3LOYrZbBo/g5mrALXi2ZUcVzxCiS0o
 W/937QVWlr2jmW2zm
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 10:42:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

--Sig_/1sBqL_tEK44pnZF+0.SL2.N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

The yank feature allows to recover from hanging qemu by "yanking"
at various parts. Other qemu systems can register themselves and
multiple yank functions. Then all yank functions for selected
instances can be called by the 'yank' out-of-band qmp command.
Available instances can be queried by a 'query-yank' oob command.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
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
index a5a0beb902..794d0afd5d 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1552,3 +1552,48 @@
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


--Sig_/1sBqL_tEK44pnZF+0.SL2.N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7yFOEACgkQNasLKJxd
sljW1A//cqGRdIne4oGwaPvRp7I7g4zAYJvu1u7Xx0h5IAq4Dv7SLl8fzNdlLuOC
iPFd3mQXNOJWn/UKFcaEoKFw+6o7taLoforYNX1EEozazE8biDihMVvJkIKFJ3M2
9v2C1rE6ic3lHSPj2D4qcseIPzB7Ed0JgTa8E6nBZ3cegVRPLbsZMvjjkWnC5iGa
NeWwIpdTmjU5RR0s2ifLyyin0W0qaq1HtcOLJYbEo7nOVDnBV/tb94WoXJsE3WyB
YSKPWPJVFIw2Zygb6tBCz9fdjSVrWdIkOd+Ugl36VD88moWhayBO394jZYoiGLmC
FEXjQi8MgqlHC1czOV5REXZDCtadYYkrs6W0u2HULO9VSMexjJD+le8WPXZIiJQA
AoXaRTqKo35F42n7qBzaucFyHmLyZTnZkCHVknNMNKvO2UPCLXA46IFQbjbsMsUK
AP5y798Q1wuqkug7OJJkTVszZpaDryWRBU49B/DGJLFAPUGHZ68ciSCyTuPI/Q1x
KBzwPPf7LHGCEr7DgdRGmjlPXiHqkJA/VJOpDVSLltbXqwdnWtQXBmtAVgU9LWmt
jDuhjnFxy9//tc+wE5xsjrh6QUlNeetC1QsxQzJ7ZOskKuswYKVz0YgYiBc/WmzW
hK2GnV7d+466UWba2yCr3C4Q/R53zzCYEQ4KdG5HwYgHR29zAhg=
=6fva
-----END PGP SIGNATURE-----

--Sig_/1sBqL_tEK44pnZF+0.SL2.N--

