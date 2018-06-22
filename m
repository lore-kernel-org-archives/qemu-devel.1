Received: from eggs.gnu.org ([2001:4830:134:3::10]:39563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fWR7V-0004gp-Gk
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fWR7S-0007fU-E9
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:49:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fWR7S-0007fL-8T
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:49:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 22 Jun 2018 15:49:08 -0300
Message-Id: <20180622184909.23381-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Python queue, 2018-06-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>

The following changes since commit 7ed14cbf3cf083f125c079bd02b3215941853830:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2018-06-22' into staging (2018-06-22 17:08:58 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to bf20b675cc5a2568f1105c3577663978c5a13108:

  Partially revert "python: futurize -f libfuturize.fixes.fix_absolute_import" (2018-06-22 15:45:42 -0300)

----------------------------------------------------------------
Python queue, 2018-06-22

* Partially revert commit that broke qmp-shell and other scripts
  inside ./scripts/qmp

----------------------------------------------------------------

Eduardo Habkost (1):
  Partially revert "python: futurize -f
    libfuturize.fixes.fix_absolute_import"

 scripts/qmp/qemu-ga-client | 3 +--
 scripts/qmp/qmp            | 3 +--
 scripts/qmp/qmp-shell      | 3 +--
 scripts/qmp/qom-fuse       | 3 +--
 scripts/qmp/qom-get        | 3 +--
 scripts/qmp/qom-list       | 3 +--
 scripts/qmp/qom-set        | 3 +--
 scripts/qmp/qom-tree       | 3 +--
 8 files changed, 8 insertions(+), 16 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140
