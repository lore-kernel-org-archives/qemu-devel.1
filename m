Received: from eggs.gnu.org ([2001:4830:134:3::10]:50687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dB0J7-0001fu-Qf
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dB0J3-0004dg-Op
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:52:09 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dB0J3-0004dD-ID
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:52:05 -0400
Received: by mail-wm0-x233.google.com with SMTP id v15so19205705wmv.1
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 07:52:05 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 17 May 2017 15:52:53 +0100
Message-Id: <20170517145259.28979-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/6] gdb updates and cputlb traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, stefanha@redhat.com
Cc: cota@braap.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

Here is an update to the cputlb tracing and also a number of gdbstub
updates. The main changes to the cputlb tracing are making each flush
an explicit event instead of just dumping counts. This means you can
so analysis on the delay from queuing work to scheduling at the cost
of losing the raw count in the MMI interface.

Alex Bennée (6):
  scripts/replay-dump.py: replay log dumper
  scripts/qemu-gdb/timers.py: new helper to dump timer state
  scripts/qemu-gdb/tcg: new helper to dump tcg state
  cputlb: remove tlb_flush_count
  cputlb: add trace events
  new script/analyse-tlb-flushes-simpletrace.py

 cputlb.c                                   |  38 +++-
 include/exec/cputlb.h                      |   1 -
 scripts/analyse-tlb-flushes-simpletrace.py | 144 +++++++++++++++
 scripts/qemu-gdb.py                        |   4 +-
 scripts/qemugdb/tcg.py                     |  46 +++++
 scripts/qemugdb/timers.py                  |  54 ++++++
 scripts/replay-dump.py                     | 272 +++++++++++++++++++++++++++++
 trace-events                               |   7 +
 translate-all.c                            |   1 -
 9 files changed, 559 insertions(+), 8 deletions(-)
 create mode 100755 scripts/analyse-tlb-flushes-simpletrace.py
 create mode 100644 scripts/qemugdb/tcg.py
 create mode 100644 scripts/qemugdb/timers.py
 create mode 100755 scripts/replay-dump.py

-- 
2.11.0
