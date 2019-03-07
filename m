Received: from eggs.gnu.org ([209.51.188.92]:50434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1xWV-0005kK-Uy
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1xWU-0004un-54
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:13:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h1xWS-0004te-W2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:13:38 -0500
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
Date: Thu, 7 Mar 2019 19:13:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 07/03/19 14:09, Peter Maydell wrote:
> On Thu, 7 Mar 2019 at 12:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> In any case, this wouldn't change; as you suggest below, configure cou=
ld
>> remain as a front-end (well, in-srcdir builds are not supported by
>> Meson, so "../configure && ninja" perhaps).
>=20
> As an aside, it might be a nice idea to drop the in-srcdir
> build altogether for QEMU anyway -- it's not really a very
> good idea and it means our build system has to cope with two
> different ways of working to no particularly useful end.

I was actually going to propose that, but I was afraid of throwing two
bombs in the same day. :)

> Of the various hosts I do builds on:
>  * OSX is 2.7 only
>  * the ppc64 box in the gcc compile farm is 2.7 and 3.4
>    ("Centos 7.5.1804")
>  * the aarch64 box in the gcc compile farm is 2.7 and 3.4
>    ("Ubuntu 14.04.5 LTS", aka trusty)

OS X will need to get Python 3 from Homebrew sooner or later anyway.

Trusty does have a python3.5 package, perhaps you could ask the
maintainers to install it.

CentOS 7 doesn't have "native" Python 3 (even the 3.4 version you have
there is probably coming from Fedora) but it has software collections,
where you have to do "scl enable rh-python35 './configure && make'".
You can check if scl and the rh-python35 software collections are
already installed.

Paolo
