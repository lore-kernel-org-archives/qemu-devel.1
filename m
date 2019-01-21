Received: from eggs.gnu.org ([209.51.188.92]:39606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1glX16-00075u-RJ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1glX0V-0000lB-Dg
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:40:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1glX0V-0000iI-7n
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:40:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so10264197wml.2
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 02:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20190118185402.3065-1-peter.maydell@linaro.org>
	<906bafd8-2a2a-9cae-142e-c7045edaa9d0@redhat.com>
In-Reply-To: <906bafd8-2a2a-9cae-142e-c7045edaa9d0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 21 Jan 2019 11:40:22 +0100
Message-ID: <CAP+75-X_2oyq9siWs0ubUnUp0DGzp-CvYhwJZenfdz6b_BatrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: Disable ipmi-bt-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>
Cc: patches@linaro.org, Thomas Huth <thuth@redhat.com>

On Mon, Jan 21, 2019 at 11:39 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Cc'ing Corey, the tests author.
>
> On 1/18/19 7:54 PM, Peter Maydell wrote:
> > The ipmi-bt-test fails intermittently, especially on the NetBSD VM.
> > The frequency of this failure has recently gone up sharply to the
> > point that I'm having to retry the NetBSD build multiple times
> > to get a pass when merging pull requests.
> >
> > Disable the test until we can figure out why it's failing.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Oops wrong paste, FWIW:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> > ---
> > Fed up with this failing all the time so let's just turn it off.
> > Feel free to investigate what's actually going wrong with it...
> >
> >  tests/Makefile.include | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index eaa81ee1d07..5e6b2c7058d 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -186,7 +186,8 @@ check-qtest-i386-$(CONFIG_SGA) +=3D tests/boot-seri=
al-test$(EXESUF)
> >  check-qtest-i386-$(CONFIG_SLIRP) +=3D tests/pxe-test$(EXESUF)
> >  check-qtest-i386-y +=3D tests/rtc-test$(EXESUF)
> >  check-qtest-i386-y +=3D tests/ipmi-kcs-test$(EXESUF)
> > -check-qtest-i386-y +=3D tests/ipmi-bt-test$(EXESUF)
> > +# Disabled temporarily as it fails intermittently especially under Net=
BSD VM
> > +# check-qtest-i386-y +=3D tests/ipmi-bt-test$(EXESUF)
> >  check-qtest-i386-y +=3D tests/i440fx-test$(EXESUF)
> >  check-qtest-i386-y +=3D tests/fw_cfg-test$(EXESUF)
> >  check-qtest-i386-y +=3D tests/drive_del-test$(EXESUF)
> >
