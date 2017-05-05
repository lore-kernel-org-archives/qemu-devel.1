Received: from eggs.gnu.org ([2001:4830:134:3::10]:33246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6lwZ-0001SW-2X
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6lwY-00045f-1e
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:43:23 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<c157232e-5ec4-ddb2-0e35-be8eae2309f5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c43c946b-f469-6b25-7c6a-49300ab740c9@redhat.com>
Date: Fri, 5 May 2017 17:43:14 -0500
MIME-Version: 1.0
In-Reply-To: <c157232e-5ec4-ddb2-0e35-be8eae2309f5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1GCJGAW6XrMCvE99ldubLp93EX7mFocBp"
Subject: Re: [Qemu-devel] [PATCH v12 00/10] qcow2 zero-cluster tweaks [was
 add blkdebug tests]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1GCJGAW6XrMCvE99ldubLp93EX7mFocBp
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <c43c946b-f469-6b25-7c6a-49300ab740c9@redhat.com>
Subject: Re: [PATCH v12 00/10] qcow2 zero-cluster tweaks [was add blkdebug
 tests]
References: <20170504030755.1001-1-eblake@redhat.com>
 <c157232e-5ec4-ddb2-0e35-be8eae2309f5@redhat.com>
In-Reply-To: <c157232e-5ec4-ddb2-0e35-be8eae2309f5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2017 05:18 PM, Max Reitz wrote:
> On 04.05.2017 05:07, Eric Blake wrote:
>> I've collected several improvements for qcow2 zero-cluster handling.
>>
>> Available as a tag at:
>> git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v12
>>
>> Marked as v12 for "hysterical raisins", since it it the half of
>> v10 [1] that was not resubmitted as v11 [2].
>>
>> Depends on Max's block tree:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00641.html
>> and on Max's qcow2 cleanups:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00689.html
>>
>> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05227.htm=
l
>> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05896.htm=
l
>>

> I have given an R-b for every patch, so I could apply the series as-is
> (with the really minor fixes we have talked about, and the thing in
> patch 8), and I would be more or less OK with that. But I did have my
> fair share of nit picks and before I discard all of them, I'd like to
> know for sure that you don't intend to address them, or address them in=

> a follow-up.
>=20
> I'm saying this because some of the issues I had do not really lend
> themselves nicely to a follow-up; for instance the
> s/Data cluster/Cluster allocation/ for patch 4.
>=20
> From my perspective, it's not much more difficult to review a respin of=

> this series which just these minor points changed and maybe some very
> small patches (the follow-up, basically) added to it.

v13 coming soon to a list near you (but maybe not until Monday) - let's
see if it's the lucky one!

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1GCJGAW6XrMCvE99ldubLp93EX7mFocBp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDQACAAoJEKeha0olJ0NqkicH/2mTiCqKVM7fp7jBdBboDuAG
A6WvsU/WM4CyVyOSA5CCNaNb9KAZav9chRBKXVE+uwpXPk50B9qlc2UMl0xpOWQn
CoPX3VoltB7qCiTNCclSIunR81Z41UHTSfoRBAeMFpJE9JMKMbd17z7D4jqCoj+B
1XZeMCDaP1SUO02OVoedEozoEllvcvKILrS1bDcBaOzqRZvoEzMEKeDaRQdnk35u
qL/V1XKEF1fYlsCkjL7H+BtJL693/Q8Q/AYF+nKb2YoXGoSfLZ+eR/RfZRa3m0hB
nz/I/UK1j+LCDSIojk8YwtxR+jKt9BTXrBpF7T8/lZcVHBV+La7FVXj6xYBndyY=
=q46w
-----END PGP SIGNATURE-----

--1GCJGAW6XrMCvE99ldubLp93EX7mFocBp--
