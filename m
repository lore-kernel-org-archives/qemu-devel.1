Received: from eggs.gnu.org ([2001:4830:134:3::10]:51471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFnyA-000059-AY
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFny9-0000Vo-CQ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:42:22 -0400
References: <1496158724-2809-1-git-send-email-kchamart@redhat.com>
	<df3d406e-d9e2-73e0-4943-23fac349c1b3@redhat.com>
	<20170530202428.vtz3f6jopr74huzb@eukaryote>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6696ea97-8bf0-44b0-d515-e760f5ac4803@redhat.com>
Date: Tue, 30 May 2017 15:42:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170530202428.vtz3f6jopr74huzb@eukaryote>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="K2bc9jDtofkv6CXtN6GQThJhMNN8KIUhT"
Subject: Re: [Qemu-devel] [PATCH] live-block-ops.txt: Rewrite and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K2bc9jDtofkv6CXtN6GQThJhMNN8KIUhT
From: Eric Blake <eblake@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org
Message-ID: <6696ea97-8bf0-44b0-d515-e760f5ac4803@redhat.com>
Subject: Re: [PATCH] live-block-ops.txt: Rewrite and improve it
References: <1496158724-2809-1-git-send-email-kchamart@redhat.com>
 <df3d406e-d9e2-73e0-4943-23fac349c1b3@redhat.com>
 <20170530202428.vtz3f6jopr74huzb@eukaryote>
In-Reply-To: <20170530202428.vtz3f6jopr74huzb@eukaryote>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 03:24 PM, Kashyap Chamarthy wrote:
> First, thanks for the quick feedback!
>=20
> On Tue, May 30, 2017 at 02:24:40PM -0500, Eric Blake wrote:
>> On 05/30/2017 10:38 AM, Kashyap Chamarthy wrote:
>>> This edition documents all four operations:
>=20

>>> +
>>> +(1) `Disk image backing chain notation`_
>>> +(2) `Brief overview of live block QMP primitives`_
>>> +(3) `Interacting with a QEMU instance`_
>>> +(4) `Example disk image chain`_
>>> +(5) `A note on points-in-time vs file names`_
>>> +(6) `Live block streaming -- `block-stream``_
>>> +(7) `QMP invocation for `block-stream``_
>>> +(8) `Live block commit -- `block-commit``_
>>> +(9) `QMP invocation for `block-commit``_
>>> +(10) `Live disk synchronization -- `drive-mirror`&`blockdev-mirror``=
_
>>> +(11) `QMP invocation for `drive-mirror``_
>>> +(12) `Notes on `blockdev-mirror``_
>>> +(13) `Live disk backup -- `drive-backup`&`blockdev-backup``_
>>> +(14) `QMP invocation for `drive-backup``_
>>> +(15) `Notes on `blockdev-backup``_

> Eric, do you have an opinion:  Now that I _do_ have the notes
> available[*], do you think it is worth spelling out the invocation for
> QMP `blockdev-{backup, mirror}`?  Or wait for later?

I liked how you compared drive-mirror and blockdev-mirror, but it's
probably worth an invocation example in sections 12/15 in addition to
"this is how the block version differs from the drive version".

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--K2bc9jDtofkv6CXtN6GQThJhMNN8KIUhT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLdkgAAoJEKeha0olJ0NqFt0IAKPRv2HJAN12ZEi/eh54Baaw
v+NchGt23eqYk9giwcP5gTuSPNfuPbycXhvVyKxVNgCJmz0Tr/Myu0pzt1wGsZBP
Hvk414/unTkoUyfBjGOl8e5k/aTmshYGQTqTGz5RdX7L/ne1+sBzAE6BsSXiuJS7
OaEJ8jTybhIB3JwcFHHrwLLvTo8DXZURBlnLaFfQ+r4Tlq1gdWbAAEIlIbAv/zFF
J2CM5lu38hh17yWyHp6ZU35F2OVcC5w3YcajbrH5ovO5KKBUpQntTPrpQD9XHPg5
TRpiZxjf9F3viVqAoYSQBvelZiBh4ZGz0CwvQWrguFFF+ChPljrQScV3lK/ug6o=
=tldU
-----END PGP SIGNATURE-----

--K2bc9jDtofkv6CXtN6GQThJhMNN8KIUhT--
