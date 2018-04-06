Received: from eggs.gnu.org ([2001:4830:134:3::10]:58969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1f4XlX-0002qA-5Q
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 16:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1f4XlT-0001G6-A9
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 16:15:19 -0400
Received: from phx2.ddci.com ([184.183.10.180]:58791)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alarson@ddci.com>) id 1f4XlT-0001Av-3O
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 16:15:15 -0400
In-Reply-To: <cd9353a7-44bc-c43a-65ec-770c9afb61d4@ilande.co.uk>
References: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
	<CAFEAcA9hNNT_ooL+YKsU-V8X_FKT9x-ca+ae03DtybV13s7GoA@mail.gmail.com>
	<OF03E560EC.20D03DEC-ON88258258.001D166A-86258258.001E50AC@ddci.com>
	<CAFEAcA-PXNDUfj7b6awd5KjtGuQd3F4Diy1tkEmYa9gBoxUjiA@mail.gmail.com>
	<OF28E56C94.CBE4DE9D-ON88258266.005BC5B3-86258266.005BFAF5@ddci.com>
	<CAFEAcA8KrrzDacQXsiW-UxKsy4sodCteUWgAHu6ZdyMG4u7riQ@mail.gmail.com>
	<OFDC2B6138.CF2B5F15-ON88258266.00751F63-86258266.0075810C@ddci.com>
	<CAFEAcA_KDJ05q+Lnf3nk+TmvAYPp3R6d9svf7JdvKZ6DiHMmHA@mail.gmail.com>
	<OF82B90B05.E59E0B03-ON88258267.0044BF04-86258267.004A0756@ddci.com>
	<cd9353a7-44bc-c43a-65ec-770c9afb61d4@ilande.co.uk>
MIME-Version: 1.0
From: alarson@ddci.com
Message-ID: <OFD76FAD1E.ECD66C3E-ON88258267.006F13E0-86258267.006F415A@ddci.com>
Date: Fri, 6 Apr 2018 15:15:12 -0500
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>

"Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk> wrote on 04/06/2018 
09:14:14 AM:

> From: "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
> To: alarson@ddci.com, "Peter Maydell" <peter.maydell@linaro.org>
> Cc: "Stefan Weil" <sw@weilnetz.de>, "QEMU Developers" 
<qemu-devel@nongnu.org>
> Date: 04/06/2018 09:14 AM
> Subject: Re: [Qemu-devel] -icount changes physical address assignments 
in QEMU 2.10/2.11
> 
> On 06/04/18 14:28, alarson@ddci.com wrote:
> 
> > I was not successful with the wiki instructions for "Native builds
> > with MSYS2":
> > 
> >    ./qemu-2.12.0-rc2/configure --python=/usr/bin/python2 \
> >        '--with-pkgversion=DDCI QEMU 2.12.0-rc2' \
> >        --prefix=/usr/local/qemu \
> >        '--target-list=aarch64-softmmu ppc64-softmmu x86_64-softmmu'
> >    make
> >    ...
> >    C:\msys2-x86_64_20161025\msys64\mingw64\bin\ar.exe: creating
> > libfdt/libfdt.a
> >    make[1]: *** No rule to make target 
...build/capstone/capstone.lib'.
> > Stop.
> >    make: *** [Makefile:503: subdir-capstone] Error 2
> 
> Ah I believe those instructions were mine from when I had temporary 
> access to a Windows VM for testing last year.
> 
> Since the instructions pre-dated the inclusion of capstone as a 
> dependency, is it as simple as adding:
> 
> git submodule update --init capstone
> 
> before running configure and make?

I didn't do the "git" parts.  I extracted from the source tarball.
Is the tarball source supposed to work, or is it necessary to always
use git?
