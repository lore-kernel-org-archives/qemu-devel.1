Received: from eggs.gnu.org ([2001:4830:134:3::10]:45519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Y09-00031p-C1
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Y05-0000gt-0v
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:18:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55060 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8Y04-0000ZJ-Lx
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:18:52 -0400
References: <20180412124834.GA2025@ruderich.org>
	<68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
	<6f775e11a75a2faa1c66a86e6d23a97f695c2ca1.1523537181.git.simon@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <954f83a5-675c-c4ff-6c89-6f8eb820a806@redhat.com>
Date: Tue, 17 Apr 2018 16:18:43 -0500
MIME-Version: 1.0
In-Reply-To: <6f775e11a75a2faa1c66a86e6d23a97f695c2ca1.1523537181.git.simon@ruderich.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ciSLGcZDdoUn1EGjiJU5T3BtXarD5iE0W"
Subject: Re: [Qemu-devel] [PATCH v2 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ciSLGcZDdoUn1EGjiJU5T3BtXarD5iE0W
From: Eric Blake <eblake@redhat.com>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org
Message-ID: <954f83a5-675c-c4ff-6c89-6f8eb820a806@redhat.com>
Subject: Re: [PATCH v2 5/5] qmp: add pmemload command
References: <20180412124834.GA2025@ruderich.org>
 <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
 <6f775e11a75a2faa1c66a86e6d23a97f695c2ca1.1523537181.git.simon@ruderich.org>
In-Reply-To: <6f775e11a75a2faa1c66a86e6d23a97f695c2ca1.1523537181.git.simon@ruderich.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2018 07:50 AM, Simon Ruderich wrote:
> Adapted patch from Baojun Wang [1] with the following commit message:
>=20
>     I found this could be useful to have qemu-softmmu as a cross
>     debugger (launch with -s -S command line option), then if we can
>     have a command to load guest physical memory, we can use cross gdb
>     to do some target debug which gdb cannot do directly.
>=20
> pmemload is necessary to directly write physical memory which is not
> possible with gdb alone as it uses only logical addresses.
>=20
> The QAPI for pmemload uses "val" as parameter name for the physical
> address. This name is not very descriptive but is consistent with the
> existing pmemsave. Changing the parameter name of pmemsave is not
> possible without breaking the existing API.
>=20
> [1]: https://lists.gnu.org/archive/html/qemu-trivial/2014-04/msg00074.h=
tml
>=20
> Based-on-patch-by: Baojun Wang <wangbj@gmail.com>
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---

Focusing on just the interface:

> +++ b/qapi/misc.json
> @@ -1185,6 +1185,26 @@
>  { 'command': 'pmemsave',
>    'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
> =20
> +##
> +# @pmemload:
> +#
> +# Load a portion of guest physical memory from a file.
> +#
> +# @val: the physical address of the guest to start from
> +#
> +# @size: the size of memory region to load

Should size be an optional parameter (default read to the end of the file=
)?

> +#
> +# @offset: the offset in the file to start from

Should offset be an optional parameter (default start reading from
offset 0 of the file)?

> +#
> +# @filename: the file to load the memory from as binary data
> +#
> +# Returns: Nothing on success
> +#
> +# Since: 2.13
> +##
> +{ 'command': 'pmemload',
> +  'data': {'val': 'int', 'size': 'int', 'offset': 'int', 'filename': '=
str'} }
> +
>  ##
>  # @cont:
>  #
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ciSLGcZDdoUn1EGjiJU5T3BtXarD5iE0W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWZLMACgkQp6FrSiUn
Q2pomggArxzjYt9CzXxql7tXbLA2Tn3UPSJ4vRoH9CYSU8to9CHn63YTSUwERNxR
z24OsK4+b8hIX+BwWO3gToxak3JdmcbMmNt8KgTWndixi61zLnoL27k3RjL5NjnZ
PJjPX/ZUXBKhnMwKM7XbW3ZMpOvRPn8+0W5IWDZtcUInOSpaGCgyfgaar40ru//7
FWBXoRzDV1Q+baiy5BeERQbk9zaIXSly5/BCKdpDpmSjRLhxI3Lo+AQgvtrbNz3L
BZYR+Lw+N+/eAeIhPJwZkYyDWQ+mUe3fDQ/To2S0rkFjCgh1xcpwJ+t3Dkrqr5Cy
JYdC+ZyAw/H/SbQ50mcSrGggngkiEQ==
=EYeA
-----END PGP SIGNATURE-----

--ciSLGcZDdoUn1EGjiJU5T3BtXarD5iE0W--
