Received: from eggs.gnu.org ([2001:4830:134:3::10]:40458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dYY1y-0004WA-71
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dYY1x-0001LY-25
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:31:46 -0400
Date: Fri, 21 Jul 2017 15:31:42 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170721133142.uy6we4kf5h6zi4mt@aurel32.net>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-4-alex.bennee@linaro.org>
	<d58f694c-cc8a-fb0f-f01c-ba1e2eebc6e1@twiddle.net>
	<1ff55ec6-b8e5-8696-7472-0ac22073ddf4@redhat.com>
	<87ziby6udk.fsf@linaro.org> <20170721092758.GF17693@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170721092758.GF17693@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 03/23] softfloat3c: dos2unix
 all files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Alex =?iso-8859-15?Q?Benn=E9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2017-07-21 10:27, Daniel P. Berrange wrote:
> On Fri, Jul 21, 2017 at 09:56:23AM +0100, Alex Benn=E9e wrote:
> >=20
> > Thomas Huth <thuth@redhat.com> writes:
> >=20
> > > On 20.07.2017 20:59, Richard Henderson wrote:
> > >> On 07/20/2017 05:04 AM, Alex Benn=E9e wrote:
> > >>> This is a massive but mechanical patch, the result of:
> > >>>
> > >>>    (cd fpu/softfloat3c; and find . | xargs dos2unix)
> > >>>    (cd include/fpu/softfloat3c; and dos2unix *)
> > >>>
> > >>> Signed-off-by: Alex Benn=E9e<alex.bennee@linaro.org>
> > >>> ---
> > >>
> > >> Really shouldn't this have been part of the import?
> > >
> > > +1
> > > It's only a whitespace change, so please squash it in the previous pa=
tch
> > > instead. (You could mention this in the patch description that line
> > > endings have been changed to unix mode)
> >=20
> > Sure - I just wanted to be clear of the steps I took should I want to do
> > it from scratch again.
> >=20
> > One thing playing in my mind against moving to SoftFloat3c is the
> > inscrutability of the upstream. It's nice there has been a new release
> > with new features but there isn't a source repository or as far as I can
> > tell a development list. It is basically as far as I can tell a one man
> > project albeit backed by academic funding.
>=20
> This is no worse than the situation we already have with SoftFloat 2
> though is it. IOW, as long as we fully move from v2 -> v3 eventually
> (to avoid maintaining both indefinitely) we're no worse off from the
> community POV. At least v3 has the possibility to be become more
> community driven in future, where as v2 is essentially now a obsolete
> version.

It depends if we are able to get (at least part of) our changes
upstreamed. Switching to softfloat v3 is likely to be a substantial
effort, and we probably don't want to have the same discussion and do
this effort again when switching to softfloat v4. Now if we are able to
get our changes upstream, switching to softfloat v4 will be much easier.

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
