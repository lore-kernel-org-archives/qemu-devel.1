Received: from eggs.gnu.org ([2001:4830:134:3::10]:43956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGRPM-0004Xq-5H
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGRPI-0002UZ-W0
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:49:04 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dGRPI-0002Tg-Q9
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:49:00 -0400
Received: by mail-wm0-x22a.google.com with SMTP id n195so35523618wmg.1
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 07:48:59 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  1 Jun 2017 15:49:11 +0100
Message-Id: <20170601144915.20778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/4] some gdbstub fixes for debug and vcont
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

This is a follow up v2 of the patches I posted yesterday. There are
two new patches. The first is a simple name change to make the purpose
of the function clearer. The second new patch now fixes the bug by
making the thread-id consistent when reporting it via the gdbstub. It
also reduces the size of CPUState by avoiding duplication of
information already available in TaskStruct. The original fix is still
in the series although its theoretical (but still correct) for my test
case which now uses the correct thread-id.

Alex Bennée (4):
  gdbstub: modernise DEBUG_GDB
  gdbstub: rename cpu_index -> cpu_gdb_index
  qom/cpu: remove host_tid field
  gdbstub: don't fail on vCont;C04:0;c packets

 gdbstub.c              | 117 ++++++++++++++++++++++++-------------------------
 include/exec/gdbstub.h |   9 ----
 include/qom/cpu.h      |   2 -
 linux-user/syscall.c   |   1 -
 4 files changed, 57 insertions(+), 72 deletions(-)

-- 
2.13.0
