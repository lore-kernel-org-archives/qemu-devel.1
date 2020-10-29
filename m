Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D10C55179
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1E120747
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/7k7fXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1E120747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYBF6-0001Sx-Gx
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 12:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kYBDw-0000qw-TD
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 12:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kYBDu-0000h1-79
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 12:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603990585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2zosFn8c1cLA7L4fC/9vqQLQF4BBj1fltziN4/t0JEE=;
 b=I/7k7fXRbjyoLCwIlobR4EiP0smT+gBsNa/3igDxATYuHAZX8GaEkZ4a9ges9giCkXiVzV
 LMabtF7R/ideHB5+e8Z1hvoJt+Vc47SAGOh9OrO2EPTpRk7dySXy0PNdffWQEi4E2gKI/R
 P6aWSlLgPivM5r4A9HE78p624Jy+aNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-vMFdWTMVNX-bGw258PU7YA-1; Thu, 29 Oct 2020 12:56:21 -0400
X-MC-Unique: vMFdWTMVNX-bGw258PU7YA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76535108E1AB;
 Thu, 29 Oct 2020 16:56:19 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F32AA196FB;
 Thu, 29 Oct 2020 16:56:16 +0000 (UTC)
Date: Thu, 29 Oct 2020 17:56:14 +0100
From: Andrew Jones <drjones@redhat.com>
To: Ying Fang <fangying1@huawei.com>
Subject: Re: [RFC PATCH v2 09/13] hw/arm/virt-acpi-build: add PPTT table
Message-ID: <20201029165614.mbwv26bnx6ntughx@kamzik.brq.redhat.com>
References: <20201020131440.1090-1-fangying1@huawei.com>
 <20201020131440.1090-10-fangying1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20201020131440.1090-10-fangying1@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, alistair.francis@wdc.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 09:14:36PM +0800, Ying Fang wrote:
> Add the Processor Properties Topology Table (PPTT) to present CPU topology
> information to the guest.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>

I don't know why I have an s-o-b here. I guess it's because this code
looks nearly identical to what I wrote, except for using the new and,
IMO, unnecessary build_socket_hierarchy and build_smt_hierarchy functions.

IMHO, you should drop the last patch and just take 

https://github.com/rhdrjones/qemu/commit/439b38d67ca1f2cbfa5b9892a822b651ebd05c11

as it is, unless it needs to be fixed somehow.

Thanks,
drew

> Signed-off-by: Ying Fang <fangying1@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c | 42 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index fae5a26741..e1f3ea50ad 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -429,6 +429,42 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                   "SRAT", table_data->len - srat_start, 3, NULL, NULL);
>  }
>  
> +static void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms)
> +{
> +    int pptt_start = table_data->len;
> +    int uid = 0, cpus = 0, socket;
> +    unsigned int smp_cores = ms->smp.cores;
> +    unsigned int smp_threads = ms->smp.threads;
> +
> +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
> +
> +    for (socket = 0; cpus < ms->possible_cpus->len; socket++) {
> +        uint32_t socket_offset = table_data->len - pptt_start;
> +        int core;
> +
> +        build_socket_hierarchy(table_data, 0, socket);
> +
> +        for (core = 0; core < smp_cores; core++) {
> +            uint32_t core_offset = table_data->len - pptt_start;
> +            int thread;
> +
> +            if (smp_threads <= 1) {
> +                build_processor_hierarchy(table_data, 2, socket_offset, uid++);
> +             } else {
> +                build_processor_hierarchy(table_data, 0, socket_offset, core);
> +                for (thread = 0; thread < smp_threads; thread++) {
> +                    build_smt_hierarchy(table_data, core_offset, uid++);
> +                }
> +             }
> +        }
> +        cpus += smp_cores * smp_threads;
> +    }
> +
> +    build_header(linker, table_data,
> +                 (void *)(table_data->data + pptt_start), "PPTT",
> +                 table_data->len - pptt_start, 2, NULL, NULL);
> +}
> +
>  /* GTDT */
>  static void
>  build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> @@ -669,6 +705,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      unsigned dsdt, xsdt;
>      GArray *tables_blob = tables->table_data;
>      MachineState *ms = MACHINE(vms);
> +    bool cpu_topology_enabled = !vmc->ignore_cpu_topology;
>  
>      table_offsets = g_array_new(false, true /* clear */,
>                                          sizeof(uint32_t));
> @@ -688,6 +725,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      acpi_add_table(table_offsets, tables_blob);
>      build_madt(tables_blob, tables->linker, vms);
>  
> +    if (cpu_topology_enabled) {
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_pptt(tables_blob, tables->linker, ms);
> +    }
> +
>      acpi_add_table(table_offsets, tables_blob);
>      build_gtdt(tables_blob, tables->linker, vms);
>  
> -- 
> 2.23.0
> 
> 


