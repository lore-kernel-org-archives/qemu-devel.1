Received: from eggs.gnu.org ([2001:4830:134:3::10]:49347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXVJa-0000Nr-6w
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXVJY-0004gV-UT
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:57:54 -0500
References: <20180105144440.18129-1-muriloo@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1818f13c-0e9e-70da-8d39-9ff9f07c3982@redhat.com>
Date: Fri, 5 Jan 2018 10:57:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180105144440.18129-1-muriloo@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iNmoPHGUyYa63vRhlpHvri1eomQVKAVin"
Subject: Re: [Qemu-devel] [PATCH] block/ssh: fix possible segmentation fault
 when .desc is not null-terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Richard W M Jones <rjones@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iNmoPHGUyYa63vRhlpHvri1eomQVKAVin
From: Eric Blake <eblake@redhat.com>
To: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>,
 Richard W M Jones <rjones@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Message-ID: <1818f13c-0e9e-70da-8d39-9ff9f07c3982@redhat.com>
Subject: Re: [PATCH] block/ssh: fix possible segmentation fault when .desc is
 not null-terminated
References: <20180105144440.18129-1-muriloo@linux.vnet.ibm.com>
In-Reply-To: <20180105144440.18129-1-muriloo@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2018 08:44 AM, Murilo Opsfelder Araujo wrote:
> This patch prevents a possible segmentation fault when .desc members ar=
e checked
> against NULL.
>=20
> The ssh_runtime_opts was added by commit
> 8a6a80896d6af03b8ee0c17cdf37219eca2588a7 ("block/ssh: Use QemuOpts for =
runtime
> options").
>=20
> This fix was inspired by
> http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg00883.html.
>=20
> Fixes: 8a6a80896d6af03b8ee0c17cdf37219eca2588a7 ("block/ssh: Use QemuOp=
ts for runtime options")

present since 2.7.0, so we've gotten lucky that no one has actually
encountered a crash (but I didn't try hard to see if one was possible)

> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
> ---
>  block/ssh.c | 1 +
>  1 file changed, 1 insertion(+)

CC: qemu-stable@nongnu.org
Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/ssh.c b/block/ssh.c
> index b049a16eb9..8890a0c4ba 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -556,6 +556,7 @@ static QemuOptsList ssh_runtime_opts =3D {
>              .type =3D QEMU_OPT_STRING,
>              .help =3D "Defines how and what to check the host key agai=
nst",
>          },
> +        { /* end of list */ }
>      },
>  };
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iNmoPHGUyYa63vRhlpHvri1eomQVKAVin
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpProcACgkQp6FrSiUn
Q2rcCQf9EnxrltFk1xFvT5+Xyap2Ygd+6qOB05ddPQbCFqNrC+xBVZTSBcCmvSOS
F++7RovN/dT0OC3xlFU/EhsjLS3o260B8ulvUi9nUcWk5u8xRBdlkMgQ0Vh3Hfiy
k5IOAHsBIoQCHw2djKtyxRmrWt5dm2VraHD3Z4nTJCU/e+Ce/6JuZrrBWZ93zv5E
aG4cfSS3tOfyw08BrO/NKHWAmMQn3d/HfY1L6k6FBuRM9Vwzja8P/TGPK8f7WJnZ
lPks/S5xux8ny/5Fxa67uBvDsosgfAS4/JA2aP1NKs9q+DTPnrYY/QwP2w6tkafS
XJBwC5HEgAy8FDBziFfJn52ZTndiqw==
=gZBS
-----END PGP SIGNATURE-----

--iNmoPHGUyYa63vRhlpHvri1eomQVKAVin--
