Received: from eggs.gnu.org ([2001:4830:134:3::10]:36900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dAW9w-0000xo-PM
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dAW9u-00055C-6B
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:40:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMbC67ppDLSXQegXaDZB6O=aSOSzdGtJsfP7RCGxy_rNg@mail.gmail.com>
References: <1494348286-10253-1-git-send-email-sundeep.lkml@gmail.com>
	<1494348286-10253-5-git-send-email-sundeep.lkml@gmail.com>
	<b913e666-8df3-714f-3ff9-e8f4ff9e7098@amsat.org>
	<CALHRZuptHwyzu0Y98VWnNd785W80AZ=+1cr_rfegvDo5amh+3g@mail.gmail.com>
	<7ee4c347-4502-863a-8c9f-faaf8fab17f3@amsat.org>
	<CAKmqyKMbC67ppDLSXQegXaDZB6O=aSOSzdGtJsfP7RCGxy_rNg@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Tue, 16 May 2017 12:10:36 +0530
Message-ID: <CALHRZup5FtnBHYinuXs=FpfwcLpxXtZ2gwNh2Mv2dA-DWReNGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-devel PATCH 4/5] msf2: Add Smartfusion2 SoC.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

Hi Philippe and Alistair,

On Mon, May 15, 2017 at 10:24 PM, Alistair Francis <alistair23@gmail.com>
wrote:

>  On Thu, May 11, 2017 at 10:02 PM, Philippe Mathieu-Daud=C3=A9
> <f4bug@amsat.org> wrote:
> > On 05/12/2017 12:17 AM, sundeep subbaraya wrote:
> >>
> >> Hi Philippe,
> >>
> >> On Wed, May 10, 2017 at 5:20 PM, Philippe Mathieu-Daud=C3=A9 <
> f4bug@amsat.org>
> >> wrote:
> >>
> >>> Hi Subbaraya,
> >>>
> >>>
> >>> On 05/09/2017 01:44 PM, Subbaraya Sundeep wrote:
> >>>
> >>>> Smartfusion2 SoC has hardened Microcontroller subsystem
> >>>> and flash based FPGA fabric. This patch adds support for
> >>>> Microcontroller subsystem in the SoC.
> >>>>
> >>>> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> >>>> ---
> >>>>  default-configs/arm-softmmu.mak |   1 +
> >>>>  hw/arm/Makefile.objs            |   2 +-
> >>>>  hw/arm/msf2-soc.c               | 188 +++++++++++++++++++++++++++++=
+
> >>>> ++++++++++
> >>>>  include/hw/arm/msf2-soc.h       |  60 +++++++++++++
> >>>>  4 files changed, 250 insertions(+), 1 deletion(-)
> >>>>  create mode 100644 hw/arm/msf2-soc.c
> >>>>  create mode 100644 include/hw/arm/msf2-soc.h
> >>>>
> >>>> diff --git a/default-configs/arm-softmmu.mak
> >>>> b/default-configs/arm-softmmu.mak
> >>>> index 78d7af0..7062512 100644
> >>>> --- a/default-configs/arm-softmmu.mak
> >>>> +++ b/default-configs/arm-softmmu.mak
> >>>> @@ -122,3 +122,4 @@ CONFIG_ACPI=3Dy
> >>>>  CONFIG_SMBIOS=3Dy
> >>>>  CONFIG_ASPEED_SOC=3Dy
> >>>>  CONFIG_GPIO_KEY=3Dy
> >>>> +CONFIG_MSF2=3Dy
> >>>> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> >>>> index 4c5c4ee..ae5e4a3 100644
> >>>> --- a/hw/arm/Makefile.objs
> >>>> +++ b/hw/arm/Makefile.objs
> >>>> @@ -1,7 +1,7 @@
> >>>>  obj-y +=3D boot.o collie.o exynos4_boards.o gumstix.o highbank.o
> >>>>  obj-$(CONFIG_DIGIC) +=3D digic_boards.o
> >>>>  obj-y +=3D integratorcp.o mainstone.o musicpal.o nseries.o
> >>>> -obj-y +=3D omap_sx1.o palm.o realview.o spitz.o stellaris.o
> >>>> +obj-y +=3D omap_sx1.o palm.o realview.o spitz.o stellaris.o msf2-so=
c.o
> >>>>
> >>>
> >>> Not a big deal, but since you added CONFIG_MSF2 why not using it here
> and
> >>> the Makefiles you touched (misc/ssi/timer)?
> >>>
> >>> obj-$(CONFIG_MSF2) +=3D msf2-soc.o
> >>>
> >>>   OK. Will change it.
> >>
> >>
> >>>
> >>>  obj-y +=3D tosa.o versatilepb.o vexpress.o virt.o xilinx_zynq.o z2.o
> >>>>
> >>>>  obj-$(CONFIG_ACPI) +=3D virt-acpi-build.o
> >>>>  obj-y +=3D netduino2.o
> >
> > [...]
> >>>>
> >>>> +    MemoryRegion *system_memory =3D get_system_memory();
> >>>> +    MemoryRegion *nvm =3D g_new(MemoryRegion, 1);
> >>>> +    MemoryRegion *nvm_alias =3D g_new(MemoryRegion, 1);
> >>>> +    MemoryRegion *sram =3D g_new(MemoryRegion, 1);
> >>>> +    MemoryRegion *ddr =3D g_new(MemoryRegion, 1);
> >>>> +
> >>>> +    memory_region_init_ram(nvm, NULL, "MSF2.envm", ENVM_SIZE,
> >>>> +                           &error_fatal);
> >>>>
> >>>
> >>> Maybe you can name it "eNVM" to match the documentation.
> >>>
> >>> Also envm_size should be a per-model property.
> >>>
> >>
> >> Ok.
> >>
> >>>
> >>> +    memory_region_init_alias(nvm_alias, NULL, "MSF2.flash.alias",
> >>>>
> >>>> +                             nvm, 0, ENVM_SIZE);
> >>>>
> >>>
> >>> Hmmm well this would be the "Cache Matrix Remap" which happens to be
> >>> mapped by default to eNVM on cold reset.
> >>> Naming it "MSF2.flash.alias" is pretty confusing.
> >>>
> >>
> >> Exactly it is Cache Matrix Remap.
> >> AFAIK currently we cannot remap memory during runtime in Qemu.
> >> So I handled default remap with alias.
> >> Please suggest the name. MSF2.eNVM.alias sounds fine?
> >
> >
> > Hmm Peter, Francis?
> >
> > Personally I prefer "bus_remap.alias" which is explicit.
> >
> > "eNVM.alias" is only true on Cold Reset.
>
> Yeah, I'm pretty sure you can't remap memory (unless that is some new
> feature I missed).
>
> Creating an alias seems like the right idea (you can even
> enable/disable it as needed to pretend we have dynamic remapping).
>
> As for names usually just copy the data sheet. MSF2.eNVM.alias sounds
> fine to me.
>

