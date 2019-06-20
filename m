Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F4BC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DED2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DED2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdwem-0005ZT-SO
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 08:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40455)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hdwYU-0000TH-1K
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hdwPW-0005dA-PR
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:43:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hdwPH-00050u-1o; Thu, 20 Jun 2019 08:43:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 87215307D866;
 Thu, 20 Jun 2019 12:43:07 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 470F95C205;
 Thu, 20 Jun 2019 12:43:02 +0000 (UTC)
Date: Thu, 20 Jun 2019 14:42:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <20190620144257.7400b0a7@redhat.com>
In-Reply-To: <1557832703-42620-6-git-send-email-gengdongjiu@huawei.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
 <1557832703-42620-6-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 20 Jun 2019 12:43:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v17 05/10] acpi: add
 build_append_ghes_generic_status() helper for Generic Error Status Block
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 linuxarm@huawei.com, shannon.zhaosl@gmail.com, zhengxiang9@huawei.com,
 qemu-arm@nongnu.org, james.morse@arm.com, xuwei5@huawei.com,
 jonathan.cameron@huawei.com, pbonzini@redhat.com, lersek@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 May 2019 04:18:18 -0700
Dongjiu Geng <gengdongjiu@huawei.com> wrote:

> It will help to add Generic Error Status Block to ACPI tables
> without using packed C structures and avoid endianness
> issues as API doesn't need explicit conversion.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  hw/acpi/aml-build.c         | 14 ++++++++++++++
>  include/hw/acpi/aml-build.h |  6 ++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 102a288..ce90970 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -296,6 +296,20 @@ void build_append_ghes_notify(GArray *table, const uint8_t type,
>          build_append_int_noprefix(table, error_threshold_window, 4);
>  }
>  
> +/* Generic Error Status Block
> + * ACPI 4.0: 17.3.2.6.1 Generic Error Data
> + */
> +void build_append_ghes_generic_status(GArray *table, uint32_t block_status,
maybe ..._generic_error_status???

> +                      uint32_t raw_data_offset, uint32_t raw_data_length,
> +                      uint32_t data_length, uint32_t error_severity)
see CODING_STYLE, 1.1 Multiline Indent

> +{
when describing filds from spec try to add 'verbatim' copy of the name from spec
so it would be esy to grep for it. Like:
       /* Block Status */
> +    build_append_int_noprefix(table, block_status, 4);
       /* Raw Data Offset */

note applies all other places where you compose ACPI tables

> +    build_append_int_noprefix(table, raw_data_offset, 4);
> +    build_append_int_noprefix(table, raw_data_length, 4);
> +    build_append_int_noprefix(table, data_length, 4);
> +    build_append_int_noprefix(table, error_severity, 4);
> +}
> +
>  /* Generic Error Data Entry
>   * ACPI 4.0: 17.3.2.6.1 Generic Error Data
>   */
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index a71db2f..1ec7e1b 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -425,6 +425,12 @@ void build_append_ghes_generic_data(GArray *table, const char *section_type,
>                                      uint32_t error_data_length, uint8_t *fru_id,
>                                      uint8_t *fru_text, uint64_t time_stamp);
>  
> +void
> +build_append_ghes_generic_status(GArray *table, uint32_t block_status,
> +                                 uint32_t raw_data_offset,
> +                                 uint32_t raw_data_length,
> +                                 uint32_t data_length, uint32_t error_severity);
this and previous patch, it might be better to to move declaration
to its own header, for example to include/hw/acpi/acpi_ghes.h
that you are adding later in the series.
And maybe move helpers to hw/acpi/acpi_ghes.c
They are not really independent ACPI primitives that are shared
with other tables, aren't they?
.
> +
>  void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>                         uint64_t len, int node, MemoryAffinityFlags flags);
>  


