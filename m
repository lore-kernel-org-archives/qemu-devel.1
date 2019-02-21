Received: from eggs.gnu.org ([209.51.188.92]:45392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gwpFb-0008Jc-CL
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gwpFa-0006ZC-LF
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:22:59 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:35850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gwpFa-0006QQ-8I
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:22:58 -0500
Date: Thu, 21 Feb 2019 15:22:46 +0100
From: Sven Schnelle <svens@stackframe.org>
Message-ID: <20190221142246.GA19123@t470p.stackframe.org>
References: <20190218183314.20157-1-svens@stackframe.org>
	<b1fa8a79-c7dc-0e30-b8e3-a11657667143@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1fa8a79-c7dc-0e30-b8e3-a11657667143@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2] hw/hppa/dino: mask out lower 2 bits of
 PCI config addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, deller@gmx.de

Hi Richard,

On Wed, Feb 20, 2019 at 10:57:50AM -0800, Richard Henderson wrote:

> Can you re-test with the following?
> 
> If the stores are all aligned, then the reads to not need to re-align.
> Also, partial writes to the config register don't make much sense.
> Over in hw/pci/pci_host.c, we check addr == 0 && len == 4, which is a
> very old fashioned way to do the .valid thing.

With your proposed change it works as well - should i send a v2 or will you
take care of updating the patch?

Thanks
Sven
