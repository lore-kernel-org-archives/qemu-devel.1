Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86077C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02BBC20639
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BBC20639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBC0-00032J-VN
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1kcB5f-0003c9-1p; Mon, 09 Nov 2020 12:36:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1kcB5c-0007zX-3D; Mon, 09 Nov 2020 12:36:26 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CVJ651KqXz67JVr;
 Tue, 10 Nov 2020 01:34:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 9 Nov 2020 18:36:14 +0100
Received: from localhost (10.52.120.237) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 9 Nov 2020
 17:36:13 +0000
Date: Mon, 9 Nov 2020 17:36:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ying Fang <fangying1@huawei.com>
Subject: Re: [RFC PATCH v3 13/13] hw/arm/virt-acpi-build: Enable cpu and
 cache topology
Message-ID: <20201109173608.00007d11@Huawei.com>
In-Reply-To: <20201109030452.2197-14-fangying1@huawei.com>
References: <20201109030452.2197-1-fangying1@huawei.com>
 <20201109030452.2197-14-fangying1@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.237]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 12:36:15
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, drjones@redhat.com,
 zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, alistair.francis@wdc.com,
 imammedo@redhat.com, salil.mehta@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Nov 2020 11:04:52 +0800
Ying Fang <fangying1@huawei.com> wrote:

