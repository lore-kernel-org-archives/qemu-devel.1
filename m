Received: from eggs.gnu.org ([2001:4830:134:3::10]:39969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0SrV-0004Gb-1k
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0SrR-0002Vu-N1
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:40:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e0SrR-0002Uh-5K
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:40:17 -0400
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-3-armbru@redhat.com>
	<c3221525-70bc-475d-07c0-bbf47b507e5e@redhat.com>
	<87k208alxk.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a33e6eda-addd-dbb8-eb26-f12c1eb89da3@redhat.com>
Date: Fri, 6 Oct 2017 08:40:12 -0500
MIME-Version: 1.0
In-Reply-To: <87k208alxk.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="97EI1CLr9FEHcAHwcKLF69BE89xcwRBdP"
Subject: Re: [Qemu-devel] [RFC PATCH 02/32] texi2pod: Support @verbatim
 environment
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
--97EI1CLr9FEHcAHwcKLF69BE89xcwRBdP
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 mdroth@linux.vnet.ibm.com
Message-ID: <a33e6eda-addd-dbb8-eb26-f12c1eb89da3@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 02/32] texi2pod: Support @verbatim
 environment
References: <20171002152552.27999-1-armbru@redhat.com>
 <20171002152552.27999-3-armbru@redhat.com>
 <c3221525-70bc-475d-07c0-bbf47b507e5e@redhat.com>
 <87k208alxk.fsf@dusky.pond.sub.org>
In-Reply-To: <87k208alxk.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/06/2017 12:24 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 10/02/2017 10:25 AM, Markus Armbruster wrote:
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  scripts/texi2pod.pl | 11 +++++++++--
>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>

>>> +	and not (/^\@end\s+([a-z]+)/ and $1 eq $endw)) {
>>
>> You anchored to the beginning, but not the end, of the line; that mean=
s
>> you accept '@end verbatim garbage' as an end marker.  Worth adding $?
>=20
> Cribbed from
>=20
>     # End-block handler goes up here because it needs to operate even
>     # if we are skipping.
>     /^\@end\s+([a-z]+)/ and do {
> 	# Ignore @end foo, where foo is not an operation which may
> 	# cause us to skip, if we are presently skipping.
> 	my $ended =3D $1;
> 	next if $skipping && $ended !~ /^(?:ifset|ifclear|ignore|menu|iftex|co=
pying)$/;
>=20
> 	die "\@end $ended without \@$ended at line $.\n" unless defined $endw;=

> 	die "\@$endw ended by \@end $ended at line $.\n" unless $ended eq $end=
w;
>=20
> 	$endw =3D pop @endwstack;
>=20
> I'd prefer to stick to this regexp.

Consistency makes sense.

>=20
> texi2pod.pl parses quite sloppily in general.
>=20
>> If that's the only change, I'm okay with adding:
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Does this apply to the unchanged patch, too?

Yes.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--97EI1CLr9FEHcAHwcKLF69BE89xcwRBdP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnXh7wACgkQp6FrSiUn
Q2ql7Qf5Ae7XIsrUsWJQsapyEdMiLjRDFtqga9e+bKb8X1mpCtCo8FI4aAVehc0J
mUACdwgxNz7xji7L5FasjiwosL7VKGJSbrmunFI1TqEWil5h6EAjxNs/cTBc/pNY
bnlKJBeimHGo9MGQ+o2yNLcYYablKl1dJNpEPBNVJTh4MeVUsVgnOGuR4pjhctzX
vwLYNinBf26tYuY1IwJIEkmBODvNVsSrMrexB2HFT04InEf6HnnmBNoXdvxS+hPx
oby1jgtIvL8lM+XUP8jLVSvGC+HbzG7PS8VUKk4qxgSXvvK7orioHfULx267vYEG
0szOK081Pb6KXBGEvwUBlQChe2e8lg==
=szWW
-----END PGP SIGNATURE-----

--97EI1CLr9FEHcAHwcKLF69BE89xcwRBdP--
