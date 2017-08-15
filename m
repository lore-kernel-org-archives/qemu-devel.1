Received: from eggs.gnu.org ([2001:4830:134:3::10]:35014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhWKQ-0001Kp-21
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhWKO-0004zg-PZ
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:31:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhWKO-0004zV-JR
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:31:52 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 15 Aug 2017 09:31:46 +0200
Message-Id: <20170815073146.11726-2-cohuck@redhat.com>
In-Reply-To: <20170815073146.11726-1-cohuck@redhat.com>
References: <20170815073146.11726-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 1/1] pc-bios/s390-ccw: Use rm command
 during make clean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, Eric Farman <farman@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Eric Farman <farman@linux.vnet.ibm.com>

This reverts a change that replaced the "rm -f" command with the
undefined variable RM (expected to be set by make), and causes the
"make clean" command to fail for a s390 target:

make[1]: Entering directory '/usr/src/qemu/build/pc-bios/s390-ccw'
rm -f *.timestamp
*.o *.d *.img *.elf *~ *.a
/bin/sh: *.o: command not found
Makefile:39: recipe for target 'clean' failed
make[1]: *** [clean] Error 127
make[1]: Leaving directory '/usr/src/qemu/build/pc-bios/s390-ccw'
Makefile:489: recipe for target 'clean' failed
make: *** [clean] Error 1

Fixes: 3e4415a751d2 ("pc-bios/s390-ccw: Add core files for the network
                      bootloading program")
Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
Message-Id: <20170814204450.24118-2-farman@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index cbae74522a..6d0c2ee691 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -36,4 +36,4 @@ s390-netboot.img:
 endif
 
 clean:
-	$(RM) *.o *.d *.img *.elf *~ *.a
+	rm -f *.o *.d *.img *.elf *~ *.a
-- 
2.13.5
