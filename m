Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C228AC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D882133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D882133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEYBF-0004Se-Pc
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 07:47:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEYAC-0003yV-5H
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEYAA-0003jj-AC
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:46:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hEYA8-0003iU-Cq
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:46:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A935D3082DCE;
	Thu, 11 Apr 2019 11:46:34 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8296A60BF7;
	Thu, 11 Apr 2019 11:46:31 +0000 (UTC)
Date: Thu, 11 Apr 2019 13:46:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190411134627.15d7c340@redhat.com>
In-Reply-To: <20190411013211.GA8515@richard>
References: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
	<20190410142756.GA3136@richard>
	<20190410170150.1c447b12@redhat.com>
	<20190411013211.GA8515@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 11 Apr 2019 11:46:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411114627.I2i-2CdqaudurUZHNMM5wgIgRV5_TWLTfaUmpRau9Y4@z>

On Thu, 11 Apr 2019 09:32:11 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> On Wed, Apr 10, 2019 at 05:01:50PM +0200, Igor Mammedov wrote:
> >On Wed, 10 Apr 2019 22:27:56 +0800
> >Wei Yang <richardw.yang@linux.intel.com> wrote:
> >
> >[...]  
> >> >@@ -2411,19 +2410,7 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
> >> >     mcfg->allocation[0].start_bus_number = 0;
> >> >     mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);
> >> > 
> >> >-    /* MCFG is used for ECAM which can be enabled or disabled by guest.    
> >> 
> >> I want to cnfirm what is "enabled or disabled by guest" here.  
> >
> >Firmware theoretically during PCI initialization may disable ECAM support
> >and that's when we do no need MCFG. In practice that's not happening
> >(SeaBIOS or UEFI) but we in case there is out there a firmware that does
> >disable ECAM we do not generate MCFG.
> >
> >Note:
> >ACPI tables generated twice, 1st when QEMU starts and the second time
> >when firmware accesses fwcfg to read blobs for the 1st time.
> >The later happens after PCI subsystem was initialized by firmware.
> >At that time we know if ECAM was enabled or not.
> >  
> 
> That's much clear, thanks :-)
> 
> So this is the guest BIOS instead of guest kernel who may disable/enable it.
> 
> >> If we don't reserve mcfg and "guest" enable mcfg during running, the ACPI
> >> table size changed. But the destination still has the original table size,
> >> since destination "guest" keep sleep during this period.
> >> 
> >> Now the migration would face table size difference  
> >
> >with commit a1666142db we do not care as all the tables created on
> >source will be migrated to destination as is overwriting whatever blobs
> >destination created on startup.
> >  
> >> and break migration?  
> >nope,
> >
> >to help you figure out why it works
> >look at what following git commits did:
> >  git log c8d6f66ae7..a1666142db
> >and pay attention to 'used_length'
> >  
> 
> To be honest, this is what I feel confused in your previous reply.
> 
> First I want to confirm both fields in RAMBlock affects the migration:
> 
> * used_length
> * max_length
> 
> Both of them should be the same on both source/destination, otherwise the
> migration would fail.
well, it works fine for me.
Where do you see max_length being used during migration?


> Then I thought the migration would be broken if source/destination has
> different knowledge about acpi table size. Because this will introduce
> different value of used_length, even we have resizable MemoryRegion.
> 
> The 1st time ACPI generation flow:
> 
>     acpi_add_rom_blob
>         rom_add_blob
>             rom_set_mr
>                 memory_region_init_resizable_ram
>                     qemu_ram_alloc_resizable
>     		        new_block->used_length = size
>     		        new_block->max_length = max_size
> 
> The 2nd time ACPI generation flow:
> 
>     acpi_ram_update
>         memory_regioin_ram_resize
>             qemu_ram_resize
>                 block->used_length = new_size
> 
> The max_length is always the same, while used_length would be changed to the
> actual table_blob size.
> 
> In case source/destination has different knowledge about acpi table size, the
> table_blob size(even after aligned) could be different.
> 
> This is why I thought there is still some chance to break migration after
> resizable MemoryRegion.
> 
> Do I miss something?
yes, you did, max_length does not influence migration stream.
see what above mentioned commits and ram_load() -> "if (length != block->used_length)" do.



