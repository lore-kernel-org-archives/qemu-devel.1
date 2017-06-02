Received: from eggs.gnu.org ([2001:4830:134:3::10]:33991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGmGL-0006JI-US
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGmGL-0002kN-2H
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:05:09 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dGmGK-0002it-S9
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:05:08 -0400
Received: by mail-wm0-x233.google.com with SMTP id d127so26443008wmf.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 06:05:08 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  2 Jun 2017 14:05:14 +0100
Message-Id: <20170602130518.22943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/4] some gdbstub fixes for debug and vcont
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is v3 and hopefully the final version the gdbstub fixes. There is
one minor change to patch two where I pulled forward the move of
cpu_gdb_index into gdbstub.c from the third patch.

Otherwise it is basically a re-base and a whole host of Reviewed-by
tags.

So the final question is who's tree is going to accept these patches?

The gdbstub is currently marked as "Odd fixes" via qemu-devel. If no
one wants to take it via their tree and Peter is happy I can roll the
pullreq directly.

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
