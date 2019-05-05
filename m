Received: from eggs.gnu.org ([209.51.188.92]:37957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNIOW-0008W4-C9
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNIOV-0004v1-0u
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:45:36 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Sun,  5 May 2019 16:45:27 +0200
Message-Id: <20190505144527.27926-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] virtfs: Add missing "id" parameter in
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

... and remove the square brackets from "path" and "security_model",
since these parameters are not optional.

Buglink: https://bugs.launchpad.net/qemu/+bug/1581976
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 51802cbb26..9571ddd141 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1311,7 +1311,7 @@ DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
=20
 STEXI
=20
-@item -virtfs @var{fsdriver}[,path=3D@var{path}],mount_tag=3D@var{mount_=
tag}[,security_model=3D@var{security_model}][,writeout=3D@var{writeout}][=
,readonly][,socket=3D@var{socket}|sock_fd=3D@var{sock_fd}][,fmode=3D@var{=
fmode}][,dmode=3D@var{dmode}]
+@item -virtfs @var{fsdriver},path=3D@var{path},mount_tag=3D@var{mount_ta=
g},security_model=3D@var{security_model}[,id=3D@var{id}][,writeout=3D@var=
{writeout}][,readonly][,socket=3D@var{socket}|sock_fd=3D@var{sock_fd}][,f=
mode=3D@var{fmode}][,dmode=3D@var{dmode}]
 @findex -virtfs
=20
 The general form of a Virtual File system pass-through options are:
--=20
2.21.0
