Received: from eggs.gnu.org ([2001:4830:134:3::10]:34162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csmc9-0008GN-8K
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csmc6-000136-5y
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:36:29 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1csmc6-00012U-0a
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:36:26 -0400
Received: by mail-wr0-x22d.google.com with SMTP id u1so92920200wra.2
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 01:36:25 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 28 Mar 2017 09:36:17 +0100
Message-Id: <20170328083623.10396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/6] MTTCG fixes for rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

Here is the current batch of fixes for MTTCG regressions for the next
release candidate. I've dropped the speculative atomic cputlb patch
and included 2 fixes to the console code. The first fixes the taking
of the BQL (which I missed) and the second uses the exclusive
mechanism directly in the main thread rather than queuing the work to
run in the vCPU context. I kept them separate as they are logically
discreet changes.

The user-exec and bsd-user fixes have been posted separately before in
the various report threads.

Finally I claim a checkpatch exception for Pranith's newline fix. It
didn't seem worth splitting the string for the sake of a semicolon on
column 81 ;-)

Gerd,

Do you want to take the console patches via your tree or have me
include it in a pull request?

Alex Bennée (5):
  user-exec: handle synchronous signals from QEMU gracefully
  bsd-user: align use of mmap_lock to that of linux-user
  ui/console: ensure do_safe_dpy_refresh holds BQL
  ui/console: use exclusive mechanism directly
  replay/replay.c: bump REPLAY_VERSION

Pranith Kumar (1):
  tcg: Add a new line after incompatibility warning

 bsd-user/mmap.c   | 13 +------------
 bsd-user/qemu.h   |  2 --
 cpu-exec-common.c |  2 +-
 cpus.c            |  2 +-
 replay/replay.c   |  2 +-
 ui/console.c      | 18 +++++++++++-------
 user-exec.c       | 18 +++++++++++++++---
 7 files changed, 30 insertions(+), 27 deletions(-)

-- 
2.11.0
