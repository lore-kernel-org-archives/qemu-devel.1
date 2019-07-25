Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB44C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 07:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EEA22C97
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 07:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EEA22C97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqXl9-0002cq-Pm
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 03:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50487)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hqXky-0002E7-3d
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 03:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hqXkv-0002En-Lw
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 03:01:40 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.74]:58897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hqXkb-0001yR-41; Thu, 25 Jul 2019 03:01:17 -0400
Received: from tpw09926dag18f.domain1.systemhost.net (10.9.212.26) by
 BWP09926079.bt.com (10.36.82.110) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Thu, 25
 Jul 2019 08:01:14 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18f.domain1.systemhost.net (10.9.212.26) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Thu, 25 Jul 2019 08:01:14 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Thu, 25 Jul
 2019 08:01:14 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v3 00/15] Invert Endian bit in SPARCv9 MMU
 TTE
Thread-Index: AQHVQrP3RrTfmfnvbEOFfW6KFJKHhQ==
Date: Thu, 25 Jul 2019 07:01:14 +0000
Message-ID: <1564038073754.91133@bt.com>
References: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>,
 <1563810716254.18886@bt.com>
In-Reply-To: <1563810716254.18886@bt.com>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.42]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.74
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v3 00/15] Invert Endian bit in SPARCv9 MMU TTE
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, mst@redhat.com,
 palmer@sifive.com, mark.cave-ayland@ilande.co.uk, Alistair.Francis@wdc.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, sw@weilnetz.de, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, david@gibson.dropbear.id.au, qemu-riscv@nongnu.org,
 cohuck@redhat.com, alex.williamson@redhat.com, qemu-ppc@nongnu.org,
 amarkovic@wavecomp.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset implements the IE (Invert Endian) bit in SPARCv9 MMU TTE.

It is an attempt of the instructions outlined by Richard Henderson to Mark
Cave-Ayland.

Tested with OpenBSD on sun4u. Solaris 10 is my actual goal, but unfortunate=
ly a
separate keyboard issue remains in the way.

On 01/11/17 19:15, Mark Cave-Ayland wrote:

>On 15/08/17 19:10, Richard Henderson wrote:
>
>> [CC Peter re MemTxAttrs below]
>>
>> On 08/15/2017 09:38 AM, Mark Cave-Ayland wrote:
>>> Working through an incorrect endian issue on qemu-system-sparc64, it ha=
s
>>> become apparent that at least one OS makes use of the IE (Invert Endian=
)
>>> bit in the SPARCv9 MMU TTE to map PCI memory space without the
>>> programmer having to manually endian-swap accesses.
>>>
>>> In other words, to quote the UltraSPARC specification: "if this bit is
>>> set, accesses to the associated page are processed with inverse
>>> endianness from what is specified by the instruction (big-for-little an=
d
>>> little-for-big)".

A good explanation by Mark why the IE bit is required.

