Received: from eggs.gnu.org ([2001:4830:134:3::10]:60740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fZFiK-0004D9-7f
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 09:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fZFiF-0007mE-9T
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 09:14:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1fZFiF-0007lN-1r
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 09:14:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id u18-v6so4566186wmc.1
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 06:14:50 -0700 (PDT)
Date: Sat, 30 Jun 2018 15:14:44 +0200
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20180630151444.2f0b30cb@thl530.multi.box>
In-Reply-To: <bb109e75-6c00-45b2-bb17-7d09ff3a8112@ilande.co.uk>
References: <20180630083357.23489-1-huth@tuxfamily.org>
	<bb109e75-6c00-45b2-bb17-7d09ff3a8112@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/4] m68k: Add basic support for the
 NeXTcube machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Natalia Portillo <claunia@claunia.com>, Laurent Vivier <laurent@vivier.eu>, Bryce Lanham <blanham@gmail.com>

Am Sat, 30 Jun 2018 10:42:56 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> On 30/06/18 09:33, Thomas Huth wrote:
> 
> > During Google Summer of Code 2011, Bryce Lanham added the
> > possibility to emulate the NeXTcube machine in QEMU, e.g. see this
> > URL for some details:
> > 
> > https://wiki.qemu.org/Google_Summer_of_Code_2011#NeXT_machines_system_emulation
> > 
> > But since the machine requires a 68040 CPU and this was not
> > included in upstream QEMU in 2011 yet, the patches have never been
> > merged to upstream. Now in 2018, Laurent completed the full 680x0
> > support in upstream QEMU, so we could finally merge the NeXTcube
> > support, too.
> > 
> > The QEMU interfaces changed a lot since 2011, so I had to modify the
> > sources quite a bit, but with the attached patches, it is now
> > possible to boot up to the firmware monitor again.
> > 
> > Note that boot device emulation is either still missing (network),
> > or not working correctly yet (SCSI), so you can not boot any
> > operating systems with this machine yet.
> > 
> > Please ignore the checkpatch warnings about C99 "//" comments. There
> > are many of those in the sources, used to comment out alternative
> > code lines. I did not want to remove those yet, since some of them
> > could still be helpful while improving the machine emulation in the
> > future.
> > 
> > Thomas Huth (4):
> >    m68k: Add NeXTcube framebuffer device emulation
> >    m68k: Add NeXTcube keyboard device
> >    m68k: Add NeXTcube machine
> >    m68k: Add an entry for the NeXTcube machine to the MAINTAINERS
> > file
[...]
> Looks like the most interesting patch (patch 3) has been blocked 
> somewhere, presumably because it is quite large.

Weird... the mail was ca. 1200 lines ... that not small, but not so
big that I'd expect that it would get blocked somewhere. Let's wait
some more more hours, maybe the spam filter is just very slow today. If
it is then still not available on the list, I'll try to send it out
again.

> Is there a git repository for this patch series somewhere for the
> curious?

I just pushed it here:

https://gitlab.com/huth/qemu/tree/next-cube

 Thomas
