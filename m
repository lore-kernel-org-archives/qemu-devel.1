Received: from eggs.gnu.org ([2001:4830:134:3::10]:41117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dNWNs-00011x-Ow
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 23:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dNWNs-0000WY-1r
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 23:32:48 -0400
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Wed, 21 Jun 2017 11:32:45 +0800
Message-ID: <CAOE=1Z1Bbgb494m6mYRnX1-80eT0tSnF0F6zNM7efEie4rd7DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Will huge page have negative effect on guest vm in
 qemu enviroment?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dev@dpdk.org, users@dpdk.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org

Hi all,

We plan to use DPDK on HP host machine with several core and big memory. We
plan to use qemu-kvm enviroment. The host will carry 4 or more guest vm and
1 ovs.

Ovs-dpdk is much faster then normal ovs, but to use ovs-dpdk, we have to
enable huge page globally.

My question is, will huge page enabled globally have negative effect on
guest vm's memory orperate or something? If it is, how to prevent this, or
could I enable huge page on some core or enable huge page for a part of
memory?

Thank you~
