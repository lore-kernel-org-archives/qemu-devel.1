Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC12C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49CA24810
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="UpYwvFzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49CA24810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqUz-0001yJ-Gp
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqRu-0008Uk-Ai; Wed, 28 Oct 2020 14:45:31 -0400
Received: from mout.web.de ([212.227.15.4]:32945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqRr-0003GW-Vm; Wed, 28 Oct 2020 14:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603910716;
 bh=fdur8Yj1cjXPAAI5Zx1mBgregQ57TEBXXQs5Z9cK20w=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=UpYwvFzbjGdKzd9qPw5p82O26NoeDDi7RX3O3N0LBj8G05/lSXhMREYL3oZJoEjHJ
 SEFkOVp458RdHIrouSX9ddKLnA2co6h1oS/fd5sIGtIvjg4bwKlVU96/e8uGGerwMW
 U3e9S1EKdRj4FO4JxF5CEDLSBkVLrGZCWztK1pWY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.124]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7VZv-1kD8Qd0NlP-00xLhS; Wed, 28
 Oct 2020 19:45:16 +0100
Date: Wed, 28 Oct 2020 19:45:14 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v9 1/8] Introduce yank feature
Message-ID: <7b3b182b6ab1a859a1e9fb4ebfa5ce0a7a441e10.1603909658.git.lukasstraub2@web.de>
In-Reply-To: <cover.1603909658.git.lukasstraub2@web.de>
References: <cover.1603909658.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.nqSp6hLWSBzro6pKyYqko0";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:vViYQkV2dRTE9Y0guTGqsI5711tApXAuxht6Zii1eKLFCzMXcXm
 U6D7lNcuOQiiyEqu9YOAUXQLp2wATJhUQybsHmkTYzLTYn362go7m4RzNsddEGIvqD7psqW
 qPfZDCBgPtzdiOItlTwO9BCH3gqUkNDi5lwt24RBOJ7O8MPyaPrNzPKDlI1o2LszRO27SKy
 pxNR7rt7N1kCOADTMOprQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zXRA6gTk16k=:ATl3/vuUu7Y2DAvovGZ5hs
 mN+33shnF0WN6CFMWf/gQH9acHrsfcb5ACMKuxwJ8Am6elB+VHErwf9ylz3nyMGJCnr1WULWY
 WNoUoU2ACrQCpJa2E+n73dKiQt0hHitNLNvp96e5+j5oSZg5Pw6TR//dDeG63mQVJl5Enirkf
 Gc1ddsJMSqkTrmG4nWramrcXGhjMrfQTjlAb1ZilKT3SaA4zNESVNgiMR9fDkgM33f8ssRD4e
 TYYdyg18UkSh1XQNRUuV8v01ZoHaGWZaffir3OxI8DYy/ocZwMFHZ+J+6iRqfaF8rwzNqeph+
 PGRQ4U4Bs1DxqNqGvkkIkcqbz1zBlG6JSmUhFVmXEFoUEMIsSMk7RHjLOg2lZXLVUOb4AHzlZ
 NVl9CCP5rOY/jcOz3NTLOn86hGLBIRSA3G1bZO6s7e/FrHH0KdSQ/5a5BHUK8zl8L8e/7P7+s
 mchhOo7WhL/il1kPxtM5qXgV0PpzjoTNCkydI27YEZ6E6YOLee7a8iYX7wNX0QNxKOTPpTPdq
 x37sndCNt81F7juHrdA0xNGU5udftwBcIdGpH25pgNq37GLB8afxUj7wCKfN4P8Mamsa5otc0
 I1Uxm3NOx2rB3hnJQdsiX8/k3IC8/69kT+as3yoz6cqnkeNqaFtoqn83fcpDV9Ss0ZqaKdbd+
 zlSdmBaiDlgHGxLrmuIcmaxn6YkQfQfdGj4QfKANXbVfj/wnhTi6+P5nh5l95zd8MTsLr8FpK
 E3mCxKO2tIVZ7VjnDQS4jOMwIhsE8o6I7bXjCHx4VEjU8pLch3Z+VPUovXPYcUfoJJhcUpJWZ
 7V1RqXJh+KleWzlUm/lH5E7IX3+fZu+XN4TpUDs9kNjAqIXp0IhVrMIX7glE8HMNqnA4tLjMp
 fRNBc5mZAJPsXK/98Bcw==
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 14:45:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

