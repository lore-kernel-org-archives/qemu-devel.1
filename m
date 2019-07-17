Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D68C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616522173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616522173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnfW3-0000ap-G9
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 04:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49545)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hnfVr-0008Sv-FX
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hnfVq-0004pX-77
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:42:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hnfVl-0004jj-Jg; Wed, 17 Jul 2019 04:42:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 501A681F19;
 Wed, 17 Jul 2019 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-47.ams2.redhat.com
 [10.36.117.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 558C25C28C;
 Wed, 17 Jul 2019 08:42:00 +0000 (UTC)
Date: Wed, 17 Jul 2019 10:41:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: l00284672 <lizhengui@huawei.com>
Message-ID: <20190717084154.GB6471@localhost.localdomain>
References: <687efc8c-e081-7cca-cf69-8db9903d0f7f@huawei.com>
 <cf6d17e2-142f-ffd3-78df-da47e2c25fec@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <cf6d17e2-142f-ffd3-78df-da47e2c25fec@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 17 Jul 2019 08:42:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

Am 16.07.2019 um 04:06 hat l00284672 geschrieben:
> -------- Forwarded Message --------
> Subject: 	virtio_scsi_ctx_check failed when detach virtio_scsi disk
> Date: 	Mon, 15 Jul 2019 23:34:24 +0800
> From: 	l00284672 <lizhengui@huawei.com>
> To: 	kwolf@redhat.com, berto@igalia.com, Stefan Hajnoczi
> <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
> CC: 	lizhengui@huawei.com
>=20
>=20
>=20
> I found a problem=A0 that virtio_scsi_ctx_check=A0 failed when detachin=
g
> virtio_scsi disk.=A0 The=A0 bt is below:
>=20
> (gdb) bt
> #0=A0 0x0000ffffb02e1bd0 in raise () from /lib64/libc.so.6
> #1=A0 0x0000ffffb02e2f7c in abort () from /lib64/libc.so.6
> #2=A0 0x0000ffffb02db124 in __assert_fail_base () from /lib64/libc.so.6
> #3=A0 0x0000ffffb02db1a4 in __assert_fail () from /lib64/libc.so.6
> #4=A0 0x00000000004eb9a8 invirtio_scsi_ctx_check (d=3Dd@entry=3D0xc70d7=
90,
> s=3D<optimized out>, s=3D<optimized out>)
> =A0=A0=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:243
> #5=A0 0x00000000004ec87c in virtio_scsi_handle_cmd_req_prepare
> (s=3Ds@entry=3D0xd27a7a0, req=3Dreq@entry=3D0xafc4b90)
> =A0=A0=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:553
> #6=A0 0x00000000004ecc20 in virtio_scsi_handle_cmd_vq (s=3D0xd27a7a0,
> vq=3D0xd283410)
> =A0=A0=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:588
> #7=A0 0x00000000004eda20 in virtio_scsi_data_plane_handle_cmd (vdev=3D0=
x0,
> vq=3D0xffffae7a6f98)
> =A0=A0=A0 at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi-datapl=
ane.c:57
> #8=A0 0x0000000000877254 in aio_dispatch (ctx=3D0xac61010) at
> util/aio-posix.c:323
> #9=A0 0x00000000008773ec in aio_poll (ctx=3D0xac61010, blocking=3Dtrue)=
 at
> util/aio-posix.c:472
> #10 0x00000000005cd7cc in iothread_run (opaque=3D0xac5e4b0) at iothread=
.c:49
> #11 0x000000000087a8b8 in qemu_thread_start (args=3D0xac61360) at
> util/qemu-thread-posix.c:495
> #12 0x00000000008a04e8 in thread_entry_for_hotfix (pthread_cb=3D0x0) at
> uvp/hotpatch/qemu_hotpatch_helper.c:579
> #13 0x0000ffffb041c8bc in start_thread () from /lib64/libpthread.so.0
> #14 0x0000ffffb0382f8c in thread_start () from /lib64/libc.so.6
>=20
> assert(blk_get_aio_context(d->conf.blk) =3D=3D s->ctx) failed.
>=20
> I think this patch (https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=
=3Da6f230c8d13a7ff3a0c7f1097412f44bfd9eff0b)
> introduce this problem.
>=20
> commit a6f230c8d13a7ff3a0c7f1097412f44bfd9eff0b=A0 move blockbackend ba=
ck to
> main AioContext on unplug. It set the AioContext of SCSIDevice=A0 to th=
e
> main AioContex, but s->ctx is still the iothread AioContext.=A0 Is this
> a bug?

Yes, a failing assertion is always a bug.

The commit you mention doesn't really do anything wrong, because when
the device is unplugged, there shouldn't be any more requests that could
fail an assertion later. If anything, we could have a bug in making sure
that no requests are in flight any more during unplug, but this would be
a separate issue.

We fixed some AioContext related bugs recently. Which QEMU version did
you use when you ran into the bug? Can you try on current git master?

Kevin

