Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27E6C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8CC206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8CC206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44121 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXPW-0001qv-HZ
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 11:01:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hYXNf-0000aw-Oz
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hYXNe-0002gI-PW
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:59:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hYXNe-0002fN-Ju
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:59:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F049FA3EB3
	for <qemu-devel@nongnu.org>; Wed,  5 Jun 2019 14:59:09 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C75D11A7D0;
	Wed,  5 Jun 2019 14:59:02 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 16:58:29 +0200
Message-Id: <20190605145829.7674-6-marcandre.lureau@redhat.com>
In-Reply-To: <20190605145829.7674-1-marcandre.lureau@redhat.com>
References: <20190605145829.7674-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Wed, 05 Jun 2019 14:59:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 5/5] vhost-user-gpu: initialize msghdr & iov at
 declaration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This should fix uninitialized fields found by coverity CID 1401762.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-gpu/main.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/contrib/vhost-user-gpu/main.c b/contrib/vhost-user-gpu/main.=
c
index 0ef649ffaa..04b753046f 100644
--- a/contrib/vhost-user-gpu/main.c
+++ b/contrib/vhost-user-gpu/main.c
@@ -138,22 +138,20 @@ static int
 vg_sock_fd_write(int sock, const void *buf, ssize_t buflen, int fd)
 {
     ssize_t ret;
-    struct msghdr msg;
-    struct iovec iov;
+    struct iovec iov =3D {
+        .iov_base =3D (void *)buf,
+        .iov_len =3D buflen,
+    };
+    struct msghdr msg =3D {
+        .msg_iov =3D &iov,
+        .msg_iovlen =3D 1,
+    };
     union {
         struct cmsghdr cmsghdr;
         char control[CMSG_SPACE(sizeof(int))];
     } cmsgu;
     struct cmsghdr *cmsg;
=20
-    iov.iov_base =3D (void *)buf;
-    iov.iov_len =3D buflen;
-
-    msg.msg_name =3D NULL;
-    msg.msg_namelen =3D 0;
-    msg.msg_iov =3D &iov;
-    msg.msg_iovlen =3D 1;
-
     if (fd !=3D -1) {
         msg.msg_control =3D cmsgu.control;
         msg.msg_controllen =3D sizeof(cmsgu.control);
@@ -164,9 +162,6 @@ vg_sock_fd_write(int sock, const void *buf, ssize_t b=
uflen, int fd)
         cmsg->cmsg_type =3D SCM_RIGHTS;
=20
         *((int *)CMSG_DATA(cmsg)) =3D fd;
-    } else {
-        msg.msg_control =3D NULL;
-        msg.msg_controllen =3D 0;
     }
=20
     do {
--=20
2.22.0.rc2.384.g1a9a72ea1d


