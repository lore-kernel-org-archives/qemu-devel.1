Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D28C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FB620722
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Ls5hh1hN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FB620722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6Ss-0002yu-I0
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6OT-0000Nb-FK; Mon, 11 May 2020 07:14:45 -0400
Received: from mout.web.de ([212.227.17.11]:45173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6OS-0006pG-Er; Mon, 11 May 2020 07:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589195679;
 bh=69isl/oloXKqCgT1lMh7Rv9glCgzyS4DtmEifV3kP2Y=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Ls5hh1hNeY5R9PSRPcu0l8xb9iP8cgvDfwuYZvKhzmNCphsc7EhdeNzPh+ZWkJdPq
 dCSB3itY0opts2furo1sGH4TKfZcTZ5FKyqe3sf8UNJePEkPDXIJErsD5+Y5ajV6GS
 9JCYXCkygiweynZ0ncWoGRc+3+1JFqEdPwGiOCNg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gXQ-1j40SL0KZe-014gPR; Mon, 11
 May 2020 13:14:39 +0200
Date: Mon, 11 May 2020 13:14:37 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 1/5] Introduce yank feature
Message-ID: <99931d0c9ab23eb641bd612e154f007348afa690.1589193717.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589193717.git.lukasstraub2@web.de>
References: <cover.1589193717.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I_Kx/CpVvM=iQB0A2ZZVo8K";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:MJUelbv6jUA0wE0LZky0xBVwVS9C3aZj3VVV3jOfm7HZnRG5Mm0
 QY4q73Ow6G9i6DBZaNmccKdFCL1AX30vLnN6xSvjqoz+5KKVGTaW3EnBk7InpRL+7DXpsV7
 vkK3cI+w8qTBbaAiavTEpyhT0IIx7R2OAA2LPBtZxfh4qS+gBnZ4Cq3BvXLi/R8KyHKOM1q
 tBB6JTCxGYekgDGRQnAFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zVbW5lOgWBg=:0lyFw7JO3+DbF/yjYHeZDj
 SVyQQI0VVcepf5xP72yT5xqOJoKSQUtL0KbNIEaVgm5LqI2Srzhit0q/Fg5RA0dV0T/GTK4Dc
 ds1ePzZWf1lcXlCkY1R+Fgi7KpZksphPoLvDIGK1Dkng6JGlxyBSkYMpS7PF7iBZgyLi2phw+
 DVOr6PfmZql8DqngKZBpWM/dBEQPOtjZqL/PLCbT8G/W7xZpOfNVvrtqtnyacdkfFpLxsJqLo
 q2DoscYECFfTKTn/9AcxXTe4hCSaATlNS7DpXqdzNn52biLFnp66MLxYUm4SjQk2A3nubrqGM
 K2wNZmNhuzd6Z35PFjjbmAAwtFzUCYe+NLiZWB9vc04GSEb/UwKl198EzxJPNa5RF7QBg2eyJ
 h57vbpxxq8i8tg4fxVbN6/wg/mUCWAYEN2szjgWoCH+F5gCQl6RfWGC4RiFUvrJgNZjVy8o5V
 hgVn59NMcxmSpON+eAIKB/1RYSPtfvBBNCnEXWv9tKkSY+aIOEtKmeMlFYhpeP4a/O3I9gBUj
 BjjkFa/IayvG3nVk1BvedH7tesB737XQeSB8upt0NT3hk+4qH8RVwpksK3SGM7u5plqicheBj
 C3gH9lvouwvIUBJDySL0GBBuWWhIaIkAwqmjCqhIf89xtG6XpW8CMqKQ8dtMGIrXuePOrewCJ
 /6G6J/aS0VXZHTKsTYb+Ppikrkj+7K3Mch0nvxXgoPuNszVecxQSUxkQV0mvb9EznFHMN6qxM
 6XbXepKGN9j9cm5KM2K69c0y3Z8IC9Qt4Exz4/d0v8p4O+nDP7yah4DrHJteDgjRk1hHH7R5F
 VGRSw5sWw88o9qxrf8pux4OS7/wQzKS0erLq8bYCxMxtI1mialhe905T3HBvS8Q22T2N6HYNz
 kxy5L11dVDULmwMqAv6pKkKhCk2NjYMlPtjJE+MEikJXlrz7jve7Zza41dwBIM/k/AUwM87jD
 zxUuYakuLWW5sQlkwyekoRM93ilMuCZeEzyqxNBmqwMxLBQ2x9LFGVdgj1GJYSp1WyZ45JTam
 Msp4RH3dQZrvtip2k9ZesHrjF14aRaqH04oy483U3X9ZH+P8xDALsU+d8+IPMen/QSxlHDZjn
 Tbg5E7YBe5oBVHo2gv/PjcpPc5UgRrCd8gHL4hkfVntJv3gGn4UXksMoxJQ2JShJyiuuMUGB5
 xbzYq78TNh5rHtxLr1w+6ls8Q4kWKBACunWNJ+SHfLJMagl/b4vvxAAINL+iuSiHfj51RykbK
 LlednjxGt74IvNYRA
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:14:43
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

--Sig_/I_Kx/CpVvM=iQB0A2ZZVo8K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

The yank feature allows to recover from hanging qemu by "yanking"
at various parts. Other qemu systems can register yank functions
which will be called by the 'yank' out-of-band qmp command.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 qapi/misc.json | 15 ++++++++++
 softmmu/vl.c   |  2 ++
 yank.c         | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 yank.h         | 12 ++++++++
 4 files changed, 104 insertions(+)
 create mode 100644 yank.c
 create mode 100644 yank.h

