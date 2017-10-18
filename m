Received: from eggs.gnu.org ([2001:4830:134:3::10]:58577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXU-0005C9-Hm
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXR-0003uJ-Di
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:35 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:49430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1e4nXR-0003te-6m
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:33 -0400
Received: by mail-lf0-x244.google.com with SMTP id w21so5625622lfc.6
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 05:33:33 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 18 Oct 2017 15:33:17 +0300
Message-Id: <dd13df011d6e28beb16ef9e4548cd55fee84cb08.1508329282.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1508329282.git.riku.voipio@linaro.org>
References: <cover.1508329282.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/10] linux-user: remove duplicate break in
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

From: Carlo Marcelo Arenas Belón <carenas@gmail.com>

likely introduced in 3532fa7402cda16f7b95261b0339c58630051f0b

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 08fbc4d5f7..a25bbffd16 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3134,7 +3134,6 @@ set_timeout:
         case TARGET_SO_RCVLOWAT:
 		optname = SO_RCVLOWAT;
 		break;
-            break;
         default:
             goto unimplemented;
         }
-- 
2.14.2
