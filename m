Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C941CC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355A520770
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCdv2zqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355A520770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIpJB-00066m-2s
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kIpGf-0002Z0-UW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:27:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kIpGc-0005yr-TE
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600331265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AdgUiXyFHylizjD203xpzDAWwhXA5UQ0ZK7a3Tifkyc=;
 b=jCdv2zqZe1ymZyybkZOaaXi7jP3PoBTDOtiwORCJiI2KUCh+EdcsDyOV2F9S0V/bBU/ylX
 j3Zt57N/mA7B0yc9nicOG22JCTCX0VdRXAtpyAboHCPi/9DMSXylAbwC1QD6OSAcQA/Xa+
 Xu8uwRXmlKDOlwas1vObLfrDXkdXyPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-ooDbTDfqMbiFrNghCAaqGg-1; Thu, 17 Sep 2020 04:27:39 -0400
X-MC-Unique: ooDbTDfqMbiFrNghCAaqGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CE6D1008302;
 Thu, 17 Sep 2020 08:27:37 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 709637514A;
 Thu, 17 Sep 2020 08:27:34 +0000 (UTC)
Date: Thu, 17 Sep 2020 10:27:31 +0200
From: Andrew Jones <drjones@redhat.com>
To: Ying Fang <fangying1@huawei.com>
Subject: Re: [RFC PATCH 07/12] hw/acpi/aml-build: add processor hierarchy
 node structure
Message-ID: <20200917082731.yrkedm3y7j75lbaa@kamzik.brq.redhat.com>
References: <20200917032033.2020-1-fangying1@huawei.com>
 <20200917032033.2020-8-fangying1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200917032033.2020-8-fangying1@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: peter.maydell@linaro.org, Henglong Fan <fanhenglong@huawei.com>,
 zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org, alex.chen@huawei.com,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, alistair.francis@wdc.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 11:20:28AM +0800, Ying Fang wrote:
> Add the processor hierarchy node structures to build ACPI information
> for CPU topology. Three helpers are introduced:
> 
> (1) build_socket_hierarchy for socket description structure
> (2) build_processor_hierarchy for processor description structure
> (3) build_smt_hierarchy for thread (logic processor) description structure
> 
> Signed-off-by: Ying Fang <fangying1@huawei.com>
> Signed-off-by: Henglong Fan <fanhenglong@huawei.com>
> ---
>  hw/acpi/aml-build.c         | 37 +++++++++++++++++++++++++++++++++++++
>  include/hw/acpi/aml-build.h |  7 +++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index f6fbc9b95d..13eb6e1345 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1754,6 +1754,43 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms)
>                   table_data->len - slit_start, 1, NULL, NULL);
>  }
>  
> +/*
> + * ACPI 6.3: 5.2.29.1 Processor hierarchy node structure (Type 0)
> + */
> +void build_socket_hierarchy(GArray *tbl, uint32_t parent, uint32_t id)
> +{
> +    build_append_byte(tbl, 0);          /* Type 0 - processor */
> +    build_append_byte(tbl, 20);         /* Length, no private resources */
> +    build_append_int_noprefix(tbl, 0, 2);  /* Reserved */
> +    build_append_int_noprefix(tbl, 1, 4);  /* Flags: Physical package */
> +    build_append_int_noprefix(tbl, parent, 4);  /* Parent */
> +    build_append_int_noprefix(tbl, id, 4);     /* ACPI processor ID */
> +    build_append_int_noprefix(tbl, 0, 4);  /* Number of private resources */
> +}
> +
> +void build_processor_hierarchy(GArray *tbl, uint32_t flags,
> +                               uint32_t parent, uint32_t id)
> +{
> +    build_append_byte(tbl, 0);          /* Type 0 - processor */
> +    build_append_byte(tbl, 20);         /* Length, no private resources */
> +    build_append_int_noprefix(tbl, 0, 2);      /* Reserved */
> +    build_append_int_noprefix(tbl, flags, 4);  /* Flags */
> +    build_append_int_noprefix(tbl, parent, 4); /* Parent */
> +    build_append_int_noprefix(tbl, id, 4);     /* ACPI processor ID */
> +    build_append_int_noprefix(tbl, 0, 4);  /* Number of private resources */
> +}

I see you took this from
https://patchwork.ozlabs.org/project/qemu-devel/patch/20180704124923.32483-6-drjones@redhat.com/
(even though you neglected to mention that)

I've tweaked my implementation of it slightly per Igor's comments for the
refresh. See build_processor_hierarchy_node() in
https://github.com/rhdrjones/qemu/commit/439b38d67ca1f2cbfa5b9892a822b651ebd05c11

> +
> +void build_smt_hierarchy(GArray *tbl, uint32_t parent, uint32_t id)
> +{
> +    build_append_byte(tbl, 0);            /* Type 0 - processor */
> +    build_append_byte(tbl, 20);           /* Length, add private resources */
> +    build_append_int_noprefix(tbl, 0, 2); /* Reserved */
> +    build_append_int_noprefix(tbl, 0x0e, 4);    /* Processor is a thread */
> +    build_append_int_noprefix(tbl, parent , 4); /* parent */
> +    build_append_int_noprefix(tbl, id, 4);      /* ACPI processor ID */
> +    build_append_int_noprefix(tbl, 0, 4);       /* Num of private resources */
> +}
> +
>  /* build rev1/rev3/rev5.1 FADT */
>  void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>                  const char *oem_id, const char *oem_table_id)
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index d27da03d64..ff4c6a38f3 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -435,6 +435,13 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>  
>  void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms);
>  
> +void build_socket_hierarchy(GArray *tbl, uint32_t parent, uint32_t id);
> +
> +void build_processor_hierarchy(GArray *tbl, uint32_t flags,
> +                               uint32_t parent, uint32_t id);
> +
> +void build_smt_hierarchy(GArray *tbl, uint32_t parent, uint32_t id);

Why add build_socket_hierarchy() and build_smt_hierarchy() ?

> +
>  void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>                  const char *oem_id, const char *oem_table_id);
>  
> -- 
> 2.23.0
> 

Thanks,
drew


