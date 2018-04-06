Received: from eggs.gnu.org ([2001:4830:134:3::10]:32820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1f4RQ3-0004iA-W4
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1f4RQ0-0001qQ-5A
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:28:43 -0400
Received: from phx2.ddci.com ([184.183.10.180]:55356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alarson@ddci.com>) id 1f4RPz-0001ol-Ug
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:28:40 -0400
In-Reply-To: <CAFEAcA_KDJ05q+Lnf3nk+TmvAYPp3R6d9svf7JdvKZ6DiHMmHA@mail.gmail.com>
References: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
	<CAFEAcA9hNNT_ooL+YKsU-V8X_FKT9x-ca+ae03DtybV13s7GoA@mail.gmail.com>
	<OF03E560EC.20D03DEC-ON88258258.001D166A-86258258.001E50AC@ddci.com>
	<CAFEAcA-PXNDUfj7b6awd5KjtGuQd3F4Diy1tkEmYa9gBoxUjiA@mail.gmail.com>
	<OF28E56C94.CBE4DE9D-ON88258266.005BC5B3-86258266.005BFAF5@ddci.com>
	<CAFEAcA8KrrzDacQXsiW-UxKsy4sodCteUWgAHu6ZdyMG4u7riQ@mail.gmail.com>
	<OFDC2B6138.CF2B5F15-ON88258266.00751F63-86258266.0075810C@ddci.com>
	<CAFEAcA_KDJ05q+Lnf3nk+TmvAYPp3R6d9svf7JdvKZ6DiHMmHA@mail.gmail.com>
MIME-Version: 1.0
From: alarson@ddci.com
Message-ID: <OF82B90B05.E59E0B03-ON88258267.0044BF04-86258267.004A0756@ddci.com>
Date: Fri, 6 Apr 2018 08:28:35 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Qemu-devel] -icount changes physical address assignments in
 QEMU 2.10/2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>

"Peter Maydell" <peter.maydell@linaro.org> wrote on 04/06/2018 04:41:01 
AM:

> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: alarson@ddci.com
> Cc: "QEMU Developers" <qemu-devel@nongnu.org>, "Stefan Weil" 
<sw@weilnetz.de>
> Date: 04/06/2018 04:41 AM
> Subject: Re: [Qemu-devel] -icount changes physical address assignments 
in QEMU 2.10/2.11
> 
> On 5 April 2018 at 22:23,  <alarson@ddci.com> wrote:
> > "Peter Maydell" <peter.maydell@linaro.org> wrote on 04/05/2018 
12:28:01
> > PM:
> >
> >> From: "Peter Maydell" <peter.maydell@linaro.org>
> >> To: alarson@ddci.com
> >> Cc: "QEMU Developers" <qemu-devel@nongnu.org>
> >> Date: 04/05/2018 12:28 PM
> >> Subject: Re: [Qemu-devel] -icount changes physical address 
assignments
> > in QEMU 2.10/2.11
> >>
> >> On 5 April 2018 at 17:44,  <alarson@ddci.com> wrote:
> >> > "Peter Maydell" <peter.maydell@linaro.org> wrote on 04/05/2018
> > 09:05:53
> >> > AM:
> >> >> I've just tried your attached test image ...
> >> >
> >> > Curious.  I just downloaded qemu-2.12.0-rc2.tar.xz and built it 
using
> >> > Cygwin (a version from about a month ago) using mingw compilers
> >> > (mingw64-i686-gcc-g++ 6.4.0), and I still see the issue when the
> >> > resulting QEMU binary is run using -icount 2 against my test 
binary,
> >> > but not when run without -icount.  Here are the commands used:
> >> >
> >> > ../qemu-2.12.0-rc2/configure --python=/usr/bin/python \
> >> >    '--with-pkgversion=DDCI QEMU 2.12.0-rc2' \
> >> >    --prefix=/usr/local/qemu \
> >> >    --enable-sdl --with-sdlabi=2.0 \
> >> >    '--target-list=aarch64-softmmu ppc64-softmmu x86_64-softmmu' \
> >> >    --cross-prefix=i686-w64-mingw32-
> >> > /usr/bin/make -Otarget -j 8
> >> >
> >> > Any suggestions of things to try?
> >>
> >> Can you reproduce the problem on a Linux host? It would
> >> be interesting to identify if this is a Windows-host
> >> specific issue somehow.
> >
> > Linux "works".  I installed ubuntu 17.10 in a VM on my windows box,
> > recompiled QEMU 2.12.0-rc2 (same sources as above), using a configure
> > line the same as above except omitting --cross-prefix and 
--with-sdlabi.
> > Both with "-icount 2" and without show expected results.
> >
> > I installed a fresh Cygwin with just the packages suggested at
> > https://wiki.qemu.org/Hosts/W32#Native_builds_with_Mingw-w64 (plus
> > some obviously missing ones like python, make, etc.) and the problem
> > persists.  The updated configure line is:
> >
> > ../qemu-2.12.0-rc2/configure \
> >     '--with-pkgversion=DDCI QEMU 2.12.0-rc2' \
> >     --prefix=/usr/local/qemu \
> >     '--target-list=aarch64-softmmu ppc64-softmmu x86_64-softmmu' \
> >     --cross-prefix=i686-w64-mingw32-
> 
> Hmm, if it's Windows-only that's unfortunate, since I'm not really
> in a position to debug things that only happon on Windows hosts.
> 
> Stefan, does this sort of bug sound familiar at all?
> 
> Looking at your --cross-prefix you seem to be building 32-bit
> binaries; was your Ubuntu VM 32 bit or 64 bit? I'm wondering
> if this might turn out to be a 32-bit host issue rather than
> necessarily a Windows one.

1. Ubuntu 17.10 is 64-bit, compilation was native, run on the
   compilation host.  I.e., I did not cross compile to windows.
2. Cygwin was a 64-bit install, 64-bit windows 7 host.  I followed the
   instructions on the wiki.  I was curious about the "ming32" part
   myself, but cygwin package search doesn't indicate an obvious (to
   me) replacement.

I was not successful with the wiki instructions for "Native builds
with MSYS2":

  ./qemu-2.12.0-rc2/configure --python=/usr/bin/python2 \
      '--with-pkgversion=DDCI QEMU 2.12.0-rc2' \
      --prefix=/usr/local/qemu \
      '--target-list=aarch64-softmmu ppc64-softmmu x86_64-softmmu'
  make
  ...
  C:\msys2-x86_64_20161025\msys64\mingw64\bin\ar.exe: creating 
libfdt/libfdt.a
  make[1]: *** No rule to make target ...build/capstone/capstone.lib'. 
Stop.
  make: *** [Makefile:503: subdir-capstone] Error 2
