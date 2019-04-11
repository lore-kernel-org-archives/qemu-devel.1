Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A812C10F11
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 01:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398AC20674
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 01:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398AC20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40065 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEObI-0004vh-GE
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 21:34:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hEOZw-0004KP-2r
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hEOZv-0000E7-0B
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:32:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:55063)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hEOZu-0000AT-Ls
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:32:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Apr 2019 18:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,335,1549958400"; d="scan'208";a="148213091"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by FMSMGA003.fm.intel.com with ESMTP; 10 Apr 2019 18:32:30 -0700
Date: Thu, 11 Apr 2019 09:32:11 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190411013211.GA8515@richard>
References: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
	<20190410142756.GA3136@richard>
	<20190410170150.1c447b12@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190410170150.1c447b12@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH for-4.1] q35: acpi: do not create dummy
 MCFG table
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
Cc: ehabkost@redhat.com, mst@redhat.com,
	Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411013211.2-0UPsQDrU7BaHuIJEl3myGCkqJFRl9OVcFG8XrmUTU@z>

On Wed, Apr 10, 2019 at 05:01:50PM +0200, Igor Mammedov wrote:
>On Wed, 10 Apr 2019 22:27:56 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>[...]
>> >@@ -2411,19 +2410,7 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>> >     mcfg->allocation[0].start_bus_number = 0;
>> >     mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);
>> > 
>> >-    /* MCFG is used for ECAM which can be enabled or disabled by guest.  
>> 
>> I want to cnfirm what is "enabled or disabled by guest" here.
>
>Firmware theoretically during PCI initialization may disable ECAM support
>and that's when we do no need MCFG. In practice that's not happening
>(SeaBIOS or UEFI) but we in case there is out there a firmware that does
>disable ECAM we do not generate MCFG.
>
>Note:
>ACPI tables generated twice, 1st when QEMU starts and the second time
>when firmware accesses fwcfg to read blobs for the 1st time.
>The later happens after PCI subsystem was initialized by firmware.
>At that time we know if ECAM was enabled or not.
>

That's much clear, thanks :-)

So this is the guest BIOS instead of guest kernel who may disable/enable it.

>> If we don't reserve mcfg and "guest" enable mcfg during running, the ACPI
>> table size changed. But the destination still has the original table size,
>> since destination "guest" keep sleep during this period.
>> 
>> Now the migration would face table size difference
>
>with commit a1666142db we do not care as all the tables created on
>source will be migrated to destination as is overwriting whatever blobs
>destination created on startup.
>
>> and break migration?
>nope,
>
>to help you figure out why it works
>look at what following git commits did:
>  git log c8d6f66ae7..a1666142db
>and pay attention to 'used_length'
>

To be honest, this is what I feel confused in your previous reply.

First I want to confirm both fields in RAMBlock affects the migration:

* used_length
* max_length

Both of them should be the same on both source/destination, otherwise the
migration would fail.

Then I thought the migration would be broken if source/destination has
different knowledge about acpi table size. Because this will introduce
different value of used_length, even we have resizable MemoryRegion.

The 1st time ACPI generation flow:

    acpi_add_rom_blob
        rom_add_blob
            rom_set_mr
                memory_region_init_resizable_ram
                    qemu_ram_alloc_resizable
    		        new_block->used_length = size
    		        new_block->max_length = max_size

The 2nd time ACPI generation flow:

    acpi_ram_update
        memory_regioin_ram_resize
            qemu_ram_resize
                block->used_length = new_size

The max_length is always the same, while used_length would be changed to the
actual table_blob size.

In case source/destination has different knowledge about acpi table size, the
table_blob size(even after aligned) could be different.

This is why I thought there is still some chance to break migration after
resizable MemoryRegion.

Do I miss something?

-- 
Wei Yang
Help you, Help me

