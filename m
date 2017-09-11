Received: from eggs.gnu.org ([2001:4830:134:3::10]:57663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drEZI-0004ev-8o
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 22:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drEZF-0005co-5e
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 22:35:24 -0400
References: <1504100343-26607-1-git-send-email-thuth@redhat.com>
	<b98a4c56-f386-f827-5aa7-9a00e6fdf790@amsat.org>
	<CAFEAcA8O5T5cX8XqBVZqXLt5MPvF7qEcJK8Az2GBei07P0dZGQ@mail.gmail.com>
	<20170910032413.GB2735@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9058bb80-4e5c-3316-576f-1c21924a8a07@redhat.com>
Date: Mon, 11 Sep 2017 04:35:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170910032413.GB2735@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="GQHCXIGEsWoOcJ4EASUpJB3SX7A3CE837"
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/misc/ivshmem: Fix
 ivshmem_recv_msg() to also work on big endian systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Cornelia Huck <cohuck@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GQHCXIGEsWoOcJ4EASUpJB3SX7A3CE837
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.2017 05:24, David Gibson wrote:
> On Wed, Aug 30, 2017 at 03:59:07PM +0100, Peter Maydell wrote:
>> On 30 August 2017 at 15:53, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>>> On 08/30/2017 10:39 AM, Thomas Huth wrote:
>>>> The problem is that the server side code in ivshmem_server_send_one_=
msg()
>>>> correctly translates all messages IDs into little endian 64-bit valu=
es,
>>>> but the client side code in the ivshmem_recv_msg() function does not=
 swap
>>>> the byte order back. Fix it by passing the value through le64_to_cpu=
().
>>>
>>>
>>> Yes, we lack BE testing :(
>>
>> My pre-pull-request test set includes s390 and ppc64 bigendian.
>> This one was just missed because the 'slow' tests aren't in
>> 'make check'.
>=20
> I'm not what makes sense for staging this fix.  I could take it
> through my tree, but it's not an obvious match, since this isn't
> really related to ppc at all.

There does not seem to be maintainer for ivshmem, as far as I can see,
so I'd say any tree that is distantly related is fine. So I think you
could either take it through your ppc tree (since the bug affects big
endian ppc machines), or maybe Cornelia could take it through the s390x
tree (since we've seen the problem on the big endian s390x machines,
too). Otherwise I have to wait and see whether it goes through misc or
trivial, I guess...

 Thomas


--GQHCXIGEsWoOcJ4EASUpJB3SX7A3CE837
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZtfZhAAoJEC7Z13T+cC21kjAQAKAnBTVWYkp3dVFH8I3YyPgx
cZTt6l4O6+I3cewKtUBgn1o/tlJPM+NCS3iJwCngfYuL0RDu4F1Rb9eVRSury86b
M14D//Odt03XTFnnWZjBzctv6BoZ3uoV68ZwnfAHKttl7sVUgY04PQ0/PQ/kE0O1
+WH8pvz1dwdQGTueqhxtnNK0soVfS3o8SvRXRFa1aUlgA0+sIigLTb5SWqbhFdRZ
BJbbv2+4HNw2xHtaPfP5tEZM3+nEKyyIfQgYQcP0Yl9VpMdOByizNbMALig8Ie4Z
UHoGSINPtRydTV+Lw5wqWyWkM2JVrJQ0pRje7619BkTj80KaVc2cdmq3LJAPN+Ni
axwwFEn+NiPUd/6LFCyqOGlMwXwncGomuaV9MEl/slUaZg/u5VIFWSN9UR8mBceu
JDMpzJHEMCieqBdxzIz4OifLUzwDzxX3pH18NBBZukMuEZpYdpcY7bLPXWZKGuYu
zOmtbCZfYUzBqdseL1pX+fCwcBonYns0rKRBMiF4koVytpbhzm2XTcO82ZEekRIb
LR3L/fUPVlwzP46GfFuXGN9yEzeVpcmmcZfRRp33WV9yiN29b9DTqagCLh57Ia5T
XAfocD5nTp0K3sR0QeGPtkQDPLQSbjocrmcJquypmx2S/ZOXf5I8IPoyUHT4khRr
rHmQ26LWX9Z258Bi4TCf
=uzn9
-----END PGP SIGNATURE-----

--GQHCXIGEsWoOcJ4EASUpJB3SX7A3CE837--
