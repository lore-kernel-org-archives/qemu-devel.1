Received: from eggs.gnu.org ([2001:4830:134:3::10]:48917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gNJOf-0003ud-Hj
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gNJOb-0003Fy-78
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:17:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1gNJOa-0003Cm-OY
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:17:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AE63C051685
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 15:17:23 +0000 (UTC)
From: Erik Skultety <eskultet@redhat.com>
Date: Thu, 15 Nov 2018 16:15:53 +0100
Message-Id: <cover.1542294676.git.eskultet@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] Introduce 'rendernode' option for
 egl-headless display type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Erik Skultety <eskultet@redhat.com>, kraxel@redhat.com

Since QEMU always picks the default DRI device, libvirt doesn't know whic=
h one
to put into the mount namespace and relabel it accordingly, hence hitting
permission issues, unless admin tweaks the default permissions of the DRI
devices.

https://bugzilla.redhat.com/show_bug.cgi?id=3D1648236

Erik Skultety (3):
  qapi: Add "rendernode" display option for egl-headless
  ui: Allow specifying 'rendernode' display option for egl-headless
  help: Provide help for egl-headless

 qapi/ui.json      | 16 +++++++++++++++-
 qemu-options.hx   |  6 +++++-
 ui/egl-headless.c |  2 +-
 3 files changed, 21 insertions(+), 3 deletions(-)

--
2.19.1
