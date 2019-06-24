Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B51CC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13EA220674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EA220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50022 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfN9I-0007sW-Cs
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 07:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59216)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hfN35-0003gM-Qn
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hfN34-00010E-9U
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:22:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hfN30-0000qw-US; Mon, 24 Jun 2019 07:22:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B8A61368FF;
 Mon, 24 Jun 2019 11:21:59 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CD8B608D0;
 Mon, 24 Jun 2019 11:21:53 +0000 (UTC)
Date: Mon, 24 Jun 2019 13:21:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <20190624132149.3c79fadc@redhat.com>
In-Reply-To: <1557832703-42620-4-git-send-email-gengdongjiu@huawei.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
 <1557832703-42620-4-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 24 Jun 2019 11:22:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v17 03/10] acpi: add
 build_append_ghes_notify() helper for Hardware Error Notification
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

On Tue, 14 May 2019 04:18:16 -0700
Dongjiu Geng <gengdongjiu@huawei.com> wrote:

> It will help to add Hardware Error Notification to ACPI tables
> without using packed C structures and avoid endianness
> issues as API doesn't need explicit conversion.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  hw/acpi/aml-build.c         | 22 ++++++++++++++++++++++
>  include/hw/acpi/aml-build.h |  8 ++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 555c24f..fb53f21 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -274,6 +274,28 @@ void build_append_gas(GArray *table, AmlAddressSpace as,
>      build_append_int_noprefix(table, address, 8);
>  }
>  
> +/* Hardware Error Notification
> + * ACPI 4.0: 17.3.2.7 Hardware Error Notification
> + */
> +void build_append_ghes_notify(GArray *table, const uint8_t type,
> +                              uint8_t length, uint16_t config_write_enable,
> +                              uint32_t poll_interval, uint32_t vector,
> +                              uint32_t polling_threshold_value,
> +                              uint32_t polling_threshold_window,
> +                              uint32_t error_threshold_value,
> +                              uint32_t error_threshold_window)
> +{
> +        build_append_int_noprefix(table, type, 1); /* type */
comment should be verbatim copy from spec, in this case /* Type */
also do the same for other fields below

other than that patch looks good to me

> +        build_append_int_noprefix(table, length, 1);
> +        build_append_int_noprefix(table, config_write_enable, 2);
> +        build_append_int_noprefix(table, poll_interval, 4);
> +        build_append_int_noprefix(table, vector, 4);
> +        build_append_int_noprefix(table, polling_threshold_value, 4);
> +        build_append_int_noprefix(table, polling_threshold_window, 4);
> +        build_append_int_noprefix(table, error_threshold_value, 4);
> +        build_append_int_noprefix(table, error_threshold_window, 4);
> +}
> +
>  /*
>   * Build NAME(XXXX, 0x00000000) where 0x00000000 is encoded as a dword,
>   * and return the offset to 0x00000000 for runtime patching.
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 1a563ad..90c8ef8 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -411,6 +411,14 @@ build_append_gas_from_struct(GArray *table, const struct AcpiGenericAddress *s)
>                       s->access_width, s->address);
>  }
>  
> +void build_append_ghes_notify(GArray *table, const uint8_t type,
> +                              uint8_t length, uint16_t config_write_enable,
> +                              uint32_t poll_interval, uint32_t vector,
> +                              uint32_t polling_threshold_value,
> +                              uint32_t polling_threshold_window,
> +                              uint32_t error_threshold_value,
> +                              uint32_t error_threshold_window);
> +
>  void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>                         uint64_t len, int node, MemoryAffinityFlags flags);
>  


