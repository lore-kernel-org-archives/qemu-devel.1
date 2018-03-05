Received: from eggs.gnu.org ([2001:4830:134:3::10]:49012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1esmba-0005bl-04
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1esmbZ-00064r-5o
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:40:26 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  5 Mar 2018 09:40:00 +0000
Message-Id: <20180305094006.21446-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/6] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 136c67e07869227b21b3f627316e03679ce7b738:

  Merge remote-tracking branch 'remotes/bkoppelmann/tags/pull-tricore-2018-03-02' into staging (2018-03-02 16:56:20 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 23500c6a9409efc80d696aede0629bfbe7556a90:

  README: Document 'git-publish' workflow (2018-03-05 09:03:17 +0000)

----------------------------------------------------------------
Pull request

Mostly patches that are only indirectly related to the block layer, but I've
reviewed them and there is no maintainer.

----------------------------------------------------------------

Fam Zheng (2):
  Add a git-publish configuration file
  README: Document 'git-publish' workflow

Su Hang (3):
  util/uri.c: Coding style check, Only whitespace involved
  util/uri.c: remove brackets that wrap `return` statement's content.
  util/uri.c: wrap single statement blocks with braces {}

Thomas Huth (1):
  tests/libqos: Check for valid dev pointer when looking for PCI devices

 tests/libqos/virtio-pci.c |    4 +-
 util/uri.c                | 1733 ++++++++++++++++++++++++---------------------
 .gitpublish               |   51 ++
 README                    |   31 +-
 4 files changed, 1014 insertions(+), 805 deletions(-)
 create mode 100644 .gitpublish

-- 
2.14.3
