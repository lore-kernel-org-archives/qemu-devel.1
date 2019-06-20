Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41289C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C742083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C742083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47526 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdwfR-000681-CG
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 08:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41031)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hdwZL-0001Ac-NY
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hdwGC-00089a-Gt
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:35:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hdwBD-0006LW-SG; Thu, 20 Jun 2019 08:28:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A6470301EA90;
 Thu, 20 Jun 2019 12:28:26 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B572F608A7;
 Thu, 20 Jun 2019 12:28:18 +0000 (UTC)
Date: Thu, 20 Jun 2019 14:28:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <20190620142814.7caf9c3c@redhat.com>
In-Reply-To: <1557832703-42620-5-git-send-email-gengdongjiu@huawei.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
 <1557832703-42620-5-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 20 Jun 2019 12:28:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v17 04/10] acpi: add
 build_append_ghes_generic_data() helper for Generic Error Data Entry
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

On Tue, 14 May 2019 04:18:17 -0700
Dongjiu Geng <gengdongjiu@huawei.com> wrote:

> It will help to add Generic Error Data Entry to ACPI tables
> without using packed C structures and avoid endianness
> issues as API doesn't need explicit conversion.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  hw/acpi/aml-build.c         | 32 ++++++++++++++++++++++++++++++++
>  include/hw/acpi/aml-build.h |  6 ++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index fb53f21..102a288 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -296,6 +296,38 @@ void build_append_ghes_notify(GArray *table, const uint8_t type,
>          build_append_int_noprefix(table, error_threshold_window, 4);
>  }
>  
> +/* Generic Error Data Entry
> + * ACPI 4.0: 17.3.2.6.1 Generic Error Data
> + */
> +void build_append_ghes_generic_data(GArray *table, const char *section_type,
s/build_append_ghes_generic_data/build_append_ghes_generic_error_data/

> +                                    uint32_t error_severity, uint16_t revision,
> +                                    uint8_t validation_bits, uint8_t flags,
> +                                    uint32_t error_data_length, uint8_t *fru_id,
> +                                    uint8_t *fru_text, uint64_t time_stamp)
checkpatch probably will complain due to too long lines
you can use:
void build_append_ghe...
         uint32_t error_severity, uint16_t revision,
         ...

> +{
> +    int i;
> +
> +    for (i = 0; i < 16; i++) {
> +        build_append_int_noprefix(table, section_type[i], 1);
                                            ^^^
use QemuUUID instead, see vmgenid_build_acpi

> +    }
> +
> +    build_append_int_noprefix(table, error_severity, 4);
> +    build_append_int_noprefix(table, revision, 2);
> +    build_append_int_noprefix(table, validation_bits, 1);
> +    build_append_int_noprefix(table, flags, 1);
> +    build_append_int_noprefix(table, error_data_length, 4);
> +
> +    for (i = 0; i < 16; i++) {
> +        build_append_int_noprefix(table, fru_id[i], 1);
same as section_type

> +    }
> +
> +    for (i = 0; i < 20; i++) {
> +        build_append_int_noprefix(table, fru_text[i], 1);
> +    }
instead of loop use g_array_insert_vals()

> +
> +    build_append_int_noprefix(table, time_stamp, 8);
that's not part of 'Table 17-13'
where does it come from?

> +}
> +
>  /*
>   * Build NAME(XXXX, 0x00000000) where 0x00000000 is encoded as a dword,
>   * and return the offset to 0x00000000 for runtime patching.
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 90c8ef8..a71db2f 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -419,6 +419,12 @@ void build_append_ghes_notify(GArray *table, const uint8_t type,
>                                uint32_t error_threshold_value,
>                                uint32_t error_threshold_window);
>  
> +void build_append_ghes_generic_data(GArray *table, const char *section_type,
> +                                    uint32_t error_severity, uint16_t revision,
> +                                    uint8_t validation_bits, uint8_t flags,
> +                                    uint32_t error_data_length, uint8_t *fru_id,
> +                                    uint8_t *fru_text, uint64_t time_stamp);
> +
>  void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>                         uint64_t len, int node, MemoryAffinityFlags flags);
>  


