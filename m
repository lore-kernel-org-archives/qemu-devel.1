Received: from eggs.gnu.org ([2001:4830:134:3::10]:46886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnqqf-0000I9-Mx
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnqqb-0005aW-3W
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:07:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnqqa-0005a3-RH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:07:01 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-21-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0a7f3a05-43b7-84ed-dc9a-a7bd708cfb9f@redhat.com>
Date: Tue, 14 Mar 2017 13:06:58 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-21-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V01RlctXehNSMEUWAm04gxJTa58xhuCxe"
Subject: Re: [Qemu-devel] [PATCH for-2.9 20/47] qapi2texi: Plainer enum
 value and member name formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V01RlctXehNSMEUWAm04gxJTa58xhuCxe
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <0a7f3a05-43b7-84ed-dc9a-a7bd708cfb9f@redhat.com>
Subject: Re: [PATCH for-2.9 20/47] qapi2texi: Plainer enum value and member
 name formatting
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-21-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-21-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Use @code{%s} instead of @code{'%s'}.  Impact, using @id as example:
>=20
> * Texinfo
>   -@item @code{'id'}
>   +@item @code{id}
>=20
> * HTML
>   -<dt><code>'id'</code></dt>
>   +<dt><code>id</code></dt>
>=20
> * POD (for manual pages):
>   -=3Ditem C<'id'>
>   +=3Ditem C<id>
>=20
> * Formatted manual pages:
>   -'id'
>   +"id"
>=20
> * Plain text:
>   -     ''id''
>   +     'id'
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi2texi.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--V01RlctXehNSMEUWAm04gxJTa58xhuCxe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyDFCAAoJEKeha0olJ0Nq2PUIAJIp4IvFQFavgFyT4CBxbTpk
n0uPtNCfeqho5jrK65a3M321Cjm8tQBuKW0SUMCi9ONCImK9TbyUKlfT+hCnj6Qa
AbOH1Pzrjc3hjQuIWafR48sMpeQyaftjXPwvhIzrDzKOc1yN3lwYkvO2fd06i5Na
fr/dDqpS37tBT19R9uuc8BaVUbLcMt9a7+WusClgRf/H51cW7O/ozBSqMSAAnFEv
3dVr9S5XeVv+q6fiP3Pytlqwl0kK2ORFKwkZNt1cH/jGUUGSOOhFgz14En1qaNW9
3inXJpOhAocFL5fMoFdFVeWaA/Dejn8mqQCfTVIErNK9sE1QduPpTxRidatVYxI=
=V9Tv
-----END PGP SIGNATURE-----

--V01RlctXehNSMEUWAm04gxJTa58xhuCxe--
