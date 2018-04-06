Received: from eggs.gnu.org ([2001:4830:134:3::10]:54850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1f4Xew-0000RC-J4
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 16:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1f4Xes-0000rb-Gp
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 16:08:30 -0400
Received: from phx2.ddci.com ([184.183.10.180]:58576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alarson@ddci.com>) id 1f4Xes-0000r1-8k
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 16:08:26 -0400
In-Reply-To: <CAFEAcA-S=GRXa26i2h-n=0FcWf4DGoyUdPA33P=hwamj3R3r7Q@mail.gmail.com>
References: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
	<OF03E560EC.20D03DEC-ON88258258.001D166A-86258258.001E50AC@ddci.com>
	<CAFEAcA-PXNDUfj7b6awd5KjtGuQd3F4Diy1tkEmYa9gBoxUjiA@mail.gmail.com>
	<OF28E56C94.CBE4DE9D-ON88258266.005BC5B3-86258266.005BFAF5@ddci.com>
	<CAFEAcA8KrrzDacQXsiW-UxKsy4sodCteUWgAHu6ZdyMG4u7riQ@mail.gmail.com>
	<OFDC2B6138.CF2B5F15-ON88258266.00751F63-86258266.0075810C@ddci.com>
	<CAFEAcA_KDJ05q+Lnf3nk+TmvAYPp3R6d9svf7JdvKZ6DiHMmHA@mail.gmail.com>
	<OF82B90B05.E59E0B03-ON88258267.0044BF04-86258267.004A0756@ddci.com>
	<CAFEAcA82xrYHYg3WvCpXwqm2ajv6SEUCL7cJsXFF+rccXxrUpg@mail.gmail.com>
	<CAFEAcA_LknKJeabd74Vp6=3J1cv7yevOYW6+-TvRE9FJtSdKMQ@mail.gmail.com>
	<OF4BD73ECC.1B5CB55D-ON88258267.005D53F
	<CAFEAcA-S=GRXa26i2h-n=0FcWf4DGoyUdPA33P=hwamj3R3r7Q@mail.gmail.com>
MIME-Version: 1.0
From: alarson@ddci.com
Message-ID: <OF3B2194F7.C2B2FA85-ON88258267.006BE407-86258267.006EA131@ddci.com>
Date: Fri, 6 Apr 2018 15:08:22 -0500
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

"Peter Maydell" <peter.maydell@linaro.org> wrote on 04/06/2018 12:21:37 
PM:

> On 6 April 2018 at 18:06,  <alarson@ddci.com> wrote:
> >
> > FWIW, the compile had some anomalous behavior:
> >
> > .../qemu-2.12.0-rc2/scripts/feature_to_c.sh: line 71: /usr/bin/sed:
> > Invalid argument
> >
> > line 71 is:
> >     arrayname=xml_feature_$(echo $input | sed 's,.*/,,; s/[-.]/_/g')
> >
> > Not sure what the problem is, but I always use "-e" before scripts.
> 
> That's a bit odd. (POSIX allows both "-e script" and just "script".)
> What version of sed is this, and what version of /bin/sh ?

I don't know what the issue is.  When I execute that command from my 
normal bash shell, it works just fine.  This is current Cygwin, so:

qemu$ sed --version
sed (GNU sed) 4.4
Packaged by Cygwin (4.4-1) ...
qemu$ /bin/sh --version
GNU bash, version 4.4.12(3)-release (x86_64-unknown-cygwin) ...

Perhaps I misread the sed manual, but I thought when you used a character 
other
than "/", you had to preface the character with a backslash, e.g., 

   sed 's\,.*,,;'

But, the above is all just speculation.  I don't know what the real 
problem is.

FWIW, I rebuilt twice more and the error didn't show up again, but I did
get some other spurious errors, one from GCC "invalid argument" and 
another:

/bin/sh: /usr/bin/x86_64-w64-mingw32-gcc: Device or resource busy
make: *** 
[/cygdrive/c/scm/Deos/products/qemu/branches/2.12/output/qemu-2.12.0-rc2/rules.mak:66: 
stubs/notify-event.o] Error 126

So perhaps it is just normal Cygwin "fork" errors, or my use of "make 
-j8".

I think you can ignore this.  Sorry for the spam.
