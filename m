Received: from eggs.gnu.org ([2001:4830:134:3::10]:42163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cdJVd-0005PY-Lh
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cdJVa-0006OC-FV
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:29:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cdJVa-0006Np-9I
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:29:46 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 13 Feb 2017 16:29:39 +0000
Message-Id: <20170213162940.13428-2-stefanha@redhat.com>
In-Reply-To: <20170213162940.13428-1-stefanha@redhat.com>
References: <20170213162940.13428-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] docs: update manpage for stderr->log rename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philipp Gesang <philipp.gesang@intra2net.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Philipp Gesang <philipp.gesang@intra2net.com>

With commit ed7f5f1d8db06fc31352a5ef4f54985e630c575a the name of
this backend changed from =E2=80=9Cstderr=E2=80=9D to =E2=80=9Clog=E2=80=9D=
.

Signed-off-by: Philipp Gesang <philipp.gesang@intra2net.com>
Message-id: 20170202114101.2655-1-philipp.gesang@intra2net.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-option-trace.texi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-option-trace.texi b/qemu-option-trace.texi
index 693ab5a..4166d5c 100644
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
2.9.3
