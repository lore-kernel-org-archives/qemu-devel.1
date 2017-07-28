Received: from eggs.gnu.org ([2001:4830:134:3::10]:53575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db8Q4-0004Ab-2t
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db8Q3-0002Cr-31
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:47:20 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 28 Jul 2017 11:47:05 -0500
Message-Id: <20170728164708.12202-2-eblake@redhat.com>
In-Reply-To: <20170728164708.12202-1-eblake@redhat.com>
References: <20170728164708.12202-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/4] qemu-img: Sort sub-command names in
 --help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, peter.maydell@linaro.org

'amend' was the only sub-command not listed alphabetically; hoist
it earlier, and separate the @end table block to make it easier
to copy-and-paste the addition of future sub-commands.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-img-cmds.hx | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 3763f13625..8bd6f748c3 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -9,6 +9,12 @@ STEXI
 @table @option
 ETEXI

+DEF("amend", img_amend,
+    "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t cache] -o options filename")
+STEXI
+@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
+ETEXI
+
 DEF("bench", img_bench,
     "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-w] [-U] filename")
 STEXI
@@ -87,9 +93,6 @@ STEXI
 @item resize [--object @var{objectdef}] [--image-opts] [-q] @var{filename} [+ | -]@var{size}
 ETEXI

-DEF("amend", img_amend,
-    "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t cache] -o options filename")
 STEXI
-@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
 @end table
 ETEXI
-- 
2.13.3
