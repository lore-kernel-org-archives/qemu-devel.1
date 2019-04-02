Received: from eggs.gnu.org ([209.51.188.92]:38230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBEJC-00029k-5a
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBE4n-0006sP-Sj
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:43:23 -0400
Date: Tue, 2 Apr 2019 09:42:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190402094257.218aa0e5@redhat.com>
In-Reply-To: <459862f9-18f7-0a37-dfb9-b8ca9aa6a2d2@redhat.com>
References: <20190321104745.28068-1-shameerali.kolothum.thodi@huawei.com>
	<20190321104745.28068-8-shameerali.kolothum.thodi@huawei.com>
	<98c7f0fd-8446-8897-0808-e7615af29670@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA83933836A@lhreml524-mbs.china.huawei.com>
	<0dcd3f3c-15c4-318f-28bd-4b6706708c0d@redhat.com>
	<CAKv+Gu_-nRqeCT0s6ZwW+q3=sbGmtazFJ9R=19U5SJ=gSUmJLw@mail.gmail.com>
	<a2c37d40-e2ee-e7aa-3f34-ab39a9a6449d@redhat.com>
	<459862f9-18f7-0a37-dfb9-b8ca9aa6a2d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/10] hw/arm/virt: Introduce opt-in
 feature "fdt"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Linuxarm <linuxarm@huawei.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei (O)" <xuwei5@huawei.com>, "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>, Leif Lindholm <Leif.Lindholm@arm.com>

