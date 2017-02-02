Received: from eggs.gnu.org ([2001:4830:134:3::10]:57038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philipp.gesang@intra2net.com>) id 1cZFlG-0004B8-Uy
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philipp.gesang@intra2net.com>) id 1cZFlD-0007rw-OP
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:41:10 -0500
From: Philipp Gesang <philipp.gesang@intra2net.com>
Date: Thu,  2 Feb 2017 12:41:01 +0100
Message-Id: <20170202114101.2655-1-philipp.gesang@intra2net.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] docs: update manpage for stderr->log rename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Philipp Gesang <philipp.gesang@intra2net.com>

With commit ed7f5f1d8db06fc31352a5ef4f54985e630c575a the name of
this backend changed from =E2=80=9Cstderr=E2=80=9D to =E2=80=9Clog=E2=80=9D=
.

Signed-off-by: Philipp Gesang <philipp.gesang@intra2net.com>
---
 qemu-option-trace.texi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-option-trace.texi b/qemu-option-trace.texi
index 693ab5a3e1..4166d5cdc2 100644
--- a/qemu-option-trace.texi
+++ b/qemu-option-trace.texi
@@ -5,7 +5,7 @@ Specify tracing options.
 Immediately enable events matching @var{pattern}.
 The file must contain one event name (as listed in the @file{trace-event=
s-all}
 file) per line; globbing patterns are accepted too.  This option is only
-available if QEMU has been compiled with the @var{simple}, @var{stderr}
+available if QEMU has been compiled with the @var{simple}, @var{log}
 or @var{ftrace} tracing backend.  To specify multiple events or patterns=
,
 specify the @option{-trace} option multiple times.
=20
@@ -15,7 +15,7 @@ Use @code{-trace help} to print a list of names of trac=
e points.
 Immediately enable events listed in @var{file}.
 The file must contain one event name (as listed in the @file{trace-event=
s-all}
 file) per line; globbing patterns are accepted too.  This option is only
-available if QEMU has been compiled with the @var{simple}, @var{stderr} =
or
+available if QEMU has been compiled with the @var{simple}, @var{log} or
 @var{ftrace} tracing backend.
=20
 @item file=3D@var{file}
--=20
2.11.0
