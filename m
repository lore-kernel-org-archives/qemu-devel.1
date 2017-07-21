Received: from eggs.gnu.org ([2001:4830:134:3::10]:47995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYUEG-0006YO-7A
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYUEF-0005Zk-1E
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:28:12 -0400
Date: Fri, 21 Jul 2017 10:27:58 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170721092758.GF17693@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-4-alex.bennee@linaro.org>
	<d58f694c-cc8a-fb0f-f01c-ba1e2eebc6e1@twiddle.net>
	<1ff55ec6-b8e5-8696-7472-0ac22073ddf4@redhat.com>
	<87ziby6udk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ziby6udk.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
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
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On Fri, Jul 21, 2017 at 09:56:23AM +0100, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
> > On 20.07.2017 20:59, Richard Henderson wrote:
> >> On 07/20/2017 05:04 AM, Alex Benn=C3=A9e wrote:
> >>> This is a massive but mechanical patch, the result of:
> >>>
> >>>    (cd fpu/softfloat3c; and find . | xargs dos2unix)
> >>>    (cd include/fpu/softfloat3c; and dos2unix *)
> >>>
> >>> Signed-off-by: Alex Benn=C3=A9e<alex.bennee@linaro.org>
> >>> ---
> >>
> >> Really shouldn't this have been part of the import?
> >
> > +1
> > It's only a whitespace change, so please squash it in the previous pa=
tch
> > instead. (You could mention this in the patch description that line
> > endings have been changed to unix mode)
>=20
> Sure - I just wanted to be clear of the steps I took should I want to d=
o
> it from scratch again.
>=20
> One thing playing in my mind against moving to SoftFloat3c is the
> inscrutability of the upstream. It's nice there has been a new release
> with new features but there isn't a source repository or as far as I ca=
n
> tell a development list. It is basically as far as I can tell a one man
> project albeit backed by academic funding.

This is no worse than the situation we already have with SoftFloat 2
though is it. IOW, as long as we fully move from v2 -> v3 eventually
(to avoid maintaining both indefinitely) we're no worse off from the
community POV. At least v3 has the possibility to be become more
community driven in future, where as v2 is essentially now a obsolete
version.

> That said the license change in 3 does mean it would be a lot easier to
> incorporate fixes and updates if and when upstream release new versions=
.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
