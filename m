Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CE5C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 14:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C00523D82
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 14:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C00523D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53551 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYAgR-0000hf-CE
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 10:45:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hYAfT-0000HB-5R
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hYAfR-0001rS-Es
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:44:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hYAfR-0001oq-6k
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:44:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 438C130C132F;
	Tue,  4 Jun 2019 14:43:49 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D989019C69;
	Tue,  4 Jun 2019 14:43:43 +0000 (UTC)
Date: Tue, 4 Jun 2019 16:43:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190604164339.5e1cfd39@redhat.com>
In-Reply-To: <20190508061726.27631-7-tao3.xu@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
	<20190508061726.27631-7-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 04 Jun 2019 14:43:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 06/11] hmat acpi: Build System Locality
 Latency and Bandwidth Information Structure(s) in ACPI HMAT
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

On Wed,  8 May 2019 14:17:21 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> From: Liu Jingqi <jingqi.liu@intel.com>
> 
> This structure describes the memory access latency and bandwidth
> information from various memory access initiator proximity domains.
> The latency and bandwidth numbers represented in this structure
> correspond to rated latency and bandwidth for the platform.
> The software could use this information as hint for optimization.
> 
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> Changes in v4 -> v3:
>     - use build_append_int_noprefix() to build System Locality Latency
>     and Bandwidth Information Structure(s) tables (Igor)
>     - move globals (hmat_lb_info) into MachineState (Igor)
>     - move hmat_build_lb() inside of hmat_build_hma() (Igor)
> ---
>  hw/acpi/hmat.c          | 97 ++++++++++++++++++++++++++++++++++++++++-
>  hw/acpi/hmat.h          | 39 +++++++++++++++++
>  include/hw/boards.h     |  3 ++
>  include/qemu/typedefs.h |  1 +
>  include/sysemu/sysemu.h | 22 ++++++++++
>  5 files changed, 161 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> index bffe453280..54aabf77eb 100644
> --- a/hw/acpi/hmat.c
> +++ b/hw/acpi/hmat.c
> @@ -29,6 +29,9 @@
>  #include "hw/acpi/hmat.h"
>  #include "hw/nvram/fw_cfg.h"
>  
> +static uint32_t initiator_pxm[MAX_NODES], target_pxm[MAX_NODES];
> +static uint32_t num_initiator, num_target;
> +
>  /* Build Memory Subsystem Address Range Structure */
>  static void build_hmat_spa(GArray *table_data, MachineState *ms,
>                             uint64_t base, uint64_t length, int node)
> @@ -77,6 +80,20 @@ static int pc_dimm_device_list(Object *obj, void *opaque)
>      return 0;
>  }
>  
> +static void classify_proximity_domains(MachineState *ms)
> +{
> +    int node;
> +
> +    for (node = 0; node < ms->numa_state->num_nodes; node++) {
> +        if (ms->numa_state->nodes[node].is_initiator) {
> +            initiator_pxm[num_initiator++] = node;
> +        }
> +        if (ms->numa_state->nodes[node].is_target) {
> +            target_pxm[num_target++] = node;
> +        }
> +    }
> +}
> +
>  /*
>   * The Proximity Domain of System Physical Address ranges defined
>   * in the HMAT, NFIT and SRAT tables shall match each other.
> @@ -85,9 +102,10 @@ static void hmat_build_hma(GArray *table_data, MachineState *ms)
>  {
>      GSList *device_list = NULL;
>      uint64_t mem_base, mem_len;
> -    int i;
> +    int i, j, hrchy, type;
>      uint32_t mem_ranges_num = ms->numa_state->mem_ranges_num;
>      NumaMemRange *mem_ranges = ms->numa_state->mem_ranges;
> +    HMAT_LB_Info *numa_hmat_lb;
>  
>      PCMachineState *pcms = PC_MACHINE(ms);
>      AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
> @@ -117,6 +135,83 @@ static void hmat_build_hma(GArray *table_data, MachineState *ms)
>          i = object_property_get_uint(OBJECT(dimm), PC_DIMM_NODE_PROP, NULL);
>          build_hmat_spa(table_data, ms, mem_base, mem_len, i);
>      }
> 

Considering below part is sufficiently big, I'd move it into separate function
ex: build_hmat_lb()

> +    if (!num_initiator && !num_target) {
> +        classify_proximity_domains(ms);
This part I'd just inline instead of it being a separate function
and make initiator_pxm,target_pxm,num_initiator,num_target local variables
instead of globals. (is there a reason why they weren't made locals?)

> +    }
> +
> +    /* Build HMAT System Locality Latency and Bandwidth Information. */
> +    for (hrchy = HMAT_LB_MEM_MEMORY;
> +         hrchy <= HMAT_LB_MEM_CACHE_3RD_LEVEL; hrchy++) {
> +        for (type = HMAT_LB_DATA_ACCESS_LATENCY;
> +             type <= HMAT_LB_DATA_WRITE_BANDWIDTH; type++) {
> +            numa_hmat_lb = ms->numa_state->hmat_lb[hrchy][type];
> +
> +            if (numa_hmat_lb) {
> +                uint32_t s = num_initiator;
> +                uint32_t t = num_target;
> +                uint8_t m, n;
> +
> +                /* Type */
> +                build_append_int_noprefix(table_data, 1, 2);
> +                /* Reserved */
> +                build_append_int_noprefix(table_data, 0, 2);
> +                /* Length */
> +                build_append_int_noprefix(table_data,
> +                                          32 + 4 * s + 4 * t + 2 * s * t, 4);
> +                /* Flags */
> +                build_append_int_noprefix(table_data,
> +                                          numa_hmat_lb->hierarchy, 1);
> +                /* Data Type */
> +                build_append_int_noprefix(table_data,
> +                                          numa_hmat_lb->data_type, 1);
> +                /* Reserved */
> +                build_append_int_noprefix(table_data, 0, 2);
> +                /* Number of Initiator Proximity Domains (s) */
> +                build_append_int_noprefix(table_data, s, 4);
> +                /* Number of Target Proximity Domains (t) */
> +                build_append_int_noprefix(table_data, t, 4);
> +                /* Reserved */
> +                build_append_int_noprefix(table_data, 0, 4);
> +
> +                /* Entry Base Unit */
> +                if (type <= HMAT_LB_DATA_WRITE_LATENCY) {
> +                    build_append_int_noprefix(table_data,
> +                                              numa_hmat_lb->base_lat, 8);
> +                } else {
> +                    build_append_int_noprefix(table_data,
> +                                              numa_hmat_lb->base_bw, 8);
> +                }
> +
> +                /* Initiator Proximity Domain List */
> +                for (i = 0; i < s; i++) {
> +                    build_append_int_noprefix(table_data, initiator_pxm[i], 4);
> +                }
> +
> +                /* Target Proximity Domain List */
> +                for (i = 0; i < t; i++) {
> +                    build_append_int_noprefix(table_data, target_pxm[i], 4);
> +                }
> +
> +                /* Latency or Bandwidth Entries */
> +                for (i = 0; i < s; i++) {
> +                    m = initiator_pxm[i];
> +                    for (j = 0; j < t; j++) {
> +                        n = target_pxm[j];
> +                        uint16_t entry;
> +
> +                        if (type <= HMAT_LB_DATA_WRITE_LATENCY) {
> +                            entry = numa_hmat_lb->latency[m][n];
> +                        } else {
> +                            entry = numa_hmat_lb->bandwidth[m][n];
> +                        }
> +
> +                        build_append_int_noprefix(table_data, entry, 2);
> +                    }
> +                }
> +            }
> +        }
> +    }
>  }
>  
>  void hmat_build_acpi(GArray *table_data, BIOSLinker *linker, MachineState *ms)
> diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
> index 4f480c1e43..f37e30e533 100644
> --- a/hw/acpi/hmat.h
> +++ b/hw/acpi/hmat.h
> @@ -38,6 +38,45 @@ enum {
>      HMAT_SPA_RESERVATION_HINT = 0x4,
>  };
>  
> +struct HMAT_LB_Info {
> +    /*
> +     * Indicates total number of Proximity Domains
> +     * that can initiate memory access requests.
> +     */
> +    uint32_t    num_initiator;
> +    /*
> +     * Indicates total number of Proximity Domains
> +     * that can act as target.
> +     */
> +    uint32_t    num_target;
> +    /*
> +     * Indicates it's memory or
> +     * the specified level memory side cache.
> +     */
> +    uint8_t     hierarchy;
> +    /*
> +     * Present the type of data,
> +     * access/read/write latency or bandwidth.
> +     */
> +    uint8_t     data_type;
> +    /* The base unit for latency in nanoseconds. */
> +    uint64_t    base_lat;
> +    /* The base unit for bandwidth in megabytes per second(MB/s). */
> +    uint64_t    base_bw;
> +    /*
> +     * latency[i][j]:
> +     * Indicates the latency based on base_lat
> +     * from Initiator Proximity Domain i to Target Proximity Domain j.
> +     */
> +    uint16_t    latency[MAX_NODES][MAX_NODES];
> +    /*
> +     * bandwidth[i][j]:
> +     * Indicates the bandwidth based on base_bw
> +     * from Initiator Proximity Domain i to Target Proximity Domain j.
> +     */
> +    uint16_t    bandwidth[MAX_NODES][MAX_NODES];
> +};
> +
>  void hmat_build_acpi(GArray *table_data, BIOSLinker *linker, MachineState *ms);
>  
>  #endif
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index d392634e08..e0169b0a64 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -263,6 +263,9 @@ typedef struct NumaState {
>  
>      /* NUMA memory ranges */
>      NumaMemRange mem_ranges[MAX_NODES + 2];
> +
> +    /* NUMA modes HMAT Locality Latency and Bandwidth Information */
> +    HMAT_LB_Info *hmat_lb[HMAT_LB_LEVELS][HMAT_LB_TYPES];
>  } NumaState;
>  
>  /**
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index fcdaae58c4..c0257e936b 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -33,6 +33,7 @@ typedef struct FWCfgEntry FWCfgEntry;
>  typedef struct FWCfgIoState FWCfgIoState;
>  typedef struct FWCfgMemState FWCfgMemState;
>  typedef struct FWCfgState FWCfgState;
> +typedef struct HMAT_LB_Info HMAT_LB_Info;
>  typedef struct HVFX86EmulatorState HVFX86EmulatorState;
>  typedef struct I2CBus I2CBus;
>  typedef struct I2SCodec I2SCodec;
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 5f133cae83..da51a9bc26 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -124,6 +124,28 @@ extern int mem_prealloc;
>  #define NUMA_DISTANCE_MAX         254
>  #define NUMA_DISTANCE_UNREACHABLE 255
>  
> +/* the value of AcpiHmatLBInfo flags */
> +enum {
> +    HMAT_LB_MEM_MEMORY           = 0,
> +    HMAT_LB_MEM_CACHE_LAST_LEVEL = 1,
> +    HMAT_LB_MEM_CACHE_1ST_LEVEL  = 2,
> +    HMAT_LB_MEM_CACHE_2ND_LEVEL  = 3,
> +    HMAT_LB_MEM_CACHE_3RD_LEVEL  = 4,
> +};
> +
> +/* the value of AcpiHmatLBInfo data type */
> +enum {
> +    HMAT_LB_DATA_ACCESS_LATENCY   = 0,
> +    HMAT_LB_DATA_READ_LATENCY     = 1,
> +    HMAT_LB_DATA_WRITE_LATENCY    = 2,
> +    HMAT_LB_DATA_ACCESS_BANDWIDTH = 3,
> +    HMAT_LB_DATA_READ_BANDWIDTH   = 4,
> +    HMAT_LB_DATA_WRITE_BANDWIDTH  = 5,
> +};
> +
> +#define HMAT_LB_LEVELS    (HMAT_LB_MEM_CACHE_3RD_LEVEL + 1)
> +#define HMAT_LB_TYPES     (HMAT_LB_DATA_WRITE_BANDWIDTH + 1)
>  #define MAX_OPTION_ROMS 16
>  typedef struct QEMUOptionRom {
>      const char *name;


