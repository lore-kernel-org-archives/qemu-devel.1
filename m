Received: from eggs.gnu.org ([2001:4830:134:3::10]:48422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csp0S-0004H1-4o
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csp0O-00035m-36
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:44 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:32768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1csp0N-00035T-SA
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:40 -0400
Received: by mail-wr0-x234.google.com with SMTP id w43so85354234wrb.0
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:09:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 28 Mar 2017 12:09:30 +0100
Message-Id: <20170328110936.24806-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/6] MTTCG fixes for rc2
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

The following changes since commit ea2afcf5b6727a577cf561fd8fe0d8c397ecc927:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2017-03-24 14:14:18 +0000)

are available in the git repository at:

  https://github.com/stsquad/qemu.git tags/pull-mttcg-fixups-for-rc2-280317-1

for you to fetch changes up to 5b12c163c830081cbb78e2de3b42c5fe1b73e74e:

  replay/replay.c: bump REPLAY_VERSION (2017-03-28 10:52:50 +0100)

----------------------------------------------------------------
MTTCG regression fixes for rc2

----------------------------------------------------------------
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
