Received: from eggs.gnu.org ([2001:4830:134:3::10]:53242)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dYX1q-0000nz-Uh
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dYX1q-0002dH-38
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:27:34 -0400
References: <1500568341-8389-1-git-send-email-peter.maydell@linaro.org>
	<eec67af4-3f8e-bb85-0854-61f4d450f627@redhat.com>
	<CAFEAcA_mOeR2jTGuik6Jig972vMW5JTqQFaoZzt5_9oaG7D+aA@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <9b0800b8-b13f-67b3-a21f-96a6ba8d0a99@gmx.com>
Date: Fri, 21 Jul 2017 14:18:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_mOeR2jTGuik6Jig972vMW5JTqQFaoZzt5_9oaG7D+aA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bVeJb9iD0g3owLt6KXesHf692rl3VUN1B"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-2.10]
 util/oslib-posix.c: Avoid warning on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, "patches@linaro.org" <patches@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bVeJb9iD0g3owLt6KXesHf692rl3VUN1B
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 "patches@linaro.org" <patches@linaro.org>
Message-ID: <9b0800b8-b13f-67b3-a21f-96a6ba8d0a99@gmx.com>
Subject: Re: [Qemu-trivial] [Qemu-devel] [PATCH for-2.10] util/oslib-posix.c:
 Avoid warning on NetBSD
References: <1500568341-8389-1-git-send-email-peter.maydell@linaro.org>
 <eec67af4-3f8e-bb85-0854-61f4d450f627@redhat.com>
 <CAFEAcA_mOeR2jTGuik6Jig972vMW5JTqQFaoZzt5_9oaG7D+aA@mail.gmail.com>
In-Reply-To: <CAFEAcA_mOeR2jTGuik6Jig972vMW5JTqQFaoZzt5_9oaG7D+aA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.07.2017 12:22, Peter Maydell wrote:
> On 20 July 2017 at 19:26, Eric Blake <eblake@redhat.com> wrote:
>> On 07/20/2017 11:32 AM, Peter Maydell wrote:
>>> On NetBSD the compiler warns:
>>> util/oslib-posix.c: In function 'sigaction_invoke':
>>> util/oslib-posix.c:589:5: warning: missing braces around initializer =
[-Wmissing-braces]
>>>      siginfo_t si =3D { 0 };
>>>      ^
>>
>> Uggh. That is a broken compiler.  C99 declares that 'anything =3D {0}'=
 is
>> supposed to be a valid way to zero-initialize anything.
>>

Not necessarily broken compiler. According to strict C standard we need
to initialize it in this case with "{{0}}"... which is ugly. A portable
option is to go for memset(3). {} is also fine and I hope it will be
added to C standard.

>>> util/oslib-posix.c:589:5: warning: (near initialization for 'si.si_pa=
d') [-Wmissing-braces]
>>>
>>> because on this platform siginfo_t is defined as
>>>   typedef union siginfo {
>>>           char    si_pad[128];    /* Total size; for future expansion=
 */
>>>           struct _ksiginfo _info;
>>>   } siginfo_t;
>>>
>>> Avoid this warning by initializing the struct with {} instead;
>>> this is a GCC extension but we use it all over the codebase already.
>>
>> Well, I'm glad that works to shut up the broken compiler.
>>
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>  util/oslib-posix.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Thanks; applied to master.
>=20

Thank you!

> -- PMM
>=20



--bVeJb9iD0g3owLt6KXesHf692rl3VUN1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZcfEKAAoJEEuzCOmwLnZs5GYP/2qfUNRV0PgjaVzOYO5mfLZw
8HghTPT9utWn1JN+nox5CqBguLmDClqa/4ilqFuJMDJxhcx7FaTjaFqXFhY5tYBh
95qHdYiJ8JNfLAOlVYfUcSKFxvpTLb3siS5SaHR6oHL15GLMgKmO4uGc8q9uBihz
HrZCWtLwK83s83IUdP/148P5gsW10fQ5N89CvCWTpMlE8orAcg5OxYnc7ViagDyP
aJHK3y7AVMScJ5ArfMEQJwz1M8QeNetSG85VNXNeBxwOtZQL+C5P1s5SfFaWexOn
hV49ExTjQUiD1UT7Hr5juvQid14KCRPlDNvA9ErCfFOA3T26BUE5hy1wCfGDtEe3
BzuSYKFKoZNgMHWaQFmiH+wZKEW8UlosGwfpAOwtSOaxlWOfvlvIV/GGKxK+hIdL
9YVUygXl2nLV8gJbJdk65YDO9Fnbkea8cDGSDwu+2yHW3n+plz6HaryF3OsP5zRC
oZNbg52Kz6GAIstN/Ilxfo70SSdV5wLiFN462c6omHkRkgHJScMY+Unnb+Gwj6io
tNPhul88319hFBh0LoWxbvLlHdsNL69Gov8eLcKpaUExHHE0qUkWGNQhjG0YO2B4
JN+qjGsVjNfm/A5ZQ1iQ+9u+DRPTmy5yjk8l/Ml3q0DNTk3L+6kRj110fUA2U7s0
VJcsxSVtd+it28BOte9h
=jOHU
-----END PGP SIGNATURE-----

--bVeJb9iD0g3owLt6KXesHf692rl3VUN1B--
