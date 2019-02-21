Received: from eggs.gnu.org ([209.51.188.92]:52960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gwpkR-0002Ip-9R
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gwpkJ-0006Pr-UY
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:54:48 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gwpkJ-0006Oa-60
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:54:43 -0500
Received: by mail-wr1-x444.google.com with SMTP id n2so18602181wrw.8
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 06:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
	<20190221110703.5775-12-marcandre.lureau@redhat.com>
	<20190221132352.f66y5qljs7q4dmse@sirius.home.kraxel.org>
	<CAJ+F1CJrfnqaeHcMveNzRUavmyxLpCRxfeertfV9SrH6-Vd86Q@mail.gmail.com>
	<20190221143923.7k7fjyu64mcv4sdd@sirius.home.kraxel.org>
In-Reply-To: <20190221143923.7k7fjyu64mcv4sdd@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Feb 2019 15:54:30 +0100
Message-ID: <CAJ+F1C+Kj5+J_-TXBmmGxzNOf_ehJ2xDzBAQoE8vjmUJJAChZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/11] display: add -display spice-app
 launching a Spice client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Feb 21, 2019 at 3:39 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Hmm, not working on RHEL-7:
> > >
> > >   qemu-system-x86_64: Failed to launch spice+unix:///tmp/.QON7WZ/spic=
e.sock URI: The specified location is not supported
> > >
> > > virt-viewer + remote-viewer are installed.
> > >
> > > any clue?
> >
> > 5 months old patch, not event released yet :( but virt-viewer should
> > have a release very soon hopefully
> >
> > https://pagure.io/virt-viewer/c/c4f6142f15c4e51cbf427f5f1bf1fc6ac0e10d8=
8?branch=3Dmaster
> >
> > thanks
>
> Too bad.  So broken for pretty much everyone I guess?

It should be easy to backport the patch for older virt-viewer.

But to get the "complete" experience, I would recommend you use the
upcoming virt-viewer. Without it, you won't have the QMP monitor
handling, VTE serial console, etc..

> I think we should have a fallback which exec's remote-viewer then, for
> the next 2-3 years, until a fixed virt-viewer is in widespread use ...

I am not sure, I think it make sense to require the upcoming
virt-viewer instead.

After all, if you use a bleeding edge qemu, you can use bleeding edge
virt-viewer, no?


--=20
Marc-Andr=C3=A9 Lureau
