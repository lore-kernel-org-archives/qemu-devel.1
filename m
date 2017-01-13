Received: from eggs.gnu.org ([2001:4830:134:3::10]:58548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cS0tu-0008Ls-7A
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cS0ts-0001m0-Oc
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:24:10 -0500
References: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
	<CACXAS8AGTGJ-3yEzf9gzOmfRfppL2REmTyB2SAkb3Nd8eyVYig@mail.gmail.com>
	<733cba29-58b7-e43f-0d50-3774ee8bf3b2@reactos.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <8b07aa89-92fe-1f2d-d392-e1a7e63d75ca@ilande.co.uk>
Date: Fri, 13 Jan 2017 12:23:32 +0000
MIME-Version: 1.0
In-Reply-To: <733cba29-58b7-e43f-0d50-3774ee8bf3b2@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/6] ppc: add a IBM 40p machine (RS/6000,
 PReP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Giancarlo Teodori <gteodori@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 12/01/17 12:57, Hervé Poussineau wrote:

> Le 11/01/2017 à 17:58, Artyom Tarasenko a écrit :
>> Hi Hervé,
>>
>> nice work!
>>
>> On Thu, Dec 29, 2016 at 11:12 PM, Hervé Poussineau
>> <hpoussin@reactos.org> wrote:
>>> Hi,
>>>
>>> This patchset adds the emulation of the IBM RS/6000 7020 (40p). The
>>> real machine is
>>> able to run AIX (up to 4.3.3), Windows NT (up to 4.0 SP1), the beta
>>> of OS/2 PowerPC,
>>> Solaris, Linux, NetBSD/PReP ...
>>>
>>> I've tested current emulation with Open Hack'Ware, OpenBIOS and
>>> official firmware.
>>>
>>> Linux kernel starts, and freezes during boot (like with 'prep' machine).
> 
> I already saw a regression during 2.7.0 cycle with 603 CPU. However, I
> was unable to provide kernel source, so Benjamin was unable to find the
> problem.
> http://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03760.html
> 
>>
>> If prep can't do it anymore, it looks like a regression. I definitely
>> remember seen a sitting penguin and a login prompt ~ 2 years ago. At
>> least with OFW.
>>
>>> Windows NT starts up to the point where it wants to change endianness.
>>
>> I hit that with Solaris/PPC a few years back as you published your
>> previous attempt. Do you know what is missing? I guess CPU endianness
>> switch emulation is working because it is used in the newer POWER
>> CPUs. Is it just the systemIO which has to be improved, or is it more?
> 
> Yes, PReP System I/O has LE flag which is not implemented.
> You may be interested by
> ftp://ftp.software.ibm.com/rs6000/technology/spec/endian.ps
> which deals about endianness switching, with some code from Windows NT/PPC
> 
>>
>>> Other OSes have not been tested.
>>>
>>> This machine is a superset of the 'prep' one, because we know exactly
>>> what is/should
>>> emulated, and that operating system list running on it is quite wide.
>>> I hope that 'prep' machine can be deprecated soon and then later
>>> removed.
>>
>> Would be nice to keep 'prep' until the 40p can boot Linux and NetBSD
>> 6.1.3 (this version used to work with -M prep last time I checked).
> 
> Some Linux kernels seem to work, some other ones seem to not work (hang
> while booting)
> I've not searched why.
> 
> I tried NetBSD 6.1.3/PReP.
> cdroms/harddisks don't boot anymore with Open Hack'Ware since some
> changes in IDE core
> Kernel boots better with 40p than with prep
> 
> ====================================================
> prep:
> 
> Copyright (c) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
>     2006, 2007, 2008, 2009, 2010, 2011, 2012
>     The NetBSD Foundation, Inc.  All rights reserved.
> Copyright (c) 1982, 1986, 1989, 1991, 1993
>     The Regents of the University of California.  All rights reserved.
> 
> NetBSD 6.1.3 (INSTALL)
> Model: Qemu
> total memory = 128 MB
> avail memory = 119 MB
> panic: call to null-ptr from 0x0
> 
> The operating system has halted.
> Please press any key to reboot.
> 
> ====================================================
> 40p/Open Hack'Ware:
> 
> Copyright (c) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
>     2006, 2007, 2008, 2009, 2010, 2011, 2012
>     The NetBSD Foundation, Inc.  All rights reserved.
> Copyright (c) 1982, 1986, 1989, 1991, 1993
>     The Regents of the University of California.  All rights reserved.
> 
> NetBSD 6.1.3 (INSTALL)
> Model: Qemu
> total memory = 128 MB
> avail memory = 119 MB
> mainbus0 (root)
> cpu0 at mainbus0: 604 (Revision 1.3), ID 0 (primary)
> cpu0: HID0 0xc084<ICE,DCE,SGE,BHT>, powersave: 1
> cpu0: 0.00 MHz
> Couldn't find PNP data for bus 0 devfunc 0x0
> pnpbus0 at mainbus0
> pci0 at mainbus0 bus 0: indirect configuration space access
> pchb0 at pci0 dev 0 function 0
> pchb0: vendor 0x1057 product 0x4801 (rev. 0x00)
> siop0 at pci0 dev 1 function 0: Symbios Logic 53c810 (fast scsi)
> siop0: couldn't map interrupt
> vga0 at pci0 dev 2 function 0: vendor 0x1234 product 0x1111 (rev. 0x02)
> wsdisplay0 at vga0 (kbdmux ignored)
> drm at vga0 not configured
> pcn0 at pci0 dev 3 function 0: AMD PCnet-PCI Ethernet
> pcn0: Am79c970A PCnet-PCI II rev 0, Ethernet address 52:54:00:12:34:56
> pcn0: unable to map interrupt
> pcib0 at pci0 dev 11 function 0: vendor 0x8086 product 0x0484 (rev. 0x03)
> isa0 at pcib0
> com0 at isa0 port 0x3f8-0x3ff irq 4: ns16550a, working fifo
> com0: console
> com1 at isa0 port 0x2f8-0x2ff irq 3: ns16550a, working fifo
> pckbc0 at isa0 port 0x60-0x64
> pckbd0 at pckbc0 (kbd slot)
> pckbc0: using irq 1 for kbd slot
> wskbd0 at pckbd0 (mux ignored)
> vmmask 10000000 schedmask 10000000 highmask 70000000
> boot device: mainbus0
> root on md0a dumps on md0b
> root file system type: ffs
> WARNING: no TOD clock present
> WARNING: using filesystem time
> WARNING: CHECK AND RESET THE DATE!
> erase ^H, werase ^W, kill ^U, intr ^C, status ^T
> Terminal type? [vt100]
> 
> ====================================================
> 40p/official firmware with cdrom boot:
> 
> Copyright (c) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
>     2006, 2007, 2008, 2009, 2010, 2011, 2012
>     The NetBSD Foundation, Inc.  All rights reserved.
> Copyright (c) 1982, 1986, 1989, 1991, 1993
>     The Regents of the University of California.  All rights reserved.
> 
> NetBSD 6.1.3 (INSTALL)
> Model: IBM PPS Model 6015
> total memory = 128 MB
> avail memory = 119 MB
> trap: kernel read DSI trap @ 0x481b4cae by 0x2a4f50 (DSISR 0x40000000,
> err=14), lr 0x140e84
> panic: trap
> 
> The operating system has halted.
> Please press any key to reboot.
> ====================================================
> 
> OpenBIOS doesn't support PReP boot partitions (type 0x41) nor PReP
> kernels so this is a no-go yet.

Just out of interest, is it just the PReP boot partition support that is
missing from OpenBIOS? If so, that should be fairly easy to implement if
there's a spec lying around somewhere.

It would be great if we could finally remove OHW from QEMU :)


ATB,

Mark.
