Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA95FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258AF21473
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258AF21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFJGh-0005cT-BB
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 11:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kFJG6-0005Cz-N5
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:40:42 -0400
Received: from relay68.bu.edu ([128.197.228.73]:48739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kFJG1-0000yF-N5
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:40:42 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 087FdWm6009333
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 7 Sep 2020 11:39:38 -0400
Date: Mon, 7 Sep 2020 11:39:32 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH v2 02/15] fuzz: Add general virtual-device fuzzer
Message-ID: <20200907153932.pyzeiegsa3plzm37@mozz.bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-3-alxndr@bu.edu>
 <m2a6y8ts0n.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2a6y8ts0n.fsf@oracle.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 11:40:30
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qemu-devel@nongnu.org, f4bug@amsat.org, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200902 1103, Darren Kenny wrote:
> 
> Hi Alex,
> 
> Apologies for not taking so long to get to this.
> 
> On Wednesday, 2020-08-19 at 02:10:57 -04, Alexander Bulekov wrote:
> > This is a generic fuzzer designed to fuzz a virtual device's
> > MemoryRegions, as long as they exist within the Memory or Port IO (if it
> > exists) AddressSpaces. The fuzzer's input is interpreted into a sequence
> > of qtest commands (outb, readw, etc). The interpreted commands are
> > separated by a magic seaparator, which should be easy for the fuzzer to
> > guess. Without ASan, the separator can be specified as a "dictionary
> > value" using the -dict argument (see libFuzzer documentation).
> >
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> >  tests/qtest/fuzz/Makefile.include |   1 +
> >  tests/qtest/fuzz/general_fuzz.c   | 494 ++++++++++++++++++++++++++++++
> >  2 files changed, 495 insertions(+)
> >  create mode 100644 tests/qtest/fuzz/general_fuzz.c
> >
> > diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
> > index 5bde793bf2..854322efb6 100644
> > --- a/tests/qtest/fuzz/Makefile.include
> > +++ b/tests/qtest/fuzz/Makefile.include
> > @@ -11,6 +11,7 @@ fuzz-obj-y += tests/qtest/fuzz/qtest_wrappers.o
> >  fuzz-obj-$(CONFIG_PCI_I440FX) += tests/qtest/fuzz/i440fx_fuzz.o
> >  fuzz-obj-$(CONFIG_VIRTIO_NET) += tests/qtest/fuzz/virtio_net_fuzz.o
> >  fuzz-obj-$(CONFIG_SCSI) += tests/qtest/fuzz/virtio_scsi_fuzz.o
> > +fuzz-obj-y += tests/qtest/fuzz/general_fuzz.o
> >  
> >  FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
> >  
> > diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
> > new file mode 100644
> > index 0000000000..01bcb029b1
> > --- /dev/null
> > +++ b/tests/qtest/fuzz/general_fuzz.c
> > @@ -0,0 +1,494 @@
> > +/*
> > + * General Virtual-Device Fuzzing Target
> > + *
> > + * Copyright Red Hat Inc., 2020
> > + *
> > + * Authors:
> > + *  Alexander Bulekov   <alxndr@bu.edu>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include <wordexp.h>
> > +
> > +#include "cpu.h"
> > +#include "tests/qtest/libqtest.h"
> > +#include "fuzz.h"
> > +#include "fork_fuzz.h"
> > +#include "exec/address-spaces.h"
> > +#include "string.h"
> > +#include "exec/memory.h"
> > +#include "exec/ramblock.h"
> > +#include "exec/address-spaces.h"
> > +#include "hw/qdev-core.h"
> > +
> > +/*
> > + * SEPARATOR is used to separate "operations" in the fuzz input
> > + */
> > +#define SEPARATOR "FUZZ"
> > +
> > +enum cmds{
> > +    OP_IN,
> > +    OP_OUT,
> > +    OP_READ,
> > +    OP_WRITE,
> > +    OP_CLOCK_STEP,
> > +};
> > +
> > +#define DEFAULT_TIMEOUT_US 100000
> > +#define USEC_IN_SEC 100000000
> > +
> > +typedef struct {
> > +    size_t addr;
> > +    size_t len; /* The number of bytes until the end of the I/O region */
> > +} address_range;
> > +
> > +static useconds_t timeout = 100000;
> > +/*
> > + * List of memory regions that are children of QOM objects specified by the
> > + * user for fuzzing.
> > + */
> > +static GPtrArray *fuzzable_memoryregions;
> > +/*
> > + * Here we want to convert a fuzzer-provided [io-region-index, offset] to
> > + * a physical address. To do this, we iterate over all of the matched
> > + * MemoryRegions. Check whether each region exists within the particular io
> > + * space. Return the absolute address of the offset within the index'th region
> > + * that is a subregion of the io_space and the distance until the end of the
> > + * memory region.
> > + */
> > +static bool get_io_address(address_range *result,
> > +                                    MemoryRegion *io_space,
> > +                                    uint8_t index,
> > +                                    uint32_t offset) {
> > +    MemoryRegion *mr, *root;
> > +    index = index % fuzzable_memoryregions->len;
> > +    int candidate_regions = 0;
> > +    int i = 0;
> > +    int ind = index;
> > +    size_t abs_addr;
> > +    AddressSpace *as = (io_space == get_system_memory()) ? &address_space_memory : &address_space_io;
> > +
> > +    while (ind >= 0 && fuzzable_memoryregions->len) {
> > +        *result = (address_range){0, 0};
> > +        mr = g_ptr_array_index(fuzzable_memoryregions, i);
> > +        if (mr->enabled) {
> > +            abs_addr = mr->addr;
> > +            for (root = mr; root->container; ) {
> > +                root = root->container;
> > +                abs_addr += root->addr;
> > +            }
> > +            /*
> > +             * Only consider the region if it is rooted at the io_space we want
> > +             */
> > +            if (root == io_space) {
> > +                hwaddr xlat, len;
> > +                if(address_space_translate(as, abs_addr, &xlat, &len, true, MEMTXATTRS_UNSPECIFIED) == mr){
> > +                    ind--;
> 
> I'm wondering what is the purpose of ind, we never really do anything
> with it except possibly decrement it here and test in the while
> condition.
> 
> With candidate_regions also only being incremented here, we could just
> as easily compare that against index.
> 

Yes it is not clear. The overall idea here is:
* fuzzable_memoryregions contains regions that belong both to the
  Memory/MMIO AddressSpace and the PIO AddressSpace. 
* Thus fuzzable_mr can look like [PIO_1, MMIO_1, MMIO_2, PIO_2, PIO_3]
* If index == 4 and we want an MMIO region, we need to use that as an
  index into the sub-array of only MMIO-Type regions

I think instead, I should either
1. Have separate arrays for PIO/MMIO MRs. This will simplify this
   function, but I'm also not sure whether it is always possible to
   identify whether the mr is pio/mmio (e.g. when a PCI BAR has not yet
   been mapped)
2. Have a single read/write operation instead of in/out and read/write.
   Then, instead of differentiating between MMIO and PIO here, we could
   do that in the OP.
3. Instead of keeping track of MemoryRegions here, try instead to walk
   the corresponding "flatview" and match the memory-region pointers.

I'll try out (3) first. hopefully that will clear this up and make
everything more legible. 

> > +                    candidate_regions++;
> > +                    result->addr = abs_addr;
> > +                    if(mr->size){
> > +                        result->addr += (offset % mr->size);
> > +                    }
> > +                    result->len = mr->size-(result->addr-abs_addr);
> 
> Should we have a break here? If we don't break the look now, *result
> will be cleared again at the start of this while block, making this work
> here pointless other than counting candidate_regions and decrementing
> ind.
> 
> > +                }
> > +            }
> > +        }
> > +        ++i;
> > +        /* Loop around */
> > +        if (i == fuzzable_memoryregions->len) {
> > +            /* No enabled regions in our io_space? */
> > +            if (candidate_regions == 0) {
> > +                break;
> > +            }
> > +            i = 0;
> 
> I'm not really clear on what this block does - it resets i, only breaks
> if we've not found any candidates after reaching the end of the
> fuzzable_memoryregions array.
> 
> Overall, this while loop seems to lack a clear exit strategy, it looks
> like where it is doing today is to lopp through  all the
> fuzzable_memoryregions multiple times until ind < 0 or we simply don't
> find any candidate_regions on our first pass.
> 
> Maybe I'm missing something?
> 
> > +        }
> > +    }
> > +    return candidate_regions != 0;
> > +}
> > +static bool get_pio_address(address_range *result,
> > +                                     uint8_t index, uint16_t offset)
> > +{
> > +    /*
> > +     * PIO BARs can be set past the maximum port address (0xFFFF). Thus, result
> > +     * can contain an addr that extends past the PIO space. When we pass this
> > +     * address to qtest_in/qtest_out, it is cast to a uint16_t, so we might end
> > +     * up fuzzing a completely different MemoryRegion/Device. Therefore, check
> > +     * that the address here is within the PIO space limits.
> > +     */
> > +
> > +    bool success = get_io_address(result, get_system_io(), index, offset);
> > +    return success && result->addr <= 0xFFFF;
> > +}
> > +static bool get_mmio_address(address_range *result,
> > +                                      uint8_t index, uint32_t offset)
> > +{
> > +    return get_io_address(result, get_system_memory(), index, offset);
> > +}
> > +
> > +static void op_in(QTestState *s, const unsigned char * data, size_t len)
> > +{
> > +    enum Sizes {Byte, Word, Long, end_sizes};
> > +    struct {
> > +        uint8_t size;
> > +        uint8_t base;
> > +        uint16_t offset;
> > +    } a;
> > +    address_range abs;
> > +
> > +    if (len < sizeof(a)) {
> > +        return;
> > +    }
> > +    memcpy(&a, data, sizeof(a));
> > +    if (get_pio_address(&abs, a.base, a.offset) == 0) {
> > +        return;
> > +    }
> > +
> > +    switch (a.size %= end_sizes) {
> > +    case Byte:
> > +        qtest_inb(s, abs.addr);
> > +        break;
> > +    case Word:
> > +        if (abs.len >= 2) {
> > +            qtest_inw(s, abs.addr);
> > +        }
> > +        break;
> > +    case Long:
> > +        if (abs.len >= 4) {
> > +            qtest_inl(s, abs.addr);
> > +        }
> > +        break;
> > +    }
> > +}
> > +
> > +static void op_out(QTestState *s, const unsigned char * data, size_t len)
> > +{
> > +    enum Sizes {Byte, Word, Long, end_sizes};
> > +    struct {
> > +        uint8_t size;
> > +        uint8_t base;
> > +        uint16_t offset;
> > +        uint32_t value;
> > +    } a;
> > +    address_range abs;
> > +
> > +    if (len < sizeof(a)) {
> > +        return;
> > +    }
> > +    memcpy(&a, data, sizeof(a));
> > +
> > +    if (get_pio_address(&abs, a.base, a.offset) == 0) {
> > +        return;
> > +    }
> > +
> > +    switch (a.size %= end_sizes) {
> > +    case Byte:
> > +        qtest_outb(s, abs.addr, a.value & 0xFF);
> > +        break;
> > +    case Word:
> > +        if (abs.len >= 2) {
> > +            qtest_outw(s, abs.addr, a.value & 0xFFFF);
> > +        }
> > +        break;
> > +    case Long:
> > +        if (abs.len >= 4) {
> > +            qtest_outl(s, abs.addr, a.value);
> > +        }
> > +        break;
> > +    }
> > +}
> > +
> > +static void op_read(QTestState *s, const unsigned char * data, size_t len)
> > +{
> > +    enum Sizes {Byte, Word, Long, Quad, end_sizes};
> > +    struct {
> > +        uint8_t size;
> > +        uint8_t base;
> > +        uint32_t offset;
> > +    } a;
> > +    address_range abs;
> > +
> > +    if (len < sizeof(a)) {
> > +        return;
> > +    }
> > +    memcpy(&a, data, sizeof(a));
> > +
> > +    if (get_mmio_address(&abs, a.base, a.offset) == 0) {
> > +        return;
> > +    }
> > +
> > +    switch (a.size %= end_sizes) {
> > +    case Byte:
> > +        qtest_readb(s, abs.addr);
> > +        break;
> > +    case Word:
> > +        if (abs.len >= 2) {
> > +            qtest_readw(s, abs.addr);
> > +        }
> > +        break;
> > +    case Long:
> > +        if (abs.len >= 4) {
> > +            qtest_readl(s, abs.addr);
> > +        }
> > +        break;
> > +    case Quad:
> > +        if (abs.len >= 8) {
> > +            qtest_readq(s, abs.addr);
> > +        }
> > +        break;
> > +    }
> > +}
> > +
> > +static void op_write(QTestState *s, const unsigned char * data, size_t len)
> > +{
> > +    enum Sizes {Byte, Word, Long, Quad, end_sizes};
> > +    struct {
> > +        uint8_t size;
> > +        uint8_t base;
> > +        uint32_t offset;
> > +        uint64_t value;
> > +    } a;
> > +    address_range abs;
> > +
> > +    if (len < sizeof(a)) {
> > +        return;
> > +    }
> > +    memcpy(&a, data, sizeof(a));
> > +
> > +    if (get_mmio_address(&abs, a.base, a.offset) == 0) {
> > +        return;
> > +    }
> > +
> > +    switch (a.size %= end_sizes) {
> > +    case Byte:
> > +            qtest_writeb(s, abs.addr, a.value & 0xFF);
> > +        break;
> > +    case Word:
> > +        if (abs.len >= 2) {
> > +            qtest_writew(s, abs.addr, a.value & 0xFFFF);
> > +        }
> > +        break;
> > +    case Long:
> > +        if (abs.len >= 4) {
> > +            qtest_writel(s, abs.addr, a.value & 0xFFFFFFFF);
> > +        }
> > +        break;
> > +    case Quad:
> > +        if (abs.len >= 8) {
> > +            qtest_writeq(s, abs.addr, a.value);
> > +        }
> > +        break;
> > +    }
> > +}
> > +static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
> > +{
> > +    qtest_clock_step_next(s);
> > +}
> > +
> > +static void handle_timeout(int sig)
> > +{
> > +    if (getenv("QTEST_LOG")) {
> > +        fprintf(stderr, "[Timeout]\n");
> > +        fflush(stderr);
> > +    }
> > +    _Exit(0);
> > +}
> > +
> > +/*
> > + * Here, we interpret random bytes from the fuzzer, as a sequence of commands.
> > + * Our commands are variable-width, so we use a separator, SEPARATOR, to specify
> > + * the boundaries between commands. This is just a random 32-bit value, which
> > + * is easily identified by libfuzzer+AddressSanitizer, as long as we use
> > + * memmem. It can also be included in the fuzzer's dictionary. More details
> > + * here:
> > + * https://github.com/google/fuzzing/blob/master/docs/split-inputs.md
> > + *
> > + * As a result, the stream of bytes is converted into a sequence of commands.
> > + * In a simplified example where SEPARATOR is 0xFF:
> > + * 00 01 02 FF 03 04 05 06 FF 01 FF ...
> > + * becomes this sequence of commands:
> > + * 00 01 02    -> op00 (0102)   -> in (0102, 2)
> > + * 03 04 05 06 -> op03 (040506) -> write (040506, 3)
> > + * 01          -> op01 (-,0)    -> out (-,0)
> > + * ...
> > + *
> > + * Note here that it is the job of the individual opcode functions to check
> > + * that enough data was provided. I.e. in the last command out (,0), out needs
> > + * to check that there is not enough data provided to select an address/value
> > + * for the operation.
> > + */
> 
> Out if curiosity, do any of our corpus actually make use of the FUZZ string, or are we
> just falling back to always using the full size of the provided input?
> 

