Received: from eggs.gnu.org ([2001:4830:134:3::10]:48102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co7pV-0000mR-5e
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co7pQ-0007Su-HJ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:15:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1co7pQ-0007Sc-9J
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:14:56 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-32-git-send-email-armbru@redhat.com>
	<bde5a409-92c8-b0b9-178a-a12ddb2ea479@redhat.com>
	<87pohjq98x.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <866bbb35-aeaf-bc2e-b46b-c2272808009f@redhat.com>
Date: Wed, 15 Mar 2017 07:14:53 -0500
MIME-Version: 1.0
In-Reply-To: <87pohjq98x.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PsfncjG7WV6RXGO6jxqCn7vJQpa1dFApg"
Subject: Re: [Qemu-devel] [PATCH for-2.9 31/47] qapi: Fix detection of doc /
 expression mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PsfncjG7WV6RXGO6jxqCn7vJQpa1dFApg
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 mdroth@linux.vnet.ibm.com
Message-ID: <866bbb35-aeaf-bc2e-b46b-c2272808009f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 31/47] qapi: Fix detection of doc /
 expression mismatch
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-32-git-send-email-armbru@redhat.com>
 <bde5a409-92c8-b0b9-178a-a12ddb2ea479@redhat.com>
 <87pohjq98x.fsf@dusky.pond.sub.org>
In-Reply-To: <87pohjq98x.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 02:39 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 03/13/2017 01:18 AM, Markus Armbruster wrote:
>>> This fixes the errors uncovered by the previous commit.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>
>>> =20
>>>              expr =3D self.get_expr(False)
>>>              if 'include' in expr:
>>> +                self.reject_expr_doc()
>>>                  if len(expr) !=3D 1:
>>
>> Do you also need to handle 'pragma' expressions added earlier in the s=
eries?
>=20
> Yes.
>=20

>=20
> Need to squash in
>=20
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 1dc33c9..8d55ff4 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -301,6 +301,7 @@ class QAPISchemaParser(object):
>                  self._include(include, info, os.path.dirname(abs_fname=
),
>                                previously_included)
>              elif "pragma" in expr:
> +                self.reject_expr_doc()
>                  if len(expr) !=3D 1:
>                      raise QAPISemError(info, "Invalid 'pragma' directi=
ve")
>                  for name, value in expr['pragma'].iteritems():
>=20

Yep, that looks like it. So with the test updated in 30/47, and this
squashed into 31/47, you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PsfncjG7WV6RXGO6jxqCn7vJQpa1dFApg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyTA9AAoJEKeha0olJ0NqS+kIAJvAI8WFe8S9b8lmUmMd/9bD
CUwgg1eIjsnw8SENAA8urFMmfFgob7av9QYfALM6h00FNuh/A4kEBRRLbDBtjU6o
v281Oc6OgGHwmszpHt90qwSobuqHAE9jeIGXVd6VIVGgqvQJT+6A79571qvGL7ah
g4WQN7uL3k0NfZmmxV/eUh7o7xILXot3NXIujrGKKLQsWfd6q2t7H8etr72RqjHV
ciF8mh54rF18NdZGJHMtmSdYblQR6VTokMPK50ZGjx0EiMPZhbKH8mNUZGuOhACr
DT4d2GmtnzZDV8EBT5jXvh0EGgeB6zhRV9hkJo1uSxPR888SMMjq1VXKMaoajjI=
=orAn
-----END PGP SIGNATURE-----

--PsfncjG7WV6RXGO6jxqCn7vJQpa1dFApg--
