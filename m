Received: from eggs.gnu.org ([2001:4830:134:3::10]:54772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtT-00067Q-EH
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtP-00073L-Vx
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtP-00071e-P8
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCD43C054905
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9836217D23
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:30 +0100
Message-Id: <1489645685-4750-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for 2.9 14/49] qapi/rocker: Fix up doc comment
 notes on optional members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Talking about #optional like this

    # Note: fields are marked #optional to indicate that they may or may
    # not appear ...

doesn't work so well in generated documentation, because the #optional
tag is not visible there.  Replace by

    # Note: optional members may or may not appear ...

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <1489582656-31133-13-git-send-email-armbru@redhat.com>
---
 qapi/rocker.json | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/qapi/rocker.json b/qapi/rocker.json
index 97e2b83..f374038 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -1,3 +1,5 @@
+# -*- Mode: Python -*-
+
 ##
 # =3D Rocker switch device
 ##
@@ -137,8 +139,8 @@
 #
 # @ip-dst: #optional IP header destination address
 #
-# Note: fields are marked #optional to indicate that they may or may not
-# appear in the flow key depending if they're relevant to the flow key.
+# Note: optional members may or may not appear in the flow key
+# depending if they're relevant to the flow key.
 #
 # Since: 2.4
 ##
@@ -167,8 +169,8 @@
 #
 # @ip-tos: #optional IP header TOS field
 #
-# Note: fields are marked #optional to indicate that they may or may not
-# appear in the flow mask depending if they're relevant to the flow mask=
.
+# Note: optional members may or may not appear in the flow mask
+# depending if they're relevant to the flow mask.
 #
 # Since: 2.4
 ##
@@ -194,8 +196,8 @@
 #
 # @out-pport: #optional physical output port
 #
-# Note: fields are marked #optional to indicate that they may or may not
-# appear in the flow action depending if they're relevant to the flow ac=
tion.
+# Note: optional members may or may not appear in the flow action
+# depending if they're relevant to the flow action.
 #
 # Since: 2.4
 ##
@@ -288,8 +290,8 @@
 #
 # @ttl-check: #optional perform TTL check
 #
-# Note: fields are marked #optional to indicate that they may or may not
-# appear in the group depending if they're relevant to the group type.
+# Note: optional members may or may not appear in the group depending
+# if they're relevant to the group type.
 #
 # Since: 2.4
 ##
--=20
2.7.4
