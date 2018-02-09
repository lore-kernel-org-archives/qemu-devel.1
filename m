Received: from eggs.gnu.org ([2001:4830:134:3::10]:48877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shaun.reitan@ndchost.com>) id 1ekE7G-00030K-Fc
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shaun.reitan@ndchost.com>) id 1ekE7B-0002wb-HJ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:13:46 -0500
Received: from jade.ndchost.com ([204.10.36.36]:43294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shaun.reitan@ndchost.com>)
	id 1ekE7B-00027t-AG
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:13:41 -0500
From: "Shaun Reitan" <shaun.reitan@ndchost.com>
Date: Fri, 09 Feb 2018 19:12:59 +0000
Message-Id: <embe7de3dd-331d-44fe-9c32-75916c902fb6@ndc-wkst-2>
Reply-To: "Shaun Reitan" <shaun.reitan@ndchost.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] QEMU leaves pidfile behind on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

QEMU leaves the pidfile behind on a clean exit when using the option=20
-pidfile /var/run/qemu.pid.

Should QEMU leave it behind or should it clean up after itself?

I'm willing to take a crack at a patch to fix the issue, but before I=20
do, I want to make sure that leaving the pidfile behind was not=20
intentional?

--
Shaun Reitan
NDCHost.com
