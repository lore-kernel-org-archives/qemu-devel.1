Received: from eggs.gnu.org ([2001:4830:134:3::10]:59725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33E-0003O1-B3
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33C-0006Tx-Id
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS33C-0006T9-9f
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:54 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C25061BA9
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:41:54 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:24 +0100
Message-Id: <20170113144135.5150-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 10/21] docs: add master qapi texi files
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

The qapi2texi script generates a file to be included in a texi file. Add
"QEMU QMP Reference Manual" and "QEMU Guest Agent Protocol Reference"
master texi files.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 docs/qemu-ga-ref.texi  | 74 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 docs/qemu-qmp-ref.texi | 74 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 148 insertions(+)
 create mode 100644 docs/qemu-ga-ref.texi
 create mode 100644 docs/qemu-qmp-ref.texi

diff --git a/docs/qemu-ga-ref.texi b/docs/qemu-ga-ref.texi
new file mode 100644
index 0000000000..b8898027dc
--- /dev/null
+++ b/docs/qemu-ga-ref.texi
@@ -0,0 +1,74 @@
+\input texinfo
+@setfilename qemu-ga-ref.info
+
+@exampleindent 0
+@paragraphindent 0
+
+@settitle QEMU Guest Agent Protocol Reference
+
+@copying
+This is the QEMU Guest Agent Protocol reference manual.
+
+Copyright @copyright{} 2016 The QEMU Project developers
+
+@quotation
+This manual is free documentation: you can redistribute it and/or
+modify it under the terms of the GNU General Public License as
+published by the Free Software Foundation, either version 2 of the
+License, or (at your option) any later version.
+
+This manual is distributed in the hope that it will be useful, but
+WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this manual.  If not, see http://www.gnu.org/licenses/.
+@end quotation
+@end copying
+
+@dircategory QEMU
+@direntry
+* QEMU-GA-Ref: (qemu-ga-ref).   QEMU Guest Agent Protocol Reference
+@end direntry
+
+@titlepage
+@title Guest Agent Protocol Reference Manual
+@subtitle QEMU version @value{VERSION}
+@page
+@vskip 0pt plus 1filll
+@insertcopying
+@end titlepage
+
+@contents
+
+@ifnottex
+@node Top
+@top QEMU Guest Agent protocol reference
+@end ifnottex
+
+@menu
+* API Reference::
+* Commands and Events Index::
+* Data Types Index::
+@end menu
+
+@node API Reference
+@chapter API Reference
+
+@c for texi2pod:
+@c man begin DESCRIPTION
+
+@include qemu-ga-qapi.texi
+
+@c man end
+
+@node Commands and Events Index
+@unnumbered Commands and Events Index
+@printindex fn
+
+@node Data Types Index
+@unnumbered Data Types Index
+@printindex tp
+
+@bye
diff --git a/docs/qemu-qmp-ref.texi b/docs/qemu-qmp-ref.texi
new file mode 100644
index 0000000000..efb3370a24
--- /dev/null
+++ b/docs/qemu-qmp-ref.texi
@@ -0,0 +1,74 @@
+\input texinfo
+@setfilename qemu-qmp-ref.info
+
+@exampleindent 0
+@paragraphindent 0
+
+@settitle QEMU QMP Reference Manual
+
+@copying
+This is the QEMU QMP reference manual.
+
+Copyright @copyright{} 2016 The QEMU Project developers
+
+@quotation
+This manual is free documentation: you can redistribute it and/or
+modify it under the terms of the GNU General Public License as
+published by the Free Software Foundation, either version 2 of the
+License, or (at your option) any later version.
+
+This manual is distributed in the hope that it will be useful, but
+WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this manual.  If not, see http://www.gnu.org/licenses/.
+@end quotation
+@end copying
+
+@dircategory QEMU
+@direntry
+* QEMU-QMP-Ref: (qemu-qmp-ref). QEMU QMP Reference Manual
+@end direntry
+
+@titlepage
+@title QMP Reference Manual
+@subtitle QEMU version @value{VERSION}
+@page
+@vskip 0pt plus 1filll
+@insertcopying
+@end titlepage
+
+@contents
+
+@ifnottex
+@node Top
+@top QEMU QMP reference
+@end ifnottex
+
+@menu
+* API Reference::
+* Commands and Events Index::
+* Data Types Index::
+@end menu
+
+@node API Reference
+@chapter API Reference
+
+@c for texi2pod:
+@c man begin DESCRIPTION
+
+@include qemu-qapi.texi
+
+@c man end
+
+@node Commands and Events Index
+@unnumbered Commands and Events Index
+@printindex fn
+
+@node Data Types Index
+@unnumbered Data Types Index
+@printindex tp
+
+@bye
--=20
2.11.0
