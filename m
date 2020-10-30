Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EE5C55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC25B20725
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YQIYX7XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC25B20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXUe-0006P8-I3
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXSv-0004R8-7E; Fri, 30 Oct 2020 12:41:28 -0400
Received: from mout.web.de ([212.227.15.14]:42949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXSm-0002z6-8h; Fri, 30 Oct 2020 12:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1604076070;
 bh=oR7eWk0m4L2PKomamyzxI8Kt4wkjcH6V3b2Zzh0NqeI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=YQIYX7XDv1y8tozm6cOsKvowuokGfEogdmk8EOzLN9LSsUw/WtWnHGdsgtnW2TnDs
 cqGhO0OXcugIMVwq6rxtfzegrDPHA/nkimCgIfjaZGbYtYQdxxHHoVlHG0DsqN2pbD
 eiVzWBVIejDLfQyXHh5B+a+T+2sLCocR9d7uBiEc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.100]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79NA-1kIApe0IJQ-017LWi; Fri, 30
 Oct 2020 17:41:10 +0100
Date: Fri, 30 Oct 2020 17:41:08 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v10 1/8] Introduce yank feature
Message-ID: <20201030174108.1c88195b@luklap>
In-Reply-To: <cover.1604075469.git.lukasstraub2@web.de>
References: <cover.1604075469.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XmaH4+VQaZdzDZ_MY23hXLm";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:kXSGI1mIsEvfRuqdVE1BXzhaMa4EOzibVz0C7rDVDtapXMSPxNN
 ooM5OyCaoceMdU33ABMtE0rSauK3DSqV6aqnz3rMw0JgIobzgvFROQlehLaK/d+HIGkoKY0
 a/SUNA8gFPCsw4RWtrAN5YNenLfgSxiVVngC6e947I4NH136maDyhZjOErvZCCNCenxIpyV
 2IXr2Gwm5vIURhulRzyaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CU3cQd23/0s=:oUtbNbuLHGz+s+nvKIdaz3
 /vGRy553jEeBUE2ekHRiW9HroaNTZWnrZjtubcnXj6oj3xHMKwMwGacUqtPEQIFkglN+mpSqP
 ExvrmLgAgV+o1UN3ql9kWX8sx7cpazKYrTR4kE2aIAtsjf7WNNwNwo0UF/q5yBIpLZYW68ieZ
 mkcHJAv8ZDlEMAI5n3YkmxMnIPPQNKP1ehMc7lW5+oKBrkW9OIsr7mdIiiDXqzDh873QNFD/7
 p8Hxa2bFA6VtSdE3g14gXUVb4bbAnQ7LyuC1Cmt2E0Eh2xKwhQ5UxK/CXf5XPrKlZ1cM3jrM3
 oqyXAx310BgmlDPpjk5RCAelqND9SQMgkWKFjEuXEXD+ozdpVqDQhsFFwzKcMhscWF5tM4KlB
 aKbapPLkOsNtGbvzWnX9Fv4MAcQd/FY4AZZrXakdhqjPGXVlg4Q5Jft4va3TSr8SeF80g3bMT
 +XsKuN+KXx1/KHtE/oR9URIjrL/IomFfM60nvOYjx7a7VIeZaGnYCGwG57B3/3qiniQ1WeFIi
 yvOElnDNskM56nw10KAdkzPz21+QRnQ4isa39UBnrgj/UQxfcaMpDkh+pwXvdjkrkkUGj/eKR
 NxepElpR4CSVkTHs1v74/eT+/ecM19s+tnDtJk+EaMATLBSrizBUhH0BFFUeVMAwfvm0YhSo1
 zjeksSjt3N95OWWJeh54lU5/KGiffRepU49H7VhbKOipw1gGJXFi42UFjb48+XAMBx/N47AKn
 Xdyp2DrF8OcC5AVlcLRZs2zKe5SWwDlB0U1WCL0x6bEuGO9BaYksAQNqY4DWtk6f+bMofjIgc
 Zbe/qR+QkEDLIJSYTPBnhsmkokUokOTg6YE+y9JmoxqvWv2i/2xGkFGmkBesvNDsPgLqQWDEc
 W1uKggqB1NL/ilGN+PnA==
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 12:41:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

