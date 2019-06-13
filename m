Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAD0C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594B421473
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594B421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42224 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbTMy-0005dm-Sv
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35644)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hbRy7-0002o5-MP
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hbRy6-0006VH-2a
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:48:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hbRy3-0006RK-02; Thu, 13 Jun 2019 11:48:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C7CD781F31;
 Thu, 13 Jun 2019 15:48:41 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 540565C6D6;
 Thu, 13 Jun 2019 15:48:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 10:48:29 -0500
Message-Id: <20190613154837.21734-2-eblake@redhat.com>
In-Reply-To: <20190613154837.21734-1-eblake@redhat.com>
References: <20190613154837.21734-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 13 Jun 2019 15:48:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/9] qemu-nbd: Add --pid-file option
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
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

--fork is a bit boring if there is no way to get the child's PID.  This
option helps.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20190508211820.17851-2-mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.texi |  2 ++
 qemu-nbd.c    | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index de342c76b873..7f55657722bd 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -117,6 +117,8 @@ option; or provide the credentials needed for connect=
ing as a client
 in list mode.
 @item --fork
 Fork off the server process and exit the parent once the server is runni=
ng.
+@item --pid-file=3DPATH
+Store the server's process ID in the given file.
 @item --tls-authz=3DID
 Specify the ID of a qauthz object previously created with the
 --object option. This will be used to authorize connecting users
diff --git a/qemu-nbd.c b/qemu-nbd.c
index e24dd2f76766..99377a3f14e2 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -61,6 +61,7 @@
 #define QEMU_NBD_OPT_IMAGE_OPTS    262
 #define QEMU_NBD_OPT_FORK          263
 #define QEMU_NBD_OPT_TLSAUTHZ      264
+#define QEMU_NBD_OPT_PID_FILE      265

 #define MBR_SIZE 512

@@ -113,6 +114,7 @@ static void usage(const char *name)
 "                            specify tracing options\n"
 "  --fork                    fork off the server process and exit the pa=
rent\n"
 "                            once the server is running\n"
+"  --pid-file=3DPATH           store the server's process ID in the give=
n file\n"
 #if HAVE_NBD_DEVICE
 "\n"
 "Kernel NBD client support:\n"
@@ -641,6 +643,7 @@ int main(int argc, char **argv)
         { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
         { "trace", required_argument, NULL, 'T' },
         { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
+        { "pid-file", required_argument, NULL, QEMU_NBD_OPT_PID_FILE },
         { NULL, 0, NULL, 0 }
     };
     int ch;
@@ -667,6 +670,7 @@ int main(int argc, char **argv)
     bool list =3D false;
     int old_stderr =3D -1;
     unsigned socket_activation;
+    const char *pid_file_name =3D NULL;

     /* The client thread uses SIGTERM to interrupt the server.  A signal
      * handler ensures that "qemu-nbd -v -c" exits with a nice status co=
de.
@@ -866,6 +870,9 @@ int main(int argc, char **argv)
         case 'L':
             list =3D true;
             break;
+        case QEMU_NBD_OPT_PID_FILE:
+            pid_file_name =3D optarg;
+            break;
         }
     }

@@ -1186,6 +1193,10 @@ int main(int argc, char **argv)

     nbd_update_server_watch();

+    if (pid_file_name) {
+        qemu_write_pidfile(pid_file_name, &error_fatal);
+    }
+
     /* now when the initialization is (almost) complete, chdir("/")
      * to free any busy filesystems */
     if (chdir("/") < 0) {
--=20
2.20.1


