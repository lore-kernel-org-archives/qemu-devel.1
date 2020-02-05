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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589FDC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266C22082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnX03FpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266C22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izM0u-0007EK-CE
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1izLzz-0005ti-IE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1izLzy-0000Hk-1l
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:49:51 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38303)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1izLzx-0000AV-Q0
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:49:49 -0500
Received: by mail-wm1-x342.google.com with SMTP id a9so3121442wmj.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 06:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ons5FHmsWiXDdael+bsYF/XBaY2au8K0OD/tabwpVc4=;
 b=PnX03FpYT00IWGqxSUOmheTV3X5vz8lCsv+HfPpfAot+XLffWoMK51TM0n2rQFkG55
 02JAOI54D8fFU6uXIfAcXllpbFCRI8GYSExFhEgNIZ661i+NPNoJnTyMiATzvNdul8M/
 UfwtQjVtb7C5Rh7iPMMuG0W2X2axKA7JPsrT/3DSWBQeuWDmLVFehSuR5jsEgMnxiOUX
 fEjSfRytKz+px/3+KouKsVI2TMvEnTIO799Ou9LrHP2/bzuZ/04LUIy2rBiUTiM16ivg
 47qhErNS0ete0I2eUGofQUCrhafQz1Eh4IaA0d60TIhsSo2aq6PlYbhTpszDmkrYYGGo
 5B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ons5FHmsWiXDdael+bsYF/XBaY2au8K0OD/tabwpVc4=;
 b=kOZC5U7M/QEJYxxqzav4P4UEzCqB3pvFNfcMOo6edMki8u7bIxdBKFWuJK04VgFBi7
 DzjXsePXdQo2Tjpho6GnKI87oJgivAc0l39aej7DpGlwti7oKcT5ubtHj0CaaTw7yBP/
 8/RKCdkSMq9/iLfJaWj0CMNYkATKuzjiBJVr6SEeGU6h2/MMREULsJmPu0qkxGASZo1T
 +aeKpcSCDnrLDog3d2zlLWXwzwHsQ8luzOEo+OMm+mReYgXPwLhbqNCWnoEeP8nt6kj+
 qi9d0Sp+Jfn86Qb1psqO3AYLjpwUKuo5HOo2psp1yAyH6QmXl4/crHMyoh/Xq2U1Q7V0
 zuLA==
X-Gm-Message-State: APjAAAULDSukohg/6K5t9B0EHI31ywj3oml0IcFhuXS1qvKGOuY0iDcA
 TG5WRPJcdtjsvqIQSThD+cg=
X-Google-Smtp-Source: APXvYqytikv6zNsf5mL2jOyxpmT4/gokZW6kzROQOGNbgOvfGprECGN75MQ4wskeK+lBmH2+FqQAGg==
X-Received: by 2002:a05:600c:2301:: with SMTP id
 1mr6248429wmo.147.1580914188210; 
 Wed, 05 Feb 2020 06:49:48 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p5sm48705wrt.79.2020.02.05.06.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 06:49:47 -0800 (PST)
Date: Wed, 5 Feb 2020 14:49:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio: clean up when virtio_queue_set_rings() fails
Message-ID: <20200205144946.GH58062@stefanha-x1.localdomain>
References: <20200204151618.39296-1-stefanha@redhat.com>
 <20200204170239.49deb13a.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Content-Disposition: inline
In-Reply-To: <20200204170239.49deb13a.cohuck@redhat.com>
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
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2020 at 05:02:39PM +0100, Cornelia Huck wrote:
> On Tue,  4 Feb 2020 15:16:18 +0000
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
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
> > =20
> >  void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
>=20
> This looks correct; but shouldn't virtio_queue_set_addr() also set
> .desc to 0 on failure?

Now that you mention it, there are a number of other
virtio_init_region_cache() callers that could be affected.

I added the error handling code to virtio_queue_set_rings() because
that's symmetric - this function sets .desc and so it should be the one
to clear it on error.  But now I think virtio_init_region_cache() should
take on that responsibility so callers don't need to duplicate this
error handling code.

Stefan

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl461goACgkQnKSrs4Gr
c8ja+QgApfzlteqFB5My3P19CYWVH/KkDJ4jMXBLgzCr2i/zxgakyWy162stdOV3
ce27iLXgLrpPx35KotzUt3yukFFl6KR/UOxT0y15EhVrVEpXFx89CsgtMqsBDTxv
I9O/591ErgW9l7dVJ9gZ2EVPP8XJmF2QCZEMXh9wvYOYFXJUN3a3x+CU7PsuPE23
YljG9/TCra324HGonszmhQ37LeoZUNmw9WsGmrOdtVApyBONYwHRUQRHK/4UAoQ4
gcdXuSSAic6MMLQHDIgIk41N+1OFcoxTD9VOLg1JzRy3Xz4E/NN0DvAs8nwZVq/B
SoSKjw0IN/O2Gwe7JVG1ICJlu5T5PQ==
=ZBsx
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--

