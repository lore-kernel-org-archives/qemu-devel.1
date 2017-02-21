Received: from eggs.gnu.org ([2001:4830:134:3::10]:55779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cg8QS-0003AA-8D
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cg8QO-0002Y3-7C
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:16:08 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cg8QO-0002Xr-0e
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:16:04 -0500
Received: by mail-wm0-x241.google.com with SMTP id u63so19036841wmu.2
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 03:16:03 -0800 (PST)
Date: Tue, 21 Feb 2017 11:16:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170221111600.GC22731@stefanha-x1.localdomain>
References: <20170220093304.20515-1-stefanha@redhat.com>
	<CAFEAcA_5dyLsiGwns9LgBf92Ffv57VEPo3SYmfz6wGeFU7YeLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_5dyLsiGwns9LgBf92Ffv57VEPo3SYmfz6wGeFU7YeLg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/24] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 01:37:58PM +0000, Peter Maydell wrote:
> On 20 February 2017 at 09:32, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > The following changes since commit 5dae13cd71f0755a1395b5a4cde635b8a6ee=
3f58:
> >
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-or-20170214' into=
 staging (2017-02-14 09:55:48 +0000)
> >
> > are available in the git repository at:
> >
> >   git://github.com/stefanha/qemu.git tags/block-pull-request
> >
> > for you to fetch changes up to decc18f33adecb1316437a47fff0cf0a7665906a:
> >
> >   coroutine-lock: make CoRwlock thread-safe and fair (2017-02-16 17:17:=
34 +0000)
> >
> > ----------------------------------------------------------------
> >
> > ----------------------------------------------------------------
>=20
> Hi; this has merge conflicts in hw/scsi/virtio-scsi.c and
> hw/block/virtio-blk.c which I could maybe resolve by hand
> but at least one of them makes me suspicious that perhaps
> the automatic merging will have semantically mismerged:
>=20
> @@@ -758,13 -756,13 +768,18 @@@ out
>       virtio_scsi_release(s);
>   }
>=20
>  -void virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
>  +bool virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
>   {
> +     virtio_scsi_acquire(s);
>       if (s->events_dropped) {
>           virtio_scsi_push_event(s, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
>  +        return true;
>       }
> ++<<<<<<< HEAD
>  +    return false;
> ++=3D=3D=3D=3D=3D=3D=3D
> +     virtio_scsi_release(s);
> ++>>>>>>> remotes/stefanha/tags/block-pull-request
>   }
>=20
>   static void virtio_scsi_handle_event(VirtIODevice *vdev, VirtQueue *vq)
>=20
> since one half of this merge is adding extra return paths
> which won't have release() calls in them in the other half.
>=20
> Can you rebase and fix, please?

Sending v2.

Stefan

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrCFwAAoJEJykq7OBq3PIbZ0H/jUidNfrN7w4FuBZeVOXV4ZB
1ZJ3Ir0vMBmJwwsxZ+mrx8yZR+Oar7CG1rW6gbRRp6QJwt7SqA1nWexZUlwups+d
aAsNWSVWQCiAawLOkDlA2N0r14XCNpHE9huN0Wl31Ltikm3O0pO2PTrR5Kau+wYA
RHIktUDaabjagh3b5lMVOCd6zQbRJ+grr9m+ZDB47qZaUJeioxvPNYiPHVGC+/Dj
Jk7HhYaSmKpf8w4gj9jqQtjPHRpnoIiy0OaYRED057gNUKsbEQPlB2NP00ncFuom
kbrBSiTe02Cm/q0XT+8Rt3L8XOm1udlHkacjnaS82j79tp3zSsDQjXMqIHTgEcA=
=JKot
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
