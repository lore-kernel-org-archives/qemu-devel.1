Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0562CC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4FD20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4FD20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnXT-0006Qr-FM
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iCn7M-0006Hb-KF
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iCn7K-0006MH-K9
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:52:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1iCn7G-0006In-6g; Tue, 24 Sep 2019 11:52:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C1FC3091786;
 Tue, 24 Sep 2019 15:52:37 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-118.rdu2.redhat.com
 [10.10.120.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E04FD1001B20;
 Tue, 24 Sep 2019 15:52:31 +0000 (UTC)
Subject: Re: Invalid blob size on NVDIMM hot-add (was: RE: [RFC PATCH 0/4] ARM
 virt: ACPI memory hotplug support)
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <5FC3163CFD30C246ABAA99954A238FA83F3FB328@lhreml524-mbs.china.huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a1667b4a-72ac-48da-ab36-be1821757ac5@redhat.com>
Date: Tue, 24 Sep 2019 17:52:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F3FB328@lhreml524-mbs.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 24 Sep 2019 15:52:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Leif Lindholm \(Linaro address\)" <leif.lindholm@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, Auger Eric <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/20/19 19:04, Shameerali Kolothum Thodi wrote:
> Hi Laszlo/Igor,
>
> I spend some time to debug this further as I was rebasing the nvdimm
> hot-add support patches on top of the ongoing pc-dimm hot add ones.
>
> Just to refresh the memory:
>
> https://patchwork.kernel.org/cover/10783589/
>
> " It is observed that hot adding nvdimm will results in guest reboot
> failure. EDK2 fails to build the ACPI tables on reboot. Please find
> below EDK2 log on Guest reboot after nvdimm hot-add,
>
> ProcessCmdAddChecksum: invalid checksum range in "etc/acpi/tables"
> OnRootBridgesConnected: InstallAcpiTables: Protocol Error
> "
>
> Please find below,
>
>> -----Original Message-----
>> From: Laszlo Ersek [mailto:lersek@redhat.com]
>> Sent: 05 March 2019 12:15
>> To: Igor Mammedov <imammedo@redhat.com>
>> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> Auger Eric <eric.auger@redhat.com>; shannon.zhaosl@gmail.com;
>> peter.maydell@linaro.org; qemu-devel@nongnu.org; qemu-arm@nongnu.org;
>> xuwei (O) <xuwei5@huawei.com>; Linuxarm <linuxarm@huawei.com>; Ard
>> Biesheuvel <ard.biesheuvel@linaro.org>; Leif Lindholm (Linaro
>> address) <leif.lindholm@linaro.org>
>> Subject: Re: [RFC PATCH 0/4] ARM virt: ACPI memory hotplug support
>>
>> On 03/01/19 18:39, Igor Mammedov wrote:
>>> On Fri, 1 Mar 2019 14:49:45 +0100
>>> Laszlo Ersek <lersek@redhat.com> wrote:
>>>
>>>> On 02/28/19 15:02, Shameerali Kolothum Thodi wrote:
>>>>
>>>>> Ah..I missed the fact that, firmware indeed sees an update in the
>>>>> blob len here (rounded or not) after reboot. So don't think x86
>>>>> has the same issue and padding is not the right solution as Igor
>>>>> explained in his reply.
>>>>>
>>>>> I will try to debug this further. Any pointers welcome.
>>>>
>>>> How about this.
>>>>
>>>> (1) The firmware looks up the fw_cfg file called "etc/table-loader"
>>>> in the fw_cfg file directory (identified by constant selector key
>>>> 0x0019, FW_CFG_FILE_DIR).
>>>>
>>>> (2) The directory entry, once found, tells the firmware two things
>>>> simultaneously. The selector key, and the size of the blob.
>>>>
>>>> (3) The firmware selects the selector key from step (2).
>>>>
>>>> (4) QEMU regenerates the ACPI payload (as a select callback).
>>>>
>>>> (5) The firmware reads the number of bytes from the fw_cfg blob
>>>> that it learned in step (2).
>>>>
>>>> Here's the problem. As long as QEMU used to perform step (4) only
>>>> for the purpose of refreshing PCI resources in the ACPI payload,
>>>> step (4) wouldn't *resize* the blob.
>>>>
>>>> However, if step (4) enlarges the blob, then the byte count that
>>>> step (5) uses -- from step (2) -- for reading, is obsolete.
>>
>>> I've thought that was a problem with IO based fw_cfg, as reading
>>> size/content were separates steps and that it was solved by DMA
>>> based fw_cfg file read.
>>
>> The DMA backend is not relevant for this question, for two reasons:
>>
>> (a) The question whether the fw_cfg transfer takes places with port
>> IO vs. DMA is hidden from the fw_cfg client code; that code goes
>> through an abstract library API.
>>
>> (b) While the DMA method indeed lets the firmware specify the details
>> of the transfer with one action, the issue is with the number of
>> bytes that the firmware requests (that is, not with *how* the
>> firmware requests the transfer). The firmware has to know the size of
>> the transfer before it can initiate the transfer (regardless of port
>> IO vs. DMA).
>>
>>
>> My question is: assume the firmware item in question is selected, and
>> the QEMU-side select callback runs (regenerating the ACPI payload).
>> Does this action update the blob size in the fw_cfg file directory as
>> well?
>
> I think it doesn't update the blob size on select callback which is
> the root cause of this issue. And the reason looks like,
> qemu_ram_resize() function returns without invoking the callback to
> update the blob size.
>
> On boot up, Qemu builds the table and exposes it to guest,
>       virt_acpi_setup()
>         acpi_add_rom_blob()
>           rom_add_blob()
>             rom_set_mr()  --> mr is allocated here and ram_block used_length = HOST_PAGE_ALIGN(blob size);
>             fw_cfg_add_file_callback()
>               fw_cfg_add_bytes_callback() --> This uses the blob size passed into it.
>
> On select callback path,
>
> virt_acpi_build_update()
>    acpi_ram_update()
>     memory_region_ram_resize()
>       qemu_ram_resize() -->. Here the newsize gets aligned to HOST_PAGE and callback is only called used_length != newsize.
>
> https://github.com/qemu/qemu/blob/master/exec.c#L2180
>
> Debug logs:
> Initial boot:
> ##QEMU_DEBUG## rom_add_blob: file etc/acpi/tables size 0x64f7
> ##QEMU_DEBUG## fw_cfg_add_bytes_callback: key 0x21 len 0x64f7
> ........
> ........
> ###UEFI#### InstallQemuFwCfgTables: "etc/table-loader" has FwCfgItem 0x27 size 0xD00
> ##QEMU_DEBUG## virt_acpi_build_update:
> ##QEMU_DEBUG## acpi_ram_update: size 0x64f7
> ##QEMU_DEBUG## qemu_ram_resize: idstr /rom@etc/acpi/tables used_length  0x7000 newsize 0x7000 --> No callback.
> .....
> ######UEFI###### ProcessCmdAllocate: QemuFwCfgFindFile("etc/acpi/tables"): size 0x64F7 --> UEFI get the actual size, which is fine for now.
>
> Hot-add nvdimms and reboot.
>
> root@ubuntu:/# reboot
> .......
> ........
> ###UEFI#### InstallQemuFwCfgTables: "etc/table-loader" has FwCfgItem 0x27 size 0xD00
> ##QEMU_DEBUG## virt_acpi_build_update:
> ##QEMU_DEBUG## acpi_ram_update: size 0x6667 --> Size changed.
> ##QEMU_DEBUG## qemu_ram_resize: idstr /rom@etc/acpi/tables used_length  0x7000 newsize 0x7000 --> newsize is still aligned to 0x7000 and no callback to update.
> ......
> ######UEFI###### ProcessCmdAllocate: QemuFwCfgFindFile("etc/acpi/tables"): size 0x64F7 -->UEFI still sees the old value and fails.
>
> This can be fixed by,
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c index f3bd45675b..79da3fd35d 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -854,6 +854,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>          build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
>      }
>
> +    g_array_set_size(tables_blob,
> +                    TARGET_PAGE_ALIGN(acpi_data_len(tables_blob)));
> +
>      /* Cleanup memory that's no longer used. */
>      g_array_free(table_offsets, true);
>  }
>
> But I am not sure this is the best to way fix this issue (Or I am
> missing something here).
>
> Please let me know.

