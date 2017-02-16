Received: from eggs.gnu.org ([2001:4830:134:3::10]:48484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxI-0002Cx-Qo
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxF-0002IM-KK
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:22:44 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:63469)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceMxF-0002Hw-92
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:22:41 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:22:14 +0100
Message-Id: <20170216142227.27448-2-laurent@vivier.eu>
In-Reply-To: <20170216142227.27448-1-laurent@vivier.eu>
References: <20170216142227.27448-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 01/14] linux-user: remove ifdef __USER_MISC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Riku Voipio <riku.voipio@linaro.org>

From: Riku Voipio <riku.voipio@linaro.org>

This preprocessor macro isn't set anywhere. Remove
the check so -strace can show these options.

Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/strace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 489dbc9..8fb1b6e 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -90,10 +90,8 @@ if( cmd == val ) { \
     output_cmd( IPC_STAT );
     output_cmd( IPC_INFO );
     /* msgctl() commands */
-    #ifdef __USER_MISC
     output_cmd( MSG_STAT );
     output_cmd( MSG_INFO );
-    #endif
     /* shmctl() commands */
     output_cmd( SHM_LOCK );
     output_cmd( SHM_UNLOCK );
-- 
2.9.3
