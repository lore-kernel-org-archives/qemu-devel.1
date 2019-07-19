Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E38C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF7321849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF7321849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoSv1-0000gw-Gg
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35259)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hoStp-000446-7l
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hoStl-00083k-0p
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36973)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hoStk-00082t-Jj
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:26:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F153D5D66B
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 13:26:07 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-48.ams2.redhat.com
 [10.36.112.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C4282FC5E;
 Fri, 19 Jul 2019 13:26:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:25:49 +0100
Message-Id: <20190719132549.14726-6-berrange@redhat.com>
In-Reply-To: <20190719132549.14726-1-berrange@redhat.com>
References: <20190719132549.14726-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 19 Jul 2019 13:26:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/5] crypto: Fix LGPL information in the file
 headers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

It's either "GNU *Library* General Public License version 2" or "GNU
Lesser General Public License version *2.1*", but there was no "version
2.0" of the "Lesser" license. So assume that version 2.1 is meant here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
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
index 5a69b3ce74..409ab50f20 100644
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
index befd8b2c56..7f094e7e96 100644
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
index cefb3b2a7b..4d7cf36a8f 100644
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
index 6988fb210b..340dcfe464 100644
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
index d70d401f87..ee96759f7d 100644
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
index 5438e822fd..71c59cb542 100644
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
index d8c811fd33..bf8413e71a 100644
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
index 10d75da75d..5cece9b244 100644
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
index 115d16dd7b..d7411bb8ff 100644
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
index b3af57961b..e5adb56271 100644
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
index 972beaa0f9..829e48258d 100644
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
index a0096c7c47..82de9db705 100644
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
index 6ffb9c3db7..2a6ee7c7d5 100644
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
index b97323cf90..b0f8228bdc 100644
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
index c30156405a..b305381ec5 100644
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
index 43e258c6f7..3d5a188795 100644
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
index 6c35c0b5ab..d6edecf181 100644
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
index 06f4145fe5..81af198c49 100644
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
index 395501f693..43db898809 100644
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
index fbb7724b20..b377036c19 100644
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
index 0a20fd1fd8..f14100947d 100644
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
index 6a2b3ad01e..12822f8519 100644
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
index 28e5c67383..cecdbedfde 100644
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
index 54ca0d9c75..a8d8e64f4d 100644
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
index 212b3e816b..d6293c25a1 100644
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
index a15044da42..9c4622e424 100644
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
index f22e71d183..b7c7c4a59b 100644
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
index 7aea4ac81f..8306f16b64 100644
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
index ed6c9ca12f..96af91aee4 100644
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
index 66624106fe..f92f96987d 100644
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
index 30294b3229..a75d50ae0c 100644
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
index 50ecb704ee..4e657b850c 100644
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
index 3024b17cfd..d2adc7c131 100644
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
index 13e9b6c0b2..39f1a91c41 100644
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
index 9c53c6c7b1..4b6cf636ce 100644
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
index 5247dd3b18..56dcef3673 100644
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
index c3a920dfe8..33203e8ca7 100644
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
index 4277ad40de..d4a49fdb70 100644
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
index e729d5bd66..fe12899831 100644
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
index bce2d4c8e4..cac90b410c 100644
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
index 077ac7bea0..54d87aa2a1 100644
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
index f79c02266b..00e0f637ce 100644
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
index 0350cd2a93..9b4a62f7bb 100644
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
index ef209b3e03..2c31a44a27 100644
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
index c09998894f..325ff075d8 100644
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
index edd0e13236..5e07e29bae 100644
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
index 6b011e1dbc..fd7a284aa2 100644
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
diff --git a/include/crypto/tlscredsanon.h b/include/crypto/tlscredsanon.=
h
index 4d6b7e4d29..9e9a5ce1a8 100644
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
index 306d36c67d..907035a29b 100644
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
diff --git a/include/crypto/tlscredsx509.h b/include/crypto/tlscredsx509.=
h
index 66ad6a7486..e1542e5c8c 100644
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
index 1c7414e4ff..816300cdcc 100644
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
index 39ccaed822..f267b7824a 100644
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
--=20
2.21.0


