Received: from eggs.gnu.org ([209.51.188.92]:44978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzFhu-00086I-Oo
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzFhr-0000dj-4T
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:02:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzFhq-0000cc-QM
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:02:11 -0500
References: <20190228043503.68494-1-aik@ozlabs.ru>
	<20190228050007.GF27799@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <365a4f56-5f68-9f33-72c2-9d0dc2c7f3c6@redhat.com>
Date: Thu, 28 Feb 2019 08:01:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190228050007.GF27799@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="NHAmHPFfhHSzPk9zxFurB0X6sGGEFl6TT"
Subject: Re: [Qemu-devel] [PATCH qemu] configure: Enable werror for git
 worktrees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com, philmd@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NHAmHPFfhHSzPk9zxFurB0X6sGGEFl6TT
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28/02/2019 06.00, David Gibson wrote:
> On Thu, Feb 28, 2019 at 03:35:03PM +1100, Alexey Kardashevskiy wrote:
>> The configure script checks multiple times whether it works in a git
>> repository and it does this by "test -e "${source_path}/.git" in 4 cas=
es
>> but in one case where it tries to enable werror "-d" is used there whi=
ch
>> fails on git worktrees as .git is a file then and not a directory.

That confused me. What is a "git worktree" where .git is a file? So far
=2Egit was always a directory here...?

 Thomas


>> This changes the test to "-e" as other occurrences.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> CCing a few likely candidates based on get_maintainer -f
>=20
>> ---
>>  configure | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 05d72f1..f481ff9 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1835,7 +1835,7 @@ fi
>>  # Consult white-list to determine whether to enable werror
>>  # by default.  Only enable by default for git builds
>>  if test -z "$werror" ; then
>> -    if test -d "$source_path/.git" && \
>> +    if test -e "$source_path/.git" && \
>>          { test "$linux" =3D "yes" || test "$mingw32" =3D "yes"; }; th=
en
>>          werror=3D"yes"
>>      else
>=20



--NHAmHPFfhHSzPk9zxFurB0X6sGGEFl6TT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcd4doAAoJEC7Z13T+cC21Rc4QAKUS7k3hHb14TlScNjBeEUOC
dpsi8k/aItS6TEzpy0zzGpZeY44h16GB1AnD9KVKmZBmOTHfzGppUZSJ74QFF1vw
ITinMD/gg+X6ay51EwPsgQmr9rgpUWuVT7Z08sTk6w0uvgRblehTc+O2VvSKhdA9
bPxczxxcXhipH8j3ncKM11Si8e8OZEtfMJ/PALaIiD+F+dSD8S2WBgUVPdhUaXfy
wd1UGcnK0flp2Nz49+lqQ0OnMOPMd74g4q1VQd79XZXB3HncvYmzfYKt6+VEuT25
StMpxy2sWd8QjuJ2ZB2+YoBNW6hVItnSJ/VejTndUc8pmcH+MaHL/SRLEyk+qg7G
bk/qjpMoZJQzmsheFEhEv4SWIhSHNykkGWZzpwg9ECxs9cwkEovMdYUir83VVNSz
rnirViHlutirAqBjMfxspdZURBUAtREBw/I+foy+1/88mBM8ZSNr1LdhlFibSbiz
bTSCdna30nlRzwtYNRC0sIx316r2BgWEeZQ8pWCyYfZ7rrRh8gFF9u45xaSoAR19
uXYjC1cNGD5vXM97/GJqV5ctyZb32eVpoI71j20COQIavdHC7L69f0pCP3IXN9hk
RmvZscQuCPa6zseh6mIHZy6OVb8xqad3n9j6fRfzFUNHwsCfNrRkxC/HjkhUdo3M
qoir8P4HmbEb8q9MZWax
=yszj
-----END PGP SIGNATURE-----

--NHAmHPFfhHSzPk9zxFurB0X6sGGEFl6TT--