--Sig_/.nqSp6hLWSBzro6pKyYqko0
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
 include/qemu/yank.h |  95 ++++++++++++++++++++
 qapi/misc.json      | 106 ++++++++++++++++++++++
 util/meson.build    |   1 +
 util/yank.c         | 213 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 415 insertions(+)
 create mode 100644 include/qemu/yank.h
 create mode 100644 util/yank.c

diff --git a/include/qemu/yank.h b/include/qemu/yank.h
new file mode 100644
index 0000000000..89755e62af
--- /dev/null
+++ b/include/qemu/yank.h
@@ -0,0 +1,95 @@
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
+#include "qapi/qapi-types-misc.h"
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
+ * @instance: The instance.
+ * @errp: Error object.
+ */
+void yank_register_instance(const YankInstance *instance, Error **errp);
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
+ * @instance: The instance.
+ */
+void yank_unregister_instance(const YankInstance *instance);
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
+ * @instance: The instance.
+ * @func: The yank function.
+ * @opaque: Will be passed to the yank function.
+ */
+void yank_register_function(const YankInstance *instance,
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
+ * @instance: The instance.
+ * @func: func that was passed to yank_register_function.
+ * @opaque: opaque that was passed to yank_register_function.
+ */
+void yank_unregister_function(const YankInstance *instance,
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
+
+#define BLOCKDEV_YANK_INSTANCE(the_node_name) (&(YankInstance) { \
+        .type =3D YANK_INSTANCE_TYPE_BLOCKDEV, \
+        .u.blockdev.node_name =3D (the_node_name) })
+
+#define CHARDEV_YANK_INSTANCE(the_id) (&(YankInstance) { \
+        .type =3D YANK_INSTANCE_TYPE_CHARDEV, \
+        .u.chardev.id =3D (the_id) })
+
+#define MIGRATION_YANK_INSTANCE (&(YankInstance) { \
+        .type =3D YANK_INSTANCE_TYPE_MIGRATION })
+
+#endif
diff --git a/qapi/misc.json b/qapi/misc.json
index 40df513856..3b7de02a4d 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -568,3 +568,109 @@
  'data': { '*option': 'str' },
  'returns': ['CommandLineOptionInfo'],
  'allow-preconfig': true }
