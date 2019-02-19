Received: from eggs.gnu.org ([209.51.188.92]:34790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gw1bp-0008GO-4L
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gw1bj-00048g-HZ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:22:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gw1be-00047l-L5
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:22:26 -0500
Date: Tue, 19 Feb 2019 10:22:23 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190219092223.5y2hx4m3myjkir6f@sirius.home.kraxel.org>
References: <20190211040434.1C98674569F@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211040434.1C98674569F@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Mon, Feb 11, 2019 at 04:19:14AM +0100, BALATON Zoltan wrote:
> At least two machines, the PPC mac99 and MIPS fulong2e, have an ATI
> gfx chip by default (Rage 128 Pro and M6/RV100 respectively) and
> guests running on these and the PMON2000 firmware of the fulong2e
> expect this to be available. Fortunately these are very similar chips
> so they can be mostly emulated in the same device model. This patch
> adds basic emulation of these ATI VGA chips.
> 
> While this is incomplete and currently only enough to run the MIPS
> firmware and get console output with Linux,

Which linux driver is this?

If linux has a native driver it might make sense to also enable it on
x86.  Makes testing easier.

You can add the driver to default_list[] in vl.c, then you don't need
-vga none to remove the default vga when adding -device ati-vga.

>From a very brief look this looks sane overall, will have to find some
time for a more detailed review.

cheers,
  Gerd
