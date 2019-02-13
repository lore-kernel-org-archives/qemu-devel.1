Received: from eggs.gnu.org ([209.51.188.92]:59280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtwsY-0001CB-SK
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:55:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtwsP-0001P7-5F
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:55:14 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Feb 2019 16:54:59 +0100
Message-Id: <1550073299-3647-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] crypto: Fix LGPL information in the file
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-trivial@nongnu.org

It's either "GNU *Library* General Public License version 2" or "GNU
Lesser General Public License version *2.1*", but there was no "version
2.0" of the "Lesser" license. So assume that version 2.1 is meant here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 crypto/block-luks.c           | 2 +-
 crypto/block-luks.h           | 2 +-
 crypto/block-qcow.c           | 2 +-
 crypto/block-qcow.h           | 2 +-
 crypto/block.c                | 2 +-
 crypto/blockpriv.h            | 2 +-
 crypto/cipher-builtin.c       | 2 +-
 crypto/cipher-gcrypt.c        | 2 +-
 crypto/cipher-nettle.c        | 2 +-
 crypto/cipher.c               | 2 +-
 crypto/hash-gcrypt.c          | 2 +-
 crypto/hash-glib.c            | 2 +-
 crypto/hash-nettle.c          | 2 +-
 crypto/hash.c                 | 2 +-
 crypto/init.c                 | 2 +-
 crypto/ivgen-essiv.c          | 2 +-
 crypto/ivgen-essiv.h          | 2 +-
 crypto/ivgen-plain.c          | 2 +-
 crypto/ivgen-plain.h          | 2 +-
 crypto/ivgen-plain64.c        | 2 +-
 crypto/ivgen-plain64.h        | 2 +-
 crypto/ivgen.c                | 2 +-
 crypto/ivgenpriv.h            | 2 +-
 crypto/pbkdf-gcrypt.c         | 2 +-
 crypto/pbkdf-nettle.c         | 2 +-
 crypto/pbkdf-stub.c           | 2 +-
 crypto/pbkdf.c                | 2 +-
 crypto/random-gcrypt.c        | 2 +-
 crypto/random-gnutls.c        | 2 +-
 crypto/random-platform.c      | 2 +-
 crypto/secret.c               | 2 +-
 crypto/tlscreds.c             | 2 +-
 crypto/tlscredsanon.c         | 2 +-
 crypto/tlscredspriv.h         | 2 +-
 crypto/tlscredspsk.c          | 2 +-
 crypto/tlscredsx509.c         | 2 +-
 crypto/tlssession.c           | 2 +-
 crypto/xts.c                  | 2 +-
 include/crypto/block.h        | 2 +-
 include/crypto/cipher.h       | 2 +-
 include/crypto/hash.h         | 2 +-
 include/crypto/init.h         | 2 +-
 include/crypto/ivgen.h        | 2 +-
 include/crypto/pbkdf.h        | 2 +-
 include/crypto/random.h       | 2 +-
 include/crypto/secret.h       | 2 +-
 include/crypto/tlscreds.h     | 2 +-
 include/crypto/tlscredsanon.h | 2 +-
 include/crypto/tlscredspsk.h  | 2 +-
 include/crypto/tlscredsx509.h | 2 +-
 include/crypto/tlssession.h   | 2 +-
 include/crypto/xts.h          | 2 +-
 52 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 6bac79c..4d2b59a 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/block-luks.h b/crypto/block-luks.h
