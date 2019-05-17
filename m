Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2A6C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EB32173C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EB32173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48945 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRdFl-0001H6-PJ
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:50:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hRdDa-00006m-1m
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hRdDW-0003bC-5X
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:48:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hRdDU-0003Xu-6Q
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:48:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A38E30C1AF7
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 13:48:06 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-116-83.ams2.redhat.com
	[10.36.116.83])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AF4A25DD61;
	Fri, 17 May 2019 13:48:02 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 15:47:47 +0200
Message-Id: <20190517134748.340381-4-sgarzare@redhat.com>
In-Reply-To: <20190517134748.340381-1-sgarzare@redhat.com>
References: <20190517134748.340381-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 17 May 2019 13:48:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/4] net: use g_strsplit() for parsing host
 address and port
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
Cc: Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the glib function to split host address and port in
the parse_host_port() function.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 net/net.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/net/net.c b/net/net.c
index 47c03e5843..23f29ef1d2 100644
--- a/net/net.c
+++ b/net/net.c
@@ -86,32 +86,39 @@ static int get_str_sep(char *buf, int buf_size, const=
 char **pp, int sep)
 int parse_host_port(struct sockaddr_in *saddr, const char *str,
                     Error **errp)
 {
-    char buf[512];
+    gchar **substrings;
     struct hostent *he;
-    const char *p, *r;
-    int port;
+    const char *addr, *p, *r;
+    int port, ret =3D 0;
=20
-    p =3D str;
-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+    substrings =3D g_strsplit(str, ":", 2);
+    if (!substrings || !substrings[0] || !substrings[1]) {
         error_setg(errp, "host address '%s' doesn't contain ':' "
                    "separating host from port", str);
-        return -1;
+        ret =3D -1;
+        goto out;
     }
+
+    addr =3D substrings[0];
+    p =3D substrings[1];
+
     saddr->sin_family =3D AF_INET;
-    if (buf[0] =3D=3D '\0') {
+    if (addr[0] =3D=3D '\0') {
         saddr->sin_addr.s_addr =3D 0;
     } else {
-        if (qemu_isdigit(buf[0])) {
-            if (!inet_aton(buf, &saddr->sin_addr)) {
+        if (qemu_isdigit(addr[0])) {
+            if (!inet_aton(addr, &saddr->sin_addr)) {
                 error_setg(errp, "host address '%s' is not a valid "
-                           "IPv4 address", buf);
-                return -1;
+                           "IPv4 address", addr);
+                ret =3D -1;
+                goto out;
             }
         } else {
-            he =3D gethostbyname(buf);
+            he =3D gethostbyname(addr);
             if (he =3D=3D NULL) {
-                error_setg(errp, "can't resolve host address '%s'", buf)=
;
-                return - 1;
+                error_setg(errp, "can't resolve host address '%s'", addr=
);
+                ret =3D -1;
+                goto out;
             }
             saddr->sin_addr =3D *(struct in_addr *)he->h_addr;
         }
@@ -119,10 +126,14 @@ int parse_host_port(struct sockaddr_in *saddr, cons=
t char *str,
     port =3D strtol(p, (char **)&r, 0);
     if (r =3D=3D p) {
         error_setg(errp, "port number '%s' is invalid", p);
-        return -1;
+        ret =3D -1;
+        goto out;
     }
     saddr->sin_port =3D htons(port);
-    return 0;
+
+out:
+    g_strfreev(substrings);
+    return ret;
 }
=20
 char *qemu_mac_strdup_printf(const uint8_t *macaddr)
--=20
2.20.1


