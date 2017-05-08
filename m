Received: from eggs.gnu.org ([2001:4830:134:3::10]:36628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7lSp-000107-FP
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7lSo-0008D0-KE
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:24:47 -0400
References: <20170507000552.20847-1-eblake@redhat.com>
	<20170507000552.20847-6-eblake@redhat.com>
	<54dddadc-42a3-0256-09ee-03e8d4d5d0bc@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <78a5041a-52fd-69f1-8678-382a880e6e9f@redhat.com>
Date: Mon, 8 May 2017 11:24:39 -0500
MIME-Version: 1.0
In-Reply-To: <54dddadc-42a3-0256-09ee-03e8d4d5d0bc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LDSEAf2aeMeR1sENPQSUeITTCFd6i2mpw"
Subject: Re: [Qemu-devel] [PATCH v13 05/12] qcow2: Name typedef for cluster
 type
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
--LDSEAf2aeMeR1sENPQSUeITTCFd6i2mpw
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <78a5041a-52fd-69f1-8678-382a880e6e9f@redhat.com>
Subject: Re: [PATCH v13 05/12] qcow2: Name typedef for cluster type
References: <20170507000552.20847-1-eblake@redhat.com>
 <20170507000552.20847-6-eblake@redhat.com>
 <54dddadc-42a3-0256-09ee-03e8d4d5d0bc@redhat.com>
In-Reply-To: <54dddadc-42a3-0256-09ee-03e8d4d5d0bc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 10:43 AM, Max Reitz wrote:
> On 07.05.2017 02:05, Eric Blake wrote:
>> Although it doesn't add all that much type safety (this is C, after
>> all), it does add a bit of legibility to use the name QCow2ClusterType=

>> instead of a plain int.
>>
>> In particular, qcow2_get_cluster_offset() has an overloaded return
>> type; a QCow2ClusterType on success, and -errno on failure; keeping
>> the cluster type in a separate variable makes it slightly easier for
>> the next patch to make further computations based on the type.
>>
>> Suggested-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v13: new patch
>> ---
>>  block/qcow2.h          |  6 +++---
>>  block/qcow2-cluster.c  | 17 +++++++++--------
>>  block/qcow2-refcount.c |  2 +-
>>  3 files changed, 13 insertions(+), 12 deletions(-)
>=20
> [...]
>=20
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index f3bfce6..ed78a30 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>=20
> Above this hunk, there is count_contiguous_clusters() with a variable
> "first_cluster_type" that could be a QCow2ClusterType as well.

Hmm, I guess I didn't catch them all. Yes, that one definitely qualified.=


>=20
>> @@ -340,7 +340,7 @@ static int count_contiguous_clusters(int nb_cluste=
rs, int cluster_size,
>>   */
>>  static int count_contiguous_clusters_unallocated(int nb_clusters,
>>                                                   uint64_t *l2_table,
>> -                                                 int wanted_type)
>> +                                                 QCow2ClusterType wan=
ted_type)
>>  {
>>      int i;
>>
>=20
> And some lines below this (in this function), there is a "type" variabl=
e
> that (c|sh)ould be a QCow2ClusterType, too.

That one I blame on poor rebasing on my side.

>=20
> Although it's quite a functional change, I would be willing to change
> both when applying, if you allowed me to.
>=20
> (Once again, "no good deed shall go unpunished", as Markus likes to say=
 :-))

Yes, both changes are appropriate, and I'm fine with you making the
tweaks as part of putting it on your tree (and the corresponding fallout
on 6/12).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LDSEAf2aeMeR1sENPQSUeITTCFd6i2mpw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEJvHAAoJEKeha0olJ0Nq3x4H+wYrvqnpZW3NWvFUAAZOcYXR
cFSpAGFOuOv41mvByAsOtunqQKrRnp53snpycYsFgOo60q9D20VIZANPUx6NmfBp
NITmV2pmEFs/ISYOLtOICE79lAVwnNwJpR04X+HKdO4yeORJD9DePFcAgKzNrXue
dibvPYTOdPqbhiCawrNeCKEsPl+KKCUr90KZpjBwmWS484DiG1MoQFK0kXqgx6Tv
FKxDfzJA1EThlxXnHoI9flNo5bYDvx3Z+mLMetnJnFf0D0gqkNEyOJnVogCl1QW7
qB84Flg4kA5aIKxV+p/qYkbONqbkH6rtPOMuZT6JZqDVGiS1vyESS4F04l+tIX8=
=bDDv
-----END PGP SIGNATURE-----

--LDSEAf2aeMeR1sENPQSUeITTCFd6i2mpw--
