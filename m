Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E289C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 18:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B58920787
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 18:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="SmphbT1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B58920787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcvTS-00028D-3Q
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 14:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jcvP5-00087m-AA; Sun, 24 May 2020 14:31:19 -0400
Received: from mout.web.de ([212.227.15.14]:46807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jcvP4-0006Tb-2G; Sun, 24 May 2020 14:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590345072;
 bh=/O9xlvzvWBWMRrVLjZtOMmg80GmqgybYiXhnvOjsfhE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=SmphbT1vmDMLKcPgzfgHbAL7+8b6Ucq5EpxUIXUiHCt82jVCBIQeFvIz88DqBIyKn
 1Lv8T0NiOikRDNXuo2+0NHZfKPUOPc1ka4S6VySMxleyUdegZyOtVGOYN+hsPk/9fa
 Nj/Nn0XRIK4NIpTfq3pNh2ccaxk1dD6cKOsYznMA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.42]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfzcB-1jEFsx1lKl-00pgG2; Sun, 24
 May 2020 20:31:12 +0200
Date: Sun, 24 May 2020 20:31:10 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 1/4] Introduce yank feature
Message-ID: <dc2724aead900db8fb3bed0a066f7c7e2654edb0.1590344541.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590344541.git.lukasstraub2@web.de>
References: <cover.1590344541.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n.3UvvRlVtsstdK6ef+wBVQ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:sGSfGPEMZ/dCbbxsG7H+YVELfz/d8Dsdcofzhu/Dq/ahxcwJICc
 gIMiuzybXHE+cVES+4wUU3Sym9nN0gOyYuF8HGHibJf47TB0burxMVrDYwrP7yhf/38eYeW
 06kjpTfi9oE7TO0fvZ1NETPW1SvTabV22VTmMrtwwFvksXnPYAgfTB8Ee6LWmpCeDv4d3Ky
 R0khZo2DG900YMksIEfNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k0/DnYSIAog=:vnAYrYrZYlwzNL4+RHisjW
 /Alw2aI/0a3+dEtNSB7SUDHiCusDCWsBB8iwGy2/5ZNtJekQgkUu2WgEC/i+C2yxZfjoh8j5U
 +vp1sP82sIl8evzrr53K8sHfLhxUAnN47MsMG2OUYL9T5DJ82re9I8u6DXxAdAaVCW3MCSs2W
 khUF41+O7ymhbrNquLbPZXT5pQLZcd7MmXtYrKrlLT9mddNRZDQHyktTdV8XmwK50x4O0qoWq
 6tmA77aXsyEg08xxAzehClZDRCSxoTJq9DWrA/JTIHKQzl274IUuTFD0we9dE8TI9t9QttuU6
 gp4mKYOsLVPlrmSyWZaq7mzbvvHJ+JZ/984fTx06YVZFjY5O4JIRrzWUEideZRH9JDYKNyo6+
 T1XWvSvEbk+IE8oRYjo5COkdxjwi+x9xZ0F4L7AJjcdIDpp5HD5Oh6wC0+Nahyai7VOT4QTRO
 /T5IIRwwj2hXg9M9xn/pnTpeXw3NOM52qogq4hQTcHAi14YptFOzo8NIez1B+nxTZBPwmb/2n
 A6NyDMNHZYZ+bNcn6IQSb3MP84AnWPwknz6nM+fA9eRNbHlO0WLCwVvqu00qozIGYHFRTYIHf
 Ed5Ncp176XMEFMsl7VIAKA6xTzgpDDF8gFiyYb2FWK5PfKC8zYpT5Kyrasgn+W0L/A2cwpoZs
 TNTlHrVy9/rVgwgIr4eY2VMRu7jU1YqW74huQzE5gwmPTA4hYJWw1T4aq1zqg5Kimr8X0NjEf
 epRlmwLYXeQ7Aj635bawXUDYSGFObux6Uw/vZAUZRQxDrt7WbicCEn5YCPgpME2A4N+pjeYvQ
 A+O90mmd65n48sHKBrQlyN7x78nfahGJfnZOz13cEpx+1dpe8Yjmj48UrhUOfhoSXAYuHmxQg
 x9GVfO/nKepE52/f2BfDBgNmzRC4LaD56TTF5lz8w28A8ck9TnSBL7jsT5Bkm2ws8KnxuqtA4
 mufJ8zjYMhmlyaoCyq87q0+qlYyqr6wabJvHeTV2XD12gkB+CeqAykZFH6JyIzC1AvwKQOhr+
 dpCK7zi+qkDosUG9KThRebN3yQDmx9pyyWLzARxTL1n20piezApiGi0rcFX1lonLNjEOEs/iP
 12T6YNp1WXXwSzz4cbHyrJepROWMBXoOVWn4xiMvU9ZE5ZoI0CCVzpaXVrPS9blpeSoB0Hn8s
 hWgfvmcPbtvoTFhWOL3Fg06nZ5P/Oaw3XnIj2sW3qci6ibU1nB79HpuxxgPmNehvi1jPc3aNA
 Zh4lELMmezmHPhs8V
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 14:31:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--Sig_/n.3UvvRlVtsstdK6ef+wBVQ
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


--Sig_/n.3UvvRlVtsstdK6ef+wBVQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7KvW4ACgkQNasLKJxd
slhtFQ//YwmqA4NTBlEBE2AcDySEBzgNudQIkQWAccn5CaoGUNzPwnk5kGL9idCz
sn49GhytZsRpuYalEfVB0Kj9hiKECKEb4yYlMmy/QDYEJ6TieuyTVQQcMdRaphGB
0J93HYzrBsg7Y7zK0VkvcErvixQbJ0i6zm2yaH6YbfyeTHvERWJOh0sLwWXS5uL/
wlBq/KVWGMdgN+v0A67DRhp0852rpQPRTkVupgjFngwJM2BJnqrGgo5bk0Rw5hR8
cqYvZTIt4tNdqNOWxcYCYqJ2/uVYUtuYxx3cyROkR1t5gExhQFgNY5ooFaiomKhn
YIgBaudmqSbsV38auvSVkHk5+kyNAuLgIfew1xEdPTE4NIljmJNwo9rW9pPkScIb
PWqquvtB0wAmAtY+nFL9+bys7DuD94lUV+4G6ZPqGtQhwG/1mh1dMv8uglbxZtw2
UcyNkB3z9RiJtAhdwNlhY9iDI7JyRTheRigbRZnSATCG1OFWSzFJQZrwFsppDRQi
uNWOzaI/LW+R4yEzlz8RbOL4amrZJ4twBXdRrVQj9EJATcE3LegI721WK6b5XDpw
o5/BuInd5Q2uCIWV+fpKCjbwFgQPMCmlym8M11JZ6Q23BvNY8egNbiF4upqdFix6
gOnwQhkiCPlrJztLFqptyXNL+JuZhvhu1Ki+2HOpVmjeVa0cgXM=
=gfek
-----END PGP SIGNATURE-----

--Sig_/n.3UvvRlVtsstdK6ef+wBVQ--

