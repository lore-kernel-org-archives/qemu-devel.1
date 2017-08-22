Received: from eggs.gnu.org ([2001:4830:134:3::10]:38821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dk1vG-0007KJ-SC
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 01:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dk1vD-0002Xe-Q6
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 01:40:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dk1vD-0002XM-Gy
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 01:40:15 -0400
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
	<20170822010917.GO12356@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b2dc0860-093e-14e1-0bc8-b19195161b03@redhat.com>
Date: Tue, 22 Aug 2017 07:40:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170822010917.GO12356@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="e3rRmNhBNHxbWSCGgdmWp5o8J0Bce1Jwg"
Subject: Re: [Qemu-devel] [PATCH for-2.10] boot-serial-test: prefer tcg
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e3rRmNhBNHxbWSCGgdmWp5o8J0Bce1Jwg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.08.2017 03:09, David Gibson wrote:
> On Wed, Aug 16, 2017 at 12:18:07PM +0100, Peter Maydell wrote:
>> On 16 August 2017 at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:=

>>> On 16/08/2017 10:26, Cornelia Huck wrote:
>>>> Prefer to use the tcg accelarator if it is available: This is our on=
ly
>>>> real smoke test for tcg, and fast enough to use it for that.
>>>
>>> I'm not sure this is required for 2.10.  Yes, it means the coverage f=
rom
>>> "make check" is worse, but that's it.
>>
>> Yes, I'd put it under "if we need to roll an rc4 anyway for
>> some more significant bug we might as well put this in too,
>> but it doesn't merit cutting rc4 by itself."
>=20
> It does entirely break "make check" on a ppc host.  And that in turn
> has held up my testing cycle for a couple of ppc regressions from 2.9
> that I was hoping to squeeze in.  Does that change your calculations?

Uuh, right. The problem is that we can only run the "pseries" machine
with kvm-hv, but not the other ppc machines (and the boot-serial test
tries to start a couple of these). So the "accel=3Dtcg:kvm" fix should
currently be the best way to ease the situation - since ppc does not
support "--disable-tcg" yet, it will always be tested with tcg.

But when we support "--disable-tcg" one day on ppc, too, we might have
to come up with a more clever solution here instead...

 Thomas



--e3rRmNhBNHxbWSCGgdmWp5o8J0Bce1Jwg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZm8O3AAoJEC7Z13T+cC21et0QAKKe6yL1NUx+onJ2hJkULNlV
FFWIcLSLjixbNS/xXJsnSWBwLGGVIGLgrkfLBjkvgh08fCsX6CplIGSH24riVltj
Pn9JuP4u1ieISA6NxwyQuM6gU0sc2H6SvrVgM/V0MWH27RZFn5JNoTUJGSof6FuE
cTVg4kBZbbwDaDI0YdiydfIv65vvN1h+NEkX94JJu2b0mvDj45gd5fG9mDHuLsfd
Pcn3lofOqDOv3g14lfdhxvVNI+MWeGdJkJ+ouj9O8G4we63r9sey03WvXpdPqD3n
6X3sJOR4fkFYW4JmiIgCI71bl36ZI9sD2FlpZ5Qj3OmAIWFP/39QAQMvFCcJZrZr
4V6whKyTpHwQUC/GtnafHiy/krL0z6RQpMECbVyVYhasdtWG4l+6GkkDApJfwz/q
9uRVIN52xVbT4g1bse0nOn66HouUdc5kMM8tndKTqv4i6ysjMKXX0rEdUdnsVVeD
mrIuB2daaUJRov9R+Q+PCsFN5hHxLORsrFHN5hesH2xga7/MUxEnvlf/A7U1QL39
Zbq7tLXncc1xWTmNb0mSLKo1e3MlSkiKD9clmc0GFmN9XqM1REX1BZpmWSy19Cpa
6faxgS1eG21DyskehQw9hr0lHBumx7Egz4JFmiV68j2WiaEHTnWv5IZmHUFu2VNk
kj3uPBcSyr+9z6hPwcBY
=YMgn
-----END PGP SIGNATURE-----

--e3rRmNhBNHxbWSCGgdmWp5o8J0Bce1Jwg--
