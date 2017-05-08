Received: from eggs.gnu.org ([2001:4830:134:3::10]:55792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7kqr-0005e5-PG
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7kqq-0002IE-Ue
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:45:33 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20170507000552.20847-1-eblake@redhat.com>
	<20170507000552.20847-6-eblake@redhat.com>
	<54dddadc-42a3-0256-09ee-03e8d4d5d0bc@redhat.com>
Message-ID: <537ffb45-1126-e4cf-7b74-35865f7a8387@redhat.com>
Date: Mon, 8 May 2017 17:45:24 +0200
MIME-Version: 1.0
In-Reply-To: <54dddadc-42a3-0256-09ee-03e8d4d5d0bc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="he51x7VdLAd243qLVKW5fJVGBbri91rkm"
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--he51x7VdLAd243qLVKW5fJVGBbri91rkm
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <537ffb45-1126-e4cf-7b74-35865f7a8387@redhat.com>
Subject: Re: [PATCH v13 05/12] qcow2: Name typedef for cluster type
References: <20170507000552.20847-1-eblake@redhat.com>
 <20170507000552.20847-6-eblake@redhat.com>
 <54dddadc-42a3-0256-09ee-03e8d4d5d0bc@redhat.com>
In-Reply-To: <54dddadc-42a3-0256-09ee-03e8d4d5d0bc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.2017 17:43, Max Reitz wrote:
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

I see you're doing this in the next patch... Well, that's not really
where it belongs, though.

> Although it's quite a functional change, I would be willing to change
> both when applying, if you allowed me to.

I guess I'm extending my offer to handle the rebase fallout of the next
patch, too...?

Max

> (Once again, "no good deed shall go unpunished", as Markus likes to say=
 :-))
>=20
> Max
>=20



--he51x7VdLAd243qLVKW5fJVGBbri91rkm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkQkpQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKLIH/RAI13fyqk4nvzy4/Dv6Sx+HsObPdp5Z
QwWrBe83wf6ZPfWMlmUbM98pjwqFQnZM+cXAbMBH7m83y4NJ6ai14GCt25VeRVMP
AxGvfsccnui3POTWJx9kAoEhWB2JGEakS7v66awK9v/Br4bVd3SjXw6MRCVtdHMb
/FIh1SPYD5+3OhvPXIe1/gFs6Xt0nhhpSnHW11jOTHXx2d6ih42ZrQ5arWPOSHag
tEWPG5gx15dtEFlJLMGh10B816NTEp8FaXd/qLGRyDi+buQQvDy8YPN9qw2owmyG
1cUX2pa+yofIacvNlZzG8UuZGtYNj5phh83DH4dn+A/vCD7x/ob7494=
=xgrk
-----END PGP SIGNATURE-----

--he51x7VdLAd243qLVKW5fJVGBbri91rkm--
