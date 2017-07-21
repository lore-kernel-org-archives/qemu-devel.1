Received: from eggs.gnu.org ([2001:4830:134:3::10]:39568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dYXw4-00029a-Ft
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dYXw3-0005KH-8J
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:25:40 -0400
Date: Fri, 21 Jul 2017 15:25:34 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170721132534.s3zjgwbdn7y6oknv@aurel32.net>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-6-alex.bennee@linaro.org>
	<71a11f23-39e7-d89a-36d5-2870ed76d940@twiddle.net>
	<87y3ri6sou.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87y3ri6sou.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 05/23] softfloat3c: initial
 build machinery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-15?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 2017-07-21 10:32, Alex Benn=E9e wrote:
>=20
> Richard Henderson <rth@twiddle.net> writes:
>=20
> > On 07/20/2017 05:04 AM, Alex Benn=E9e wrote:
> >> +# so they can still be linked when needed. We build these files surpr=
essing so of the normal CFLAGS.
> >
> > "surpressing so" -> "suppressing some"
> >
> > Do we gain any confidence for our still supported but less tested
> > 32-bit hosts (all of which do support a 64-bit type) by dropping the
> > FAST_INT64 distinction?
>=20
> I guess so. Certainly I can cross-compile aarch64-softmmu on armhf
> defining all the:
>=20
>   softfloat3_fastint64=3D"yes"
>   softfloat3_fastdiv32to16=3D"yes"
>   softfloat3_fastdiv64to32=3D"yes"
>=20
> without any issue. I guess it might mean our 32 bit guests might run
> slightly slower but none of our FP is fast anyway.
>=20
> There is also a slight intermingling in the build setup between the
> FASTINT64 and the specialisation even though there are for different
> things.
>=20
> The 8086 code basically makes NaN propagation match old x86 whereas SSE
> is the more recent and more IEEE like SSE behaviour. See section 5 of:
>=20
>   http://www.jhauser.us/arithmetic/SoftFloat-3c/doc/SoftFloat-source.html
>=20
> I suspect what we should have here are specialisation for each of our
> guests. We do something similar in the softfloat2a code in it's
> specialise header. Maybe we should rename 8086-SSE to default and then
> create a specialisation for each guest that needs it?

For the sNaN is 0 or 1 specialisation we actually need to be able to
select this at runtime, as we have implemented it in the QEMU softfloat
version.

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
