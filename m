Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA52C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C0820663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C0820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK46A-00073b-ML
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iK33Y-0005YO-P6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iK33W-00078u-Ul
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:18:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60371)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iK33R-00070n-S0; Mon, 14 Oct 2019 12:18:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3EB4172644;
 Mon, 14 Oct 2019 16:18:40 +0000 (UTC)
Received: from [10.18.17.152] (dhcp-17-152.bos.redhat.com [10.18.17.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FCE04518;
 Mon, 14 Oct 2019 16:18:38 +0000 (UTC)
Subject: Re: Occasional VM soft lockup when a remote cdrom is attached
To: Guoheyi <guoheyi@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org
References: <a6a0d139-9107-83bd-8ba5-8bdc310f6ca7@huawei.com>
 <182a00dd-a505-d001-085d-02371fa52127@redhat.com>
 <a089680f-519f-f9b3-3f00-22d756be91f9@huawei.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9082e7e9-277a-0cb1-1bb3-891d0ce4c689@redhat.com>
Date: Mon, 14 Oct 2019 12:18:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <a089680f-519f-f9b3-3f00-22d756be91f9@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 14 Oct 2019 16:18:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 wanghaibin 00208455 <wanghaibin.wang@huawei.com>,
 zhengxiang 00421807 <zhengxiang9@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/13/19 10:04 PM, Guoheyi wrote:
> Really appreciate your advice. Some comments below:
>=20
>=20
> On 2019/10/12 3:06, John Snow wrote:
>>
>> On 10/11/19 9:22 AM, Guoheyi wrote:
>>> Hi folks,
>>>
>>> We observed Linux on VM occasionally (at very low rate) got soft lock=
up
>>> when a remote cdrom is attached. The guest hangs up at below call tra=
ce:
>>>
>> That's certainly a new one to me :)
>>
>>> [Tue Oct8 23:02:53 2019]ata_scsi_queuecmd+0xe0/0x2a0 [libata]
>>>
>>> [Tue Oct8 23:02:53 2019]scsi_dispatch_cmd+0xec/0x288
>>>
>>> [Tue Oct8 23:02:53 2019]scsi_queue_rq+0x5f4/0x6b8
>>>
>>> [Tue Oct8 23:02:53 2019]blk_mq_dispatch_rq_list+0xb0/0x690
>>>
>>> [Tue Oct8 23:02:53 2019]blk_mq_do_dispatch_sched+0x8c/0x130
>>>
>>> [Tue Oct8 23:02:53 2019]blk_mq_sched_dispatch_requests+0x128/0x1f0
>>>
>>> [Tue Oct8 23:02:53 2019]__blk_mq_run_hw_queue+0x9c/0x128
>>>
>>> [Tue Oct8 23:02:53 2019]__blk_mq_delay_run_hw_queue+0x198/0x1d8
>>>
>>> [Tue Oct8 23:02:53 2019]blk_mq_run_hw_queue+0x68/0x180
>>>
>>> [Tue Oct8 23:02:53 2019]blk_mq_sched_insert_request+0xbc/0x210
>>>
>>> [Tue Oct8 23:02:53 2019]blk_execute_rq_nowait+0x118/0x168
>>>
>>> [Tue Oct8 23:02:53 2019]blk_execute_rq+0x74/0xd8
>>>
>>> [Tue Oct8 23:02:53 2019]__scsi_execute+0xd8/0x1e0
>>>
>>> [Tue Oct8 23:02:53 2019]sr_check_events+0xd4/0x2c8 [sr_mod]
>>>
>>> [Tue Oct8 23:02:53 2019]cdrom_check_events+0x34/0x50 [cdrom]
>>>
>>> [Tue Oct8 23:02:53 2019]sr_block_check_events+0xdc/0x108 [sr_mod]
>>>
>>> [Tue Oct8 23:02:53 2019]disk_check_events+0x60/0x198
>>>
>>> [Tue Oct8 23:02:53 2019]disk_events_workfn+0x24/0x30
>>>
>>> [Tue Oct8 23:02:53 2019]process_one_work+0x1b4/0x3f8
>>>
>>> [Tue Oct8 23:02:53 2019]worker_thread+0x54/0x470
>>>
>>> [Tue Oct8 23:02:53 2019]kthread+0x134/0x138
>>>
>>> [Tue Oct8 23:02:53 2019]ret_from_fork+0x10/0x18
>>>
>>>
>>> We are running the whole stack on ARM64 platforms, using rcdrom on ho=
st
>>> to connect a remote cdrom, which is appeared as "/dev/sr0" on the hos=
t.
>>> Our Linux kernel version is 4.19.36 and qemu version is 2.8.1, which =
is
>>> fairly old but I checked the mainline and found the work flow does no=
t
>>> change much. And KVM is enabled.
>>>
>>> We provide the remote cdrom to guest as a block device, attached unde=
r
>>> ICH SATA bus.
>>>
>>>
>>> The work flow should be like this (please correct me if I was wrong):
>>>
>>> 1. There is a kworker thread in guest kernel which will check cdrom
>>> status periodically.
>>>
>>> 2. The call of "ata_scsi_queuecmd" in guest will write AHCI port
>>> register "PORT_CMD_ISSUE", so this VCPU thread is trapped out to qemu=
.
>>>
>>> 3. qemu will grab the BQL and then dispatch the access to
>>> ahci_port_write().
>>>
>>> 4. For this is a "get event status notification" command, qemu finall=
y
>>> goes to cmd_get_event_status_notification() and then
>>> cdrom_is_inserted().
>>>
>> via
>>
>> cmd_get_event_status_notification (SCSI 0x4A)
>> =C2=A0=C2=A0 event_status_media
>> =C2=A0=C2=A0=C2=A0=C2=A0 blk_is_inserted
>>
>>> 5. In cdrom_is_inserted(), an ioctl to cdrom fd is issued.
>>>
>> Using the bdrv_host_cdrom BlockDriver, for the .bdrv_is_inserted
>> callback.
>>
>>> However, in the last step, we found the ioctl() may have large latenc=
y,
>>> for it is a virtual device of remote cdrom, when the remote server is
>>> busy and of poor performance. We have observed more than 8 seconds
>>> latency in half an hour test, and the latency might reach more than 2=
0
>>> seconds when guest soft lockup occurred.
>>>
>> I'm not sure what can be done here. the host_cdrom driver has a few
>> methods to query state (cdrom_is_inserted, cdrom_eject,
>> cdrom_lock_medium) and in general code is going to rely on
>> bdrv_is_inserted returning a truthful answer.
>>
>> (I'm not sure we have callbacks established to tell when the backing
>> media we are ourselves relying on has gone away. Maybe it could be
>> added, but it's not there now. We could maybe cache the answer if we h=
ad
>> something reliable.)
>>
>> You could always try using the host_device driver instead of the
>> host_cdrom one, which will just treat it as a "normal" block device
>> instead of a CDROM one, and doesn't use any cdrom specific ioctls. It
>> might avoid the costly call.
> By following this work around, the cdrom device was represented to gues=
t
> as a normal disk ("/dev/sdb"). We are not sure if this will cause more
> functional differences.
>=20

What command line are you using? You should be able to specify the
emulator (ask for device ide-cd) separately from the backend (specify
block driver host_device.)

It might require the use of -blockdev command line flags instead of
sugared variants (-cdrom, -drive.)

>>
>>> My question is, is there any way to get around of this issue? Does it
>>> make sense for qemu to setup an IO thread to issue this ioctl() and l=
et
>>> the VCPU thread return to guest as soon as possible? Or it is kernel'=
s
>>> responsibility to break up the long time ioctl() and return to user
>>> space?
>>>
>> Yeah, I think you could probably try to make this change -- the code i=
s
>> unfortunately very callback-hell-ish with poor abstraction boundaries,
>> but obviously the data transfer commands already defer to bottom halve=
s.
>>
>> (Ideally, I think every ATAPI command would just immediately defer to =
a
>> bottom half, but I don't know what effect that would have on callers o=
f
>> ide_atapi_cmd. I'd have to audit it, and it's quite squiggly.)
>>
>> "Patches welcome" as they say, but it's quite messy down there.
> It sounds like a long term work, especially for we are not familiar wit=
h
> SATA/AHCI devices...
>=20
> Thanks,
>=20
> HG
>=20

Yes, probably. It's low priority right now, but if it becomes more
important you can always try formal channels at RH to get it escalated.

--js.

