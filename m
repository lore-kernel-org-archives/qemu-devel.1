Received: from eggs.gnu.org ([2001:4830:134:3::10]:49765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elZmg-0005HG-Rg
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:34:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elZmf-00039t-WB
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:34:06 -0500
Date: Tue, 13 Feb 2018 13:33:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180213123358.GF5083@localhost.localdomain>
References: <cover.1517840876.git.berto@igalia.com>
	<f441889f-c0a7-8b7b-5125-e9d852896669@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <f441889f-c0a7-8b7b-5125-e9d852896669@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/39] Allow configuring the qcow2 L2
 cache entry size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.02.2018 um 17:31 hat Max Reitz geschrieben:
> On 2018-02-05 15:33, Alberto Garcia wrote:
> > this is the new revision of the patch series to allow configuring the
> > entry size of the qcow2 L2 cache. Follow this link for the full
> > description from the first version:
> >=20
> >    https://lists.gnu.org/archive/html/qemu-block/2017-10/msg00458.html
> >=20
> > And here are some numbers showing the performance improvements:
> >=20
> >    https://lists.gnu.org/archive/html/qemu-block/2017-12/msg00507.html
> >=20
> > Regards,
> >=20
> > Berto
>=20
> Looks good to me, and all qcow2 iotests pass when the default L2 slice
> size is changed (in the code) to 512, so it should be good.
>=20
> I'll still give it a couple of days for others to protest. :-)

I didn't review the series in detail, but the approach looks sane to me,
so no objections from my side.

Kevin

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJagts2AAoJEH8JsnLIjy/W92UP/3X4Eijaepc0lCPmDOPFPeMJ
bbFGiPNgChxTlzNHswQMK/gZzsupKvshAlMldY+078H4LOj2JgJTL8uUrPU0fLqX
DM1W6HRKbRO4Q/5NebprxE7oeJt4T+m5ye2So2m3aLxGHqYofNLa+uJEmsIPa1eJ
5Or5ZUJriqypiOYHUTHgxveOGBgcqTzHfwi3a4Wq3EWwlV2gWToxDR8WbULifDbf
rnNVZSBVfuXOXmPATBoNhR8zl6CaPMlvSVn2HDT2ZjGh8iBhhHVQg/d9E7SYSvoQ
+J58d91FOsWt4EfmXRFimAG1BWFjN6afeKlB4l01pZ1XEGrueiRYFH21zym3hQcZ
sk0LTp91nAsHtLj5jtRlQQOD1C1zDkyMR6dIhpxjh/SRTuQrmphjT5n16fojF6Bk
GHM6nI58H469j7sbT9bocSsNh1k/TL4ZlMOj9KAUsMzJfE7QICOYeShbXsrujn1j
jhtSIpNCYKKJrfShqKLGYbqe/XTuoZiZHJgXJMjDnwoNAnzpxAeY9T7NxgeJZvM0
DQ/wjb9w3SIMVJ31nq2iGThqGLlPaHX5rwj8l+sLULmXk2Pcr9a50xzS/Pgo50Kc
L7WiQI5C5nG/q9j1UOHf4FJXd/wDYkA0yQfOgxpu6BFNiGyj9SI2Q5K9iKSorlky
tbMpE+SN2+INJNvsxKym
=TDXB
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