>>>
>>> Looking through various bits of code, I'm trying to get a feel for the
>>> best way to implement this in an efficient manner. From what I can see
>>> this could be solved using an additional MMU index, however I'm not
>>> overly familiar with the memory and softmmu subsystems.
>>
>> No, it can't be solved with an MMU index.
>>
>>> Can anyone point me in the right direction as to what would be the best
>>> way to implement this feature within QEMU?
>>
>> It's definitely tricky.
>>
>> We definitely need some TLB_FLAGS_MASK bit set so that we're forced thro=
ugh
>> the
>> memory slow path.  There is no other way to bypass the endianness that w=
e've
>> already encoded from the target instruction.
>>
>> Given the tlb_set_page_with_attrs interface, I would think that we need =
a new
>> bit in MemTxAttrs, so that the target/sparc tlb_fill (and subroutines) c=
an
>> pass
>> along the TTE bit for the given page.
>>
>> We have an existing problem in softmmu_template.h,
>>
>>     /* ??? Note that the io helpers always read data in the target
>>        byte ordering.  We should push the LE/BE request down into io.  *=
/
>>     res =3D glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr);
>>     res =3D TGT_BE(res);
>>
>> We do not want to add a third(!) byte swap along the i/o path.  We need =
to
>> collapse the two that we have already before considering this one.
>>
>> This probably takes the form of:
>>
>> (1) Replacing the "int size" argument with "TCGMemOp memop" for
>>       a) io_{read,write}x in accel/tcg/cputlb.c,
>>       b) memory_region_dispatch_{read,write} in memory.c,
>>       c) adjust_endianness in memory.c.
>>     This carries size+sign+endianness down to the next level.
>>
>> (2) In memory.c, adjust_endianness,
>>
>>      if (memory_region_wrong_endianness(mr)) {
>> -        switch (size) {
>> +        memop ^=3D MO_BSWAP;
>> +    }
>> +    if (memop & MO_BSWAP) {
>>
>>     For extra credit, re-arrange memory_region_wrong_endianness
>>     to something more explicit -- "wrong" isn't helpful.
>
>Finally I've had a bit of spare time to experiment with this approach,
>and from what I can see there are currently 2 issues:
>
>
>1) Using TCGMemOp in memory.c means it is no longer accelerator agnostic
>
>For the moment I've defined a separate MemOp in memory.h and provided a
>mapping function in io_{read,write}x to map from TCGMemOp to MemOp and
>then pass that into memory_region_dispatch_{read,write}.
>
>Other than not referencing TCGMemOp in the memory API, another reason
>for doing this was that I wasn't convinced that all the MO_ attributes
>were valid outside of TCG. I do, of course, strongly defer to other
>people's knowledge in this area though.
>
>
>2) The above changes to adjust_endianness() fail when
>memory_region_dispatch_{read,write} are called recursively
>
>Whilst booting qemu-system-sparc64 I see that
>memory_region_dispatch_{read,write} get called recursively - once via
>io_{read,write}x and then again via flatview_read_continue() in exec.c.
>
>The net effect of this is that we perform the bswap correctly at the
>tail of the recursion, but then as we travel back up the stack we hit
>memory_region_dispatch_{read,write} once again causing a second bswap
>which means the value is returned with the incorrect endian again.
>
>
>My understanding from your softmmu_template.h comment above is that the
>memory API should do the endian swapping internally allowing the removal
>of the final TGT_BE/TGT_LE applied to the result, or did I get this wrong?
>
>> (3) In tlb_set_page_with_attrs, notice attrs.byte_swap and set
>>     a new TLB_FORCE_SLOW bit within TLB_FLAGS_MASK.
>>
>> (4) In io_{read,write}x, if iotlbentry->attrs.byte_swap is set,
>>     then memop ^=3D MO_BSWAP.

Thanks all for the v1 and v2 feedback.

v2:
- Moved size+sign+endianness attributes from TCGMemOp into MemOp.
  In v1 TCGMemOp was re-purposed entirely into MemOp.
- Replaced MemOp MO_{8|16|32|64} with TCGMemOp MO_{UB|UW|UL|UQ} alias.
  This is to avoid warnings on comparing and coercing different enums.
- Renamed get_memop to get_tcgmemop for clarity.
- MEMOP is now SIZE_MEMOP, which is just ctzl(size).
- Split patch 3/4 so one memory_region_dispatch_{read|write} interface
  is converted per patch.
- Do not reuse TLB_RECHECK, use new TLB_FORCE_SLOW instead.
- Split patch 4/4 so adding the MemTxAddrs parameters and converting
  tlb_set_page() to tlb_set_page_with_attrs() is separate from usage.
- CC'd maintainers.

v3:
- Like v1, the entire TCGMemOp enum is now MemOp.
- MemOp target dependant attributes are conditional upon NEED_CPU_H

Tony Nguyen (15):
  tcg: TCGMemOp is now accelerator independent MemOp
  memory: Access MemoryRegion with MemOp
  target/mips: Access MemoryRegion with MemOp
  hw/s390x: Access MemoryRegion with MemOp
  hw/intc/armv7m_nic: Access MemoryRegion with MemOp
  hw/virtio: Access MemoryRegion with MemOp
  hw/vfio: Access MemoryRegion with MemOp
  exec: Access MemoryRegion with MemOp
  cputlb: Access MemoryRegion with MemOp
  memory: Access MemoryRegion with MemOp semantics
  memory: Single byte swap along the I/O path
  cpu: TLB_FLAGS_MASK bit to force memory slow path
  cputlb: Byte swap memory transaction attribute
  target/sparc: Add TLB entry with attributes
  target/sparc: sun4u Invert Endian TTE bit

 accel/tcg/cputlb.c                      |  71 +++++++++--------
 exec.c                                  |   6 +-
 hw/intc/armv7m_nvic.c                   |  12 ++-
 hw/s390x/s390-pci-inst.c                |   8 +-
 hw/vfio/pci-quirks.c                    |   5 +-
 hw/virtio/virtio-pci.c                  |   7 +-
 include/exec/cpu-all.h                  |  10 ++-
 include/exec/memattrs.h                 |   2 +
 include/exec/memop.h                    | 112 +++++++++++++++++++++++++++
 include/exec/memory.h                   |   9 ++-
 memory.c                                |  37 +++++----
 memory_ldst.inc.c                       |  18 ++---
 target/alpha/translate.c                |   2 +-
 target/arm/translate-a64.c              |  48 ++++++------
 target/arm/translate-a64.h              |   2 +-
 target/arm/translate-sve.c              |   2 +-
 target/arm/translate.c                  |  32 ++++----
 target/arm/translate.h                  |   2 +-
 target/hppa/translate.c                 |  14 ++--
 target/i386/translate.c                 | 132 ++++++++++++++++------------=
----
 target/m68k/translate.c                 |   2 +-
 target/microblaze/translate.c           |   4 +-
 target/mips/op_helper.c                 |   5 +-
 target/mips/translate.c                 |   8 +-
 target/openrisc/translate.c             |   4 +-
 target/ppc/translate.c                  |  12 +--
 target/riscv/insn_trans/trans_rva.inc.c |   8 +-
 target/riscv/insn_trans/trans_rvi.inc.c |   4 +-
 target/s390x/translate.c                |   6 +-
 target/s390x/translate_vx.inc.c         |  10 +--
 target/sparc/cpu.h                      |   2 +
 target/sparc/mmu_helper.c               |  40 ++++++----
 target/sparc/translate.c                |  14 ++--
 target/tilegx/translate.c               |  10 +--
 target/tricore/translate.c              |   8 +-
 tcg/README                              |   2 +-
 tcg/aarch64/tcg-target.inc.c            |  26 +++----
 tcg/arm/tcg-target.inc.c                |  26 +++----
 tcg/i386/tcg-target.inc.c               |  24 +++---
 tcg/mips/tcg-target.inc.c               |  16 ++--
 tcg/optimize.c                          |   2 +-
 tcg/ppc/tcg-target.inc.c                |  12 +--
 tcg/riscv/tcg-target.inc.c              |  20 ++---
 tcg/s390/tcg-target.inc.c               |  14 ++--
 tcg/sparc/tcg-target.inc.c              |   6 +-
 tcg/tcg-op.c                            |  38 ++++-----
 tcg/tcg-op.h                            |  86 ++++++++++-----------
 tcg/tcg.c                               |   2 +-
 tcg/tcg.h                               |  99 ++----------------------
 trace/mem-internal.h                    |   4 +-
 trace/mem.h                             |   4 +-
 51 files changed, 561 insertions(+), 488 deletions(-)
 create mode 100644 include/exec/memop.h

--
1.8.3.1



