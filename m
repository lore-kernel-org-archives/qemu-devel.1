Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E90C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 06:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44106218D4
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 06:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44106218D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqtw7-0007R9-JR
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 02:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55189)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hqtvu-0006WT-50
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 02:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hqtvm-0000VJ-4e
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 02:42:20 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.71]:1709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hqtvk-0000MC-Q8; Fri, 26 Jul 2019 02:42:17 -0400
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 BWP09926076.bt.com (10.36.82.107) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Fri, 26
 Jul 2019 07:42:03 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18e.domain1.systemhost.net (10.9.212.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 26 Jul 2019 07:42:03 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 26 Jul
 2019 07:42:03 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v5 00/15] Invert Endian bit in SPARCv9 MMU
 TTE
Thread-Index: AQHVQ308zVdR2+sE0k2bOWs5r0zqAQ==
Date: Fri, 26 Jul 2019 06:42:03 +0000
Message-ID: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.42]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.71
Subject: [Qemu-devel] [PATCH v5 00/15] Invert Endian bit in SPARCv9 MMU TTE
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, sagark@eecs.berkeley.edu,
 david@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 Alistair.Francis@wdc.com, edgar.iglesias@gmail.com, arikalo@wavecomp.com,
 mst@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, rth@twiddle.net,
 atar4qemu@gmail.com, ehabkost@redhat.com, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, stefanha@redhat.com, shorne@gmail.com,
 david@gibson.dropbear.id.au, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 kbastian@mail.uni-paderborn.de, cohuck@redhat.com, laurent@vivier.eu,
 qemu-ppc@nongnu.org, amarkovic@wavecomp.com, pbonzini@redhat.com,
 aurelien@aurel32.net
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
Tony Nguyen (15):=0A=
  tcg: TCGMemOp is now accelerator independent MemOp=0A=
  memory: Access MemoryRegion with MemOp=0A=
  target/mips: Access MemoryRegion with MemOp=0A=
  hw/s390x: Access MemoryRegion with MemOp=0A=
  hw/intc/armv7m_nic: Access MemoryRegion with MemOp=0A=
  hw/virtio: Access MemoryRegion with MemOp=0A=
  hw/vfio: Access MemoryRegion with MemOp=0A=
  exec: Access MemoryRegion with MemOp=0A=
  cputlb: Access MemoryRegion with MemOp=0A=
  memory: Access MemoryRegion with MemOp semantics=0A=
  memory: Single byte swap along the I/O path=0A=
  cpu: TLB_FLAGS_MASK bit to force memory slow path=0A=
  cputlb: Byte swap memory transaction attribute=0A=
  target/sparc: Add TLB entry with attributes=0A=
  target/sparc: sun4u Invert Endian TTE bit=0A=
=0A=
 MAINTAINERS                             |   1 +=0A=
 accel/tcg/cputlb.c                      |  71 +++++++++--------=0A=
 exec.c                                  |   6 +-=0A=
 hw/intc/armv7m_nvic.c                   |  12 ++-=0A=
 hw/s390x/s390-pci-inst.c                |   8 +-=0A=
 hw/vfio/pci-quirks.c                    |   5 +-=0A=
 hw/virtio/virtio-pci.c                  |   7 +-=0A=
 include/exec/cpu-all.h                  |  10 ++-=0A=
 include/exec/memattrs.h                 |   2 +=0A=
 include/exec/memop.h                    | 112 +++++++++++++++++++++++++++=
=0A=
 include/exec/memory.h                   |   9 ++-=0A=
 memory.c                                |  37 +++++----=0A=
 memory_ldst.inc.c                       |  18 ++---=0A=
 target/alpha/translate.c                |   2 +-=0A=
 target/arm/translate-a64.c              |  48 ++++++------=0A=
 target/arm/translate-a64.h              |   2 +-=0A=
 target/arm/translate-sve.c              |   2 +-=0A=
 target/arm/translate.c                  |  32 ++++----=0A=
 target/arm/translate.h                  |   2 +-=0A=
 target/hppa/translate.c                 |  14 ++--=0A=
 target/i386/translate.c                 | 132 ++++++++++++++++------------=
----=0A=
 target/m68k/translate.c                 |   2 +-=0A=
 target/microblaze/translate.c           |   4 +-=0A=
 target/mips/op_helper.c                 |   5 +-=0A=
 target/mips/translate.c                 |   8 +-=0A=
 target/openrisc/translate.c             |   4 +-=0A=
 target/ppc/translate.c                  |  12 +--=0A=
 target/riscv/insn_trans/trans_rva.inc.c |   8 +-=0A=
 target/riscv/insn_trans/trans_rvi.inc.c |   4 +-=0A=
 target/s390x/translate.c                |   6 +-=0A=
 target/s390x/translate_vx.inc.c         |  10 +--=0A=
 target/sparc/cpu.h                      |   2 +=0A=
 target/sparc/mmu_helper.c               |  40 ++++++----=0A=
 target/sparc/translate.c                |  14 ++--=0A=
 target/tilegx/translate.c               |  10 +--=0A=
 target/tricore/translate.c              |   8 +-=0A=
 tcg/README                              |   2 +-=0A=
 tcg/aarch64/tcg-target.inc.c            |  26 +++----=0A=
 tcg/arm/tcg-target.inc.c                |  26 +++----=0A=
 tcg/i386/tcg-target.inc.c               |  24 +++---=0A=
 tcg/mips/tcg-target.inc.c               |  16 ++--=0A=
 tcg/optimize.c                          |   2 +-=0A=
 tcg/ppc/tcg-target.inc.c                |  12 +--=0A=
 tcg/riscv/tcg-target.inc.c              |  20 ++---=0A=
 tcg/s390/tcg-target.inc.c               |  14 ++--=0A=
 tcg/sparc/tcg-target.inc.c              |   6 +-=0A=
 tcg/tcg-op.c                            |  38 ++++-----=0A=
 tcg/tcg-op.h                            |  86 ++++++++++-----------=0A=
 tcg/tcg.c                               |   2 +-=0A=
 tcg/tcg.h                               |  99 ++----------------------=0A=
 trace/mem-internal.h                    |   4 +-=0A=
 trace/mem.h                             |   4 +-=0A=
 52 files changed, 562 insertions(+), 488 deletions(-)=0A=
 create mode 100644 include/exec/memop.h=0A=
=0A=
-- =0A=
1.8.3.1=0A=

