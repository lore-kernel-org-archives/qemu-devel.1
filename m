Received: from eggs.gnu.org ([2001:4830:134:3::10]:37965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAb-0007CA-1o
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAZ-0000Oi-Bd
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:32 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:39705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAZ-0000My-4p
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:31 -0400
Received: by mail-wm0-x234.google.com with SMTP id p11-v6so10223452wmc.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:31 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:26 +0200
Message-Id: <1530216310-52873-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/60] qemu-options: Add missing newline to
 -accel help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>

From: Eduardo Habkost <ehabkost@redhat.com>

The newline was removed by commit c97d6d2c, and broke -help output:

Before this patch:

  $ qemu-system-x86_64 -help | grep smp
                  thread=single|multi (enable multi-threaded TCG)-smp [...]

After this patch:

  $ qemu-system-x86_64 -help  | grep smp
  -smp [cpus=]n[,maxcpus=cpus][,cores=cores][,threads=threads][,sockets=sockets]

Fixes: c97d6d2cdf97edb4aebe832fdba65d701ad7bcb6
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180611195607.3015-1-ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index d5b0c26..2707728 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -130,7 +130,7 @@ ETEXI
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,thread=single|multi]\n"
     "                select accelerator (kvm, xen, hax, hvf, whpx or tcg; use 'help' for a list)\n"
-    "                thread=single|multi (enable multi-threaded TCG)", QEMU_ARCH_ALL)
+    "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
 STEXI
 @item -accel @var{name}[,prop=@var{value}[,...]]
 @findex -accel
-- 
1.8.3.1
