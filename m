Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF2FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D612218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D612218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT4PE-0005LC-8i
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 10:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT4OB-0004dY-2i
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:37:55 -0400
Received: from relay68.bu.edu ([128.197.228.73]:40254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT4O8-0008RA-M3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:37:54 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 09FEaZBa008412
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 15 Oct 2020 10:36:38 -0400
Date: Thu, 15 Oct 2020 10:36:35 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 04/16] fuzz: Add DMA support to the generic-fuzzer
Message-ID: <20201015143635.pl3ih7tcvmel4quy@mozz.bu.edu>
References: <20201015134137.205958-1-alxndr@bu.edu>
 <20201015134137.205958-5-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015134137.205958-5-alxndr@bu.edu>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:44:03
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201015 0941, Alexander Bulekov wrote:
> When a virtual-device tries to access some buffer in memory over DMA, we
> add call-backs into the fuzzer(next commit). The fuzzer checks verifies
> that the DMA request maps to a physical RAM address and fills the memory
> with fuzzer-provided data. The patterns that we use to fill this memory
> are specified using add_dma_pattern and clear_dma_patterns operations.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> ---
>  tests/qtest/fuzz/general_fuzz.c | 230 ++++++++++++++++++++++++++++++++
>  1 file changed, 230 insertions(+)
> 
> diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
> index ef754843ed..0fd42a16da 100644
> --- a/tests/qtest/fuzz/general_fuzz.c
> +++ b/tests/qtest/fuzz/general_fuzz.c
> @@ -25,6 +25,7 @@
>  #include "exec/address-spaces.h"
>  #include "hw/qdev-core.h"
>  #include "hw/pci/pci.h"
> +#include "hw/boards.h"
>  
>  /*
>   * SEPARATOR is used to separate "operations" in the fuzz input
> @@ -38,12 +39,16 @@ enum cmds {
>      OP_WRITE,
>      OP_PCI_READ,
>      OP_PCI_WRITE,
> +    OP_ADD_DMA_PATTERN,
> +    OP_CLEAR_DMA_PATTERNS,
>      OP_CLOCK_STEP,
>  };
>  
>  #define DEFAULT_TIMEOUT_US 100000
>  #define USEC_IN_SEC 100000000
>  
> +#define MAX_DMA_FILL_SIZE 0x10000
> +
>  #define PCI_HOST_BRIDGE_CFG 0xcf8
>  #define PCI_HOST_BRIDGE_DATA 0xcfc
>  
> @@ -56,6 +61,24 @@ static useconds_t timeout = 100000;
>  
>  static bool qtest_log_enabled;
>  
> +/*
> + * A pattern used to populate a DMA region or perform a memwrite. This is
> + * useful for e.g. populating tables of unique addresses.
> + * Example {.index = 1; .stride = 2; .len = 3; .data = "\x00\x01\x02"}
> + * Renders as: 00 01 02   00 03 02   00 05 02   00 07 02 ...
> + */
> +typedef struct {
> +    uint8_t index;      /* Index of a byte to increment by stride */
> +    uint8_t stride;     /* Increment each index'th byte by this amount */
> +    size_t len;
> +    const uint8_t *data;
> +} pattern;
> +
> +/* Avoid filling the same DMA region between MMIO/PIO commands ? */
> +static bool avoid_double_fetches;
> +
> +static QTestState *qts_global; /* Need a global for the DMA callback */
> +
>  /*
>   * List of memory regions that are children of QOM objects specified by the
>   * user for fuzzing.
> @@ -84,6 +107,169 @@ static int get_io_address_cb(ram_addr_t start, ram_addr_t size,
>      return 0;
>  }
>  
> +/*
> + * List of dma regions populated since the last fuzzing command. Used to ensure
> + * that we only write to each DMA address once, to avoid race conditions when
> + * building reproducers.
> + */
> +static GArray *dma_regions;
> +
> +static GArray *dma_patterns;
> +static int dma_pattern_index;
> +
> +void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write);
> +
> +/*
> + * Allocate a block of memory and populate it with a pattern.
> + */
> +static void *pattern_alloc(pattern p, size_t len)
> +{
> +    int i;
> +    uint8_t *buf = g_malloc(len);
> +    uint8_t sum = 0;
> +
> +    for (i = 0; i < len; ++i) {
> +        buf[i] = p.data[i % p.len];
> +        if ((i % p.len) == p.index) {
> +            buf[i] += sum;
> +            sum += p.stride;
> +        }
> +    }
> +    return buf;
> +}
> +
> +static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
> +{
> +    unsigned access_size_max = mr->ops->valid.max_access_size;
> +
> +    /* Regions are assumed to support 1-4 byte accesses unless
> +       otherwise specified.  */
> +    if (access_size_max == 0) {
> +        access_size_max = 4;
> +    }
> +
> +    /* Bound the maximum access by the alignment of the address.  */
> +    if (!mr->ops->impl.unaligned) {
> +        unsigned align_size_max = addr & -addr;
> +        if (align_size_max != 0 && align_size_max < access_size_max) {
> +            access_size_max = align_size_max;
> +        }
> +    }
> +
> +    /* Don't attempt accesses larger than the maximum.  */
> +    if (l > access_size_max) {
> +        l = access_size_max;
> +    }
> +    l = pow2floor(l);
> +
> +    return l;
> +}
> +
> +/*
> + * Call-back for functions that perform DMA reads from guest memory. Confirm
> + * that the region has not already been populated since the last loop in
> + * general_fuzz(), avoiding potential race-conditions, which we don't have
> + * a good way for reproducing right now.
> + */
> +void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write)
> +{
> +    /* Are we in the general-fuzzer or are we using another fuzz-target? */
> +    if (!qts_global) {
> +        return;
> +    }
> +
> +    /*
> +     * Return immediately if:
> +     * - We have no DMA patterns defined
> +     * - The length of the DMA read request is zero
> +     * - The DMA read is hitting an MR other than the machine's main RAM
> +     * - The DMA request is not a read (what happens for a address_space_map
> +     *   with is_write=True? Can the device use the same pointer to do reads?)
> +     * - The DMA request hits past the bounds of our RAM
> +     */
> +    if (dma_patterns->len == 0
> +        || len == 0
> +        || mr != MACHINE(qdev_get_machine())->ram
> +        || is_write
> +        || addr > current_machine->ram_size) {
> +        return;
> +    }
> +
> +    /*
> +     * If we overlap with any existing dma_regions, split the range and only
> +     * populate the non-overlapping parts.
> +     */
> +    address_range region;
> +    bool double_fetch = false;
> +    for (int i = 0;
> +         i < dma_regions->len && (avoid_double_fetches || qtest_log_enabled);
> +         ++i) {
> +        region = g_array_index(dma_regions, address_range, i);
> +        if (addr < region.addr + region.size && addr + len > region.addr) {
> +            double_fetch = true;
> +            if (addr < region.addr
> +                && avoid_double_fetches) {
> +                fuzz_dma_read_cb(addr, region.addr - addr, mr, is_write);
> +            }
> +            if (addr + len > region.addr + region.size
> +                && avoid_double_fetches) {
> +                fuzz_dma_read_cb(region.addr + region.size,
> +                        addr + len - (region.addr + region.size), mr, is_write);
> +            }
> +            return;
> +        }
> +    }
> +
> +    /* Cap the length of the DMA access to something reasonable */
> +    len = MIN(len, MAX_DMA_FILL_SIZE);
> +
> +    address_range ar = {addr, len};
> +    g_array_append_val(dma_regions, ar);
> +    pattern p = g_array_index(dma_patterns, pattern, dma_pattern_index);
> +    void *buf = pattern_alloc(p, ar.size);
> +    hwaddr l, addr1;
> +    MemoryRegion *mr1;
> +    uint8_t *ram_ptr;
> +    while (len > 0) {
> +        l = len;
> +        mr1 = address_space_translate(first_cpu->as,
> +                                      addr, &addr1, &l, true,
> +                                      MEMTXATTRS_UNSPECIFIED);
> +
> +        if (!(memory_region_is_ram(mr1) ||
> +              memory_region_is_romd(mr1))) {
> +            l = memory_access_size(mr1, l, addr1);
> +        } else {
> +            /* ROM/RAM case */
> +            ram_ptr = qemu_map_ram_ptr(mr1->ram_block, addr1);
> +            memcpy(ram_ptr, buf, l);
> +            break;
> +        }
> +        len -= l;
> +        buf += l;
> +        addr += l;
> +
> +    }
> +    if (qtest_log_enabled) {
> +        /*
> +         * With QTEST_LOG, use a normal, slow QTest memwrite. Prefix the log
> +         * that will be written by qtest.c with a DMA tag, so we can reorder
> +         * the resulting QTest trace so the DMA fills precede the last PIO/MMIO
> +         * command.
> +         */
> +        fprintf(stderr, "[DMA] ");
> +        if (double_fetch) {
> +            fprintf(stderr, "[DOUBLE-FETCH] ");
> +        }
> +        fflush(stderr);
> +        qtest_memwrite(qts_global, ar.addr, buf, ar.size);
> +    }
       ^^ This if statement should end  above the qtest_memwrite...
-Alex
> +    g_free(buf);
> +
> +    /* Increment the index of the pattern for the next DMA access */
> +    dma_pattern_index = (dma_pattern_index + 1) % dma_patterns->len;
> +}
> +
>  /*
>   * Here we want to convert a fuzzer-provided [io-region-index, offset] to
>   * a physical address. To do this, we iterate over all of the matched
> @@ -346,6 +532,35 @@ static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
>      }
>  }
>  
> +static void op_add_dma_pattern(QTestState *s,
> +                               const unsigned char *data, size_t len)
> +{
> +    struct {
> +        /*
> +         * index and stride can be used to increment the index-th byte of the
> +         * pattern by the value stride, for each loop of the pattern.
> +         */
> +        uint8_t index;
> +        uint8_t stride;
> +    } a;
> +
> +    if (len < sizeof(a) + 1) {
> +        return;
> +    }
> +    memcpy(&a, data, sizeof(a));
> +    pattern p = {a.index, a.stride, len - sizeof(a), data + sizeof(a)};
> +    p.index = a.index % p.len;
> +    g_array_append_val(dma_patterns, p);
> +    return;
> +}
> +
> +static void op_clear_dma_patterns(QTestState *s,
> +                                  const unsigned char *data, size_t len)
> +{
> +    g_array_set_size(dma_patterns, 0);
> +    dma_pattern_index = 0;
> +}
> +
>  static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
>  {
>      qtest_clock_step_next(s);
> @@ -405,6 +620,8 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
>          [OP_WRITE]              = op_write,
>          [OP_PCI_READ]           = op_pci_read,
>          [OP_PCI_WRITE]          = op_pci_write,
> +        [OP_ADD_DMA_PATTERN]    = op_add_dma_pattern,
> +        [OP_CLEAR_DMA_PATTERNS] = op_clear_dma_patterns,
>          [OP_CLOCK_STEP]         = op_clock_step,
>      };
>      const unsigned char *cmd = Data;
> @@ -434,6 +651,8 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
>              setitimer(ITIMER_VIRTUAL, &timer, NULL);
>          }
>  
> +        op_clear_dma_patterns(s, NULL, 0);
> +
>          while (cmd && Size) {
>              /* Get the length until the next command or end of input */
>              nextcmd = memmem(cmd, Size, SEPARATOR, strlen(SEPARATOR));
> @@ -450,6 +669,7 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
>              /* Advance to the next command */
>              cmd = nextcmd ? nextcmd + sizeof(SEPARATOR) - 1 : nextcmd;
>              Size = Size - (cmd_len + sizeof(SEPARATOR) - 1);
> +            g_array_set_size(dma_regions, 0);
>          }
>          _Exit(0);
>      } else {
> @@ -464,6 +684,9 @@ static void usage(void)
>      printf("QEMU_FUZZ_ARGS= the command line arguments passed to qemu\n");
>      printf("QEMU_FUZZ_OBJECTS= "
>              "a space separated list of QOM type names for objects to fuzz\n");
> +    printf("Optionally: QEMU_AVOID_DOUBLE_FETCH= "
> +            "Try to avoid racy DMA double fetch bugs? %d by default\n",
> +            avoid_double_fetches);
>      printf("Optionally: QEMU_FUZZ_TIMEOUT= Specify a custom timeout (us). "
>              "0 to disable. %d by default\n", timeout);
>      exit(0);
> @@ -534,9 +757,16 @@ static void general_pre_fuzz(QTestState *s)
>      if (getenv("QTEST_LOG")) {
>          qtest_log_enabled = 1;
>      }
> +    if (getenv("QEMU_AVOID_DOUBLE_FETCH")) {
> +        avoid_double_fetches = 1;
> +    }
>      if (getenv("QEMU_FUZZ_TIMEOUT")) {
>          timeout = g_ascii_strtoll(getenv("QEMU_FUZZ_TIMEOUT"), NULL, 0);
>      }
> +    qts_global = s;
> +
> +    dma_regions = g_array_new(false, false, sizeof(address_range));
> +    dma_patterns = g_array_new(false, false, sizeof(pattern));
>  
>      fuzzable_memoryregions = g_hash_table_new(NULL, NULL);
>      fuzzable_pci_devices   = g_ptr_array_new();
> -- 
> 2.28.0
> 