--Sig_/XmaH4+VQaZdzDZ_MY23hXLm
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
 include/qemu/yank.h   |  95 +++++++++++++++++++
 qapi/meson.build      |   1 +
 qapi/qapi-schema.json |   1 +
 qapi/yank.json        | 115 ++++++++++++++++++++++
 util/meson.build      |   1 +
 util/yank.c           | 216 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 429 insertions(+)
 create mode 100644 include/qemu/yank.h
 create mode 100644 qapi/yank.json
 create mode 100644 util/yank.c

diff --git a/include/qemu/yank.h b/include/qemu/yank.h
new file mode 100644
index 0000000000..96f5b2626f
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
+#include "qapi/qapi-types-yank.h"
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
+        .type =3D YANK_INSTANCE_TYPE_BLOCK_NODE, \
+        .u.block_node.node_name =3D (the_node_name) })
+
+#define CHARDEV_YANK_INSTANCE(the_id) (&(YankInstance) { \
+        .type =3D YANK_INSTANCE_TYPE_CHARDEV, \
+        .u.chardev.id =3D (the_id) })
+
+#define MIGRATION_YANK_INSTANCE (&(YankInstance) { \
+        .type =3D YANK_INSTANCE_TYPE_MIGRATION })
+
+#endif
diff --git a/qapi/meson.build b/qapi/meson.build
index 0e98146f1f..ab68e7900e 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -47,6 +47,7 @@ qapi_all_modules =3D [
   'trace',
   'transaction',
   'ui',
+  'yank',
 ]

 qapi_storage_daemon_modules =3D [
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 0b444b76d2..79c1705ed7 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -91,3 +91,4 @@
 { 'include': 'audio.json' }
 { 'include': 'acpi.json' }
 { 'include': 'pci.json' }
+{ 'include': 'yank.json' }
diff --git a/qapi/yank.json b/qapi/yank.json
new file mode 100644
index 0000000000..1964a2202e
--- /dev/null
+++ b/qapi/yank.json
@@ -0,0 +1,115 @@
+# -*- Mode: Python -*-
+# vim: filetype=3Dpython
+#
+
+##
+# @YankInstanceType:
+#
+# An enumeration of yank instance types. See @YankInstance for more
+# information.
+#
+# Since: 5.2
+##
+{ 'enum': 'YankInstanceType',
+  'data': [ 'block-node', 'chardev', 'migration' ] }
+
+##
+# @YankInstanceBlockNode:
+#
+# Specifies which block graph node to yank. See @YankInstance for more
+# information.
+#
+# @node-name: the name of the block graph node
+#
+# Since: 5.2
+##
+{ 'struct': 'YankInstanceBlockNode',
+  'data': { 'node-name': 'str' } }
+
+##
+# @YankInstanceChardev:
+#
+# Specifies which character device to yank. See @YankInstance for more
+# information.
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
+# A yank instance can be yanked with the @yank qmp command to recover from=
 a
+# hanging QEMU.
+#
+# Currently implemented yank instances:
+#  - nbd block device:
+#    Yanking it will shut down the connection to the nbd server without
+#    attempting to reconnect.
+#  - socket chardev:
+#    Yanking it will shut down the connected socket.
+#  - migration:
+#    Yanking it will shut down all migration connections. Unlike
+#    @migrate_cancel, it will not notify the migration process, so migrati=
on
+#    will go into @failed state, instead of @cancelled state. @yank should=
 be
+#    used to recover from hangs.
+#
+# Since: 5.2
+##
+{ 'union': 'YankInstance',
+  'base': { 'type': 'YankInstanceType' },
+  'discriminator': 'type',
+  'data': {
+      'block-node': 'YankInstanceBlockNode',
+      'chardev': 'YankInstanceChardev' } }
+
+##
+# @yank:
+#
+# Try to recover from hanging QEMU by yanking the specified instances. See
+# @YankInstance for more information.
+#
+# Takes a list of @YankInstance as argument.
+#
+# Returns: - Nothing on success
+#          - @DeviceNotFound error, if any of the YankInstances doesn't ex=
ist
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
+# Query yank instances. See @YankInstance for more information.
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
index 0000000000..4a0f538359
--- /dev/null
+++ b/util/yank.c
@@ -0,0 +1,216 @@
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
+#include "qapi/qapi-commands-yank.h"
+#include "qapi/qapi-visit-yank.h"
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
+ * This lock protects the yank_instance_list below. Because it's taken by
+ * OOB-capable commands, it must be "fast", i.e. it may only be held for a
+ * bounded, short time. See docs/devel/qapi-code-gen.txt for additional
+ * information.
+ */
+static QemuMutex yank_lock;
+
+static QLIST_HEAD(, YankInstanceEntry) yank_instance_list
+    =3D QLIST_HEAD_INITIALIZER(yank_instance_list);
+
+static bool yank_compare_instances(const YankInstance *a, const YankInstan=
ce *b)
+{
+    if (a->type !=3D b->type) {
+        return false;
+    }
+
+    switch (a->type) {
+    case YANK_INSTANCE_TYPE_BLOCK_NODE:
+        return !strcmp(a->u.block_node.node_name, b->u.block_node.node_nam=
e);
+    break;
+
+    case YANK_INSTANCE_TYPE_CHARDEV:
+        return !strcmp(a->u.chardev.id, b->u.chardev.id);
+    break;
+
+    case YANK_INSTANCE_TYPE_MIGRATION:
+        return true;
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


--Sig_/XmaH4+VQaZdzDZ_MY23hXLm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+cQiQACgkQNasLKJxd
slgtZBAAgzDEJwZukzp2AT13T9UqqWf65insPAFwex+7dTnztaHmIkZXj3I6s5IE
5cXVIsM3C5pLChX0EOIHAdCIsB3LBpA3m45FPjgs4QtnFfXubNmRkxUzQ4vyrlB/
e3N1lVtfjj/u3PpDXYzLtu0gAueFhnSMaYbLO3ypFiYalalYrW8CJLL84gZmaG26
FN83QXfLkJdjlOuEaphdAUie5BmVkWpzd6D91dsWUPHilxkwNmJPJPVOzY4m30Zw
R4CzeIZ4uRcMyqS+odpwdPiGY0rxswwSELjHry6IB7Dp9g4sVKX9Zv0GvNOHkD3f
8zloaeM1XN8rZiU3l+tF0NTKXj76ySxDHJDSU+g/HQi3KDbedo0yZrPdM+eQq47b
Xkb9aU0ct8WznAi15oBTUrupaRnR5dfjBixsX566W3oWJ31RlUlX51rpQ2wJ3DTC
/ZuDU6KzcKOXwDhVj+N1VwkkY3DGnFsOe7g96QYRWkZy9UMp4ZSibFqq5PxECFnm
K5f0A+4EKRTD4V3NIMNklAmY6nVH6ARn1xYstAfQJQ8X/DjFleevb9MW6MJrIQPy
csyHc/7lAme+yza4PaP1hZaEushig+8gxXFmKUvYQDYPTaNTKbTshvOYKKyj+5Sr
Y2BkfmxO34hUxXJqRYoTEB6bZ+y/MSE7FWE01Dr+bZ+QZ7HcyEg=
=ZJ37
-----END PGP SIGNATURE-----

--Sig_/XmaH4+VQaZdzDZ_MY23hXLm--

