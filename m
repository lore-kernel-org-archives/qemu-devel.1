Received: from eggs.gnu.org ([209.51.188.92]:37263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gopq8-0001pW-8H
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gopq4-0006ry-7G
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:38 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 30 Jan 2019 14:22:08 +0100
Message-Id: <20190130132214.25493-8-laurent@vivier.eu>
In-Reply-To: <20190130132214.25493-1-laurent@vivier.eu>
References: <20190130132214.25493-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/13] target/openrisc: Fix LGPL version number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Stefan Hajnoczi <stefanha@redhat.com>, Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

From: Thomas Huth <thuth@redhat.com>

It's either "GNU *Library* General Public version 2" or "GNU Lesser
General Public version *2.1*", but there was no "version 2.0" of the
"Lesser" library. So assume that version 2.1 is meant here.

Cc: Stafford Horne <shorne@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1548252536-6242-3-git-send-email-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/openrisc/cpu.c              | 2 +-
 target/openrisc/exception.h        | 2 +-
 target/openrisc/gdbstub.c          | 2 +-
 target/openrisc/helper.h           | 2 +-
 target/openrisc/interrupt_helper.c | 2 +-
 target/openrisc/sys_helper.c       | 2 +-
 target/openrisc/translate.c        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index fb7cb5c507..541b2a66c7 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/openrisc/exception.h b/target/openrisc/exception.h
index 4ec56b4653..c9c4e471d2 100644
--- a/target/openrisc/exception.h
+++ b/target/openrisc/exception.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index f9af6507f3..43b1a18d4b 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index 9db9bf3963..96d79a8113 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/openrisc/interrupt_helper.c b/target/openrisc/interrupt_helper.c
index 9c5489f5f7..ab4ea88b69 100644
--- a/target/openrisc/interrupt_helper.c
+++ b/target/openrisc/interrupt_helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index b66a45c1e0..05f66c455b 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index c089914d6a..89680f882d 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.20.1
