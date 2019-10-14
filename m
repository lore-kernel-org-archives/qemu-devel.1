Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94781C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 02:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683462067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 02:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683462067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJpk1-0002w6-KW
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 22:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iJpj9-0002Cm-44
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 22:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iJpj7-0004Rj-KY
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 22:04:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40168 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iJpj4-0004Lo-86; Sun, 13 Oct 2019 22:04:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 57506A485445C1C9F8DC;
 Mon, 14 Oct 2019 10:04:38 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 10:04:30 +0800
Subject: Re: Occasional VM soft lockup when a remote cdrom is attached
To: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 <qemu-block@nongnu.org>
References: <a6a0d139-9107-83bd-8ba5-8bdc310f6ca7@huawei.com>
 <182a00dd-a505-d001-085d-02371fa52127@redhat.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <a089680f-519f-f9b3-3f00-22d756be91f9@huawei.com>
Date: Mon, 14 Oct 2019 10:04:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <182a00dd-a505-d001-085d-02371fa52127@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 wanghaibin 00208455 <wanghaibin.wang@huawei.com>,
 zhengxiang 00421807 <zhengxiang9@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Really appreciate your advice. Some comments below:


On 2019/10/12 3:06, John Snow wrote:
>
> On 10/11/19 9:22 AM, Guoheyi wrote:
>> Hi folks,
>>
>> We observed Linux on VM occasionally (at very low rate) got soft lockup
>> when a remote cdrom is attached. The guest hangs up at below call trace:
>>
> That's certainly a new one to me :)
>
>> [Tue Oct8 23:02:53 2019]ata_scsi_queuecmd+0xe0/0x2a0 [libata]
>>
>> [Tue Oct8 23:02:53 2019]scsi_dispatch_cmd+0xec/0x288
>>
>> [Tue Oct8 23:02:53 2019]scsi_queue_rq+0x5f4/0x6b8
>>
>> [Tue Oct8 23:02:53 2019]blk_mq_dispatch_rq_list+0xb0/0x690
>>
>> [Tue Oct8 23:02:53 2019]blk_mq_do_dispatch_sched+0x8c/0x130
>>
>> [Tue Oct8 23:02:53 2019]blk_mq_sched_dispatch_requests+0x128/0x1f0
>>
>> [Tue Oct8 23:02:53 2019]__blk_mq_run_hw_queue+0x9c/0x128
>>
>> [Tue Oct8 23:02:53 2019]__blk_mq_delay_run_hw_queue+0x198/0x1d8
>>
>> [Tue Oct8 23:02:53 2019]blk_mq_run_hw_queue+0x68/0x180
>>
>> [Tue Oct8 23:02:53 2019]blk_mq_sched_insert_request+0xbc/0x210
>>
>> [Tue Oct8 23:02:53 2019]blk_execute_rq_nowait+0x118/0x168
>>
>> [Tue Oct8 23:02:53 2019]blk_execute_rq+0x74/0xd8
>>
>> [Tue Oct8 23:02:53 2019]__scsi_execute+0xd8/0x1e0
>>
>> [Tue Oct8 23:02:53 2019]sr_check_events+0xd4/0x2c8 [sr_mod]
>>
>> [Tue Oct8 23:02:53 2019]cdrom_check_events+0x34/0x50 [cdrom]
>>
>> [Tue Oct8 23:02:53 2019]sr_block_check_events+0xdc/0x108 [sr_mod]
>>
>> [Tue Oct8 23:02:53 2019]disk_check_events+0x60/0x198
>>
>> [Tue Oct8 23:02:53 2019]disk_events_workfn+0x24/0x30
>>
>> [Tue Oct8 23:02:53 2019]process_one_work+0x1b4/0x3f8
>>
>> [Tue Oct8 23:02:53 2019]worker_thread+0x54/0x470
>>
>> [Tue Oct8 23:02:53 2019]kthread+0x134/0x138
>>
>> [Tue Oct8 23:02:53 2019]ret_from_fork+0x10/0x18
>>
>>
>> We are running the whole stack on ARM64 platforms, using rcdrom on host
>> to connect a remote cdrom, which is appeared as "/dev/sr0" on the host.
>> Our Linux kernel version is 4.19.36 and qemu version is 2.8.1, which is
>> fairly old but I checked the mainline and found the work flow does not
>> change much. And KVM is enabled.
>>
>> We provide the remote cdrom to guest as a block device, attached under
>> ICH SATA bus.
>>
>>
>> The work flow should be like this (please correct me if I was wrong):
>>
>> 1. There is a kworker thread in guest kernel which will check cdrom
>> status periodically.
>>
>> 2. The call of "ata_scsi_queuecmd" in guest will write AHCI port
>> register "PORT_CMD_ISSUE", so this VCPU thread is trapped out to qemu.
>>
>> 3. qemu will grab the BQL and then dispatch the access to
>> ahci_port_write().
>>
>> 4. For this is a "get event status notification" command, qemu finally
>> goes to cmd_get_event_status_notification() and then cdrom_is_inserted().
>>
> via
>
> cmd_get_event_status_notification (SCSI 0x4A)
>    event_status_media
>      blk_is_inserted
>
>> 5. In cdrom_is_inserted(), an ioctl to cdrom fd is issued.
>>
> Using the bdrv_host_cdrom BlockDriver, for the .bdrv_is_inserted callback.
>
>> However, in the last step, we found the ioctl() may have large latency,
>> for it is a virtual device of remote cdrom, when the remote server is
>> busy and of poor performance. We have observed more than 8 seconds
>> latency in half an hour test, and the latency might reach more than 20
>> seconds when guest soft lockup occurred.
>>
> I'm not sure what can be done here. the host_cdrom driver has a few
> methods to query state (cdrom_is_inserted, cdrom_eject,
> cdrom_lock_medium) and in general code is going to rely on
> bdrv_is_inserted returning a truthful answer.
>
> (I'm not sure we have callbacks established to tell when the backing
> media we are ourselves relying on has gone away. Maybe it could be
> added, but it's not there now. We could maybe cache the answer if we had
> something reliable.)
>
> You could always try using the host_device driver instead of the
> host_cdrom one, which will just treat it as a "normal" block device
> instead of a CDROM one, and doesn't use any cdrom specific ioctls. It
> might avoid the costly call.
By following this work around, the cdrom device was represented to guest 
as a normal disk ("/dev/sdb"). We are not sure if this will cause more 
functional differences.

>
>> My question is, is there any way to get around of this issue? Does it
>> make sense for qemu to setup an IO thread to issue this ioctl() and let
>> the VCPU thread return to guest as soon as possible? Or it is kernel's
>> responsibility to break up the long time ioctl() and return to user space?
>>
> Yeah, I think you could probably try to make this change -- the code is
> unfortunately very callback-hell-ish with poor abstraction boundaries,
> but obviously the data transfer commands already defer to bottom halves.
>
> (Ideally, I think every ATAPI command would just immediately defer to a
> bottom half, but I don't know what effect that would have on callers of
> ide_atapi_cmd. I'd have to audit it, and it's quite squiggly.)
>
> "Patches welcome" as they say, but it's quite messy down there.
It sounds like a long term work, especially for we are not familiar with 
SATA/AHCI devices...

Thanks,

HG

>
> --js
>
>> Any comments or advice will be appreciated :)
>>
>>
>> HG
>>
>>
>>
>>
>



