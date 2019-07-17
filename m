Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47867C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 07:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2059B20665
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 07:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2059B20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hne6Q-0004DK-4h
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 03:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51438)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lizhengui@huawei.com>) id 1hne6C-0003fy-6p
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lizhengui@huawei.com>) id 1hne6A-0003dh-RD
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:11:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:32972 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lizhengui@huawei.com>)
 id 1hne66-0003Rc-Ll; Wed, 17 Jul 2019 03:11:31 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C471491D3108C600A716;
 Wed, 17 Jul 2019 15:11:17 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.193) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0;
 Wed, 17 Jul 2019 15:11:07 +0800
From: l00284672 <lizhengui@huawei.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, <berto@igalia.com>, <kwolf@redhat.com>
References: <687efc8c-e081-7cca-cf69-8db9903d0f7f@huawei.com>
 <cf6d17e2-142f-ffd3-78df-da47e2c25fec@huawei.com>
Message-ID: <217e14f3-1e0d-bd52-76c4-c2af0a1f2180@huawei.com>
Date: Wed, 17 Jul 2019 15:10:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <cf6d17e2-142f-ffd3-78df-da47e2c25fec@huawei.com>
Content-Type: multipart/mixed; boundary="------------A95E4C3587AFAEBB5B77E302"
Content-Language: en-US
X-Originating-IP: [10.177.251.193]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] Fwd: virtio_scsi_ctx_check failed when detach
 virtio_scsi disk
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
Cc: lizhengui@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--------------A95E4C3587AFAEBB5B77E302
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

ping?


On 2019/7/16 10:06, l00284672 wrote:
>
>
>
>
> -------- Forwarded Message --------
> Subject: 	virtio_scsi_ctx_check failed when detach virtio_scsi disk
> Date: 	Mon, 15 Jul 2019 23:34:24 +0800
> From: 	l00284672 <lizhengui@huawei.com>
> To: 	kwolf@redhat.com, berto@igalia.com, Stefan Hajnoczi=20
> <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
> CC: 	lizhengui@huawei.com
>
>
>
> I found a problem=C2=A0 that virtio_scsi_ctx_check=C2=A0 failed when de=
taching=20
> virtio_scsi disk.=C2=A0 The=C2=A0 bt is below:
>
> (gdb) bt
> #0=C2=A0 0x0000ffffb02e1bd0 in raise () from /lib64/libc.so.6
> #1=C2=A0 0x0000ffffb02e2f7c in abort () from /lib64/libc.so.6
> #2=C2=A0 0x0000ffffb02db124 in __assert_fail_base () from /lib64/libc.s=
o.6
> #3=C2=A0 0x0000ffffb02db1a4 in __assert_fail () from /lib64/libc.so.6
> #4=C2=A0 0x00000000004eb9a8 invirtio_scsi_ctx_check (d=3Dd@entry=3D0xc7=
0d790,=20
> s=3D<optimized out>, s=3D<optimized out>)
> =C2=A0=C2=A0=C2=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-sc=
si.c:243
> #5=C2=A0 0x00000000004ec87c in virtio_scsi_handle_cmd_req_prepare=20
> (s=3Ds@entry=3D0xd27a7a0, req=3Dreq@entry=3D0xafc4b90)
> =C2=A0=C2=A0=C2=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-sc=
si.c:553
> #6=C2=A0 0x00000000004ecc20 in virtio_scsi_handle_cmd_vq (s=3D0xd27a7a0=
,=20
> vq=3D0xd283410)
> =C2=A0=C2=A0=C2=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-sc=
si.c:588
> #7=C2=A0 0x00000000004eda20 in virtio_scsi_data_plane_handle_cmd (vdev=3D=
0x0,=20
> vq=3D0xffffae7a6f98)
> =C2=A0=C2=A0=C2=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-sc=
si-dataplane.c:57
> #8=C2=A0 0x0000000000877254 in aio_dispatch (ctx=3D0xac61010) at=20
> util/aio-posix.c:323
> #9=C2=A0 0x00000000008773ec in aio_poll (ctx=3D0xac61010, blocking=3Dtr=
ue) at=20
> util/aio-posix.c:472
> #10 0x00000000005cd7cc in iothread_run (opaque=3D0xac5e4b0) at iothread=
.c:49
> #11 0x000000000087a8b8 in qemu_thread_start (args=3D0xac61360) at=20
> util/qemu-thread-posix.c:495
> #12 0x00000000008a04e8 in thread_entry_for_hotfix (pthread_cb=3D0x0) at=
=20
> uvp/hotpatch/qemu_hotpatch_helper.c:579
> #13 0x0000ffffb041c8bc in start_thread () from /lib64/libpthread.so.0
> #14 0x0000ffffb0382f8c in thread_start () from /lib64/libc.so.6
>
> assert(blk_get_aio_context(d->conf.blk) =3D=3D s->ctx) failed.
>
> I think this patch=20
> (https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Da6f230c8d13a7ff3=
a0c7f1097412f44bfd9eff0b)=20
> introduce this problem.
>
> commit a6f230c8d13a7ff3a0c7f1097412f44bfd9eff0b=C2=A0 move blockbackend=
=20
> back to main AioContext on unplug. It set the AioContext of
>
> SCSIDevice=C2=A0 to the main AioContex, but s->ctx is still the iothrea=
d=20
> AioContext.=C2=A0 Is this a bug?
>


--------------A95E4C3587AFAEBB5B77E302
Content-Type: text/x-vcard; name="lizhengui.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lizhengui.vcf"

bnVsbA==
--------------A95E4C3587AFAEBB5B77E302--

