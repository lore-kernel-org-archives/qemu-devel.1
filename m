Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA83C04AA7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 05:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2C02084A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 05:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2C02084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59823 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQmUY-0004Tc-5r
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 01:30:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQmTh-00046r-RA
	for qemu-devel@nongnu.org; Wed, 15 May 2019 01:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQmTg-00051V-MJ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 01:29:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQmTg-0004xP-GK
	for qemu-devel@nongnu.org; Wed, 15 May 2019 01:29:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so3796700wme.0
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 22:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/jTHOxsJ7PAM6xGoNz59r8y5PNeCVWuZw86J1Q4W5dg=;
	b=FFkSHT9oKE4aCMxZ1u9/kOHYu6nhjcWOZLPKhYKAm3woBXLwrxB71kNAettiRRrrfR
	UjrEc/q+8/aaRAxRf1uR1PYwlXT6Lvesfxfec7RGkI5BueFWJnuuN2z1O++wxKzQQdgu
	QSNxMbLi3bh591UwJk84aF8PeQnSzjPGEwWnausY6ceAK63n1qIwaJKh4RESgv5kC8Ml
	Gsl6CllggY72yMSeSAJAIOAuBpkfkb3nLZgqkVlH/QroCxfgyPLKP85E2WJseDLmaF8K
	L0CBrhWjBMeHD0aSLcjEEWRWgmV693mDVhaU8guaJv0yITYq1VqMZAZt9jtNrRjc24s6
	ruYQ==
X-Gm-Message-State: APjAAAXKkMjAbpkrCLpj5MZEA//3OT/vo/PsvXLQiHckibrDjQamlQZz
	+lVVAhr8ty/So1RPjrifnFRL5Q==
X-Google-Smtp-Source: APXvYqzd3Nm3gCZpABYFGjPClMiXtv9Gt+iawLJ+UnJR/uFRRDoVLuqLdBl8MFox9J604i10Lg7iGA==
X-Received: by 2002:a1c:9c8c:: with SMTP id f134mr7659684wme.95.1557898158852; 
	Tue, 14 May 2019 22:29:18 -0700 (PDT)
Received: from [192.168.1.43] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id s10sm808099wrt.66.2019.05.14.22.29.17
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 22:29:17 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>
References: <20190419003053.8260-1-richardw.yang@linux.intel.com>
	<20190419003053.8260-7-richardw.yang@linux.intel.com>
	<20190514211015-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d9d265e1-1052-9d8d-c749-5d1e5901f567@redhat.com>
Date: Wed, 15 May 2019 07:29:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514211015-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
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
	shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/19 3:10 AM, Michael S. Tsirkin wrote:
> On Fri, Apr 19, 2019 at 08:30:53AM +0800, Wei Yang wrote:
>> build_append_foo() API doesn't need explicit endianness conversions
>> which eliminates a source of errors and it makes build_mcfg() look like
>> declarative definition of MCFG table in ACPI spec, which makes it easy
>> to review.
>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Causes a regression with an invalid MCFG produced.
> Dropped.
> 
>> ---
>>  hw/acpi/pci.c               | 33 +++++++++++++++++++++------------
>>  include/hw/acpi/acpi-defs.h | 18 ------------------
>>  2 files changed, 21 insertions(+), 30 deletions(-)
>>
>> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
>> index fa0fa30bb9..341805e786 100644
>> --- a/hw/acpi/pci.c
>> +++ b/hw/acpi/pci.c
>> @@ -30,17 +30,26 @@
>>  
>>  void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>>  {
>> -    AcpiTableMcfg *mcfg;
>> -    int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
>> -
>> -    mcfg = acpi_data_push(table_data, len);
>> -    mcfg->allocation[0].address = cpu_to_le64(info->base);
>> -
>> -    /* Only a single allocation so no need to play with segments */
>> -    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
>> -    mcfg->allocation[0].start_bus_number = 0;
>> -    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
>> -
>> -    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
>> +    int mcfg_start = table_data->len;
>> +
>> +    acpi_data_push(table_data, sizeof(AcpiTableHeader));

Ah, it seems we missed AcpiTableMcfg.reserved[8]...:

        build_append_int_noprefix(table_data, 0, 8);

>> +
>> +    /*
>> +     * PCI Firmware Specification, Revision 3.0
>> +     * 4.1.2 MCFG Table Description.
>> +     */
>> +    /* Base address, processor-relative */
>> +    build_append_int_noprefix(table_data, info->base, 8);
>> +    /* PCI segment group number */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +    /* Starting PCI Bus number */
>> +    build_append_int_noprefix(table_data, 0, 1);
>> +    /* Final PCI Bus number */
>> +    build_append_int_noprefix(table_data, PCIE_MMCFG_BUS(info->size - 1), 1);
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 4);
>> +
>> +    build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
>> +                 "MCFG", table_data->len - mcfg_start, 1, NULL, NULL);
>>  }
>>  
>> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
>> index f9aa4bd398..57a3f58b0c 100644
>> --- a/include/hw/acpi/acpi-defs.h
>> +++ b/include/hw/acpi/acpi-defs.h
>> @@ -449,24 +449,6 @@ struct AcpiSratProcessorGiccAffinity {
>>  
>>  typedef struct AcpiSratProcessorGiccAffinity AcpiSratProcessorGiccAffinity;
>>  
>> -/* PCI fw r3.0 MCFG table. */
>> -/* Subtable */
>> -struct AcpiMcfgAllocation {
>> -    uint64_t address;                /* Base address, processor-relative */
>> -    uint16_t pci_segment;            /* PCI segment group number */
>> -    uint8_t start_bus_number;       /* Starting PCI Bus number */
>> -    uint8_t end_bus_number;         /* Final PCI Bus number */
>> -    uint32_t reserved;
>> -} QEMU_PACKED;
>> -typedef struct AcpiMcfgAllocation AcpiMcfgAllocation;
>> -
>> -struct AcpiTableMcfg {
>> -    ACPI_TABLE_HEADER_DEF;
>> -    uint8_t reserved[8];

           --------^

Thanks Michael for testing...

Wei, can you add a MCFG test in tests/bios-tables-test.c?

Regards,

Phil.

>> -    AcpiMcfgAllocation allocation[0];
>> -} QEMU_PACKED;
>> -typedef struct AcpiTableMcfg AcpiTableMcfg;
>> -
>>  /*
>>   * TCPA Description Table
>>   *
>> -- 
>> 2.19.1

