Received: from eggs.gnu.org ([209.51.188.92]:43243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ggrN0-0001QU-3H
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ggrMx-0007JG-SJ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:24:38 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ggrMx-0005Od-IV
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:24:35 -0500
Received: by mail-wr1-x441.google.com with SMTP id t27so4027807wra.6
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 05:23:59 -0800 (PST)
MIME-Version: 1.0
References: <CAMxuvawUrZ=y-txTS86Tz3b-BYY05k4n-jBiY8+vO5e7AOkPKA@mail.gmail.com>
	<20181210183313-mutt-send-email-mst@kernel.org>
	<20181211074241.ovuharwewaw22ygq@sirius.home.kraxel.org>
	<20181211092944.GA921@redhat.com>
	<20181211135230-mutt-send-email-mst@kernel.org>
	<CAJ+F1CKuoWWxLqZKQRU-g_144jX2bwsQJUzeW0W-QicNrbPfQw@mail.gmail.com>
	<20181218181803-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJmT5O3x84upBDhvvCPCK5x51RP0TxBMsodLzVeQgC-vw@mail.gmail.com>
	<20181219103112-mutt-send-email-mst@kernel.org>
	<CAJ+F1CLKftEt8g5WyW8NPOPNsKPXhNnS3BkdVqjrny4cjb+kWw@mail.gmail.com>
	<20181220113338-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181220113338-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 8 Jan 2019 17:23:45 +0400
Message-ID: <CAJ+F1CK1jeJgk07TXwHWpZLhO59Rrf7gSfpB6=J-NO+sYFfwpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 01/11] vhost-user: define
 conventions for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>

Hi

On Thu, Dec 20, 2018 at 8:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Dec 20, 2018 at 04:40:55PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Dec 19, 2018 at 7:42 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Wed, Dec 19, 2018 at 12:01:59PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi
> > > >
> > > > On Wed, Dec 19, 2018 at 3:20 AM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> > > > >
> > > > > On Tue, Dec 18, 2018 at 10:35:05PM +0400, Marc-Andr=C3=A9 Lureau =
wrote:
> > > > > > Hi
> > > > > >
> > > > > > On Tue, Dec 11, 2018 at 10:56 PM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > > > > > >
> > > > > > > On Tue, Dec 11, 2018 at 09:29:44AM +0000, Daniel P. Berrang=
=C3=A9 wrote:
> > > > > > > > On Tue, Dec 11, 2018 at 08:42:41AM +0100, Hoffmann, Gerd wr=
ote:
> > > > > > > > >   Hi,
> > > > > > > > >
> > > > > > > > > > Right. The main issue is that we need to make sure only
> > > > > > > > > > in-tree devices are supported.
> > > > > > > > >
> > > > > > > > > Well, that is under debate right now, see:
> > > > > > > > > https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg=
04912.html
> > > > > > > >
> > > > > > > > I've previously been against the idea of external plugins f=
or QEMU,
> > > > > > > > however, that was when the plugin was something that would =
be dlopen'd
> > > > > > > > by QEMU. That would cause our internal ABI to be exposed to=
 3rd parties
> > > > > > > > which is highly undesirable, even if they were open source =
to comply
> > > > > > > > with the license needs.
> > > > > > > >
> > > > > > > > When the plugin is a completely isolated process communicat=
ing with a
> > > > > > > > well defined protocol, it is not placing a significant burd=
en on the
> > > > > > > > QEMU developers' ongoing maintainence, nor has problems wit=
h license
> > > > > > > > compliance. The main problem would come from debugging the =
combined
> > > > > > > > system as the external process is essentially a black box f=
rom QEMU's
> > > > > > > > POV. Downstream OS vendors are free to place restrictions o=
n which
> > > > > > > > backend processes they'd be willing to support with QEMU, a=
nd upstream
> > > > > > > > is under no obligation to debug stuff beyond the QEMU bound=
ary.
> > > > > > > >
> > > > > > > > We have already accepted that tradeoff with networking by s=
upporting
> > > > > > > > vhost-user and have externals impls like DPDK, so I don't s=
ee a
> > > > > > > > compelling reason to try to restrict it for other vhost-use=
r backends.
> > > > > > >
> > > > > > > OK seems to be more or less a rough concensus then.
> > > > > > >
> > > > > > > I wonder what's the approach wrt migration though.
> > > > > >
> > > > > > The series doesn't take care of migration.
> > > > > >
> > > > > > >
> > > > > > > Even the compatibility story about vhost-user isn't
> > > > > > > great, I would like to see something solid before
> > > > > > > we allow that.
> > > > > >
> > > > > > To allow migration? vhost-user has partial support for migratio=
n
> > > > > > (dirty memory tracking), and there is also "[PATCH v2 for-4.0 0=
/7]
> > > > > > vhost-user-blk: Add support for backend reconnecting" - allowin=
g the
> > > > > > backend to store some state, if I understand correctly, which c=
ould be
> > > > > > leveraged I guess...
> > > > > >
> > > > > > But I don't think we should block this series because migration=
 isn't
> > > > > > tackled here.
> > > > > >
> > > > > > thanks
> > > > > >
> > > > > >
> > > > > > .
> > > > >
> > > > > How about blocking migration for now then?
> > > >
> > > > The device here (vhost-user-input) blocks migration (unmigratable =
=3D 1)
> > >
> > > Right. But that device is just an excersize, right?
> >
> > Mostly
> >
> > > It bothers me that next device might not remember and
> > > we will get a mess.
> >
> > The next device (the one I care most about) is vhost-user-gpu.
> >
> > > Could we make it somehow that if there is no vmsd
> > > then migration is blocked?
> >
> > Where would you do that? in DeviceClass? That might break other
> > devices, needs code review. In VirtIODevice? that would be probably
> > simpler.
>
> In vhost user core somehow?

I suppose something like that:

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index d51d1087f6..5680dc5d8e 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1470,12 +1470,16 @@ static int vhost_user_backend_init(struct
vhost_dev *dev, void *opaque)
         }
     }

-    if (dev->migration_blocker =3D=3D NULL &&
-        !virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_LOG_SHMFD)) {
-        error_setg(&dev->migration_blocker,
-                   "Migration disabled: vhost-user backend lacks "
-                   "VHOST_USER_PROTOCOL_F_LOG_SHMFD feature.");
+    if (dev->migration_blocker =3D=3D NULL) {
+        if (!virtio_has_feature(dev->protocol_features,
+                                VHOST_USER_PROTOCOL_F_LOG_SHMFD)) {
+            error_setg(&dev->migration_blocker,
+                       "Migration disabled: vhost-user backend lacks "
+                       "VHOST_USER_PROTOCOL_F_LOG_SHMFD feature.");
+        } else if (!qdev_get_vmsd(DEVICE(dev->vdev))) {
+            error_setg(&dev->migration_blocker,
+                       "Migration disabled: vhost-user device lacks VMSD")=
;
+        }
     }

Unfortunately, vdev is not set before vhost_dev_start().

We could add the migration blocker there somehow? There is no
dedicated backend callback for that (I don't think set_features(),
set_mem_table()  etc are good places..)

Looking for help here, this is currently blocking me on
vhost-user-input/vhost-user-gpu.

--=20
Marc-Andr=C3=A9 Lureau
