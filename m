Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E8BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE1C2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQ/3DUXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE1C2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96Xu-0000J7-SR
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 08:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k96X5-0007oc-0d
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k96X3-0003lI-5p
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598014352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwnQSnOdO0kzAmPMy82NWYC6HgtCxJmPxf8n4fk2n/8=;
 b=EQ/3DUXWSVy5Y3AKgy5ymmjC12q+Sw6BiIGuHcMmzbtVV5ZeT8eIUMrIZL81HIXGhH4Hqf
 7IjLJQpzEInXqR26ehJpPnD4Y4tu9JW6BU9C36gBiciZMnfTvo/r+Hl8YiMkG8VAQIbhYu
 P5zJYkEW6cbykjrrECD6+WMoFhGA4To=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-eqv9TipnNLS6Eb-VEZ0JKg-1; Fri, 21 Aug 2020 08:52:27 -0400
X-MC-Unique: eqv9TipnNLS6Eb-VEZ0JKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B5C71DE05;
 Fri, 21 Aug 2020 12:52:26 +0000 (UTC)
Received: from localhost (ovpn-114-118.ams2.redhat.com [10.36.114.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 797ED71780;
 Fri, 21 Aug 2020 12:52:24 +0000 (UTC)
Date: Fri, 21 Aug 2020 13:52:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
Message-ID: <20200821125223.GH205318@stefanha-x1.localdomain>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
 <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
MIME-Version: 1.0
In-Reply-To: <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="54u2kuW9sGWg/X+X"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, fam@euphon.net, qemu-block@nongnu.org,
 armbru@redhat.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 09:54:08PM +0800, Zhenyu Ye wrote:
> Hi Kevin,
>=20
> On 2020/8/10 23:38, Kevin Wolf wrote:
> > Am 10.08.2020 um 16:52 hat Zhenyu Ye geschrieben:
> >> Before doing qmp actions, we need to lock the qemu_global_mutex,
> >> so the qmp actions should not take too long time.
> >>
> >> Unfortunately, some qmp actions need to acquire aio context and
> >> this may take a long time.  The vm will soft lockup if this time
> >> is too long.
> >=20
> > Do you have a specific situation in mind where getting the lock of an
> > AioContext can take a long time? I know that the main thread can
> > block for considerable time, but QMP commands run in the main thread, s=
o
> > this patch doesn't change anything for this case. It would be effective
> > if an iothread blocks, but shouldn't everything running in an iothread
> > be asynchronous and therefore keep the AioContext lock only for a short
> > time?
> >=20
>=20
> Theoretically, everything running in an iothread is asynchronous. However=
,
> some 'asynchronous' actions are not non-blocking entirely, such as
> io_submit().  This will block while the iodepth is too big and I/O pressu=
re
> is too high.  If we do some qmp actions, such as 'info block', at this ti=
me,
> may cause vm soft lockup.  This series can make these qmp actions safer.
>=20
> I constructed the scene as follow:
> 1. create a vm with 4 disks, using iothread.
> 2. add press to the CPU on the host.  In my scene, the CPU usage exceeds =
95%.
> 3. add press to the 4 disks in the vm at the same time.  I used the fio a=
nd
> some parameters are:
>=20
> =09 fio -rw=3Drandrw -bs=3D1M -size=3D1G -iodepth=3D512 -ioengine=3Dlibai=
o -numjobs=3D4
>=20
> 4. do block query actions, for example, by virsh:
>=20
> =09virsh qemu-monitor-command [vm name] --hmp info block

Great, thanks for describing a reproducer.

Do you also have a QEMU backtrace?

I'm curious whether io_submit(2) is blocking for 40+ seconds or whether
the softlockup is caused by QEMU code waiting to drain in-flight I/O
requests with the global mutex held.

I'll try to reproduce this here and start with:

  host# perf record -a -e syscalls:sys_enter_io_submit \
                       -e syscalls:sys_exit_io_submit \
                       -e kvm:kvm_exit \
                       -e kvm:kvm_entry

This will allow us to check the io_submit() and vmexit->vmenter timings.

I want to understand this better to be sure that the timeout is really
the only solution before merging this patch. My concern is that relying
on timeouts will hide QEMU bugs that could be fixed instead.

> Then the vm will soft lockup, the calltrace is:
>=20
> [  192.311393] watchdog: BUG: soft lockup - CPU#1 stuck for 42s! [kworker=
/1:1:33]
> [  192.314241] Kernel panic - not syncing: softlockup: hung tasks
> [  192.316370] CPU: 1 PID: 33 Comm: kworker/1:1 Kdump: loaded Tainted: G =
          OEL    4.19.36+ #16
> [  192.318765] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/=
2015
> [  192.325638] Workqueue: events drm_fb_helper_dirty_work
> [  192.roorr327238] Call trace:
> [  192.331528]  dump_backtrace+0x0/0x198
> [  192.332695]  show_stack+0x24/0x30
> [  192.334219]  dump_stack+0xa4/0xcc
> [  192.335578]  panic+0x12c/0x314
> [  192.336565]  watchdog_timoot_fn+0x3e4/0x3e8
> [  192.339984]  __hrtimer_run_queues+0x114/0x358
> [  192.341576]  hrtimer_interrupt+0x104/0x2d8
> [  192.343247]  arch_timer_handler_virt+0x38/0x58
> [  192.345074]  handle_percpu_devid_irq+0x90/0x248
> [  192.347238]  generic_handle_irq+0x34/0x50
> [  192.349536]  __handle_domain_irq+0x68/0xc0
> [  192.351193]  gic_handle_irq+0x6c/0x150
> [  192.352639]  el1_irq+0xb8/0x140
> [  192.353855]  vp_notify+0x28/0x38 [virtio_pci]
> [  192.355646]  virtqueue_kick+0x3c/0x78 [virtio_ring]
> [  192.357539]  virtio_gpu_queue_ctrl_buffer_locked+0x180/0x248 [virtio_g=
pu]
> [  192.359869]  virtio_gpu_queue_ctrl_buffer+0x50/0x78 [virtio_gpu]
> [  192.361456]  virtio_gpu_cmd_resource_flush+0x8c/0xb0 [virtio_gpu]
> [  192.363422]  virtio_gpu_surface_dirty+0x60/0x110 [virtio_gpu]
> [  192.365215]  virtio_gpu_framebuffer_surface_dirty+0x34/0x48 [virtio_gp=
u]
> [  192.367452]  drm_fb_helper_dirty_work+0x178/0x1c0
> [  192.368912]  process_one_work+0x1b4/0x3f8
> [  192.370192]  worker_thread+0x54/0x470
> [  192.371370]  kthread+0x134/0x138
> [  192.379241]  ret_from_fork+0x10/0x18
> [  192.382688] kernel fault(0x5) notification starting on CPU 1
> [  192.385059] kernel fault(0x5) notification finished on CPU 1
> [  192.387311] SMP: stopping secondary CPUs
> [  192.391024] Kernel Offset: disabled
> [  192.392111] CPU features: 0x0,a1806008
> [  192.393306] Memory Limit: none
> [  192.396701] Starting crashdump kernel...
> [  192.397821] Bye!
>=20
> This problem can be avoided after this series applied.
>=20
> Thanks,
> Zhenyu
>=20

--54u2kuW9sGWg/X+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8/w4cACgkQnKSrs4Gr
c8itVQf9E3mJRY75lI1DbbDgOWKABKv/wHZoTxvf6QEWu2+KuXcGxCCSyZFfYkcq
BjIoAGVsGCYisUFap5x0rV+5DltoRlAbbEqErlzvSFuPVQsI+fRu7i0EiUF44fbP
ecNEAnf8MW1qwpqrPEZC0Nr5sE0o53iIJeYqPduw1zUBzULFk5fzvbyPy8FPcI+5
d0nqXTnG/o1/Hh7yCGTq9BUZHW7AsIzLjzzjT3vX7E3O0vdIU4aJcb079vFdOG2+
610jJO3cvrwcKw3z7GbRUSzWBElwRZaNNIcaBvxb3sNTlfYcNIV09kOFWVOPdLNT
tq2ikgE8sRiMsoHtsOEA6HIy5Pwe/A==
=E5I5
-----END PGP SIGNATURE-----

--54u2kuW9sGWg/X+X--


