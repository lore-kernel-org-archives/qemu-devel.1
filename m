Received: from eggs.gnu.org ([2001:4830:134:3::10]:38428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etBpm-00005E-0I
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etBpi-0000aK-VN
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:36:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36638 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etBpi-0000Zy-QB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:36:42 -0500
Date: Tue, 6 Mar 2018 13:36:41 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180306123641.ti4nixbpfnbddv7q@sirius.home.kraxel.org>
References: <20180306083832.8144-1-kraxel@redhat.com>
	<20180306083832.8144-3-kraxel@redhat.com>
	<CAJ+F1CLYj9h7hR9phL5O4CTLrSkwkRKLz3mQqSv7u8Y7Sqvt4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLYj9h7hR9phL5O4CTLrSkwkRKLz3mQqSv7u8Y7Sqvt4A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] spice: add scanout_dmabuf support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

> > @@ -969,6 +983,7 @@ static const DisplayChangeListenerOps display_listener_gl_ops = {
> >
> >      .dpy_gl_scanout_disable  = qemu_spice_gl_scanout_disable,
> >      .dpy_gl_scanout_texture  = qemu_spice_gl_scanout_texture,
> > +    .dpy_gl_scanout_dmabuf   = qemu_spice_gl_scanout_dmabuf,
> >      .dpy_gl_update           = qemu_spice_gl_update,
> >  };
> >
> > --
> > 2.9.3
> >
> >
> 
> Looks good. Btw, how is multi-monitor designed? Is there going to be a
> scanout/dmabuf per monitor when using vfio/mdev?

Yes, that would be one QemuConsole per head (simliar to virtio-gpu).
There is no multihead support right now though.  Not in the drivers, and
also not in the vfio API.  Adding api for it without an actual test case
didn't look like a good plan to me.  Extending the API later is easier
than dealing with a broken api in case we miss some detail and only
figure later when the first driver tries to use the untested API ...

cheers,
  Gerd
