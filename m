Received: from eggs.gnu.org ([2001:4830:134:3::10]:44851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faxzh-0006Zx-OH
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faxze-00078t-MO
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:43:57 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  5 Jul 2018 08:43:48 +0200
Message-Id: <20180705064348.3162-3-kraxel@redhat.com>
In-Reply-To: <20180705064348.3162-1-kraxel@redhat.com>
References: <20180705064348.3162-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] vga: don't pick cirrus by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Sebastian Bauer <mail@sebastianbauer.info>, Gerd Hoffmann <kraxel@redhat.com>

Now that all machines which need cirrus explicitly select it qemu
doesn't need to consider it as default display any more.  Drop it.

With this patch applied all ppc machine types will use "std" as default
display, no matter whenever cirrus-vga is compiled in or not.

Fixes: 29f9cef39e ppc: Include vga cirrus card into the compiling process
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/vl.c b/vl.c
index 16b913f9d5..117e4e6879 100644
--- a/vl.c
+++ b/vl.c
@@ -4475,8 +4475,6 @@ int main(int argc, char **argv, char **envp)
     if (default_vga) {
         if (machine_class->default_display) {
             vga_model = machine_class->default_display;
-        } else if (vga_interface_available(VGA_CIRRUS)) {
-            vga_model = "cirrus";
         } else if (vga_interface_available(VGA_STD)) {
             vga_model = "std";
         }
-- 
2.9.3