index befd8b2..7f094e7 100644
--- a/crypto/block-luks.h
+++ b/crypto/block-luks.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index cefb3b2..4d7cf36 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/block-qcow.h b/crypto/block-qcow.h
index 6988fb2..340dcfe 100644
--- a/crypto/block-qcow.h
+++ b/crypto/block-qcow.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/block.c b/crypto/block.c
index d70d401..ee96759 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 5438e82..71c59cb 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
index d8c811f..bf8413e 100644
--- a/crypto/cipher-builtin.c
+++ b/crypto/cipher-builtin.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index 10d75da..5cece9b 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index 3848cb3..9f87799 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/cipher.c b/crypto/cipher.c
index b3af579..e5adb56 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index 972beaa..829e482 100644
--- a/crypto/hash-gcrypt.c
+++ b/crypto/hash-gcrypt.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index a0096c7..82de9db 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 96f186f..6b0a8f7 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/hash.c b/crypto/hash.c
index b97323c..b0f8228 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/init.c b/crypto/init.c
index c301564..b305381 100644
--- a/crypto/init.c
+++ b/crypto/init.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/ivgen-essiv.c b/crypto/ivgen-essiv.c
index 43e258c..3d5a188 100644
--- a/crypto/ivgen-essiv.c
+++ b/crypto/ivgen-essiv.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/ivgen-essiv.h b/crypto/ivgen-essiv.h
index f34dbab..2cce33d 100644
--- a/crypto/ivgen-essiv.h
+++ b/crypto/ivgen-essiv.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/ivgen-plain.c b/crypto/ivgen-plain.c
index 06f4145..81af198 100644
--- a/crypto/ivgen-plain.c
+++ b/crypto/ivgen-plain.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/ivgen-plain.h b/crypto/ivgen-plain.h
index 16e1ae5..1938329 100644
--- a/crypto/ivgen-plain.h
+++ b/crypto/ivgen-plain.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/ivgen-plain64.c b/crypto/ivgen-plain64.c
index fbb7724..b377036 100644
--- a/crypto/ivgen-plain64.c
+++ b/crypto/ivgen-plain64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/ivgen-plain64.h b/crypto/ivgen-plain64.h
index f8611bd..f87cfd3 100644
--- a/crypto/ivgen-plain64.h
+++ b/crypto/ivgen-plain64.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/ivgen.c b/crypto/ivgen.c
index 6a2b3ad..12822f8 100644
--- a/crypto/ivgen.c
+++ b/crypto/ivgen.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/ivgenpriv.h b/crypto/ivgenpriv.h
index 28e5c67..cecdbed 100644
--- a/crypto/ivgenpriv.h
+++ b/crypto/ivgenpriv.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/pbkdf-gcrypt.c b/crypto/pbkdf-gcrypt.c
index 54ca0d9..a8d8e64 100644
--- a/crypto/pbkdf-gcrypt.c
+++ b/crypto/pbkdf-gcrypt.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/pbkdf-nettle.c b/crypto/pbkdf-nettle.c
index 212b3e8..d6293c2 100644
--- a/crypto/pbkdf-nettle.c
+++ b/crypto/pbkdf-nettle.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/pbkdf-stub.c b/crypto/pbkdf-stub.c
index a15044d..9c4622e 100644
--- a/crypto/pbkdf-stub.c
+++ b/crypto/pbkdf-stub.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/pbkdf.c b/crypto/pbkdf.c
index f22e71d..b7c7c4a 100644
--- a/crypto/pbkdf.c
+++ b/crypto/pbkdf.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/random-gcrypt.c b/crypto/random-gcrypt.c
index 9f1c9ee..f405a64 100644
--- a/crypto/random-gcrypt.c
+++ b/crypto/random-gcrypt.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/random-gnutls.c b/crypto/random-gnutls.c
index 445fd6a..4c411be 100644
--- a/crypto/random-gnutls.c
+++ b/crypto/random-gnutls.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/random-platform.c b/crypto/random-platform.c
index 7541b4c..4b1613c 100644
--- a/crypto/random-platform.c
+++ b/crypto/random-platform.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/secret.c b/crypto/secret.c
index 388abd7..4a833d8 100644
--- a/crypto/secret.c
+++ b/crypto/secret.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 02255a6..339a950 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 7ad66d1..c2090a0 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/tlscredspriv.h b/crypto/tlscredspriv.h
index 13e9b6c..39f1a91 100644
--- a/crypto/tlscredspriv.h
+++ b/crypto/tlscredspriv.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index 7be7c8e..f9e36f5 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index d6ab4a9..6da2eef 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 0dedd4a..6dec913 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/crypto/xts.c b/crypto/xts.c
index 4277ad4..d4a49fd 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/crypto/block.h b/include/crypto/block.h
index e729d5b..fe12899 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index bce2d4c..cac90b4 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 077ac7b..54d87aa 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/crypto/init.h b/include/crypto/init.h
index f79c022..00e0f63 100644
--- a/include/crypto/init.h
+++ b/include/crypto/init.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/crypto/ivgen.h b/include/crypto/ivgen.h
index 0350cd2..9b4a62f 100644
--- a/include/crypto/ivgen.h
+++ b/include/crypto/ivgen.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/crypto/pbkdf.h b/include/crypto/pbkdf.h
index ef209b3..2c31a44 100644
--- a/include/crypto/pbkdf.h
+++ b/include/crypto/pbkdf.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/crypto/random.h b/include/crypto/random.h
index 8764ca0..80784e0 100644
--- a/include/crypto/random.h
+++ b/include/crypto/random.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/crypto/secret.h b/include/crypto/secret.h
index edd0e13..5e07e29 100644
--- a/include/crypto/secret.h
+++ b/include/crypto/secret.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/crypto/tlscreds.h b/include/crypto/tlscreds.h
index 6b011e1..fd7a284 100644
--- a/include/crypto/tlscreds.h
+++ b/include/crypto/tlscreds.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/crypto/tlscredsanon.h b/include/crypto/tlscredsanon.h
index 4d6b7e4..9e9a5ce 100644
--- a/include/crypto/tlscredsanon.h
+++ b/include/crypto/tlscredsanon.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/crypto/tlscredspsk.h b/include/crypto/tlscredspsk.h
index 306d36c..907035a 100644
--- a/include/crypto/tlscredspsk.h
+++ b/include/crypto/tlscredspsk.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/crypto/tlscredsx509.h b/include/crypto/tlscredsx509.h
index 66ad6a7..e1542e5 100644
--- a/include/crypto/tlscredsx509.h
+++ b/include/crypto/tlscredsx509.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index 1c7414e..816300c 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/crypto/xts.h b/include/crypto/xts.h
index 3c8967a..edaabda 100644
--- a/include/crypto/xts.h
+++ b/include/crypto/xts.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
1.8.3.1
