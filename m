Received: from eggs.gnu.org ([2001:4830:134:3::10]:53136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csWwp-0001S2-3R
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csWwo-0006CZ-HX
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:52:47 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 27 Mar 2017 17:52:29 +0200
Message-Id: <20170327155234.10980-2-mreitz@redhat.com>
In-Reply-To: <20170327155234.10980-1-mreitz@redhat.com>
References: <20170327155234.10980-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] qemu-img: show help for invalid global
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

The qemu-img sub-command executes regardless of invalid global options:

  $ qemu-img --foo info test.img
  qemu-img: unrecognized option '--foo'
  image: test.img
  ...

The unrecognized option warning may be missed by the user.  This can
hide incorrect command-lines in scripts and confuse users.

This patch prints the help information and terminates instead of
executing the sub-command.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170317104541.28979-2-stefanha@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qemu-img.c b/qemu-img.c
index 98b836b030..ce293a4710 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4339,6 +4339,7 @@ int main(int argc, char **argv)
     while ((c = getopt_long(argc, argv, "+hVT:", long_options, NULL)) != -1) {
         switch (c) {
         case 'h':
+        case '?':
             help();
             return 0;
         case 'V':
-- 
2.12.1
