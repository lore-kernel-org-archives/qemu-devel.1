Received: from eggs.gnu.org ([2001:4830:134:3::10]:35967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpt5W-0003Cb-Ek
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpt5U-0000H5-4U
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:54:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cpt5T-0000Gn-Uy
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:54:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E891A8FCFB
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 08:54:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Mar 2017 09:54:35 +0100
Message-Id: <1490000078-31202-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 0/3] fixes: vnc, cirrus,
 tcg display updates.
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

Misc bugfixes for the next -rc.

please pull,
  Gerd

The following changes since commit 272d7dee5951f926fad1911f2f072e5915cdcb=
a0:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-cirrus-20170316-=
1' into staging (2017-03-16 16:40:44 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-fixes-20170320-1

for you to fetch changes up to 7bc4f0846f5e15dad5a54490290241243b5a4416:

  vnc: fix a qio-channel leak (2017-03-20 09:07:34 +0100)

----------------------------------------------------------------
fixes for 2.9: vnc, cirrus, tcg display updates.

----------------------------------------------------------------
Alex Benn=C3=A9e (1):
      ui/console: ensure graphic updates don't race with TCG vCPUs

Gerd Hoffmann (1):
      cirrus: fix off-by-one in cirrus_bitblt_rop_bkwd_transp_*_16

Marc-Andr=C3=A9 Lureau (1):
      vnc: fix a qio-channel leak

 hw/display/cirrus_vga_rop.h |  2 +-
 ui/console.c                | 21 ++++++++++++++++++++-
 ui/vnc.c                    |  1 +
 3 files changed, 22 insertions(+), 2 deletions(-)
