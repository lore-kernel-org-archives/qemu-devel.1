Received: from eggs.gnu.org ([2001:4830:134:3::10]:50102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctwoI-0004nO-Ox
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctwoH-0004My-Fr
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:41:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ctwoH-0004MT-5y
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:41:49 -0400
References: <20170331101947.2046-1-vfeenstr@redhat.com>
	<20170331101947.2046-2-vfeenstr@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e60c94da-f3d8-3139-27c5-2c357b37834b@redhat.com>
Date: Fri, 31 Mar 2017 08:41:46 -0500
MIME-Version: 1.0
In-Reply-To: <20170331101947.2046-2-vfeenstr@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8TGHp0GcHq1l8hlCOEVagH4q5AJcnWQWX"
Subject: Re: [Qemu-devel] [PATCH v3] qemu-ga: add guest-get-osrelease command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8TGHp0GcHq1l8hlCOEVagH4q5AJcnWQWX
From: Eric Blake <eblake@redhat.com>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@gmail.com
Message-ID: <e60c94da-f3d8-3139-27c5-2c357b37834b@redhat.com>
Subject: Re: [PATCH v3] qemu-ga: add guest-get-osrelease command
References: <20170331101947.2046-1-vfeenstr@redhat.com>
 <20170331101947.2046-2-vfeenstr@redhat.com>
In-Reply-To: <20170331101947.2046-2-vfeenstr@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 05:19 AM, Vinzenz 'evilissimo' Feenstra wrote:
> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>=20
> Add a new 'guest-get-osrelease' command to report OS information in the=

> os-release format. As documented here:
> https://www.freedesktop.org/software/systemd/man/os-release.html
>=20
> The win32 implementation generates the information.
> On POSIX systems the /etc/os-release or /usr/lib/os-release files
> content is returned when available and gets extended with the fields:
> - QGA_UNAME_RELEASE which is the content of `uname -r`
> - QGA_UNAME_VERSION which is the content of `uname -v`
> - QGA_UNAME_MACHINE which is the content of `uname -m`
>=20
> Here an example for a Fedora 25 VM:
>=20
> virsh # qemu-agent-command F25 '{ "execute": "guest-get-osrelease" }'
> {"return":{"content":"NAME=3DFedora\nVERSION=3D\"25 (Server Edition)\"\=
n
> ID=3Dfedora\nVERSION_ID=3D25\nPRETTY_NAME=3D\"Fedora 25 (Server Edition=
)\"\n
> ANSI_COLOR=3D\"0;34\"\nCPE_NAME=3D\"cpe:/o:fedoraproject:fedora:25\"\n
> HOME_URL=3D\"https://fedoraproject.org/\"\n
> BUG_REPORT_URL=3D\"https://bugzilla.redhat.com/\"\n
> REDHAT_BUGZILLA_PRODUCT=3D\"Fedora\"\n
> REDHAT_BUGZILLA_PRODUCT_VERSION=3D25\nREDHAT_SUPPORT_PRODUCT=3D\"Fedora=
\"\n
> REDHAT_SUPPORT_PRODUCT_VERSION=3D25\n
> PRIVACY_POLICY_URL=3Dhttps://fedoraproject.org/wiki/Legal:PrivacyPolicy=
\n
> VARIANT=3D\"Server Edition\"\nVARIANT_ID=3Dserver\n\n
> QGA_UNAME_RELEASE=3D\"4.8.6-300.fc25.x86_64\"\n
> QGA_UNAME_VERSION=3D\"#1 SMP Tue Nov 1 12:36:38 UTC 2016\"\n
> QGA_UNAME_MACHINE=3D\"x86_64\"\n"}}

Uggh. This is a step backwards.  Now you are requiring the end user to
parse a raw string, instead of giving them the information already
broken out as a JSON dictionary.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8TGHp0GcHq1l8hlCOEVagH4q5AJcnWQWX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3lyaAAoJEKeha0olJ0Nq8zUH/jppxEgB8uc1TiDOP9HiuLie
jV4PXEfh1YnESNbmlxBFCWvMh12oXwhqcQ3AFfVkEWF+wMG6GGSr2Fci7aWas1t/
s9CSU4b/V75SsS5rrehZFWKVseiHf9dysO2B5pfi9y2GhT1vfnnnGv0EYZRqD1WU
IS7wASGK7kiNLUQU0Fc774c6nc50sABPFjwi4bRNfPuuWvszS5cc/4BifFfcCcMd
1PioMKsdik9EGqZahLtlM3AIdyI1C0ZfSnlV4PREeVwFcj1UPJOi8U8LQzJ4qvOi
XCwU4zrkzG1oa37ywouEtRUE6b6HxelL85fhsy38Yyn5Np3ayOAZZgpGIu9/8+A=
=5fua
-----END PGP SIGNATURE-----

--8TGHp0GcHq1l8hlCOEVagH4q5AJcnWQWX--
