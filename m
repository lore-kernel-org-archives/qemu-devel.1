Received: from eggs.gnu.org ([2001:4830:134:3::10]:52480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1eCDZh-0005WH-Fy
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 18:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1eCDZg-0005YZ-Md
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 18:46:33 -0500
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:44606
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1eCDZg-0005Oj-3y
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 18:46:32 -0500
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id B547A9843B
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 18:46:19 -0500 (EST)
Received: from humpty.home.comstyle.com (unknown
	[IPv6:2607:fea8:12c0:f00:90d3:1871:bd7:c7e5])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested) (Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 5CC8E98439
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 18:46:17 -0500 (EST)
Date: Tue, 7 Nov 2017 18:46:11 -0500
From: Brad Smith <brad@comstyle.com>
Message-ID: <20171107234608.GA395@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2] configure: Deal with OpenBSD/i386 emulation
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
index dd73cce62f..c9dd747283 100755
--- a/configure
+++ b/configure
@@ -5159,9 +5159,9 @@ if test \( "$cpu" = "i386" -o "$cpu" = "x86_64" \) -a \
         "$targetos" != "Darwin" -a "$targetos" != "SunOS" -a \
         "$softmmu" = yes ; then
     # Different host OS linkers have different ideas about the name of the ELF
-    # emulation. Linux and OpenBSD use 'elf_i386'; FreeBSD uses the _fbsd
-    # variant; and Windows uses i386pe.
-    for emu in elf_i386 elf_i386_fbsd i386pe; do
+    # emulation. Linux and OpenBSD/amd64 use 'elf_i386'; FreeBSD uses the _fbsd
+    # variant; OpenBSD/i386 uses the _obsd variant; and Windows uses i386pe.
+    for emu in elf_i386 elf_i386_fbsd elf_i386_obsd i386pe; do
         if "$ld" -verbose 2>&1 | grep -q "^[[:space:]]*$emu[[:space:]]*$"; then
             ld_i386_emulation="$emu"
             roms="optionrom"
