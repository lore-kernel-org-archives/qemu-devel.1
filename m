Received: from eggs.gnu.org ([2001:4830:134:3::10]:48251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvD-0003LH-T4
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvD-0002lX-48
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:58:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZyvC-0002kL-UR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:58:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 007317E446
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 12:58:58 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 13:58:40 +0100
Message-Id: <20180112125854.18261-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] Vnc 20180112 patches
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

The following changes since commit 997eba28a3ed5400a80f754bf3a1c8044b75b9=
ff:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80111' into staging (2018-01-11 14:34:41 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vnc-20180112-pull-request

for you to fetch changes up to 30b80fd5269257f55203b7072c505b4ebaab5115:

  ui: mix misleading comments & return types of VNC I/O helper methods (2=
018-01-12 13:48:54 +0100)

----------------------------------------------------------------
vnc: limit memory usage (CVE-2017-15124)

----------------------------------------------------------------

Daniel P. Berrange (13):
  ui: remove 'sync' parameter from vnc_update_client
  ui: remove unreachable code in vnc_update_client
  ui: remove redundant indentation in vnc_client_update
  ui: avoid pointless VNC updates if framebuffer isn't dirty
  ui: track how much decoded data we consumed when doing SASL encoding
  ui: introduce enum to track VNC client framebuffer update request
    state
  ui: correctly reset framebuffer update state after processing dirty
    regions
  ui: refactor code for determining if an update should be sent to the
    client
  ui: fix VNC client throttling when audio capture is active
  ui: fix VNC client throttling when forced update is requested
  ui: place a hard cap on VNC server output buffer size
  ui: add trace events related to VNC client throttling
  ui: mix misleading comments & return types of VNC I/O helper methods

Marc-Andr=C3=A9 Lureau (1):
  vnc: fix debug spelling

 ui/vnc-auth-sasl.h |   5 +-
 ui/vnc.h           |  28 ++++-
 ui/vnc-auth-sasl.c |  16 ++-
 ui/vnc-jobs.c      |   5 +
 ui/vnc.c           | 318 ++++++++++++++++++++++++++++++++++++++---------=
------
 ui/trace-events    |   7 ++
 6 files changed, 276 insertions(+), 103 deletions(-)

--=20
2.9.3
