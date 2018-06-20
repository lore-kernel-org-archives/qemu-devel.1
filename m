Received: from eggs.gnu.org ([2001:4830:134:3::10]:56437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fVUic-0001O8-Dh
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 00:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fVUiY-0007Jx-G0
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 00:27:42 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <suratiamol@gmail.com>)
	id 1fVUiY-0007Jq-9i
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 00:27:38 -0400
Received: by mail-pl0-x244.google.com with SMTP id g20-v6so1033028plq.1
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 21:27:37 -0700 (PDT)
From: Amol Surati <suratiamol@gmail.com>
Date: Wed, 20 Jun 2018 09:59:28 +0530
Message-Id: <20180620042930.24208-1-suratiamol@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] ide/hw/core: fix bug# 1777315,
 crash on short PRDs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, Amol Surati <suratiamol@gmail.com>

The fix utilizes the existing policy QEMU has about short PRDs, and
considers the transfers that cause the crash as generated through short
PRDS.

It
- continues to allow QEMU to support multiple calls to
  prepare_buf/ide_dma_cb,
- so, continues to keep QEMU free from needing the entire sglist in one
  go;
- avoids the crash;
- but, treats the affected transfers as short, instead of allowing them
  to continue.


Amol Surati (1):
  ide/hw/core: fix crash on processing a partial-sector-size DMA xfer

John Snow (1):
  tests/ide-test: test case for crash when processing short PRDs

 hw/ide/core.c    |  5 ++++-
 tests/ide-test.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.17.1
