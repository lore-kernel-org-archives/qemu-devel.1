Received: from eggs.gnu.org ([2001:4830:134:3::10]:41606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gAtuz-0000TL-1C
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gAtux-00027S-5H
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:39:36 -0400
References: <1539271305-20671-1-git-send-email-thuth@redhat.com>
	<20181012093107.xikqvacxhqq7n6bv@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <405b06dd-adb8-2844-15e5-a3b03eb6e0c1@redhat.com>
Date: Fri, 12 Oct 2018 11:39:26 +0200
MIME-Version: 1.0
In-Reply-To: <20181012093107.xikqvacxhqq7n6bv@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/display/cirrus_vga: Add CONFIG option
 for "isa-cirrus-vga"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc <qemu-ppc@nongnu.org>, Richard Henderson <rth@twiddle.net>, BALATON Zoltan <balaton@eik.bme.hu>

On 2018-10-12 11:31, Gerd Hoffmann wrote:
> On Thu, Oct 11, 2018 at 05:21:45PM +0200, Thomas Huth wrote:
>> In downstream distros like RHEL we'd like to disable some of the "legacy"
>> devices of QEMU. The ISA version of the Cirrus VGA device is one of these
>> legacy devices. So let's make the build process a little bit more flexible
>> here by putting the Cirrus ISA code into a separate file and by providing
>> a proper CONFIG_VGA_CIRRUS_ISA switch which can be used to disable
>> this device.
> 
> We already have a CONFIG_VGA_ISA, how about adding it there instead?

Fine for me, too. I'll send a v2 with that. Note that this will disable
the "isa-cirrus-vga" device on ppc-softmmu and alpha-softmmu, since that
config switch is not use there (while CONFIG_VGA_CIRRUS currently
enables it there). But I assume that's ok since these platforms are
likely only interested in the PCI variant of the Cirrus VGA devices.

 Thomas
