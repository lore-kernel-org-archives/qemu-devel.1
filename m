Received: from eggs.gnu.org ([2001:4830:134:3::10]:39773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9xDU-00070q-NS
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 13:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9xDO-00078w-OD
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 13:54:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50374
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e9xDO-00078h-IE
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 13:54:10 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA1Hqsxx088851
	for <qemu-devel@nongnu.org>; Wed, 1 Nov 2017 13:54:07 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dyhepwfkh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 13:54:07 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 1 Nov 2017 11:54:06 -0600
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed,  1 Nov 2017 15:53:56 -0200
Message-Id: <20171101175356.11771-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] configure: adding ppc64le to supported host
 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

When executing 'configure' in a fresh QEMU clone, in a fresh
OS install running in a ppc64le host, this is the error
shown:

-----

../configure --enable-trace-backend=simple --enable-debug
    --target-list=ppc64-softmmu

ERROR: Unsupported CPU = ppc64le, try --enable-tcg-interpreter

-----

This isn't true, ppc64le host CPU is supported.

This patch adds 'ppc64le' to the list of supported host CPUs. After
this patch, the next error when executing configure in the
scenario mentioned is:

-----

../configure --enable-trace-backend=simple --enable-debug
    --target-list=ppc64-softmmu

ERROR: "cc" either does not exist or does not work

-----

Indicating that now we need a valid compiler to proceed.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 285d123dbf..38c1003fb3 100755
--- a/configure
+++ b/configure
@@ -637,7 +637,7 @@ ARCH=
 # Normalise host CPU name and set ARCH.
 # Note that this case should only have supported host CPUs, not guests.
 case "$cpu" in
-  ppc|ppc64|s390|s390x|sparc64|x32)
+  ppc|ppc64|ppc64le|s390|s390x|sparc64|x32)
     cpu="$cpu"
     supported_cpu="yes"
   ;;
-- 
2.13.6
