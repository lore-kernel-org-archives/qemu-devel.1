Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FC9C04AB4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 01:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3126D20862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 01:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3126D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57279 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQiSJ-0003oe-39
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 21:11:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hQiRP-0003Rh-UY
	for qemu-devel@nongnu.org; Tue, 14 May 2019 21:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hQiRO-0006lc-Gl
	for qemu-devel@nongnu.org; Tue, 14 May 2019 21:10:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hQiRO-0006is-Aj
	for qemu-devel@nongnu.org; Tue, 14 May 2019 21:10:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id h1so1445265qtp.1
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 18:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=PU0ahnnz2Yw+Drru1xrR3apQ5vSXutrP8LiQj6IFiPg=;
	b=M4gkw0f0n97g7AKGM5SZvIhSdC1d1WtlZXYRneRULYCgw+hDsvX+aZ+r+av8P9/KoZ
	W17khXnSPeBpZaETFzLEmCU5YywXiEKCGlIciS+jHiljTBjQUiElS7IW8yKAj7OnZwk3
	mzN4uMp7t3T+U7JJOtVMlF7xfgxx/0HiX6J4n3hWFv8WO1HNpC7lgJCe5mIbS5PLP19h
	+OvzORLg2nB3iDfYjCnlog0CcmBdWLpofByUMyiMr130G5m6Y40aHsnUuuZdf+WcBhtU
	j+PYK9ZqfDRYtUcGF7yQZpOTaJ/mtGXW3/aIhpavGz5qx57XpM3JR0uDIUPmBcW7aHBO
	1fCA==
X-Gm-Message-State: APjAAAUSWYap9o15f/7p4R1r5xv3oGaS7hsJs+tw+hS+G17uv/SsRAD0
	N5QGJrP2BDPFvfkeaaZl8wpcyA==
X-Google-Smtp-Source: APXvYqwDiqC3RAYXzyOYtCw+lXE0OsL/UKLB7wFIgNaD7m6JeyTXTxlhiqFu4RxjNrM7gxxfRLDm2A==
X-Received: by 2002:ac8:2af4:: with SMTP id c49mr14230189qta.83.1557882640602; 
	Tue, 14 May 2019 18:10:40 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
	by smtp.gmail.com with ESMTPSA id v22sm551377qtj.29.2019.05.14.18.10.37
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 14 May 2019 18:10:39 -0700 (PDT)
Date: Tue, 14 May 2019 21:10:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190514211015-mutt-send-email-mst@kernel.org>
References: <20190419003053.8260-1-richardw.yang@linux.intel.com>
	<20190419003053.8260-7-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190419003053.8260-7-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.196
Subject: Re: [Qemu-devel] [PATCH v4 6/6] acpi: pci: use build_append_foo()
 API to construct MCFG
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
	shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
	imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 19, 2019 at 08:30:53AM +0800, Wei Yang wrote:
> build_append_foo() API doesn't need explicit endianness conversions
> which eliminates a source of errors and it makes build_mcfg() look like
> declarative definition of MCFG table in ACPI spec, which makes it easy
> to review.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Causes a regression with an invalid MCFG produced.
Dropped.

> ---
>  hw/acpi/pci.c               | 33 +++++++++++++++++++++------------
>  include/hw/acpi/acpi-defs.h | 18 ------------------
>  2 files changed, 21 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> index fa0fa30bb9..341805e786 100644
> --- a/hw/acpi/pci.c
> +++ b/hw/acpi/pci.c
> @@ -30,17 +30,26 @@
>  
>  void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>  {
> -    AcpiTableMcfg *mcfg;
> -    int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
> -
> -    mcfg = acpi_data_push(table_data, len);
> -    mcfg->allocation[0].address = cpu_to_le64(info->base);
> -
> -    /* Only a single allocation so no need to play with segments */
> -    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
> -    mcfg->allocation[0].start_bus_number = 0;
> -    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
> -
> -    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
> +    int mcfg_start = table_data->len;
> +
> +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
> +
> +    /*
> +     * PCI Firmware Specification, Revision 3.0
> +     * 4.1.2 MCFG Table Description.
> +     */
> +    /* Base address, processor-relative */
> +    build_append_int_noprefix(table_data, info->base, 8);
> +    /* PCI segment group number */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    /* Starting PCI Bus number */
> +    build_append_int_noprefix(table_data, 0, 1);
> +    /* Final PCI Bus number */
> +    build_append_int_noprefix(table_data, PCIE_MMCFG_BUS(info->size - 1), 1);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 4);
> +
> +    build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
> +                 "MCFG", table_data->len - mcfg_start, 1, NULL, NULL);
>  }
>  
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index f9aa4bd398..57a3f58b0c 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -449,24 +449,6 @@ struct AcpiSratProcessorGiccAffinity {
>  
>  typedef struct AcpiSratProcessorGiccAffinity AcpiSratProcessorGiccAffinity;
>  
> -/* PCI fw r3.0 MCFG table. */
> -/* Subtable */
> -struct AcpiMcfgAllocation {
> -    uint64_t address;                /* Base address, processor-relative */
> -    uint16_t pci_segment;            /* PCI segment group number */
> -    uint8_t start_bus_number;       /* Starting PCI Bus number */
> -    uint8_t end_bus_number;         /* Final PCI Bus number */
> -    uint32_t reserved;
> -} QEMU_PACKED;
> -typedef struct AcpiMcfgAllocation AcpiMcfgAllocation;
> -
> -struct AcpiTableMcfg {
> -    ACPI_TABLE_HEADER_DEF;
> -    uint8_t reserved[8];
> -    AcpiMcfgAllocation allocation[0];
> -} QEMU_PACKED;
> -typedef struct AcpiTableMcfg AcpiTableMcfg;
> -
>  /*
>   * TCPA Description Table
>   *
> -- 
> 2.19.1

