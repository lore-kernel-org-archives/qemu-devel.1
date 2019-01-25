Received: from eggs.gnu.org ([209.51.188.92]:46469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gn1aK-0002lc-7T
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gn1aI-0002Y2-Rb
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:31:52 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36397 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gn1aI-0002WJ-Gk
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:31:50 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 25 Jan 2019 14:31:37 +0100
Message-Id: <1548423098-31864-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 13/14] qemu-doc: Add nanoMIPS ISA information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add nanoMIPS information in qemu-doc.texi. An example of usage
is included.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 qemu-doc.texi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 16b955c..83be010 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1995,6 +1995,10 @@ Set the emulated machine type. The default is sun4u.
 @section MIPS System emulator
 @cindex system emulation (MIPS)
 
+@menu
+* nanoMIPS System emulator ::
+@end menu
+
 Four executables cover simulation of 32 and 64-bit MIPS systems in
 both endian options, @file{qemu-system-mips}, @file{qemu-system-mipsel}
 @file{qemu-system-mips64} and @file{qemu-system-mips64el}.
@@ -2086,6 +2090,31 @@ SCSI controller
 G364 framebuffer
 @end itemize
 
+@node nanoMIPS System emulator
+@subsection nanoMIPS System emulator
+@cindex system emulation (nanoMIPS)
+
+Executable @file{qemu-system-mipsel} also covers simulation of
+32-bit nanoMIPS system in little endian mode:
+
+@itemize @minus
+@item
+nanoMIPS I7200 CPU
+@end itemize
+
+Example of @file{qemu-system-mipsel} usage for nanoMIPS is shown below:
+
+Download @code{<disk_image_file>} from @url{https://mipsdistros.mips.com/LinuxDistro/nanomips/buildroot/index.html}.
+
+Download @code{<kernel_image_file>} from @url{https://mipsdistros.mips.com/LinuxDistro/nanomips/kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/index.html}.
+
+Start system emulation of Malta board with nanoMIPS I7200 CPU:
+@example
+qemu-system-mipsel -cpu I7200 -kernel @code{<kernel_image_file>} \
+    -M malta -serial stdio -m @code{<memory_size>} -hda @code{<disk_image_file>} \
+    -append "mem=256m@@0x0 rw console=ttyS0 vga=cirrus vesa=0x111 root=/dev/sda"
+@end example
+
 
 @node ARM System emulator
 @section ARM System emulator
-- 
2.7.4
