Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92510C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EEFC21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.com header.i=@mail.com header.b="YVDxcWHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEFC21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i18hc-0006r6-Rg
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@mail.com>) id 1i0xzc-0004Ho-LX
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 21:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@mail.com>) id 1i0xzY-0007HQ-IH
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 21:03:51 -0400
Received: from mout.gmx.com ([74.208.4.201]:57847)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@mail.com>)
 id 1i0xzV-00078D-BC
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 21:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.com;
 s=dbd5af2cbaf7; t=1566522184;
 bh=O91txkjOBmEcJRe3Oe4vNR9+bAbaktkHXi77BLcgQzc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=YVDxcWHmh0Ok4vy5hhsgYp4CTncpyxQvMXTX08FuYSTNb6meFuquI5qYIraTEWk2n
 z/Tj0c3rsU9LOTUH+faaZIO0to6+q9URRQWRdaNZUnAal/X3fVCTzWFYii54N3i0QH
 44N3T8ge29DfNppxxHBBtj52LxkAO+FYaWClIkAY=
X-UI-Sender-Class: 214d933f-fd2f-45c7-a636-f5d79ae31a79
Received: from localhost.localdomain ([58.173.98.68]) by mail.gmx.com
 (mrgmxus002 [74.208.5.15]) with ESMTPSA (Nemesis) id
 0M6Ryf-1iBJnh0xSd-00ySuw; Fri, 23 Aug 2019 03:03:04 +0200
From: Tony Nguyen <tony.nguyen.git@mail.com>
To: qemu-devel@nongnu.org
Date: Fri, 23 Aug 2019 11:02:33 +1000
Message-Id: <cover.1566466906.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yqCELo2c/WM+ZvIqEyMs91gKddnzlWLqAtXOieGh0ZaqNPTa7Y3
 CIZYZbw6oFuXOsJlQMLJLpSf6GxPzCiaGVX2afiYDy15uMRJLT/a/K9tFuDAb8KdpykPCk6
 w5ewm8Ae6j20Mp3Y0bowYVsiaUtq9C5Ai+7qYlLbz2amyQvhhrLinoZJsLQl0gSPdxsvWO0
 I14TprQADY3uJj8ncTxWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wtyp1ee4o/0=:L+04E7EvwH1qxLCcXI0meh
 rriUWmNd6VZ2fP0pdDVlnqc6a9M9LZu3Zzq65o8tg2WI0/k8MaBSt0yC5et6FUhFNXg+iUTax
 IimoPu3pO7oJet+myX+2FWP4D/fIETrGx13YTD5a3td3H8jslw3dfo2B64aBHbBay+Z/v4Lfj
 bQYl6L5X2Zv8Yap5JOGqrCUpWHW3HsYvcxhe6nvV8By+9gyYmmUVvxnPLpazLMIm86gXuckY5
 o6xfiZD+wkjQsIOQXNzsNo9smNM77HDMJYFWxxQF4usDaXCzTXyFVu5bmK05Xfmr6wV6UYCVs
 2ITN0kXeP6lOyDTd5YsqlzcKCT4Wnt4RffLR1MtJo0qJCg3RtkFk7dOY4zAhzTS7NyvusA9iZ
 iaqXQ1MFjcQgV/+Zx6IuorI66cr+/5VxMgDLLs12zghv5KrUkPX5A+O71aiYT94YNZSgIM8OU
 xWzSIcjagPPsTGzQNkqgDiLwRxIoVWtIYM1wcgKYtYUk4WqiMV57vrFygLdGyGPza+GCGuANL
 5UfqsD3zx6JHLMdpnVq0mx4ogmGySUD52a6XBkLiG4+2tC8A1e4VBIMHn9rBfMnxwpGP7XA0p
 zeL02QCN/UfhWSOHwiM47PWNNHdqJO+xwVMWKjzIJfkubyqqjJPc7OJOamgSVfA4luEYHHTpG
 B/kEU4G9bMaz4V0UN+R4NhS4G38N6ew/c0CaWpl6e2lbgJ/TenBZf5arnkaB1RnZQmYSHCAea
 8o+hvefg9FCljk20APe6qrA/FImZwwDYxgDciWFWXyISBLibD7yiLScg3C4VFSAk3hmrBZrwZ
 Qjk/UzCS/gbX3ElJlcWHfSIXe3k+Jlc1w/Z1UH1jIKfT1luHREX5bGQIQCwK9rjElUt+tEZhX
 lZmGiL6w3+JvZKl+m8DgU7JSlMl/41SIo4GudcsJtbQwVcEiYgK7NF/8VOyj9uwOqAEYJlgj3
 oaknuBTTqxwR8BjSJOz7RUw2i8ScU1SI8oi4kk10EtUiLGA81CM0Oa0HlvoGLn7ffRUXqjQpZ
 SlMGph4BwGK4NisjZd0r5kOnswt2s0CRyRWXyv7ZeoyW8SsBK/cTtVcXvvUNqZdJ8/GLNwuBY
 akNTYqTMpgnTYvfp8mrwNolbQbtavBe6HoaTvOvSQfS2aZ85opWBb4bKjl8tNADhK2hbAStCo
 le2f4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 74.208.4.201
X-Mailman-Approved-At: Fri, 23 Aug 2019 08:20:36 -0400
Subject: [Qemu-devel] [PATCH v9 00/20] Invert Endian bit in SPARCv9 MMU TTE
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
Cc: Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190823010233.n0HwT4FTr7r8o-sY_oEIAoNAYkpJge-bPJASOA1lwJI@z>

From: Tony Nguyen <tony.nguyen@bt.com>

This patchset implements the IE (Invert Endian) bit in SPARCv9 MMU TTE.

It is an attempt of the instructions outlined by Richard Henderson to Mark
Cave-Ayland.

Tested with OpenBSD on sun4u. Solaris 10 is my actual goal, but unfortunat=
ely a
separate keyboard issue remains in the way.

On 01/11/17 19:15, Mark Cave-Ayland wrote:

>On 15/08/17 19:10, Richard Henderson wrote:
>
>> [CC Peter re MemTxAttrs below]
>>
>> On 08/15/2017 09:38 AM, Mark Cave-Ayland wrote:
>>> Working through an incorrect endian issue on qemu-system-sparc64, it h=
as
>>> become apparent that at least one OS makes use of the IE (Invert Endia=
n)
>>> bit in the SPARCv9 MMU TTE to map PCI memory space without the
>>> programmer having to manually endian-swap accesses.
>>>
>>> In other words, to quote the UltraSPARC specification: "if this bit is
>>> set, accesses to the associated page are processed with inverse
>>> endianness from what is specified by the instruction (big-for-little a=
nd
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
>>> Can anyone point me in the right direction as to what would be the bes=
t
>>> way to implement this feature within QEMU?
>>
>> It's definitely tricky.
>>
>> We definitely need some TLB_FLAGS_MASK bit set so that we're forced thr=
ough
>> the
>> memory slow path.  There is no other way to bypass the endianness that =
we've
>> already encoded from the target instruction.
>>
>> Given the tlb_set_page_with_attrs interface, I would think that we need=
 a new
>> bit in MemTxAttrs, so that the target/sparc tlb_fill (and subroutines) =
can
>> pass
>> along the TTE bit for the given page.
>>
>> We have an existing problem in softmmu_template.h,
>>
>>     /* ??? Note that the io helpers always read data in the target
>>        byte ordering.  We should push the LE/BE request down into io.  =
*/
>>     res =3D glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr);
>>     res =3D TGT_BE(res);
>>
>> We do not want to add a third(!) byte swap along the i/o path.  We need=
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
>of the final TGT_BE/TGT_LE applied to the result, or did I get this wrong=
?
>
>> (3) In tlb_set_page_with_attrs, notice attrs.byte_swap and set
>>     a new TLB_FORCE_SLOW bit within TLB_FLAGS_MASK.
>>
>> (4) In io_{read,write}x, if iotlbentry->attrs.byte_swap is set,
>>     then memop ^=3D MO_BSWAP.

Thanks all for the feedback. Learnt a lot =3D)

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

v4:
- Added Paolo Bonzini as include/exec/memop.h maintainer

v5:
- Improved commit messages to clarify how interface to access
  MemoryRegion will be converted from "unsigned size" to "MemOp op".
- Moved cpu_transaction_failed() MemOp conversion from patch #11 to #9
  to make review easier.

v6:
- Improved commit messages.
- Include as patch #1 an earlier posted TARGET_ALIGNED_ONLY configure patc=
h.
- Typeless macro SIZE_MEMOP is now inline.
- size_memop now includes CONFIG_DEBUG_TCG code.
- size_memop now also encodes endianness via MO_TE.
- Reverted size_memop operand "unsigned long" back to "unsigned".
- Second pass of size_memop to replace no-op place holder with MO_{8|16|32=
|64}.
- Delay memory_region_dispatch_{read,write} operand conversion until no-op
  size_memop is implemented so we have proper typing at all points in betw=
een.
- Fixed bug where not all memory_region_dispatch_{read,write} callers wher=
e
  encoding endianness into the MemOp operand, see patch #20.
- Fixed bug where not all memory_region_dispatch_{read,write} callers were
  collapsing their byte swap into adjust_endianness, see patch #20 and #22=
.
- Split byte swap collapsing patch (v5 #11) into #21 and #22.
- Corrected non-common *-common-obj to *-obj.
- Replaced enum device_endian with MemOp to simplify endianness checks. A
  straight forward sed but touched *alot* of files. See patch #16 and #17.
- Deleted enum device_endian.
- Deleted DEVICE_HOST_ENDIAN definition.
- Generalized the description of introduced MemTxAttrs attribute byte_swap=
.

v7:
- Fixed bug where size_memop was implicitly encoding MO_TE. Endianness,
  {MO_TE|MO_BE|MO_LE}, is now explicitly encoded by MemoryRegion accessors=
.
- While a no-op, size_memop return type remains an unsigned.
- Use '=3D 0' short hand instead of macro logic to declare host endianness=
.
- With new set of constant arguments, sanity checked the compiler is still
  folding away tests in cputlb.c
- Re-declared many native endian devices as little or big endian. This is =
why
  v7 has +16 patches.

v8:
- Split out re-declaration of native endian devices as little or big endia=
n.
  The clean up approach was too naive, and touched too many subsystem.
- Introduced devend_memop converter which the clean up was trying to avoid=
.
- Collapsed bswap in flatview_{read|write}_continue into adjust_endianness=
.
- Fixed pci{stg|lg}_service_call to access MemoryRegion with MO_BE not MO_=
LE.
- Fixed memory_region_{add|del}_eventfd to adjust_endianness with target,
  not host, endianness.
- Used git send-email... apologies to all for the HTML!

v9:
- Rebase on master and test with git am... again apologies to all, thanks =
for
  the patience =3D)

Tony Nguyen (20):
  tcg: TCGMemOp is now accelerator independent MemOp
  memory: Introduce size_memop
  target/mips: Access MemoryRegion with MemOp
  hw/s390x: Access MemoryRegion with MemOp
  hw/intc/armv7m_nic: Access MemoryRegion with MemOp
  hw/virtio: Access MemoryRegion with MemOp
  hw/vfio: Access MemoryRegion with MemOp
  exec: Access MemoryRegion with MemOp
  cputlb: Access MemoryRegion with MemOp
  memory: Access MemoryRegion with MemOp
  hw/s390x: Hard code size with MO_{8|16|32|64}
  target/mips: Hard code size with MO_{8|16|32|64}
  exec: Hard code size with MO_{8|16|32|64}
  memory: Access MemoryRegion with endianness
  cputlb: Replace size and endian operands for MemOp
  memory: Single byte swap along the I/O path
  cpu: TLB_FLAGS_MASK bit to force memory slow path
  cputlb: Byte swap memory transaction attribute
  target/sparc: Add TLB entry with attributes
  target/sparc: sun4u Invert Endian TTE bit

 MAINTAINERS                             |   1 +
 accel/tcg/cputlb.c                      | 197 ++++++++++--------------
 exec.c                                  |  10 +-
 hw/intc/armv7m_nvic.c                   |  13 +-
 hw/s390x/s390-pci-inst.c                |  11 +-
 hw/vfio/pci-quirks.c                    |   7 +-
 hw/virtio/virtio-pci.c                  |  15 +-
 include/exec/cpu-all.h                  |  10 +-
 include/exec/memattrs.h                 |   2 +
 include/exec/memop.h                    | 134 ++++++++++++++++
 include/exec/memory.h                   |  12 +-
 memory.c                                |  58 ++++---
 memory_ldst.inc.c                       |  81 ++--------
 target/alpha/translate.c                |   2 +-
 target/arm/translate-a64.c              |  48 +++---
 target/arm/translate-a64.h              |   2 +-
 target/arm/translate-sve.c              |   2 +-
 target/arm/translate.c                  |  32 ++--
 target/arm/translate.h                  |   2 +-
 target/hppa/translate.c                 |  14 +-
 target/i386/translate.c                 | 132 ++++++++--------
 target/m68k/translate.c                 |   2 +-
 target/microblaze/translate.c           |   4 +-
 target/mips/op_helper.c                 |   5 +-
 target/mips/translate.c                 |   8 +-
 target/openrisc/translate.c             |   4 +-
 target/ppc/translate.c                  |  12 +-
 target/riscv/insn_trans/trans_rva.inc.c |   8 +-
 target/riscv/insn_trans/trans_rvi.inc.c |   4 +-
 target/s390x/translate.c                |   6 +-
 target/s390x/translate_vx.inc.c         |  10 +-
 target/sparc/cpu.h                      |   2 +
 target/sparc/mmu_helper.c               |  40 +++--
 target/sparc/translate.c                |  14 +-
 target/tilegx/translate.c               |  10 +-
 target/tricore/translate.c              |   8 +-
 tcg/README                              |   2 +-
 tcg/aarch64/tcg-target.inc.c            |  26 ++--
 tcg/arm/tcg-target.inc.c                |  26 ++--
 tcg/i386/tcg-target.inc.c               |  24 +--
 tcg/mips/tcg-target.inc.c               |  16 +-
 tcg/optimize.c                          |   2 +-
 tcg/ppc/tcg-target.inc.c                |  12 +-
 tcg/riscv/tcg-target.inc.c              |  20 +--
 tcg/s390/tcg-target.inc.c               |  14 +-
 tcg/sparc/tcg-target.inc.c              |   6 +-
 tcg/tcg-op.c                            |  38 ++---
 tcg/tcg-op.h                            |  86 +++++------
 tcg/tcg.c                               |   2 +-
 tcg/tcg.h                               | 101 +-----------
 trace/mem-internal.h                    |   4 +-
 trace/mem.h                             |   4 +-
 52 files changed, 662 insertions(+), 643 deletions(-)
 create mode 100644 include/exec/memop.h

=2D-
2.23.0


