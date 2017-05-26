Received: from eggs.gnu.org ([2001:4830:134:3::10]:47438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEFMf-0002UY-Il
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEFMb-00064I-DA
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:33:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dEFMb-00063Y-3l
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:33:09 -0400
References: <19feea44a3f4010645a1b829b504481f1b574b9a.1495797845.git.maozy.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <caf34cd4-a2cd-395b-f95f-d2588ba1672a@redhat.com>
Date: Fri, 26 May 2017 08:33:01 -0500
MIME-Version: 1.0
In-Reply-To: <19feea44a3f4010645a1b829b504481f1b574b9a.1495797845.git.maozy.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="itVQSiAHvvtSksIHbwj30Rb0l6ewtIahV"
Subject: Re: [Qemu-devel] [PATCH v2] pci: Set err to errp directly rather
 than through error_porpagate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, imammedo@redhat.com, armbru@redhat.com, mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--itVQSiAHvvtSksIHbwj30Rb0l6ewtIahV
From: Eric Blake <eblake@redhat.com>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, imammedo@redhat.com, armbru@redhat.com, mst@redhat.com
Message-ID: <caf34cd4-a2cd-395b-f95f-d2588ba1672a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] pci: Set err to errp directly rather than
 through error_porpagate()
References: <19feea44a3f4010645a1b829b504481f1b574b9a.1495797845.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <19feea44a3f4010645a1b829b504481f1b574b9a.1495797845.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 06:58 AM, Mao Zhongyi wrote:

In the subject: s/porpagate/propagate/

> ioh3420_interrupts_init() and its callers rp_realize() fill error
> message to local_err, then propagate it to errp by error_porpagate(),

and again

> which's not necessary. So eliminate it and pass errp directly instead

s/which's/which is/ (English does not have the abbreviation which's)

> of local_err. Of course, error_propagate() also has been removed.
>=20
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
> v2:
> * Drop the part of wrong handling that ignored the fact that if=20
>   pci_qdev_realize()'s caller pass errp =3D NULL.
>=20

The code portion is fine, so with the commit message fixed (which a
maintainer might do without needing you to send a v3),
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--itVQSiAHvvtSksIHbwj30Rb0l6ewtIahV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEbBAEBCAAGBQJZKC6NAAoJEKeha0olJ0NqwQUH+K3AcZCIDlLngZ7LsYCbAkAl
zI/z4m6mCkhVCn+O8Q3wahghVtElZi1909DraIaBkmDkP1AjyykcpnUflhokuAvR
x2qVBn8lUqmD641DKLwh/ze61ADswsZ0CSEzozzZJ9QxR39zx5NN77tVsIfvpj7E
BQrmXrbNxPpPcni4fWyW5c/suDmBNjTyPE4f6LAIOpYEne6kjkMGyhdLbQID6wz8
uHnoP2dKynr3bXSModkHDOaBudO/OZL9GM0vWFiQ7c2BqHuVWHWabSyYsssMAvus
Y1m0ZwMMDbbjBzNj+IiNkSa45S4n0mIyekN6SHp97L8XXAhJModt660V95ftzg==
=rRGK
-----END PGP SIGNATURE-----

--itVQSiAHvvtSksIHbwj30Rb0l6ewtIahV--
