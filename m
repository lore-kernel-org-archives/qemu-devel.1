Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AD2C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68330206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=online.net header.i=@online.net header.b="FsHGuSwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68330206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=online.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionqm-0001rg-FY
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fflorensa@online.net>) id 1iomoC-0003PC-Td
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fflorensa@online.net>) id 1iomoA-0000KF-Ht
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:13:59 -0500
Received: from mail.online.net ([62.210.16.11]:50098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fflorensa@online.net>)
 id 1iomoA-0000Ds-3S
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:13:58 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.online.net (Postfix) with ESMTP id 57F8EF2B95AF;
 Tue,  7 Jan 2020 12:13:49 +0100 (CET)
Received: from mail.online.net ([127.0.0.1])
 by localhost (mail.online.net [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id bAu8Y2iqHWE4; Tue,  7 Jan 2020 12:13:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.online.net (Postfix) with ESMTP id 36458F2B95C1;
 Tue,  7 Jan 2020 12:13:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.online.net 36458F2B95C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.net;
 s=4EC61654-9574-11E8-870F-3D38CA7095BF; t=1578395629;
 bh=ngB++wtkSZHUP5B588vFWq2FjId5OvgTOA4S3gPNaMw=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=FsHGuSwhmJpb07xt1b34+eT8/1vT/UADCwSz7JDp2mLwjknqy7H/NezuZ57uFxGCy
 jTI2kuoI8zobwpUoeEQbZX1NR9KRaQTv5iL5o0X0+GiUVg4YNzvcSM5+RW46Sun6L0
 nuw23a6mD3xgpB+zd76bkwfFHu6khCMeXJvOTLMmKk7EFrlNpQbvuWyk1X6ZuRUPT6
 PGzvipMM2M+IreoCmAClSTLywcME2qWmrFhlAY55ZI3pJEeERap+Y59sR2PJTxAX2g
 jXc7g8GnFrgp/ZX0VnvK43oa5YgRCze/BuHePSYkSJLWeby+H+FZwsbRR0ad7qhhFX
 wJeWCs8CJ8CVw==
X-Virus-Scanned: amavisd-new at mail.online.net
Received: from mail.online.net ([127.0.0.1])
 by localhost (mail.online.net [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id NRk9Houg8a0A; Tue,  7 Jan 2020 12:13:49 +0100 (CET)
Received: from flash.online.net (unknown [195.154.229.35])
 by mail.online.net (Postfix) with ESMTPSA id 14E3DF2B95AF;
 Tue,  7 Jan 2020 12:13:49 +0100 (CET)
From: Florian Florensa <fflorensa@online.net>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] block/rbd: Add support for ceph namespaces
Date: Tue,  7 Jan 2020 12:13:40 +0100
Message-Id: <20200107111340.334965-2-fflorensa@online.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107111340.334965-1-fflorensa@online.net>
References: <20200107111340.334965-1-fflorensa@online.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 62.210.16.11
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
Cc: kwolf@redhat.com, dillaman@redhat.com, armbru@redhat.com, mreitz@redhat.com,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Starting from ceph Nautilus, RBD has support for namespaces, allowing
for finer grain ACLs on images inside a pool, and tenant isolation.

In the rbd cli tool documentation, the new image-spec and snap-spec are :
 - [pool-name/[namespace-name/]]image-name
 - [pool-name/[namespace-name/]]image-name@snap-name

When using an non namespace's enabled qemu, it complains about not
finding the image called namespace-name/image-name, thus we only need to
parse the image once again to find if there is a '/' in its name, and if
there is, use what is before it as the name of the namespace to later
pass it to rados_ioctx_set_namespace.
rados_ioctx_set_namespace if called with en empty string or a null
pointer as the namespace parameters pretty much does nothing, as it then
defaults to the default namespace.

The namespace is extracted inside qemu_rbd_parse_filename, stored in the
qdict, and used in qemu_rbd_connect to make it work with both qemu-img,
and qemu itself.

Signed-off-by: Florian Florensa <fflorensa@online.net>
---
 block/rbd.c          | 45 ++++++++++++++++++++++++++++++--------------
 qapi/block-core.json |  4 ++++
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 027cbcc695..8df0e3b65e 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -104,6 +104,7 @@ typedef struct BDRVRBDState {
     rbd_image_t image;
     char *image_name;
     char *snap;
+    char *namespace;
     uint64_t image_size;
 } BDRVRBDState;
=20
@@ -152,7 +153,7 @@ static void qemu_rbd_parse_filename(const char *filen=
ame, QDict *options,
     const char *start;
     char *p, *buf;
     QList *keypairs =3D NULL;
-    char *found_str;
+    char *found_str, *image_name;
=20
     if (!strstart(filename, "rbd:", &start)) {
         error_setg(errp, "File name must start with 'rbd:'");
@@ -171,18 +172,24 @@ static void qemu_rbd_parse_filename(const char *fil=
ename, QDict *options,
     qdict_put_str(options, "pool", found_str);
=20
     if (strchr(p, '@')) {
-        found_str =3D qemu_rbd_next_tok(p, '@', &p);
-        qemu_rbd_unescape(found_str);
-        qdict_put_str(options, "image", found_str);
+        image_name =3D qemu_rbd_next_tok(p, '@', &p);
=20
         found_str =3D qemu_rbd_next_tok(p, ':', &p);
         qemu_rbd_unescape(found_str);
         qdict_put_str(options, "snapshot", found_str);
     } else {
-        found_str =3D qemu_rbd_next_tok(p, ':', &p);
-        qemu_rbd_unescape(found_str);
-        qdict_put_str(options, "image", found_str);
+        image_name =3D qemu_rbd_next_tok(p, ':', &p);
+    }
+    /* Check for namespace in the image_name */
+    if (strchr(image_name, '/')) {
+	found_str =3D qemu_rbd_next_tok(image_name, '/', &image_name);
+	qemu_rbd_unescape(found_str);
+	qdict_put_str(options, "namespace", found_str);
+    } else {
+	qdict_put_str(options, "namespace", "");
     }
+    qemu_rbd_unescape(image_name);
+    qdict_put_str(options, "image", image_name);
     if (!p) {
         goto done;
     }
@@ -343,6 +350,11 @@ static QemuOptsList runtime_opts =3D {
             .type =3D QEMU_OPT_STRING,
             .help =3D "Rados pool name",
         },
+        {
+            .name =3D "namespace",
+            .type =3D QEMU_OPT_STRING,
+            .help =3D "Rados namespace name in the pool",
+        },
         {
             .name =3D "image",
             .type =3D QEMU_OPT_STRING,
@@ -467,13 +479,14 @@ static int coroutine_fn qemu_rbd_co_create_opts(con=
st char *filename,
      * schema, but when they come from -drive, they're all QString.
      */
     loc =3D rbd_opts->location;
-    loc->pool     =3D g_strdup(qdict_get_try_str(options, "pool"));
-    loc->conf     =3D g_strdup(qdict_get_try_str(options, "conf"));
-    loc->has_conf =3D !!loc->conf;
-    loc->user     =3D g_strdup(qdict_get_try_str(options, "user"));
-    loc->has_user =3D !!loc->user;
-    loc->image    =3D g_strdup(qdict_get_try_str(options, "image"));
-    keypairs      =3D qdict_get_try_str(options, "=3Dkeyvalue-pairs");
+    loc->pool        =3D g_strdup(qdict_get_try_str(options, "pool"));
+    loc->conf        =3D g_strdup(qdict_get_try_str(options, "conf"));
+    loc->has_conf    =3D !!loc->conf;
+    loc->user        =3D g_strdup(qdict_get_try_str(options, "user"));
+    loc->has_user    =3D !!loc->user;
+    loc->q_namespace =3D g_strdup(qdict_get_try_str(options, "namespace"=
));
+    loc->image       =3D g_strdup(qdict_get_try_str(options, "image"));
+    keypairs         =3D qdict_get_try_str(options, "=3Dkeyvalue-pairs")=
;
=20
     ret =3D qemu_rbd_do_create(create_options, keypairs, password_secret=
, errp);
     if (ret < 0) {
@@ -648,6 +661,10 @@ static int qemu_rbd_connect(rados_t *cluster, rados_=
ioctx_t *io_ctx,
         error_setg_errno(errp, -r, "error opening pool %s", opts->pool);
         goto failed_shutdown;
     }
+    /* Set the namespace after opening the io context on the pool,
+     * if nspace =3D=3D NULL or if nspace =3D=3D "", it is just as we di=
d nothing
+     */
+    rados_ioctx_set_namespace(*io_ctx, opts->q_namespace);
=20
     return 0;
=20
diff --git a/qapi/block-core.json b/qapi/block-core.json
index fcb52ec24f..c6f187ec9b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3661,6 +3661,9 @@
 #
 # @pool:               Ceph pool name.
 #
+# @namespace:          Rados namespace name in the Ceph pool.
+#                      (Since 5.0)
+#
 # @image:              Image name in the Ceph pool.
 #
 # @conf:               path to Ceph configuration file.  Values
@@ -3687,6 +3690,7 @@
 ##
 { 'struct': 'BlockdevOptionsRbd',
   'data': { 'pool': 'str',
+            '*namespace': 'str',
             'image': 'str',
             '*conf': 'str',
             '*snapshot': 'str',
--=20
2.24.1


