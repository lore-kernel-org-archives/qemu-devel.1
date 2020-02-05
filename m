Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC7FC352A1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEFC217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pr+bWi/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEFC217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izM80-00086T-7Y
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1izM6w-0006Nf-OG
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1izM6v-0006fk-A9
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:57:02 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1izM6v-0006YU-0k
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:57:01 -0500
Received: by mail-wm1-x342.google.com with SMTP id q9so2810152wmj.5
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 06:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iLtCDDC/RoJTzoC/6xIH/BnyH3RVe1YFQniBC3pjmpM=;
 b=pr+bWi/WSfs8nlyMijB5jQyczcc20jQlnL0i4FGBSpgM+nQTB1WWx/cim3edLFGrgm
 jJo6jgh1ZPxwfWpKRfkVww/ttMzW13bQn+QWjkSRboq6HE65c8g8IB0/2sekD6hp2Tmc
 AxFKFv52hJq67B561QzmeAAbjZEkDhg8w6iE5Tu4PIZ78qdQJzv73Oqpguf3uZsJZdt/
 DCU1r3tJ0IvQ3wlsjkNOBwD1V9PB0EvrXZ1GmmiYf91pqTEEU8gCReitzBBebOW/KgO8
 Om/zj7VFwiC0Oi/ytCNtAfm+5L7Rsrk2KuFSAzSNTPC2dkSLRBSwstvVoB5oyL423eMj
 g0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iLtCDDC/RoJTzoC/6xIH/BnyH3RVe1YFQniBC3pjmpM=;
 b=b/jyXf32o2pldQQeXydtnrtrXasLEade3/9te5WUQPag545xcOcx4ce6xFU3MgWSOW
 4W/Pkc7XFoKjoo0UsMjqdi0Wd+FLg7Bk4h1mmbgSWNedmxYdrPZEdQpCC9hEXNONHItd
 bDcFPLOf+XLPTl8pK6nZVgKdyN4J7gRWiGRT67ybGeLv0xJOvvGvfU0GCEI4f9kEjIMp
 oCtqaplH0Up2E7He1/PFEMynaWhqgW3cL5gZQoLbESF47fzyg8GkNTkp62NyOKbuVP8V
 cHflyPsuTs2fNpzhEs/BzBYMdcIr1MyM5E2JX8pnjCBAv9YHw0ncR+sYK9YsADARJNS4
 DEbw==
X-Gm-Message-State: APjAAAWi4cjZ/K3P/0HUsxAadupZpU81zd0OqrrOZNwL/K189WvioQBo
 /IXLTR7pfSG1BBAxhoHdpnc=
X-Google-Smtp-Source: APXvYqwD+tf+qD/zn8xixW73KJpgvqlVchBZTu9MqbLo6R3OopFPNdNQ7oKRn3haAWgmt+bPaLINEA==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr5950633wmf.113.1580914619279; 
 Wed, 05 Feb 2020 06:56:59 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q1sm132794wrw.5.2020.02.05.06.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 06:56:58 -0800 (PST)
Date: Wed, 5 Feb 2020 14:56:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: clean up when virtio_queue_set_rings() fails
Message-ID: <20200205145657.GI58062@stefanha-x1.localdomain>
References: <20200204151618.39296-1-stefanha@redhat.com>
 <20200205005605-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PMULwz+zIGJzpDN9"
