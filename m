Received: from eggs.gnu.org ([2001:4830:134:3::10]:34527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gA7iY-00027m-LN
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gA7iW-0008FN-0I
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gA7iV-0007dD-NI
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D24F88319
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 06:11:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 10 Oct 2018 08:11:10 +0200
Message-Id: <20181010061113.6057-3-armbru@redhat.com>
In-Reply-To: <20181010061113.6057-1-armbru@redhat.com>
References: <20181010061113.6057-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] qapi/misc.json: Remove superfluous words in
 CpuModelExpansionType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>

From: Kashyap Chamarthy <kchamart@redhat.com>

Remove repetition of 'independent of'.  While at it, s/QMU/QEMU in
@CpuDefinitionInfo.

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
Message-Id: <20181003104605.8477-1-kchamart@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
[Commit message updated as requested by Kashyap]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/misc.json | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index ada9af5add..f98de3a58c 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2017,7 +2017,7 @@
 #
 # @migration-safe: whether a CPU definition can be safely used for
 #                  migration in combination with a QEMU compatibility ma=
chine
-#                  when migrating between different QMU versions and bet=
ween
+#                  when migrating between different QEMU versions and be=
tween
 #                  hosts with different sets of (hardware or software)
 #                  capabilities. If not provided, information is not ava=
ilable
 #                  and callers should not assume the CPU definition to b=
e
@@ -2126,11 +2126,11 @@
 # @static: Expand to a static CPU model, a combination of a static base
 #          model name and property delta changes. As the static base mod=
el will
 #          never change, the expanded CPU model will be the same, indepe=
ndent of
-#          independent of QEMU version, machine type, machine options, a=
nd
-#          accelerator options. Therefore, the resulting model can be us=
ed by
-#          tooling without having to specify a compatibility machine - e=
.g. when
-#          displaying the "host" model. static CPU models are migration-=
safe.
-#
+#          QEMU version, machine type, machine options, and accelerator =
options.
+#          Therefore, the resulting model can be used by tooling without=
 having
+#          to specify a compatibility machine - e.g. when displaying the=
 "host"
+#          model. The @static CPU models are migration-safe.
+
 # @full: Expand all properties. The produced model is not guaranteed to =
be
 #        migration-safe, but allows tooling to get an insight and work w=
ith
 #        model details.
--=20
2.17.1
