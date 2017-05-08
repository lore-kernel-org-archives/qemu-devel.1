Received: from eggs.gnu.org ([2001:4830:134:3::10]:47812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7nzw-0001ha-Q5
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7nzv-0007xk-MQ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:07:08 -0400
References: <20170508171302.17805-1-eblake@redhat.com>
	<4d045f6a-15ce-7659-94d2-fb573fa621b1@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9c93461-8829-3270-5527-3f93fad32a62@redhat.com>
Date: Mon, 8 May 2017 14:06:59 -0500
MIME-Version: 1.0
In-Reply-To: <4d045f6a-15ce-7659-94d2-fb573fa621b1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ocIpDXbvqADJxUaFlC7rCLBXLSdTQaotk"
Subject: Re: [Qemu-devel] [PATCH] block: Tweak error message related to
 qemu-img convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ocIpDXbvqADJxUaFlC7rCLBXLSdTQaotk
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <a9c93461-8829-3270-5527-3f93fad32a62@redhat.com>
Subject: Re: [PATCH] block: Tweak error message related to qemu-img convert
References: <20170508171302.17805-1-eblake@redhat.com>
 <4d045f6a-15ce-7659-94d2-fb573fa621b1@redhat.com>
In-Reply-To: <4d045f6a-15ce-7659-94d2-fb573fa621b1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 01:41 PM, Max Reitz wrote:
> On 08.05.2017 19:13, Eric Blake wrote:
>> When converting a 1.1 image down to 0.10, qemu-iotests 060 forces
>> a contrived failure where allocating a cluster used to replace a
>> zero cluster reads unaligned data.  Since it is a zero cluster
>> rather than a data cluster being converted, changing the error
>> message to match our earlier change in 'qcow2: Make distinction
>> bewteen zero cluster types obvious' is worthwhile.
>>
>> Suggested-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> There's one more instance of "Data cluster offset" in qcow2-cluster.c,=

>> but that one in handle_copied() is contained inside a
>> cluster_type =3D=3D QCOW2_CLUSTER_NORMAL conditional.
>>
>>  block/qcow2-cluster.c      | 3 ++-
>>  tests/qemu-iotests/060.out | 2 +-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> Looks good, except for one thing: This is for qemu-img amend, not
> qemu-img convert.
>=20
> I can handle that, if you'd like, though. :-)

So is fixing my commit message considered a conversion, or an amendment?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ocIpDXbvqADJxUaFlC7rCLBXLSdTQaotk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEMHTAAoJEKeha0olJ0NqpB4H/0KCQQusPvWnjG6BYVfuoodY
1FSyIlBkWJ0Ry3F6UXkERc6btTSoYRlg31TfpwPGoAp+v+etv73cAQnX3hlcmMLt
6s/d0PGAFVmIJr0XNUNDEZqoFmgt9Xm+1teAHdCeI02ekq+UPanjFsKrYvxBWHKp
6Jn7rzM2aMajvPM7KOhyyntLfHfPsWF6RLzA3zue9xodsmsvBDxST20vh2louMOt
PUSmXcpCG8wjScdRJNYkdd/vbQzOK9OqqQjj0oO6qNphmnunBh3DKpYAi7552cYo
GrJkB0l0ioBwgBIeYE2pTbSLoEksDECITlgUt81dyua1rtDAAaSRdrAANuAy1Dk=
=ASSR
-----END PGP SIGNATURE-----

--ocIpDXbvqADJxUaFlC7rCLBXLSdTQaotk--
