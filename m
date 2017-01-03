Received: from eggs.gnu.org ([2001:4830:134:3::10]:57975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOR2t-0001T0-GU
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOR2s-0006y6-Nu
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:30:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOR2s-0006xr-HO
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:30:38 -0500
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
	<1483371890-289981-3-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1778cf8f-03d6-9ba8-d84e-1ac53e9885a3@redhat.com>
Date: Tue, 3 Jan 2017 09:30:35 -0600
MIME-Version: 1.0
In-Reply-To: <1483371890-289981-3-git-send-email-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pdVTivjqBgW3S92Mt144ps2SbEWILPqRa"
Subject: Re: [Qemu-devel] [PATCH 2/3] reuse user_creatable_add_opts()
 instead of user_creatable_add() in monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com, afaerber@suse.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pdVTivjqBgW3S92Mt144ps2SbEWILPqRa
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 afaerber@suse.de
Message-ID: <1778cf8f-03d6-9ba8-d84e-1ac53e9885a3@redhat.com>
Subject: Re: [PATCH 2/3] reuse user_creatable_add_opts() instead of
 user_creatable_add() in monitor
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
 <1483371890-289981-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1483371890-289981-3-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/02/2017 09:44 AM, Igor Mammedov wrote:
> Simplify code by dropping ~57LOC by merging user_creatable_add()
> into user_creatable_add_opts() and using the later from monutor.

s/monutor/monitor/

> Along with it allocate opts_visitor_new() once in user_creatable_add_op=
ts().

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--pdVTivjqBgW3S92Mt144ps2SbEWILPqRa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa8ObAAoJEKeha0olJ0NqaQkH/0LB63HTzUlE40VggTxitqWu
PTMyV5mpIV/qPfx9BCUpPPjj+7c+Dg4/75+thVxlqgCHnUSaOXdyesMfuCP132cL
7Z8njHi0N4Dls2p19ZEd4CAbnYmGTi4XWhnbI89hmyxj1Frjiwmh+jkgaJVWurMd
c3h6u0GYxuyW/9sTkKvg7UsAg+GxHoLSrTqirwHmO9Dwi91zK7Ch3S0JOunzYtkh
7Ybp2zlc0O+RofgxE5U/FMezhdxuAeearWGTZ8kh6Q7iFNmN90VSOmIQ+Z2Tv2Ed
JG6anfMC4kR7GHuSQCiiBlL+Ppz9gZC4OqMuhNxBZHDEWBaeVRvRsv3DNBRldPM=
=L3BX
-----END PGP SIGNATURE-----

--pdVTivjqBgW3S92Mt144ps2SbEWILPqRa--
