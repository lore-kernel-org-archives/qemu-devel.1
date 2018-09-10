Received: from eggs.gnu.org ([2001:4830:134:3::10]:36249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fzPPI-0000I5-HA
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 12:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fzPPH-0004Ex-II
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 12:51:24 -0400
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180910151848.GJ4901@dhcp-200-186.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a043566e-f794-5be0-b0dd-29490f735486@redhat.com>
Date: Mon, 10 Sep 2018 18:51:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180910151848.GJ4901@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1a6U3gaRGamShXn39KxFIXDddGech5Pd1"
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 00/31] block: Fix some filename
 generation issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1a6U3gaRGamShXn39KxFIXDddGech5Pd1
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <a043566e-f794-5be0-b0dd-29490f735486@redhat.com>
Subject: Re: [PATCH for-3.1 v10 00/31] block: Fix some filename generation
 issues
References: <20180809213528.14738-1-mreitz@redhat.com>
 <20180910151848.GJ4901@dhcp-200-186.str.redhat.com>
In-Reply-To: <20180910151848.GJ4901@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.09.18 17:18, Kevin Wolf wrote:
> Am 09.08.2018 um 23:34 hat Max Reitz geschrieben:
>> Once more, I=E2=80=99ll spare both me and you another iteration of the=
 cover
>> letter, so see here:
>>
>> http://lists.nongnu.org/archive/html/qemu-block/2017-09/msg01030.html
>>
>> (Although this series no longer includes a @base-directory option.)
>>
>> In regards to the last version, the biggest change is that I dropped
>> backing_overridden and instead try to compare the filename from the
>> image header with the filename of the actual backing BDS to find out
>> whether the backing file has been overridden.
>>
>> In order that this doesn=E2=80=99t break whenever the header contains =
a slightly
>> unusual (=E2=80=9Cnon-canonical=E2=80=9D) backing filename (e.g. =E2=80=
=9Cfile:foo.qcow2=E2=80=9D or
>> =E2=80=9Cnbd:localhost:10809=E2=80=9D instead of =E2=80=9Cnbd://localh=
ost:10809=E2=80=9D, i.e. something
>> different from what bdrv_refresh_filename() would generate), when the
>> reference filename in the BDS (auto_backing_file) is used to open the
>> backing file, it is updated from the backing BDS's resulting filename.=

>=20
> This doesn't seem to apply cleanly any more.

I know, but is that a "Please send your current v11 to the list"?

Max


--1a6U3gaRGamShXn39KxFIXDddGech5Pd1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluWoPwACgkQ9AfbAGHV
z0Aklgf+L88iHMoKSLvDLWRJ84+flH0vYqNIrQp4Lm0lOk6A/HbzWhNdCk7sW9/T
ph9x55RPiLpBhdQCGzn56pk/Rx3Iil3788QF016Acys6ZB/LQj3rMPkckHK8LY3i
DebK2MjycsnL2HRvOb7I8UVVEdgCBc8vuoJoyaqo2IX3tpT+qFeO41M2g5voev4J
m2lCW7F9V4glNMFmQSazJzDloY79A8jQiMzVS5LY9ta1SIAgx4oRDRVy8IpmovA4
lWTMf/nSsKzM9YpGi320CcSdctAMcBR+wr0dXBTqdq9zQaPb5dl5/X8ajDFseuvD
Y7QOCFQzX2mTJjsq7MJ+Im6bP60HLw==
=kAvd
-----END PGP SIGNATURE-----

--1a6U3gaRGamShXn39KxFIXDddGech5Pd1--
