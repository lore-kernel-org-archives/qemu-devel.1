Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEAAC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBC8206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBC8206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsD7U-0002zJ-9u
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 17:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57943)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hsD6v-0002UJ-Ld
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hsD6t-00009W-UE
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:23:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34112)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hsD6p-00005l-VN; Mon, 29 Jul 2019 17:23:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A20E85550;
 Mon, 29 Jul 2019 21:23:07 +0000 (UTC)
Received: from [10.18.17.74] (dhcp-17-74.bos.redhat.com [10.18.17.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86AB610016EA;
 Mon, 29 Jul 2019 21:23:06 +0000 (UTC)
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190723221940.25585-1-dmitry.fomichev@wdc.com>
 <6d6bc169-49d8-8baf-99db-c99d066d59f6@redhat.com>
 <c6ed95a593b31a6a0edce7426d4bcd12538c1fda.camel@wdc.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <39c0e037-610c-23bd-e79e-588ed5af3e91@redhat.com>
Date: Mon, 29 Jul 2019 17:23:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c6ed95a593b31a6a0edce7426d4bcd12538c1fda.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 29 Jul 2019 21:23:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/4] virtio/block: handle
 zoned backing devices
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/26/19 7:42 PM, Dmitry Fomichev wrote:
> John, please see inline...
> 
> Regards,
> Dmitry
> 
> On Thu, 2019-07-25 at 13:58 -0400, John Snow wrote:
>>
>> On 7/23/19 6:19 PM, Dmitry Fomichev wrote:
>>> Currently, attaching zoned block devices (i.e., storage devices
>>> compliant to ZAC/ZBC standards) using several virtio methods doesn't
>>> work properly as zoned devices appear as regular block devices at the
>>> guest. This may cause unexpected i/o errors and, potentially, some
>>> data corruption.
>>>
>>
>> Hi, I'm quite uninitiated here, what's a zoned block device? What are
>> the ZAC/ZBC standards?
> Zoned block devices (ZBDs) are HDDs that use SMR (shingled magnetic
> recording). This type of recording, if applied to the entire drive, would
> only allow the drive to be written sequentially. To make such devices more
> practical, the entire LBA range of the drive is divided into zones. All
> writes within a particular zone must be sequential, but writing different
> zones can be done concurrently in random manner. This sounds like a lot of
> hassle, but in return SMR can achieve up to 20% better areal data density
> compared to the most common PMR recording.
> 
> The same zoned model is used in up-and-coming NVMe ZNS standard, even
> though the reason for using it in ZNS is different compared to SMR HDDs -
> easier flash erase block management.
> 
> ZBC is an INCITS T10 (SCSI) standard and ZAC is the corresponding T13 (ATA)
> standard.
> 
> The lack of limelight for these standards is explained by the fact that
> these devices are mostly used by cloud infrastructure providers for "cold"
> data storage, a purely enterprise application. Currently, both WDC and
> Seagate produce SMR drives in significant quantities and Toshiba has
> announced support for ZBDs in their future products.
> 
>>>
>> I've found this:
>> https://www.snia.org/sites/default/files/SDC/2016/presentations/smr/DamienLeMoal_ZBC-ZAC_Linux.pdf
>>
> AFAIK, the most useful collection of public resources about zoned block
> devices is this website -
> http://zonedstorage.io
> The site is maintained by our group at WDC (shameless plug here :) ).
> BTW, here is the page containing the links to T10/T13 standards
> (the access might be restricted for non-members of T10/T13 committees) -
> http://zonedstorage.io/introduction/smr/#governing-standards
> 
>> It looks like ZAC/ZBC are new commands -- what happens if we just don't
>> use them, exactly?
> The standards define three models of zoned block devices: drive-managed,
> host-aware and host-managed.
> 
> Drive-managed zoned devices behave just like regular SCSI/ATA devices and
> don't require any additional support. There is no point for manufacturers
> to market such devices as zoned. Host-managed and host-aware devices can
> read data exactly the same way as common SCSI/ATA drives, but there are
> I/O pattern limitations in the write path that the host must adhere to.
> 
> Host-aware drives will work without I/O errors under purely random write
> workload, but their performance might be significantly degraded
> compared to running them under zone-sequential workload. With
> host-managed drives, any non-sequential writes within zones will lead
> to an I/O error, most likely, "unaligned write".
> 
> It is important to mention that almost all zoned devices that are
> currently on the market are host-managed.
> 

