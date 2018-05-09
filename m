Received: from eggs.gnu.org ([2001:4830:134:3::10]:49925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGTMp-0000gD-Aj
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGTMo-0000ZB-Dn
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:59:07 -0400
References: <20180509154949.8206-1-mreitz@redhat.com>
	<20180509154949.8206-3-mreitz@redhat.com>
	<f9bbaffe-2543-929f-7ee2-c41704046416@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fbecd9ca-742e-44b2-7378-c396d6c1fcd1@redhat.com>
Date: Wed, 9 May 2018 19:58:56 +0200
MIME-Version: 1.0
In-Reply-To: <f9bbaffe-2543-929f-7ee2-c41704046416@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EVqmvrXGhAMhHMnU3Sz6hMp6FRPi2S8m2"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] iotests: Add test for
 rebasing with relative paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EVqmvrXGhAMhHMnU3Sz6hMp6FRPi2S8m2
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <fbecd9ca-742e-44b2-7378-c396d6c1fcd1@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PATCH 2/2] iotests: Add test for
 rebasing with relative paths
References: <20180509154949.8206-1-mreitz@redhat.com>
 <20180509154949.8206-3-mreitz@redhat.com>
 <f9bbaffe-2543-929f-7ee2-c41704046416@redhat.com>
In-Reply-To: <f9bbaffe-2543-929f-7ee2-c41704046416@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 19:24, Eric Blake wrote:
> On 05/09/2018 10:49 AM, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/024=C2=A0=C2=A0=C2=A0=C2=A0 | 82
>> ++++++++++++++++++++++++++++++++++++++++++++--
>> =C2=A0 tests/qemu-iotests/024.out | 30 +++++++++++++++++
>> =C2=A0 2 files changed, 109 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
>> index e0d77ce2f5..4071ed6093 100755
>> --- a/tests/qemu-iotests/024
>> +++ b/tests/qemu-iotests/024
>> @@ -29,9 +29,14 @@ status=3D1=C2=A0=C2=A0=C2=A0 # failure is the defau=
lt!
>> =C2=A0 =C2=A0 _cleanup()
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 _cleanup_test_img
>> -=C2=A0=C2=A0=C2=A0 rm -f "$TEST_DIR/t.$IMGFMT.base_old"
>> -=C2=A0=C2=A0=C2=A0 rm -f "$TEST_DIR/t.$IMGFMT.base_new"
>> +=C2=A0=C2=A0=C2=A0 _cleanup_test_img
>> +=C2=A0=C2=A0=C2=A0 rm -f "$TEST_DIR/t.$IMGFMT.base_old"
>> +=C2=A0=C2=A0=C2=A0 rm -f "$TEST_DIR/t.$IMGFMT.base_new"
>> +
>> +=C2=A0=C2=A0=C2=A0 rm -f "$TEST_DIR/subdir/t.$IMGFMT"
>> +=C2=A0=C2=A0=C2=A0 rm -f "$TEST_DIR/subdir/t.$IMGFMT.base_old"
>> +=C2=A0=C2=A0=C2=A0 rm -f "$TEST_DIR/subdir/t.$IMGFMT.base_new"
>> +=C2=A0=C2=A0=C2=A0 rmdir "$TEST_DIR/subdir" 2> /dev/null
>=20
> Any easier to just 'rm -rf "$TEST_DIR/subdir"' instead of calling out
> individual files?

Sure it would be easier, but I decided against it on the basis that I
personally don=E2=80=99t like to call rm -rf on cleanup.

(Because if I mess something up, I might hurt somebody really bad, and
that somebody might be myself.)

> And was Jeff ever going to finish the iotests
> cleanups that took care of cleanup globally by running tests in a
> per-test directory in preparation for running tests in parallel?

If that was a question to me, I=E2=80=99m afraid I don=E2=80=99t know the=
 status of that...

Max

> Reviewed-by: Eric Blake <eblake@redhat.com>



--EVqmvrXGhAMhHMnU3Sz6hMp6FRPi2S8m2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrzNuAACgkQ9AfbAGHV
z0ALjwgAtY8qrK6po8W20f7XL6XewvaKXsu3XoFukif1sSjFivyvWaEpS4RUatTw
/vE1v7/WO1PM200itgh/QLK8/2SRQ57ryI3i9tOWXsLsQiW3v0lKR4bz/bLaW3ar
pWWsUqqy21IpOQm8zVNJ6I+R3Hp1jMV3S1EaVjgmcm8cPUHfpFHSg4folXp+4DTQ
bT2HLrcZBG9TsLn32WPXnAD00lupaJPTisbM3zHnHg2fYU/biNuXIVaaiS9eBf1h
hAr/fx3sNumWvOj/0/yqLM0fAVhkbm8+AF4mPIm9l4gqrjubm/mZSktQoCg1kjNz
m+43fUsY1diiuK2JPUaXb7O3akILcg==
=9AOv
-----END PGP SIGNATURE-----

--EVqmvrXGhAMhHMnU3Sz6hMp6FRPi2S8m2--
