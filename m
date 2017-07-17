Received: from eggs.gnu.org ([2001:4830:134:3::10]:55468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dX6ny-0004eR-IS
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dX6nx-0003vN-Iv
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:15:22 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dX6nx-0003ut-Cd
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:15:21 -0400
Date: Mon, 17 Jul 2017 16:15:19 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170717141519.ecfti2drjkkqz4ej@aurel32.net>
References: <3349c01e-1f1a-2111-28c2-70fb5cc077cd@physik.fu-berlin.de>
	<20170707163826.22631-1-rth@twiddle.net>
	<CAD-reDZ5RUnTm3JZG7rQ_dDSE41KJ_HoARQuiCLpT0wkdcowAQ@mail.gmail.com>
	<6894e2eb-2ca2-cf92-80fc-b715996aba3e@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6894e2eb-2ca2-cf92-80fc-b715996aba3e@twiddle.net>
Subject: Re: [Qemu-devel] Fwd: [PATCH v2.5] fixup! linux-user/sh4: Notice
 gUSA regions during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 2017-07-07 09:00, Richard Henderson wrote:
> On 07/07/2017 07:57 AM, Richard Henderson wrote:
> > +    /* ??? The SH4 kernel checks for and address above 0xC0000000.
> > +       However, the page mappings in qemu linux-user aren't as restricted
> > +       and we wind up with the normal stack mapped above 0xF0000000.
> > +       That said, there is no reason why the kernel should be allowing
> > +       a gUSA region that spans 1GB.  Use a tighter check here, for what
> > +       can actually be enabled by the immediate move.  */
> 
> Additionally, I can (and should) fix the address space problem for SH4 in
> linux-user/main.c, where we have already done so for MIPS and Nios2.
> 
> See the initialization of reserved_va.

I guess it's what you have done in the "linux-user fixes for va
mapping", which renders this version 2.5 obsolete. Therefore I guess the
version 2 is the one to be used instead.

Unfortunately my knowledge of linux-user is rather limited to review
this new series.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
