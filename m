Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD96C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3498C20863
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3498C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47201 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSy9u-0004cC-EA
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 02:21:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSy8y-0004FP-RP
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSy8x-0002Vh-OH
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:21:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:6641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hSy8v-0002Tz-2U; Tue, 21 May 2019 02:20:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 May 2019 23:20:55 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga002.jf.intel.com with ESMTP; 20 May 2019 23:20:53 -0700
Date: Tue, 21 May 2019 14:20:23 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190521062023.GB3589@richard>
References: <20190521033249.1960-1-richardw.yang@linux.intel.com>
	<20190521033249.1960-3-richardw.yang@linux.intel.com>
	<20190520234407-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520234407-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [PATCH v5 2/2] acpi: pci: use build_append_foo()
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, thuth@redhat.com,
	qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
	qemu-arm@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
	imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 11:44:28PM -0400, Michael S. Tsirkin wrote:
>On Tue, May 21, 2019 at 11:32:49AM +0800, Wei Yang wrote:
>> build_append_foo() API doesn't need explicit endianness conversions
>> which eliminates a source of errors and it makes build_mcfg() look like
>> declarative definition of MCFG table in ACPI spec, which makes it easy
>> to review.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> 
>> ---
>> v5:
>>    * miss the reserved[8] of MCFG in last version, add it back
>>    * drop SOBs and make sure bios-tables-test all OK
>> ---
>>  hw/acpi/pci.c               | 35 +++++++++++++++++++++++------------
>>  include/hw/acpi/acpi-defs.h | 18 ------------------
>>  2 files changed, 23 insertions(+), 30 deletions(-)
>> 
>> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
>> index fa0fa30bb9..49df7b7d54 100644
>> --- a/hw/acpi/pci.c
>> +++ b/hw/acpi/pci.c
>> @@ -30,17 +30,28 @@
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
>> +    /*
>> +     * PCI Firmware Specification, Revision 3.0
>> +     * 4.1.2 MCFG Table Description.
>> +     */
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 8);
>
>below is in fact
>	Memory Mapped Enhanced Configuration Space Base Address Allocation Structure
>
>maybe document this?
>

Sure. Let me add this.

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
>> -- 
>> 2.19.1

-- 
Wei Yang
Help you, Help me

