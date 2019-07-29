Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81694C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FF220693
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FF220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs1A5-00017j-Jo
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 04:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48056)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hs16Z-0004VL-9C
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hs16X-0003Ik-73
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:34:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hs16V-0003Hy-5f
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:34:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 617BC3082133;
 Mon, 29 Jul 2019 08:33:58 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-203.pek2.redhat.com
 [10.72.12.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B790410190AA;
 Mon, 29 Jul 2019 08:33:56 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Mon, 29 Jul 2019 16:33:45 +0800
Message-Id: <1564389226-4489-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1564389226-4489-1-git-send-email-jasowang@redhat.com>
References: <1564389226-4489-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 29 Jul 2019 08:33:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/5] net: tap: replace snprintf with
 g_strdup_printf calls
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
Cc: Jason Wang <jasowang@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When invoking qemu-bridge-helper in 'net_bridge_run_helper',
instead of using fixed sized buffers, use dynamically allocated
ones initialised and returned by g_strdup_printf().

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index e8aadd8..fc38029 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -498,9 +498,9 @@ static int net_bridge_run_helper(const char *helper, =
const char *bridge,
     }
     if (pid =3D=3D 0) {
         int open_max =3D sysconf(_SC_OPEN_MAX), i;
-        char fd_buf[6+10];
-        char br_buf[6+IFNAMSIZ] =3D {0};
-        char helper_cmd[PATH_MAX + sizeof(fd_buf) + sizeof(br_buf) + 15]=
;
+        char *fd_buf =3D NULL;
+        char *br_buf =3D NULL;
+        char *helper_cmd =3D NULL;
=20
         for (i =3D 3; i < open_max; i++) {
             if (i !=3D sv[1]) {
@@ -508,17 +508,17 @@ static int net_bridge_run_helper(const char *helper=
, const char *bridge,
             }
         }
=20
-        snprintf(fd_buf, sizeof(fd_buf), "%s%d", "--fd=3D", sv[1]);
+        fd_buf =3D g_strdup_printf("%s%d", "--fd=3D", sv[1]);
=20
         if (strrchr(helper, ' ') || strrchr(helper, '\t')) {
             /* assume helper is a command */
=20
             if (strstr(helper, "--br=3D") =3D=3D NULL) {
-                snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=3D", brid=
ge);
+                br_buf =3D g_strdup_printf("%s%s", "--br=3D", bridge);
             }
=20
-            snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s %s",
-                     helper, "--use-vnet", fd_buf, br_buf);
+            helper_cmd =3D g_strdup_printf("%s %s %s %s", helper,
+                            "--use-vnet", fd_buf, br_buf ? br_buf : "");
=20
             parg =3D args;
             *parg++ =3D (char *)"sh";
@@ -527,10 +527,11 @@ static int net_bridge_run_helper(const char *helper=
, const char *bridge,
             *parg++ =3D NULL;
=20
             execv("/bin/sh", args);
+            g_free(helper_cmd);
         } else {
             /* assume helper is just the executable path name */
=20
-            snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=3D", bridge);
+            br_buf =3D g_strdup_printf("%s%s", "--br=3D", bridge);
=20
             parg =3D args;
             *parg++ =3D (char *)helper;
@@ -541,6 +542,8 @@ static int net_bridge_run_helper(const char *helper, =
const char *bridge,
=20
             execv(helper, args);
         }
+        g_free(fd_buf);
+        g_free(br_buf);
         _exit(1);
=20
     } else {
--=20
2.5.0


