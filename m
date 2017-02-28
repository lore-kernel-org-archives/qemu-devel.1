Received: from eggs.gnu.org ([2001:4830:134:3::10]:55249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cikja-0004LC-FN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cikjZ-0001sO-K5
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:34:42 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 28 Feb 2017 11:34:31 -0500
Message-Id: <20170228163436.31357-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL v2 0/5] Block patches for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

The following changes since commit c8c0a1a784cdf70ecea50e93213137c6c89337a7:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-02-28 13:41:03 +0000)

are available in the git repository at:

  git@github.com:codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 7a4bdbdd818fba3fb6c79d23baa3c7cb928be661:

  block/rbd: add support for 'mon_host', 'auth_supported' via QAPI (2017-02-28 11:32:46 -0500)

----------------------------------------------------------------
Block patches for 2.9 - rbd blockdev-add.  Added s-o-b's.
----------------------------------------------------------------

Jeff Cody (5):
  block/rbd: don't copy strings in qemu_rbd_next_tok()
  block/rbd: add all the currently supported runtime_opts
  block/rbd: parse all options via bdrv_parse_filename
  block/rbd: add blockdev-add support
  block/rbd: add support for 'mon_host', 'auth_supported' via QAPI

 block/rbd.c          | 568 ++++++++++++++++++++++++++++++++++-----------------
 qapi/block-core.json |  62 +++++-
 2 files changed, 442 insertions(+), 188 deletions(-)

-- 
2.9.3
