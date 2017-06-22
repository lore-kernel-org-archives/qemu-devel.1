Received: from eggs.gnu.org ([2001:4830:134:3::10]:45908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1TG-0007pJ-0o
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1TE-0006wc-DU
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1TE-0006wU-7M
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27D3E65738
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:44:23 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:59 +0200
Message-Id: <20170622124204.19407-27-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 26/31] decnumber: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 libdecnumber/decNumber.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libdecnumber/decNumber.c b/libdecnumber/decNumber.c
index c9e7807f87..8c197023f4 100644
--- a/libdecnumber/decNumber.c
+++ b/libdecnumber/decNumber.c
@@ -4775,7 +4775,7 @@ static decNumber * decDivideOp(decNumber *res,
 	    half=3D*up & 0x01;
 	    *up/=3D2;		   /* [shift] */
 	    if (!half) continue;
-	    *(up-1)+=3D(DECDPUNMAX+1)/2;
+	    *(up-1)+=3DDIV_ROUND_UP(DECDPUNMAX, 2);
 	    }
 	  /* [accunits still describes the original remainder length] */
=20
--=20
2.13.1.395.gf7b71de06
