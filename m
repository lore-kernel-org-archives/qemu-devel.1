Received: from eggs.gnu.org ([2001:4830:134:3::10]:35133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnp60-0000hN-BW
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnp5z-0004pV-3O
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:14:48 -0400
References: <20170314154315.17869-1-famz@redhat.com>
	<bcb24567-c232-803d-a316-c9f285494583@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e2b629be-1d0f-5fda-54a9-b3bce4e21416@redhat.com>
Date: Tue, 14 Mar 2017 11:14:39 -0500
MIME-Version: 1.0
In-Reply-To: <bcb24567-c232-803d-a316-c9f285494583@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C5mUwurIipqsQBCWCK7AoJi8lmvE6tftF"
Subject: Re: [Qemu-devel] [PATCH] file-posix: Don't leak fd in
 hdev_get_max_segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C5mUwurIipqsQBCWCK7AoJi8lmvE6tftF
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <e2b629be-1d0f-5fda-54a9-b3bce4e21416@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: Don't leak fd in
 hdev_get_max_segments
References: <20170314154315.17869-1-famz@redhat.com>
 <bcb24567-c232-803d-a316-c9f285494583@redhat.com>
In-Reply-To: <bcb24567-c232-803d-a316-c9f285494583@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 11:11 AM, Eric Blake wrote:
> On 03/14/2017 10:43 AM, Fam Zheng wrote:
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>  block/file-posix.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index c4c0663..e6170f4 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -703,6 +703,7 @@ static int hdev_get_max_segments(const struct stat=
 *st)
>=20
> hdev_get_max_segments() is not part of master yet; should this just be
> treated as a fixup! to a pending patch?

Scratch that - I forgot to 'git pull' on my end.

Commit message could usefully be improved by mentioning commit 9103f1ce
as the spot the problem was introduced.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--C5mUwurIipqsQBCWCK7AoJi8lmvE6tftF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyBbvAAoJEKeha0olJ0NqsDsH/jl++oI/AF9cXsb1O/QPEAf6
uKpxcp7rVTtYCuJrZ4qvAW/DmZLGBmuS+mhwo+wwbHLtWV3bDTYSan09hHsyrdH/
pWLQgIWiUzsWmPFVe+E4UOqxvweo03lJCN9sz66lc1/AFq8YCdkL+PEsM2k7RilI
EMvI2b6x1SFQ9g+gqoXShGw1j7NPFrwzUJ4rQigsowbTFRJhpwJcjenG0ntsCUd0
HD3lVwmXrqMkGRX2R5MHzvl3ag/1HCJN2zEWhchTaTC6FuIPeZ27DuNiaVvX18/n
tMsYXVi98W/0I3JbN+q2hnRBK5vGrxQZ8HkxvXlPLdypEKSwf0JHOj6qyV2pK34=
=WIja
-----END PGP SIGNATURE-----

--C5mUwurIipqsQBCWCK7AoJi8lmvE6tftF--
