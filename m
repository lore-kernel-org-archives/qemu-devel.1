Received: from eggs.gnu.org ([2001:4830:134:3::10]:49783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gTuEv-0003vW-Kn
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gTuEu-0006ze-58
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:50:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gTuEt-0006zB-VA
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:50:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 117DF3154872
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 19:50:43 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Dec 2018 20:50:37 +0100
Message-Id: <20181203195039.29597-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Fixes 31 20181203 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit 039d4e3df0049bdd8f93a2de735a816483b139=
54:

  scsi: Address spurious clang warning (2018-11-27 23:56:12 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/fixes-31-20181203-pull-request

for you to fetch changes up to c52d46e041b42bb1ee6f692e00a0abe37a9659f6:

  usb-mtp: outlaw slashes in filenames (2018-12-03 19:40:17 +0100)

----------------------------------------------------------------
usb: mtp fixes.

----------------------------------------------------------------

Gerd Hoffmann (2):
  usb-mtp: fix utf16_to_str
  usb-mtp: outlaw slashes in filenames

 hw/usb/dev-mtp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--=20
2.9.3
