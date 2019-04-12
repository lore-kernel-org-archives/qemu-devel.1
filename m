Received: from eggs.gnu.org ([209.51.188.92]:36172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEv6i-0002h6-Mv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEv6g-0004V7-RR
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEv6g-0004Uf-Ky
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:34 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 12 Apr 2019 13:16:21 +0100
Message-Id: <20190412121626.19829-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/5] misc set of fixes for warnings under
 GCC 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This series addresses all the warnings I see when building on Fedora 30
x86_64 with GCC 9 (gcc-9.0.1-0.10.fc30.x86_64).

Changed in v2:

 - Dropped patches mistakenly included due to not correctly rebasing
 - Dropped s390x patches already merged
 - Dropped usb-mtp patches which need much more work to be correctly
   handling untrustworthy guest data.

Daniel P. Berrang=C3=A9 (5):
  linux-user: avoid string truncation warnings in uname field copying
  linux-user: avoid string truncation warnings in elf field copying
  sockets: avoid string truncation warnings when copying UNIX path
  hw/usb: avoid format truncation warning when formatting port name
  qxl: avoid unaligned pointer reads/writes

 hw/display/qxl.c     | 55 +++++++++++++++++++-------------------------
 hw/usb/hcd-xhci.c    |  2 ++
 linux-user/elfload.c | 10 ++++----
 linux-user/uname.c   |  2 +-
 util/qemu-sockets.c  | 12 ++++++----
 5 files changed, 39 insertions(+), 42 deletions(-)

--=20
2.20.1
