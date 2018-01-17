Received: from eggs.gnu.org ([2001:4830:134:3::10]:41356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnbt-0004GR-A8
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnbs-0007kd-Cw
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:18:33 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnbs-0007kP-9D
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:18:32 -0500
Received: by mail-qk0-x242.google.com with SMTP id b76so25193527qkc.1
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 05:18:32 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 17 Jan 2018 10:18:19 -0300
Message-Id: <20180117131821.18700-2-f4bug@amsat.org>
In-Reply-To: <20180117131821.18700-1-f4bug@amsat.org>
References: <20180117131821.18700-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/3] compiler: add QEMU_WARN_NONNULL_ARGS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Stefan Weil <sw@weilnetz.de>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/compiler.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 340e5fdc09..d9b2489391 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -26,6 +26,8 @@
 
 #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
 
+#define QEMU_WARN_NONNULL_ARGS(args...) __attribute__((nonnull(args)))
+
 #define QEMU_SENTINEL __attribute__((sentinel))
 
 #if QEMU_GNUC_PREREQ(4, 3)
-- 
2.15.1
