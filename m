Received: from eggs.gnu.org ([2001:4830:134:3::10]:41901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1csDBb-0006dP-0A
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 14:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1csDBX-0002Jp-3H
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 14:46:43 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:46702)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1csDBW-0002Hz-T6
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 14:46:39 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 26 Mar 2017 20:46:32 +0200
Message-Id: <20170326184634.25042-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCH 0/2] Fix spurious RDNSS announce
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, thuth@redhat.com, jan.kiszka@siemens.com

Hello,

These two patches fix sending the IPv6 RDNSS announce only when
it can actually work, fixing the bug reported by Cole Robinson
<crobinso@redhat.com>.  Could somebody review them before I can send
a pull update?

Samuel Thibault (2):
  slirp: Make RA build more flexible
  slirp: Send RDNSS in RA only if host has an IPv6 DNS server

 slirp/ip6_icmp.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

-- 
2.11.0
