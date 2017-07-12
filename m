Received: from eggs.gnu.org ([2001:4830:134:3::10]:60798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVFFp-0003uE-G5
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVFFk-0001Wt-4z
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:52:25 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVFFj-0001WL-Ti
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:52:20 -0400
Received: by mail-wr0-x22b.google.com with SMTP id c11so28150171wrc.3
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 03:52:19 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 12 Jul 2017 11:52:12 +0100
Message-Id: <20170712105216.747-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 0/4] some gdbstub fixes for debug and vcont
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi Paolo,

I was going through my review queue and realised I had this hanging
around with an outstanding comment. Basically the only change is to
fix the bsd-user build by adding a field for the thread-id. It isn't
populated but it never was and it looks like the gdbstub for threaded
bsd-user programs has been broken forever.

Given the range of different ways of getting a thread-id and the fact
the bsd fork machinery looks like it needs updating anyway I'd left
this for a future BSD maintainer to fix up properly.

Are you happy to take this into your tree?

Alex Bennée (4):
  gdbstub: modernise DEBUG_GDB
  gdbstub: rename cpu_index -> cpu_gdb_index
  qom/cpu: remove host_tid field
  gdbstub: don't fail on vCont;C04:0;c packets

 bsd-user/qemu.h        |   2 +
 gdbstub.c              | 117 ++++++++++++++++++++++++-------------------------
 include/exec/gdbstub.h |   9 ----
 include/qom/cpu.h      |   2 -
 linux-user/syscall.c   |   1 -
 5 files changed, 59 insertions(+), 72 deletions(-)

-- 
2.13.0
