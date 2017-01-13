Received: from eggs.gnu.org ([2001:4830:134:3::10]:38985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cS7st-0002Q0-G8
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 14:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cS7sq-0000S8-Ec
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 14:51:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cS7sq-0000S2-6P
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 14:51:32 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C72A4621C
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 19:51:32 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-30-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9758ac38-48c7-1dcd-4567-e523eecbb8c8@redhat.com>
Date: Fri, 13 Jan 2017 13:51:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-30-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="buNaRHF1b1XMJecIF3q8wlduL6n9CmJJ3"
Subject: Re: [Qemu-devel] [PATCH 29/40] char: move win chardev base class in
 its own file
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
--buNaRHF1b1XMJecIF3q8wlduL6n9CmJJ3
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <9758ac38-48c7-1dcd-4567-e523eecbb8c8@redhat.com>
Subject: Re: [PATCH 29/40] char: move win chardev base class in its own file
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-30-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-30-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-win.h    |  30 ++++++
>  chardev/char-win.c    | 242 ++++++++++++++++++++++++++++++++++++++++++=
+++++
>  chardev/char.c        | 253 +-----------------------------------------=
--------
>  chardev/Makefile.objs |   1 +
>  4 files changed, 276 insertions(+), 250 deletions(-)
>  create mode 100644 chardev/char-win.h
>  create mode 100644 chardev/char-win.c
>=20

> +++ b/chardev/Makefile.objs
> @@ -4,3 +4,4 @@ chardev-obj-y +=3D char-io.o
>  chardev-obj-y +=3D char-mux.o
>  chardev-obj-y +=3D char-null.o
>  chardev-obj-y +=3D char-ringbuf.o
> +chardev-obj-$(CONFIG_WIN32) +=3D char-win.o

This part is the neatest - trading #ifdefs in the code for conditionally
compiling an entire .c file.

I have not closely read 28-39, so I don't know if R-b is appropriate,
but they are all mechanical and the fact that it still compiles is good.
 So maybe we go with the weaker:
Acked-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--buNaRHF1b1XMJecIF3q8wlduL6n9CmJJ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYeS/BAAoJEKeha0olJ0Nq8rEH/26HokvgCTjXO/VXNr3W4PNy
cVu3UCFZvljmHxdke/90RB12srMFR1Ywbcvu+Grhw+OS6f5wGUH1NiDoKcUBFtoj
W47FDSftxwzPj6Vkr2b65b3BodiuImKXCf3wujuRdcQjA9ZzXzNul/2jTtfGLcwq
znNSJWeEzCODziyO9Ewl5DQLUIxGm6KR75ifas/0lFao7XtfpJFzegbgqIMdvSsb
rauFISJAOytXnHXJFKKs06s3HjSoj/L1/uG56hmRhLU0qICH8mCWwXKgqMPlJ/SD
QMjs8/ZVyAXfyYBRNWtWIdgRrvGt+Aft6jgdOIfWXZQNsO461/2vqWbRlBhs7G4=
=ZDqC
-----END PGP SIGNATURE-----

--buNaRHF1b1XMJecIF3q8wlduL6n9CmJJ3--
