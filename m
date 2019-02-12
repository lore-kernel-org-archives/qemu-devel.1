Received: from eggs.gnu.org ([209.51.188.92]:51447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtYhr-00020o-LD
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtYhq-0006od-N3
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:06:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtYhq-0006mo-DS
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:06:38 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 12 Feb 2019 15:06:18 +0100
Message-Id: <20190212140621.17009-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] pci,
 vhost-user: Fix two incorrectly applied patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Changpeng Liu <changpeng.liu@intel.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Commit a56de056c91f8 squashed two unrelated commits at once.
Revert it and reapply the two commits to avoid confusion.

See: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg02966.html

Changpeng Liu (1):
  contrib/vhost-user-blk: fix the compilation issue

Peter Xu (1):
  i386/kvm: ignore masked irqs when update msi routes

Philippe Mathieu-Daud=C3=A9 (1):
  Revert "contrib/vhost-user-blk: fix the compilation issue"


--=20
2.20.1
