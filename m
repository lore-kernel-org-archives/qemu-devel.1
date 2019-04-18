Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00F4C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842C821479
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842C821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40877 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH6C8-0002Wr-S3
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 08:31:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH6BC-00024u-5e
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH6BA-0002D4-Vi
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:30:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hH6BA-0002C6-Pb
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:30:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so2601383wmi.0
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 05:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Ig2LvWykN6ZD97/sREGGIKZnghPcjvbydVqaXU/nJgM=;
	b=D1QkhGF4QbR2dQ6/YHE5aYhqz8vfD9XE2NpieUDJbq2JeKdIofNGBhj/H5ysPkYnYR
	e+c/XSbz3hwJdafZl8a2ea0DzN1WklJg8bPCfHH5wTN8yt83Ba0Hm+dwqaovEgyf9zGu
	hfXTyiRzPOit845oiIb+SDmPwCnHsAWWCO9/Spqa2e6v/RamI+6bvy3YjJtBWI15S0C4
	gMzADQNNzm09byVVsFMXRtzs5eORZcDSMzIW2z5oJVufacYHTQCOSCr26d+woIqu5lGa
	6JMgvz0gH+5hG0OVN62T4n0vVZ3Lf2VhfP0JFnQeMcrrmtzeSsfrBPzSazAQuoAPER95
	+C3A==
X-Gm-Message-State: APjAAAXQS3DBGMOO/k2IxUQ0fm5Asf4T1GrSLPiZsr595Z+5+y0XKjw8
	q3c6J5gWfujWMPaWHAzPl+ue8w==
X-Google-Smtp-Source: APXvYqy42OgDnfIp5rIdkzCt6if7Xsb1EreyatEb4lEYohJL+dPYuCgpCdRA94YmoZEEpjicinwPeg==
X-Received: by 2002:a05:600c:2055:: with SMTP id
	p21mr3069508wmg.118.1555590611790; 
	Thu, 18 Apr 2019 05:30:11 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	z140sm3063601wmc.27.2019.04.18.05.30.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Apr 2019 05:30:11 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>
References: <20190417014038.26018-1-richardw.yang@linux.intel.com>
	<20190417014038.26018-7-richardw.yang@linux.intel.com>
	<20190418130241.635b2e97@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fb85c756-d3ba-2244-478c-814aaea436af@redhat.com>
Date: Thu, 18 Apr 2019 14:30:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418130241.635b2e97@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v3 6/6] acpi: pci: use build_append_foo()
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, mst@redhat.com,
	qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418123010.pzlmgbQNx430DrupTYMa4jNovWKnZO4-LQhTo9ruR4c@z>

On 4/18/19 1:02 PM, Igor Mammedov wrote:
> On Wed, 17 Apr 2019 09:40:38 +0800
> Wei Yang <richardw.yang@linux.intel.com> wrote:
> 
>> build_append_foo() API doesn't need explicit endianness conversions
>> which eliminates a source of errors and it makes build_mcfg() look like
>> declarative definition of MCFG table in ACPI spec, which makes it easy
>> to review.
>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Thanks for nice cleanup!
> 
> with comment fixed up:
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
>> ---
>>  hw/acpi/pci.c               | 30 ++++++++++++++++++------------
>>  include/hw/acpi/acpi-defs.h | 18 ------------------
>>  2 files changed, 18 insertions(+), 30 deletions(-)
>>
>> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
>> index fa0fa30bb9..05050fa087 100644
>> --- a/hw/acpi/pci.c
>> +++ b/hw/acpi/pci.c
>> @@ -30,17 +30,23 @@
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
>> +
>> +    /* PCI fw r3.0 MCFG table. */
> It would be better to put spec name as is here so simple search
> could immediately point to it.
> 
> like: PCI Firmware Specification, Revision 3.0
>       4.1.2 MCFG Table Description

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
>> -    AcpiMcfgAllocation allocation[0];
>> -} QEMU_PACKED;
>> -typedef struct AcpiTableMcfg AcpiTableMcfg;
>> -
>>  /*
>>   * TCPA Description Table
>>   *
> 