diff --git a/qapi/misc.json b/qapi/misc.json
index 99b90ac80b..de1ee494ae 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1550,3 +1550,18 @@
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
=20
+##
+# @yank:
+#
+# Recover from hanging qemu by calling yank functions.
+#
+# Returns: nothing.
+#
+# Example:
+#
+# -> { "execute": "yank" }
+# <- { "return": {} }
+#
+# Since: 5.1
+##
+{ 'command': 'yank', 'allow-oob': true }
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 32c0047889..5d99749d29 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -112,6 +112,7 @@
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
 #include "qemu/guest-random.h"
+#include "yank.h"
=20
 #define MAX_VIRTIO_CONSOLES 1
=20
@@ -2906,6 +2907,7 @@ void qemu_init(int argc, char **argv, char **envp)
     precopy_infrastructure_init();
     postcopy_infrastructure_init();
     monitor_init_globals();
+    yank_init();
=20
     if (qcrypto_init(&err) < 0) {
         error_reportf_err(err, "cannot initialize crypto: ");
diff --git a/yank.c b/yank.c
new file mode 100644
index 0000000000..cefbfd8ab5
--- /dev/null
+++ b/yank.c
@@ -0,0 +1,75 @@
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
+#include "yank.h"
+
+struct YankFuncAndParam {
+    YankFn *func;
+    void *opaque;
+    QLIST_ENTRY(YankFuncAndParam) next;
+};
+
+static QemuMutex lock;
+static QLIST_HEAD(qlisthead, YankFuncAndParam) head
+    =3D QLIST_HEAD_INITIALIZER(head);
+
+void yank_register_function(YankFn *func, void *opaque)
+{
+    struct YankFuncAndParam *tmp =3D g_malloc(sizeof(struct YankFuncAndPar=
am));
+    tmp->func =3D func;
+    tmp->opaque =3D opaque;
+
+    qemu_mutex_lock(&lock);
+    QLIST_INSERT_HEAD(&head, tmp, next);
+    qemu_mutex_unlock(&lock);
+}
+
+void yank_unregister_function(YankFn *func, void *opaque)
+{
+    qemu_mutex_lock(&lock);
+
+    struct YankFuncAndParam *tmp;
+    QLIST_FOREACH(tmp, &head, next) {
+        if (tmp->func =3D=3D func && tmp->opaque =3D=3D opaque) {
+            QLIST_REMOVE(tmp, next);
+            g_free(tmp);
+            qemu_mutex_unlock(&lock);
+            return;
+        }
+    }
+
+    abort();
+}
+
+void yank_call_functions(void)
+{
+    qemu_mutex_lock(&lock);
+
+    struct YankFuncAndParam *tmp;
+    QLIST_FOREACH(tmp, &head, next) {
+        tmp->func(tmp->opaque);
+    }
+
+    qemu_mutex_unlock(&lock);
+}
+
+void qmp_yank(Error **errp)
+{
+    yank_call_functions();
+}
+
+void yank_init(void)
+{
+    qemu_mutex_init(&lock);
+    QLIST_INIT(&head);
+}
diff --git a/yank.h b/yank.h
new file mode 100644
index 0000000000..7376224219
--- /dev/null
+++ b/yank.h
@@ -0,0 +1,12 @@
+
+#ifndef YANK_H
+#define YANK_H
+
+typedef void (YankFn) (void *opaque);
+
+void yank_register_function(YankFn *func, void *opaque);
+void yank_unregister_function(YankFn *func, void *opaque);
+void yank_call_functions(void);
+void yank_init(void);
+void qmp_yank(Error **errp);
+#endif
--=20
2.20.1


--Sig_/I_Kx/CpVvM=iQB0A2ZZVo8K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65M50ACgkQNasLKJxd
sljF3g//Us2qiNZcJZKouFsTTshtllfrT2KsgQ9R8+mhMUFYR1xg8R2762Q3cdr9
/5MPThQ0OSAkDVeYlodoTwHJu8v1MXgmXhwEvGSRlo13ITybpoWZD//eOp7yE6mZ
4wXjMRygQKq1SVZ82tW9lRFCpwUcg7xTR28sKMAYkaY0NiXN/Y/71u/mVmruanIB
PtN4T+flpH41IXDwwD+mK7lANIjU2BrBJRAXjtENuiKDIuwC9XwFRepr0N/065uY
/T/nVAR4x4yvDOnu/sJbeOME0Wqm08BBo/sQ86J9vyyI/7machOmXEKLE+RtALjM
Xbuy36o5bC51JyR/VrOxd3TBdk0jgBsk+J+wUSISvBIh+WuFiYfqNtYkuyqZh7Hr
xKuI+R0dcCU0t9FZd4LszNN29C9f2P8VR/lfoWw27vUwAfLtD9EF3mVflxzEfrqO
fHnasQwFXT77SPvBwj/heThaLChu0XuWrBPrLddT+2VNUS/OOC2eiD/KC8P+96+v
N5RChkGkoq/RrK6NYBWLNgGZfkAaJU5OBbpE/aNerSikUVAW+q43b+qLoaGeGXVE
Y3UGSlA9roVCiPteWS6JaUKFgAmefZnTASpm610cejMfgG0KK0BizPCpben9vzsu
vLjIt0utqAU/gbCk7rOzIHpRdgMCqwDeKrxOyZKVDrW41I+0lNI=
=Qx+H
-----END PGP SIGNATURE-----

--Sig_/I_Kx/CpVvM=iQB0A2ZZVo8K--

