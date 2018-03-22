Received: from eggs.gnu.org ([2001:4830:134:3::10]:48157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ez2pc-0001jH-Ja
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ez2pY-00074n-L5
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:12:48 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu, 22 Mar 2018 17:12:22 +0100
Message-Id: <20180322161226.29796-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] coccinelle: re-run scripts from
 scripts/coccinelle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>

I've re-run some scripts from the coccinelle directory,
and they have found some problems.

This series fixes them.

Laurent Vivier (4):
  error: Strip trailing '\n' from error string arguments (again again)
  error: Remove NULL checks on error_propagate() calls
  qdict: remove useless cast
  Remove unnecessary variables for function return value

 accel/tcg/translate-all.c                          |  5 +-
 block/nvme.c                                       | 11 ++---
 block/quorum.c                                     |  6 +--
 hw/arm/exynos4210.c                                |  7 +--
 hw/block/vhost-user-blk.c                          |  5 +-
 hw/hppa/dino.c                                     |  5 +-
 hw/misc/mos6522.c                                  |  6 +--
 hw/net/ftgmac100.c                                 |  5 +-
 hw/ppc/pnv_lpc.c                                   | 14 +-----
 io/channel-websock.c                               |  4 +-
 io/net-listener.c                                  |  6 +--
 monitor.c                                          |  2 +-
 target/i386/hax-darwin.c                           | 10 ++--
 target/i386/hvf/hvf.c                              | 24 +++++-----
 target/mips/dsp_helper.c                           | 15 ++----
 target/xtensa/core-dc232b/xtensa-modules.c         | 56 ++++++----------------
 target/xtensa/core-dc233c/xtensa-modules.c         | 56 ++++++----------------
 target/xtensa/core-de212/xtensa-modules.c          | 48 +++++--------------
 target/xtensa/core-fsf/xtensa-modules.c            | 32 ++++---------
 .../xtensa/core-sample_controller/xtensa-modules.c | 24 +++-------
 target/xtensa/translate.c                          |  5 +-
 tests/m48t59-test.c                                |  6 +--
 tests/test-thread-pool.c                           |  6 +--
 util/uri.c                                         |  5 +-
 24 files changed, 94 insertions(+), 269 deletions(-)

-- 
2.14.3
