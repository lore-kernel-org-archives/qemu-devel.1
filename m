Received: from eggs.gnu.org ([2001:4830:134:3::10]:43062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIHJH-00079w-5t
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIHJG-00064d-Bt
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:30:55 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 18:30:42 +0100
Message-Id: <20180514173044.5025-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] gdbstub: fix a couple of coverity nits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

Fix a couple of coverity nits in gdbstub.c regarding failing
to check error returns.

Peter Maydell (2):
  gdbstub: Use qemu_set_cloexec()
  gdbstub: Handle errors in gdb_accept()

 gdbstub.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

-- 
2.17.0
