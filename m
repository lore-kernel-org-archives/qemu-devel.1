Received: from eggs.gnu.org ([2001:4830:134:3::10]:50799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1ckdyT-00047k-At
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1ckdyS-0005Xw-H8
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:45:53 -0500
Received: from mail.kernel.org ([198.145.29.136]:56578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <krzk@kernel.org>) id 1ckdyS-0005WM-Av
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:45:52 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun,  5 Mar 2017 23:45:30 +0200
Message-Id: <20170305214530.19733-2-krzk@kernel.org>
In-Reply-To: <20170305214530.19733-1-krzk@kernel.org>
References: <20170305214530.19733-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH 2/2] char: Remove confusing mix of assignment
 with local variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

The assignment under pointed offset was put next to declaration of local
variables.  This might be quite confusing as the assignment looks like
duplicated declaration of offset variable.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 chardev/char.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/chardev/char.c b/chardev/char.c
index a2571409bf65..b9343e03b9ec 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -104,6 +104,7 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
 {
     const ChardevClass *cc = CHARDEV_GET_CLASS(s);
     int res = 0;
+
     *offset = 0;
 
     qemu_mutex_lock(&s->chr_write_lock);
-- 
2.9.3
