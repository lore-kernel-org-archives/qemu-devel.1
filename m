Received: from eggs.gnu.org ([2001:4830:134:3::10]:40083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1egBru-0004N1-CI
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1egBro-0001wj-Kx
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:01:14 -0500
Date: Mon, 29 Jan 2018 16:01:04 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129160104.GN20446@stefanha-x1.localdomain>
References: <VI1PR10MB0301515CFEEA940842FDF26FB7330@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
	<20171211115634.GI13593@stefanha-x1.localdomain>
	<VI1PR10MB030143CAC84D8E8AA783C0B0B7370@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
	<20171213112345.GK16782@stefanha-x1.localdomain>
	<VI1PR10MB0301BD1873225A06B658C988B7350@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aSnC4ZPPfhCvD8sN"
Content-Disposition: inline
In-Reply-To: <VI1PR10MB0301BD1873225A06B658C988B7350@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
Subject: Re: [Qemu-devel] qemu process crash: Assertion failed:
 QLIST_EMPTY(&bs->tracked_requests)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fernando Casas =?iso-8859-1?Q?Sch=F6ssow?= <casasfernando@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Jeff Cody <jcody@redhat.com>


--aSnC4ZPPfhCvD8sN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 03:33:01PM +0000, Fernando Casas Sch=C3=B6ssow wrot=
e:
> Maybe I=E2=80=99m missing something here but, if I recall correctly, the =
qemu process for the guest is terminated when this problem happens. So how =
a debugger will be attached to a process that is gone?

Sorry, this got lost in my inbox.

assert(false) sends SIGABRT to the process.  The default behavior is to
dump a core file that can be analyzed later with GDB.

Your system must have core dumps enabled (i.e. ulimit -c unlimited).
Also, various pieces of software like systemd's coredumpctl can
influence where and how core dumps are stored.

But in short, an assertion failure produces a core dump.

Stefan

--aSnC4ZPPfhCvD8sN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJab0VAAAoJEJykq7OBq3PIncEIAKqFw3BMEEzz3IVcT4XbIR+n
kHrjH0/69OVFbBZHHaZ5AbWXn8vn3ku3O0+ammNE6PBH64OWzve9ga4KqJFBYcbS
y+GYSx4DpN1aY8UM204HdbShlIxo+r1oNHN5/kzYUatGtJMDWILhJLIDBGM1JFSm
S0FR+A1efVE8VJ1JY5vUrDqtd9Tf+znBCbdjpgjx7VdHf16td8sMiSG3gRty+n9/
wNaeDeAAWxociZCWcCgZfyDSlGGcP97ds8W8CEDkTXCkGTNoNMptMtYBQUjJC2uy
i1XoDxTizW4dxd50JTHKLNl4HeVPp7Y6H0fyY5uV9W30JokTqM2furomFzUGQxM=
=TZhy
-----END PGP SIGNATURE-----

--aSnC4ZPPfhCvD8sN--
