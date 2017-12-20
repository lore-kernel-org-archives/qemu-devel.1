Received: from eggs.gnu.org ([2001:4830:134:3::10]:35914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRZbD-0001Nw-Lm
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRZbC-0002cv-BL
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:19:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRZbC-0002bn-4W
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:19:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 455747E421
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 08:19:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 09:19:24 +0100
Message-Id: <20171220081927.8761-8-armbru@redhat.com>
In-Reply-To: <20171220081927.8761-1-armbru@redhat.com>
References: <20171220081927.8761-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 07/10] qemu-options: Polish section
 "Character device options"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Cc: Paolo Bonzini <pbonzini@redhat.com>
CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-options.hx | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 372cbabb7f..80b2331a32 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2502,11 +2502,6 @@ ETEXI
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
@@ -2552,6 +2547,9 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
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
@@ -2575,7 +2573,7 @@ Backend is one of:
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
@@ -2630,8 +2628,11 @@ to a file to record all data transmitted via the b=
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
