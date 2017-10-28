Received: from eggs.gnu.org ([2001:4830:134:3::10]:59166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e8Kk6-0005U4-38
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e8Kk1-0000G6-WA
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:37:14 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:47660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e8Kk1-0000Dg-O5
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:37:09 -0400
Received: by mail-io0-x241.google.com with SMTP id h70so17049646ioi.4
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 23:37:08 -0700 (PDT)
References: <20171027131412.18830-1-berrange@redhat.com>
	<20171027131412.18830-3-berrange@redhat.com>
	<c287efce-4926-32dd-b591-e02ad5edf8fc@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <7e123f2a-4248-72e6-8194-1458cfd8ef60@ozlabs.ru>
Date: Sat, 28 Oct 2017 17:37:01 +1100
MIME-Version: 1.0
In-Reply-To: <c287efce-4926-32dd-b591-e02ad5edf8fc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pceOeNIP1h0r43VC8VLnmQJura9JGef8w"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] build: don't create temporary files
 in source dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pceOeNIP1h0r43VC8VLnmQJura9JGef8w
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7e123f2a-4248-72e6-8194-1458cfd8ef60@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] build: don't create temporary files
 in source dir
References: <20171027131412.18830-1-berrange@redhat.com>
 <20171027131412.18830-3-berrange@redhat.com>
 <c287efce-4926-32dd-b591-e02ad5edf8fc@redhat.com>
In-Reply-To: <c287efce-4926-32dd-b591-e02ad5edf8fc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/10/17 16:25, Eric Blake wrote:
> On 10/27/2017 03:14 PM, Daniel P. Berrange wrote:
>> There are cases where users do VPATH builds with the source directory =
being on
>> a read-only volume. In such a case they have to manually run the comma=
nd
>> 'git-submodule.sh ...modules...'  manually ahead of time. When checkin=
g for
>=20
> One of the two "manually" can be removed (either one, and the sentence
> still makes sense)
>=20
>> status we should not then write into the source dir.
>>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>  scripts/git-submodule.sh | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
>> index c66567d409..586ff32293 100755
>> --- a/scripts/git-submodule.sh
>> +++ b/scripts/git-submodule.sh
>> @@ -31,10 +31,10 @@ fi
>>  case "$command" in
>>  status)
>>      test -f "$substat" || exit 1
>> -    trap "rm -f ${substat}.tmp" EXIT
>> -    $GIT submodule status $modules > "${substat}.tmp"
>> -    test $? -ne 0 && error "failed to query git submodule status"
>> -    diff "${substat}" "${substat}.tmp" >/dev/null
>> +    substat_tmp=3D$(mktemp)
>=20
> Is mktemp portable enough?  Hopefully so.

It could also be some fixed file name in the build directory.


--=20
Alexey


--pceOeNIP1h0r43VC8VLnmQJura9JGef8w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAln0JY0OHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILmdxQ/+O17dXO0jOJ/n7zSGn6FsjiQ/dlvFpMbxN4N1
ulGvme0CCh1nPVPYODbbXZzD4JZLwLU+TRvQjIJ0WwlWtve2Adlnd5FFP1tzNAdC
tBKNf/aIvvBwFNpNZJ8duJzkWfh9t0pCegWY4jYTOmsxzhU073UEqswtWak7+Wx3
2mUZSrLQQjDucQpRtoF2GW0gQ5f4U/uhkrkLnswxDSBOG9aZ6fMRf8r+18wNeO51
mkNXDTto0swrd4Y+JIS4vpKfP7sEd7RBlsriKEypUbVoM/lAIs1UMex1zVWpduXK
LPjwnWYbg5rReycE53RKThHgPGtVafeljBbNVzIHxQChUAt2dP8EAomG8AXskR7X
8vgQZrCz3MpOPQzumE+Hvb+oYbthXfrNJhH1XV+XFN24MuFFh9Hil3OHdBhkaJwh
ui9CrWYReXkyW+1dCOfIS8LWEpB8XnjWP6YzXAVkU7L/lLJrNi8zZzZAybFeKZ8R
nMlhRqtQRBqyDAwaOQlDvltgE1lBKMDVuzS0zn04BK/8fJrN+7cXR4SQiTRsp7N4
1derMC02HWsQSXf1rxrUBIJN5OXZjiEXjccpmOcNjcJkDI8+hO7u1VENT/bL7+nX
rCA+fLNfEZ6FMm5gt7YOMYyJF1RA7cfwq/w3NSdm1sDKZb3PRN3s8kqXBssWA9IM
trlLBUA=
=Kho9
-----END PGP SIGNATURE-----

--pceOeNIP1h0r43VC8VLnmQJura9JGef8w--
