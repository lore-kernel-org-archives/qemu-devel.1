Received: from eggs.gnu.org ([2001:4830:134:3::10]:60446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ondrejj@salstar.sk>) id 1cHSDg-0002Rn-72
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ondrejj@salstar.sk>) id 1cHSDc-0004LW-U8
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:20:56 -0500
Received: from work.salstar.sk ([158.197.240.41]:33802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ondrejj@salstar.sk>) id 1cHSDc-0004Ky-Jf
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:20:52 -0500
Date: Thu, 15 Dec 2016 10:20:47 +0100
From: =?utf-8?B?SsOhbiBPTkRSRUogKFNBTCk=?= <ondrejj@salstar.sk>
Message-ID: <20161215092046.GG30847@salstar.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Network unreachable on IPv6 network using qemu-kvm-2.7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

  using qemu-2.7 there are network unreachable problems when using user
networking on network with IPv4 and IPv6 support. With qemu 2.6 from Fedora
24 works well, but after update to qemu-2.7 from Fedora 25 unable to
connect. Looks like DNS returns IPv6 address, which is not reachable
from qemu. An IPv4 fallback can be useful.

  More info in Red Hat bugzilla:
	https://bugzilla.redhat.com/show_bug.cgi?id=1401165

						SAL
