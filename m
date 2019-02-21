Received: from eggs.gnu.org ([209.51.188.92]:34843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gwoT1-000743-Gx
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:32:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gwoSz-0007ae-Ah
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:32:47 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gwoSy-0007Wy-Tc
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:32:45 -0500
Received: by mail-wr1-x432.google.com with SMTP id q1so30191519wrp.7
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 05:32:41 -0800 (PST)
MIME-Version: 1.0
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
	<20190221110703.5775-12-marcandre.lureau@redhat.com>
	<20190221132352.f66y5qljs7q4dmse@sirius.home.kraxel.org>
In-Reply-To: <20190221132352.f66y5qljs7q4dmse@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Feb 2019 14:32:28 +0100
Message-ID: <CAJ+F1CJrfnqaeHcMveNzRUavmyxLpCRxfeertfV9SrH6-Vd86Q@mail.gmail.com>
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
To: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Feb 21, 2019 at 2:24 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Feb 21, 2019 at 12:07:03PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Add a new display backend that will configure Spice to allow a remote
> > client to control QEMU in a similar fashion as other QEMU display
> > backend/UI like GTK.
> >
> > For this to work, it will set up Spice server with a unix socket, and
> > register a VC chardev that will be exposed as Spice ports. A QMP
> > monitor is also exposed as a Spice port, this allows the remote client
> > fuller qemu control and state handling.
> >
> > - doesn't handle VC set_echo() - this doesn't seem a strong
> >   requirement, very few front-end use it
> > - spice options can be tweaked with other -spice arguments
> > - Windows support shouldn't be hard to do, but will probably use a TCP
> >   port instead
> > - we may want to watch the child process to quit automatically if it
> >   crashed
>
> Hmm, not working on RHEL-7:
>
>   qemu-system-x86_64: Failed to launch spice+unix:///tmp/.QON7WZ/spice.so=
ck URI: The specified location is not supported
>
> virt-viewer + remote-viewer are installed.
>
> any clue?

5 months old patch, not event released yet :( but virt-viewer should
have a release very soon hopefully

https://pagure.io/virt-viewer/c/c4f6142f15c4e51cbf427f5f1bf1fc6ac0e10d88?br=
anch=3Dmaster

thanks

--=20
Marc-Andr=C3=A9 Lureau
