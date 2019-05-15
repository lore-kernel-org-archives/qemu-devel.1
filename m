Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F74C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD0420862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD0420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33609 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQph3-00045K-62
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 04:55:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hQpg8-0003hj-6v
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hQpg7-0007s6-3i
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:54:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:24024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hQpg4-0007nF-6G; Wed, 15 May 2019 04:54:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 May 2019 01:54:17 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga008.jf.intel.com with ESMTP; 15 May 2019 01:54:15 -0700
Date: Wed, 15 May 2019 16:53:44 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190515085344.GB31136@richard>
References: <20190419003053.8260-1-richardw.yang@linux.intel.com>
	<20190419003053.8260-7-richardw.yang@linux.intel.com>
	<20190514211015-mutt-send-email-mst@kernel.org>
	<d9d265e1-1052-9d8d-c749-5d1e5901f567@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9d265e1-1052-9d8d-c749-5d1e5901f567@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.136
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: yang.zhong@intel.com, peter.maydell@linaro.org,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
	Wei Yang <richardw.yang@linux.intel.com>, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 07:29:17AM +0200, Philippe Mathieu-Daudé wrote:
>On 5/15/19 3:10 AM, Michael S. Tsirkin wrote:
>> On Fri, Apr 19, 2019 at 08:30:53AM +0800, Wei Yang wrote:
>>> build_append_foo() API doesn't need explicit endianness conversions
>>> which eliminates a source of errors and it makes build_mcfg() look like
>>> declarative definition of MCFG table in ACPI spec, which makes it easy
>>> to review.
>>>
>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> 
>> Causes a regression with an invalid MCFG produced.
>> Dropped.
>> 
>>> ---
>>>  hw/acpi/pci.c               | 33 +++++++++++++++++++++------------
>>>  include/hw/acpi/acpi-defs.h | 18 ------------------
>>>  2 files changed, 21 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
>>> index fa0fa30bb9..341805e786 100644
>>> --- a/hw/acpi/pci.c
>>> +++ b/hw/acpi/pci.c
>>> @@ -30,17 +30,26 @@
>>>  
>>>  void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>>>  {
>>> -    AcpiTableMcfg *mcfg;
>>> -    int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
>>> -
>>> -    mcfg = acpi_data_push(table_data, len);
>>> -    mcfg->allocation[0].address = cpu_to_le64(info->base);
>>> -
>>> -    /* Only a single allocation so no need to play with segments */
>>> -    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
>>> -    mcfg->allocation[0].start_bus_number = 0;
>>> -    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
>>> -
>>> -    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
>>> +    int mcfg_start = table_data->len;
>>> +
>>> +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
>
>Ah, it seems we missed AcpiTableMcfg.reserved[8]...:
>
>        build_append_int_noprefix(table_data, 0, 8);
>

Hmm... you are right. Shame on me.

>>> +
>>> +    /*
>>> +     * PCI Firmware Specification, Revision 3.0
>>> +     * 4.1.2 MCFG Table Description.
>>> +     */
>>> +    /* Base address, processor-relative */
>>> +    build_append_int_noprefix(table_data, info->base, 8);
>>> +    /* PCI segment group number */
>>> +    build_append_int_noprefix(table_data, 0, 2);
>>> +    /* Starting PCI Bus number */
>>> +    build_append_int_noprefix(table_data, 0, 1);
>>> +    /* Final PCI Bus number */
>>> +    build_append_int_noprefix(table_data, PCIE_MMCFG_BUS(info->size - 1), 1);
>>> +    /* Reserved */
>>> +    build_append_int_noprefix(table_data, 0, 4);
>>> +
>>> +    build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
>>> +                 "MCFG", table_data->len - mcfg_start, 1, NULL, NULL);
>>>  }
>>>  
>>> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
>>> index f9aa4bd398..57a3f58b0c 100644
>>> --- a/include/hw/acpi/acpi-defs.h
>>> +++ b/include/hw/acpi/acpi-defs.h
>>> @@ -449,24 +449,6 @@ struct AcpiSratProcessorGiccAffinity {
>>>  
>>>  typedef struct AcpiSratProcessorGiccAffinity AcpiSratProcessorGiccAffinity;
>>>  
>>> -/* PCI fw r3.0 MCFG table. */
>>> -/* Subtable */
>>> -struct AcpiMcfgAllocation {
>>> -    uint64_t address;                /* Base address, processor-relative */
>>> -    uint16_t pci_segment;            /* PCI segment group number */
>>> -    uint8_t start_bus_number;       /* Starting PCI Bus number */
>>> -    uint8_t end_bus_number;         /* Final PCI Bus number */
>>> -    uint32_t reserved;
>>> -} QEMU_PACKED;
>>> -typedef struct AcpiMcfgAllocation AcpiMcfgAllocation;
>>> -
>>> -struct AcpiTableMcfg {
>>> -    ACPI_TABLE_HEADER_DEF;
>>> -    uint8_t reserved[8];
>
>           --------^
>
>Thanks Michael for testing...
>
>Wei, can you add a MCFG test in tests/bios-tables-test.c?
>

Sure, let me prepare the test.

>Regards,
>
>Phil.
>
>>> -    AcpiMcfgAllocation allocation[0];
>>> -} QEMU_PACKED;
>>> -typedef struct AcpiTableMcfg AcpiTableMcfg;
>>> -
>>>  /*
>>>   * TCPA Description Table
>>>   *
>>> -- 
>>> 2.19.1

-- 
Wei Yang
Help you, Help me

