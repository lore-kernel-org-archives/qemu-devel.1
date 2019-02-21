Received: from eggs.gnu.org ([209.51.188.92]:43346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmlM-0007Zj-3J
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmlL-0002qw-9u
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:43:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57689)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwmlL-0002q5-1T
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:43:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB5EE8665A
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:43:33 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 12:43:26 +0100
Message-Id: <20190221114330.17968-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] virtio-gpu fixes (resend)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Hi,

Here are a few patches that were in the vhost-user-gpu series, but are
worth to consider separately. In particular, "virtio-gpu: block both
2d and 3d rendering" fixes a bug reported on RH bugzilla recently.

Marc-Andr=C3=A9 Lureau (4):
  virtio-gpu: remove unused qdev
  virtio-gpu: remove unused config_size
  virtio-gpu: block both 2d and 3d rendering
  virtio-gpu: remove useless 'waiting' field

 include/hw/virtio/virtio-gpu.h |  5 -----
 hw/display/virtio-gpu-3d.c     | 21 ---------------------
 hw/display/virtio-gpu.c        | 31 ++++++++++++++++++++++---------
 3 files changed, 22 insertions(+), 35 deletions(-)

--=20
2.21.0.rc1
