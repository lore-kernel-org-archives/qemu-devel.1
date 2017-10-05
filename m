Received: from eggs.gnu.org ([2001:4830:134:3::10]:54659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e03lC-000352-PY
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e03l6-0003Un-RR
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e03l6-0003TU-Lo
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C460C0587E8
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 10:52:03 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  5 Oct 2017 11:51:56 +0100
Message-Id: <20171005105157.10831-5-dgilbert@redhat.com>
In-Reply-To: <20171005105157.10831-1-dgilbert@redhat.com>
References: <20171005105157.10831-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] hmp-commands-info: Move Texinfo stanzas to
 conventional place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

From: Markus Armbruster <armbru@redhat.com>

A command's STEXI..ETEXI stanza follows the command's initializer.
Two commands got them backwards.  Correct that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171002134538.23332-3-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands-info.hx | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 574db7d24e..d27d3b1227 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -837,12 +837,6 @@ STEXI
 Show information about hotpluggable CPUs
 ETEXI
=20
-STEXI
-@item info vm-generation-id
-@findex vm-generation-id
-Show Virtual Machine Generation ID
-ETEXI
-
     {
         .name       =3D "vm-generation-id",
         .args_type  =3D "",
@@ -852,10 +846,9 @@ ETEXI
     },
=20
 STEXI
-@item info memory_size_summary
-@findex memory_size_summary
-Display the amount of initially allocated and present hotpluggable (if
-enabled) memory in bytes.
+@item info vm-generation-id
+@findex vm-generation-id
+Show Virtual Machine Generation ID
 ETEXI
=20
     {
@@ -868,6 +861,13 @@ ETEXI
     },
=20
 STEXI
+@item info memory_size_summary
+@findex memory_size_summary
+Display the amount of initially allocated and present hotpluggable (if
+enabled) memory in bytes.
+ETEXI
+
+STEXI
 @end table
 ETEXI
=20
--=20
2.13.6
