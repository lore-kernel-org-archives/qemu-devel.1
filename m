Received: from eggs.gnu.org ([2001:4830:134:3::10]:49533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apilotti@cloudbasesolutions.com>) id 1f1GVB-0006Ea-BJ
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 15:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apilotti@cloudbasesolutions.com>) id 1f1GV7-0004U9-BE
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 15:12:53 -0400
Received: from smtp1.cloudbase.it ([46.107.15.2]:28076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apilotti@cloudbasesolutions.com>)
	id 1f1GV7-0004TB-3Y
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 15:12:49 -0400
From: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Date: Wed, 28 Mar 2018 22:12:20 +0300
Message-Id: <20180328191221.64777-1-apilotti@cloudbasesolutions.com>
Subject: [Qemu-devel] [PATCH 0/1] WHPX Add signature CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, juterry@microsoft.com, Alessandro Pilotti <apilotti@cloudbasesolutions.com>

Add support for CPUID 0x40000000 in WHPX, requiring Justin Terry's patch
that adds support for CPUID 1.

Based-on: <20180326170658.606-1-juterry@microsoft.com>

Alessandro Pilotti (1):
  WHPX Add signature CPUID

 target/i386/whpx-all.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--
2.13.2
