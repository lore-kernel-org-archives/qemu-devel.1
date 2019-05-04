Received: from eggs.gnu.org ([209.51.188.92]:41673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMupT-0004Uk-90
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMupS-00056V-8O
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:35:51 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat,  4 May 2019 15:35:39 +0200
Message-Id: <20190504133540.19758-2-philmd@redhat.com>
In-Reply-To: <20190504133540.19758-1-philmd@redhat.com>
References: <20190504133540.19758-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/2] roms: Correct the
 EDK2_BASETOOLS_OPTFLAGS variable description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

In commit 1cab464136b4 we incorrectly described the
EDK2_BASETOOLS_OPTFLAGS can pass CPPFLAGS and CFLAGS
options to the EDK2 build tools, but it only expands
the CFLAGS (not to the CPPFLAGS).
Update the description to be more accurate.

Reported-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index 0ce84a45ad5..f020102c866 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -121,8 +121,8 @@ build-efi-roms: build-pxe-roms
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
=20
-# Build scripts can pass compiler/linker flags to the EDK2 build tools
-# via the EDK2_BASETOOLS_OPTFLAGS (CPPFLAGS and CFLAGS) and
+# Build scripts can pass compiler/linker flags to the EDK2
+# build  tools via the EDK2_BASETOOLS_OPTFLAGS (CFLAGS) and
 # EDK2_BASETOOLS_LDFLAGS (LDFLAGS) environment variables.
 #
 # Example:
--=20
2.20.1
