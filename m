Received: from eggs.gnu.org ([2001:4830:134:3::10]:57454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=373afa021=owen.smith@citrix.com>)
	id 1daNyW-0008O7-Rz
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=373afa021=owen.smith@citrix.com>)
	id 1daNyR-0008R7-Lk
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:11:48 -0400
Received: from smtp.citrix.com ([66.165.176.89]:7925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=373afa021=owen.smith@citrix.com>)
	id 1daNyR-0008OM-EY
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:11:43 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Wed, 26 Jul 2017 15:10:29 +0000
Message-ID: <1501081831-9587-1-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2 v3] xenfb: rework xen vkbd backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, sstabellini@kernel.org, anthony.perard@citrix.com, Owen Smith <owen.smith@citrix.com>

These patches are intended to allow PV frontends, like the Windows
frontend to use the backend provided by Qemu. The Windows frontend(1)
requires absolute mouse coordinates in a fixed range, which is not
possible under HVM guests, where the vfb and Qemu console is not
guaranteed to be available or report constant dimmensions.

(1) git://xenbits.xen.org/pvdrivers/win/xenvkbd.git

Fixes since v2:
  Rebased to master
  Reworked the input handler callbacks, simplifying the state
    tracking and input event mapping.

Owen Smith (2):
  xenfb: Use Input Handlers directly
  xenfb: Add [feature|request]-raw-pointer

 hw/display/xenfb.c | 412 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 258 insertions(+), 154 deletions(-)

-- 
2.1.4
