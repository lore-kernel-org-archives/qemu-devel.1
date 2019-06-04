Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A02C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 15:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E365F2067C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 15:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E365F2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYB15-0005we-0J
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 11:06:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hYB07-0005WN-C1
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hYB00-00080p-0w
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:05:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hYAzz-0007wH-Fb
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:05:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF8F230860A4;
	Tue,  4 Jun 2019 15:05:05 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 87D4519C69;
	Tue,  4 Jun 2019 15:05:01 +0000 (UTC)
Date: Tue, 4 Jun 2019 17:04:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190604170456.5b3c198e@redhat.com>
In-Reply-To: <20190508061726.27631-8-tao3.xu@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
	<20190508061726.27631-8-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 04 Jun 2019 15:05:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 07/11] hmat acpi: Build Memory Side
 Cache Information Structure(s) in ACPI HMAT
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, jingqi.liu@intel.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  8 May 2019 14:17:22 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> From: Liu Jingqi <jingqi.liu@intel.com>
> 
> This structure describes memory side cache information for memory
> proximity domains if the memory side cache is present and the
> physical device(SMBIOS handle) forms the memory side cache.
> The software could use this information to effectively place
> the data in memory to maximize the performance of the system
> memory that use the memory side cache.
> 
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> Changes in v4 -> v3:
>     - use build_append_int_noprefix() to build Memory Side Cache
>     Information Structure(s) tables (Igor)
>     - move globals (hmat_cache_info) into MachineState (Igor)
>     - move hmat_build_cache() inside of hmat_build_hma() (Igor)
> ---
>  hw/acpi/hmat.c          | 50 ++++++++++++++++++++++++++++++++++++++++-
>  hw/acpi/hmat.h          | 25 +++++++++++++++++++++
>  include/hw/boards.h     |  3 +++
>  include/qemu/typedefs.h |  1 +
>  include/sysemu/sysemu.h |  8 +++++++
>  5 files changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> index 54aabf77eb..3a8c41162d 100644
> --- a/hw/acpi/hmat.c
> +++ b/hw/acpi/hmat.c
> @@ -102,10 +102,11 @@ static void hmat_build_hma(GArray *table_data, MachineState *ms)
>  {
>      GSList *device_list = NULL;
>      uint64_t mem_base, mem_len;
> -    int i, j, hrchy, type;
> +    int i, j, hrchy, type, level;
>      uint32_t mem_ranges_num = ms->numa_state->mem_ranges_num;
>      NumaMemRange *mem_ranges = ms->numa_state->mem_ranges;
>      HMAT_LB_Info *numa_hmat_lb;
> +    HMAT_Cache_Info *numa_hmat_cache = NULL;
>  
>      PCMachineState *pcms = PC_MACHINE(ms);
>      AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
> @@ -212,6 +213,53 @@ static void hmat_build_hma(GArray *table_data, MachineState *ms)
>              }
>          }
>      }
> +
> +    /* Build HMAT Memory Side Cache Information. */
> +    for (i = 0; i < ms->numa_state->num_nodes; i++) {
> +        for (level = 0; level <= MAX_HMAT_CACHE_LEVEL; level++) {
> +            numa_hmat_cache = ms->numa_state->hmat_cache[i][level];
> +            if (numa_hmat_cache) {
> +                uint16_t n = numa_hmat_cache->num_smbios_handles;


> +                uint32_t cache_attr = HMAT_CACHE_TOTAL_LEVEL(
> +                                      numa_hmat_cache->total_levels);
> +                cache_attr |= HMAT_CACHE_CURRENT_LEVEL(
> +                              numa_hmat_cache->level);
> +                cache_attr |= HMAT_CACHE_ASSOC(
> +                                          numa_hmat_cache->associativity);
> +                cache_attr |= HMAT_CACHE_WRITE_POLICY(
> +                                          numa_hmat_cache->write_policy);
> +                cache_attr |= HMAT_CACHE_LINE_SIZE(
> +                                          numa_hmat_cache->line_size);
I don't see a merit of hiding bitfield manipulation behind macro
I'd suggest to drop macros here and mask+shift data here.

> +                cache_attr = cpu_to_le32(cache_attr);
> +
> +                /* Memory Side Cache Information Structure */
> +                /* Type */
> +                build_append_int_noprefix(table_data, 2, 2);
> +                /* Reserved */
> +                build_append_int_noprefix(table_data, 0, 2);
> +                /* Length */
> +                build_append_int_noprefix(table_data, 32 + 2 * n, 4);
> +                /* Proximity Domain for the Memory */
> +                build_append_int_noprefix(table_data,
> +                                          numa_hmat_cache->mem_proximity, 4);
> +                /* Reserved */
> +                build_append_int_noprefix(table_data, 0, 4);
> +                /* Memory Side Cache Size */
> +                build_append_int_noprefix(table_data,
> +                                          numa_hmat_cache->size, 8);
> +                /* Cache Attributes */
> +                build_append_int_noprefix(table_data, cache_attr, 4);
> +                /* Reserved */
> +                build_append_int_noprefix(table_data, 0, 2);
> +                /* Number of SMBIOS handles (n) */
> +                build_append_int_noprefix(table_data, n, 2);
> +
> +                /* SMBIOS Handles */
> +                /* TBD: set smbios handles */
> +                build_append_int_noprefix(table_data, 0, 2 * n);
Is memory side cache structure useful at all without pointing to SMBIOS entries?

> +            }
> +        }
> +    }
>  }
>  
>  void hmat_build_acpi(GArray *table_data, BIOSLinker *linker, MachineState *ms)
> diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
> index f37e30e533..8f563f19dd 100644
> --- a/hw/acpi/hmat.h
> +++ b/hw/acpi/hmat.h
> @@ -77,6 +77,31 @@ struct HMAT_LB_Info {
>      uint16_t    bandwidth[MAX_NODES][MAX_NODES];
>  };
>  
> +struct HMAT_Cache_Info {
> +    /* The memory proximity domain to which the memory belongs. */
> +    uint32_t    mem_proximity;
> +    /* Size of memory side cache in bytes. */
> +    uint64_t    size;
> +    /*
> +     * Total cache levels for this memory
> +     * pr#include "hw/acpi/aml-build.h"oximity domain.
> +     */
> +    uint8_t     total_levels;
> +    /* Cache level described in this structure. */
> +    uint8_t     level;
> +    /* Cache Associativity: None/Direct Mapped/Comple Cache Indexing */
> +    uint8_t     associativity;
> +    /* Write Policy: None/Write Back(WB)/Write Through(WT) */
> +    uint8_t     write_policy;
> +    /* Cache Line size in bytes. */
> +    uint16_t    line_size;
> +    /*
> +     * Number of SMBIOS handles that contributes to
> +     * the memory side cache physical devices.
> +     */
> +    uint16_t    num_smbios_handles;
> +};
> +
>  void hmat_build_acpi(GArray *table_data, BIOSLinker *linker, MachineState *ms);
>  
>  #endif
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index e0169b0a64..8609f923d9 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -266,6 +266,9 @@ typedef struct NumaState {
>  
>      /* NUMA modes HMAT Locality Latency and Bandwidth Information */
>      HMAT_LB_Info *hmat_lb[HMAT_LB_LEVELS][HMAT_LB_TYPES];
> +
> +    /* Memory Side Cache Information Structure */
> +    HMAT_Cache_Info *hmat_cache[MAX_NODES][MAX_HMAT_CACHE_LEVEL + 1];
>  } NumaState;
>  
>  /**
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index c0257e936b..d971f5109e 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -33,6 +33,7 @@ typedef struct FWCfgEntry FWCfgEntry;
>  typedef struct FWCfgIoState FWCfgIoState;
>  typedef struct FWCfgMemState FWCfgMemState;
>  typedef struct FWCfgState FWCfgState;
> +typedef struct HMAT_Cache_Info HMAT_Cache_Info;
>  typedef struct HMAT_LB_Info HMAT_LB_Info;
>  typedef struct HVFX86EmulatorState HVFX86EmulatorState;
>  typedef struct I2CBus I2CBus;
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index da51a9bc26..0cfb387887 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -143,9 +143,17 @@ enum {
>      HMAT_LB_DATA_WRITE_BANDWIDTH  = 5,
>  };
>  
> +#define MAX_HMAT_CACHE_LEVEL        3
> +
>  #define HMAT_LB_LEVELS    (HMAT_LB_MEM_CACHE_3RD_LEVEL + 1)
>  #define HMAT_LB_TYPES     (HMAT_LB_DATA_WRITE_BANDWIDTH + 1)
>  
> +#define HMAT_CACHE_TOTAL_LEVEL(level)      (level & 0xF)
> +#define HMAT_CACHE_CURRENT_LEVEL(level)    ((level & 0xF) << 4)
> +#define HMAT_CACHE_ASSOC(assoc)            ((assoc & 0xF) << 8)
> +#define HMAT_CACHE_WRITE_POLICY(policy)    ((policy & 0xF) << 12)
> +#define HMAT_CACHE_LINE_SIZE(size)         ((size & 0xFFFF) << 16)
> +
>  #define MAX_OPTION_ROMS 16
>  typedef struct QEMUOptionRom {
>      const char *name;


