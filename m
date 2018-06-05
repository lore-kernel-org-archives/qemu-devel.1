Received: from eggs.gnu.org ([2001:4830:134:3::10]:59343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1fQGO1-0006oE-9Y
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1fQGNx-0000Yb-WE
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:08:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45526 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1fQGNx-0000Xx-QF
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:08:45 -0400
From: P J P <ppandit@redhat.com>
Date: Tue,  5 Jun 2018 23:38:34 +0530
Message-Id: <20180605180836.21485-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] correct size computation in m_cat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Hello,

While reassembling incoming fragmented datagrams, 'm_cat' routine
extends the 'mbuf' buffer if it has insufficient room. It computes
a wrong buffer size, which leads to overwriting adjacent heap buffer
area.

This patch set fixes this issue and formats m_cat() routine as per coding
style guide.

Thank you.
--
Prasad J Pandit (2):
  slirp: correct size computation while concatenating mbuf
  slirp: reformat m_cat routine

 slirp/mbuf.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

--
2.17.1
