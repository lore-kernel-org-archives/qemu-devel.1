Received: from eggs.gnu.org ([2001:4830:134:3::10]:47573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co7oQ-0000CA-E9
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co7oL-00071G-Hh
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1co7oL-00070z-8n
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:13:49 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-27-git-send-email-armbru@redhat.com>
	<c75316de-3aa7-c6d5-a626-fd407a31789c@redhat.com>
	<8737efro8t.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9cb94c9c-8f39-c283-5202-08ac7de13954@redhat.com>
Date: Wed, 15 Mar 2017 07:13:46 -0500
MIME-Version: 1.0
In-Reply-To: <8737efro8t.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vvAUEJUr3Laik7UWMgdXMguXRxpdOUfgg"
Subject: Re: [Qemu-devel] [PATCH for-2.9 26/47] qapi2texi: Generate
 reference to base type members
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
--vvAUEJUr3Laik7UWMgdXMguXRxpdOUfgg
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 mdroth@linux.vnet.ibm.com
Message-ID: <9cb94c9c-8f39-c283-5202-08ac7de13954@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 26/47] qapi2texi: Generate reference
 to base type members
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-27-git-send-email-armbru@redhat.com>
 <c75316de-3aa7-c6d5-a626-fd407a31789c@redhat.com>
 <8737efro8t.fsf@dusky.pond.sub.org>
In-Reply-To: <8737efro8t.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 02:30 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20

>>> @@ -152,6 +152,8 @@ def texi_members(doc, what, member_func):
>>>          else:
>>>              desc =3D 'Not documented'
>>>          items +=3D member_func(section.member) + texi_format(desc) +=
 '\n'
>>> +    if base:
>>> +        items +=3D '@item The members of @code{%s}\n' % base.doc_typ=
e()
>>
>> Will this still work for implicit bases?
>>
>>> =20
>>> @@ -205,11 +207,13 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVi=
sitor):
>>>              typ =3D 'Flat Union'
>>>          else:
>>>              typ =3D 'Simple Union'
>>> +        if base and base.is_implicit():
>>> +            base =3D None
>>
>> Hmm - you just ignore those, such as the anonymous base in CpuInfo.  O=
n
>> the other hand, CpuInfo documents its base fields explicitly.  Are we =
at
>> risk of double-documenting a base member, both explicitly and via its
>> named base type?
>=20
> Actually no.
>=20
> Doc comments should document exactly the members defined locally.  This=

> includes members of anonymous bases, but not members of named bases.  I=
f
> you try to document members of named basses, you get your wrist slapped=
=2E

Cool, we enforce a uniform style.  That's what I was missing.

>> At any rate, this patch is an incremental improvement, so:
>> Reviewed-by: Eric Blake <eblake@redhat.com>

And you've shown me that we don't even need a followup for my original
concern.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vvAUEJUr3Laik7UWMgdXMguXRxpdOUfgg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyS/6AAoJEKeha0olJ0Nq3s0H/j2EB8t8bJ1sLOhjOpj5ajjp
sC1PlWBOGBy0XcXdpJak8ru9DyPcisZoamiTKGJlZAY6KqDd85p/NtAL55BSlJgI
+tAOPHMbAlUAUTHMXycUHTCYZxtI7E3cRa/gb+HCA3NlfW6bKvO9oz4lXst7s4Vk
27ISUpz0akXiSMxIJ22BaEALfr71o2qHq3dtBCDQ0LmMv59OTRYhGvnHLHh1zlfn
M9DaurcZCMmQkb5CxGHcHgtZQZxNuXkdrxIKkiSjB9FDMtbkK+9kB6dKUqoQJIEA
C6OvikoeDJShA+mmF+iMqmvdJYxOufJljTgqoLtxTyPkE9/xhdbT+XJhYEloIYs=
=5Tg7
-----END PGP SIGNATURE-----

--vvAUEJUr3Laik7UWMgdXMguXRxpdOUfgg--
