Received: from eggs.gnu.org ([2001:4830:134:3::10]:54032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1ekBDa-0007M2-6s
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1ekBDY-0001Fm-BM
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:08:06 -0500
Received: from leibniz.telenet-ops.be ([195.130.137.77]:55138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1ekBDY-0001Ey-0g
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:08:04 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
	[IPv6:2a02:1800:120:4::f00:13])
	by leibniz.telenet-ops.be (Postfix) with ESMTPS id 3zdJw02yrhzMqYmh
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 16:32:16 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  9 Feb 2018 16:16:50 +0100
Message-Id: <1518189413-2761-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1518189413-2761-1-git-send-email-geert+renesas@glider.be>
References: <1518189413-2761-1-git-send-email-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH/RFC 3/6] clk: renesas: r8a7795: Mark the GPIO6
 clock critical
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexander Graf <agraf@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, kvm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, qemu-devel@nongnu.org, Geert Uytterhoeven <geert+renesas@glider.be>

The GPIO6 block will be exported to a guest.  As long as the guest won't
manage its module clock, it must be kept running by the host.

Not-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
TODO: Find a way to manage module clocks using PM Domains and Runtime
      PM on the guest.
---
 drivers/clk/renesas/r8a7795-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index b1d9f48eae9e6ad4..6fbfd5973a889b7d 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -271,6 +271,7 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 
 static const unsigned int r8a7795_crit_mod_clks[] __initconst = {
 	MOD_CLK_ID(408),	/* INTC-AP (GIC) */
+	MOD_CLK_ID(906),	/* GPIO6 */
 };
 
 
-- 
2.7.4
