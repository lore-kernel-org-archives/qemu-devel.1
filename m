Received: from eggs.gnu.org ([2001:4830:134:3::10]:43881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEbdp-0007wu-LB
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEbdo-0003JQ-Nb
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:52:41 -0500
References: <20171103144113.7188-1-berrange@redhat.com>
	<9b0c5170-c97a-51d5-b1e4-003f1628d7be@redhat.com>
	<20171110172253.GH30685@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fa4f8209-37ec-f8e9-eaf1-ac48453c1bff@redhat.com>
Date: Tue, 14 Nov 2017 14:52:27 +0100
MIME-Version: 1.0
In-Reply-To: <20171110172253.GH30685@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ILJ7mD17WauXb3lBt9n9KsETHdlxB0Lqv"
Subject: Re: [Qemu-devel] [PATCH] qcow2: fix image corruption after
 committing qcow2 image into base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ILJ7mD17WauXb3lBt9n9KsETHdlxB0Lqv
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <fa4f8209-37ec-f8e9-eaf1-ac48453c1bff@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: fix image corruption after committing
 qcow2 image into base
References: <20171103144113.7188-1-berrange@redhat.com>
 <9b0c5170-c97a-51d5-b1e4-003f1628d7be@redhat.com>
 <20171110172253.GH30685@redhat.com>
In-Reply-To: <20171110172253.GH30685@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 18:22, Daniel P. Berrange wrote:
> On Fri, Nov 10, 2017 at 10:34:59AM -0600, Eric Blake wrote:
>> On 11/03/2017 09:41 AM, Daniel P. Berrange wrote:
>>> After committing the qcow2 image contents into the base image, qemu-i=
mg
>>> will call bdrv_make_empty to drop the payload in the layered image.
>>>
>>> When this is done for qcow2 images, it blows away the LUKS encryption=

>>> header, making the resulting image unusable. There are two codepaths
>>> for emptying a qcow2 image, and the second (slower) codepaths leaves
>>> the LUKS header intact, so force use of that codepath.
>>>
>>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>>> ---
>>>
>>> NB, ideally we would fix the faster codepath in make_completely_empty=
, but
>>> having looked at the code, I've really no idea how to even start on f=
ixing that
>>> to not kill the LUKS header clusters.
>>
>> Hmm - I wonder if persistent bitmaps are also corrupted in the fast pa=
th.
>=20
> I also wonder if there's anything better we can do to make us safer by
> default, so we default to the slow & safe path, unless we can provide
> we *only* have the subset of features that are safe for the fast path ?=


I have wondered the same but I can't think of any.  The only thing that
comes close would be to check for which header extensions there are; but
at the same time, we could just add a comment to qcow2_read_extensions()
("If you add a new feature to qcow2, note that you may want to adjust
the qcow2_make_empty() fastpath conditions").

Max


--ILJ7mD17WauXb3lBt9n9KsETHdlxB0Lqv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloK9RsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Alk0H/Alekyyz5jHicBe4fqRYjQlDTwG+BV7m
B+KJgKsVojf9neh/9ZIhM6o4TkTBKa8qIvX6Vauyj2uOtwvjnNLxagEIlWnDcjdv
WbfzYUNd/ziPGjbiO2YLRy7X1UbI2zzhqCIy5YSBzT/CfLSs5JghyOmvTlD/r+BT
PVFUbnSNJNNL/4BS7tRi+5xcv4YSULO/GRzisiDSR0NLOgMjOFJKQU5Lp+G3+rPo
aOS3AGhyhLUNGLK/4nBn8HAVcVqbGjKJhucjaWSdXjpAG1Tl/QWdW1MKujXMNQO4
vZLfZy+sw2eZDVRtmKtTDE4RsjTXfA6jXqvxME31hJAu7W3rD8xMnaM=
=3Aj5
-----END PGP SIGNATURE-----

--ILJ7mD17WauXb3lBt9n9KsETHdlxB0Lqv--
