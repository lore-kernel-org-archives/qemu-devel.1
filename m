Received: from eggs.gnu.org ([209.51.188.92]:36981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bf3-0005nY-QX
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bf3-0000LC-7U
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h2Bf3-0000K9-0Z
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:25 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  8 Mar 2019 10:18:42 +0100
Message-Id: <1552036723-1949-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1552036723-1949-1-git-send-email-thuth@redhat.com>
References: <1552036723-1949-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/7] tests/bios-tables: Improve portability by
 searching bash in the $PATH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Bash is not always installed as /bin/bash. In particular on OpenBSD,
the package installs it in /usr/local/bin.
Use the 'env' shebang to search bash in the $PATH.

Reviewed-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/data/acpi/rebuild-expected-aml.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/re=
build-expected-aml.sh
index bf9ba24..abdff70 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -1,4 +1,4 @@
-#! /bin/bash
+#!/usr/bin/env bash
=20
 #
 # Rebuild expected AML files for acpi unit-test
--=20
1.8.3.1
