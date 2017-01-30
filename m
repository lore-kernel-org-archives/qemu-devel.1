Received: from eggs.gnu.org ([2001:4830:134:3::10]:55722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cYDHu-0000HX-65
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cYDHq-0004ZB-5v
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:50:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cYDHq-0004Yo-04
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:50:30 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 30 Jan 2017 15:50:25 +0100
Message-Id: <20170130145025.26475-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH] target/s390x: use "qemu" cpu model in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, rth@twiddle.net, agraf@suse.de, sw@weilnetz.de, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, riku.voipio@iki.fi, david@redhat.com

"any" does not exist, therefore resulting in a misleading error message.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 linux-user/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 3004958..e588f58 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4322,6 +4322,8 @@ int main(int argc, char **argv, char **envp)
 # endif
 #elif defined TARGET_SH4
         cpu_model = TYPE_SH7785_CPU;
+#elif defined TARGET_S390X
+        cpu_model = "qemu";
 #else
         cpu_model = "any";
 #endif
-- 
2.9.3
