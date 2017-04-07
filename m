Received: from eggs.gnu.org ([2001:4830:134:3::10]:47576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cwUPf-0006nU-5f
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cwUPe-0002AE-Aq
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:58:55 -0400
References: <CAO_EM_=wECMYRRaDyPtY8sKFZF8owp0u2sE4k_oeS=BLF9B2Mw@mail.gmail.com>
	<67b441ce-ee18-c6d5-df5f-224439214ab8@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6838894a-e6ab-1c83-25a1-163c35fd0a38@redhat.com>
Date: Fri, 7 Apr 2017 15:58:37 +0200
MIME-Version: 1.0
In-Reply-To: <67b441ce-ee18-c6d5-df5f-224439214ab8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xgOPU1RKN2H6OFFwdeSrGaC0ULit15GrQ"
Subject: Re: [Qemu-devel] New iotest repros failures on virtio external
 snapshot with iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xgOPU1RKN2H6OFFwdeSrGaC0ULit15GrQ
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>,
 Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <6838894a-e6ab-1c83-25a1-163c35fd0a38@redhat.com>
Subject: Re: [Qemu-devel] New iotest repros failures on virtio external
 snapshot with iothread
References: <CAO_EM_=wECMYRRaDyPtY8sKFZF8owp0u2sE4k_oeS=BLF9B2Mw@mail.gmail.com>
 <67b441ce-ee18-c6d5-df5f-224439214ab8@redhat.com>
In-Reply-To: <67b441ce-ee18-c6d5-df5f-224439214ab8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.03.2017 04:16, Eric Blake wrote:
> On 03/29/2017 09:01 PM, Ed Swierk via Qemu-devel wrote:
>> Parts of qemu's block code have changed a lot in recent months but are=

>> not well exercised by current tests.
>>
>> Subtle bugs have crept in causing assertion failures, hangs and other
>> crashes in a variety of situations: immediately on start, on first
>> guest activity, on external snapshot create or commit, on qmp quit
>> command.
>>
>> Reproducing these bugs has proved tricky, as each may occur only with
>> a specific combination of qemu version, block device type (virtio-blk
>> or virtio-scsi) and iothread enabled or not. In some cases the bug
>> occurs only after several external snapshot operations. And in some
>> cases the bug only manifests when a guest is accessing the block
>> device simultaneously.
>>
>> I've written an iotest (number 176, for now) that attempts to cover
>=20
> At least one other thread has already proposed a test 176.  It's
> somewhat straightforward to renumber things, but I'm wondering if there=

> is some even-more-efficient way of reserving test numbers, perhaps
> through the wiki, since we are finding that test numbers get reserved
> several weeks before actually getting merged into the tree.

As a maintainer, I don't mind collisions; I can and will rename tests.
For all I care, you can even name all of your tests 001.

Max


--xgOPU1RKN2H6OFFwdeSrGaC0ULit15GrQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljnmw0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AeZkH/2RZvA4tlnSgh8n85mCtzHBb0td30X1/
k22KdiJqqTCEBPKIqmuHsgwPxlv7DYwePz6oIK4CJQyL6ljA6mbcYvYZxM8Cn6Er
g+6j2ujcgA5qTX2yB/tjwtUfCnIPbS7QI7ZsJka2or7uWNttbqD7IrWq3Lq+PQK5
JI+vCMetM5N9XgY1clE/QjEQSI8HI49lN23rGfG1v4rtD0E2ANRYyO+QleDKroXd
UKZVZwbMZAW+nn7qO+qthpeWvzSOvgC+QQhG493Cr56t0pzWXfE8nUSqdvGh5k79
Wp5eWxaAPxynrOtTIkoKKoCgY7VN5j4/x8Z5zqnK0Sydqc+NOUH9Kxk=
=o6iV
-----END PGP SIGNATURE-----

--xgOPU1RKN2H6OFFwdeSrGaC0ULit15GrQ--
