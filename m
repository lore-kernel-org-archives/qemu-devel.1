Received: from eggs.gnu.org ([2001:4830:134:3::10]:50606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d5SPT-0004OI-SM
	for qemu-devel@nongnu.org; Tue, 02 May 2017 03:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d5SPS-0000gC-OE
	for qemu-devel@nongnu.org; Tue, 02 May 2017 03:39:47 -0400
References: <1493646214-3342-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170502015002.GD10741@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <8f067ee2-4e57-d514-7e6c-47dbd75a91dd@ilande.co.uk>
Date: Tue, 2 May 2017 08:38:56 +0100
MIME-Version: 1.0
In-Reply-To: <20170502015002.GD10741@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] Add qemu_vga.ndrv MacOS PPC VGA driver
 from QemuMacDrivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, benh@kernel.crashing.org

On 02/05/17 02:50, David Gibson wrote:

> On Mon, May 01, 2017 at 02:43:29PM +0100, Mark Cave-Ayland wrote:
>> Last year Ben posted an initial set of patches for OpenBIOS which provided a
>> MacOS PPC VGA driver enabling MacOS guests to control the colour depth and
>> resolution of the QEMU stdvga device. The QemuMacDrivers repository was set up on
>> qemu-project.org [1] but due to personal circumstances in the second half of last
>> year, I was unable to spend much time on it.
>>
>> Over the last few months I've reworked the OpenBIOS patches and applied all the
>> required dependencies upstream which makes it possible to enable the driver with
>> a fairly simple patch [2] to OpenBIOS's vga.fs (binary provided for testing, but not
>> to be included in the final merge).
>>
>> The main change I've made is that instead of serving the driver binary directly
>> through the VGA PCI BAR (with the relevant binary inlined within OpenBIOS), the
>> driver is now hosted by QEMU and is installed via the fw_cfg interface by the
>> OpenBIOS vga.fs driver during startup. Not only does this make it possible to
>> further develop the driver without also having to rebuild OpenBIOS every time but
>> it also leaves us with the ability to serve a proper IEEE-1275 FCode ROM via the
>> VGA PCI BAR later if needed.
>>
>> In addition to this I've added a new OpenBIOS NVRAM variable "vga-ndrv?" which
>> defaults to "true" but can be overidden via -prom-env to force disable the
>> driver if any incompatibilities are found. I've tested it locally against my
>> OS X 10.2 and MacOS 9.2.1 images and it seems to work there, but as I don't
>> have an exhaustive set of MacOS images available I'd be grateful for some more
>> testing.
>>
>> [1] https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg06159.html
>> [2] https://mail.coreboot.org/pipermail/openbios/2017-May/009909.html
>>
>> This patchset can also be found on my github repository at
>> https://github.com/mcayland/qemu/tree/ppc-vga-upstream.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Applied to ppc-for-2.10, thanks.

Hi David,

I just had a look at your ppc-for-2.10 branch and I see that you've also
included patch 5 which is a custom made OpenBIOS binary.

Can you drop patch 5 from the series and then I will do a manual pull
request to update OpenBIOS and activate the new functionality once this
is in?


Many thanks,

Mark.
