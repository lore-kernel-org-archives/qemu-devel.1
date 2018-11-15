Received: from eggs.gnu.org ([2001:4830:134:3::10]:35948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNHHD-00075m-8s
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNHH7-0003cK-5e
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:01:42 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:60841)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1gNHH6-0003WX-Vp
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:01:37 -0500
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 15 Nov 2018 14:01:12 +0100
Message-Id: <a70786b87c3bff7780c8121ad53e3a04d5d98c1b.1542285958.git.simon@ruderich.org>
In-Reply-To: <cover.1542285958.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1542285958.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v6 4/6] hmp: use F for filename arguments in
 memsave/pmemsave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Simon Ruderich <simon@ruderich.org>

This enables completion for the filename arguments.

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Simon Ruderich <simon@ruderich.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index ff96c3ad24..2404a5210d 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -833,7 +833,7 @@ ETEXI
 
     {
         .name       = "memsave",
-        .args_type  = "val:l,size:l,filename:s",
+        .args_type  = "val:l,size:l,filename:F",
         .params     = "addr size file",
         .help       = "save to disk virtual memory dump starting at 'addr' of size 'size'",
         .cmd        = hmp_memsave,
@@ -847,7 +847,7 @@ ETEXI
 
     {
         .name       = "pmemsave",
-        .args_type  = "val:l,size:l,filename:s",
+        .args_type  = "val:l,size:l,filename:F",
         .params     = "addr size file",
         .help       = "save to disk physical memory dump starting at 'addr' of size 'size'",
         .cmd        = hmp_pmemsave,
-- 
2.19.1
