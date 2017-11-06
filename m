Received: from eggs.gnu.org ([2001:4830:134:3::10]:60030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1eBVfo-0001zm-P4
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1eBVfl-00086x-NX
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:53:56 -0500
Received: from speedy.comstyle.com ([206.51.28.2]:25607 helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1eBVfl-00084t-Hv
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:53:53 -0500
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id A6F6C9843A
	for <qemu-devel@nongnu.org>; Sun,  5 Nov 2017 19:53:38 -0500 (EST)
Received: from humpty.home.comstyle.com (unknown
	[IPv6:2607:fea8:12c0:f00:3c40:9470:82cf:3fa8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested) (Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 79EC098439
	for <qemu-devel@nongnu.org>; Sun,  5 Nov 2017 19:53:38 -0500 (EST)
Date: Sun, 5 Nov 2017 19:53:30 -0500
From: Brad Smith <brad@comstyle.com>
Message-ID: <20171106005328.GB84093@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] configure: Deal with OpenBSD/i386 emulation
 linker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

OpenBSD/i386 uses elf_i386_obsd for the emulation linker.

Signed-off-by: Brad Smith <brad@comstyle.com>


diff --git a/configure b/configure
index dd73cce62f..02799d38ac 100755
--- a/configure
+++ b/configure
@@ -5159,9 +5159,9 @@ if test \( "$cpu" = "i386" -o "$cpu" = "x86_64" \) -a \
         "$targetos" != "Darwin" -a "$targetos" != "SunOS" -a \
         "$softmmu" = yes ; then
     # Different host OS linkers have different ideas about the name of the ELF
-    # emulation. Linux and OpenBSD use 'elf_i386'; FreeBSD uses the _fbsd
-    # variant; and Windows uses i386pe.
-    for emu in elf_i386 elf_i386_fbsd i386pe; do
+    # emulation. Linux uses 'elf_i386'; FreeBSD uses the _fbsd variant;
+    # OpenBSD uses the _obsd variant; and Windows uses i386pe.
+    for emu in elf_i386 elf_i386_fbsd elf_i386_obsd i386pe; do
         if "$ld" -verbose 2>&1 | grep -q "^[[:space:]]*$emu[[:space:]]*$"; then
             ld_i386_emulation="$emu"
             roms="optionrom"
