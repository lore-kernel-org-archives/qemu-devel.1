Received: from eggs.gnu.org ([209.51.188.92]:45348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h1GA2-0006HS-Um
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h1GA2-0005qn-4w
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:55:34 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:40155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h1GA1-0005eZ-Nl
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:55:34 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Tue,  5 Mar 2019 20:55:14 +0100
Message-Id: <20190305195519.24303-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/5] LSI53C895 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sven Schnelle <svens@stackframe.org>

Hi,

this series contains a few cosmetic cleanups and one small bugfix for the
LSI53C895 emulation.

Regards
Sven

Sven Schnelle (5):
  lsi: use ldn_le_p()/stn_le_p()
  lsi: use enum type for s->waiting
  lsi: use enum type for s->msg_action
  lsi: use SCSI phase names instead of numbers in trace
  lsi: return dfifo value

 hw/scsi/lsi53c895a.c | 126 +++++++++++++++++++++++--------------------
 hw/scsi/trace-events |   6 +--
 2 files changed, 70 insertions(+), 62 deletions(-)

-- 
2.20.1
