Received: from eggs.gnu.org ([2001:4830:134:3::10]:41513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1csrlB-0007es-Sx
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1csrlA-00080k-R7
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:06:09 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 28 Mar 2017 10:05:45 -0400
Message-Id: <20170328140555.3001-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 00/10] Block patches for -rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

The following changes since commit 142b9ca51d7260d20f6e87bd7f2020ac0a7d95d9:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-03-28 11:10:36 +0100)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 2836284db603775af557e969d5a800efb0190324:

  rbd: Fix bugs around -drive parameter "server" (2017-03-28 10:01:21 -0400)

----------------------------------------------------------------
Block patches for 2.9-rc2
----------------------------------------------------------------

Markus Armbruster (10):
  rbd: Reject -blockdev server.*.{numeric, to, ipv4, ipv6}
  rbd: Fix to cleanly reject -drive without pool or image
  rbd: Don't limit length of parameter values
  rbd: Clean up after the previous commit
  rbd: Don't accept -drive driver=rbd, keyvalue-pairs=...
  rbd: Clean up runtime_opts, fix -drive to reject filename
  rbd: Clean up qemu_rbd_create()'s detour through QemuOpts
  rbd: Revert -blockdev and -drive parameter auth-supported
  rbd: Revert -blockdev parameter password-secret
  rbd: Fix bugs around -drive parameter "server"

 block/rbd.c          | 319 ++++++++++++++-------------------------------------
 qapi-schema.json     |  21 ++--
 qapi/block-core.json |  30 +----
 3 files changed, 100 insertions(+), 270 deletions(-)

-- 
2.9.3