Content-Disposition: inline
In-Reply-To: <20200205005605-mutt-send-email-mst@kernel.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PMULwz+zIGJzpDN9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2020 at 01:13:37AM -0500, Michael S. Tsirkin wrote:
> On Tue, Feb 04, 2020 at 03:16:18PM +0000, Stefan Hajnoczi wrote:
> > hw/virtio.c checks vq->vring.desc !=3D NULL to see if the vring has been
> > set up successfully.
> >=20
> > When virtio_queue_set_rings() fails due to an invalid vring memory
> > address it must clear vq->vring.desc (and related fields) so we don't
> > treat this virtqueue as successfully initialized later on.
> >=20
> > This bug was found by device fuzzing and can be triggered as follows:
> >=20
> >   $ qemu -M pc -device virtio-blk-pci,id=3Ddrv0,drive=3Ddrive0,addr=3D4=
=2E0 \
> >          -drive if=3Dnone,id=3Ddrive0,file=3Dnull-co://,format=3Draw,au=
to-read-only=3Doff \
> >          -drive if=3Dnone,id=3Ddrive1,file=3Dnull-co://,file.read-zeroe=
s=3Don,format=3Draw \
> >          -display none \
> >          -qtest stdio
> >   endianness
> >   outl 0xcf8 0x80002020
> >   outl 0xcfc 0xe0000000
> >   outl 0xcf8 0x80002004
> >   outw 0xcfc 0x7
> >   write 0xe0000000 0x24 0x00ffffffabffffffabffffffabffffffabffffffabfff=
fffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffab5cffff=
ffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffa=
bffffffabffffffabffffffabffffffabffffffab0000000001
> >   inb 0x4
> >   writew 0xe000001c 0x1
> >   write 0xe0000014 0x1 0x0d
> >=20
> > The following error message is produced:
> >=20
> >   qemu-system-x86_64: /home/stefanha/qemu/hw/virtio/virtio.c:286: vring=
_get_region_caches: Assertion `caches !=3D NULL' failed.
> >=20
> > The backtrace looks like this:
> >=20
> >   #0  0x00007ffff5520625 in raise () at /lib64/libc.so.6
> >   #1  0x00007ffff55098d9 in abort () at /lib64/libc.so.6
> >   #2  0x00007ffff55097a9 in _nl_load_domain.cold () at /lib64/libc.so.6
> >   #3  0x00007ffff5518a66 in annobin_assert.c_end () at /lib64/libc.so.6
> >   #4  0x00005555559073da in vring_get_region_caches (vq=3D<optimized ou=
t>) at qemu/hw/virtio/virtio.c:286
> >   #5  vring_get_region_caches (vq=3D<optimized out>) at qemu/hw/virtio/=
virtio.c:283
> >   #6  0x000055555590818d in vring_used_flags_set_bit (mask=3D1, vq=3D0x=
5555575ceea0) at qemu/hw/virtio/virtio.c:398
> >   #7  virtio_queue_split_set_notification (enable=3D0, vq=3D0x5555575ce=
ea0) at qemu/hw/virtio/virtio.c:398
> >   #8  virtio_queue_set_notification (vq=3Dvq@entry=3D0x5555575ceea0, en=
able=3Denable@entry=3D0) at qemu/hw/virtio/virtio.c:451
> >   #9  0x0000555555908512 in virtio_queue_set_notification (vq=3Dvq@entr=
y=3D0x5555575ceea0, enable=3Denable@entry=3D0) at qemu/hw/virtio/virtio.c:4=
44
> >   #10 0x00005555558c697a in virtio_blk_handle_vq (s=3D0x5555575c57e0, v=
q=3D0x5555575ceea0) at qemu/hw/block/virtio-blk.c:775
> >   #11 0x0000555555907836 in virtio_queue_notify_aio_vq (vq=3D0x5555575c=
eea0) at qemu/hw/virtio/virtio.c:2244
> >   #12 0x0000555555cb5dd7 in aio_dispatch_handlers (ctx=3Dctx@entry=3D0x=
55555671a420) at util/aio-posix.c:429
> >   #13 0x0000555555cb67a8 in aio_dispatch (ctx=3D0x55555671a420) at util=
/aio-posix.c:460
> >   #14 0x0000555555cb307e in aio_ctx_dispatch (source=3D<optimized out>,=
 callback=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:2=
60
> >   #15 0x00007ffff7bbc510 in g_main_context_dispatch () at /lib64/libgli=
b-2.0.so.0
> >   #16 0x0000555555cb5848 in glib_pollfds_poll () at util/main-loop.c:219
> >   #17 os_host_main_loop_wait (timeout=3D<optimized out>) at util/main-l=
oop.c:242
> >   #18 main_loop_wait (nonblocking=3D<optimized out>) at util/main-loop.=
c:518
> >   #19 0x00005555559b20c9 in main_loop () at vl.c:1683
> >   #20 0x0000555555838115 in main (argc=3D<optimized out>, argv=3D<optim=
ized out>, envp=3D<optimized out>) at vl.c:4441
> >=20
> > Reported-by: Alexander Bulekov <alxndr@bu.edu>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  hw/virtio/virtio.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 2c5410e981..5d7f619a1e 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2163,6 +2163,11 @@ void virtio_queue_set_rings(VirtIODevice *vdev, =
int n, hwaddr desc,
> >      vdev->vq[n].vring.avail =3D avail;
> >      vdev->vq[n].vring.used =3D used;
> >      virtio_init_region_cache(vdev, n);
> > +    if (vdev->broken) {
> > +        vdev->vq[n].vring.desc =3D 0;
> > +        vdev->vq[n].vring.avail =3D 0;
> > +        vdev->vq[n].vring.used =3D 0;
> > +    }
> >  }
>=20
> OK but now that you mention it, guest can cause us to call
> virtio_queue_set_rings at any time.
> If device was running there's still a window when desc is set
> but cache isn't.
>=20
> Is this an issue?

Yes, this is an issue for devices that support iothreads because the
virtqueue could be processed in the iothread while the vcpu thread
enters the virtio.c code.

> I also worry desc is tested in a way that isn't safe for RCU ...
>=20
> Should we convert most/all users to check the presence of region cache?

Yes.

I suspect there are additional issues because virtio.c doesn't use
locking, except for vring.caches RCU. :(

Stefan

--PMULwz+zIGJzpDN9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4617kACgkQnKSrs4Gr
c8htUQgAylc/QVooaB9y3Jlhgahy8GqSxlv5DgsLmcZBsgZOGZ0ToESYC5Tuhhe3
Uyxx9GvjSxfCqOODR0WWeTy7CXdNrQ1iGfLlqXoOGpPoLj+OEaGYE8yD6rhC2GNf
05nmaMK8OPmjY5wTW/yhxZUKODCCLdQBPohnPYJn2caKlc3TrgqvRhFpJozl7RiI
o4u3HSPSeBLZ9eaXIJI9ygcBvPakBPRDRMz0a8UW8s2S6tPVD7X7Ji7lcY5JGeSN
PvmgqwCMfPkJQTykwY3OyClY8SuupgbEYInaLxGIiygyin77LvXMFZnohjCW/qwu
q4wfwIYbwIl57JwAyzc0NWqm3glU/Q==
=AVmo
-----END PGP SIGNATURE-----

--PMULwz+zIGJzpDN9--

