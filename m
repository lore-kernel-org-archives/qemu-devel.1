Received: from eggs.gnu.org ([209.51.188.92]:55402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ngompa13@gmail.com>) id 1h39bq-0005d4-3y
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 21:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ngompa13@gmail.com>) id 1h39SY-00068t-8A
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 21:10:31 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:39694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ngompa13@gmail.com>) id 1h39SX-00068V-Tr
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 21:10:30 -0400
Received: by mail-qt1-x841.google.com with SMTP id i14so3346847qtp.6
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 18:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
In-Reply-To: <62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Sun, 10 Mar 2019 21:09:51 -0400
Message-ID: <CAEg-Je-0EA7qafLAXOdSTDAHUEi-Gf9wgriSsDkSrSw-YuPz=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 7, 2019 at 1:44 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 07/03/19 14:09, Peter Maydell wrote:
> > On Thu, 7 Mar 2019 at 12:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> In any case, this wouldn't change; as you suggest below, configure cou=
ld
> >> remain as a front-end (well, in-srcdir builds are not supported by
> >> Meson, so "../configure && ninja" perhaps).
> >
> > As an aside, it might be a nice idea to drop the in-srcdir
> > build altogether for QEMU anyway -- it's not really a very
> > good idea and it means our build system has to cope with two
> > different ways of working to no particularly useful end.
>
> I was actually going to propose that, but I was afraid of throwing two
> bombs in the same day. :)
>
> > Of the various hosts I do builds on:
> >  * OSX is 2.7 only
> >  * the ppc64 box in the gcc compile farm is 2.7 and 3.4
> >    ("Centos 7.5.1804")
> >  * the aarch64 box in the gcc compile farm is 2.7 and 3.4
> >    ("Ubuntu 14.04.5 LTS", aka trusty)
>
> OS X will need to get Python 3 from Homebrew sooner or later anyway.
>
> Trusty does have a python3.5 package, perhaps you could ask the
> maintainers to install it.
>
> CentOS 7 doesn't have "native" Python 3 (even the 3.4 version you have
> there is probably coming from Fedora) but it has software collections,
> where you have to do "scl enable rh-python35 './configure && make'".
> You can check if scl and the rh-python35 software collections are
> already installed.
>

Most normal users of CentOS use it with EPEL. In this case, EPEL 7 is
transitioning to Python 3.6 (both are available in EPEL 7 today, and
Meson is built there against 3.6).

macOS already has Python 3 in Homebrew, as well as Meson itself.
Eventually Apple will change the native Python runtime to 3.x as well.

Ubuntu 14.04 LTS is EOL next month, and Ubuntu 16.04 LTS ships Python
3.5 and offers a recent Meson in backports.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
