Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B672C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 13:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F402E2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 13:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F402E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0mk2-0006gc-3D
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 09:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i0mij-00061F-0n
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i0mid-0005Bn-5I
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:01:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i0miV-00055C-Aj; Thu, 22 Aug 2019 09:01:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0E623092775;
 Thu, 22 Aug 2019 13:01:25 +0000 (UTC)
Received: from localhost (ovpn-117-251.ams2.redhat.com [10.36.117.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F7CB60BF3;
 Thu, 22 Aug 2019 13:01:22 +0000 (UTC)
Date: Thu, 22 Aug 2019 14:01:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190822130121.GF20491@stefanha-x1.localdomain>
References: <20190816171503.24761-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <20190816171503.24761-1-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 22 Aug 2019 13:01:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: Cancel the pending BH when the
 dataplane is reset
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Xujun Ma <xuma@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Yihuang Yu <yihyu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2019 at 07:15:03PM +0200, Philippe Mathieu-Daud=E9 wrote:
> When 'system_reset' is called, the main loop clear the memory
> region cache before the BH has a chance to execute. Later when
> the deferred function is called, some assumptions that were
> made when scheduling them are no longer true when they actually
> execute.
>=20
> This is what happens using a virtio-blk device (fresh RHEL7.8 install):
>=20
>  $ (sleep 12.3; echo system_reset; sleep 12.3; echo system_reset; sleep 1=
; echo q) \
>    | qemu-system-x86_64 -m 4G -smp 8 -boot menu=3Don \
>      -device virtio-blk-pci,id=3Dimage1,drive=3Ddrive_image1 \
>      -drive file=3D/var/lib/libvirt/images/rhel78.qcow2,if=3Dnone,id=3Ddr=
ive_image1,format=3Dqcow2,cache=3Dnone \
>      -device virtio-net-pci,netdev=3Dnet0,id=3Dnic0,mac=3D52:54:00:c4:e7:=
84 \
>      -netdev tap,id=3Dnet0,script=3D/bin/true,downscript=3D/bin/true,vhos=
t=3Don \
>      -monitor stdio -serial null -nographic
>   (qemu) system_reset
>   (qemu) system_reset
>   (qemu) qemu-system-x86_64: hw/virtio/virtio.c:225: vring_get_region_cac=
hes: Assertion `caches !=3D NULL' failed.
>   Aborted
>=20
>   (gdb) bt
>   Thread 1 (Thread 0x7f109c17b680 (LWP 10939)):
>   #0  0x00005604083296d1 in vring_get_region_caches (vq=3D0x56040a24bdd0)=
 at hw/virtio/virtio.c:227
>   #1  0x000056040832972b in vring_avail_flags (vq=3D0x56040a24bdd0) at hw=
/virtio/virtio.c:235
>   #2  0x000056040832d13d in virtio_should_notify (vdev=3D0x56040a240630, =
vq=3D0x56040a24bdd0) at hw/virtio/virtio.c:1648
>   #3  0x000056040832d1f8 in virtio_notify_irqfd (vdev=3D0x56040a240630, v=
q=3D0x56040a24bdd0) at hw/virtio/virtio.c:1662
>   #4  0x00005604082d213d in notify_guest_bh (opaque=3D0x56040a243ec0) at =
hw/block/dataplane/virtio-blk.c:75
>   #5  0x000056040883dc35 in aio_bh_call (bh=3D0x56040a243f10) at util/asy=
nc.c:90
>   #6  0x000056040883dccd in aio_bh_poll (ctx=3D0x560409161980) at util/as=
ync.c:118
>   #7  0x0000560408842af7 in aio_dispatch (ctx=3D0x560409161980) at util/a=
io-posix.c:460
>   #8  0x000056040883e068 in aio_ctx_dispatch (source=3D0x560409161980, ca=
llback=3D0x0, user_data=3D0x0) at util/async.c:261
>   #9  0x00007f10a8fca06d in g_main_context_dispatch () at /lib64/libglib-=
2.0.so.0
>   #10 0x0000560408841445 in glib_pollfds_poll () at util/main-loop.c:215
>   #11 0x00005604088414bf in os_host_main_loop_wait (timeout=3D0) at util/=
main-loop.c:238
>   #12 0x00005604088415c4 in main_loop_wait (nonblocking=3D0) at util/main=
-loop.c:514
>   #13 0x0000560408416b1e in main_loop () at vl.c:1923
>   #14 0x000056040841e0e8 in main (argc=3D20, argv=3D0x7ffc2c3f9c58, envp=
=3D0x7ffc2c3f9d00) at vl.c:4578
>=20
> Fix this by cancelling the BH when the virtio dataplane is stopped.
>=20
> Reported-by: Yihuang Yu <yihyu@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1839428
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  hw/block/dataplane/virtio-blk.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-=
blk.c
> index 9299a1a7c2..4030faa21d 100644
> --- a/hw/block/dataplane/virtio-blk.c
> +++ b/hw/block/dataplane/virtio-blk.c
> @@ -301,6 +301,8 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
>      /* Clean up guest notifier (irq) */
>      k->set_guest_notifiers(qbus->parent, nvqs, false);
> =20
> +    qemu_bh_cancel(s->bh);
> +
>      vblk->dataplane_started =3D false;
>      s->stopping =3D false;
>  }
> --=20
> 2.20.1
>=20

Along the lines of what John said:

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-bl=
k.c
index 9299a1a7c2..4030faa21d 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -301,6 +301,8 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
+    qemu_bh_cancel(s->bh);
+    notify_guest_bh(s); /* final chance to notify guest */
+
     /* Clean up guest notifier (irq) */
     k->set_guest_notifiers(qbus->parent, nvqs, false);
=20
     vblk->dataplane_started =3D false;
     s->stopping =3D false;
 }

Let's notify the guest if any batched notifications are waiting.  This
ensures that no notifications are lost when dataplane is stopped.

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1ekiEACgkQnKSrs4Gr
c8hI/gf/QkoBce27m8MDIaXY0VDbfLYgO5LMl452EB3zMSaNVtv+D8GF8AasR2AK
mnUE8tp+NhyD7+C3jZRvw8POftH1dnsikwTHVLU/kGn867gyzxlFIYHepAQy3Lxv
2GqUNNiFRQ0ghFGvbULWzP9efaGPwlAbYj6ZqDzit/1bIitVyO2OWHnCxvpDssXm
D9Ib3mXJtXvYTcQk1ERj5UABwc3VDIcfF/hzlqeFoJ0lb90VFnzrxiAPSKf3661r
Yp8UxfX+aL/oRjFCyJgaarQD+gAHgeh6YchQV8zG5Sl8ncFFbcraFmcjN7M/5wSd
F3GrbSyA0jhGtuM8fZCXHTriiVBFBA==
=yInJ
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--

