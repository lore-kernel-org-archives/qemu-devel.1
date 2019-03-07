Received: from eggs.gnu.org ([209.51.188.92]:54317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1uUR-0005JJ-5m
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1uUL-0000hX-D3
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:59:17 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  7 Mar 2019 15:58:36 +0100
Message-Id: <20190307145839.13128-2-philmd@redhat.com>
In-Reply-To: <20190307145839.13128-1-philmd@redhat.com>
References: <20190307145839.13128-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/4] tests/multiboot: Improve portability by
 searching bash in the $PATH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kamil Rytarowski <n54@gmx.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Brad Smith <brad@comstyle.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>

Bash is not always installed as /bin/bash. In particular on OpenBSD,
the package installs it in /usr/local/bin.
Use the 'env' shebang to search bash in the $PATH.

Reviewed-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/multiboot/run_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
index 6c33003e71..98df91e6af 100755
--- a/tests/multiboot/run_test.sh
+++ b/tests/multiboot/run_test.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
=20
 # Copyright (c) 2013 Kevin Wolf <kwolf@redhat.com>
 #
--=20
2.20.1
