Received: from eggs.gnu.org ([2001:4830:134:3::10]:54968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cv5cx-0000QB-Fw
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cv5ct-0003ie-7h
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:18:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cv5ct-0003iO-21
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:18:47 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  3 Apr 2017 18:18:38 +0100
Message-Id: <20170403171843.3363-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/5 for 2.10] SLIRP VMStatification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, samuel.thibault@gnu.org, jan.kiszka@siemens.com
Cc: quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  Another crack at slirp vmstatification; v5 fixes the type and
value portability issues in the ss_family field.

  It now always sends this as a 16bit field and always uses Linux's
AF_INET or AF_INET6 value on writing.  It'll also accept Windows and
FreeBSDs values as inet6 to keep compatibility with incoming migrations
from previous versions.

Dave

v5
  Fix ss_family portability

Dr. David Alan Gilbert (5):
  slirp: VMState conversion; tcpcb
  slirp: VMStatify sbuf
  slirp: Common lhost/fhost union
  slirp: VMStatify socket level
  slirp: VMStatify remaining except for loop

 slirp/sbuf.h    |   4 +-
 slirp/slirp.c   | 494 +++++++++++++++++++++++++++++++-------------------------
 slirp/socket.h  |  24 ++-
 slirp/tcp_var.h |   6 +-
 4 files changed, 288 insertions(+), 240 deletions(-)

-- 
2.9.3