> A helper struct AcpiCacheOffset is introduced to describe the offset
> of three level caches. The cache hierarchy is built according to
> ACPI spec v6.3 5.2.29.2. Let's enable CPU cache topology now.
> 
> Signed-off-by: Ying Fang <fangying1@huawei.com>
> ---
>  hw/acpi/aml-build.c         | 19 +++++++++-----
>  hw/arm/virt-acpi-build.c    | 52 ++++++++++++++++++++++++++++++++-----
>  include/hw/acpi/acpi-defs.h |  6 +++++
>  include/hw/acpi/aml-build.h |  7 ++---
>  4 files changed, 68 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 1a38110149..93a81fbaf5 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1799,27 +1799,32 @@ void build_cache_hierarchy(GArray *tbl,
>  /*
>   * ACPI 6.3: 5.2.29.1 Processor hierarchy node structure (Type 0)
>   */
> -void build_socket_hierarchy(GArray *tbl, uint32_t parent, uint32_t id)
> +void build_socket_hierarchy(GArray *tbl, uint32_t parent,
> +                            uint32_t offset, uint32_t id)
>  {
>      build_append_byte(tbl, 0);          /* Type 0 - processor */
> -    build_append_byte(tbl, 20);         /* Length, no private resources */
> +    build_append_byte(tbl, 24);         /* Length, with private resources */
>      build_append_int_noprefix(tbl, 0, 2);  /* Reserved */
>      build_append_int_noprefix(tbl, 1, 4);  /* Flags: Physical package */
>      build_append_int_noprefix(tbl, parent, 4);  /* Parent */
>      build_append_int_noprefix(tbl, id, 4);     /* ACPI processor ID */
> -    build_append_int_noprefix(tbl, 0, 4);  /* Number of private resources */
> +    build_append_int_noprefix(tbl, 1, 4);  /*  Number of private resources */
> +    build_append_int_noprefix(tbl, offset, 4);  /* Private resources */
>  }
>  
> -void build_processor_hierarchy(GArray *tbl, uint32_t flags,
> -                               uint32_t parent, uint32_t id)
> +void build_processor_hierarchy(GArray *tbl, uint32_t flags, uint32_t parent,
> +                               AcpiCacheOffset offset, uint32_t id)
>  {
>      build_append_byte(tbl, 0);          /* Type 0 - processor */
> -    build_append_byte(tbl, 20);         /* Length, no private resources */
> +    build_append_byte(tbl, 32);         /* Length, with private resources */
>      build_append_int_noprefix(tbl, 0, 2);      /* Reserved */
>      build_append_int_noprefix(tbl, flags, 4);  /* Flags */
>      build_append_int_noprefix(tbl, parent, 4); /* Parent */
>      build_append_int_noprefix(tbl, id, 4);     /* ACPI processor ID */
> -    build_append_int_noprefix(tbl, 0, 4);  /* Number of private resources */
> +    build_append_int_noprefix(tbl, 3, 4);  /* Number of private resources */
> +    build_append_int_noprefix(tbl, offset.l1d_offset, 4);/* Private resources */
> +    build_append_int_noprefix(tbl, offset.l1i_offset, 4);/* Private resources */
> +    build_append_int_noprefix(tbl, offset.l2_offset, 4); /* Private resources */

So this is an interesting corner of the ACPI spec.  Do we need to include
the level 2 cache in the private resources or not?

My reading is that it is optional and we have at least one obscure bug in Linux
due to the ambiguity in the spec.  You won't hit that here for reasons found
in that thread though (cache types are different).

https://lore.kernel.org/linux-acpi/20201105174233.1146-2-shiju.jose@huawei.com/

So I suggest we make the only access to the l2 cache be via the l1 nodes
as per the example in ACPI 6.3 Figure 5.13 "Cache Type Structure - Type 1 Example"

i.e. Drop the l2 entry here and reduced the Length to 28.

Thanks,

Jonathan

>  }
>  
>  void build_smt_hierarchy(GArray *tbl, uint32_t parent, uint32_t id)
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 5784370257..ad49006b42 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -429,29 +429,69 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                   "SRAT", table_data->len - srat_start, 3, NULL, NULL);
>  }
>  
> -static void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms)
> +static inline void arm_acpi_cache_info(CPUCacheInfo *cpu_cache,
> +                                       AcpiCacheInfo *acpi_cache)
>  {
> +    acpi_cache->size = cpu_cache->size;
> +    acpi_cache->sets = cpu_cache->sets;
> +    acpi_cache->associativity = cpu_cache->associativity;
> +    acpi_cache->attributes = cpu_cache->attributes;
> +    acpi_cache->line_size = cpu_cache->line_size;
> +}
> +
> +static void build_pptt(GArray *table_data, BIOSLinker *linker,
> +                       VirtMachineState *vms)
> +{
> +    MachineState *ms = MACHINE(vms);
>      int pptt_start = table_data->len;
>      int uid = 0, cpus = 0, socket;
>      unsigned int smp_cores = ms->smp.cores;
>      unsigned int smp_threads = ms->smp.threads;
> +    AcpiCacheOffset offset;
> +    ARMCPU *cpu = ARM_CPU(qemu_get_cpu(cpus));
> +    AcpiCacheInfo cache_info;
>  
>      acpi_data_push(table_data, sizeof(AcpiTableHeader));
>  
>      for (socket = 0; cpus < ms->possible_cpus->len; socket++) {
> -        uint32_t socket_offset = table_data->len - pptt_start;
> +        uint32_t l3_offset = table_data->len - pptt_start;
> +        uint32_t socket_offset;
>          int core;
>  
> -        build_socket_hierarchy(table_data, 0, socket);
> +        /* L3 cache type structure */
> +        arm_acpi_cache_info(cpu->caches.l3_cache, &cache_info);
> +        build_cache_hierarchy(table_data, 0, &cache_info);
> +
> +        socket_offset = table_data->len - pptt_start;
> +        build_socket_hierarchy(table_data, 0, l3_offset, socket);
>  
>          for (core = 0; core < smp_cores; core++) {
>              uint32_t core_offset = table_data->len - pptt_start;
>              int thread;
>  
> +            /* L2 cache tpe structure */
> +            offset.l2_offset = table_data->len - pptt_start;
> +            arm_acpi_cache_info(cpu->caches.l2_cache, &cache_info);
> +            build_cache_hierarchy(table_data, 0, &cache_info);
> +
> +            /* L1d cache type structure */
> +            offset.l1d_offset = table_data->len - pptt_start;
> +            arm_acpi_cache_info(cpu->caches.l1d_cache, &cache_info);
> +            build_cache_hierarchy(table_data, offset.l2_offset, &cache_info);
> +
> +            /* L1i cache type structure */
> +            offset.l1i_offset = table_data->len - pptt_start;
> +            arm_acpi_cache_info(cpu->caches.l1i_cache, &cache_info);
> +            build_cache_hierarchy(table_data, offset.l2_offset, &cache_info);
> +
> +            core_offset = table_data->len - pptt_start;
>              if (smp_threads <= 1) {
> -                build_processor_hierarchy(table_data, 2, socket_offset, uid++);
> +                build_processor_hierarchy(table_data, 2, socket_offset,
> +                                          offset, uid++);
>               } else {
> -                build_processor_hierarchy(table_data, 0, socket_offset, core);
> +
> +                build_processor_hierarchy(table_data, 0, socket_offset,
> +                                          offset, core);
>                  for (thread = 0; thread < smp_threads; thread++) {
>                      build_smt_hierarchy(table_data, core_offset, uid++);
>                  }
> @@ -727,7 +767,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  
>      if (cpu_topology_enabled) {
>          acpi_add_table(table_offsets, tables_blob);
> -        build_pptt(tables_blob, tables->linker, ms);
> +        build_pptt(tables_blob, tables->linker, vms);
>      }
>  
>      acpi_add_table(table_offsets, tables_blob);
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 3df38ab449..e48b7fa506 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -626,4 +626,10 @@ typedef struct AcpiCacheInfo {
>      uint16_t line_size;
>  } AcpiCacheInfo;
>  
> +typedef struct AcpiCacheOffset {
> +    uint32_t l1d_offset;
> +    uint32_t l1i_offset;
> +    uint32_t l2_offset;
> +} AcpiCacheOffset;
> +
>  #endif
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 01078753a8..a15ccb2c91 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -440,10 +440,11 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms);
>  void build_cache_hierarchy(GArray *tbl,
>                uint32_t next_level, AcpiCacheInfo *cache_info);
>  
> -void build_socket_hierarchy(GArray *tbl, uint32_t parent, uint32_t id);
> +void build_socket_hierarchy(GArray *tbl, uint32_t parent,
> +                            uint32_t offset, uint32_t id);
>  
> -void build_processor_hierarchy(GArray *tbl, uint32_t flags,
> -                               uint32_t parent, uint32_t id);
> +void build_processor_hierarchy(GArray *tbl, uint32_t flags, uint32_t parent,
> +                               AcpiCacheOffset offset, uint32_t id);
>  
>  void build_smt_hierarchy(GArray *tbl, uint32_t parent, uint32_t id);
>  


