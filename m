Received: from eggs.gnu.org ([2001:4830:134:3::10]:40627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbS1-0005TB-W9
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbRz-00013T-3S
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:57:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53026 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1etbRy-00013L-VA
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:57:55 -0500
From: marcandre.lureau@redhat.com
Date: Wed,  7 Mar 2018 16:57:40 +0100
Message-Id: <20180307155746.18526-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180307155746.18526-1-marcandre.lureau@redhat.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/8] SecurityPkg/Tcg2Pei: drop
 PeiReadOnlyVariable from Depex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, lersek@redhat.com, qemu-devel@nongnu.org, javierm@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The module doesn't use read-only variable.

Cc: Laszlo Ersek <lersek@redhat.com>
Contributed-under: TianoCore Contribution Agreement 1.1
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf | 1 -
 1 file changed, 1 deletion(-)

diff --git a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf b/SecurityPkg/Tcg/Tcg2Pe=
i/Tcg2Pei.inf
index bc910c3baf97..a4aae1488ff8 100644
--- a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
+++ b/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
@@ -91,7 +91,6 @@ [Pcd]
=20
 [Depex]
   gEfiPeiMasterBootModePpiGuid AND
-  gEfiPeiReadOnlyVariable2PpiGuid AND
   gEfiTpmDeviceSelectedGuid
=20
 [UserExtensions.TianoCore."ExtraFiles"]
--=20
2.16.2.346.g9779355e34