OK, understood.

> ZAC/ZBC standards do add some new commands to the common SCSI/ACS command
> sets, but, at least for the host-managed model, it wouldn't be sufficient
> just to never issue these commands to be able to utilize these devices.
> 
>>
>>> To be more precise, attaching a zoned device via virtio-pci-blk,
>>> virtio-scsi-pci/scsi-disk or virtio-scsi-pci/scsi-hd demonstrates the
>>> above behavior. The virtio-scsi-pci/scsi-block method works with a
>>> recent patch. The virtio-scsi-pci/scsi-generic method also appears to
>>> handle zoned devices without problems.
>>>
>>
>> What exactly fails, out of curiosity?
> The current Linux kernel is able to recognize zoned block devices and
> provide some means for the user to see that a particular device is zoned.
> For example, lsscsi will show "zbc" instead of "disk" for zoned devices.
> Another useful value is the "zoned" sysfs attribute that carries the
> zoned model of the drive. Without this patch, the attachment methods
> mentioned above present host-managed drives as regular drives at the
> guest system. There is no way for the user to figure out that they are
> dealing with a ZBD besides starting I/O and getting "unaligned write"
> error.
> 

Mmhmm...

> The folks who designed ZAC/ZBC were very careful about this not to
> happen and this doesn't happen on bare metal. Host-managed drives have
> a distinctive SCSI device type, 0x14, and old kernels without zoned
> device support simply are not be able to classify these drives during
> the device scan. The kernels with ZBD support are able to recognize
> a host-managed drive by its SCSI type and read some additional
> protocol-specific info from the drive that is necessary for the kernel
> to support it (how? see http://zonedstorage.io/linux/sched/).
> In QEMU, this SCSI device type mechanism currently only works for
> attachment methods that directly pass SCSI commands to the host OS
> during the initial device scan, i.e. scsi-block and scsi-generic.
> All other methods should be disabled until a meaningful way of handling
> ZBDs is developed for each of them (or disabled permanently for "legacy"
> attachment methods).
> 
>>
>> Naively, it seems strange to me that you'd have something that presents
>> itself as a block device but can't be used like one. Usually I expect to
>> see new features / types of devices used inefficiently when we aren't
>> aware of a special attribute/property they have, but not create data
>> corruption.
> Data corruption can theoretically happen, for example, if a regular hard
> drive is accidentally swapped for a zoned one in a complex environment
> under I/O. Any environment where this can potentially be a problem must
> have udev rules defined to prevent this situation. Without this type of
> patch, these udev rules will not work.
>>
>> The only reason I ask is because it seems odd that you need to add a
>> special flag to e.g. legacy IDE devices that explicitly says they don't
>> support zoned block devices -- instead of adding flags to virtio devices
>> that say they explicitly do support that feature set.
> The initial version of the patch set had some bits of code added in the
> drivers that are not capable of supporting zoned devices to check if the
> device is zoned and abort if it is. Kevin and Paolo suggested the current
> approach and I think it's a lot cleaner than the initial attempt since it
> minimizes the necessary changes across the whole set of block drivers. The
> flag is a true/false setting that is set individually by each driver. It
> is in line with two existing flags in blkconf_apply_backend_options(),
> "readonly" and "resizable". There is no "default" setting for any of these.

Thank you for the detailed explanation! This is good information to have
on the ML archive.

I'm still surprised that we need to prohibit IDE specifically from
interacting with drives of this type, as I would have hoped that the
kernel driver beneath our feet would have managed the access for us, but
I guess that's not true?

(If it isn't, I worry what happens if we have a format layer between us
and the baremetal: if we write qcow2 to the block device instead of raw,
even if we advertise to the emulated guest that we're using a zoned
device, we might remap things in/outside of zones and that coordination
is lost, wouldn't it?)

Not that I really desire people to use IDE emulators with fancy new
disks, it just seemed like an unusual patch.

If Kevin and Paolo are on board with the design, it's not my place to
try to begin managing this, it just caught my eye because it touched
something as old as IDE.

Thanks,
--js

