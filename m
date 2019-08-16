Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5FDC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 06:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB8D2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 06:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB8D2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyVkd-0000vc-2j
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 02:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1hyVjK-0008BT-DL
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 02:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hyVjH-0002Ib-7q
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 02:28:54 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.74]:5202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hyVjG-0002HU-S8; Fri, 16 Aug 2019 02:28:51 -0400
Received: from tpw09926dag18g.domain1.systemhost.net (10.9.212.34) by
 BWP09926079.bt.com (10.36.82.110) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Fri, 16
 Aug 2019 07:28:25 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18g.domain1.systemhost.net (10.9.212.34) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 16 Aug 2019 07:28:47 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 16 Aug
 2019 07:28:47 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v7 00/42] Invert Endian bit in SPARCv9 MMU
 TTE
Thread-Index: AQHVU/vc8DdfhK3ulkmWv148s0Uozg==
Date: Fri, 16 Aug 2019 06:28:47 +0000
Message-ID: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.74
Subject: [Qemu-devel] [PATCH v7 00/42] Invert Endian bit in SPARCv9 MMU TTE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: frederic.konrad@adacore.com, berto@igalia.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, lersek@redhat.com,
 jasowang@redhat.com, jiri@resnulli.us, ehabkost@redhat.com,
 b.galvani@gmail.com, eric.auger@redhat.com, alex.williamson@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 andrew@aj.id.au, claudio.fontana@suse.com, crwulff@gmail.com,
 laurent@vivier.eu, sundeep.lkml@gmail.com, michael@walle.cc,
 qemu-ppc@nongnu.org, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 fam@euphon.net, peter.maydell@linaro.org, david@redhat.com, palmer@sifive.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com, hare@suse.com,
 sstabellini@kernel.org, andrew.smirnov@gmail.com, deller@gmx.de,
 magnus.damm@gmail.com, atar4qemu@gmail.com, minyard@acm.org, sw@weilnetz.de,
 yuval.shaia@oracle.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, shorne@gmail.com, qemu-riscv@nongnu.org,
 i.mitsyanko@gmail.com, cohuck@redhat.com, philmd@redhat.com,
 amarkovic@wavecomp.com, peter.chubb@nicta.com.au, aurelien@aurel32.net,
 pburton@wavecomp.com, sagark@eecs.berkeley.edu, green@moxielogic.com,
 kraxel@redhat.com, edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn,
 robh@kernel.org, borntraeger@de.ibm.com, joel@jms.id.au,
 antonynpavlov@gmail.com, chouteau@adacore.com, Andrew.Baumann@microsoft.com,
 mreitz@redhat.com, walling@linux.ibm.com, dmitry.fleytman@gmail.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, jslaby@suse.cz, marex@denx.de,
 proljc@gmail.com, marcandre.lureau@redhat.com, alistair@alistair23.me,
 paul.durrant@citrix.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, huth@tuxfamily.org, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset implements the IE (Invert Endian) bit in SPARCv9 MMU TTE.=0A=
