Received: from eggs.gnu.org ([2001:4830:134:3::10]:47672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEJL7-0008IE-Sn
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 13:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEJL6-0001Hr-Sp
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 13:20:09 -0500
References: <20171113152424.25381-1-eblake@redhat.com>
	<87h8tyyuch.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e9e7bf10-bc24-0524-bb02-5328718d124a@redhat.com>
Date: Mon, 13 Nov 2017 12:19:59 -0600
MIME-Version: 1.0
In-Reply-To: <87h8tyyuch.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0U8WqM28clHO21d5XCoHWfp7gjuAWvsWq"
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd/client: Use error_prepend()
 correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-stable@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0U8WqM28clHO21d5XCoHWfp7gjuAWvsWq
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 vsementsov@virtuozzo.com, qemu-stable@nongnu.org, qemu-block@nongnu.org
Message-ID: <e9e7bf10-bc24-0524-bb02-5328718d124a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd/client: Use error_prepend()
 correctly
References: <20171113152424.25381-1-eblake@redhat.com>
 <87h8tyyuch.fsf@dusky.pond.sub.org>
In-Reply-To: <87h8tyyuch.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/13/2017 11:14 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> When using error prepend(), it is necessary to end with a space
>> in the format string; otherwise, messages come out incorrectly,
>> such as when connecting to a socket that hangs up immediately:
>>
>> can't open device nbd://localhost:10809/: Failed to read dataUnexpecte=
d end-of-file before all bytes were read
>>

> Preexisting: inconsistent capitalization (Failed vs. failed).
>=20
> In general, prepend chains looks slightly less ugly when each link
> starts with a lower case letter.  Compare:
>=20
>     can't open device nbd://localhost:10809/: failed to read data: unex=
pected end-of-file before all bytes were read
>     Can't open device nbd://localhost:10809/: Failed to read data: Unex=
pected end-of-file before all bytes were read
>=20
> Neither message is really good, but the second one is ugly to boot.

A tree-wide search shows that we have no strong preference for
capitalization or not; but I can do a followup patch for at least NBD
code to prefer lower-case, and enforce that style in future NBD-related
patches.  Not sure if that followup would be 2.11 material, though.

>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20

Thanks

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0U8WqM28clHO21d5XCoHWfp7gjuAWvsWq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloJ4k8ACgkQp6FrSiUn
Q2p0MggAiUe4xGiCEVV5Y2df2uT1Udq9/nCNcZ6opffWZ9/szhxaav/c6D8wgkwk
4XObUpak1cC4Kff5t1g00emMwFlLbxJ/shdzweSu6aoZSXcwxNIiyQPZNqIeVati
9rj+nYI69JVYFZ0XhxCMA+HDrJkg6I4jfhesshzrqKdtTlgTYpBbJwVipC0oJTj2
BCXtRQzH4Au+ELSgwtPmeo4llRaDxzrSz+JvSPZZ2Br9npRKfXG9lg2RDv2tvUal
AQZrgTbKZCOSFKVLzHC7Gjn9f6Chvn9Tuu7LGLlEPo5iD+77ywzbQDQvF2JHdcZb
BaHCfLlWFSJ/p1o1krG2Kb/uRpHlHA==
=Z7J3
-----END PGP SIGNATURE-----

--0U8WqM28clHO21d5XCoHWfp7gjuAWvsWq--
