Received: from eggs.gnu.org ([2001:4830:134:3::10]:45757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1csopn-0002CP-W1
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1csopm-0006OO-Qq
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:58:44 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1csopm-0006Nw-K3
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:58:42 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 11:58:38 +0100
Message-Id: <1490698718-23762-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9] configure: Mark SPARC as supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org

Thanks to John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
and the Debian Project, we now have access to a SPARC Linux
system we can use for build testing. Move SPARC back into
the "supported" list.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We should also at least apply the TCG fixes:
 http://patchwork.ozlabs.org/patch/743890/
 http://patchwork.ozlabs.org/patch/743890/
and ideally the bios-tables-test fix, but that's a testsuite bug:
 http://patchwork.ozlabs.org/patch/744178/

There are 'make check' failures in qga-test on this box but
they don't seem architecture related:
 https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04712.html

I also see some failures in ppc64 guests which might just be
timeout issues and which I haven't investigated yet.
I don't think those are severe enough to worry about for this
release.

 configure | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index d1ce33b..82966f7 100755
--- a/configure
+++ b/configure
@@ -520,11 +520,11 @@ ARCH=
 # Normalise host CPU name and set ARCH.
 # Note that this case should only have supported host CPUs, not guests.
 case "$cpu" in
-  ppc|ppc64|s390|s390x|x32)
+  ppc|ppc64|s390|s390x|sparc64|x32)
     cpu="$cpu"
     supported_cpu="yes"
   ;;
-  ia64|sparc64)
+  ia64)
     cpu="$cpu"
   ;;
   i386|i486|i586|i686|i86pc|BePC)
@@ -549,6 +549,7 @@ case "$cpu" in
   ;;
   sparc|sun4[cdmuv])
     cpu="sparc"
+    supported_cpu="yes"
   ;;
   *)
     # This will result in either an error or falling back to TCI later
-- 
2.7.4
