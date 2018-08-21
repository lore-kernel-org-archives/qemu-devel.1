Received: from eggs.gnu.org ([2001:4830:134:3::10]:42342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1TH-0008Hu-8e
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1TE-0007qe-3t
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:52:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs1TD-0007qK-VG
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:52:56 -0400
Date: Tue, 21 Aug 2018 09:52:54 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821075254.jheqod47stoc6fpp@sirius.home.kraxel.org>
References: <20180802155147.1863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802155147.1863-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/2] mips: convert devices away from
 old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Aleksandar Markovic <aleksandar.markovic@mips.com>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>

On Thu, Aug 02, 2018 at 04:51:45PM +0100, Peter Maydell wrote:
> These patches convert a couple of devices used only by MIPS
> boards from using the old_mmio MemoryRegionOps accessor functions.
> 
>  * vga-isa-mm: used by the MIPS 'jazz' boards "magnum" and "pica61"
>  * bonito pci controller: used by the MIPS "fulong2e" board
> 
> Tested only with "make check".

Added to vga queue.

thanks,
  Gerd
