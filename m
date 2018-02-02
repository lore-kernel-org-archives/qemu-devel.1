Received: from eggs.gnu.org ([208.118.235.92]:55983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehdNk-0002kG-A1
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehdMG-0005eh-Jd
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:35:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ehdMG-0005ce-1j
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3AE388535D
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 07:17:54 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  2 Feb 2018 08:17:48 +0100
Message-Id: <20180202071751.16316-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Ui 20180202 patches
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

The following changes since commit 11ed801d3df3c6e46b2f1f97dcfbf4ca3a2a2f=
4f:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2018-01-30 09:47:51 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180202-pull-request

for you to fetch changes up to 627ebec208a8809818589e17f4fce55a59420ad2:

  ui: correctly advance output buffer when writing SASL data (2018-02-02 =
07:48:18 +0100)

----------------------------------------------------------------
ui: use QIONetListener in vnc, bugfixes for sdl1 and vnc.

----------------------------------------------------------------

Daniel P. Berrange (1):
  ui: convert VNC server to QIONetListener

Daniel P. Berrang=C3=A9 (2):
  ui: fix mixup between qnum and qcode in SDL1 key handling
  ui: correctly advance output buffer when writing SASL data

 ui/vnc.h           |   9 +--
 ui/sdl.c           |   9 ++-
 ui/vnc-auth-sasl.c |   2 +-
 ui/vnc.c           | 195 +++++++++++++++--------------------------------=
------
 4 files changed, 67 insertions(+), 148 deletions(-)

--=20
2.9.3
