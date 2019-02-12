Received: from eggs.gnu.org ([209.51.188.92]:45102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtYQ4-00020X-6w
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtYQ3-00067c-7f
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:48:16 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 12 Feb 2019 13:47:54 +0000
Message-Id: <20190212134758.10514-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] a few trivials
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com, mst@redhat.com
Cc: qemu-trivial@nongnu.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Just cleaning out my trivial pile; a few more traces and
a couple of error reporting tweaks.

Dave


Dr. David Alan Gilbert (4):
  pckbd: Convert DPRINTF->trace
  HMP: Prepend errors with 'Error:'
  kvm: Add kvm_set_ioeventfd* traces
  wavcapture: Convert to error_report

 accel/kvm/kvm-all.c    |  3 +++
 accel/kvm/trace-events |  2 ++
 audio/wavcapture.c     | 39 +++++++++++++++++----------------------
 hmp.c                  |  2 +-
 hw/input/pckbd.c       | 19 ++++++-------------
 hw/input/trace-events  |  7 +++++++
 6 files changed, 36 insertions(+), 36 deletions(-)

--=20
2.20.1
