Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14126C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDCC020880
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCC020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hngWF-0004XJ-1Q
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 05:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41952)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lizhengui@huawei.com>) id 1hngW1-00047i-M6
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lizhengui@huawei.com>) id 1hngW0-0003pl-8i
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:46:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55060 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lizhengui@huawei.com>)
 id 1hngVv-0003lx-Pb; Wed, 17 Jul 2019 05:46:20 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C8DB0417D9736613299C;
 Wed, 17 Jul 2019 17:46:12 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.193) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0;
 Wed, 17 Jul 2019 17:46:09 +0800
To: Kevin Wolf <kwolf@redhat.com>
References: <687efc8c-e081-7cca-cf69-8db9903d0f7f@huawei.com>
 <cf6d17e2-142f-ffd3-78df-da47e2c25fec@huawei.com>
 <20190717084154.GB6471@localhost.localdomain>
From: l00284672 <lizhengui@huawei.com>
Message-ID: <f01d71fe-c26e-a606-5601-d88aacac1bc8@huawei.com>
Date: Wed, 17 Jul 2019 17:45:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20190717084154.GB6471@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------9DCB2A7CBCD7F61F73861F23"
Content-Language: en-US
X-Originating-IP: [10.177.251.193]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: Re: [Qemu-devel] [Qemu-block] Fwd: virtio_scsi_ctx_check failed
 when detach virtio_scsi disk
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--------------9DCB2A7CBCD7F61F73861F23
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

I reproduce it on qemu4.0.0 version again.=C2=A0 The bt is below:

(gdb) bt
#0=C2=A0 0x0000ffff86aacbd0 in raise () from /lib64/libc.so.6
#1=C2=A0 0x0000ffff86aadf7c in abort () from /lib64/libc.so.6
#2=C2=A0 0x0000ffff86aa6124 in __assert_fail_base () from /lib64/libc.so.=
6
#3=C2=A0 0x0000ffff86aa61a4 in __assert_fail () from /lib64/libc.so.6
#4=C2=A0 0x0000000000529118 in virtio_scsi_ctx_check (d=3D<optimized out>=
,=20
s=3D<optimized out>, s=3D<optimized out>) at=20
/home/qemu-4.0.0/hw/scsi/virtio-scsi.c:246
#5=C2=A0 0x0000000000529ec4 in virtio_scsi_handle_cmd_req_prepare=20
(s=3D0x2779ec00, req=3D0xffff740397d0) at=20
/home/qemu-4.0.0/hw/scsi/virtio-scsi.c:559
#6=C2=A0 0x000000000052a228 in virtio_scsi_handle_cmd_vq (s=3D0x2779ec00,=
=20
vq=3D0xffff7c6d7110) at /home/qemu-4.0.0/hw/scsi/virtio-scsi.c:603
#7=C2=A0 0x000000000052afa8 in virtio_scsi_data_plane_handle_cmd=20
(vdev=3D<optimized out>, vq=3D0xffff7c6d7110) at=20
/home/qemu-4.0.0/hw/scsi/virtio-scsi-dataplane.c:59
#8=C2=A0 0x000000000054d94c in virtio_queue_host_notifier_aio_poll=20
(opaque=3D<optimized out>) at /home/qemu-4.0.0/hw/virtio/virtio.c:2452
Backtrace stopped: previous frame identical to this frame (corrupt stack?=
)
(gdb)

The scsi controller is configured with iothread.=C2=A0 Hot unpluging the =
scsi=20
disk may cause this problem if the disk is processing IO because the=20
main thread and the iothread are in parallel.


