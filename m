Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6B9C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E392075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E392075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38685 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWYY-0002zb-3m
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:40:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLt-0007yo-FS
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLs-0003aI-5I
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:41 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58167)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWLp-0003X8-FM; Fri, 03 May 2019 07:27:37 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1Movrq-1gxtmB3xWg-00qTby; Fri, 03 May 2019 13:27:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:26:54 +0200
Message-Id: <20190503112654.4393-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503112654.4393-1-laurent@vivier.eu>
References: <20190503112654.4393-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ttwLbHfjFvzQwfNO9cPzyHDWHibyiGxX3ChUL76EYHycmw6EnmQ
	kx4FPyw+19atBvv9rTvmGMzWtnRB2Nw8LpG3BT7UsJRdIGZppMUoPxmfCku0TYi4WxRrpc2
	gcC4yxJY5WaFH2jsPA0++zT7nbzpXMsAr25W1rV5bf4PAkkPXiFCAytwX+5eeT1n+pRGQ46
	iBYBR40gUDShIbw4z18QQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8DdFuGzYnG0=:Cz+Bl1L/hYJ+YNd2i6eG0t
	37PibROpijR6jsht4R6cKPt2uQ1t8+Ak3RII7DCZy/fUpyN/LDaEbukfbq4p3FzAdyaHyAjUH
	YJwWT23oTMom+/552ujZEHEv6LO8KO7qM2eQ2sghrEuJFCMPIVYdK5Df4ntxWhWTYtWX8gKfF
	7pScW0UZxYQikQSVUskv62EmbLTTJGWhXXPrvOuzKGtWXM+HxEQcmFPM6JZemz/kBX0gRZuM9
	ztrHpLzJ2Y44iX2A6YxzgxeHNvmH6OkLfdTIuTkfWhFDlNReG29GIQvsnswBZj9OvcvuwvtWp
	H3/+XJZGO3/EzJ1QTTPFyeJCnAB3972CUTfswf6s+uH5MTAW9xdLUZEHkgfb6SAiATGvhGdtZ
	zaD3utatdFMyB4Z6LLDaPUP0aptg2Ou/dXSQ3DbRTURc0UvGHV90NkDQOOku6FzNAFGHRRN1Y
	BqhCeinaag4avNPCqqdpI3WkuZRp+WEqVZspx/h+Hx3EwuKO9EEO2VnF0NbQgbwJjZkeXTrl0
	qJGZUMzW598nOk6InZVcSpxAwM7OZWhKnn8h5MAPcVch0p3rBS6oyIErsl/9teeBdmKWWsnuk
	suOCoLu5K/I8IDVyoLDITF8dTHmhl65A7CMWLYRfTI8lsKGjnYRGmrHU+oY2XpHN2Hz3M6YMd
	ppLr+1DnBbL2vNimNVp/rjtvpSvWC5H0wyDbBjOskjg2Z7UDLXZa3d7W3fILc3du3UQRmZC5r
	jtXI7EBExZulsJsnEUV/wgnupFfnvMIn1yq7kuJ9+GTqH3cxcgL398syCVM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL v2 12/12] sockets: avoid string truncation
 warnings when copying UNIX path
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503112654.qz6OHyBqNHbBJDBpVoIvuoKqd2pOsJauTL-w3duaHzw@z>

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


