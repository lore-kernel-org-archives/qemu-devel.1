Received: from eggs.gnu.org ([2001:4830:134:3::10]:38151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1f5hkZ-00062s-H4
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 21:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1f5hkU-0004fT-H7
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 21:07:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42468
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1f5hkU-0004ed-Bd
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 21:07:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3A145sY015815
	for <qemu-devel@nongnu.org>; Mon, 9 Apr 2018 21:07:01 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h8jqg17he-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 21:07:00 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 9 Apr 2018 21:06:59 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  9 Apr 2018 19:57:24 -0500
Message-Id: <20180410005724.10059-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.12] make-release: add skiboot .version
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mjt@tls.msk.ru, qemu-stable@nongnu.org

This is needed to build skiboot from tarball-distributed sources
since the git data the make_release.sh script relies on to generate
it is not available.

Cc: qemu-stable@nongnu.org
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 scripts/make-release | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/make-release b/scripts/make-release
index 04fa9defdc..c14f75b12c 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -19,6 +19,7 @@ pushd ${destination}
 git checkout "v${version}"
 git submodule update --init
 (cd roms/seabios && git describe --tags --long --dirty > .version)
+(cd roms/skiboot && ./make_version.sh > .version)
 # FIXME: The following line is a workaround for avoiding filename collisions
 # when unpacking u-boot sources on case-insensitive filesystems. Once we
 # update to something with u-boot commit 610eec7f0 we can drop this line.
-- 
2.11.0
