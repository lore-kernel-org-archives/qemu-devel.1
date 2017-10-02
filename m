Received: from eggs.gnu.org ([2001:4830:134:3::10]:40365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1JV-0005gf-QH
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1JR-0004ke-Rv
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1JR-0004kM-Lj
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ADB79806A6
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:03:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:03:06 +0200
Message-Id: <20171002140307.5292-8-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-1-armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 7/8] qemu-options: Polish section "Character
 device options"
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Cc: Paolo Bonzini <pbonzini@redhat.com>
CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-options.hx | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 615cb230ab..b792c65149 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2492,11 +2492,6 @@ ETEXI
 DEFHEADING()
=20
 DEFHEADING(Character device options:)
-STEXI
-
-The general form of a character device option is:
-@table @option
-ETEXI
=20
 DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "-chardev help\n"
@@ -2542,6 +2537,9 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
 )
=20
 STEXI
+
+The general form of a character device option is:
+@table @option
 @item -chardev @var{backend} ,id=3D@var{id} [,mux=3Don|off] [,@var{optio=
ns}]
 @findex -chardev
 Backend is one of:
@@ -2565,7 +2563,7 @@ Backend is one of:
 @option{spiceport}.
 The specific backend will determine the applicable options.
=20
-Use "-chardev help" to print all available chardev backend types.
+Use @code{-chardev help} to print all available chardev backend types.
=20
 All devices must have an id, which can be any string up to 127 character=
s long.
 It is used to uniquely identify this device in other command line direct=
ives.
@@ -2620,8 +2618,11 @@ to a file to record all data transmitted via the b=
ackend. The @option{logappend}
 option controls whether the log file will be truncated or appended to wh=
en
 opened.
=20
-Further options to each backend are described below.
+@end table
=20
+The available backends are:
+
+@table @option
 @item -chardev null ,id=3D@var{id}
 A void device. This device will not emit any data, and will drop any dat=
a it
 receives. The null backend does not take any options.
--=20
2.13.6
