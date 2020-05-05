Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DDCC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2878206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJTuGyYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2878206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyba-0008JR-T9
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVyas-0007s2-K2
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:30:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53069
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVyar-0002h0-Mn
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588689044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNsXmyXu3HIiU2hvsa3XAbXJ5SBeRNfjZk6COlFnoos=;
 b=LJTuGyYTlOtF+JLrqGqoE5NWjEOsDLed50H5PoDkaB+hUQqQkA4lRsRjboeADX/4kBKLDn
 mhX0up/fGm0byRUeKWvoL5RoankbPikBEungVKBMoF3JmxA9zNXX0PFyUXiqMw/aPNDnQs
 L9AVdxFjgXFbTuGTo3hrfuPfuMtwJ+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-7nKC0aDkOJ2dGtThbdaLOw-1; Tue, 05 May 2020 10:30:41 -0400
X-MC-Unique: 7nKC0aDkOJ2dGtThbdaLOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 616C48014C0;
 Tue,  5 May 2020 14:30:40 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9A8970532;
 Tue,  5 May 2020 14:30:20 +0000 (UTC)
Date: Tue, 5 May 2020 16:30:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 06/13] acpi: move acpi_align_size to acpi-common.h
Message-ID: <20200505163018.1aa43aa6@redhat.com>
In-Reply-To: <20200505134305.22666-7-kraxel@redhat.com>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-7-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  5 May 2020 15:42:58 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

patch probably isn't needed, see my comment on 9/13

> ---
>  hw/i386/acpi-common.h | 19 +++++++++++++++++++
>  hw/i386/acpi-build.c  | 18 ------------------
>  2 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
> index 5788a13da9ca..f837bb17163b 100644
> --- a/hw/i386/acpi-common.h
> +++ b/hw/i386/acpi-common.h
> @@ -3,12 +3,31 @@
>  
>  #include "include/hw/acpi/acpi-defs.h"
>  #include "include/hw/acpi/acpi_dev_interface.h"
> +#include "include/hw/acpi/aml-build.h"
>  #include "include/hw/acpi/bios-linker-loader.h"
>  #include "include/hw/i386/x86.h"
>  
> +/* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
> + * -M pc-i440fx-2.0.  Even if the actual amount of AML generated grows
> + * a little bit, there should be plenty of free space since the DSDT
> + * shrunk by ~1.5k between QEMU 2.0 and QEMU 2.1.
> + */
> +#define ACPI_BUILD_LEGACY_CPU_AML_SIZE    97
> +#define ACPI_BUILD_ALIGN_SIZE             0x1000
> +
> +#define ACPI_BUILD_TABLE_SIZE             0x20000
> +
>  /* Default IOAPIC ID */
>  #define ACPI_BUILD_IOAPIC_ID 0x0
>  
> +static inline void acpi_align_size(GArray *blob, unsigned align)
> +{
> +    /* Align size to multiple of given size. This reduces the chance
> +     * we need to change size in the future (breaking cross version migration).
> +     */
> +    g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
> +}
> +
>  void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>                       X86MachineState *x86ms, AcpiDeviceIf *adev,
>                       bool has_pci);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index d1f14394734e..dc3b62468439 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -72,16 +72,6 @@
>  #include "hw/acpi/ipmi.h"
>  #include "hw/acpi/hmat.h"
>  
> -/* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
> - * -M pc-i440fx-2.0.  Even if the actual amount of AML generated grows
> - * a little bit, there should be plenty of free space since the DSDT
> - * shrunk by ~1.5k between QEMU 2.0 and QEMU 2.1.
> - */
> -#define ACPI_BUILD_LEGACY_CPU_AML_SIZE    97
> -#define ACPI_BUILD_ALIGN_SIZE             0x1000
> -
> -#define ACPI_BUILD_TABLE_SIZE             0x20000
> -
>  /* #define DEBUG_ACPI_BUILD */
>  #ifdef DEBUG_ACPI_BUILD
>  #define ACPI_BUILD_DPRINTF(fmt, ...)        \
> @@ -267,14 +257,6 @@ static void acpi_get_pci_holes(Range *hole, Range *hole64)
>                                                 NULL));
>  }
>  
> -static void acpi_align_size(GArray *blob, unsigned align)
> -{
> -    /* Align size to multiple of given size. This reduces the chance
> -     * we need to change size in the future (breaking cross version migration).
> -     */
> -    g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
> -}
> -
>  static void build_append_pcihp_notify_entry(Aml *method, int slot)
>  {
>      Aml *if_ctx;


