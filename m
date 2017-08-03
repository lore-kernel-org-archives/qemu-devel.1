Received: from eggs.gnu.org ([2001:4830:134:3::10]:43113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddI4m-0003iU-Eh
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddI4l-000746-IW
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:30:16 -0400
References: <20170728164708.12202-1-eblake@redhat.com>
	<20170728164708.12202-2-eblake@redhat.com>
	<20170803151445.GJ4456@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd705e6f-ac49-2555-5316-51e920871d68@redhat.com>
Date: Thu, 3 Aug 2017 10:30:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170803151445.GJ4456@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JEWB0xfdRCik0Rf5S1hlM5xK9DEGwqLWN"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qemu-img: Sort sub-command names in
 --help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JEWB0xfdRCik0Rf5S1hlM5xK9DEGwqLWN
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Message-ID: <bd705e6f-ac49-2555-5316-51e920871d68@redhat.com>
Subject: Re: [PATCH v2 1/4] qemu-img: Sort sub-command names in --help
References: <20170728164708.12202-1-eblake@redhat.com>
 <20170728164708.12202-2-eblake@redhat.com>
 <20170803151445.GJ4456@dhcp-200-186.str.redhat.com>
In-Reply-To: <20170803151445.GJ4456@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 10:14 AM, Kevin Wolf wrote:
> Am 28.07.2017 um 18:47 hat Eric Blake geschrieben:
>> 'amend' was the only sub-command not listed alphabetically;
>=20
> Not completel true: create is the second one that is in the wrong place=
,
> it should come after commit/compare/convert. Do you want to fix that
> one, too?

Indeed.  I wonder if part of the issue is due to an 80-columen window
displaying qemu-img --help as a wall-o-text and therefore I missed
command names; maybe some well-place newlines and tabs would aid
legibility, as in:

  bench [-c count] [-d depth] [-f fmt] [--flush-interval=3Dflush_interval=
]
	[-n] [--no-drain] [-o offset] [--pattern=3Dpattern] [-q]
	[-s buffer_size] [-S step_size] [-t cache] [-w] [-U] filename
  check [-q] [--object objectdef] [--image-opts] [-f fmt]
	[--output=3Dofmt] [-r [leaks | all]] [-T src_cache] [-U] filename
=2E..

But for this patch, I'll just fix the sorting of 'create'.

>=20
>> hoist it earlier, and separate the @end table block to make it easier
>> to copy-and-paste the addition of future sub-commands.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Kevin
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JEWB0xfdRCik0Rf5S1hlM5xK9DEGwqLWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmDQX0ACgkQp6FrSiUn
Q2rx3gf/Q0tuxok8pBswjUh3DAoPYChDzJ3B0yhsZYVL4e/etIT2GNJUXHKjZmYC
bAT0ibdIgKWMOg1qW0iaiDbfDbg1asJENQujkHVZuvqHrfIQgetR+TAGF8BqjCKS
nQUp+3lbIfN4AE8aW9QUnc/fv9YmKvRWeUVQmw9HFo1Us6Rvj75geEh2hkS0c/Xt
p+A1tetlrYgTSjJM1BSFm7W+LEdmATgIBIkaAQb3D8JSvNEflsxoxkU9ISnaQeqO
M0xnlTbaWCXyDtMDSUPE9ZcaCkERGLojWbuhNw+qPAPDAayrQT3S8PYgAlrl8Kzy
Rqjm9D4c4VO5+lWbmUA/X+dQD+RhKg==
=sPf/
-----END PGP SIGNATURE-----

--JEWB0xfdRCik0Rf5S1hlM5xK9DEGwqLWN--
