Received: from eggs.gnu.org ([2001:4830:134:3::10]:38981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXXsa-00059O-Rd
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXXsZ-0006NL-Qi
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:09:56 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-11-git-send-email-armbru@redhat.com>
	<1aa2bff6-8798-cfd4-e969-b98064dd7d4c@redhat.com>
	<87d18xk2si.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1f4e349-c312-9000-6dc3-d3fa46fce903@redhat.com>
Date: Tue, 18 Jul 2017 14:09:46 -0500
MIME-Version: 1.0
In-Reply-To: <87d18xk2si.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jrN1gE0sgNonPtKH4vU4P4uufVBg2x5rr"
Subject: Re: [Qemu-devel] [PATCH for-2.10 10/10] migration: Use JSON null
 instead of "" to reset parameter to default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jrN1gE0sgNonPtKH4vU4P4uufVBg2x5rr
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com
Message-ID: <d1f4e349-c312-9000-6dc3-d3fa46fce903@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 10/10] migration: Use JSON null
 instead of "" to reset parameter to default
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-11-git-send-email-armbru@redhat.com>
 <1aa2bff6-8798-cfd4-e969-b98064dd7d4c@redhat.com>
 <87d18xk2si.fsf@dusky.pond.sub.org>
In-Reply-To: <87d18xk2si.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 01:39 PM, Markus Armbruster wrote:

>>> +++ b/qapi-schema.json
>>> @@ -116,6 +116,13 @@
>>>  { 'command': 'qmp_capabilities' }
>>> =20
>>>  ##
>>> +# @StrOrNull:
>>
>> A little light on the documentation.
>=20
> Care to suggest improvements?  I figure the schema is obvious enough
> without any, but the generated documentation could perhaps use some.

Perhaps:

Specifies a string value or the explicit lack of a string (often used as
an optional parameter type, where omitting the parameter has different
semantics than supplying null).
@s a JSON string
@n an explicit NULL


and certainly worth having

Since: 2.10

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jrN1gE0sgNonPtKH4vU4P4uufVBg2x5rr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluXPoACgkQp6FrSiUn
Q2pAHQf/TTb/UQYjUiYHx/L8P8yFxU9oaEGmpHeIPXZV9VNX3a0NNbNImeSLYZkO
OQywWGownDI9JinV85VrFmfCNCDwniUvKqpvQ/W6173AKZ5MawnZ0wwuMGTfkQNE
qIUSqoumKEo7w770OPK6Vw6V2Hwgjlp6XdAS609L5I0UBspzOSPPhrvaLb5aZkhj
D3moOCEiZ+C0AL6NZ8jfUKmBWitec5K1t3PLJ3nRz2H4BBs1ZXMc/K3jNOpxyayO
Gap8b77PefCVo+f1pa2gaobYH4jam687bKg1A2yPvvnysWwgPJXDgmooP9Tha6Lg
6zFQ/PZuvRyrIRNnPJYMPYD63ByQZQ==
=x/+/
-----END PGP SIGNATURE-----

--jrN1gE0sgNonPtKH4vU4P4uufVBg2x5rr--