=0A=
It is an attempt of the instructions outlined by Richard Henderson to Mark=
=0A=
Cave-Ayland.=0A=
=0A=
Tested with OpenBSD on sun4u. Solaris 10 is my actual goal, but unfortunate=
ly a=0A=
separate keyboard issue remains in the way.=0A=
=0A=
On 01/11/17 19:15, Mark Cave-Ayland wrote:=0A=
=0A=
>On 15/08/17 19:10, Richard Henderson wrote:=0A=
>=0A=
>> [CC Peter re MemTxAttrs below]=0A=
>>=0A=
>> On 08/15/2017 09:38 AM, Mark Cave-Ayland wrote:=0A=
>>> Working through an incorrect endian issue on qemu-system-sparc64, it ha=
s=0A=
>>> become apparent that at least one OS makes use of the IE (Invert Endian=
)=0A=
>>> bit in the SPARCv9 MMU TTE to map PCI memory space without the=0A=
>>> programmer having to manually endian-swap accesses.=0A=
>>>=0A=
>>> In other words, to quote the UltraSPARC specification: "if this bit is=
=0A=
>>> set, accesses to the associated page are processed with inverse=0A=
>>> endianness from what is specified by the instruction (big-for-little an=
d=0A=
>>> little-for-big)".=0A=
=0A=
A good explanation by Mark why the IE bit is required.=0A=
=0A=
>>>=0A=
>>> Looking through various bits of code, I'm trying to get a feel for the=
=0A=
>>> best way to implement this in an efficient manner. From what I can see=
=0A=
>>> this could be solved using an additional MMU index, however I'm not=0A=
>>> overly familiar with the memory and softmmu subsystems.=0A=
>>=0A=
>> No, it can't be solved with an MMU index.=0A=
>>=0A=
>>> Can anyone point me in the right direction as to what would be the best=
=0A=
>>> way to implement this feature within QEMU?=0A=
>>=0A=
>> It's definitely tricky.=0A=
>>=0A=
>> We definitely need some TLB_FLAGS_MASK bit set so that we're forced thro=
ugh=0A=
>> the=0A=
>> memory slow path.  There is no other way to bypass the endianness that w=
e've=0A=
>> already encoded from the target instruction.=0A=
>>=0A=
>> Given the tlb_set_page_with_attrs interface, I would think that we need =
a new=0A=
>> bit in MemTxAttrs, so that the target/sparc tlb_fill (and subroutines) c=
an=0A=
>> pass=0A=
>> along the TTE bit for the given page.=0A=
>>=0A=
>> We have an existing problem in softmmu_template.h,=0A=
>>=0A=
>>     /* ??? Note that the io helpers always read data in the target=0A=
>>        byte ordering.  We should push the LE/BE request down into io.  *=
/=0A=
>>     res =3D glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr);=
=0A=
>>     res =3D TGT_BE(res);=0A=
>>=0A=
>> We do not want to add a third(!) byte swap along the i/o path.  We need =
to=0A=
>> collapse the two that we have already before considering this one.=0A=
>>=0A=
>> This probably takes the form of:=0A=
>>=0A=
>> (1) Replacing the "int size" argument with "TCGMemOp memop" for=0A=
>>       a) io_{read,write}x in accel/tcg/cputlb.c,=0A=
>>       b) memory_region_dispatch_{read,write} in memory.c,=0A=
>>       c) adjust_endianness in memory.c.=0A=
>>     This carries size+sign+endianness down to the next level.=0A=
>>=0A=
>> (2) In memory.c, adjust_endianness,=0A=
>>=0A=
>>      if (memory_region_wrong_endianness(mr)) {=0A=
>> -        switch (size) {=0A=
>> +        memop ^=3D MO_BSWAP;=0A=
>> +    }=0A=
>> +    if (memop & MO_BSWAP) {=0A=
>>=0A=
>>     For extra credit, re-arrange memory_region_wrong_endianness=0A=
>>     to something more explicit -- "wrong" isn't helpful.=0A=
>=0A=
>Finally I've had a bit of spare time to experiment with this approach,=0A=
>and from what I can see there are currently 2 issues:=0A=
>=0A=
>=0A=
>1) Using TCGMemOp in memory.c means it is no longer accelerator agnostic=
=0A=
>=0A=
>For the moment I've defined a separate MemOp in memory.h and provided a=0A=
>mapping function in io_{read,write}x to map from TCGMemOp to MemOp and=0A=
>then pass that into memory_region_dispatch_{read,write}.=0A=
>=0A=
>Other than not referencing TCGMemOp in the memory API, another reason=0A=
>for doing this was that I wasn't convinced that all the MO_ attributes=0A=
>were valid outside of TCG. I do, of course, strongly defer to other=0A=
>people's knowledge in this area though.=0A=
>=0A=
>=0A=
>2) The above changes to adjust_endianness() fail when=0A=
>memory_region_dispatch_{read,write} are called recursively=0A=
>=0A=
>Whilst booting qemu-system-sparc64 I see that=0A=
>memory_region_dispatch_{read,write} get called recursively - once via=0A=
>io_{read,write}x and then again via flatview_read_continue() in exec.c.=0A=
>=0A=
>The net effect of this is that we perform the bswap correctly at the=0A=
>tail of the recursion, but then as we travel back up the stack we hit=0A=
>memory_region_dispatch_{read,write} once again causing a second bswap=0A=
>which means the value is returned with the incorrect endian again.=0A=
>=0A=
>=0A=
>My understanding from your softmmu_template.h comment above is that the=0A=
>memory API should do the endian swapping internally allowing the removal=
=0A=
>of the final TGT_BE/TGT_LE applied to the result, or did I get this wrong?=
=0A=
>=0A=
>> (3) In tlb_set_page_with_attrs, notice attrs.byte_swap and set=0A=
>>     a new TLB_FORCE_SLOW bit within TLB_FLAGS_MASK.=0A=
>>=0A=
>> (4) In io_{read,write}x, if iotlbentry->attrs.byte_swap is set,=0A=
>>     then memop ^=3D MO_BSWAP.=0A=
=0A=
Thanks all for the feedback. Learnt a lot =3D)=0A=
=0A=
v2:=0A=
- Moved size+sign+endianness attributes from TCGMemOp into MemOp.=0A=
  In v1 TCGMemOp was re-purposed entirely into MemOp.=0A=
- Replaced MemOp MO_{8|16|32|64} with TCGMemOp MO_{UB|UW|UL|UQ} alias.=0A=
  This is to avoid warnings on comparing and coercing different enums.=0A=
- Renamed get_memop to get_tcgmemop for clarity.=0A=
- MEMOP is now SIZE_MEMOP, which is just ctzl(size).=0A=
- Split patch 3/4 so one memory_region_dispatch_{read|write} interface=0A=
  is converted per patch.=0A=
- Do not reuse TLB_RECHECK, use new TLB_FORCE_SLOW instead.=0A=
- Split patch 4/4 so adding the MemTxAddrs parameters and converting=0A=
  tlb_set_page() to tlb_set_page_with_attrs() is separate from usage.=0A=
- CC'd maintainers.=0A=
=0A=
v3:=0A=
- Like v1, the entire TCGMemOp enum is now MemOp.=0A=
- MemOp target dependant attributes are conditional upon NEED_CPU_H=0A=
=0A=
v4:=0A=
- Added Paolo Bonzini as include/exec/memop.h maintainer=0A=
=0A=
v5:=0A=
- Improved commit messages to clarify how interface to access=0A=
  MemoryRegion will be converted from "unsigned size" to "MemOp op".=0A=
- Moved cpu_transaction_failed() MemOp conversion from patch #11 to #9=0A=
  to make review easier.=0A=
=0A=
v6:=0A=
- Improved commit messages.=0A=
- Include as patch #1 an earlier posted TARGET_ALIGNED_ONLY configure patch=
.=0A=
- Typeless macro SIZE_MEMOP is now inline.=0A=
- size_memop now includes CONFIG_DEBUG_TCG code.=0A=
- size_memop now also encodes endianness via MO_TE.=0A=
- Reverted size_memop operand "unsigned long" back to "unsigned".=0A=
- Second pass of size_memop to replace no-op place holder with MO_{8|16|32|=
64}.=0A=
- Delay memory_region_dispatch_{read,write} operand conversion until no-op=
=0A=
  size_memop is implemented so we have proper typing at all points in betwe=
en.=0A=
- Fixed bug where not all memory_region_dispatch_{read,write} callers where=
=0A=
  encoding endianness into the MemOp operand, see patch #20.=0A=
- Fixed bug where not all memory_region_dispatch_{read,write} callers were=
=0A=
  collapsing their byte swap into adjust_endianness, see patch #20 and #22.=
=0A=
- Split byte swap collapsing patch (v5 #11) into #21 and #22.=0A=
- Corrected non-common *-common-obj to *-obj.=0A=
- Replaced enum device_endian with MemOp to simplify endianness checks. A=
=0A=
  straight forward sed but touched *alot* of files. See patch #16 and #17.=
=0A=
- Deleted enum device_endian.=0A=
- Deleted DEVICE_HOST_ENDIAN definition.=0A=
- Generalized the description of introduced MemTxAttrs attribute byte_swap.=
=0A=
=0A=
v7:=0A=
- Fixed bug where size_memop was implicitly encoding MO_TE. Endianness,=0A=
  {MO_TE|MO_BE|MO_LE}, is now explicitly encoded by MemoryRegion accessors.=
=0A=
- While a no-op, size_memop return type remains an unsigned.=0A=
- Use '=3D 0' short hand instead of macro logic to declare host endianness.=
=0A=
- With a new set of constant arguments, sanity checked the compiler is stil=
l=0A=
  folding away tests in cputlb.c=0A=
- Re-declared many native endian devices as little or big endian. This is w=
hy=0A=
  v7 has +16 patches.=0A=
=0A=
Tony Nguyen (42):=0A=
  configure: Define TARGET_ALIGNED_ONLY in configure=0A=
  tcg: TCGMemOp is now accelerator independent MemOp=0A=
  memory: Introduce size_memop=0A=
  target/mips: Access MemoryRegion with MemOp=0A=
  hw/s390x: Access MemoryRegion with MemOp=0A=
  hw/intc/armv7m_nic: Access MemoryRegion with MemOp=0A=
  hw/virtio: Access MemoryRegion with MemOp=0A=
  hw/vfio: Access MemoryRegion with MemOp=0A=
  exec: Access MemoryRegion with MemOp=0A=
  cputlb: Access MemoryRegion with MemOp=0A=
  memory: Access MemoryRegion with MemOp=0A=
  hw/s390x: Hard code size with MO_{8|16|32|64}=0A=
  target/mips: Hard code size with MO_{8|16|32|64}=0A=
  exec: Hard code size with MO_{8|16|32|64}=0A=
  hw/audio: Declare device little or big endian=0A=
  hw/block: Declare device little or big endian=0A=
  hw/char: Declare device little or big endian=0A=
  hw/display: Declare device little or big endian=0A=
  hw/dma: Declare device little or big endian=0A=
  hw/gpio: Declare device little or big endian=0A=
  hw/i2c: Declare device little or big endian=0A=
  hw/input: Declare device little or big endian=0A=
  hw/intc: Declare device little or big endian=0A=
  hw/isa: Declare device little or big endian=0A=
  hw/misc: Declare device little or big endian=0A=
  hw/net: Declare device little or big endian=0A=
  hw/pci-host: Declare device little or big endian=0A=
  hw/sd: Declare device little or big endian=0A=
  hw/ssi: Declare device little or big endian=0A=
  hw/timer: Declare device little or big endian=0A=
  build: Correct non-common common-obj-* to obj-*=0A=
  exec: Map device_endian onto MemOp=0A=
  exec: Replace device_endian with MemOp=0A=
  exec: Delete device_endian=0A=
  exec: Delete DEVICE_HOST_ENDIAN=0A=
  memory: Access MemoryRegion with endianness=0A=
  cputlb: Replace size and endian operands for MemOp=0A=
  memory: Single byte swap along the I/O path=0A=
  cpu: TLB_FLAGS_MASK bit to force memory slow path=0A=
  cputlb: Byte swap memory transaction attribute=0A=
  target/sparc: Add TLB entry with attributes=0A=
  target/sparc: sun4u Invert Endian TTE bit=0A=
=0A=
 MAINTAINERS                             |   1 +=0A=
 accel/tcg/cputlb.c                      | 197 ++++++++++++++--------------=
----=0A=
 configure                               |  10 +-=0A=
 exec.c                                  |  15 ++-=0A=
 hw/acpi/core.c                          |   6 +-=0A=
 hw/acpi/cpu.c                           |   2 +-=0A=
 hw/acpi/cpu_hotplug.c                   |   2 +-=0A=
 hw/acpi/ich9.c                          |   4 +-=0A=
 hw/acpi/memory_hotplug.c                |   2 +-=0A=
 hw/acpi/nvdimm.c                        |   2 +-=0A=
 hw/acpi/pcihp.c                         |   2 +-=0A=
 hw/acpi/piix4.c                         |   2 +-=0A=
 hw/acpi/tco.c                           |   2 +-=0A=
 hw/adc/stm32f2xx_adc.c                  |   2 +-=0A=
 hw/alpha/pci.c                          |   6 +-=0A=
 hw/alpha/typhoon.c                      |   6 +-=0A=
 hw/arm/allwinner-a10.c                  |   2 +-=0A=
 hw/arm/armv7m.c                         |   2 +-=0A=
 hw/arm/aspeed.c                         |   2 +-=0A=
 hw/arm/aspeed_soc.c                     |   2 +-=0A=
 hw/arm/exynos4210.c                     |   2 +-=0A=
 hw/arm/highbank.c                       |   2 +-=0A=
 hw/arm/integratorcp.c                   |   6 +-=0A=
 hw/arm/kzm.c                            |   2 +-=0A=
 hw/arm/msf2-soc.c                       |   2 +-=0A=
 hw/arm/musicpal.c                       |  20 ++--=0A=
 hw/arm/omap1.c                          |  40 +++----=0A=
 hw/arm/omap2.c                          |  10 +-=0A=
 hw/arm/omap_sx1.c                       |   2 +-=0A=
 hw/arm/palm.c                           |   2 +-=0A=
 hw/arm/pxa2xx.c                         |  20 ++--=0A=
 hw/arm/pxa2xx_gpio.c                    |   2 +-=0A=
 hw/arm/pxa2xx_pic.c                     |   2 +-=0A=
 hw/arm/smmuv3.c                         |   2 +-=0A=
 hw/arm/spitz.c                          |   2 +-=0A=
 hw/arm/stellaris.c                      |   8 +-=0A=
 hw/arm/strongarm.c                      |  12 +-=0A=
 hw/arm/versatilepb.c                    |   2 +-=0A=
 hw/audio/Makefile.objs                  |   3 +-=0A=
 hw/audio/ac97.c                         |   4 +-=0A=
 hw/audio/cs4231.c                       |   2 +-=0A=
 hw/audio/es1370.c                       |   2 +-=0A=
 hw/audio/intel-hda.c                    |   2 +-=0A=
 hw/audio/marvell_88w8618.c              |   2 +-=0A=
 hw/audio/milkymist-ac97.c               |   2 +-=0A=
 hw/audio/pl041.c                        |   2 +-=0A=
 hw/block/Makefile.objs                  |   6 +-=0A=
 hw/block/fdc.c                          |   4 +-=0A=
 hw/block/nvme.c                         |   4 +-=0A=
 hw/block/onenand.c                      |   2 +-=0A=
 hw/block/pflash_cfi01.c                 |   2 +-=0A=
 hw/block/pflash_cfi02.c                 |   2 +-=0A=
 hw/char/Makefile.objs                   |   4 +-=0A=
 hw/char/bcm2835_aux.c                   |   2 +-=0A=
 hw/char/cadence_uart.c                  |   2 +-=0A=
 hw/char/cmsdk-apb-uart.c                |   2 +-=0A=
 hw/char/debugcon.c                      |   2 +-=0A=
 hw/char/digic-uart.c                    |   2 +-=0A=
 hw/char/escc.c                          |   2 +-=0A=
 hw/char/etraxfs_ser.c                   |   2 +-=0A=
 hw/char/exynos4210_uart.c               |   2 +-=0A=
 hw/char/grlib_apbuart.c                 |   2 +-=0A=
 hw/char/imx_serial.c                    |   2 +-=0A=
 hw/char/lm32_uart.c                     |   2 +-=0A=
 hw/char/mcf_uart.c                      |   2 +-=0A=
 hw/char/milkymist-uart.c                |   2 +-=0A=
 hw/char/nrf51_uart.c                    |   2 +-=0A=
 hw/char/omap_uart.c                     |   6 +-=0A=
 hw/char/parallel.c                      |   2 +-=0A=
 hw/char/pl011.c                         |   2 +-=0A=
 hw/char/serial.c                        |  26 ++---=0A=
 hw/char/sh_serial.c                     |   2 +-=0A=
 hw/char/stm32f2xx_usart.c               |   2 +-=0A=
 hw/char/xilinx_uartlite.c               |   2 +-=0A=
 hw/core/Makefile.objs                   |   2 +-=0A=
 hw/core/empty_slot.c                    |   2 +-=0A=
 hw/cris/axis_dev88.c                    |   4 +-=0A=
 hw/display/Makefile.objs                |   6 +-=0A=
 hw/display/ati.c                        |   2 +-=0A=
 hw/display/bcm2835_fb.c                 |   2 +-=0A=
 hw/display/bochs-display.c              |   4 +-=0A=
 hw/display/cg3.c                        |   2 +-=0A=
 hw/display/cirrus_vga.c                 |  10 +-=0A=
 hw/display/edid-region.c                |   2 +-=0A=
 hw/display/exynos4210_fimd.c            |   2 +-=0A=
 hw/display/g364fb.c                     |   2 +-=0A=
 hw/display/jazz_led.c                   |   2 +-=0A=
 hw/display/milkymist-tmu2.c             |   2 +-=0A=
 hw/display/milkymist-vgafb.c            |   2 +-=0A=
 hw/display/omap_dss.c                   |  10 +-=0A=
 hw/display/omap_lcdc.c                  |   2 +-=0A=
 hw/display/pl110.c                      |   2 +-=0A=
 hw/display/pxa2xx_lcd.c                 |   2 +-=0A=
 hw/display/sm501.c                      |  10 +-=0A=
 hw/display/tc6393xb.c                   |   2 +-=0A=
 hw/display/tcx.c                        |  14 +--=0A=
 hw/display/vga-isa-mm.c                 |   2 +-=0A=
 hw/display/vga-pci.c                    |   6 +-=0A=
 hw/display/vga.c                        |   2 +-=0A=
 hw/display/vmware_vga.c                 |   2 +-=0A=
 hw/display/xlnx_dp.c                    |   8 +-=0A=
 hw/dma/Makefile.objs                    |   6 +-=0A=
 hw/dma/bcm2835_dma.c                    |   4 +-=0A=
 hw/dma/etraxfs_dma.c                    |   2 +-=0A=
 hw/dma/i8257.c                          |   4 +-=0A=
 hw/dma/omap_dma.c                       |   4 +-=0A=
 hw/dma/pl080.c                          |   2 +-=0A=
 hw/dma/pl330.c                          |   2 +-=0A=
 hw/dma/puv3_dma.c                       |   2 +-=0A=
 hw/dma/pxa2xx_dma.c                     |   2 +-=0A=
 hw/dma/rc4030.c                         |   4 +-=0A=
 hw/dma/sparc32_dma.c                    |   2 +-=0A=
 hw/dma/xilinx_axidma.c                  |   2 +-=0A=
 hw/dma/xlnx-zdma.c                      |   2 +-=0A=
 hw/dma/xlnx-zynq-devcfg.c               |   2 +-=0A=
 hw/dma/xlnx_dpdma.c                     |   2 +-=0A=
 hw/gpio/Makefile.objs                   |   2 +-=0A=
 hw/gpio/bcm2835_gpio.c                  |   2 +-=0A=
 hw/gpio/imx_gpio.c                      |   2 +-=0A=
 hw/gpio/mpc8xxx.c                       |   2 +-=0A=
 hw/gpio/nrf51_gpio.c                    |   2 +-=0A=
 hw/gpio/omap_gpio.c                     |   6 +-=0A=
 hw/gpio/pl061.c                         |   2 +-=0A=
 hw/gpio/puv3_gpio.c                     |   2 +-=0A=
 hw/gpio/zaurus.c                        |   2 +-=0A=
 hw/hppa/dino.c                          |   6 +-=0A=
 hw/hppa/machine.c                       |   2 +-=0A=
 hw/hppa/pci.c                           |   6 +-=0A=
 hw/hyperv/hyperv_testdev.c              |   2 +-=0A=
 hw/i2c/Makefile.objs                    |   2 +-=0A=
 hw/i2c/aspeed_i2c.c                     |   4 +-=0A=
 hw/i2c/exynos4210_i2c.c                 |   2 +-=0A=
 hw/i2c/imx_i2c.c                        |   2 +-=0A=
 hw/i2c/microbit_i2c.c                   |   2 +-=0A=
 hw/i2c/mpc_i2c.c                        |   2 +-=0A=
 hw/i2c/omap_i2c.c                       |   2 +-=0A=
 hw/i2c/pm_smbus.c                       |   2 +-=0A=
 hw/i2c/ppc4xx_i2c.c                     |   2 +-=0A=
 hw/i2c/versatile_i2c.c                  |   2 +-=0A=
 hw/i386/amd_iommu.c                     |   4 +-=0A=
 hw/i386/intel_iommu.c                   |   4 +-=0A=
 hw/i386/kvm/apic.c                      |   2 +-=0A=
 hw/i386/kvmvapic.c                      |   2 +-=0A=
 hw/i386/pc.c                            |   6 +-=0A=
 hw/i386/vmport.c                        |   2 +-=0A=
 hw/i386/xen/xen_apic.c                  |   2 +-=0A=
 hw/i386/xen/xen_platform.c              |   4 +-=0A=
 hw/i386/xen/xen_pvdevice.c              |   2 +-=0A=
 hw/ide/ahci-allwinner.c                 |   2 +-=0A=
 hw/ide/ahci.c                           |   4 +-=0A=
 hw/ide/macio.c                          |   2 +-=0A=
 hw/ide/mmio.c                           |   4 +-=0A=
 hw/ide/pci.c                            |   6 +-=0A=
 hw/ide/sii3112.c                        |   2 +-=0A=
 hw/input/Makefile.objs                  |   2 +-=0A=
 hw/input/milkymist-softusb.c            |   2 +-=0A=
 hw/input/pckbd.c                        |   6 +-=0A=
 hw/input/pl050.c                        |   2 +-=0A=
 hw/input/pxa2xx_keypad.c                |   2 +-=0A=
 hw/intc/Makefile.objs                   |   6 +-=0A=
 hw/intc/allwinner-a10-pic.c             |   2 +-=0A=
 hw/intc/apic.c                          |   2 +-=0A=
 hw/intc/arm_gic.c                       |  12 +-=0A=
 hw/intc/arm_gicv2m.c                    |   2 +-=0A=
 hw/intc/arm_gicv3.c                     |   4 +-=0A=
 hw/intc/arm_gicv3_its_common.c          |   2 +-=0A=
 hw/intc/armv7m_nvic.c                   |  19 +--=0A=
 hw/intc/aspeed_vic.c                    |   2 +-=0A=
 hw/intc/bcm2835_ic.c                    |   2 +-=0A=
 hw/intc/bcm2836_control.c               |   2 +-=0A=
 hw/intc/etraxfs_pic.c                   |   2 +-=0A=
 hw/intc/exynos4210_combiner.c           |   2 +-=0A=
 hw/intc/grlib_irqmp.c                   |   2 +-=0A=
 hw/intc/heathrow_pic.c                  |   2 +-=0A=
 hw/intc/imx_avic.c                      |   2 +-=0A=
 hw/intc/imx_gpcv2.c                     |   2 +-=0A=
 hw/intc/ioapic.c                        |   2 +-=0A=
 hw/intc/mips_gic.c                      |   2 +-=0A=
 hw/intc/omap_intc.c                     |   4 +-=0A=
 hw/intc/ompic.c                         |   2 +-=0A=
 hw/intc/openpic.c                       |  20 ++--=0A=
 hw/intc/openpic_kvm.c                   |   2 +-=0A=
 hw/intc/pl190.c                         |   2 +-=0A=
 hw/intc/pnv_xive.c                      |  14 +--=0A=
 hw/intc/puv3_intc.c                     |   2 +-=0A=
 hw/intc/sh_intc.c                       |   2 +-=0A=
 hw/intc/slavio_intctl.c                 |   4 +-=0A=
 hw/intc/xics_pnv.c                      |   2 +-=0A=
 hw/intc/xilinx_intc.c                   |   2 +-=0A=
 hw/intc/xive.c                          |   6 +-=0A=
 hw/intc/xlnx-pmu-iomod-intc.c           |   2 +-=0A=
 hw/intc/xlnx-zynqmp-ipi.c               |   2 +-=0A=
 hw/ipack/Makefile.objs                  |   2 +-=0A=
 hw/ipack/tpci200.c                      |  10 +-=0A=
 hw/ipmi/isa_ipmi_bt.c                   |   2 +-=0A=
 hw/ipmi/isa_ipmi_kcs.c                  |   2 +-=0A=
 hw/isa/lpc_ich9.c                       |   4 +-=0A=
 hw/isa/pc87312.c                        |   2 +-=0A=
 hw/isa/vt82c686.c                       |   2 +-=0A=
 hw/m68k/mcf5206.c                       |   2 +-=0A=
 hw/m68k/mcf5208.c                       |   4 +-=0A=
 hw/m68k/mcf_intc.c                      |   2 +-=0A=
 hw/microblaze/petalogix_ml605_mmu.c     |   2 +-=0A=
 hw/mips/boston.c                        |   6 +-=0A=
 hw/mips/gt64xxx_pci.c                   |   2 +-=0A=
 hw/mips/mips_jazz.c                     |   8 +-=0A=
 hw/mips/mips_malta.c                    |   4 +-=0A=
 hw/mips/mips_r4k.c                      |   2 +-=0A=
 hw/misc/Makefile.objs                   |  10 +-=0A=
 hw/misc/a9scu.c                         |   2 +-=0A=
 hw/misc/applesmc.c                      |   6 +-=0A=
 hw/misc/arm11scu.c                      |   2 +-=0A=
 hw/misc/arm_integrator_debug.c          |   2 +-=0A=
 hw/misc/arm_l2x0.c                      |   2 +-=0A=
 hw/misc/arm_sysctl.c                    |   2 +-=0A=
 hw/misc/armsse-cpuid.c                  |   2 +-=0A=
 hw/misc/armsse-mhu.c                    |   2 +-=0A=
 hw/misc/aspeed_scu.c                    |   2 +-=0A=
 hw/misc/aspeed_sdmc.c                   |   2 +-=0A=
 hw/misc/aspeed_xdma.c                   |   2 +-=0A=
 hw/misc/bcm2835_mbox.c                  |   2 +-=0A=
 hw/misc/bcm2835_property.c              |   2 +-=0A=
 hw/misc/bcm2835_rng.c                   |   2 +-=0A=
 hw/misc/debugexit.c                     |   2 +-=0A=
 hw/misc/eccmemctl.c                     |   4 +-=0A=
 hw/misc/edu.c                           |   2 +-=0A=
 hw/misc/exynos4210_clk.c                |   2 +-=0A=
 hw/misc/exynos4210_pmu.c                |   2 +-=0A=
 hw/misc/exynos4210_rng.c                |   2 +-=0A=
 hw/misc/grlib_ahb_apb_pnp.c             |   4 +-=0A=
 hw/misc/imx25_ccm.c                     |   2 +-=0A=
 hw/misc/imx2_wdt.c                      |   2 +-=0A=
 hw/misc/imx31_ccm.c                     |   2 +-=0A=
 hw/misc/imx6_ccm.c                      |   4 +-=0A=
 hw/misc/imx6_src.c                      |   2 +-=0A=
 hw/misc/imx6ul_ccm.c                    |   4 +-=0A=
 hw/misc/imx7_ccm.c                      |   4 +-=0A=
 hw/misc/imx7_gpr.c                      |   2 +-=0A=
 hw/misc/imx7_snvs.c                     |   2 +-=0A=
 hw/misc/iotkit-secctl.c                 |   4 +-=0A=
 hw/misc/iotkit-sysctl.c                 |   2 +-=0A=
 hw/misc/iotkit-sysinfo.c                |   2 +-=0A=
 hw/misc/ivshmem.c                       |   2 +-=0A=
 hw/misc/macio/cuda.c                    |   2 +-=0A=
 hw/misc/macio/gpio.c                    |   2 +-=0A=
 hw/misc/macio/mac_dbdma.c               |   2 +-=0A=
 hw/misc/macio/macio.c                   |   2 +-=0A=
 hw/misc/macio/pmu.c                     |   2 +-=0A=
 hw/misc/milkymist-hpdmc.c               |   2 +-=0A=
 hw/misc/milkymist-pfpu.c                |   2 +-=0A=
 hw/misc/mips_cmgcr.c                    |   2 +-=0A=
 hw/misc/mips_cpc.c                      |   2 +-=0A=
 hw/misc/mips_itu.c                      |   4 +-=0A=
 hw/misc/mos6522.c                       |   2 +-=0A=
 hw/misc/mps2-fpgaio.c                   |   2 +-=0A=
 hw/misc/mps2-scc.c                      |   2 +-=0A=
 hw/misc/msf2-sysreg.c                   |   2 +-=0A=
 hw/misc/mst_fpga.c                      |   2 +-=0A=
 hw/misc/nrf51_rng.c                     |   2 +-=0A=
 hw/misc/omap_gpmc.c                     |   6 +-=0A=
 hw/misc/omap_l4.c                       |   2 +-=0A=
 hw/misc/omap_sdrc.c                     |   2 +-=0A=
 hw/misc/omap_tap.c                      |   2 +-=0A=
 hw/misc/pc-testdev.c                    |  10 +-=0A=
 hw/misc/pci-testdev.c                   |   4 +-=0A=
 hw/misc/puv3_pm.c                       |   2 +-=0A=
 hw/misc/slavio_misc.c                   |  16 +--=0A=
 hw/misc/stm32f2xx_syscfg.c              |   2 +-=0A=
 hw/misc/tz-mpc.c                        |   4 +-=0A=
 hw/misc/tz-msc.c                        |   2 +-=0A=
 hw/misc/tz-ppc.c                        |   2 +-=0A=
 hw/misc/unimp.c                         |   2 +-=0A=
 hw/misc/zynq-xadc.c                     |   2 +-=0A=
 hw/misc/zynq_slcr.c                     |   2 +-=0A=
 hw/moxie/moxiesim.c                     |   2 +-=0A=
 hw/net/Makefile.objs                    |   2 +-=0A=
 hw/net/allwinner_emac.c                 |   2 +-=0A=
 hw/net/cadence_gem.c                    |   2 +-=0A=
 hw/net/can/can_kvaser_pci.c             |   6 +-=0A=
 hw/net/can/can_mioe3680_pci.c           |   4 +-=0A=
 hw/net/can/can_pcm3680_pci.c            |   4 +-=0A=
 hw/net/dp8393x.c                        |   2 +-=0A=
 hw/net/e1000.c                          |   4 +-=0A=
 hw/net/e1000e.c                         |   4 +-=0A=
 hw/net/eepro100.c                       |   2 +-=0A=
 hw/net/etraxfs_eth.c                    |   2 +-=0A=
 hw/net/fsl_etsec/etsec.c                |   2 +-=0A=
 hw/net/ftgmac100.c                      |   2 +-=0A=
 hw/net/imx_fec.c                        |   2 +-=0A=
 hw/net/lan9118.c                        |   4 +-=0A=
 hw/net/lance.c                          |   2 +-=0A=
 hw/net/mcf_fec.c                        |   2 +-=0A=
 hw/net/milkymist-minimac2.c             |   2 +-=0A=
 hw/net/ne2000.c                         |   2 +-=0A=
 hw/net/pcnet-pci.c                      |   4 +-=0A=
 hw/net/rocker/rocker.c                  |   2 +-=0A=
 hw/net/rtl8139.c                        |   2 +-=0A=
 hw/net/smc91c111.c                      |   2 +-=0A=
 hw/net/stellaris_enet.c                 |   2 +-=0A=
 hw/net/sungem.c                         |  12 +-=0A=
 hw/net/sunhme.c                         |  10 +-=0A=
 hw/net/vmxnet3.c                        |   4 +-=0A=
 hw/net/xgmac.c                          |   2 +-=0A=
 hw/net/xilinx_axienet.c                 |   2 +-=0A=
 hw/net/xilinx_ethlite.c                 |   2 +-=0A=
 hw/nios2/10m50_devboard.c               |   2 +-=0A=
 hw/nvram/ds1225y.c                      |   2 +-=0A=
 hw/nvram/fw_cfg.c                       |   8 +-=0A=
 hw/nvram/mac_nvram.c                    |   2 +-=0A=
 hw/nvram/nrf51_nvm.c                    |   8 +-=0A=
 hw/openrisc/openrisc_sim.c              |   2 +-=0A=
 hw/pci-host/Makefile.objs               |   2 +-=0A=
 hw/pci-host/bonito.c                    |  10 +-=0A=
 hw/pci-host/designware.c                |   6 +-=0A=
 hw/pci-host/piix.c                      |   2 +-=0A=
 hw/pci-host/ppce500.c                   |   2 +-=0A=
 hw/pci-host/prep.c                      |   4 +-=0A=
 hw/pci-host/q35.c                       |   4 +-=0A=
 hw/pci-host/sabre.c                     |   4 +-=0A=
 hw/pci-host/uninorth.c                  |   4 +-=0A=
 hw/pci-host/versatile.c                 |   4 +-=0A=
 hw/pci/msix.c                           |   4 +-=0A=
 hw/pci/pci_host.c                       |   8 +-=0A=
 hw/pci/pcie_host.c                      |   2 +-=0A=
 hw/pci/shpc.c                           |   2 +-=0A=
 hw/pcmcia/pxa2xx.c                      |   6 +-=0A=
 hw/ppc/e500.c                           |   4 +-=0A=
 hw/ppc/mpc8544_guts.c                   |   2 +-=0A=
 hw/ppc/pnv_core.c                       |   6 +-=0A=
 hw/ppc/pnv_lpc.c                        |   8 +-=0A=
 hw/ppc/pnv_occ.c                        |   4 +-=0A=
 hw/ppc/pnv_psi.c                        |   8 +-=0A=
 hw/ppc/pnv_xscom.c                      |   2 +-=0A=
 hw/ppc/ppc405_boards.c                  |   4 +-=0A=
 hw/ppc/ppc405_uc.c                      |  14 +--=0A=
 hw/ppc/ppc440_bamboo.c                  |   4 +-=0A=
 hw/ppc/ppc440_pcix.c                    |   4 +-=0A=
 hw/ppc/ppc4xx_pci.c                     |   2 +-=0A=
 hw/ppc/ppce500_spin.c                   |   2 +-=0A=
 hw/ppc/sam460ex.c                       |   4 +-=0A=
 hw/ppc/spapr_pci.c                      |   2 +-=0A=
 hw/ppc/virtex_ml507.c                   |   2 +-=0A=
 hw/rdma/vmw/pvrdma_main.c               |   4 +-=0A=
 hw/riscv/sifive_clint.c                 |   2 +-=0A=
 hw/riscv/sifive_gpio.c                  |   2 +-=0A=
 hw/riscv/sifive_plic.c                  |   2 +-=0A=
 hw/riscv/sifive_prci.c                  |   2 +-=0A=
 hw/riscv/sifive_test.c                  |   2 +-=0A=
 hw/riscv/sifive_uart.c                  |   2 +-=0A=
 hw/riscv/virt.c                         |   2 +-=0A=
 hw/s390x/s390-pci-bus.c                 |   2 +-=0A=
 hw/s390x/s390-pci-inst.c                |  11 +-=0A=
 hw/scsi/Makefile.objs                   |   2 +-=0A=
 hw/scsi/esp-pci.c                       |   2 +-=0A=
 hw/scsi/esp.c                           |   2 +-=0A=
 hw/scsi/lsi53c895a.c                    |   6 +-=0A=
 hw/scsi/megasas.c                       |   6 +-=0A=
 hw/scsi/mptsas.c                        |   6 +-=0A=
 hw/scsi/vmw_pvscsi.c                    |   2 +-=0A=
 hw/sd/bcm2835_sdhost.c                  |   2 +-=0A=
 hw/sd/milkymist-memcard.c               |   2 +-=0A=
 hw/sd/omap_mmc.c                        |   2 +-=0A=
 hw/sd/pl181.c                           |   2 +-=0A=
 hw/sd/pxa2xx_mmci.c                     |   2 +-=0A=
 hw/sd/sdhci.c                           |   4 +-=0A=
 hw/sh4/r2d.c                            |   2 +-=0A=
 hw/sh4/sh7750.c                         |   4 +-=0A=
 hw/sh4/sh_pci.c                         |   2 +-=0A=
 hw/sparc/sun4m_iommu.c                  |   2 +-=0A=
 hw/sparc64/niagara.c                    |   2 +-=0A=
 hw/sparc64/sun4u.c                      |   4 +-=0A=
 hw/sparc64/sun4u_iommu.c                |   2 +-=0A=
 hw/ssi/Makefile.objs                    |   2 +-=0A=
 hw/ssi/aspeed_smc.c                     |   6 +-=0A=
 hw/ssi/imx_spi.c                        |   2 +-=0A=
 hw/ssi/mss-spi.c                        |   2 +-=0A=
 hw/ssi/omap_spi.c                       |   2 +-=0A=
 hw/ssi/pl022.c                          |   2 +-=0A=
 hw/ssi/stm32f2xx_spi.c                  |   2 +-=0A=
 hw/ssi/xilinx_spi.c                     |   2 +-=0A=
 hw/ssi/xilinx_spips.c                   |   8 +-=0A=
 hw/timer/Makefile.objs                  |   6 +-=0A=
 hw/timer/a9gtimer.c                     |   4 +-=0A=
 hw/timer/allwinner-a10-pit.c            |   2 +-=0A=
 hw/timer/altera_timer.c                 |   2 +-=0A=
 hw/timer/arm_mptimer.c                  |   4 +-=0A=
 hw/timer/arm_timer.c                    |   4 +-=0A=
 hw/timer/armv7m_systick.c               |   2 +-=0A=
 hw/timer/aspeed_rtc.c                   |   2 +-=0A=
 hw/timer/aspeed_timer.c                 |   2 +-=0A=
 hw/timer/cadence_ttc.c                  |   2 +-=0A=
 hw/timer/cmsdk-apb-dualtimer.c          |   2 +-=0A=
 hw/timer/cmsdk-apb-timer.c              |   2 +-=0A=
 hw/timer/digic-timer.c                  |   2 +-=0A=
 hw/timer/etraxfs_timer.c                |   2 +-=0A=
 hw/timer/exynos4210_mct.c               |   2 +-=0A=
 hw/timer/exynos4210_pwm.c               |   2 +-=0A=
 hw/timer/exynos4210_rtc.c               |   2 +-=0A=
 hw/timer/grlib_gptimer.c                |   2 +-=0A=
 hw/timer/hpet.c                         |   2 +-=0A=
 hw/timer/i8254.c                        |   2 +-=0A=
 hw/timer/imx_epit.c                     |   2 +-=0A=
 hw/timer/imx_gpt.c                      |   2 +-=0A=
 hw/timer/lm32_timer.c                   |   2 +-=0A=
 hw/timer/m48t59.c                       |   4 +-=0A=
 hw/timer/mc146818rtc.c                  |   2 +-=0A=
 hw/timer/milkymist-sysctl.c             |   2 +-=0A=
 hw/timer/mss-timer.c                    |   2 +-=0A=
 hw/timer/nrf51_timer.c                  |   2 +-=0A=
 hw/timer/omap_gptimer.c                 |   2 +-=0A=
 hw/timer/omap_synctimer.c               |   2 +-=0A=
 hw/timer/pl031.c                        |   2 +-=0A=
 hw/timer/puv3_ost.c                     |   2 +-=0A=
 hw/timer/pxa2xx_timer.c                 |   2 +-=0A=
 hw/timer/sh_timer.c                     |   2 +-=0A=
 hw/timer/slavio_timer.c                 |   2 +-=0A=
 hw/timer/stm32f2xx_timer.c              |   2 +-=0A=
 hw/timer/sun4v-rtc.c                    |   2 +-=0A=
 hw/timer/xilinx_timer.c                 |   2 +-=0A=
 hw/timer/xlnx-zynqmp-rtc.c              |   2 +-=0A=
 hw/tpm/tpm_crb.c                        |   2 +-=0A=
 hw/tpm/tpm_tis.c                        |   2 +-=0A=
 hw/usb/chipidea.c                       |   4 +-=0A=
 hw/usb/hcd-ehci-sysbus.c                |   2 +-=0A=
 hw/usb/hcd-ehci.c                       |   6 +-=0A=
 hw/usb/hcd-ohci.c                       |   2 +-=0A=
 hw/usb/hcd-uhci.c                       |   2 +-=0A=
 hw/usb/hcd-xhci.c                       |  10 +-=0A=
 hw/usb/tusb6010.c                       |   2 +-=0A=
 hw/vfio/common.c                        |   2 +-=0A=
 hw/vfio/pci-quirks.c                    |  33 +++---=0A=
 hw/vfio/pci.c                           |   4 +-=0A=
 hw/virtio/Makefile.objs                 |   2 +-=0A=
 hw/virtio/virtio-mmio.c                 |   2 +-=0A=
 hw/virtio/virtio-pci.c                  |  27 +++--=0A=
 hw/watchdog/cmsdk-apb-watchdog.c        |   2 +-=0A=
 hw/watchdog/wdt_aspeed.c                |   2 +-=0A=
 hw/watchdog/wdt_i6300esb.c              |   2 +-=0A=
 hw/xen/xen_pt.c                         |   2 +-=0A=
 hw/xen/xen_pt_msi.c                     |   2 +-=0A=
 hw/xtensa/mx_pic.c                      |   2 +-=0A=
 hw/xtensa/xtfpga.c                      |   6 +-=0A=
 include/exec/cpu-all.h                  |  10 +-=0A=
 include/exec/cpu-common.h               |  12 --=0A=
 include/exec/memattrs.h                 |   2 +=0A=
 include/exec/memop.h                    | 134 ++++++++++++++++++++++=0A=
 include/exec/memory.h                   |  11 +-=0A=
 include/exec/poison.h                   |   1 +=0A=
 include/hw/char/serial.h                |   2 +-=0A=
 include/qom/cpu.h                       |   2 +-=0A=
 ioport.c                                |   4 +-=0A=
 memory.c                                |  55 ++++-----=0A=
 memory_ldst.inc.c                       | 153 ++++++++-----------------=0A=
 target/alpha/cpu.h                      |   2 -=0A=
 target/alpha/translate.c                |   2 +-=0A=
 target/arm/translate-a64.c              |  48 ++++----=0A=
 target/arm/translate-a64.h              |   2 +-=0A=
 target/arm/translate-sve.c              |   2 +-=0A=
 target/arm/translate.c                  |  32 +++---=0A=
 target/arm/translate.h                  |   2 +-=0A=
 target/hppa/cpu.h                       |   1 -=0A=
 target/hppa/translate.c                 |  14 +--=0A=
 target/i386/translate.c                 | 132 ++++++++++-----------=0A=
 target/m68k/translate.c                 |   2 +-=0A=
 target/microblaze/translate.c           |   4 +-=0A=
 target/mips/cpu.h                       |   2 -=0A=
 target/mips/op_helper.c                 |   5 +-=0A=
 target/mips/translate.c                 |   8 +-=0A=
 target/openrisc/translate.c             |   4 +-=0A=
 target/ppc/translate.c                  |  12 +-=0A=
 target/riscv/insn_trans/trans_rva.inc.c |   8 +-=0A=
 target/riscv/insn_trans/trans_rvi.inc.c |   4 +-=0A=
 target/s390x/translate.c                |   6 +-=0A=
 target/s390x/translate_vx.inc.c         |  10 +-=0A=
 target/sh4/cpu.h                        |   2 -=0A=
 target/sparc/cpu.h                      |   4 +-=0A=
 target/sparc/mmu_helper.c               |  40 ++++---=0A=
 target/sparc/translate.c                |  14 +--=0A=
 target/tilegx/translate.c               |  10 +-=0A=
 target/tricore/translate.c              |   8 +-=0A=
 target/xtensa/cpu.h                     |   2 -=0A=
 tcg/README                              |   2 +-=0A=
 tcg/aarch64/tcg-target.inc.c            |  26 ++---=0A=
 tcg/arm/tcg-target.inc.c                |  26 ++---=0A=
 tcg/i386/tcg-target.inc.c               |  24 ++--=0A=
 tcg/mips/tcg-target.inc.c               |  16 +--=0A=
 tcg/optimize.c                          |   2 +-=0A=
 tcg/ppc/tcg-target.inc.c                |  12 +-=0A=
 tcg/riscv/tcg-target.inc.c              |  20 ++--=0A=
 tcg/s390/tcg-target.inc.c               |  14 +--=0A=
 tcg/sparc/tcg-target.inc.c              |   6 +-=0A=
 tcg/tcg-op.c                            |  38 +++---=0A=
 tcg/tcg-op.h                            |  86 +++++++-------=0A=
 tcg/tcg.c                               |   4 +-=0A=
 tcg/tcg.h                               |  99 +---------------=0A=
 trace/mem-internal.h                    |   4 +-=0A=
 trace/mem.h                             |   4 +-=0A=
 497 files changed, 1436 insertions(+), 1473 deletions(-)=0A=
 create mode 100644 include/exec/memop.h=0A=
=0A=
-- =0A=
1.8.3.1=0A=

