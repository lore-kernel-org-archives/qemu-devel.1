Received: from eggs.gnu.org ([2001:4830:134:3::10]:47855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ch2A9-0003Rx-GL
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ch2A6-0001r2-Fa
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:47:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ch2A6-0001qj-6w
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:46:58 -0500
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12466fb1-5182-e97c-f82c-40d124fbbbcb@redhat.com>
Date: Thu, 23 Feb 2017 16:46:55 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WcSO8xbxiJQVnbknMF3E2M47RAAGg7mKP"
Subject: Re: [Qemu-devel] [PATCH 01/21] qga: Fix crash on non-dictionary QMP
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WcSO8xbxiJQVnbknMF3E2M47RAAGg7mKP
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <12466fb1-5182-e97c-f82c-40d124fbbbcb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/21] qga: Fix crash on non-dictionary QMP
 argument
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:44 PM, Markus Armbruster wrote:
> The value of key 'arguments' must be a JSON object.  qemu-ga neglects
> to check, and crashes.  To reproduce, send
>=20
>     { 'execute': 'guest-sync', 'arguments': [] }
>=20
> to qemu-ga.
>=20
> do_qmp_dispatch() uses qdict_get_qdict() to get the arguments.  When
> not a JSON object, this gets a null pointer, which flows through the
> generated marshalling function to qobject_input_visitor_new(), where
> it fails the assertion.  qmp_dispatch_check_obj() needs to catch this
> error.
>=20
> QEMU isn't affected, because it runs qmp_check_input_obj() first,
> which basically duplicates qmp_check_input_obj()'s checks, plus the
> missing one.
>=20
> Fix by copying the missing one from qmp_check_input_obj() to
> qmp_dispatch_check_obj().
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  qapi/qmp-dispatch.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--WcSO8xbxiJQVnbknMF3E2M47RAAGg7mKP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYr2ZfAAoJEKeha0olJ0NqchEH/ijy5N/jTj4J0o31YwueVQ9d
hic7vGDw9IIebzAzEUCCBSt6Ks25tJB7TK8doMVg7InSzIKxqH2ShPj1Sx2QbJnZ
b7oY4qjfTqhqOxMTLe7OcPiKm1chdLB+u6zz1EwmH9x1X6caDqONw3e2KLgf00s+
VPl4e2i8D8u8lxHmkeNAmEyE8NXmXwDmMD3cNr0SqqAhupEDUQTzwiICTRy/puH0
P74LT9N9tE7DvuvXrwLPwf7Bp01yjl7ZrnU1B5aJPkglP9UDbTR5LedeqHVwmBEn
C1avuHiZeOnXQ8DtF8hPQZlK4m62l+S6qpojx3lVHUh7iJldj5zZ/283+pVp+vs=
=1VGV
-----END PGP SIGNATURE-----

--WcSO8xbxiJQVnbknMF3E2M47RAAGg7mKP--
