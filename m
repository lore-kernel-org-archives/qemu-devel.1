Received: from eggs.gnu.org ([209.51.188.92]:34530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBcli-0008A1-63
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBcle-0002Ro-6R
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:05:17 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed,  3 Apr 2019 12:05:01 +0200
Message-Id: <20190403100505.7550-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-4.0 0/4] s390x gcc 9 warning fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 061b51e9195670e9d190cdec46fabcb3c77763=
fb:

  Update version for v4.0.0-rc2 release (2019-04-02 17:01:20 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20190403

for you to fetch changes up to 7357b2215978debf2fd17b525ba745d3c69272a3:

  hw/s390x/3270-ccw: avoid taking address of fields in packed struct (201=
9-04-03 11:19:57 +0200)

----------------------------------------------------------------
Fix taking address of fields in packed structs warnings
by gcc 9

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (4):
  hw/vfio/ccw: avoid taking address members in packed structs
  hw/s390/css: avoid taking address members in packed structs
  hw/s390x/ipl: avoid taking address of fields in packed struct
  hw/s390x/3270-ccw: avoid taking address of fields in packed struct

 hw/s390x/3270-ccw.c |   8 +-
 hw/s390x/css.c      | 388 +++++++++++++++++++++-----------------------
 hw/s390x/ipl.c      |  12 +-
 hw/vfio/ccw.c       |  42 ++---
 4 files changed, 218 insertions(+), 232 deletions(-)

--=20
2.17.2
