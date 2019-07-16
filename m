Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5FCC76191
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D90220880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D90220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnCs1-00055H-PU
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 22:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37464)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lizhengui@huawei.com>) id 1hnCrp-0004YZ-Tt
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lizhengui@huawei.com>) id 1hnCro-0003cu-Cx
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:06:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2173 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lizhengui@huawei.com>)
 id 1hnCrk-0003WE-3u; Mon, 15 Jul 2019 22:06:52 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 463F96D914E309D2DAF4;
 Tue, 16 Jul 2019 10:06:43 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.193) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0;
 Tue, 16 Jul 2019 10:06:38 +0800
References: <687efc8c-e081-7cca-cf69-8db9903d0f7f@huawei.com>
To: <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>
From: l00284672 <lizhengui@huawei.com>
X-Forwarded-Message-Id: <687efc8c-e081-7cca-cf69-8db9903d0f7f@huawei.com>
Message-ID: <cf6d17e2-142f-ffd3-78df-da47e2c25fec@huawei.com>
Date: Tue, 16 Jul 2019 10:06:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <687efc8c-e081-7cca-cf69-8db9903d0f7f@huawei.com>
Content-Type: multipart/mixed; boundary="------------A38EC4ED9770E6CCC7A23409"
Content-Language: en-US
X-Originating-IP: [10.177.251.193]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] Fwd: virtio_scsi_ctx_check failed when detach
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--------------A38EC4ED9770E6CCC7A23409
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable




-------- Forwarded Message --------
Subject: 	virtio_scsi_ctx_check failed when detach virtio_scsi disk
Date: 	Mon, 15 Jul 2019 23:34:24 +0800
From: 	l00284672 <lizhengui@huawei.com>
To: 	kwolf@redhat.com, berto@igalia.com, Stefan Hajnoczi=20
<stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
CC: 	lizhengui@huawei.com



I found a problem=C2=A0 that virtio_scsi_ctx_check=C2=A0 failed when deta=
ching=20
virtio_scsi disk.=C2=A0 The=C2=A0 bt is below:

(gdb) bt
#0=C2=A0 0x0000ffffb02e1bd0 in raise () from /lib64/libc.so.6
#1=C2=A0 0x0000ffffb02e2f7c in abort () from /lib64/libc.so.6
#2=C2=A0 0x0000ffffb02db124 in __assert_fail_base () from /lib64/libc.so.=
6
#3=C2=A0 0x0000ffffb02db1a4 in __assert_fail () from /lib64/libc.so.6
#4=C2=A0 0x00000000004eb9a8 invirtio_scsi_ctx_check (d=3Dd@entry=3D0xc70d=
790,=20
s=3D<optimized out>, s=3D<optimized out>)
 =C2=A0=C2=A0=C2=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scs=
i.c:243
#5=C2=A0 0x00000000004ec87c in virtio_scsi_handle_cmd_req_prepare=20
(s=3Ds@entry=3D0xd27a7a0, req=3Dreq@entry=3D0xafc4b90)
 =C2=A0=C2=A0=C2=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scs=
i.c:553
#6=C2=A0 0x00000000004ecc20 in virtio_scsi_handle_cmd_vq (s=3D0xd27a7a0,=20
vq=3D0xd283410)
 =C2=A0=C2=A0=C2=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scs=
i.c:588
#7=C2=A0 0x00000000004eda20 in virtio_scsi_data_plane_handle_cmd (vdev=3D=
0x0,=20
vq=3D0xffffae7a6f98)
 =C2=A0=C2=A0=C2=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scs=
i-dataplane.c:57
#8=C2=A0 0x0000000000877254 in aio_dispatch (ctx=3D0xac61010) at=20
util/aio-posix.c:323
#9=C2=A0 0x00000000008773ec in aio_poll (ctx=3D0xac61010, blocking=3Dtrue=
) at=20
util/aio-posix.c:472
#10 0x00000000005cd7cc in iothread_run (opaque=3D0xac5e4b0) at iothread.c=
:49
#11 0x000000000087a8b8 in qemu_thread_start (args=3D0xac61360) at=20
util/qemu-thread-posix.c:495
#12 0x00000000008a04e8 in thread_entry_for_hotfix (pthread_cb=3D0x0) at=20
uvp/hotpatch/qemu_hotpatch_helper.c:579
#13 0x0000ffffb041c8bc in start_thread () from /lib64/libpthread.so.0
#14 0x0000ffffb0382f8c in thread_start () from /lib64/libc.so.6

assert(blk_get_aio_context(d->conf.blk) =3D=3D s->ctx) failed.

I think this patch=20
(https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Da6f230c8d13a7ff3a0=
c7f1097412f44bfd9eff0b)=20
introduce this problem.

commit a6f230c8d13a7ff3a0c7f1097412f44bfd9eff0b=C2=A0 move blockbackend b=
ack=20
to main AioContext on unplug. It set the AioContext of

SCSIDevice=C2=A0 to the main AioContex, but s->ctx is still the iothread=20
AioContext.=C2=A0 Is this a bug?


--------------A38EC4ED9770E6CCC7A23409
Content-Type: text/x-vcard; name="lizhengui.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lizhengui.vcf"

bnVsbA==
--------------A38EC4ED9770E6CCC7A23409--

