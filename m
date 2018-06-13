Received: from eggs.gnu.org ([2001:4830:134:3::10]:47455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fT9ZL-0003Gh-Bp
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fT9ZG-00064p-BJ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:28:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57262 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fT9ZG-00061Y-6K
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:28:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B9D287AAD
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 17:28:21 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Jun 2018 19:28:12 +0200
Message-Id: <20180613172815.32738-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] Fix usb-ccid hotplug regression follow-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

The series "[Qemu-devel] [PATCH 0/4] Fix usb-ccid hotplug regression"
made wrong assumptions about bus ref'counting pointed out by Paolo
after it was merged.

This series reverts the 2 offending patches, as well as a older
related patch that is now clearly wrong as well.

Marc-Andr=C3=A9 Lureau (3):
  Revert "usb-ccid: fix bus leak"
  Revert "usb: release the created buses"
  Revert "bus: do not unref the added child bus on realize"

 hw/core/bus.c                 |  1 +
 hw/usb/dev-smartcard-reader.c |  1 -
 hw/usb/dev-storage.c          | 16 ----------------
 hw/usb/dev-uas.c              |  2 --
 4 files changed, 1 insertion(+), 19 deletions(-)

--=20
2.18.0.rc1
