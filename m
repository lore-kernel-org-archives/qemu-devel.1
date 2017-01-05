Received: from eggs.gnu.org ([2001:4830:134:3::10]:53419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIG-00079s-KS
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIF-0002fV-Tj
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cPBIF-0002f9-OT
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:35 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D074E15552
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:53:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  5 Jan 2017 17:53:11 +0100
Message-Id: <20170105165329.17227-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-1-marcandre.lureau@redhat.com>
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/20] qemu-options: stdio is available on win32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Available since commit db418a0a7ef5887ea0f3d167584e6f500bb0c4c5
(October 2011, qemu 1.0)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-options.hx | 2 --
 1 file changed, 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index c534a2f7f9..6ee8a8adc3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2431,8 +2431,6 @@ Connect to standard input and standard output of th=
e QEMU process.
 exiting QEMU with the key sequence @key{Control-c}. This option is enabl=
ed by
 default, use @option{signal=3Doff} to disable it.
=20
-@option{stdio} is not available on Windows hosts.
-
 @item -chardev braille ,id=3D@var{id}
=20
 Connect to a local BrlAPI server. @option{braille} does not take any opt=
ions.
--=20
2.11.0
