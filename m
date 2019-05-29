Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAA1C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 03:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A1821721
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 03:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A1821721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46491 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVpT8-0001y6-0I
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 23:41:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVpSF-0001c2-Hb
	for qemu-devel@nongnu.org; Tue, 28 May 2019 23:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVpSE-0008WC-AO
	for qemu-devel@nongnu.org; Tue, 28 May 2019 23:40:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hVpSE-0007KI-5r
	for qemu-devel@nongnu.org; Tue, 28 May 2019 23:40:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id s57so884171qte.8
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 20:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=CA/4dQuaDckNy4AUShkfB3sMJYFzdlrvMh+cMSh6ymk=;
	b=f8Drda/0/seq3TZbwrPxg6IuO7Ad2i0wN3Zxf0qAmITEccJxoQDJOGKAfQIhY/ywww
	sGlOOXD6pFMBEVWmRamD/A+ybzDIFUeNxwvi6sQFNIJZr8TI1sUzzbyicaLzAi55SFRj
	PUUfilbtiJnktNHTuuIAnKcGjWPZ6zndG+y4adjsHbui0ZGMv/XMrUPn+Ne05APLoYmZ
	5V9RTiQsY43rAWSqQIg/BvkO/oJDll0EreIUKzAeb4tKc40e3LJHtJAn5R+WqpKX6AsN
	Canzcf9FzeIEawTB+OGTHtQfvPhuqLdm4Jom5QNIyt0fDhO2PVU2gPJWYjH1RRrN7Bk5
	RGbQ==
X-Gm-Message-State: APjAAAUvjxQ8HO78ffFW2LZDnZByxzsJZSBDS7bdjhfetdIBFHzLwIC1
	jybtVnNiEjShjBuoW7zpocjGjg==
X-Google-Smtp-Source: APXvYqxZCW8sl4NzynuNYSnfMxxMzOniFC/UrECQYsUqP/bQUypqcvtbOQPs3tn5egFKxY8JGWz0FQ==
X-Received: by 2002:ac8:96d:: with SMTP id z42mr90521227qth.24.1559101221644; 
	Tue, 28 May 2019 20:40:21 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id w5sm6288911qtc.50.2019.05.28.20.40.20
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 28 May 2019 20:40:20 -0700 (PDT)
Date: Tue, 28 May 2019 23:40:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <20190528233859-mutt-send-email-mst@kernel.org>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
	<1557832703-42620-3-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557832703-42620-3-git-send-email-gengdongjiu@huawei.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH v17 02/10] ACPI: add some GHES structures
 and macros definition
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
	mtosatti@redhat.com, qemu-devel@nongnu.org, linuxarm@huawei.com,
	shannon.zhaosl@gmail.com, zhengxiang9@huawei.com,
	qemu-arm@nongnu.org, james.morse@arm.com,
	jonathan.cameron@huawei.com, imammedo@redhat.com,
	pbonzini@redhat.com, xuwei5@huawei.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 14, 2019 at 04:18:15AM -0700, Dongjiu Geng wrote:
> Add Generic Error Status Block structures and some macros
> definitions, which is referred to the ACPI 4.0 or ACPI 6.2. The
> HEST table generation and CPER record will use them.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

Are these all still used? I'd rather you moved stuff to
where it's used.



> ---
>  include/hw/acpi/acpi-defs.h | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index f9aa4bd..d1996fb 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -224,6 +224,25 @@ typedef struct AcpiMultipleApicTable AcpiMultipleApicTable;
>  #define ACPI_APIC_RESERVED              16   /* 16 and greater are reserved */
>  
>  /*
> + * Values for Hardware Error Notification Type field
> + */
> +enum AcpiHestNotifyType {
> +    ACPI_HEST_NOTIFY_POLLED = 0,
> +    ACPI_HEST_NOTIFY_EXTERNAL = 1,
> +    ACPI_HEST_NOTIFY_LOCAL = 2,
> +    ACPI_HEST_NOTIFY_SCI = 3,
> +    ACPI_HEST_NOTIFY_NMI = 4,
> +    ACPI_HEST_NOTIFY_CMCI = 5,  /* ACPI 5.0: 18.3.2.7, Table 18-290 */
> +    ACPI_HEST_NOTIFY_MCE = 6,   /* ACPI 5.0: 18.3.2.7, Table 18-290 */
> +    ACPI_HEST_NOTIFY_GPIO = 7,  /* ACPI 6.0: 18.3.2.7, Table 18-332 */
> +    ACPI_HEST_NOTIFY_SEA = 8,   /* ACPI 6.1: 18.3.2.9, Table 18-345 */
> +    ACPI_HEST_NOTIFY_SEI = 9,   /* ACPI 6.1: 18.3.2.9, Table 18-345 */
> +    ACPI_HEST_NOTIFY_GSIV = 10, /* ACPI 6.1: 18.3.2.9, Table 18-345 */
> +    ACPI_HEST_NOTIFY_SDEI = 11, /* ACPI 6.2: 18.3.2.9, Table 18-383 */
> +    ACPI_HEST_NOTIFY_RESERVED = 12 /* 12 and greater are reserved */
> +};
> +

If there's a single user, the best thing to do
is just to open-code with a comment that matches
spec names. It's hard to find stuff like ACPI_HEST_NOTIFY_GSIV
in a spec.

> +/*
>   * MADT sub-structures (Follow MULTIPLE_APIC_DESCRIPTION_TABLE)
>   */
>  #define ACPI_SUB_HEADER_DEF   /* Common ACPI sub-structure header */\
> @@ -400,6 +419,39 @@ struct AcpiSystemResourceAffinityTable {
>  } QEMU_PACKED;
>  typedef struct AcpiSystemResourceAffinityTable AcpiSystemResourceAffinityTable;
>  
> +/*
> + * Generic Error Status Block
> + */
> +struct AcpiGenericErrorStatus {
> +    /* It is a bitmask composed of ACPI_GEBS_xxx macros */
> +    uint32_t block_status;
> +    uint32_t raw_data_offset;
> +    uint32_t raw_data_length;
> +    uint32_t data_length;
> +    uint32_t error_severity;
> +} QEMU_PACKED;
> +typedef struct AcpiGenericErrorStatus AcpiGenericErrorStatus;
> +
> +/*
> + * Masks for block_status flags above
> + */
> +#define ACPI_GEBS_UNCORRECTABLE         1
> +
> +/*
> + * Values for error_severity field above
> + */
> +enum AcpiGenericErrorSeverity {
> +    ACPI_CPER_SEV_RECOVERABLE,
> +    ACPI_CPER_SEV_FATAL,
> +    ACPI_CPER_SEV_CORRECTED,
> +    ACPI_CPER_SEV_NONE,
> +};
> +
> +/*
> + * Generic Hardware Error Source version 2
> + */
> +#define ACPI_HEST_SOURCE_GENERIC_ERROR_V2    10
> +
>  #define ACPI_SRAT_PROCESSOR_APIC     0
>  #define ACPI_SRAT_MEMORY             1
>  #define ACPI_SRAT_PROCESSOR_x2APIC   2
> -- 
> 1.8.3.1

