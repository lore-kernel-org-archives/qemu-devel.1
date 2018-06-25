Received: from eggs.gnu.org ([2001:4830:134:3::10]:57568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXaAh-0006gU-HT
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXaAe-0000P2-GQ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:41:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXaAe-0000NE-9u
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:41:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 25 Jun 2018 19:41:08 -0300
Message-Id: <20180625224110.5147-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Machine queue, 2018-06-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

The following changes since commit 35e238c9330669882487f9929e0aa97900431853:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180625-pull-request' into staging (2018-06-25 15:25:26 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 08fe68244eb44f3c8ccecd35066eca8392d1345a:

  hw/i386: Deprecate the machine types pc-0.10 and pc-0.11 (2018-06-25 14:10:01 -0300)

----------------------------------------------------------------
Machine queue, 2018-06-25

* Don't support --daemonize and --preconfig together
* Deprecate machine types pc-0.10 and pc-0.11

----------------------------------------------------------------

Queue for Machine Core patches


Igor Mammedov (1):
  vl.c: do not allow --daemonize in combination with --preconfig CLI
    option

Thomas Huth (1):
  hw/i386: Deprecate the machine types pc-0.10 and pc-0.11

 include/hw/boards.h |  3 +++
 hw/i386/pc_piix.c   |  1 +
 vl.c                | 16 ++++++++++++++--
 qemu-doc.texi       |  5 +++++
 4 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140
