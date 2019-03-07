Received: from eggs.gnu.org ([209.51.188.92]:51512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1mhG-0008Mt-Jo
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 01:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1mhA-0000oj-RH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 01:39:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h1mh8-0000nU-Fz
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 01:39:55 -0500
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
Date: Thu, 7 Mar 2019 07:39:46 +0100
MIME-Version: 1.0
In-Reply-To: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/03/2019 19.12, Paolo Bonzini wrote:
> Hi all,
>=20
> lately I have been thinking of converting the QEMU build system to
> Meson.  Meson is a relatively new build system that can replace
> Autotools or hand-written Makefiles such as QEMU; as a die-hard
> Autotools fan, I must say that Meson is by far better than anything els=
e
> that has ever tried to replace Autotools, and actually has the potentia=
l
> to do so.
>=20
> Advantages of Meson that directly matter for QEMU include:[...]

I'm not objecting a new build system per se, but could you elaborate on
 problems of the current QEMU build system that will be fixed by this
change? Since apart from some minor glitches (with the *.mak file
dependencies for example), the current build system seems to work quite
well for me ... so at least I currently don't feel enough pain yet to do
such a big step, just because there is another new cool build system
around...

Just my 0.02 =E2=82=AC, of course.

 Thomas


PS: I just saw https://mesonbuild.com/Dependencies.html#cmake ... that's
a funny idea :-)
