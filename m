Received: from eggs.gnu.org ([2001:4830:134:3::10]:51926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4CDw-0006fE-8G
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4CDt-0006R0-S3
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:42:56 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 16 Oct 2017 23:33:41 +0300
Message-Id: <6b4f250bfc529bdf73a10ca6873a460175e666cc.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/14] Add myself as maintainer for TPM code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

Also add backends/tpm.c to the list of files.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 162e914a2d..cee32914bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1535,12 +1535,14 @@ F: docs/devel/tracing.txt
 T: git git://github.com/stefanha/qemu.git tracing
=20
 TPM
-S: Orphan
+M: Stefan Berger <stefanb@linux.vnet.ibm.com>
+S: Maintained
 F: tpm.c
 F: hw/tpm/*
 F: include/hw/acpi/tpm.h
 F: include/sysemu/tpm*
 F: qapi/tpm.json
+F: backends/tpm.c
=20
 Checkpatch
 S: Odd Fixes
--=20
2.11.0
