Received: from eggs.gnu.org ([2001:4830:134:3::10]:53401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqr-0002U7-6v
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqm-00036S-Um
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:25 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxYqm-00035Q-O8
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:20 -0400
Received: by mail-wr0-x236.google.com with SMTP id l28so18755968wre.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 05:55:18 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Apr 2017 13:55:13 +0100
Message-Id: <20170410125524.21008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/11] Final icount and misc MTTCG fixes for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit 5fe2339e6b09da7d6f48b9bef0f1a7360392b489:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20170406.0' into staging (2017-04-07 10:29:56 +0100)

are available in the git repository at:

  https://github.com/stsquad/qemu.git tags/pull-mttcg-fixups-for-rc2-100417-1

for you to fetch changes up to 982263ce714ffcc4c7c41a7b255bd29e093912fe:

  replay: assert time only goes forward (2017-04-10 10:23:38 +0100)

----------------------------------------------------------------
Final icount and misc MTTCG fixes for 2.9

Minor differences from:
  Message-Id: <20170405132503.32125-1-alex.bennee@linaro.org>

  - dropped new feature patches
  - last minute typo fix from Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

----------------------------------------------------------------
Alex Bennée (10):
      scripts/qemugdb/mtree.py: fix up mtree dump
      target/i386/misc_helper: wrap BQL around another IRQ generator
      cpus: remove icount handling from qemu_tcg_cpu_thread_fn
      cpus: check cpu->running in cpu_get_icount_raw()
      cpus: move icount preparation out of tcg_exec_cpu
      cpus: don't credit executed instructions before they have run
      cpus: introduce cpu_update_icount helper
      cpu-exec: update icount after each TB_EXIT
      cpus: call cpu_update_icount on read
      replay: assert time only goes forward

Nikunj A Dadhania (1):
      cpus: fix wrong define name

 cpu-exec.c                |  14 +++---
 cpus.c                    | 111 +++++++++++++++++++++++++++++++++-------------
 include/qemu/timer.h      |   1 +
 include/qom/cpu.h         |   1 +
 replay/replay-internal.c  |   4 ++
 replay/replay.c           |   4 ++
 scripts/qemugdb/mtree.py  |  12 ++++-
 target/i386/misc_helper.c |   3 ++
 8 files changed, 110 insertions(+), 40 deletions(-)

-- 
2.11.0