Do you mean if there is some case where "FUZZ" needs to be used as a
real value, rather than a magical separator?

Or are asking whether the fuzzer actually generates inputs with the
"FUZZ" separator?
With ASan enabled, libfuzzer immediately figures out that "FUZZ" is an
interesting string (because it instruments memmem) and starts inserting
it all over the place. Without --enable-sanitizers, I add it to a fuzzer
dictionary for the same effect (see bullet-point 1 in PATCH v2 00/15).

> > +static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
> > +{
> > +    void (*ops[]) (QTestState *s, const unsigned char* , size_t) = {
> > +        [OP_IN]                 = op_in,
> > +        [OP_OUT]                = op_out,
> > +        [OP_READ]               = op_read,
> > +        [OP_WRITE]              = op_write,
> > +        [OP_CLOCK_STEP]         = op_clock_step,
> > +    };
> > +    const unsigned char *cmd = Data;
> > +    const unsigned char *nextcmd;
> > +    size_t cmd_len;
> > +    uint8_t op;
> > +
> > +    if (fork() == 0) {
> > +        /*
> > +         * Sometimes the fuzzer will find inputs that take quite a long time to
> > +         * process. Often times, these inputs do not result in new coverage.
> > +         * Even if these inputs might be interesting, they can slow down the
> > +         * fuzzer, overall. Set a timeout to avoid hurting performance, too much
> > +         */
> > +        if (timeout) {
> > +            struct sigaction sact;
> > +            struct itimerval timer;
> > +
> > +            sigemptyset(&sact.sa_mask);
> > +            sact.sa_flags   = SA_NODEFER;
> > +            sact.sa_handler = handle_timeout;
> > +            sigaction(SIGALRM, &sact, NULL);
> > +
> > +            memset(&timer, 0, sizeof(timer));
> > +            timer.it_value.tv_sec = timeout / USEC_IN_SEC;
> > +            timer.it_value.tv_usec = timeout % USEC_IN_SEC;
> > +            setitimer(ITIMER_VIRTUAL, &timer, NULL);
> > +        }
> > +
> > +        while (cmd && Size) {
> > +            /* Get the length until the next command or end of input */
> > +            nextcmd = memmem(cmd, Size, SEPARATOR, strlen(SEPARATOR));
> > +            cmd_len = nextcmd ? nextcmd - cmd : Size;
> > +
> > +            if (cmd_len > 0) {
> > +                /* Interpret the first byte of the command as an opcode */
> > +                op = *cmd % (sizeof(ops) / sizeof((ops)[0]));
> > +                ops[op](s, cmd + 1, cmd_len - 1);
> > +
> > +                /* Run the main loop */
> > +                flush_events(s);
> > +            }
> > +            /* Advance to the next command */
> > +            cmd = nextcmd ? nextcmd + sizeof(SEPARATOR) - 1 : nextcmd;
> > +            Size = Size - (cmd_len + sizeof(SEPARATOR) - 1);
> > +        }
> > +        _Exit(0);
> > +    } else {
> > +        flush_events(s);
> > +        wait(0);
> > +    }
> > +}
> > +
> > +static void usage(void)
> > +{
> > +    printf("Please specify the following environment variables:\n");
> > +    printf("QEMU_FUZZ_ARGS= the command line arguments passed to qemu\n");
> > +    printf("QEMU_FUZZ_OBJECTS= "
> > +            "a space separated list of QOM type names for objects to fuzz\n");
> > +    printf("Optionally: QEMU_FUZZ_TIMEOUT= Specify a custom timeout (us). "
> > +            "0 to disable. %d by default\n", timeout);
> > +    exit(0);
> > +}
> > +
> > +static int locate_fuzz_memory_regions(Object *child, void *opaque)
> > +{
> > +    const char *name;
> > +    MemoryRegion *mr;
> > +    if (object_dynamic_cast(child, TYPE_MEMORY_REGION)) {
> > +        mr = MEMORY_REGION(child);
> > +        if ((memory_region_is_ram(mr) ||
> > +            memory_region_is_ram_device(mr) ||
> > +            memory_region_is_rom(mr) ||
> > +            memory_region_is_romd(mr)) == false) {
> > +            name = object_get_canonical_path_component(child);
> > +            /*
> > +             * We don't want duplicate pointers to the same MemoryRegion, so
> > +             * try to remove copies of the pointer, before adding it.
> > +             */
> > +            g_ptr_array_remove_fast(fuzzable_memoryregions, mr);
> > +            g_ptr_array_add(fuzzable_memoryregions, mr);
> > +        }
> > +    }
> > +    return 0;
> > +}
> > +static int locate_fuzz_objects(Object *child, void *opaque)
> > +{
> > +    char *pattern = opaque;
> > +    if (g_pattern_match_simple(pattern, object_get_typename(child))) {
> > +        /* Find and save ptrs to any child MemoryRegions */
> > +        object_child_foreach_recursive(child, locate_fuzz_memory_regions, NULL);
> > +    } else if (object_dynamic_cast(OBJECT(child), TYPE_MEMORY_REGION)) {
> > +        if (g_pattern_match_simple(pattern,
> > +            object_get_canonical_path_component(child))) {
> > +            MemoryRegion *mr;
> > +            mr = MEMORY_REGION(child);
> > +            if ((memory_region_is_ram(mr) ||
> > +                 memory_region_is_ram_device(mr) ||
> > +                 memory_region_is_rom(mr) ||
> > +                 memory_region_is_romd(mr)) == false) {
> > +                g_ptr_array_remove_fast(fuzzable_memoryregions, mr);
> > +                g_ptr_array_add(fuzzable_memoryregions, mr);
> > +            }
> > +        }
> > +    }
> > +    return 0;
> > +}
> > +
> > +static void general_pre_fuzz(QTestState *s)
> > +{
> > +    if (!getenv("QEMU_FUZZ_OBJECTS")) {
> > +        usage();
> > +    }
> > +    if (getenv("QEMU_FUZZ_TIMEOUT")) {
> > +        timeout = g_ascii_strtoll(getenv("QEMU_FUZZ_TIMEOUT"), NULL, 0);
> > +    }
> > +
> > +    fuzzable_memoryregions = g_ptr_array_new();
> > +    char **result = g_strsplit (getenv("QEMU_FUZZ_OBJECTS"), " ", -1);
> > +    for (int i = 0; result[i] != NULL; i++) {
> > +        printf("Matching objects by name %s\n", result[i]);
> > +        object_child_foreach_recursive(qdev_get_machine(),
> > +                                    locate_fuzz_objects,
> > +                                    result[i]);
> > +    }
> > +    g_strfreev(result);
> > +    printf("This process will try to fuzz the following MemoryRegions:\n");
> > +    for (int i = 0; i < fuzzable_memoryregions->len; i++) {
> > +        MemoryRegion *mr;
> > +        mr = g_ptr_array_index(fuzzable_memoryregions, i);
> > +        printf("  * %s (size %lx)\n",
> > +               object_get_canonical_path_component(&(mr->parent_obj)),
> > +               mr->addr);
> > +    }
> > +
> > +    if(!fuzzable_memoryregions->len){
> > +        printf("No fuzzable memory regions found...\n");
> > +        exit(0);
> 
> Possibly this should exit with a non-zero value since it probably is an
> error case?

Yes - that would certainly be useful for CI.

Thank you for your reviews, Darren!
-Alex

> 
> Thanks,
> 
> Darren.

