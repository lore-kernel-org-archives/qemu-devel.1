Received: from eggs.gnu.org ([2001:4830:134:3::10]:51957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cWs6o-0003Ac-9p
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 17:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cWs6j-0001mS-Qp
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 17:01:34 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1cWs6j-0001mJ-M7
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 17:01:29 -0500
Received: by mail-pf0-x244.google.com with SMTP id 19so17160121pfo.3
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 14:01:29 -0800 (PST)
Date: Fri, 27 Jan 2017 07:01:26 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170126220126.GC21641@lianli.shorne-pla.net>
References: <CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
	<20170114080435.GF25986@lianli.shorne-pla.net>
	<20170120163918.GD7836@lianli.shorne-pla.net>
	<d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
	<20170124102625.GF7836@lianli.shorne-pla.net>
	<01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
	<20170125123430.GG7836@lianli.shorne-pla.net>
	<39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
	<20170126131229.GB16014@lianli.shorne-pla.net>
	<ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH] target-openrisc: Fix exception handling
 status registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org, openrisc@lists.librecores.org

On Thu, Jan 26, 2017 at 09:26:55AM -0800, Richard Henderson wrote:
> On 01/26/2017 05:12 AM, Stafford Horne wrote:
> > I just sent you a mail with a link to my kernel for download.
> > 
> > One thing I noticed is you passed '-append console=ttyS0' I think that
> > does nothing on openrisc since as far as I know openrisc only gets boot
> > params from the device tree file. I tried with and without it and got no
> > differences.
> 
> That was just reflex, wondering where the output went.
> 
> > Another thing, I am using a 'late' version of gcc built with musl cross [1]
> > , I dont think it would make a difference, but maybe?
> 
> I think that's likely the difference.  I can indeed boot your kernel.

OK, you can try to build with the musl-cross link I sent you.

  https://github.com/openrisc/musl-cross/tree/or1k

Also, for the linux kernel crosstool project I am working on getting
their toolchain updated to support l.swa/l.lwa.   I have posted some
binaries here (but no libc needed for the kernel):

  http://shorne.noip.me/crosstool/files/bin/x86_64/5.4.0/

The official ones are all here (below), but much too old to support openrisc
modern instructions.

  https://www.kernel.org/pub/tools/crosstool/

-Stafford
