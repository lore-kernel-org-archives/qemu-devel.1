Received: from eggs.gnu.org ([209.51.188.92]:54509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gwlcI-00056G-Hu
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gwlcH-0001n2-Ki
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:30:10 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gwlcH-0001fe-8M
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:30:09 -0500
Received: by mail-wm1-x343.google.com with SMTP id h22so6728118wmb.0
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 02:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
	<20190208112357.31615-13-marcandre.lureau@redhat.com>
	<20190221094256.6l4rhurvzdgqedw7@sirius.home.kraxel.org>
In-Reply-To: <20190221094256.6l4rhurvzdgqedw7@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Feb 2019 11:29:46 +0100
Message-ID: <CAJ+F1C+9qTJ3aNLc2BqyRJmnbr6hN3Jv-0TeRtWKbWuArB0fmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/13] contrib: add vhost-user-input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Thu, Feb 21, 2019 at 10:53 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Feb 08, 2019 at 12:23:56PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Add a vhost-user input backend example, based on virtio-input-host
> > device. It takes an evdev path as argument, and can be associated with
> > a vhost-user-input device via a UNIX socket:
> >
> > $ vhost-user-input -p /dev/input/eventX -s /tmp/vui.sock
> >
> > $ qemu ... -chardev socket,id=3Dvuic,path=3D/tmp/vui.sock
> >   -device vhost-user-input-pci,chardev=3Dvuic
>
> > +static int unix_sock_new(char *path)
> > +{
>
> Move to the library?  This looks like something other backends will need
> too.
>

Eventually. I am not sure libvhost-user is the right place though.

We could eventually link with a util/ object.

That could be done in a seperate patch, since there are already
several similar functions in qemu source tree.


Thanks


--=20
Marc-Andr=C3=A9 Lureau
