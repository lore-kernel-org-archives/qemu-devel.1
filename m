Received: from eggs.gnu.org ([2001:4830:134:3::10]:36516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fZCPT-0006Fn-U7
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 05:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fZCPP-0007Mk-2E
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 05:43:15 -0400
Received: from chuckie.co.uk ([82.165.15.123]:60428
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fZCPO-0007Fk-QI
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 05:43:11 -0400
References: <20180630083357.23489-1-huth@tuxfamily.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <bb109e75-6c00-45b2-bb17-7d09ff3a8112@ilande.co.uk>
Date: Sat, 30 Jun 2018 10:42:56 +0100
MIME-Version: 1.0
In-Reply-To: <20180630083357.23489-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
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
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
Cc: Natalia Portillo <claunia@claunia.com>, Laurent Vivier <laurent@vivier.eu>, Bryce Lanham <blanham@gmail.com>

On 30/06/18 09:33, Thomas Huth wrote:

> During Google Summer of Code 2011, Bryce Lanham added the possibility to
> emulate the NeXTcube machine in QEMU, e.g. see this URL for some details:
> 
> https://wiki.qemu.org/Google_Summer_of_Code_2011#NeXT_machines_system_emulation
> 
> But since the machine requires a 68040 CPU and this was not included in
> upstream QEMU in 2011 yet, the patches have never been merged to upstream.
> Now in 2018, Laurent completed the full 680x0 support in upstream QEMU, so
> we could finally merge the NeXTcube support, too.
> 
> The QEMU interfaces changed a lot since 2011, so I had to modify the
> sources quite a bit, but with the attached patches, it is now possible
> to boot up to the firmware monitor again.
> 
> Note that boot device emulation is either still missing (network), or
> not working correctly yet (SCSI), so you can not boot any operating
> systems with this machine yet.
> 
> Please ignore the checkpatch warnings about C99 "//" comments. There
> are many of those in the sources, used to comment out alternative code
> lines. I did not want to remove those yet, since some of them could
> still be helpful while improving the machine emulation in the future.
> 
> Thomas Huth (4):
>    m68k: Add NeXTcube framebuffer device emulation
>    m68k: Add NeXTcube keyboard device
>    m68k: Add NeXTcube machine
>    m68k: Add an entry for the NeXTcube machine to the MAINTAINERS file
> 
>   MAINTAINERS                      |    7 +
>   default-configs/m68k-softmmu.mak |    4 +
>   hw/display/Makefile.objs         |    1 +
>   hw/display/next-fb.c             |  152 ++++
>   hw/m68k/Makefile.objs            |    5 +-
>   hw/m68k/next-cube.c              | 1103 ++++++++++++++++++++++++++++++
>   hw/m68k/next-kbd.c               |  289 ++++++++
>   include/hw/m68k/next-cube.h      |   49 ++
>   8 files changed, 1608 insertions(+), 2 deletions(-)
>   create mode 100644 hw/display/next-fb.c
>   create mode 100644 hw/m68k/next-cube.c
>   create mode 100644 hw/m68k/next-kbd.c
>   create mode 100644 include/hw/m68k/next-cube.h

Looks like the most interesting patch (patch 3) has been blocked 
somewhere, presumably because it is quite large.

Is there a git repository for this patch series somewhere for the curious?


ATB,

Mark.
