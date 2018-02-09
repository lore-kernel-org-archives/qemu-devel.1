Received: from eggs.gnu.org ([2001:4830:134:3::10]:44653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1ekAjj-0004Ob-Bk
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1ekAji-0007Hh-F0
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:37:15 -0500
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAFEAcA_Z1JH6RXp19g2N3rV3TGOTa7LzFctEScrENBYB8eAf3w@mail.gmail.com>
References: <1518189456-2873-1-git-send-email-geert+renesas@glider.be>
	<1518189456-2873-4-git-send-email-geert+renesas@glider.be>
	<CAFEAcA_Z1JH6RXp19g2N3rV3TGOTa7LzFctEScrENBYB8eAf3w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 9 Feb 2018 16:37:10 +0100
Message-ID: <CAMuHMdX07rESnzAko-Tjp6xvdmPEKsX0djp3sP5HZqzv6jvWMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH/RFC 3/5] hw/arm/virt: Allow dynamic sysbus
 devices again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Alex Williamson <alex.williamson@redhat.com>, Auger Eric <eric.auger@redhat.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Alexander Graf <agraf@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Peter,

On Fri, Feb 9, 2018 at 4:27 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 9 February 2018 at 15:17, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> Allow the instantation of generic dynamic sysbus devices again, without
>> the need to create a new device-specific vfio type.
>>
>> This is a partial revert of commit  6f2062b9758ebc64 ("hw/arm/virt:
>> Allow only supported dynamic sysbus devices").
>>
>> Not-Yet-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  hw/arm/virt.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index b334c82edae9fb1f..fa83784fc08ed076 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1596,6 +1596,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>>      mc->max_cpus = 255;
>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_CALXEDA_XGMAC);
>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
>> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
>>      mc->block_default_type = IF_VIRTIO;
>>      mc->no_cdrom = 1;
>>      mc->pci_allow_0_address = true;
>
> This needs a lot of justification. Dynamic sysbus is not supposed
> to be for plugging any random sysbus device in, it's for vfio,
> which needs special casing anyway to work right. (Overall it's

Sure. Is there a way to limit this to vfio devices?

> a terrible hack -- in an ideal world all vfio would use pci
> or another probeable bus.)

What about vfio-platform, which is my use case?
On DT-based systems, platform devices are described very well in DT (even
better than what's provided by probing PCI IDs and BARs ;-)

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