On Mon, 1 Apr 2019 15:07:05 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 03/29/19 14:56, Auger Eric wrote:
> > Hi Ard,
> > 
> > On 3/29/19 2:14 PM, Ard Biesheuvel wrote:  
> >> On Fri, 29 Mar 2019 at 14:12, Auger Eric <eric.auger@redhat.com> wrote:  
> >>>
> >>> Hi Shameer,
> >>>
> >>> On 3/29/19 10:59 AM, Shameerali Kolothum Thodi wrote:  
> >>>>
> >>>>  
> >>>>> -----Original Message-----
> >>>>> From: Auger Eric [mailto:eric.auger@redhat.com]
> >>>>> Sent: 29 March 2019 09:32
> >>>>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> >>>>> qemu-devel@nongnu.org; qemu-arm@nongnu.org; imammedo@redhat.com;
> >>>>> peter.maydell@linaro.org; shannon.zhaosl@gmail.com;
> >>>>> sameo@linux.intel.com; sebastien.boeuf@intel.com
> >>>>> Cc: Linuxarm <linuxarm@huawei.com>; xuwei (O) <xuwei5@huawei.com>;
> >>>>> Laszlo Ersek <lersek@redhat.com>; Ard Biesheuvel
> >>>>> <ard.biesheuvel@linaro.org>; Leif Lindholm <Leif.Lindholm@arm.com>
> >>>>> Subject: Re: [PATCH v3 07/10] hw/arm/virt: Introduce opt-in feature "fdt"
> >>>>>
> >>>>> Hi Shameer,
> >>>>>
> >>>>> [ + Laszlo, Ard, Leif ]
> >>>>>
> >>>>> On 3/21/19 11:47 AM, Shameer Kolothum wrote:  
> >>>>>> This is to disable/enable populating DT nodes in case
> >>>>>> any conflict with acpi tables. The default is "off".  
> >>>>> The name of the option sounds misleading to me. Also we don't really
> >>>>> know the scope of the disablement. At the moment this just aims to
> >>>>> prevent the hotpluggable dt nodes from being added if we boot in ACPI mode.
> >>>>>  
> >>>>>>
> >>>>>> This will be used in subsequent patch where cold plug
> >>>>>> device-memory support is added for DT boot.  
> >>>>> I am concerned about the fact that in dt mode, by default, you won't see
> >>>>> any PCDIMM nodes.  
> >>>>>>
> >>>>>> If DT memory node support is added for cold-plugged device
> >>>>>> memory, those memory will be visible to Guest kernel via
> >>>>>> UEFI GetMemoryMap() and gets treated as early boot memory.  
> >>>>> Don't we have an issue in UEFI then. Normally the SRAT indicates whether
> >>>>> the slots are hotpluggable or not. Shouldn't the UEFI code look at this
> >>>>> info.  
> >>>>
> >>>> Sorry I missed this part. Yes, that will be a more cleaner solution.
> >>>>
> >>>> Also, to be more clear on what happens,
> >>>>
> >>>> Guest ACPI boot with "fdt=on" ,
> >>>>
> >>>> From kernel log,
> >>>>
> >>>> [    0.000000] Early memory node ranges
> >>>> [    0.000000]   node   0: [mem 0x0000000040000000-0x00000000bbf5ffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bbf60000-0x00000000bbffffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bc000000-0x00000000bc02ffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bc030000-0x00000000bc36ffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bc370000-0x00000000bf64ffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bf650000-0x00000000bf6dffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bf6e0000-0x00000000bf6effff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bf6f0000-0x00000000bf80ffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bf810000-0x00000000bfffffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000c0000000-0x00000000ffffffff]  --> This is the hotpluggable memory node from DT.
> >>>> [    0.000000] Zeroed struct page in unavailable ranges: 1040 pages
> >>>> [    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000ffffffff]
> >>>>
> >>>>
> >>>> Guest ACPI boot with "fdt=off" ,
> >>>>
> >>>> [    0.000000] Movable zone start for each node
> >>>> [    0.000000] Early memory node ranges
> >>>> [    0.000000]   node   0: [mem 0x0000000040000000-0x00000000bbf5ffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bbf60000-0x00000000bbffffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bc000000-0x00000000bc02ffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bc030000-0x00000000bc36ffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bc370000-0x00000000bf64ffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bf650000-0x00000000bf6dffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bf6e0000-0x00000000bf6effff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bf6f0000-0x00000000bf80ffff]
> >>>> [    0.000000]   node   0: [mem 0x00000000bf810000-0x00000000bfffffff]
> >>>> [    0.000000] Zeroed struct page in unavailable ranges: 1040 pages
> >>>> [    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff
> >>>>
> >>>> The hotpluggable memory node is absent from early memory nodes here.  
> >>>
> >>> OK thank you for the example illustrating the concern.  
> >>>>
> >>>> As you said, it could be possible to detect this node using SRAT in UEFI.  
> >>>
> >>> Let's wait for EDK2 experts on this.
> >>>  
> >>
> >> Happy to chime in, but I need a bit more context here.
> >>
> >> What is the problem, how does this path try to solve it, and why is
> >> that a bad idea?
> >>  
> > Sure, sorry.
> > 
> > This series:
> > - [PATCH v3 00/10] ARM virt: ACPI memory hotplug support,
> > https://patchwork.kernel.org/cover/10863301/
> > 
> > aims to introduce PCDIMM support in qemu. In ACPI mode, it builds the
> > SRAT and DSDT parts and relies on GED to trigger the hotplug.
> > 
> > We noticed that if we build the hotpluggable memory dt nodes on top of
> > the above ACPI tables, the DIMM slots are interpreted as not
> > hotpluggable memory slots (at least we think so).
> > 
> > We think the EDK2 GetMemoryMap() uses the dt node info and ignores the
> > fact that those slots are exposed as hotpluggable in the SRAT for example.
> > 
> > So in this series, we are forced to not generate the hotpluggable memory
> > dt nodes if we want the DIMM slots to be effectively recognized as
> > hotpluggable.
> > 
> > Could you confirm we have a correct understanding of the EDK2 behaviour
> > and if so, would there be any solution for EDK2 to absorb both the DT
> > nodes and the relevant SRAT/DSDT tables and make the slots hotpluggable.
> > 
> > At qemu level, detecting we are booting in ACPI mode and purposely
> > removing the above mentioned DT nodes does not look straightforward.  
> 
> The firmware is not enlightened about the ACPI content that comes from
> QEMU / fw_cfg. That ACPI content is *blindly* processed by the firmware,
> as instructed through the ACPI linker/loader script, in order to install
> the ACPI content for the OS. No actual information is consumed by the
> firmware from the ACPI payload -- and that's a feature.
> 
> The firmware does consume DT:
> 
> - If you start QEMU *with* "-no-acpi", then the DT is both consumed by
> the firmware (for its own information needs), and passed on to the OS.
> 
> - If you start QEMU *without* "-no-acpi" (the default), then the DT is
> consumed only by the firmware (for its own information needs), and the
> DT is hidden from the OS. The OS gets only the ACPI content
> (processed/prepared as described above).
> 
> 
> In the firmware, the "ArmVirtPkg/HighMemDxe" driver iterates over the
> base/size pairs in all the memory nodes in the DT. For each such base
> address that is currently tracked as "nonexistent" in the GCD memory
> space map, the driver currently adds the base/size range as "system
> memory". This in turn is reflected by the UEFI memmap that the OS gets
> to see as "conventional memory".
> 
> If you need some memory ranges to show up as "special" in the UEFI
> memmap, then you need to distinguish them somehow from the "regular"
> memory areas, in the DT. And then extend "ArmVirtPkg/HighMemDxe" in the
> firmware, so that it act upon the discriminator that you set in the DT.
> 
> 
> Now... from a brief look at the Platform Init and UEFI specs, my
> impression is that the hotpluggable (but presently not plugged) DIMM
> ranges should simply be *absent* from the UEFI memmap; is that correct?
> (I didn't check the ACPI spec, maybe it specifies the expected behavior
> in full.) If my impression is correct, then two options (alternatives)
> exist:
> 
> (1) Hide the affected memory nodes -- or at least the affected base/size
> pairs -- from the DT, in case you boot without "-no-acpi" but with an
> external firmware loaded. Then the firmware will not expose those ranges
> as "conventional memory" in the UEFI memmap. This approach requires no
> changes to edk2.
> 
> This option is precisely what Eric described up-thread, at
> <http://mid.mail-archive.com/3f0a5793-dd35-a497-2248-8eb0cd3c3a16@redhat.com>:
> 
> > in machvirt_init, there is firmware_loaded that tells you whether you
> > have a FW image. If this one is not set, you can induce dt. But if
> > there is a FW it can be either DT or ACPI booted. You also have the
> > acpi_enabled knob.  
> 
> (The "-no-acpi" cmdline option clears the "acpi_enabled" variable in
> "vl.c").
> 
> So, the condition for hiding the hotpluggable memory nodes in question
> from the DT is:
> 
>   (aarch64 && firmware_loaded && acpi_enabled)
I'd go with this one, though I have a question for firmware side.
Let's assume we would want in future to expose hotpluggable & present
memory via GetMemoryMap() (like bare-metal does) (guest OS theoretically
can avoid using it for Normal zone based on hint from SRAT table early
at boot), but what about firmware can it inspect SRAT table and not use
hotpluggable ranges for its own use (or at least do not canibalize
them permanently)?
 

> 
> (2) Invent and set an "ignore me, firmware" property for the
> hotpluggable memory nodes in the DT, and update the firmware to honor
> that property.
> 
> Thanks
> Laszlo
