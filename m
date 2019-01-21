Received: from eggs.gnu.org ([209.51.188.92]:43027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glXE5-0007Xz-Jj
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glXE3-0002Sh-Cw
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:54:45 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1glXDz-0002FN-Kx
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:54:39 -0500
Received: by mail-wr1-x441.google.com with SMTP id p4so22753094wrt.7
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 02:54:29 -0800 (PST)
Date: Mon, 21 Jan 2019 10:54:24 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190121105424.GH30536@stefanha-x1.localdomain>
References: <154803791641.5550.15254007790773130906@2d3111e9616b>
	<7979bbc2-2713-4043-291b-79b7132634c0@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Content-Disposition: inline
In-Reply-To: <7979bbc2-2713-4043-291b-79b7132634c0@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] QEMU changes to do PVH boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com, george.kennedy@oracle.com, stefanha@redhat.com, pbonzini@redhat.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, sgarzare@redhat.com, rth@twiddle.net


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 08:19:03AM +0000, Liam Merwick wrote:
> On 21/01/2019 02:31, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/1547554687-12687-1-git-send-email=
-liam.merwick@oracle.com/
> ...>
> >    CC      dma-helpers.o
> >    CC      vl.o
> > /tmp/qemu-test/src/block/sheepdog.c: In function 'find_vdi_name':
> > /tmp/qemu-test/src/block/sheepdog.c:1239:5: error: 'strncpy' specified =
bound 256 equals destination size [-Werror=3Dstringop-truncation]
> >       strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
> >       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> >=20
>=20
>=20
> Given the PVH patch series was posted 5 days ago and the following change
> was committed 3 days ago, I'm assuming this is not related to the PVH
> changes (which do not touch this file).
>=20
> commit 97b583f46c435aaa40942ca73739d79190776b7f
> Author: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Date:   Thu Jan 3 09:56:35 2019 +0100
>=20
>     block/sheepdog: Use QEMU_NONSTRING for non NUL-terminated arrays

Yes, don't worry, it's a false positive.

Stefan

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcRaTgAAoJEJykq7OBq3PIyqEIAKTn3nBUrMCGFIo7UyaD93oQ
SdGjt0xqouk7nGmnvV71C/vPUSLzR78EF3yvseHSkJv+hpBA2WN+p+jQAyIWz3BP
ajszz66vHPKzte3Tpo1PBFuwgFSkTCgub+q2pna23g2QPharBhm/61QHsmcQ0eVs
P+NuHBZXfFBe0iZ1ykXR4OwmJ5Wmw+HBlTGUXMkJy3NV5+VU7Tlh+6Ek6hgfm+36
MLxONoXfQzXSJPHhrxPE8uGPrgAv5yAKiiO2AX7G/1n2dncicN/XKU/3Dy5AJ4z1
3pm9X0McNX4d9dv+k6CWSKc6Zku3xv2peTG6fe06xX0KjAwoibVejih3s0YoPc4=
=755q
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
