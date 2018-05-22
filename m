Received: from eggs.gnu.org ([2001:4830:134:3::10]:37057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fL4iD-0000s9-PL
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fL4iD-0004mA-46
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:40:13 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 11:39:55 +0100
Message-Id: <20180522104000.9044-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/5] Make the next release be 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

I think that we should number the next release 3.0
(3.0.0, in long form). We already have a few places that
have used "2.13", in machine-versions or in "feature
exists since release X" annotations; update those.

thanks
-- PMM

Peter Maydell (5):
  qapi: Change "since 2.13" annotations to "since 3.0"
  hw/i386: Rename 2.13 machine types to 3.0
  hw/s390x: Rename 2.13 machines to 3.0
  ppc: Rename 2.13 machines to 3.0
  qemu-doc.texi: Rename references to 2.13 to 3.0

 qapi/block-core.json            |  4 ++--
 qapi/common.json                |  2 +-
 qapi/migration.json             | 16 ++++++++--------
 qapi/misc.json                  |  4 ++--
 qapi/net.json                   |  2 +-
 qapi/ui.json                    |  2 +-
 target/ppc/cpu.h                |  2 +-
 hw/i386/pc_piix.c               |  8 ++++----
 hw/i386/pc_q35.c                |  8 ++++----
 hw/ppc/spapr.c                  | 14 +++++++-------
 hw/s390x/s390-virtio-ccw.c      | 10 +++++-----
 target/ppc/machine.c            |  8 ++++----
 target/ppc/translate_init.inc.c |  2 +-
 qemu-doc.texi                   |  4 ++--
 14 files changed, 43 insertions(+), 43 deletions(-)

-- 
2.17.0
