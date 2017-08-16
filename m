Received: from eggs.gnu.org ([2001:4830:134:3::10]:34882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhxHg-0003e0-JS
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhxHf-0001ji-I7
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:18:52 -0400
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
	<6ebebb61-1f5e-391b-03d7-cae2bee99a2f@redhat.com>
	<20170816094135.beufpqce3v4amhl3@postretch>
	<1d2871d5-e224-6bc7-ebc1-f791357371ce@redhat.com>
	<20170816121138.jecvtc7ei3sgqomp@postretch>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a4664b0a-cfce-c495-02f0-ffd2668b1e44@redhat.com>
Date: Wed, 16 Aug 2017 07:18:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170816121138.jecvtc7ei3sgqomp@postretch>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nCKXNtvlb6BqP2kSgm0bSqRmTcr18QODp"
Subject: Re: [Qemu-devel] [PATCH RFC] block: add block-insert-node QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nCKXNtvlb6BqP2kSgm0bSqRmTcr18QODp
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block <qemu-block@nongnu.org>
Message-ID: <a4664b0a-cfce-c495-02f0-ffd2668b1e44@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] block: add block-insert-node QMP command
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
 <6ebebb61-1f5e-391b-03d7-cae2bee99a2f@redhat.com>
 <20170816094135.beufpqce3v4amhl3@postretch>
 <1d2871d5-e224-6bc7-ebc1-f791357371ce@redhat.com>
 <20170816121138.jecvtc7ei3sgqomp@postretch>
In-Reply-To: <20170816121138.jecvtc7ei3sgqomp@postretch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/16/2017 07:11 AM, Manos Pitsidianakis wrote:

>>
>> Given a qcow2 image backing chain:
>>
>> base <- active
>>
>> there are four BDS (2 format, 2 protocol).  Ideally, I could add
>> filtering to any one of those four nodes (a filter on the base protoco=
l
>> level restricts how much guest data can be used from the backing image=
,
>> but with no limits on the qcow2 metadata; a filter on the base format
>> level restricts metadata reads as well; similarly for filters on the
>> active protocol and format layers).
>>
>> But adding a filter on 'active' at the format level has no pre-existin=
g
>> parent (I'm adding the filter as the new top-level).  Or am I missing
>> something?
>=20
> The parent in this case is the storage device (disk / cdrom), whose nam=
e
> is specified as the parent. The first example in the
> qapi/block-core.json is such a case. In code I check blk_by_name(parent=
)
> and if that doesn't exist, I try with bdrv_find_node(parent).  Perhaps =
I
> should reword the documentation or did I misunderstand what you wrote?

Ah, so you are including both BB and BDS in your set of names for parent
objects.  Yes, clarifying the documentation that the parent can be
either a device name (for the top of the chain) or a node name (for the
middle of the chain) would help; the child name is always a node name
(since we are filtering how the child will be used when accessed from
the parent).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nCKXNtvlb6BqP2kSgm0bSqRmTcr18QODp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmUOB8ACgkQp6FrSiUn
Q2p9XAf/ZQ71XsCZvsNbzKg1Sf+SIj/NVHMvhnYpxqFJOBGruhXCxK6Xl9k15c6O
oYSVefZXJB63s1V8WzatPar5NWuK4EkcJuOE+jRqce0Mu3DXEixjK96tVSJxlC9t
4zjoR3YOhTwDk52tsiiUsGReQojDhgsauv7TPU4wBthEm/TV/jW8W/tB/NQhwPiC
5R+nZHDuFBpp2FLqjgH659d/wFl8RmJZdfGOmFPCKYST3yMjeALGOHu342B5TOFG
DFk2YjF6saGEL+OA2E7YsYX5xwyjv7Cosehs++EheJQ2eT5jJQaT8RFxsxN8BPEd
m5iFAvKGOXZ71SS+lkHFFunGwbghbQ==
=sGIS
-----END PGP SIGNATURE-----

--nCKXNtvlb6BqP2kSgm0bSqRmTcr18QODp--
