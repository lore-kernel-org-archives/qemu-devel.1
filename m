Received: from eggs.gnu.org ([209.51.188.92]:35191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJxhK-0000dr-1X
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJxhI-0005X2-Rf
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:03:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hJxhI-0005Uw-Gr
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:03:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id a12so3582676wrq.10
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 03:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-5-marcandre.lureau@redhat.com>
	<20190426071530.y4eeu6ekx2nzvpar@sirius.home.kraxel.org>
In-Reply-To: <20190426071530.y4eeu6ekx2nzvpar@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 Apr 2019 12:02:58 +0200
Message-ID: <CAJ+F1CJrR60CpTp4_tYC4Up2rFZ-7TJ4HBghKSe9VQmUzhKDZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 04/11] contrib: add vhost-user-input
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

On Fri, Apr 26, 2019 at 9:16 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Apr 23, 2019 at 03:19:57PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Add a vhost-user input backend example, based on virtio-input-host
> > device. It takes an evdev path as argument, and can be associated with
> > a vhost-user-input device via a UNIX socket:
> >
> > $ vhost-user-input -p /dev/input/eventX -s /tmp/vui.sock
> >
> > $ qemu ... -chardev socket,id=3Dvuic,path=3D/tmp/vui.sock
> >   -device vhost-user-input-pci,chardev=3Dvuic
> >
> > This example is intentionally not included in $TOOLS, to not be built
> > and installed by default.
>
> I think we should build it by default, so it doesn't bitrot,
> even if we don't install it by default.
>
> > +static int unix_sock_new(char *path)
> > +{
>
> Move to common code?
>

Better, use existing unix_listen()!

thanks



--=20
Marc-Andr=C3=A9 Lureau
