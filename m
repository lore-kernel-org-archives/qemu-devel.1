Received: from eggs.gnu.org ([2001:4830:134:3::10]:43161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ce4Ar-0001eO-Oa
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ce4An-0006Y6-PI
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:19:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ce4An-0006Xq-Ie
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:19:25 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 15 Feb 2017 18:19:17 +0000
Message-Id: <20170215181922.11624-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/5] SLIRP VMStatification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com
Cc: quintela@redhat.com, lvivier@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This is an update to my previous SLIRP vmstatification, but finally
the dependent patches have gone in, so this can now follow.
  The only real change since v2 is adding in the commented out IPv6 migration
state as suggested in the review code.

Dave


Dr. David Alan Gilbert (5):
  slirp: VMState conversion; tcpcb
  slirp: VMStatify sbuf
  slirp: Common lhost/fhost union
  slirp: VMStatify socket level
  slirp: VMStatify remaining except for loop

 slirp/sbuf.h    |   4 +-
 slirp/slirp.c   | 438 +++++++++++++++++++++++++++-----------------------------
 slirp/socket.h  |  24 ++--
 slirp/tcp_var.h |   6 +-
 4 files changed, 227 insertions(+), 245 deletions(-)

-- 
2.9.3
