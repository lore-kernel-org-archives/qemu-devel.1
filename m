Received: from eggs.gnu.org ([209.51.188.92]:42371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLpPl-00067a-Dd
	for qemu-devel@nongnu.org; Wed, 01 May 2019 09:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLpPi-0003ez-8w
	for qemu-devel@nongnu.org; Wed, 01 May 2019 09:36:49 -0400
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-3-thuth@redhat.com>
	<877eba77ps.fsf@zen.linaroharston>
	<3205a43e-20f3-b152-2f8c-a450dd8e7cdc@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <733e7c9b-fc1a-b2f3-89b0-084424f7e56b@redhat.com>
Date: Wed, 1 May 2019 15:36:21 +0200
MIME-Version: 1.0
In-Reply-To: <3205a43e-20f3-b152-2f8c-a450dd8e7cdc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="0EnEvVOShwj0KiD4K0ofBcvkzvPZTNZRL"
Subject: Re: [Qemu-devel] [PATCH v2 2/8] tests/qemu-iotests/005: Add a
 sanity check for large sparse file support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0EnEvVOShwj0KiD4K0ofBcvkzvPZTNZRL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01/05/2019 14.06, Eric Blake wrote:
> On 5/1/19 6:08 AM, Alex Benn=C3=A9e wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> "check -raw 005" fails when running on ext4 filesystems - these do no=
t
>>> support such large sparse files. Use the same check as in test 220 to=

>>> skip the test in this case.
>>>
>>> Suggested-by: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  tests/qemu-iotests/005 | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
>>> index 2fef63af88..6136ced5c8 100755
>>> --- a/tests/qemu-iotests/005
>>> +++ b/tests/qemu-iotests/005
>>> @@ -55,6 +55,15 @@ if [ "$IMGPROTO" =3D "sheepdog" ]; then
>>>      _notrun "image protocol $IMGPROTO does not support large image s=
izes"
>>>  fi
>>>
>>> +# Sanity check: For raw, we require a file system that permits the c=
reation
>>> +# of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.
>>
>> Is this comment correct? Running on my ext4 home partition this test
>> seems to be running fine and not skipping. Indeed:
>=20
>>> +if [ "$IMGFMT" =3D "raw" ]; then
>>> +    if ! truncate --size=3D5T "$TEST_IMG"; then
>=20
> 5T fits on ext4 but not ext3.

It fails for me on my ext4 partition. Anyway, I'll change the comment.

 Thomas


--0EnEvVOShwj0KiD4K0ofBcvkzvPZTNZRL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcyaDaAAoJEC7Z13T+cC216V4P/iTblcQBu/eJww3rw4zdlckX
gZ7GH31BIqMzHPCcJnt5twBpU2Hv668Gn2It1NNcUXW32wcAJwEjC6BAsTxwif+Y
b+n9UdPKQiNB+QREiIoUTAR8ex4CKqpV9SII0fnBqvOkRrD+CLc3wZXHiG6GhnX9
wvnh5KrUpkL4kEPV++62D7L22t7foMTupk1zYvqVDTn37AnrIdH5ZaY4q6TkFXs5
yaMJ8J8v27zP7Rd8VIpJySFcUnpx4+DcUeKWzhSkeeD3i35VGKRvNsHLlZpJF3QM
FUvT2nAeFiZrJIFa/lVpyrAoNz1U2WX3ZgGO/poHJbfIBfSaEcxf7AApc903A34w
opvtSJTAGNoMRZPXiOaLMfTniB/gbWghlTnVAy18djSwOxcGaD80yX8pTLzC9GW/
xq628+j9zzZA4BUDkZgTwy5/eJ8gV/orrLMaXwnupSt//85CpN7BX3Sg8kmY0sGt
zc6DmP5aIDsI4RTzMJdFESW2ueSp5Hwor9bgbdnl2TIxLwisSAjGdMY5UiQuuDfn
deu7z8aOlK52fseeustGFZluCqnJC5ZzET+8wuFAAfmEC3xQso9L34uAa7qyDwWJ
JFaYRtR12qMA/5Do0Q45K5tQFwmjhVShjl85iSffzbngTVBA6MYzKC4KNA9D03Qo
/L+chBfqAhj+ZguG2e+D
=Ca84
-----END PGP SIGNATURE-----

--0EnEvVOShwj0KiD4K0ofBcvkzvPZTNZRL--
