Received: from eggs.gnu.org ([2001:4830:134:3::10]:35323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyF4b-0006Sn-EU
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyF4a-0002g6-Di
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:37:13 -0400
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-32-mreitz@redhat.com>
	<w51wos0rol5.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0c53e71a-fbba-14b8-0789-dad6599c1933@redhat.com>
Date: Fri, 7 Sep 2018 13:37:03 +0200
MIME-Version: 1.0
In-Reply-To: <w51wos0rol5.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DK12BxabGrNYic73FBZnrsjZOU103wSqX"
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 31/31] iotests: Test json:{}
 filenames of internal BDSs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DK12BxabGrNYic73FBZnrsjZOU103wSqX
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <0c53e71a-fbba-14b8-0789-dad6599c1933@redhat.com>
Subject: Re: [PATCH for-3.1 v10 31/31] iotests: Test json:{} filenames of
 internal BDSs
References: <20180809213528.14738-1-mreitz@redhat.com>
 <20180809213528.14738-32-mreitz@redhat.com>
 <w51wos0rol5.fsf@maestria.local.igalia.com>
In-Reply-To: <w51wos0rol5.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-05 16:44, Alberto Garcia wrote:
> On Thu 09 Aug 2018 11:35:28 PM CEST, Max Reitz wrote:
>> +        vm.shutdown()
>> +
>> +        #assert top_name[:5] =3D=3D 'json:'
>> +        #top_options =3D json.loads(top_name[5:])
>> +
>> +        #if filter_node_name:
>> +        #    # This should be present and set
>> +        #    assert top_options['backing']['driver'] =3D=3D 'commit_t=
op'
>> +        #    # And the mid image is commit_top's backing image
>> +        #    mid_options =3D top_options['backing']['backing']
>> +        #else:
>> +        #    # The mid image should appear as the immediate backing B=
DS
>> +        #    # of top
>> +        #    mid_options =3D top_options['backing']
>> +
>> +        #assert mid_options['driver'] =3D=3D iotests.imgfmt
>> +        #assert mid_options['file']['filename'] =3D=3D mid_img_path
>=20
> What's with all these commented lines? I don't see how you are checking=

> the filename in this test, it's also not in the output file.

Indeed, what is with them?  I have no idea.  They shouldn't be commented
out.  Sorry.

Max


--DK12BxabGrNYic73FBZnrsjZOU103wSqX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluSYt8ACgkQ9AfbAGHV
z0B26Qf/SVM4JVbyd/F0geevCpQfdSv1MHA9ZHpRSxJPYnp/TPcpm+X6+ETLo9hK
taWHtTFQys7HR9K6x1GX86Eb+B6/7kRLmldkA3/G6z92062vabWRgLOX9RA2GmcM
/AX3X/SEkMJICFpW7H/xeuB2Hq5hln8hegqGlYcQS3ipj1ZW+Cqkeog57eo5DPUc
XqDPUZldbNzc+HMRBeC1tE9usFGCCzSbRnoFUtoAZaVYwRXKG1n80ROMBN2Mc3rZ
EivmSRQo4s+3CS6GbglcrkUad8UcivkcdtH0TNIDzSAWZquUVSVxk6nEUrfjlloR
xzLvVEz0urMWWTNkGHZrSnr+PTuNug==
=3g+E
-----END PGP SIGNATURE-----

--DK12BxabGrNYic73FBZnrsjZOU103wSqX--
