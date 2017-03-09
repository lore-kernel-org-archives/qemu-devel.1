Received: from eggs.gnu.org ([2001:4830:134:3::10]:53476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1clu6M-0005ku-4K
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1clu6I-0003Bf-Ow
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:11:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1clu6I-0003BQ-Hq
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:11:10 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E8ECC04D2A3
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 09:11:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  9 Mar 2017 10:10:59 +0100
Message-Id: <1489050661-17989-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 0/2] bugfixes for ohci and qxl
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

2.9 fixes queue, with two patches for qxl and ohci.

please pull,
  Gerd

The following changes since commit 87467097f8811258cd91d42c141a7bd8492ed0=
8a:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-block-2017-02-28=
-v4' into staging (2017-03-07 17:06:48 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-fixes-20170309-1

for you to fetch changes up to dbb5fb8d3519130559b10fa4e1395e4486c633f8:

  qxl: clear guest_cursor on QXL_CURSOR_HIDE (2017-03-09 09:47:26 +0100)

----------------------------------------------------------------
2.9 bugfixes for ohci and qxl

----------------------------------------------------------------
Gerd Hoffmann (2):
      ohci: relax link check
      qxl: clear guest_cursor on QXL_CURSOR_HIDE

 hw/display/qxl.c  | 5 +++++
 hw/usb/hcd-ohci.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)
