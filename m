Received: from eggs.gnu.org ([2001:4830:134:3::10]:59856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33T-0003bq-9K
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33R-0006e6-6I
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS33Q-0006dU-TV
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:09 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 102858FCE6
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:42:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:30 +0100
Message-Id: <20170113144135.5150-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 16/21] docs: add qemu logo to pdf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a logo to texi2pdf output. Other formats (info/html) are left as
future improvements.

The PDF (needed by texi2pdf for vectorized images) was generated from
pc-bios/qemu_logo.svg like this:

inkscape --export-pdf=3Ddocs/qemu_logo.pdf pc-bios/qemu_logo.svg

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 docs/qemu-ga-ref.texi  |   4 ++++
 docs/qemu-qmp-ref.texi |   4 ++++
 docs/qemu_logo.pdf     | Bin 0 -> 9117 bytes
 3 files changed, 8 insertions(+)
 create mode 100644 docs/qemu_logo.pdf

diff --git a/docs/qemu-ga-ref.texi b/docs/qemu-ga-ref.texi
index b8898027dc..87cc8d01a5 100644
--- a/docs/qemu-ga-ref.texi
+++ b/docs/qemu-ga-ref.texi
@@ -6,6 +6,10 @@
=20
 @settitle QEMU Guest Agent Protocol Reference
=20
+@iftex
+@center @image{docs/qemu_logo}
+@end iftex
+
 @copying
 This is the QEMU Guest Agent Protocol reference manual.
=20
diff --git a/docs/qemu-qmp-ref.texi b/docs/qemu-qmp-ref.texi
index efb3370a24..818e52573b 100644
--- a/docs/qemu-qmp-ref.texi
+++ b/docs/qemu-qmp-ref.texi
@@ -6,6 +6,10 @@
=20
 @settitle QEMU QMP Reference Manual
=20
+@iftex
+@center @image{docs/qemu_logo}
+@end iftex
+
 @copying
 This is the QEMU QMP reference manual.
=20
diff --git a/docs/qemu_logo.pdf b/docs/qemu_logo.pdf
new file mode 100644
index 0000000000000000000000000000000000000000..294cb7dec50de73c786925671=
300fb0abdf9d641
GIT binary patch
literal 9117
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

literal 0
HcmV?d00001

--=20
2.11.0
