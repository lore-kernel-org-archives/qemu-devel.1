Received: from eggs.gnu.org ([209.51.188.92]:58150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h12ms-0000N7-Jm
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h12mr-0004Xd-Nz
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:38:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h12mr-0004XH-I2
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:38:45 -0500
Date: Tue, 5 Mar 2019 06:38:42 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190305053842.m2u5ahgztybbzpaj@sirius.home.kraxel.org>
References: <alpine.BSF.2.21.9999.1903041535050.72040@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1903041535050.72040@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] Question about hardware cursor in VGA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org

On Mon, Mar 04, 2019 at 03:58:00PM +0100, BALATON Zoltan wrote:
> Hello,
> 
> I'm trying to implement hardware cursor for ati-vga before submitting the
> last version of it before the freeze.

Use dpy_cursor_define().

cheers,
  Gerd
