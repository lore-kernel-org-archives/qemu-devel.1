Received: from eggs.gnu.org ([2001:4830:134:3::10]:53885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiK-0002qk-Fq
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiI-0004T8-QE
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgIiI-0004Sb-Kw
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:14 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C421E80461
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 22:15:14 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 23:14:58 +0100
Message-Id: <1487715299-21102-9-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 8/9] update -g command line switch documentation
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

Bring documentation in line with the recent changes.
Text suggested by L=C3=A1szl=C3=B3 =C3=89rsek.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qemu-options.hx | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 4e89610..ae62e0d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1241,7 +1241,18 @@ DEF("g", 1, QEMU_OPTION_g ,
 STEXI
 @item -g @var{width}x@var{height}[x@var{depth}]
 @findex -g
-Set the initial graphical resolution and depth (PPC, SPARC only).
+Set the initial graphical resolution and depth.
+
+This setting may be masked by guest firmware temporarily.
+
+On PPC and SPARC, the guest firmware will configure the display from
+this setting, and the guest OS will inherit the display resolution
+and depth.
+
+On x86 and ARM, if the guest firmware is an edk2 (UEFI) platform,
+the firmware may initially configure the display according to its own,
+persistent, independent settings. The guest OS drivers, once loaded,
+should adhere to "-g" however, for virtio and qxl adapters.
 ETEXI
=20
 DEF("vnc", HAS_ARG, QEMU_OPTION_vnc ,
--=20
1.8.3.1
