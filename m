Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC5EC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54CD920692
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CD920692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMXut-0004Lv-Fp
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 10:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1jMXuH-0003ec-Uu
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1jMXuF-0006Qt-Jr
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:11:48 -0400
Received: from gecko.sbs.de ([194.138.37.40]:59321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1jMXuF-0006Ds-AP
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:11:47 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 039EBNun002817
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Apr 2020 16:11:23 +0200
Received: from [139.22.34.184] ([139.22.34.184])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 039EBLIk014322;
 Thu, 9 Apr 2020 16:11:22 +0200
Subject: Re: [RFC][PATCH v2 0/3] IVSHMEM version 2 device for QEMU
To: Liang Yan <lyan@suse.com>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1578407802.git.jan.kiszka@siemens.com>
 <e11366c8-44e6-2d58-7c0a-f49e497cc240@suse.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <883ab460-77c2-a324-6c8b-eb2e74f6458c@siemens.com>
Date: Thu, 9 Apr 2020 16:11:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e11366c8-44e6-2d58-7c0a-f49e497cc240@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 194.138.37.40
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
Cc: Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.04.20 15:52, Liang Yan wrote:
> 
> 
> On 1/7/20 9:36 AM, Jan Kiszka wrote:
>> Overdue update of the ivshmem 2.0 device model as presented at [1].
>>
>> Changes in v2:
>>   - changed PCI device ID to Siemens-granted one,
>>     adjusted PCI device revision to 0
>>   - removed unused feature register from device
>>   - addressed feedback on specification document
>>   - rebased over master
>>
>> This version is now fully in sync with the implementation for Jailhouse
>> that is currently under review [2][3], UIO and virtio-ivshmem drivers
>> are shared. Jailhouse will very likely pick up this revision of the
>> device in order to move forward with stressing it.
>>
>> More details on the usage with QEMU were in the original cover letter
>> (with adjustements to the new device ID):
>>
>> If you want to play with this, the basic setup of the shared memory
>> device is described in patch 1 and 3. UIO driver and also the
>> virtio-ivshmem prototype can be found at
>>
>>      http://git.kiszka.org/?p=linux.git;a=shortlog;h=refs/heads/queues/ivshmem2
>>
>> Accessing the device via UIO is trivial enough. If you want to use it
>> for virtio, this is additionally to the description in patch 3 needed on
>> the virtio console backend side:
>>
>>      modprobe uio_ivshmem
>>      echo "110a 4106 1af4 1100 ffc003 ffffff" > /sys/bus/pci/drivers/uio_ivshmem/new_id
>>      linux/tools/virtio/virtio-ivshmem-console /dev/uio0
>>
>> And for virtio block:
>>
>>      echo "110a 4106 1af4 1100 ffc002 ffffff" > /sys/bus/pci/drivers/uio_ivshmem/new_id
>>      linux/tools/virtio/virtio-ivshmem-console /dev/uio0 /path/to/disk.img
>>
>> After that, you can start the QEMU frontend instance with the
>> virtio-ivshmem driver installed which can use the new /dev/hvc* or
>> /dev/vda* as usual.
>>
> Hi, Jan,
> 
> Nice work.
> 
> I did a full test for your this new version. QEMU device part looks
> good, virtio console worked as expected. Just had some issue with
> virtio-ivshmem-block tests here.
> 
> I suppose you mean "linux/tools/virtio/virtio-ivshmem-block"?

Yes, copy&paste mistake, had the same issue over in 
https://github.com/siemens/jailhouse/blob/master/Documentation/inter-cell-communication.md

> 
> Noticed "ffc002" is the main difference, however I saw nothing response
> when run echo command here, are there anything I need to prepare?
> 
> I build the driver in guest kernel already.
> 
> Do I need a new protocol or anything for below command line?
> ivshmem2-server -F -l 64K -n 2 -V 3 -P 0x8003

Yes, you need to adjust that command line - didn't I document that 
somewhere? Looks like I didn't:

ivshmem2-server -F -l 1M -n 2 -V 2 -P 0x8002

i.e. a bit more memory is good (but this isn't speed-optimized anyway), 
you only need 2 vectors here (but more do not harm), and the protocol 
indeed needs adjustment (that is the key).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