+
+##
+# @YankInstanceType:
+#
+# An enumeration of yank instance types. See "YankInstance" for more
+# information.
+#
+# Since: 5.2
+##
+{ 'enum': 'YankInstanceType',
+  'data': [ 'blockdev', 'chardev', 'migration' ] }
+
+##
+# @YankInstanceBlockdev:
+#
+# Specifies which blockdev to yank. See "YankInstance" for more informatio=
n.
+#
+# @node-name: the blockdev's node-name
+#
+# Since: 5.2
+##
+{ 'struct': 'YankInstanceBlockdev',
+  'data': { 'node-name': 'str' } }
+
+##
+# @YankInstanceChardev:
+#
+# Specifies which chardev to yank. See "YankInstance" for more information.
+#
+# @id: the chardev's ID
+#
+# Since: 5.2
+##
+{ 'struct': 'YankInstanceChardev',
+  'data': { 'id': 'str' } }
+
+##
+# @YankInstance:
+#
+# A yank instance can be yanked with the "yank" qmp command to recover fro=
m a
+# hanging qemu.
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
+{ 'union': 'YankInstance',
+  'base': { 'type': 'YankInstanceType' },
+  'discriminator': 'type',
+  'data': {
+      'blockdev': 'YankInstanceBlockdev',
+      'chardev': 'YankInstanceChardev' } }
+
+##
+# @yank:
+#
+# Recover from hanging qemu by yanking the specified instances. See
+# "YankInstance" for more information.
+#
+# Takes a list of @YankInstance as argument.
+#
+# Returns: nothing.
+#
+# Example:
+#
+# -> { "execute": "yank",
+#      "arguments": {
+#          "instances": [
+#               { "type": "block-node",
+#                 "node-name": "nbd0" }
+#          ] } }
+# <- { "return": {} }
+#
+# Since: 5.2
+##
+{ 'command': 'yank',
+  'data': { 'instances': ['YankInstance'] },
+  'allow-oob': true }
+
+##
+# @query-yank:
+#
+# Query yank instances. See "YankInstance" for more information.
+#
+# Returns: list of @YankInstance
+#
+# Example:
+#
+# -> { "execute": "query-yank" }
+# <- { "return": [
+#          { "type": "block-node",
+#            "node-name": "nbd0" }
+#      ] }
+#
+# Since: 5.2
+##
+{ 'command': 'query-yank',
+  'returns': ['YankInstance'],
+  'allow-oob': true }
diff --git a/util/meson.build b/util/meson.build
index c5159ad79d..dbda9d9123 100644
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
index 0000000000..0b3a816706
--- /dev/null
+++ b/util/yank.c
@@ -0,0 +1,213 @@
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
+#include "qapi/qapi-visit-misc.h"
+#include "qapi/clone-visitor.h"
+#include "io/channel.h"
+#include "qemu/yank.h"
+
+struct YankFuncAndParam {
+    YankFn *func;
+    void *opaque;
+    QLIST_ENTRY(YankFuncAndParam) next;
+};
+
+struct YankInstanceEntry {
+    YankInstance *instance;
+    QLIST_HEAD(, YankFuncAndParam) yankfns;
+    QLIST_ENTRY(YankInstanceEntry) next;
+};
+
+typedef struct YankFuncAndParam YankFuncAndParam;
+typedef struct YankInstanceEntry YankInstanceEntry;
+
+/*
+ * This lock protects the yank_instance_list below.
+ */
+static QemuMutex yank_lock;
+
+static QLIST_HEAD(, YankInstanceEntry) yank_instance_list
+    =3D QLIST_HEAD_INITIALIZER(yank_instance_list);
+
+static int yank_compare_instances(const YankInstance *a, const YankInstanc=
e *b)
+{
+    if (a->type !=3D b->type) {
+        return 0;
+    }
+
+    switch (a->type) {
+    case YANK_INSTANCE_TYPE_BLOCKDEV:
+        return !strcmp(a->u.blockdev.node_name, b->u.blockdev.node_name);
+    break;
+
+    case YANK_INSTANCE_TYPE_CHARDEV:
+        return !strcmp(a->u.chardev.id, b->u.chardev.id);
+    break;
+
+    case YANK_INSTANCE_TYPE_MIGRATION:
+        return 1;
+    break;
+
+    default:
+        abort();
+    }
+}
+
+static YankInstanceEntry *yank_find_entry(const YankInstance *instance)
+{
+    YankInstanceEntry *entry;
+
+    QLIST_FOREACH(entry, &yank_instance_list, next) {
+        if (yank_compare_instances(entry->instance, instance)) {
+            return entry;
+        }
+    }
+    return NULL;
+}
+
+void yank_register_instance(const YankInstance *instance, Error **errp)
+{
+    YankInstanceEntry *entry;
+
+    qemu_mutex_lock(&yank_lock);
+
+    if (yank_find_entry(instance)) {
+        error_setg(errp, "duplicate yank instance");
+        qemu_mutex_unlock(&yank_lock);
+        return;
+    }
+
+    entry =3D g_slice_new(YankInstanceEntry);
+    entry->instance =3D QAPI_CLONE(YankInstance, instance);
+    QLIST_INIT(&entry->yankfns);
+    QLIST_INSERT_HEAD(&yank_instance_list, entry, next);
+
+    qemu_mutex_unlock(&yank_lock);
+}
+
+void yank_unregister_instance(const YankInstance *instance)
+{
+    YankInstanceEntry *entry;
+
+    qemu_mutex_lock(&yank_lock);
+    entry =3D yank_find_entry(instance);
+    assert(entry);
+
+    assert(QLIST_EMPTY(&entry->yankfns));
+    QLIST_REMOVE(entry, next);
+    qapi_free_YankInstance(entry->instance);
+    g_slice_free(YankInstanceEntry, entry);
+
+    qemu_mutex_unlock(&yank_lock);
+}
+
+void yank_register_function(const YankInstance *instance,
+                            YankFn *func,
+                            void *opaque)
+{
+    YankInstanceEntry *entry;
+    YankFuncAndParam *func_entry;
+
+    qemu_mutex_lock(&yank_lock);
+    entry =3D yank_find_entry(instance);
+    assert(entry);
+
+    func_entry =3D g_slice_new(YankFuncAndParam);
+    func_entry->func =3D func;
+    func_entry->opaque =3D opaque;
+
+    QLIST_INSERT_HEAD(&entry->yankfns, func_entry, next);
+    qemu_mutex_unlock(&yank_lock);
+}
+
+void yank_unregister_function(const YankInstance *instance,
+                              YankFn *func,
+                              void *opaque)
+{
+    YankInstanceEntry *entry;
+    YankFuncAndParam *func_entry;
+
+    qemu_mutex_lock(&yank_lock);
+    entry =3D yank_find_entry(instance);
+    assert(entry);
+
+    QLIST_FOREACH(func_entry, &entry->yankfns, next) {
+        if (func_entry->func =3D=3D func && func_entry->opaque =3D=3D opaq=
ue) {
+            QLIST_REMOVE(func_entry, next);
+            g_slice_free(YankFuncAndParam, func_entry);
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
+void qmp_yank(YankInstanceList *instances,
+              Error **errp)
+{
+    YankInstanceList *tail;
+    YankInstanceEntry *entry;
+    YankFuncAndParam *func_entry;
+
+    qemu_mutex_lock(&yank_lock);
+    for (tail =3D instances; tail; tail =3D tail->next) {
+        entry =3D yank_find_entry(tail->value);
+        if (!entry) {
+            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND, "Instance not fo=
und");
+            qemu_mutex_unlock(&yank_lock);
+            return;
+        }
+    }
+    for (tail =3D instances; tail; tail =3D tail->next) {
+        entry =3D yank_find_entry(tail->value);
+        assert(entry);
+        QLIST_FOREACH(func_entry, &entry->yankfns, next) {
+            func_entry->func(func_entry->opaque);
+        }
+    }
+    qemu_mutex_unlock(&yank_lock);
+}
+
+YankInstanceList *qmp_query_yank(Error **errp)
+{
+    YankInstanceEntry *entry;
+    YankInstanceList *ret;
+
+    ret =3D NULL;
+
+    qemu_mutex_lock(&yank_lock);
+    QLIST_FOREACH(entry, &yank_instance_list, next) {
+        YankInstanceList *new_entry;
+        new_entry =3D g_new0(YankInstanceList, 1);
+        new_entry->value =3D QAPI_CLONE(YankInstance, entry->instance);
+        new_entry->next =3D ret;
+        ret =3D new_entry;
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


--Sig_/.nqSp6hLWSBzro6pKyYqko0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+ZvDoACgkQNasLKJxd
slhKgQ//Ww3chWS+GmCH2DoarT5bKpjNyrqlIBlXzh7QGcUsXbi4vE3PMmKcgirM
CtWnUYzJ/DxM+j1eurx8l5riuEY35TDuHKpn5EZtpcqTxtaVkbYPRWDFUvcFvWep
pSgBhuP9WjMH6VkatJ3fdd6GRQx6Io4kVLsrB/ej1BRTOB+i1MD8QkbTVu+b4Iv4
pnGC3/f8grHWk+vvhYzLOd6fTt3tIfE+OJ+0JOUfhyN3JfK/jdqysc9toIBZbRf/
7AKxooukR0NjHmZKap1uC8IhAfFVHI+NiRVzBP1fD6ZrNK9wxE7xvz+mD4hVK7ZB
SmOcrhtdlMXx9EOQ0R9/eQ8hdLw3gtoYq9kg+ZpHb37yMIZOVRUii4pjEQcgLKcX
emJB/RrBT8rU8y+mKSJ9MQ5yw1xTi9gr5XeI//rFa0U3lgexJZBpUeUxkWQA9Gk4
VZZQ8ZzhKlqnka0T+3FLbzeaURQ7ywbXzyh8OqXyQYLiqPzP3sgBdxrn32pD2wdb
hmg2NlEbC2dNxXMHAolEwAxPtXJ6D/7uxQyJGrQnOt9jGy9PLgugU5aXP10GrRpE
F9h9R0Ix9mChJ0X3JKY0JZ6pyh7H2AHCEDzA2LlrLycixubMrG6dbdoaHjjYcquX
4+O3eD0ONEL4W6kBSrjw+WnqCYbkNIR/kwXQtDvPSWzE3zAqotw=
=UYAQ
-----END PGP SIGNATURE-----

--Sig_/.nqSp6hLWSBzro6pKyYqko0--

