Received: from eggs.gnu.org ([2001:4830:134:3::10]:56287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cu7n7-0001TB-CK
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 21:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cu7n6-0005RR-EC
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 21:25:21 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 31 Mar 2017 21:25:05 -0400
Message-Id: <20170401012508.24665-1-jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 0/3] Block patches
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

The following changes since commit 95b31d709ba343ad237c3630047ee7438bac40=
65:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-201703=
31.0' into staging (2017-03-31 18:06:13 +0100)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 34634ca28688652198f77d7001c0f1e204434663:

  block/curl: Check protocol prefix (2017-03-31 15:53:22 -0400)

----------------------------------------------------------------
Block patches for -rc3
----------------------------------------------------------------

Eric Blake (1):
  rbd: Fix regression in legacy key/values containing escaped :

Max Reitz (2):
  qapi/curl: Extend and fix blockdev-add schema
  block/curl: Check protocol prefix

 block/curl.c         |  10 +++++
 block/rbd.c          |  83 +++++++++++++++++++++--------------------
 qapi/block-core.json | 103 +++++++++++++++++++++++++++++++++++++++++++++=
+-----
 3 files changed, 146 insertions(+), 50 deletions(-)

--=20
2.9.3
