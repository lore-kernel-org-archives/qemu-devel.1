Received: from eggs.gnu.org ([2001:4830:134:3::10]:45191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG5FS-0007sx-9s
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG5FP-0005Wx-4a
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:09:22 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dG5FO-0005Vw-Td
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:09:19 -0400
Received: by mail-wm0-x22c.google.com with SMTP id e127so24956771wmg.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 08:09:18 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 31 May 2017 16:09:31 +0100
Message-Id: <20170531150933.10156-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/2] some gdbstub fixes for debug and vcont
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

I was attempting to debug RISU via qemu-aarch64 and the gdbstub and I
was finding the stub responding with an E22 on vcont. The fix is in
the second patch. The first patch just modernises the debug output to
use a helper instead of lots of #ifdefs.

Alex Bennée (2):
  gdbstub: modernise DEBUG_GDB
  gdbstub: don't fail on vCont;C04:0;c packets

 gdbstub.c | 81 +++++++++++++++++++++++++++------------------------------------
 1 file changed, 35 insertions(+), 46 deletions(-)

-- 
2.13.0