The above QEMU patch, for virt_acpi_build(), may be necessary, but I
don't think it is sufficient.

For the firmware to see the updated (enlarged) blob, two things are
required:

(a) QEMU to update the blob size in the fw_cfg directory entry.

Note: to the firmware, it is totally irrelevant if QEMU updates some
*other* value or field that reflects the fresh blob size. The only thing
the firmware can see is the entry in the FW_CFG_FILE_DIR blob.

To illustrate the field I'm referring to, see:

    s->files->f[index].size   = cpu_to_be32(len);

in fw_cfg_add_file_callback().

See also:

            s->files->f[i].size   = cpu_to_be32(len);

in fw_cfg_modify_file().

That "size" field is what the firmware can see.

Note: *all* relevant fw_cfg files must have their "size" fields updated
in the directory blob (FW_CFG_FILE_DIR). I.e. the requirement applies to
both the linker-loader script, and to all blobs that are referenced (by
name) by the commands in the linker-loader script.


(b) The firmware to re-read the size from the directory, after selecting
the key for the sake of ACPI regeneration.

I wrote:

>> If it does, then I can work around the problem in the firmware. I can
>> add a re-lookup to the code after the item selection, in order to get
>> the fresh blob size from the fw_cfg file directory. Then we can use
>> that size for the actual transfer.
>>
>> This won't help old firmware on new QEMU, but at least new firmware
>> on old QEMU will not be hurt (the re-fetching of the fw_cfg file
>> directory will come with a small performance penalty, but
>> functionally it will be a no-op).

