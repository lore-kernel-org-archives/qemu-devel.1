Received: from eggs.gnu.org ([2001:4830:134:3::10]:44359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cxppI-0001XL-Sr
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 03:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cxppF-0003FU-Q6
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 03:02:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cxppF-0003EY-Kp
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 03:02:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0063804E4
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 07:02:50 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 11 Apr 2017 09:02:41 +0200
Message-Id: <20170411070243.635-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 0/2] qxl bugfixes
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

  Hi,

Two bugfixes for qxl.  Well, one actually is a workaround for a guest
driver bug.

please pull,
  Gerd

The following changes since commit 5fe2339e6b09da7d6f48b9bef0f1a7360392b4=
89:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-201704=
06.0' into staging (2017-04-07 10:29:56 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-fixes-20170411-1

for you to fetch changes up to 86dbcdd9c7590d06db89ca256c5eaf0b4aba8858:

  qxl: add migration blocker to avoid pre-save assert (2017-04-11 08:38:1=
7 +0200)

----------------------------------------------------------------
qxl: bugfixes.

----------------------------------------------------------------
Gerd Hoffmann (1):
      qxl: add migration blocker to avoid pre-save assert

Marc-Andr=C3=A9 Lureau (1):
      qxl: switch display on entering VGA

 hw/display/qxl.h |  1 +
 hw/display/qxl.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
