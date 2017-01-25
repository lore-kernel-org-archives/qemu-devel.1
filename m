Received: from eggs.gnu.org ([2001:4830:134:3::10]:33193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWVYl-0006nS-7C
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:56:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWVYi-0003Zt-7p
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:56:55 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:58744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cWVYh-0003Z0-UD
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:56:52 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 25 Jan 2017 22:56:37 +0100
Message-Id: <20170125215637.2992-4-laurent@vivier.eu>
In-Reply-To: <20170125215637.2992-1-laurent@vivier.eu>
References: <20170125215637.2992-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 3/3] linux-user: define correct UTS machine
 name for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>

the correct UTS machine name (as expected by systemd) is "parisc",
not "hppa".

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/uname.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/uname.c b/linux-user/uname.c
index 313b79d..daad002 100644
--- a/linux-user/uname.c
+++ b/linux-user/uname.c
@@ -63,6 +63,8 @@ const char *cpu_to_uname_machine(void *cpu_env)
         return "i586";
     }
     return "i686";
+#elif defined(TARGET_HPPA)
+    return "parisc";
 #else
     /* default is #define-d in each arch/ subdir */
     return UNAME_MACHINE;
-- 
2.9.3
