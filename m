Received: from eggs.gnu.org ([2001:4830:134:3::10]:52277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpEaT-0008Dc-Dp
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpEaS-00081s-E4
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:16:53 -0400
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-7-lbloch@janustech.com>
	<w5136vm8m8u.fsf@maestria.local.igalia.com>
	<ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
	<BDD8E417-5EE2-4B3A-BF19-C37A7BBD0330@janustech.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <572652c3-bb11-4158-c3ec-8dc786fd2ae8@redhat.com>
Date: Mon, 13 Aug 2018 17:16:43 +0200
MIME-Version: 1.0
In-Reply-To: <BDD8E417-5EE2-4B3A-BF19-C37A7BBD0330@janustech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ks6GIjHhDg9lkUq0x5bnMoifpJfWsXscZ"
Subject: Re: [Qemu-devel] [PATCH v7 6/9] qcow2: Increase the default upper
 limit on the L2 cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ks6GIjHhDg9lkUq0x5bnMoifpJfWsXscZ
From: Max Reitz <mreitz@redhat.com>
To: Leonid Bloch <lbloch@janustech.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <572652c3-bb11-4158-c3ec-8dc786fd2ae8@redhat.com>
Subject: Re: [PATCH v7 6/9] qcow2: Increase the default upper limit on the L2
 cache size
References: <20180810062647.23211-1-lbloch@janustech.com>
 <20180810062647.23211-7-lbloch@janustech.com>
 <w5136vm8m8u.fsf@maestria.local.igalia.com>
 <ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
 <BDD8E417-5EE2-4B3A-BF19-C37A7BBD0330@janustech.com>
In-Reply-To: <BDD8E417-5EE2-4B3A-BF19-C37A7BBD0330@janustech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-13 08:09, Leonid Bloch wrote:
> On August 13, 2018 4:39:35 AM EEST, Max Reitz <mreitz@redhat.com> wrote=
:

[...]

>> Ideally we'd probably want a soft and a hard cache limit, but I don't
>> know...
>>
>> (Like, a soft cache limit of 1 MB with a CCI of 10 min, and a hard
>> cache
>> limit of 32 MB with a CCI of 1 min by default.  So whenever your cache=

>> uses more than 1 MB of RAM, your CCI is 1 min, and whenever it's below=
,
>> your CCI is 10 min.)
>=20
> Max, thanks for your insight. Indeed some good points.
> Considering this, I'm thinking to set the limit to 16 MB, and the CCI t=
o 5 min. What do you think?

I think it's good for a preliminary solution, and then later increase
the limit with the soft and hard limits.

OTOH, if we implement the soft/hard limits, it doesn't really matter
what default you choose now...

> Modern Windows installations should gain performance from being able to=
 random I/O to >8 GB chunks, and data processing tasks where each data se=
t is 8+ GB for sure do (did benchmarks). And the maximum is only ever use=
d if (a) the image is large enough and (b) it is indeed used.
> While taking 256 GB images as the "limit" can be considered an overshoo=
t, 128 GB is quite reasonable, I think.
>=20
> Your idea with "soft" and "hard" limits is great! I'm tempted to implem=
ent this. Say 4 MB with 10 min., and 16 MB with 5 min?

32 MB and 2 or 3 min? :-)

If you do that, I'm fine with a plain default of 32 MB for now.

Max


--Ks6GIjHhDg9lkUq0x5bnMoifpJfWsXscZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltxoNsACgkQ9AfbAGHV
z0C4Hwf+OLfePsUQ6A5jZ1iQMmN4UpWf5+29z9b0sty4IjRS9bqQYEWDTEpOKXvu
sACk98SgjWZAITJQkaIusNqGTqTxAhfZwMOghUOJ5UaFoGna+A1pL2All1ztZ9cV
KKtdFtluiAGRfneu00R2/FYp8C6D8tcVQTRlm8gKZbmlLRoHezzWj5rKYCSRHpKl
N5EKt8jIYGyKDZQ/iydLbleJePadkE5td3l0tSIkx3yCpPENRI1BDZWtDRdMDpO5
lgpuNa1dWifYnjveZtDhnTTyetXt7LABCWJ0BPxwGUm3sycng2tHpbpjPx4jrlvo
gssWfffd8jWSKtZSSFHvLn6FEYYU2w==
=HW0a
-----END PGP SIGNATURE-----

--Ks6GIjHhDg9lkUq0x5bnMoifpJfWsXscZ--
