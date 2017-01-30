Received: from eggs.gnu.org ([2001:4830:134:3::10]:55187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYGpm-0004of-1l
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYGph-000091-He
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:37:46 -0500
References: <20170126110435.2777-1-berrange@redhat.com>
	<20170126110435.2777-4-berrange@redhat.com>
	<20170126123530.GB23095@lemon.Home> <20170126132708.GB29127@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
Date: Mon, 30 Jan 2017 12:37:28 -0600
MIME-Version: 1.0
In-Reply-To: <20170126132708.GB29127@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nGkThvJuioVSUQdDaQCFVOBUo4jTm2GgA"
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nGkThvJuioVSUQdDaQCFVOBUo4jTm2GgA
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
References: <20170126110435.2777-1-berrange@redhat.com>
 <20170126110435.2777-4-berrange@redhat.com>
 <20170126123530.GB23095@lemon.Home> <20170126132708.GB29127@redhat.com>
In-Reply-To: <20170126132708.GB29127@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2017 07:27 AM, Daniel P. Berrange wrote:
> On Thu, Jan 26, 2017 at 08:35:30PM +0800, Fam Zheng wrote:
>> On Thu, 01/26 11:04, Daniel P. Berrange wrote:
>>> The -n arg to the convert command allows use of a pre-existing image,=

>>> rather than creating a new image. This adds a -n arg to the dd comman=
d
>>> to get feature parity.
>>
>> I remember there was a discussion about changing qemu-img dd's default=
 to a
>> "conv=3Dnocreat" semantic, if so, "-n" might not be that useful. But t=
hat part
>> hasn't made it into the tree, and I'm not sure which direction we shou=
ld take.
>> (Personally I think default to nocreat is a good idea).
>=20
> Use nocreat by default would be semantically different from real "dd"
> binary which feels undesirable if the goal is to make "qemu-img dd"
> be as consistent with "dd" as possible.
>=20
> It would be trivial to rewrite this patch to add support for the "conv"=

> option, allowing the user to explicitly give 'qemu-img dd conv=3Dnocrea=
t'
> instead of my 'qemu-img dd -n' syntax, without changing default semanti=
cs.

Adding 'conv=3Dnocreat' (and not '-n') feels like the right way to me.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nGkThvJuioVSUQdDaQCFVOBUo4jTm2GgA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj4foAAoJEKeha0olJ0NqnY8H/R7d2XM8l8Z85eaTg7J8z6dh
bz85W+8eJJOhntUPjOGlqnI2F4qCq3hCOMikDYO9gxsjSzptsZcoCgArB/9fTW0M
JvM4N28jF8r+L1ucpkVnf8KHiZhj/Y9xBe3+69mx5J4yNYb+whqA7Mlah0JBigSG
qO2F2YVtBa/ko4aLTFZ2v5LpYKRySGTUxM+7wev7UEvY9MqlqFE+Xxvpb22kSFBB
hAZgB/VZ+00rF9qc98YI0yKNOI9cMcjTFypR4inEfIrGUwLcFiMRo/BSbwz5/5/1
FAadOqVWgXRe/i/85Fo1ZTA3ZFFTLa3n+5hkF2nDlT8/jrNybNR42zyEmNiHcew=
=gHCe
-----END PGP SIGNATURE-----

--nGkThvJuioVSUQdDaQCFVOBUo4jTm2GgA--
