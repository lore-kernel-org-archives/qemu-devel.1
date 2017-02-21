Received: from eggs.gnu.org ([2001:4830:134:3::10]:59253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4gc-0002yc-4M
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4gY-00086Y-Sj
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg4gY-00086M-Mi
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:30 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2B2513CF3
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:16:30 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 08:16:14 +0100
Message-Id: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/11] usb patch queue
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

Here is the usb patch queue, bringing the usual share of bugfixes.
Also a generic xhci device variant (qemu-xhci).

please pull,
  Gerd

The following changes since commit 56f9e46b841c7be478ca038d8d4085d776ab4b=
0d:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-02-20'=
 into staging (2017-02-20 17:42:47 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-usb-20170221-1

for you to fetch changes up to 31fb4444a485a348f8e2699d7c3dd15e1819ad2c:

  usb-ccid: add check message size checks (2017-02-21 08:11:43 +0100)

----------------------------------------------------------------
xhci: add qemu-xhci device, some followup cleanups.
ccid: better sanity checking.
ehci: fix memory leak
ohci: bugfixes.

----------------------------------------------------------------
Gerd Hoffmann (8):
      xhci: apply limits to loops
      xhci: drop ER_FULL_HACK workaround
      xhci: add qemu xhci controller
      xhci: fix nec vendor quirk handling
      xhci: drop via vendor command handling
      usb-ccid: better bulk_out error handling
      usb-ccid: move header size check
      usb-ccid: add check message size checks

Li Qiang (3):
      usb: ehci: fix memory leak in ehci
      usb: ohci: fix error return code in servicing iso td
      usb: ohci: limit the number of link eds

 docs/specs/pci-ids.txt        |   1 +
 hw/usb/dev-smartcard-reader.c | 140 +++++++++++++-----------
 hw/usb/hcd-ehci-pci.c         |   9 ++
 hw/usb/hcd-ehci.c             |   5 +
 hw/usb/hcd-ehci.h             |   1 +
 hw/usb/hcd-ohci.c             |  11 +-
 hw/usb/hcd-xhci.c             | 247 +++++++++++++++---------------------=
------
 hw/usb/trace-events           |   1 +
 include/hw/pci/pci.h          |   1 +
 9 files changed, 193 insertions(+), 223 deletions(-)
