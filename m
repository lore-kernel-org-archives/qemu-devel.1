Received: from eggs.gnu.org ([2001:4830:134:3::10]:54139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnpzb-00014C-Pa
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnpza-0000lF-Rf
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:12:15 -0400
References: <20170314161205.19415-1-famz@redhat.com>
	<66715588-a25e-3028-d008-8fd285edb755@redhat.com>
	<20170314162804.GO3952@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5b82e5c8-1779-a1b7-d5f2-a9e90b99589a@redhat.com>
Date: Tue, 14 Mar 2017 12:12:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170314162804.GO3952@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="80OgRliDa6p5SoBkfOGL3PedMW66QMvMN"
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: Don't leak fd in
 hdev_get_max_segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--80OgRliDa6p5SoBkfOGL3PedMW66QMvMN
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <5b82e5c8-1779-a1b7-d5f2-a9e90b99589a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: Don't leak fd in
 hdev_get_max_segments
References: <20170314161205.19415-1-famz@redhat.com>
 <66715588-a25e-3028-d008-8fd285edb755@redhat.com>
 <20170314162804.GO3952@noname.str.redhat.com>
In-Reply-To: <20170314162804.GO3952@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 11:28 AM, Kevin Wolf wrote:
> Am 14.03.2017 um 17:20 hat Eric Blake geschrieben:
>> On 03/14/2017 11:12 AM, Fam Zheng wrote:
>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>> ---
>>>  block/file-posix.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>> index c4c0663..d670be3 100644
>>> --- a/block/file-posix.c
>>> +++ b/block/file-posix.c
>>> @@ -703,6 +703,9 @@ static int hdev_get_max_segments(const struct sta=
t *st)
>>>      }
>>> =20
>>>  out:
>>> +    if (fd !=3D -1) {
>>> +        close(fd);
>>> +    }
>>
>> Mails crossed - I see I asked about this in reply to v1 after you
>> already sent v2 minutes earlier.
>>
>> I still think it might be nice to mention a commit id that you are
>> fixing (one of my reply-to-self on your v1), but either way,
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> I added a sentence to the commit message: "This fixes a leaked fd
> introduced in commit 9103f1ce." Sounds good?

Works for me!

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--80OgRliDa6p5SoBkfOGL3PedMW66QMvMN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyCRlAAoJEKeha0olJ0NqpjsH/3BnzaHR3OnSzuSZLyOclgbj
Orp5Po6jSJXmVmfK+AkesBwjMF2KolyLd5/RMsp80UfpNpgEuiCuEiUegEFZqVXi
ss06YzTF4iYHHyU+UT3qWfpzOT21Npnx3chHMwKhKCL6mbbywj1+kg/Oy8iQIw4W
BbI0jM82OtKjYjIrAysCKY2obAQ+eg5TQ6pwkIURhyMKY2HFtX+RkIB3KDUOGwn3
cfgyuhgGCQiVL0co/xoHneiiNl4Fb75Bx/faqgjMzcSQXDquW+wSX8Jpkwd6kZzy
LWEzowCMUMC/CnoRctaoJJ9D3MCjq2fCgmhbGg3J2R8/FbxYsSM1avu53JQ7oWg=
=r4Xz
-----END PGP SIGNATURE-----

--80OgRliDa6p5SoBkfOGL3PedMW66QMvMN--