I will let it be MSF2.eNVM.alias and add comment about default remapping on
reset.

Thanks,
Sundeep

>
> Thanks,
>
> Alistair
>
> >
> >>>
> >>> +    vmstate_register_ram_global(nvm);
> >>>>
> >>>> +
> >>>> +    memory_region_set_readonly(nvm, true);
> >>>> +    memory_region_set_readonly(nvm_alias, true);
> >>>> +
> >>>> +    memory_region_add_subregion(system_memory, ENVM_BASE_ADDRESS,
> nvm);
> >>>> +    memory_region_add_subregion(system_memory, 0, nvm_alias);
> >>>> +
> >>>> +    memory_region_init_ram(ddr, NULL, "MSF2.ddr", DDR_SIZE,
> >>>> +                           &error_fatal);
> >>>>
> >>>
> >>> Wrong, there is no DDR on this SoC.
> >>>
> >> DDR controller is there in Smartfusion2 (different from Smartfusion). =
As
> >> you said below this
> >> should be in board file.
> >
> >
> > There IS a DDRC in this SoC, but here you are registering a DDR 'ram'
> memory
> > region, not a controller. This SoC can be used without any DDR, enough
> using
> > embedded eNVM and eSRAM.
> >
> > Now it happens your SoM board provides a DDR chip connected to this SoC=
.
> >
> >>>
> >>> +    vmstate_register_ram_global(ddr);
> >>>>
> >>>> +    memory_region_add_subregion(system_memory, DDR_BASE_ADDRESS,
> ddr);
> >>>> +
> >>>> +    memory_region_init_ram(sram, NULL, "MSF2.sram", SRAM_SIZE,
> >>>> +                           &error_fatal);
> >>>>
> >>>
> >>> I'd rather like to see it named "eSRAM" somehow, so there is no
> confusion
> >>> possible with external SRAM a SoM/board can map at 0x60000000.
> >>>
> >>> Same comment than envm_size, sram_size should be a per-model property=
.
> >>>
> >>> OK
> >>
> >>
> >>> +    vmstate_register_ram_global(sram);
> >>>>
> >>>> +    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS,
> >>>> sram);
> >>>> +
> >>>> +    armv7m =3D DEVICE(&s->armv7m);
> >>>> +    qdev_prop_set_uint32(armv7m, "num-irq", 96);
> >>>>
> >>>
> >>> Can you point me to your datasheet? I thought the SF2 had 240 IRQs.
> >>
> >>
> >>
> >> Please go to link:
> >> https://www.microsemi.com/document-portal/search_form
> >> and provide search keyword as "UG0331". You can the download the spec.
> >> It has 81 irqs I remember when I have given 81 qemu complained not
> >> multiple
> >> of 4.
> >> I checked again with 81 and it is fine. I will change it to 81.
> >
> >
> > Ok :)
> >
> >> +    qdev_prop_set_string(armv7m, "cpu-model", "cortex-m3");
> >>>>
> >>>> +    object_property_set_link(OBJECT(&s->armv7m),
> >>>> OBJECT(get_system_memory()),
> >>>> +                                     "memory", &error_abort);
> >
> > [...]
> >>>>
> >>>> +#define MSF2_NUM_SPIS         2
> >>>> +#define MSF2_NUM_UARTS        2
> >>>> +
> >>>> +#define ENVM_BASE_ADDRESS     0x60000000
> >>>> +#define ENVM_SIZE             (128 * 1024)
> >>>>
> >>>
> >>> The SoC design ENVM_SIZE is 1MB, 128K seems your particular model.
> >>>
> >>
> >>  M2S010 SoC device has 256K eNMV. My bad it should be 256 instead of
> 128.
> >>  The board I have contains M2S010 device in SOM.
> >>
> >
> > What I mean here is on the SF2 the eNVM "region size" (as seen by the A=
HB
> > Bus) is 1MB. Now your SoC M2S010 provides 256KB in this dedicated 1M
> region.
> >
> > I find your #define confusing, what about:
> >
> > #define ENVM_REGION_SIZE      (1 * M_BYTE)
> > #define M2S010_ENVM_SIZE      (256 * K_BYTE)
> >
> > (?_BYTE from "qemu/cutils.h")
> >
> > I wanted to clarify this because you named your functions as it can
> models
> > any SF2 but actually you restrict it to your M2S010.
> >
> > Maybe to start you can rename msf2_soc_x() -> m2s010_sf2_soc_x() then i=
f
> > needed this can be generalized to other SoCs from SF2 family?
> >
> >>> +
> >>>>
> >>>> +#define DDR_BASE_ADDRESS      0xA0000000
> >>>> +#define DDR_SIZE              (64 * 1024 * 1024)
> >>>>
> >>>
> >>> This belongs to the SoM.
> >>> Yes will change it.
> >>>
> >>>> +
> >>>> +#define SRAM_BASE_ADDRESS     0x20000000
> >>>> +#define SRAM_SIZE             (64 * 1024)
> >>>>
> >>>
> >>> Indeed this SoC is designed to have up to 64K of SRAM.
> >>> Luckily your model provides 64K.
> >>>
> >>
> >>
> >> Yes it is 64k :)
> >>
> >
> > Same here, what you have is:
> >
> > #define ESRAM_REGION_SIZE     (64 * K_BYTE)
> > #define M2S010_ESRAM_SIZE     (64 * K_BYTE)
> >
> > which happens to be equal but does not mean the same, do you see the
> > difference?
> >
> >
> >> +
> >>>>
> >>>> +typedef struct MSF2State {
> >>>> +    /*< private >*/
> >>>> +    SysBusDevice parent_obj;
> >>>> +    /*< public >*/
> >>>> +
> >>>> +    ARMv7MState armv7m;
> >>>> +
> >>>> +    MSF2SysregState sysreg;
> >>>> +    MSF2TimerState timer;
> >>>> +    MSF2SpiState spi[MSF2_NUM_SPIS];
> >>>> +} MSF2State;
> >>>> +
> >>>> +#endif
>
