Received: from eggs.gnu.org ([2001:4830:134:3::10]:42412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSkhM-0008HV-Lq
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSkhI-0001S3-9I
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:50:32 -0400
References: <20170626101159.19676-1-berrange@redhat.com>
	<c4381bd8-a417-0c3b-f3c2-1292ca9f6dfc@redhat.com>
	<20170705134104.GD1280@stefanha-x1.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dd89f2b0-dbcc-10a4-50dd-598c2115e8cd@redhat.com>
Date: Wed, 5 Jul 2017 15:50:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170705134104.GD1280@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aVeKnSxLL44lBOqJfo7O0pIhV3aX8vIng"
Subject: Re: [Qemu-devel] [PATCH] sockets: avoid formatting buffer that may
 not be NULL terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aVeKnSxLL44lBOqJfo7O0pIhV3aX8vIng
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.07.2017 15:41, Stefan Hajnoczi wrote:
> On Mon, Jun 26, 2017 at 12:19:40PM +0200, Thomas Huth wrote:
>> On 26.06.2017 12:11, Daniel P. Berrange wrote:
>>> The 'sun_path' field in the sockaddr_un struct is not required
>>> to be NULL termianted, so when reporting an error, we must use
>>
>> s/NULL/NUL/
>>
>> NULL is a pointer, NUL is the '\0' character.
>=20
> I wanted to point out the same thing to someone recently, so I chased u=
p
> a reference to the NUL character in RFC 20 "ASCII format for Network
> Interchange".  After all, no one can argue with an RFC.
>=20
> What I found shocked me!  There must be a typo in the ASCII RFC:
> https://tools.ietf.org/html/rfc20#section-5.2
>=20
> I closed my browser tab quickly and headed to Wikipedia instead.  If th=
e
> primary source didn't support my argument, I could always count on good=

> old Wikipedia...
>=20
> But do you know what I found?  Someone had conflated nul and null on th=
e
> Wikipedia entry:
> https://en.wikipedia.org/wiki/Null_character
>=20
> Amateurs!  The Wikipedia editors probably didn't have the intellectual
> calibre to question the correctness of the RFC text the way I did.
>=20
> But to cut a long story short, as my search continued the evidence
> became overwhelming.  It is acceptable to refer to the nul character as=

> the null character.

Well, I don't see a real problem here - as long as you write "null" with
lowercase letters. "NULL" with uppercase letters is the pointer. "NUL"
with uppercase letters is the character. And "null" with lowercase
letters is just a context-sensitive word :-)

 Thomas


--aVeKnSxLL44lBOqJfo7O0pIhV3aX8vIng
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZXO6cAAoJEC7Z13T+cC21IPsP/2QaVCIGsQcoRMio1cEJDz8H
TXW5SnA8NYX5LO6SquRHl41QD12K2VXQBKmhBWc2YlruJCblCWx4TpYt3QNc/IHY
Wh5RMiegsu2czwezpxrqZdNOV/9M7qj3kSXUzSzk/952+I24ZETYIdCNZq2zeQLO
jAbQPXkwJaxvrf8G16SeOxWpg762qNfVxUb93dPvP9TFkOv0W0U7EfFl52v/l/M1
HTZraK6dTaeds7aj5EPOkIpCebDlCF8Ey2tAfvG15B+dfmHQ7RnPqVR9ezxWI1Ce
7/AnWEN8M5zYz/JfNhRCdGe47Nn4mGmnNCvT5zgSRwKwmUEw4b+U/wOg45tBPQAj
cgaiwnHHeBi6MCg4C4jAM1fMttQwx58dFWyIzCGOynIgKwnFtHFpdFLuSA0mADhJ
JvqKgrVYiT8eT/E11KK9ddmJftCEROU0r6iwWInpvWOR4xPg8a8p31sRjZNWF6sw
SQhD++Qqdv32IosQa5ucraoHbb5nDeDVHRKSEFqrJj1XOSXQhRdHy92lyuUE3w3S
W2DSSnaOROrCoDiEoCBhPb+KkfiG8jWoRGI41MZR46oIgNTJ+woSUtsOdPPL8Bza
CINVy97blIArx+yTjtFE3xLUb6fYUA+NIc851whsuI4ck8MurFdVI6H4PmAjBN1P
jauNd1COt2n5k41YpjPo
=/5yd
-----END PGP SIGNATURE-----

--aVeKnSxLL44lBOqJfo7O0pIhV3aX8vIng--
