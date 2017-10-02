Received: from eggs.gnu.org ([2001:4830:134:3::10]:38144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz1CT-0001Lf-DI
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz1CS-0000My-Af
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:56:01 -0400
References: <20170930195345.23338-1-eblake@redhat.com>
	<20170930201121.24157-1-eblake@redhat.com>
	<20171001030357.GF4313@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <834de435-020b-9400-b640-af82968433dd@redhat.com>
Date: Mon, 2 Oct 2017 08:55:50 -0500
MIME-Version: 1.0
In-Reply-To: <20171001030357.GF4313@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BqdrhDq2pghpRD11TCsAPGGf6VRt0kEdO"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/4] iotests: Add test 197 for
 covering copy-on-read
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BqdrhDq2pghpRD11TCsAPGGf6VRt0kEdO
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <834de435-020b-9400-b640-af82968433dd@redhat.com>
Subject: Re: [Qemu-block] [PATCH 4/4] iotests: Add test 197 for covering
 copy-on-read
References: <20170930195345.23338-1-eblake@redhat.com>
 <20170930201121.24157-1-eblake@redhat.com>
 <20171001030357.GF4313@localhost.localdomain>
In-Reply-To: <20171001030357.GF4313@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/30/2017 10:03 PM, Jeff Cody wrote:
> On Sat, Sep 30, 2017 at 03:11:21PM -0500, Eric Blake wrote:
>> Add a test for qcow2 copy-on-read behavior, including exposure
>> for the just-fixed bugs.
>>
>> The copy-on-read behavior is always to a qcow2 image, but the
>> test is careful to allow running with most image protocol/format
>> combos as the backing file being copied from (luks being the
>> exception, as it is harder to pass the right secret to all the
>> right places).  In fact, for './check nbd', this appears to be
>> the first time we've had a qcow2 image wrapping NBD, requiring
>> an additional line in _filter_img_create to match the similar
>> line in _filter_img_info.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> +_cleanup()
>> +{
>> +    _cleanup_test_img
>> +    rm -f "$BLKDBG_CONF"
>> +}
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>=20
>=20
> Note to myself to add this to my iotests series.

Yep, and I even thought about that, since I've been pointing it out on
other patches, but forgot to mention it when composing the email ;)


>> +$QEMU_IO -c "open -C \
>> + -o driver=3Dblkdebug,config=3D$BLKDBG_CONF,image.driver=3Dqcow2 $TES=
T_WRAP" \
>=20
> Hmm, this will lead to issues if $TEST_WRAP has spaces, right?

Probably :(  Although I didn't actually test that setup

But I don't know what other options we have to work around it. As long
as we are executing in the correct directory, I guess we can open both
BLKDBG_CONF and TEST_WRAP relative to ./ rather than as an absolute
path, and that should be sufficient to avoid spaces.  But I don't know
how easy that is to achieve, or if _filter_qemu_io will handle it correct=
ly.

Maybe I take the wimpy way out and skip the test if $PWD contains spaces
or other problematic characters?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BqdrhDq2pghpRD11TCsAPGGf6VRt0kEdO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSRWYACgkQp6FrSiUn
Q2pgywgAjn3xQraiG9RFdr6DEmxgcae2pMUitbm09K7FuurEulAcjxAaazGEelfw
0cQZ47rTz7Iye214jYISZZ/fRfqUiLpB4VBGZgpgQxQinu2Rd+sXTDBal3hwegzG
SqFp6DPAo5joMFPTT8lvTh7+uGwDPPkQWA7o2bezlbTefeuXYOYiw3wOBkYYR/MN
Fs7whNhAbvYqFihpC5D98RmViX/UkJHIO0X6bTwvcwG77eRotxCKtrZU8rGq1lDK
RenRogVpkaX5Qv0SkNUt2OZS5jz4lqVFyEra8WTA+yFxSWot4hc1tCICNQZ6X1PL
WBj3hmxx9Z0XxWw/8NQySPqYIcuNUA==
=y7qA
-----END PGP SIGNATURE-----

--BqdrhDq2pghpRD11TCsAPGGf6VRt0kEdO--
