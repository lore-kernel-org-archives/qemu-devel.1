Received: from eggs.gnu.org ([2001:4830:134:3::10]:53026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZHw5-0003Yx-7u
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:09:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZHw1-0008T7-Ce
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:09:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gZHw0-0008S1-Vh
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:09:29 -0500
Date: Tue, 18 Dec 2018 16:09:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181218160919.GD4807@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181218100002.11219-1-xieyongji@baidu.com>
	<20181218100002.11219-2-xieyongji@baidu.com>
	<CAMxuvawx1GXar_UX5Pa_JEEW7EFnG092_PZGKiUL73wtd+s7cg@mail.gmail.com>
	<20181218152520.GB4807@redhat.com>
	<20181218104351-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218104351-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0 1/7] chardev: Add disconnected
 option for chardev socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, elohimes@gmail.com, zhangyu31@baidu.com, xieyongji@baidu.com, Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, lilin24@baidu.com, Yury Kotov <yury-kotov@yandex-team.ru>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, chaiwen@baidu.com, nixun@baidu.com

On Tue, Dec 18, 2018 at 11:02:46AM -0500, Michael S. Tsirkin wrote:
> On Tue, Dec 18, 2018 at 03:25:20PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > On Tue, Dec 18, 2018 at 04:24:26PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Hi
> > >=20
> > > On Tue, Dec 18, 2018 at 2:01 PM <elohimes@gmail.com> wrote:
> > > >
> > > > From: Xie Yongji <xieyongji@baidu.com>
> > > >
> > > > New option "disconnected" is added to init the chardev socket
> > > > in disconnected state. Then we can use qemu_chr_fe_wait_connected=
()
> > > > to connect when necessary. Now it would be used for unix domain
> > > > socket of vhost-user-blk device to support reconnect.
> > >=20
> > > What difference does that make if you wait for connection in
> > > qemu_chr_fe_wait_connected(), or during chardev setup?
> > >=20
> > > "disconnected" is misleading, would it be possible to reuse
> > > "wait/nowait" instead?
> >=20
> > Currently we default to doing a blocking connect in foreground,
> > except if reconnect is non-zero, in which case we do a connect
> > async in the background. This "disconnected" proposal effectively
> > does a blocking connect, but delayed to later in startup.
> >=20
> > IOW, this could already be achieved if "reconnect" were set to
> > non-zero. If the usage doesn't want reconnect though, I tend
> > to agree that we should use the exisiting wait/nowait options
> > to let it be controlled. I don't see that this "disconnected"
> > option gives a compelling benefit over using wait/nowait.
>=20
> So the tricky thing is that we can not expose the
> device to guest until we get a connection and can query
> it for the first time. After that is completed,
> we can reasonably support disconnected operation at least for net.

The device code would still use  qemu_chr_fe_wait_connected() in my propo=
sal,
so that its no different to the situation with the proposed "disconnected=
"
flag.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
