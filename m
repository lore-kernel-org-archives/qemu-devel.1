Received: from eggs.gnu.org ([2001:4830:134:3::10]:40630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eh695-0000W2-St
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 23:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eh695-0008O4-03
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 23:06:43 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 31 Jan 2018 23:06:33 -0500
Message-Id: <20180201040635.5749-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Block patches
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

The following changes since commit b05631954d6dfe93340d516660397e2c1a2a5dd6:

  Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180131' into staging (2018-01-31 15:50:29 +0000)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 45a79646ea746fa3f32083d0aa70512aae29f6b3:

  iotests: Make 200 run on tmpfs (2018-01-31 22:37:00 -0500)

----------------------------------------------------------------
Block patches
----------------------------------------------------------------

Max Reitz (1):
  iotests: Make 200 run on tmpfs

Murilo Opsfelder Araujo (1):
  block/ssh: fix possible segmentation fault when .desc is not
    null-terminated

 block/ssh.c            | 1 +
 tests/qemu-iotests/200 | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.9.5
