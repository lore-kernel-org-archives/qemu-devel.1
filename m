Received: from eggs.gnu.org ([2001:4830:134:3::10]:44201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQzFG-0002ZO-Qf
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQzFE-0004bj-5N
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eQzFD-0004Zr-UG
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 265661A406F
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 17:30:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA9CB7F7E0
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 17:30:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Dec 2017 18:30:21 +0100
Message-Id: <20171218173023.21417-9-armbru@redhat.com>
In-Reply-To: <20171218173023.21417-1-armbru@redhat.com>
References: <20171218173023.21417-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/10] qemu-options: Belatedly document
 --watchdog-action inject-nmi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Missed in commit 795dc6e46d, v2.4.0.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-options.hx | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 80b2331a32..84f41e6ac4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3622,7 +3622,7 @@ A virtual watchdog for s390x backed by the diagnose=
 288 hypercall
 ETEXI
=20
 DEF("watchdog-action", HAS_ARG, QEMU_OPTION_watchdog_action, \
-    "-watchdog-action reset|shutdown|poweroff|pause|debug|none\n" \
+    "-watchdog-action reset|shutdown|poweroff|inject-nmi|pause|debug|non=
e\n" \
     "                action when watchdog fires [default=3Dreset]\n",
     QEMU_ARCH_ALL)
 STEXI
@@ -3636,6 +3636,7 @@ The default is
 Other possible actions are:
 @code{shutdown} (attempt to gracefully shutdown the guest),
 @code{poweroff} (forcefully poweroff the guest),
+@code{inject-nmi} (inject a NMI into the guest),
 @code{pause} (pause the guest),
 @code{debug} (print a debug message and continue), or
 @code{none} (do nothing).
--=20
2.13.6
