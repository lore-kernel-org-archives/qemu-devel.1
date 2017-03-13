Received: from eggs.gnu.org ([2001:4830:134:3::10]:50359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnUkX-0003x6-LH
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnUkT-0005Xz-J7
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:31:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnUkT-0005W9-9q
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:31:13 -0400
References: <20161228145344.30819-1-cov@codeaurora.org>
	<20161228200433.24244-1-cov@codeaurora.org>
	<db6c1fd9-16ac-7670-0fe3-966139864a23@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0b2a787b-9ce8-292c-2de6-fe2f3f945b4a@redhat.com>
Date: Mon, 13 Mar 2017 13:31:10 -0500
MIME-Version: 1.0
In-Reply-To: <db6c1fd9-16ac-7670-0fe3-966139864a23@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P3VbsH3PpGcwL38hQaNPo7gTn1Sd8ABVB"
Subject: Re: [Qemu-devel] [PATCH v3] build: include sys/sysmacros.h for
 major() and minor()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christopher Covington <cov@codeaurora.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Mike Frysinger <vapier@gentoo.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P3VbsH3PpGcwL38hQaNPo7gTn1Sd8ABVB
From: Eric Blake <eblake@redhat.com>
To: Christopher Covington <cov@codeaurora.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Mike Frysinger <vapier@gentoo.org>
Message-ID: <0b2a787b-9ce8-292c-2de6-fe2f3f945b4a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] build: include sys/sysmacros.h for
 major() and minor()
References: <20161228145344.30819-1-cov@codeaurora.org>
 <20161228200433.24244-1-cov@codeaurora.org>
 <db6c1fd9-16ac-7670-0fe3-966139864a23@redhat.com>
In-Reply-To: <db6c1fd9-16ac-7670-0fe3-966139864a23@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/29/2016 08:03 AM, Eric Blake wrote:
> On 12/28/2016 02:04 PM, Christopher Covington wrote:
>=20
> It's best when posting a v3 to do so as a new thread, rather than burie=
d
> in-reply-to an earlier thread, as some maintainers' tools overlook
> deeply-threaded patches.  Probably won't matter too much in this case,
> but it's useful information for future submissions; other tips can be
> found here:
> http://wiki.qemu.org/Contribute/SubmitAPatch
>=20
>=20
>> The definition of the major() and minor() macros are moving within gli=
bc to
>> <sys/sysmacros.h>.
>=20
> Or more precisely, major() and minor() have ALWAYS been in
> <sys/sysmacros.h> under glibc, but are now being removed from
> <sys/types.h>.  But your patch is the correct fix: if <sys/sysmacros.h>=

> exists, include it.
>=20
>> Include this header when it is available to avoid the
>> following sorts of build-stopping messages:
>>
>> qga/commands-posix.c: In function =E2=80=98dev_major_minor=E2=80=99:
>> qga/commands-posix.c:656:13: error: In the GNU C Library, "major" is d=
efined
>>  by <sys/sysmacros.h>. For historical compatibility, it is
=2E..
>> The additional include allows the build to complete on Fedora 26 (Rawh=
ide)
>> with glibc version 2.24.90.
>>
>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
>> ---
>>  configure                 | 18 ++++++++++++++++++
>>  include/sysemu/os-posix.h |  4 ++++
>>  2 files changed, 22 insertions(+)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Ping - can we get this applied to master to fix broken builds on rawhide?=


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--P3VbsH3PpGcwL38hQaNPo7gTn1Sd8ABVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYxuVuAAoJEKeha0olJ0NqyAAH/3eZS/1NUs5SDtdKuyUu8tj3
+GAvUlbnK07ji6bF6LijcfncxeiJN+YPzyxKjwIAGkqQhHW4zo2Vmf5hdGdsxzv0
543QPYGYQiiXkSfeOxtzhkowj9xDKp7+4YN/OFOMTKKzh++WxpV/rv63Tu0SOu1R
eDfa3Zc5p9+EZBOYZ8Mw39wUwzS2HAmqjjdjH1Z1hVJ9Oy2Tp9XjBi4mGojf5BSE
o3cClzdxs2L9ivEwAerNxIBpoGL4QP2In3Q0Fmy3UmdbnFrsw9vmaEMiynR9v224
+K/POU+wVarPnn6h0jQxAM5z3cBCXe3adUOKCG3Oyf5V0xbttP6V0H3HvsakvU8=
=D0Tg
-----END PGP SIGNATURE-----

--P3VbsH3PpGcwL38hQaNPo7gTn1Sd8ABVB--
