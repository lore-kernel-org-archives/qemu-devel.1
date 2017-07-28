Received: from eggs.gnu.org ([2001:4830:134:3::10]:57437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbBC6-0002gN-A9
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbBC3-0006Sg-6d
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:45:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dbBC2-0006Rl-T5
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:45:03 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-48-f4bug@amsat.org>
	<87r2x0le8c.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e70f6b76-4a83-9afb-d549-73bb5a229d70@redhat.com>
Date: Fri, 28 Jul 2017 14:44:56 -0500
MIME-Version: 1.0
In-Reply-To: <87r2x0le8c.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="W7VDeD2N7stp9xvlBDXwrlfEwnSRmaqOo"
Subject: Re: [Qemu-devel] [RFC PATCH 47/47] script to find outdated entry in
 MAINTAINERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W7VDeD2N7stp9xvlBDXwrlfEwnSRmaqOo
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Message-ID: <e70f6b76-4a83-9afb-d549-73bb5a229d70@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 47/47] script to find outdated entry in
 MAINTAINERS
References: <20170728053610.15770-1-f4bug@amsat.org>
 <20170728053610.15770-48-f4bug@amsat.org> <87r2x0le8c.fsf@dusky.pond.sub.org>
In-Reply-To: <87r2x0le8c.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 11:26 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---

>> +# This script checks MAINTAINERS consistency
>=20
> Consistency?  I think you mean coverage.

Indeed - consistency implies even more, such as all email addresses and
git trees are still valid.  Coverage is merely that all files at least
have one listed owner, whether or not that owner is still correct.

> But what I really want is checkpatch whining when it happens.  Thomas
> posted a patch some time ago.  Would you be willing to revive it?
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05742.html
> Message-Id: <1485436265-12573-5-git-send-email-thuth@redhat.com>
>=20
> Basically:
>=20
> * Patch deletes a file
>=20
>   - still in MAINTAINERS after the patch: warn
>   - else: ok
>=20

Careful, since we have globs in MAINTAINERS.  I guess it really means:

* Patch deletes a file:
   - check all lines in MAINTAINERS; if any no longer maps to a file: war=
n
   - else: ok

> * Patch creates a file
>=20
>   - not in in MAINTAINERS after the patch: warn
>   - else: ok
>=20
> * Patch moves a file

Same as delete + move, even if it shows up in git differently.

>=20
> May have to ignore "uninteresting" files to reduce the noise.  But even=

> ignoring everything but *.[ch] would be an improvement!

And like all checkpatch warnings, maintainers (or, in this case, lack of
maintainer?) can ignore the warning and submit pull request anyway.  But
the key part is that by making it part of checkpatch, coupled with
patchew CI, the whole list would know who's ignoring the warnings :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--W7VDeD2N7stp9xvlBDXwrlfEwnSRmaqOo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7lDgACgkQp6FrSiUn
Q2o2nAf+MZLhd0R5ObfxNqG/nbiQw/k1LCocTbZQcEUZ8VsMmL1pSZFl2r/rpqbz
FsNjCPJHedRW5RdhOT1cXQVrn6c+NjO8T8DUDeHr6la/9kxPJJJFbevl1J/f7n2/
BbhnWegp7OFFxH9kzljJRG3kxzj7JcjaIw1NkfD97n5BEqVBZ1tNlu2mXWzmIF2P
RZeOAsYGh8nwDRsbCENtAQ1M9C2alGsHI2a8RuqeuYlHV6BJ+gyMySTC3baTT4kv
2GTnAo9eBuizNdR3gT14mB+Yi+x3mzUiuKuyPLMWSIOIfawgDqNJGLjJH4rKovBt
GY02cOfcVNnM4H5UbZsYdgEMwhkHlg==
=me6g
-----END PGP SIGNATURE-----

--W7VDeD2N7stp9xvlBDXwrlfEwnSRmaqOo--
