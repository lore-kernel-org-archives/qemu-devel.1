Received: from eggs.gnu.org ([2001:4830:134:3::10]:58786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cE0rp-0007UL-LU
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cE0ro-0005oJ-OZ
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:32:09 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  5 Dec 2016 16:31:58 -0500
Message-Id: <1480973521-28945-1-git-send-email-jcody@redhat.com>
Subject: [Qemu-devel] [PULL for-2.8 0/3] Block patches for -rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

The following changes since commit bc66cedb4141fb7588f2462c74310d8fb5dd4cf1:

  Merge remote-tracking branch 'yongbok/tags/mips-20161204' into staging (2016-12-05 10:56:45 +0000)

are available in the git repository at:

  https://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 76b5550f709b975a7b04fb4c887f300b7bb731c2:

  qemu-doc: update gluster protocol usage guide (2016-12-05 16:30:29 -0500)

----------------------------------------------------------------
Gluster block patches for -rc3
----------------------------------------------------------------

Prasanna Kumar Kalever (3):
  block/gluster: fix QMP to match debug option
  block/nfs: fix QMP to match debug option
  qemu-doc: update gluster protocol usage guide

 block/gluster.c      | 38 ++++++++++++++++-----------------
 block/nfs.c          |  4 ++--
 qapi/block-core.json |  8 +++----
 qemu-doc.texi        | 59 +++++++++++++++++++++++++++++++++++++++-------------
 qemu-options.hx      | 25 ++++++++++++++++++++--
 5 files changed, 93 insertions(+), 41 deletions(-)

-- 
2.7.4
