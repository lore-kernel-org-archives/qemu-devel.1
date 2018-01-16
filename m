Received: from eggs.gnu.org ([2001:4830:134:3::10]:49361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebVYC-0001Ys-9n
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebVYB-00014q-IH
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:01:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebVYB-00013d-D0
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:01:31 -0500
Date: Tue, 16 Jan 2018 18:01:19 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180116180119.GK1521@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180110131832.16623-1-klim.kireev@virtuozzo.com>
	<CAJ+F1CKBKLXGFFN+FjKBPRWh9QdGx5=36J_XYS9Gz+6RsUG9Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKBKLXGFFN+FjKBPRWh9QdGx5=36J_XYS9Gz+6RsUG9Wg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev/char-socket: add POLLHUP handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Klim Kireev <klim.kireev@virtuozzo.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, den@virtuozzo.com

On Tue, Jan 16, 2018 at 06:56:20PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Jan 10, 2018 at 2:18 PM, Klim Kireev <klim.kireev@virtuozzo.com=
> wrote:
> > The following behavior was observed for QEMU configured by libvirt
> > to use guest agent as usual for the guests without virtio-serial
> > driver (Windows or the guest remaining in BIOS stage).
> >
> > In QEMU on first connect to listen character device socket
> > the listen socket is removed from poll just after the accept().
> > virtio_serial_guest_ready() returns 0 and the descriptor
> > of the connected Unix socket is removed from poll and it will
> > not be present in poll() until the guest will initialize the driver
> > and change the state of the serial to "guest connected".
> >
> > In libvirt connect() to guest agent is performed on restart and
> > is run under VM state lock. Connect() is blocking and can
> > wait forever.
> > In this case libvirt can not perform ANY operation on that VM.
>=20
> Adding Daniel in CC for comments about libvirt behaviour.

This is a libvirt bug - libvirt should put a finite timeout on connecting
to the guest agent socket to avoid this.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
