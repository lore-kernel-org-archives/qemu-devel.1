Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBA1C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 18:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7CC2070C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 18:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7CC2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5wSn-0003Vy-Iu
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 14:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5wO8-0006ZX-RR
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5wO7-00064e-Hh
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:21:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i5wO4-0005uu-AT; Thu, 05 Sep 2019 14:21:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 67CEB2D0FC7;
 Thu,  5 Sep 2019 18:21:39 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE3A95D6A3;
 Thu,  5 Sep 2019 18:21:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  5 Sep 2019 13:21:25 -0500
Message-Id: <20190905182132.3563-3-eblake@redhat.com>
In-Reply-To: <20190905182132.3563-1-eblake@redhat.com>
References: <20190905182132.3563-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 05 Sep 2019 18:21:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/9] nbd: Use g_autofree in a few places
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks to our recent move to use glib's g_autofree, I can join the
bandwagon.  Getting rid of gotos is fun ;)

There are probably more places where we could register cleanup
functions and get rid of more gotos; this patch just focuses on the
labels that existed merely to call g_free.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190824172813.29720-2-eblake@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c  | 11 ++++-------
 nbd/client.c | 22 +++++++---------------
 nbd/server.c | 12 ++++--------
 3 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index beed46fb3414..c4c91a158602 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1374,7 +1374,7 @@ static bool nbd_has_filename_options_conflict(QDict=
 *options, Error **errp)
 static void nbd_parse_filename(const char *filename, QDict *options,
                                Error **errp)
 {
-    char *file;
+    g_autofree char *file =3D NULL;
     char *export_name;
     const char *host_spec;
     const char *unixpath;
@@ -1396,7 +1396,7 @@ static void nbd_parse_filename(const char *filename=
, QDict *options,
     export_name =3D strstr(file, EN_OPTSTR);
     if (export_name) {
         if (export_name[strlen(EN_OPTSTR)] =3D=3D 0) {
-            goto out;
+            return;
         }
         export_name[0] =3D 0; /* truncate 'file' */
         export_name +=3D strlen(EN_OPTSTR);
@@ -1407,11 +1407,11 @@ static void nbd_parse_filename(const char *filena=
me, QDict *options,
     /* extract the host_spec - fail if it's not nbd:... */
     if (!strstart(file, "nbd:", &host_spec)) {
         error_setg(errp, "File name string for NBD must start with 'nbd:=
'");
-        goto out;
+        return;
     }

     if (!*host_spec) {
-        goto out;
+        return;
     }

     /* are we a UNIX or TCP socket? */
@@ -1431,9 +1431,6 @@ static void nbd_parse_filename(const char *filename=
, QDict *options,
     out_inet:
         qapi_free_InetSocketAddress(addr);
     }
-
-out:
-    g_free(file);
 }

 static bool nbd_process_legacy_socket_options(QDict *output_options,
diff --git a/nbd/client.c b/nbd/client.c
index 49bf9906f94b..a9d8d32feff7 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -247,12 +247,11 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NB=
DOptionReply *reply,
 static int nbd_receive_list(QIOChannel *ioc, char **name, char **descrip=
tion,
                             Error **errp)
 {
-    int ret =3D -1;
     NBDOptionReply reply;
     uint32_t len;
     uint32_t namelen;
-    char *local_name =3D NULL;
-    char *local_desc =3D NULL;
+    g_autofree char *local_name =3D NULL;
+    g_autofree char *local_desc =3D NULL;
     int error;

     if (nbd_receive_option_reply(ioc, NBD_OPT_LIST, &reply, errp) < 0) {
@@ -298,7 +297,7 @@ static int nbd_receive_list(QIOChannel *ioc, char **n=
ame, char **description,
     local_name =3D g_malloc(namelen + 1);
     if (nbd_read(ioc, local_name, namelen, "export name", errp) < 0) {
         nbd_send_opt_abort(ioc);
-        goto out;
+        return -1;
     }
     local_name[namelen] =3D '\0';
     len -=3D namelen;
@@ -306,24 +305,17 @@ static int nbd_receive_list(QIOChannel *ioc, char *=
*name, char **description,
         local_desc =3D g_malloc(len + 1);
         if (nbd_read(ioc, local_desc, len, "export description", errp) <=
 0) {
             nbd_send_opt_abort(ioc);
-            goto out;
+            return -1;
         }
         local_desc[len] =3D '\0';
     }

     trace_nbd_receive_list(local_name, local_desc ?: "");
-    *name =3D local_name;
-    local_name =3D NULL;
+    *name =3D g_steal_pointer(&local_name);
     if (description) {
-        *description =3D local_desc;
-        local_desc =3D NULL;
+        *description =3D g_steal_pointer(&local_desc);
     }
-    ret =3D 1;
-
- out:
-    g_free(local_name);
-    g_free(local_desc);
-    return ret;
+    return 1;
 }


diff --git a/nbd/server.c b/nbd/server.c
index 0fb41c6c50ea..74d205812fee 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -206,7 +206,7 @@ static int GCC_FMT_ATTR(4, 0)
 nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
                             Error **errp, const char *fmt, va_list va)
 {
-    char *msg;
+    g_autofree char *msg =3D NULL;
     int ret;
     size_t len;

@@ -216,18 +216,14 @@ nbd_negotiate_send_rep_verr(NBDClient *client, uint=
32_t type,
     trace_nbd_negotiate_send_rep_err(msg);
     ret =3D nbd_negotiate_send_rep_len(client, type, len, errp);
     if (ret < 0) {
-        goto out;
+        return ret;
     }
     if (nbd_write(client->ioc, msg, len, errp) < 0) {
         error_prepend(errp, "write failed (error message): ");
-        ret =3D -EIO;
-    } else {
-        ret =3D 0;
+        return -EIO;
     }

-out:
-    g_free(msg);
-    return ret;
+    return 0;
 }

 /* Send an error reply.
--=20
2.21.0


