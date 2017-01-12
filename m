Received: from eggs.gnu.org ([2001:4830:134:3::10]:37378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRnDV-0004nD-Qb
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRnDR-0004sr-TW
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:47:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRnDR-0004sD-L6
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:47:25 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F7444E4CD
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 21:47:25 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-21-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0140a753-69ac-ebed-804d-58e8b5494a9f@redhat.com>
Date: Thu, 12 Jan 2017 15:47:22 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-21-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JI5dI6apjrkH7MnbXkLcEJte3fpiACgCO"
Subject: Re: [Qemu-devel] [PATCH 20/40] char: create chardev-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JI5dI6apjrkH7MnbXkLcEJte3fpiACgCO
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <0140a753-69ac-ebed-804d-58e8b5494a9f@redhat.com>
Subject: Re: [PATCH 20/40] char: create chardev-obj-y
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-21-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-21-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> This will help to split char.c in several units without having to
> reference them all everywhere. This is useful in particular for tests.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> @@ -221,7 +222,7 @@ subdir-dtc:dtc/libfdt dtc/tests
>  dtc/%:
>  	mkdir -p $@
> =20
> -$(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y) $(qom-obj=
-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
> +$(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y) $(chardev=
-obj-y) $(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))

Again, splitting long lines with \ would be nice, but not a necessity.

> =20
>  ROMSUBDIR_RULES=3D$(patsubst %,romsubdir-%, $(ROMS))
>  # Only keep -O and -g cflags
> diff --git a/Makefile.objs b/Makefile.objs
> index cad4c54740..7985d21841 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -51,7 +51,7 @@ common-obj-$(CONFIG_POSIX) +=3D os-posix.o
>  common-obj-$(CONFIG_LINUX) +=3D fsdev/
> =20
>  common-obj-y +=3D migration/
> -common-obj-y +=3D chardev/ #aio.o
> +common-obj-y +=3D #aio.o

The fact that aio.o is commented is unrelated to your patch, but now
that this line is a comment only, can we delete it?

>  common-obj-y +=3D page_cache.o

Or maybe merge it with this line, so it doesn't look quite as odd?

Nothing major, so
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JI5dI6apjrkH7MnbXkLcEJte3fpiACgCO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYd/lqAAoJEKeha0olJ0NqMWAH/RPA811ozPuPTlM05GbEv/Wy
JrIitTpefj2u6RixDcsvM3KEBVRnpW5SMfs4uklhARp2JUiJj9oEeVjgGp1K1Dfo
HT07O05CKb+z1X9YtQ7InI6juSK/+ES1YMHYi7TBYTiJ6XTyAVrVfgGj1Jy2Ar/c
9AS46FoUkDTFW9exsh8Uyymria4LQjiVttn8L9/ce1cgdo2MF9Jf7/JSMMhh2s+w
c1kHj0fJS4669Xq7ynRXg1WGE124kdcDamwbCZlPpQhwuL+x5Z2e7ESbEGFcrpZj
j8tf8xigGlC1F4GoRTO7e2Lxl4098/59k2MYIDBUKbC42iygL1NbJcbqVtKwXhw=
=Rb1S
-----END PGP SIGNATURE-----

--JI5dI6apjrkH7MnbXkLcEJte3fpiACgCO--