On 2019/7/17 16:41, Kevin Wolf wrote:
> Am 16.07.2019 um 04:06 hat l00284672 geschrieben:
>> -------- Forwarded Message --------
>> Subject: 	virtio_scsi_ctx_check failed when detach virtio_scsi disk
>> Date: 	Mon, 15 Jul 2019 23:34:24 +0800
>> From: 	l00284672 <lizhengui@huawei.com>
>> To: 	kwolf@redhat.com, berto@igalia.com, Stefan Hajnoczi
>> <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
>> CC: 	lizhengui@huawei.com
>>
>>
>>
>> I found a problem=C2=A0 that virtio_scsi_ctx_check=C2=A0 failed when d=
etaching
>> virtio_scsi disk.=C2=A0 The=C2=A0 bt is below:
>>
>> (gdb) bt
>> #0=C2=A0 0x0000ffffb02e1bd0 in raise () from /lib64/libc.so.6
>> #1=C2=A0 0x0000ffffb02e2f7c in abort () from /lib64/libc.so.6
>> #2=C2=A0 0x0000ffffb02db124 in __assert_fail_base () from /lib64/libc.=
so.6
>> #3=C2=A0 0x0000ffffb02db1a4 in __assert_fail () from /lib64/libc.so.6
>> #4=C2=A0 0x00000000004eb9a8 invirtio_scsi_ctx_check (d=3Dd@entry=3D0xc=
70d790,
>> s=3D<optimized out>, s=3D<optimized out>)
>>  =C2=A0=C2=A0=C2=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-=
scsi.c:243
>> #5=C2=A0 0x00000000004ec87c in virtio_scsi_handle_cmd_req_prepare
>> (s=3Ds@entry=3D0xd27a7a0, req=3Dreq@entry=3D0xafc4b90)
>>  =C2=A0=C2=A0=C2=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-=
scsi.c:553
>> #6=C2=A0 0x00000000004ecc20 in virtio_scsi_handle_cmd_vq (s=3D0xd27a7a=
0,
>> vq=3D0xd283410)
>>  =C2=A0=C2=A0=C2=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-=
scsi.c:588
>> #7=C2=A0 0x00000000004eda20 in virtio_scsi_data_plane_handle_cmd (vdev=
=3D0x0,
>> vq=3D0xffffae7a6f98)
>>  =C2=A0=C2=A0=C2=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-=
scsi-dataplane.c:57
>> #8=C2=A0 0x0000000000877254 in aio_dispatch (ctx=3D0xac61010) at
>> util/aio-posix.c:323
>> #9=C2=A0 0x00000000008773ec in aio_poll (ctx=3D0xac61010, blocking=3Dt=
rue) at
>> util/aio-posix.c:472
>> #10 0x00000000005cd7cc in iothread_run (opaque=3D0xac5e4b0) at iothrea=
d.c:49
>> #11 0x000000000087a8b8 in qemu_thread_start (args=3D0xac61360) at
>> util/qemu-thread-posix.c:495
>> #12 0x00000000008a04e8 in thread_entry_for_hotfix (pthread_cb=3D0x0) a=
t
>> uvp/hotpatch/qemu_hotpatch_helper.c:579
>> #13 0x0000ffffb041c8bc in start_thread () from /lib64/libpthread.so.0
>> #14 0x0000ffffb0382f8c in thread_start () from /lib64/libc.so.6
>>
>> assert(blk_get_aio_context(d->conf.blk) =3D=3D s->ctx) failed.
>>
>> I think this patch (https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;=
h=3Da6f230c8d13a7ff3a0c7f1097412f44bfd9eff0b)
>> introduce this problem.
>>
>> commit a6f230c8d13a7ff3a0c7f1097412f44bfd9eff0b=C2=A0 move blockbacken=
d back to
>> main AioContext on unplug. It set the AioContext of SCSIDevice=C2=A0 t=
o the
>> main AioContex, but s->ctx is still the iothread AioContext.=C2=A0 Is =
this
>> a bug?
> Yes, a failing assertion is always a bug.
>
> The commit you mention doesn't really do anything wrong, because when
> the device is unplugged, there shouldn't be any more requests that coul=
d
> fail an assertion later. If anything, we could have a bug in making sur=
e
> that no requests are in flight any more during unplug, but this would b=
e
> a separate issue.
>
> We fixed some AioContext related bugs recently. Which QEMU version did
> you use when you ran into the bug? Can you try on current git master?
>
> Kevin
>
> .
>


--------------9DCB2A7CBCD7F61F73861F23
Content-Type: text/x-vcard; name="lizhengui.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lizhengui.vcf"

bnVsbA==
--------------9DCB2A7CBCD7F61F73861F23--

