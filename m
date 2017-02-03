Received: from eggs.gnu.org ([2001:4830:134:3::10]:56014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cZfZg-00063Q-Ta
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cZfZd-0001dk-Jq
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:14:56 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1cZfZd-0001d4-Dj
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:14:53 -0500
Received: by mail-pf0-x241.google.com with SMTP id f144so1761870pfa.2
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 07:14:53 -0800 (PST)
Date: Sat, 4 Feb 2017 00:14:49 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170203151449.GC32144@lianli.shorne-pla.net>
References: <d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
	<20170124102625.GF7836@lianli.shorne-pla.net>
	<01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
	<20170125123430.GG7836@lianli.shorne-pla.net>
	<39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
	<20170126131229.GB16014@lianli.shorne-pla.net>
	<ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
	<20170201100423.GE21641@lianli.shorne-pla.net>
	<c840eff0-2be7-07d7-eae9-4cded569d146@twiddle.net>
	<20170202143455.GB32144@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170202143455.GB32144@lianli.shorne-pla.net>
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

On Thu, Feb 02, 2017 at 11:34:55PM +0900, Stafford Horne wrote:
> On Wed, Feb 01, 2017 at 10:15:54AM -0800, Richard Henderson wrote:
> > On 02/01/2017 02:04 AM, Stafford Horne wrote:
> > > On Thu, Jan 26, 2017 at 09:26:55AM -0800, Richard Henderson wrote:
> > >> On 01/26/2017 05:12 AM, Stafford Horne wrote:
> > >>> I just sent you a mail with a link to my kernel for download.
> > >>>
> > >>> One thing I noticed is you passed '-append console=ttyS0' I think that
> > >>> does nothing on openrisc since as far as I know openrisc only gets boot
> > >>> params from the device tree file. I tried with and without it and got no
> > >>> differences.
> > >>
> > >> That was just reflex, wondering where the output went.
> > >>
> > >>> Another thing, I am using a 'late' version of gcc built with musl cross [1]
> > >>> , I dont think it would make a difference, but maybe?
> > >>
> > >> I think that's likely the difference.  I can indeed boot your kernel.
> > > 
> > > Hi Richard,
> > > 
> > > For kernel builds I have created toolchain binaries here:
> > > 
> > >   http://shorne.noip.me/crosstool/files/bin/x86_64/5.4.0/
> > > 
> > > These should work.
> > > 
> > > If all is ok with the qemu patch I sent what is the next step to get them
> > > incorporated.  Do you need any help from me?
> > > 
> > > ... Actually I just checked your branch on github, it looks like you are
> > > doing a few updates.  Let me know if you want me to review anything.
> > 
> > Yes, I've been attempting to revive a patch set from 2013 that cleans up the
> > implementation, fixing a few other bugs in the process.
> > 
> > However, testing it properly has been tricky.  It appears as if I'm debugging
> > qemu and gcc simultaneously, while your gdb branch doesn't want to compile for
> > me.  So I've been limited to instruction traces from qemu, which is slow going.
> 
> What issue are you having compiling gdb?
> 
> I compile gdb with these flags.
> 
>   ../binutils-gdb/configure --target=or1k-musl-linux \
>     --prefix=$PREFIX \
>     --disable-itcl \
>     --disable-tk \
>     --disable-tcl \
>     --disable-winsup \
>     --disable-gdbtk \
>     --disable-libgui \
>     --disable-rda \
>     --disable-sid \
>     --with-sysroot \
>     --disable-newlib \
>     --disable-libgloss \
>     --disable-gas \
>     --disable-ld \
>     --disable-binutils \
>     --disable-gprof \
>     --with-system-zlib
> 
> Also, I uploaded my binaries just in case:
> 
>   http://shorne.noip.me/crosstool/files/bin/x86_64/5.4.0/
> 
> My host gcc is "6.3.1 20161221", I used musl-cross and my gdb branch
> 
>   https://github.com/openrisc/musl-cross.git or1k
> 
>   git@github.com:stffrdhrn/binutils-gdb.git or1k-upstream
> 
> > If you'd like to do your own testing on my tgt-or1k-2 branch, that would be
> > appreciated.
> 
> I will have a look tomorrow if I can.

I tried your tgt-or1k-2 branch with my latest kernel and have no issues.

What are you having issues with?  If you have some example code I could
have a look.

-Stafford
