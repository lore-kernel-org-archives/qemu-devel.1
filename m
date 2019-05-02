Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9134CC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596C72081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596C72081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57492 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMH5f-0003x9-Ii
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 15:09:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvv-0003uF-7V
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvt-0003Ai-V4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:51 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:48925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMGvr-00037l-RF; Thu, 02 May 2019 14:59:49 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MeTHG-1goJ5D2reG-00aWOX; Thu, 02 May 2019 20:59:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 20:58:35 +0200
Message-Id: <20190502185835.15185-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502185835.15185-1-laurent@vivier.eu>
References: <20190502185835.15185-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:johlun5VbqcFFeXrYbcsP3qULCYtVfsxhJ0z39MAyC1YkfTLvrZ
	7zip1xJrieVu35UEQ+V5YlcsBmCskkF3JMsMbUEdTAJuzmepg0GifQn0+/c9WinCoLhoSSq
	EWCQLcv1zj+w+ZryTUSgTuJ1yBc4P36BZX3s086YICNmsv15IwxY99KI/kSNuCbNhluUJ3B
	sV+cw+Lq78WCz1dLoAk2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AyS5xkSKc/4=:dYbQfipr5uRL0uioQB0yuJ
	ZANmGH/T/igME9DASM/EyL+8+YxkZHBExlwzb04daIuzzF0D9aM26oqt1sTZKwZcga6ny84l8
	Lbd4CkqQmc6whFK+XyKRyFUFSYv/ntw9Tx8NyZDuJMaJvefahYJmuBNFKZgegz2baZVhBlzY7
	zrrjboUxwhP2DBYp0r27VGnCHGLKUw+hWs7w/tGJqsgSstMvzGuddaElmpKoa7skKAJBqpOF0
	nnyCCTIk9kSCU4Fe3tXozFQqiKnBQcd4ADjbh6RS7DqG99bDyoXAvbgSmyh+B8TnJxGJU8DTr
	lYZDl1WSitSfwhJW8VGEG6SFzzyNlcfpaTD73/wXVqasI67xIop+8wnZA6ZW7fX7jehB7USbf
	5tEMM+thJ/QohdVXOegleBXHLem15kFXbzVI4VcnUc8NbTw3OnUp3TTGMoxzEURd44A2kDd76
	QalIz6PZW4qkL0EhioROIPeqUs1mgJZJE2GEJhGEmYWbUKmifTaFfE/W+Hzzo23ya/CaV9N1N
	ZQ3Ip5I0Vtv+jaQfX0ADfDEu72vnFc7WMUU93qoM/g1gzY9PknypJUlZVhWqmdk+c9vBbOAiW
	eY0RUjw1zXYedBwrUIlxX8rIJo9dd8lQU5VkPKpf9J05SE42xoSiiT4GR5TEnKEs1VYD/a2Ys
	moi1oxuXJP4kn/mCouAhDvULVNeilE/ZRja/dgdr+jAxawTMSp+elgFy3aa/ZYciRRMR2sDJH
	UrRgWhoN5wILjoT8xLveez9KfIZFZakRrOqjAk+0/0Z/LKcdcZ0Tjpdk8XQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 13/13] sockets: avoid string truncation warnings
 when copying UNIX path
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Fabien Chouteau <chouteau@adacore.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502185835.ySHE5h2C88XeXW3MaqelOh4SQcIpH5qyjUJDn75zDhg@z>

From: Daniel P. Berrangé <berrange@redhat.com>

In file included from /usr/include/string.h:494,
                 from include/qemu/osdep.h:101,
                 from util/qemu-sockets.c:18:
In function ‘strncpy’,
    inlined from ‘unix_connect_saddr.isra.0’ at util/qemu-sockets.c:925:5:
/usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Wstringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function ‘strncpy’,
    inlined from ‘unix_listen_saddr.isra.0’ at util/qemu-sockets.c:880:5:
/usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Wstringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We are already validating the UNIX socket path length earlier in
the functions. If we save this string length when we first check
it, then we can simply use memcpy instead of strcpy later, avoiding
the gcc truncation warnings.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190501145052.12579-1-berrange@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/qemu-sockets.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 970505169000..ba6335e71a95 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -830,6 +830,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     int sock, fd;
     char *pathbuf = NULL;
     const char *path;
+    size_t pathlen;
 
     sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
     if (sock < 0) {
@@ -845,7 +846,8 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
         path = pathbuf = g_strdup_printf("%s/qemu-socket-XXXXXX", tmpdir);
     }
 
-    if (strlen(path) > sizeof(un.sun_path)) {
+    pathlen = strlen(path);
+    if (pathlen > sizeof(un.sun_path)) {
         error_setg(errp, "UNIX socket path '%s' is too long", path);
         error_append_hint(errp, "Path must be less than %zu bytes\n",
                           sizeof(un.sun_path));
@@ -877,7 +879,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
 
     memset(&un, 0, sizeof(un));
     un.sun_family = AF_UNIX;
-    strncpy(un.sun_path, path, sizeof(un.sun_path));
+    memcpy(un.sun_path, path, pathlen);
 
     if (bind(sock, (struct sockaddr*) &un, sizeof(un)) < 0) {
         error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
@@ -901,6 +903,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
 {
     struct sockaddr_un un;
     int sock, rc;
+    size_t pathlen;
 
     if (saddr->path == NULL) {
         error_setg(errp, "unix connect: no path specified");
@@ -913,7 +916,8 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
         return -1;
     }
 
-    if (strlen(saddr->path) > sizeof(un.sun_path)) {
+    pathlen = strlen(saddr->path);
+    if (pathlen > sizeof(un.sun_path)) {
         error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
         error_append_hint(errp, "Path must be less than %zu bytes\n",
                           sizeof(un.sun_path));
@@ -922,7 +926,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
 
     memset(&un, 0, sizeof(un));
     un.sun_family = AF_UNIX;
-    strncpy(un.sun_path, saddr->path, sizeof(un.sun_path));
+    memcpy(un.sun_path, saddr->path, pathlen);
 
     /* connect to peer */
     do {
-- 
2.20.1


