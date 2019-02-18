Received: from eggs.gnu.org ([209.51.188.92]:45038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gvnkY-0007oG-QV
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gvnkW-00052a-LU
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:34:41 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:50983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gvnkW-0004zD-53
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:34:40 -0500
Date: Mon, 18 Feb 2019 19:34:35 +0100
From: Sven Schnelle <svens@stackframe.org>
Message-ID: <20190218183435.GA10958@t470p.stackframe.org>
References: <20190218182851.19714-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218182851.19714-1-svens@stackframe.org>
Subject: Re: [Qemu-devel] [PATCH] hw/hppa/dino: mask out lower 2 bits of PCI
 config addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Richard Henderson <rth@twiddle.net>

Hi List,

On Mon, Feb 18, 2019 at 07:28:51PM +0100, Sven Schnelle wrote:
> some versions of HP-UX 10.20 seems to rely on the fact that DINO
> strips out the lower 2 bits of the PCI configuration address.
> Also update the binary SeaBIOS distributed to the latest version
> from Helge's repository, which is required with that change.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  hw/hppa/dino.c            |  25 ++++++++++++++++++++++---
>  pc-bios/hppa-firmware.img | Bin 215936 -> 53 bytes
>  2 files changed, 22 insertions(+), 3 deletions(-)
>  mode change 100644 => 120000 pc-bios/hppa-firmware.img
> 

please ignore that patch and use v2 instead. I've accidently committed
a symlink to hppa-firmware.img.

Regards
Sven
