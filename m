Received: from eggs.gnu.org ([2001:4830:134:3::10]:50507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gHmlN-0003hv-HK
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gHmlB-0005rO-QE
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:26:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gHmlB-0005Tf-A1
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:25:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 31 Oct 2018 08:43:05 +0000
Message-Id: <20181031084309.9227-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Use 'https://' instead of 'git://'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Jeff Cody has enabled git smart HTTP support on qemu.org.  From now on HTTPS is
the preferred protocol because it adds some protection against
man-in-the-middle when cloning a repo.

This patch series updates git:// URLs and changes them to https://.  The https:// URL format is:

  https://git.qemu.org/git/<project>.git

The old git:// URL format was:

  git://git.qemu.org/<project>.git

I have also update git://github.com/ URLs because GitHub also offers HTTPS.

I have tested that submodules continue to work after the change to .gitmodules.

Stefan Hajnoczi (4):
  README: use 'https://' instead of 'git://'
  get_maintainer: use 'https://' instead of 'git://'
  MAINTAINERS: use 'https://' instead of 'git://' for GitHub
  gitmodules: use 'https://' instead of 'git://'

 MAINTAINERS               | 74 +++++++++++++++++++--------------------
 .gitmodules               | 34 +++++++++---------
 README                    |  4 +--
 pc-bios/README            |  4 +--
 scripts/get_maintainer.pl |  2 +-
 5 files changed, 59 insertions(+), 59 deletions(-)

-- 
2.17.2