Thus, the firmware patch in question would be:

| diff --git a/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c b/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c
| index bc1a891dbaf1..07f70ffe158a 100644
| --- a/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c
| +++ b/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c
| @@ -975,6 +975,24 @@ InstallQemuFwCfgTables (
|    ORDERED_COLLECTION       *SeenPointers;
|    ORDERED_COLLECTION_ENTRY *SeenPointerEntry, *SeenPointerEntry2;
|
| +  Status = QemuFwCfgFindFile ("etc/table-loader", &FwCfgItem, &FwCfgSize);
| +  if (EFI_ERROR (Status)) {
| +    return Status;
| +  }
| +
| +  //
| +  // By selecting "FwCfgItem", ask QEMU to regenerate the ACPI payload, with
| +  // all PCI devices decoding their resources. Note: further selections
| +  // of the same key will not repeat the patching.
| +  //
| +  EnablePciDecoding (&OriginalPciAttributes, &OriginalPciAttributesCount);
| +  QemuFwCfgSelectItem (FwCfgItem);
| +  RestorePciDecoding (OriginalPciAttributes, OriginalPciAttributesCount);
| +
| +  //
| +  // The size of the script may have changed, possibly due to platform devices
| +  // having been hot-plugged before platform reset. Re-read the size.
| +  //
|    Status = QemuFwCfgFindFile ("etc/table-loader", &FwCfgItem, &FwCfgSize);
|    if (EFI_ERROR (Status)) {
|      return Status;
| @@ -989,10 +1007,8 @@ InstallQemuFwCfgTables (
|    if (LoaderStart == NULL) {
|      return EFI_OUT_OF_RESOURCES;
|    }
| -  EnablePciDecoding (&OriginalPciAttributes, &OriginalPciAttributesCount);
|    QemuFwCfgSelectItem (FwCfgItem);
|    QemuFwCfgReadBytes (FwCfgSize, LoaderStart);
| -  RestorePciDecoding (OriginalPciAttributes, OriginalPciAttributesCount);
|    LoaderEnd = LoaderStart + FwCfgSize / sizeof *LoaderEntry;
|
|    AllocationsRestrictedTo32Bit = NULL;

But, again, this only makes sense if QEMU implements (a).

Thanks
Laszlo

