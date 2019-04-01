Received: from eggs.gnu.org ([209.51.188.92]:43538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47z-0004cB-C7
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47v-0005cN-IE
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB47s-0005QS-IV
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:53 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L5K7b006368
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:05:29 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkqrc0863-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:05:24 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:41 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:34 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-61-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 60/97] make-release: add skiboot .version file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

This is needed to build skiboot from tarball-distributed sources
since the git data the make_release.sh script relies on to generate
it is not available.

Cc: qemu-stable@nongnu.org
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20181109161352.29873-1-mdroth@linux.vnet.ibm.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 3fccd3f26ef3c0c76a06c138b17af6d55a5d9904)
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
 # FIXME: The following line is a workaround for avoiding filename collis=
ions
 # when unpacking u-boot sources on case-insensitive filesystems. Once we
 # update to something with u-boot commit 610eec7f0 we can drop this line.
--=20
2.17.1
