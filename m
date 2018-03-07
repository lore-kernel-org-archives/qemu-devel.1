Received: from eggs.gnu.org ([2001:4830:134:3::10]:40628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbS1-0005TD-WA
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbRx-00012v-Mr
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:57:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1etbRx-00012R-JI
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:57:53 -0500
From: marcandre.lureau@redhat.com
Date: Wed,  7 Mar 2018 16:57:39 +0100
Message-Id: <20180307155746.18526-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180307155746.18526-1-marcandre.lureau@redhat.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/8] SecurityPkg: also clear
 HashInterfaceHob.SupportedHashMask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, lersek@redhat.com, qemu-devel@nongnu.org, javierm@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Chao Zhang <chao.b.zhang@intel.com>, Star Zeng <star.zeng@intel.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Commit 4cc2b63bd829426b05bad0d8952f1855a10d6ed7 fixed an out of bounds
ZeroMem() call. However, as Laszlo Ersek pointed out, the intent was
to clear all but the Identifier (to revert the effect of
RegisterHashInterfaceLib()). For that, it should clear the
SupportedHashMask too.

Cc: Jiewen Yao <jiewen.yao@intel.com>
Cc: Chao Zhang <chao.b.zhang@intel.com>
Cc: Star Zeng <star.zeng@intel.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Contributed-under: TianoCore Contribution Agreement 1.1
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 .../Library/HashLibBaseCryptoRouter/HashLibBaseCryptoRouterPei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCrypt=
oRouterPei.c b/SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCry=
ptoRouterPei.c
index 361a4f6508a0..bf6e1336ee76 100644
--- a/SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCryptoRouter=
Pei.c
+++ b/SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCryptoRouter=
Pei.c
@@ -426,6 +426,7 @@ HashLibBaseCryptoRouterPeiConstructor (
     //
     ZeroMem (&HashInterfaceHob->HashInterface, sizeof (HashInterfaceHob-=
>HashInterface));
     HashInterfaceHob->HashInterfaceCount =3D 0;
+    HashInterfaceHob->SupportedHashMask =3D 0;
   }
=20
   //
--=20
2.16.2.346.g9779355e34
