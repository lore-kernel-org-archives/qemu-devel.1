Received: from eggs.gnu.org ([2001:4830:134:3::10]:47299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZWoG-0004ZA-JK
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZWoA-0000x4-J9
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:02:28 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gZWo1-0000o8-QB
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:02:15 -0500
Received: by mail-wr1-x443.google.com with SMTP id l9so18413585wrt.13
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 00:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20181126124250.29985-1-marcandre.lureau@redhat.com>
	<20181126124250.29985-2-marcandre.lureau@redhat.com>
	<20181210142956.wucn33osm7fxa27d@sirius.home.kraxel.org>
	<CAMxuvawUrZ=y-txTS86Tz3b-BYY05k4n-jBiY8+vO5e7AOkPKA@mail.gmail.com>
	<20181210183313-mutt-send-email-mst@kernel.org>
	<20181211074241.ovuharwewaw22ygq@sirius.home.kraxel.org>
	<20181211092944.GA921@redhat.com>
	<20181211135230-mutt-send-email-mst@kernel.org>
	<CAJ+F1CKuoWWxLqZKQRU-g_144jX2bwsQJUzeW0W-QicNrbPfQw@mail.gmail.com>
	<20181218181803-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181218181803-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 19 Dec 2018 12:01:59 +0400
Message-ID: <CAJ+F1CJmT5O3x84upBDhvvCPCK5x51RP0TxBMsodLzVeQgC-vw@mail.gmail.com>
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Hi

On Wed, Dec 19, 2018 at 3:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Dec 18, 2018 at 10:35:05PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Dec 11, 2018 at 10:56 PM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > >
> > > On Tue, Dec 11, 2018 at 09:29:44AM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> > > > On Tue, Dec 11, 2018 at 08:42:41AM +0100, Hoffmann, Gerd wrote:
> > > > >   Hi,
> > > > >
> > > > > > Right. The main issue is that we need to make sure only
> > > > > > in-tree devices are supported.
> > > > >
> > > > > Well, that is under debate right now, see:
> > > > > https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04912.ht=
ml
> > > >
> > > > I've previously been against the idea of external plugins for QEMU,
> > > > however, that was when the plugin was something that would be dlope=
n'd
> > > > by QEMU. That would cause our internal ABI to be exposed to 3rd par=
ties
> > > > which is highly undesirable, even if they were open source to compl=
y
> > > > with the license needs.
> > > >
> > > > When the plugin is a completely isolated process communicating with=
 a
> > > > well defined protocol, it is not placing a significant burden on th=
e
> > > > QEMU developers' ongoing maintainence, nor has problems with licens=
e
> > > > compliance. The main problem would come from debugging the combined
> > > > system as the external process is essentially a black box from QEMU=
's
> > > > POV. Downstream OS vendors are free to place restrictions on which
> > > > backend processes they'd be willing to support with QEMU, and upstr=
eam
> > > > is under no obligation to debug stuff beyond the QEMU boundary.
> > > >
> > > > We have already accepted that tradeoff with networking by supportin=
g
> > > > vhost-user and have externals impls like DPDK, so I don't see a
> > > > compelling reason to try to restrict it for other vhost-user backen=
ds.
> > >
> > > OK seems to be more or less a rough concensus then.
> > >
> > > I wonder what's the approach wrt migration though.
> >
> > The series doesn't take care of migration.
> >
> > >
> > > Even the compatibility story about vhost-user isn't
> > > great, I would like to see something solid before
> > > we allow that.
> >
> > To allow migration? vhost-user has partial support for migration
> > (dirty memory tracking), and there is also "[PATCH v2 for-4.0 0/7]
> > vhost-user-blk: Add support for backend reconnecting" - allowing the
> > backend to store some state, if I understand correctly, which could be
> > leveraged I guess...
> >
> > But I don't think we should block this series because migration isn't
> > tackled here.
> >
> > thanks
> >
> >
> > .
>
> How about blocking migration for now then?

The device here (vhost-user-input) blocks migration (unmigratable =3D 1)

>
> We need someone to work on a solution for cross version/device
> compatibility, vhost net/blk without that is bad enough but at least we
> have a feature bits, for random devices it would be very very bad.

For now, if migration is somehow supported, it must be handled mostly
by the qemu device, and the vhost-user backend must track dirty memory
and be "stateless": *able to reconnect & resume where it left off).

A backend shouldn't declare VHOST_USER_PROTOCOL_F_LOG_SHMFD if it can't do =
that.

When a backend will have a state to migrate, we will have to implement
a new feature. I assume that's what you are asking.

>
>
> > >
> > > Are we happy to just block live migration?
> > > For sure that's already the case with VFIO.
> > >
> > >
> > > > > > vhost-user by design
> > > > > > is for out of tree users. It needn't be hard,
> > > > > > maybe it's enough to just make qemu launch these processes
> > > > > > as opposed to connecting to them on command line.
> > > > >
> > > > > Not sure this is a good idea, with security being one of the moti=
vating
> > > > > factors to move device emulation to other processes.  When libvir=
t
> > > > > launches the processes it can place them in separate sandboxes ..=
.
> > > >
> > > > Yep, libvirt already turns on seccomp policies which forbid QEMU fr=
om
> > > > forking/execing anything, and we have no desire to go backwards her=
e.
> > > > Any external processes have to be launched by libvirt ahead of time=
.
> > > >
> > > >
> > > > Regards,
> > > > Daniel
> > > > --
> > > > |: https://berrange.com      -o-    https://www.flickr.com/photos/d=
berrange :|
> > > > |: https://libvirt.org         -o-            https://fstop138.berr=
ange.com :|
> > > > |: https://entangle-photo.org    -o-    https://www.instagram.com/d=
berrange :|
> > >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau
