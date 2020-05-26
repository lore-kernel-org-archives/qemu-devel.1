Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F33C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 03:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B75207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 03:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B75207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdQkW-00087O-9C
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 23:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jdQk0-0007hA-Ie
 for qemu-devel@nongnu.org; Mon, 25 May 2020 23:59:00 -0400
Received: from relay64.bu.edu ([128.197.228.104]:55392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jdQjy-00012p-Tz
 for qemu-devel@nongnu.org; Mon, 25 May 2020 23:58:59 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04Q3w5eH020769
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 25 May 2020 23:58:08 -0400
Date: Mon, 25 May 2020 23:58:05 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH] tests/qtest/fuzz: Add direct MemoryRegion fuzzer
Message-ID: <20200526035805.hkg2zvfwoehr4vyl@mozz.bu.edu>
References: <20200525172704.32142-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200525172704.32142-1-f4bug@amsat.org>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 23:58:56
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, darren.kenny@oracle.com, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200525 1927, Philippe Mathieu-Daudé wrote:
> This is a proof-of-concept fuzzer that resolve a MemoryRegion
> Object within the fuzzed QEMU process, then directly do
> memory accesses using memory_region_dispatch_read/write calls.
> 
> We avoid first the serialization of QTest strings, then the
> FlatView resolve and AddressSpace dispatch.

Hi Phil,
This seems like a great performance win. It looks like using
device_cold_reset is an enormous gain, alone, since you don't need to
reboot the entire VM or fork. This is 10 times faster than some of my
harnesses _without_ AddressSanitizer. It would be interesting to see if
there is some way of tracking "dirty" devices so that you could
automatically reset only the devices/ram that you touch.

I am close to sending out an RFC series which tries to address DMA
inputs by hooking functions used by devices to read data from memory
(dma_read_read, address_space_ld*,...) and populating that memory with
fuzzed data just in time for the device to read it. Some inputs lead to
the e1000e performing 100k+ small DMA reads, where skipping the overhead
from qtest parsing made a big difference.

> 
> Various TODO/FIXME left.
> In particular we need to be able to parse command line argv[]
> for machine/device/region_name.
> 
> This PoC will fuzz the e1000e network device on a Q35 machine,
> bypassing the PCI bus.
> 
> Run on a single i7-8650U core, it takes less than 1min to find:
> 
>  $ time \
>    i386-softmmu/qemu-fuzz-i386 --fuzz-target=mr-fuzz \
>    -detect_leaks=0 -max_len=64 /tmp/mycorpus
>  [...]
>  #995301 REDUCE cov: 1042 ft: 3262 corp: 622/13348b lim: 64 exec/s: 23697 rss: 349Mb L: 10/64 MS: 2 CopyPart-EraseBytes-
>  #999227 REDUCE cov: 1042 ft: 3262 corp: 622/13345b lim: 64 exec/s: 23791 rss: 350Mb L: 40/64 MS: 1 EraseBytes-
>  #1024575        REDUCE cov: 1043 ft: 3272 corp: 629/13702b lim: 64 exec/s: 23827 rss: 353Mb L: 25/64 MS: 1 EraseBytes-
>  #1025436        REDUCE cov: 1043 ft: 3272 corp: 629/13699b lim: 64 exec/s: 23847 rss: 353Mb L: 39/64 MS: 1 EraseBytes-
>  qemu: hardware error: e1000e: PSRCTL.BSIZE0 cannot be zero
>  CPU #0:
>  EAX=00000000 EBX=00000000 ECX=00000000 EDX=00000663
>  ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
>  EIP=0000fff0 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
>  ES =0000 00000000 0000ffff 00009300
>  CS =f000 ffff0000 0000ffff 00009b00
>  SS =0000 00000000 0000ffff 00009300
>  DS =0000 00000000 0000ffff 00009300
>  FS =0000 00000000 0000ffff 00009300
>  GS =0000 00000000 0000ffff 00009300
>  LDT=0000 00000000 0000ffff 00008200
>  TR =0000 00000000 0000ffff 00008b00
>  GDT=     00000000 0000ffff
>  IDT=     00000000 0000ffff
>  CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
>  DR0=00000000 DR1=00000000 DR2=00000000 DR3=00000000
>  DR6=ffff0ff0 DR7=00000400
>  EFER=0000000000000000
>  FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
>  FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
>  FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
>  FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
>  FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
>  XMM00=00000000000000000000000000000000 XMM01=00000000000000000000000000000000
>  XMM02=00000000000000000000000000000000 XMM03=00000000000000000000000000000000
>  XMM04=00000000000000000000000000000000 XMM05=00000000000000000000000000000000
>  XMM06=00000000000000000000000000000000 XMM07=00000000000000000000000000000000
>  ==31659== ERROR: libFuzzer: deadly signal
>      #0 0x557a8f6f0430 in __sanitizer_print_stack_trace (i386-softmmu/qemu-fuzz-i386+0xcb1430)
>      #1 0x557a8f5ff421 in fuzzer::PrintStackTrace() (i386-softmmu/qemu-fuzz-i386+0xbc0421)
>      #2 0x557a8f5dfcaf in fuzzer::Fuzzer::CrashCallback() (i386-softmmu/qemu-fuzz-i386+0xba0caf)
>      #3 0x557a8f5dfd03 in fuzzer::Fuzzer::StaticCrashSignalCallback() (i386-softmmu/qemu-fuzz-i386+0xba0d03)
>      #4 0x7ff5aea7fc6f  (/lib64/libpthread.so.0+0x12c6f)
>      #5 0x7ff5ae8bee34 in __GI_raise (/lib64/libc.so.6+0x37e34)
>      #6 0x7ff5ae8a9894 in __GI_abort (/lib64/libc.so.6+0x22894)
>      #7 0x557a8f8bb5dd in hw_error (i386-softmmu/qemu-fuzz-i386+0xe7c5dd)
>      #8 0x557a90425f42 in e1000e_set_psrctl (i386-softmmu/qemu-fuzz-i386+0x19e6f42)
>      #9 0x557a904144df in e1000e_core_write (i386-softmmu/qemu-fuzz-i386+0x19d54df)
>      #10 0x557a9040c796 in e1000e_mmio_write (i386-softmmu/qemu-fuzz-i386+0x19cd796)
>      #11 0x557a8f8fbc67 in memory_region_write_accessor (i386-softmmu/qemu-fuzz-i386+0xebcc67)
>      #12 0x557a8f8fb7d3 in access_with_adjusted_size (i386-softmmu/qemu-fuzz-i386+0xebc7d3)
>      #13 0x557a8f8fa374 in memory_region_dispatch_write (i386-softmmu/qemu-fuzz-i386+0xebb374)
>      #14 0x557a90ef4e5f in memory_region_fuzz_one (i386-softmmu/qemu-fuzz-i386+0x24b5e5f)
>      #15 0x557a90eef1ae in memory_region_fuzz (i386-softmmu/qemu-fuzz-i386+0x24b01ae)
>      #16 0x557a90eed0d0 in LLVMFuzzerTestOneInput (i386-softmmu/qemu-fuzz-i386+0x24ae0d0)
>      #17 0x557a8f5e01b8 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) (i386-softmmu/qemu-fuzz-i386+0xba11b8)
>      #18 0x557a8f5e358e in fuzzer::Fuzzer::MutateAndTestOne() (i386-softmmu/qemu-fuzz-i386+0xba458e)
>      #19 0x557a8f5e418f in fuzzer::Fuzzer::Loop(std::vector<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, fuzzer::fuzzer_allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > > > const&) (i386-softmmu/qemu-fuzz-i386+0xba518f)
>      #20 0x557a8f5d6f91 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) (i386-softmmu/qemu-fuzz-i386+0xb97f91)
>      #21 0x557a8f5cdc76 in main (i386-softmmu/qemu-fuzz-i386+0xb8ec76)
>      #22 0x7ff5ae8aaf42 in __libc_start_main (/lib64/libc.so.6+0x23f42)
>      #23 0x557a8f5cdccd in _start (i386-softmmu/qemu-fuzz-i386+0xb8eccd)
> 
>  NOTE: libFuzzer has rudimentary signal handlers.
>        Combine libFuzzer with AddressSanitizer or similar for better crash reports.
>  SUMMARY: libFuzzer: deadly signal
>  MS: 1 CopyPart-; base unit: 5ce018d6638e560881cffa145fedad441d5ef356
>  0x0,0x46,0x0,0x26,0x0,0x1,0xe2,0x67,0x8,0x0,0x0,0x0,0x74,0x27,0x70,0x21,0x16,0xe1,0xd8,0x0,0x90,0x59,0x1e,0x0,0x27,0x70,0x21,0x0,0x74,0x27,0x70,0x21,0x16,0xe1,0xd8,0x0,0x90,0x59,0x1e,0x0,0x27,0x70,0x21,0x2b,0xe1,0xd8,0x0,0x90,0xd6,0x1e,0x0,0x27,0xa,0x1,0xaa,0xc9,0x1,0xb0,0xc0,0x0,0x0,0xda,0x56,0x68,
>  \x00F\x00&\x00\x01\xe2g\x08\x00\x00\x00t'p!\x16\xe1\xd8\x00\x90Y\x1e\x00'p!\x00t'p!\x16\xe1\xd8\x00\x90Y\x1e\x00'p!+\xe1\xd8\x00\x90\xd6\x1e\x00'\x0a\x01\xaa\xc9\x01\xb0\xc0\x00\x00\xdaVh
>  artifact_prefix='./'; Test unit written to ./crash-fafe2e3e3412d9a722b06f43bd57c3c43fe9ae99
>  Base64: AEYAJgAB4mcIAAAAdCdwIRbh2ACQWR4AJ3AhAHQncCEW4dgAkFkeACdwISvh2ACQ1h4AJwoBqskBsMAAANpWaA==
>  real    0m44.191s
>  user    0m43.696s
>  sys     0m0.624s
> 
> libFuzzer report about 24K executions of resetting device and
> processing packets in a 64 bytes input payload.
> 
> Inspired-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/qtest/fuzz/memory_region_fuzz.c | 230 ++++++++++++++++++++++++++
>  tests/qtest/fuzz/Makefile.include     |   1 +
>  2 files changed, 231 insertions(+)
>  create mode 100644 tests/qtest/fuzz/memory_region_fuzz.c
> 
> diff --git a/tests/qtest/fuzz/memory_region_fuzz.c b/tests/qtest/fuzz/memory_region_fuzz.c
> new file mode 100644
> index 0000000000..4e542d1772
> --- /dev/null
> +++ b/tests/qtest/fuzz/memory_region_fuzz.c
> @@ -0,0 +1,230 @@
> +/*
> + * MMIO Fuzzing Target
> + *
> + * Resolve MemoryRegion Object in process, then directly
> + * access it using memory_region_dispatch_read/write calls.
> + *
> + * Copyright 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/memory.h"
> +#include "hw/qdev-core.h"
> +#include "fuzz.h"
> +
> +enum {
> +    MEM8WRITE8  = 0x00,
> +    MEM8WRITE16,
> +    MEM8WRITE32,
> +    MEM8WRITE64,
> +
> +    MEM16WRITE8,
> +    MEM16WRITE16,
> +    MEM16WRITE32,
> +    MEM16WRITE64,
> +
> +    MEM32WRITE8,
> +    MEM32WRITE16,
> +    MEM32WRITE32,
> +    MEM32WRITE64,
> +
> +    MEM8READ8   = 0x10,
> +    MEM8READ16,
> +    MEM8READ32,
> +    MEM8READ64,
> +
> +    MEM16READ8,
> +    MEM16READ16,
> +    MEM16READ32,
> +    MEM16READ64,
> +
> +    MEM32READ8,
> +    MEM32READ16,
> +    MEM32READ32,
> +    MEM32READ64,
> +
> +    OP_MASK     = 0x1f
> +};
> +
> +/* We interpret the fuzzer input as a sequence of packets */
> +typedef struct {
> +    union {
> +        uint8_t opcode;
> +    };
> +    union {
> +        struct {
> +            uint8_t addr;
> +            union {
> +                uint8_t val8[8];
> +                uint16_t val16[4];
> +                uint32_t val32[2];
> +                uint64_t val64[1];
> +            };
> +        } QEMU_PACKED mem8;
> +        struct {
> +            uint16_t addr;
> +            union {
> +                uint8_t val8[8];
> +                uint16_t val16[4];
> +                uint32_t val32[2];
> +                uint64_t val64[1];
> +            };
> +        } QEMU_PACKED mem16;
> +        struct {
> +            uint32_t addr;
> +            union {
> +                uint8_t val8[8];
> +                uint16_t val16[4];
> +                uint32_t val32[2];
> +                uint64_t val64[1];
> +            };
> +        } QEMU_PACKED mem32;
> +        /* mem64 not supported */
> +    };
> +} QEMU_PACKED pkt;
> +
> +static void memory_region_fuzz_one(QTestState *s,
> +                                   DeviceState *dev,
> +                                   MemoryRegion *mr,
> +                                   const unsigned char *Data,
> +                                   size_t Size,
> +                                   bool do_not_reset)
> +{
> +    pkt *a;
> +    size_t sz;
> +    uint64_t addr;
> +    uint64_t iosize;
> +    uint64_t iomask;
> +    uint64_t rdval;
> +
> +    /* TODO check .valid.min/max_access_size */
> +
> +    iosize = memory_region_size(mr);
> +    if (iosize < 0x100) {
> +        /* 8-bit address */
> +        iosize = 0x100;
> +    } else if (iosize < 0x10000) {
> +        /* 16-bit address */
> +        iosize = 0x10000;
> +    } else {
> +        /* 32-bit address */
> +        assert(is_power_of_2(iosize));
> +    }
> +    iomask = iosize - 1;
> +
> +    if (!do_not_reset) {
> +        device_cold_reset(dev);
> +    }
> +
> +    /* process all packets */
> +    while (Size != 0) {
> +        a = (pkt *)Data;
> +        switch (a->opcode & OP_MASK) {
> +
> +        /* ugly but efficient macros... */
> +#define CASE_OP_READ(OP, OPTYPE, ADDRW, DATAW, MR) \
> +        case OP##ADDRW##READ##DATAW:\
> +            sz = sizeof(a->opcode)\
> +               + sizeof(a->OPTYPE##ADDRW.addr)\
> +               + sizeof(uint##DATAW##_t);\
> +            if (Size < sz) {\
> +                return;\
> +            }\
> +            addr = a->OPTYPE##ADDRW.addr & iomask;\
> +            memory_region_dispatch_read(MR, addr, &rdval,\
> +                                        size_memop(sizeof(uint##DATAW##_t)),\
> +                                        MEMTXATTRS_UNSPECIFIED);\
> +            break
> +#define CASE_OP_WRITE(OP, OPTYPE, ADDRW, DATAW, MR) \
> +        case OP##ADDRW##WRITE##DATAW:\
> +            sz = sizeof(a->opcode)\
> +               + sizeof(a->OPTYPE##ADDRW.addr)\
> +               + sizeof(uint##DATAW##_t);\
> +            if (Size < sz) {\
> +                return;\
> +            }\
> +            addr = a->OPTYPE##ADDRW.addr & iomask;\
> +            memory_region_dispatch_write(MR, addr,\
> +                                         a->OPTYPE##ADDRW.val##DATAW[0],\
> +                                         size_memop(sizeof(uint##DATAW##_t)),\
> +                                         MEMTXATTRS_UNSPECIFIED);\
> +            break
> +
> +        /* ... now the macro make more sense? */
> +#define CASE_MEMOP(ADDRW, DATAW) \
> +        CASE_OP_READ(MEM, mem, ADDRW, DATAW, mr);\
> +        CASE_OP_WRITE(MEM, mem, ADDRW, DATAW, mr)
> +        CASE_MEMOP(8, 8);
> +        CASE_MEMOP(8, 16);
> +        CASE_MEMOP(8, 32);
> +        CASE_MEMOP(8, 64);
> +        CASE_MEMOP(16, 8);
> +        CASE_MEMOP(16, 16);
> +        CASE_MEMOP(16, 32);
> +        CASE_MEMOP(16, 64);
> +        CASE_MEMOP(32, 8);
> +        CASE_MEMOP(32, 16);
> +        CASE_MEMOP(32, 32);
> +        CASE_MEMOP(32, 64);
> +        default:
> +            return;
> +        }
> +        Size -= sz;
> +        Data += sz;
> +    }
> +    flush_events(s);
> +}
> +
> +/* Global context, ideally instead of QTestState *s */
> +static struct {
> +    Object *dev;
> +    Object *mr;
> +    bool do_not_reset;
> +} g_ctx;
> +
> +/* FIXME get this from command line ... */
> +const char *machine_name = "q35";
> +const char *type_name = "e1000e";
> +/* FIXME enumerate and select by index? */
> +const char *mr_name = "e1000e-mmio[0]";
> +
> +static void memory_region_fuzz(QTestState *s,
> +                               const unsigned char *Data,
> +                               size_t Size)
> +{
> +
> +    if (!g_ctx.dev || !g_ctx.mr) {
> +        g_ctx.dev = object_resolve_path_type("", type_name, NULL);
> +        assert(g_ctx.dev);
> +        g_ctx.mr  = object_resolve_path_component(g_ctx.dev, mr_name);
> +        assert(g_ctx.mr);
> +    }

Should the same fuzzer be used for all regions associated with the
device (e1000e-io, e1000e-msix, pci registers)?

Do you think there should be an option to translate these ops to qtest
commands to build reproducers?

It seems that memory-region-fuzz will already do a good job for many
devices. With a main_loop(and maybe clock_step) calls, it can even cover
devices with bottom-halves. Theres a possibility that the resetting code
for some devices isn't complete, but the performance gains seem to
overshadow this.

-Alex

