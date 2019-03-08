Received: from eggs.gnu.org ([209.51.188.92]:59360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5X-0008CF-Bn
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5U-0005tz-FM
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:58:57 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:57:57 +0100
Message-Id: <20190308125823.32535-8-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/33] tests/multiboot: Improve portability by
 searching bash in the $PATH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Bash is not always installed as /bin/bash. In particular on OpenBSD,
the package installs it in /usr/local/bin.
Use the 'env' shebang to search bash in the $PATH.

Reviewed-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
