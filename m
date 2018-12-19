Received: from eggs.gnu.org ([2001:4830:134:3::10]:37519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZdzK-0000WQ-Ht
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZdzH-0002Zn-0i
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:42:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZdzG-0002Xi-Ir
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:42:18 -0500
Date: Wed, 19 Dec 2018 10:42:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181219103112-mutt-send-email-mst@kernel.org>
References: <20181126124250.29985-2-marcandre.lureau@redhat.com>
	<20181210142956.wucn33osm7fxa27d@sirius.home.kraxel.org>
	<CAMxuvawUrZ=y-txTS86Tz3b-BYY05k4n-jBiY8+vO5e7AOkPKA@mail.gmail.com>
	<20181210183313-mutt-send-email-mst@kernel.org>
	<20181211074241.ovuharwewaw22ygq@sirius.home.kraxel.org>
	<20181211092944.GA921@redhat.com>
	<20181211135230-mutt-send-email-mst@kernel.org>
	<CAJ+F1CKuoWWxLqZKQRU-g_144jX2bwsQJUzeW0W-QicNrbPfQw@mail.gmail.com>
	<20181218181803-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJmT5O3x84upBDhvvCPCK5x51RP0TxBMsodLzVeQgC-vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJmT5O3x84upBDhvvCPCK5x51RP0TxBMsodLzVeQgC-vw@mail.gmail.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, maxime.coquelin@redhat.com

On Wed, Dec 19, 2018 at 12:01:59PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Wed, Dec 19, 2018 at 3:20 AM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> >
> > On Tue, Dec 18, 2018 at 10:35:05PM +0400, Marc-Andr=E9 Lureau wrote:
> > > Hi
> > >
> > > On Tue, Dec 11, 2018 at 10:56 PM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> > > >
> > > > On Tue, Dec 11, 2018 at 09:29:44AM +0000, Daniel P. Berrang=E9 wr=
ote:
> > > > > On Tue, Dec 11, 2018 at 08:42:41AM +0100, Hoffmann, Gerd wrote:
> > > > > >   Hi,
> > > > > >
> > > > > > > Right. The main issue is that we need to make sure only
> > > > > > > in-tree devices are supported.
> > > > > >
> > > > > > Well, that is under debate right now, see:
> > > > > > https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg0491=
2.html
> > > > >
> > > > > I've previously been against the idea of external plugins for Q=
EMU,
> > > > > however, that was when the plugin was something that would be d=
lopen'd
> > > > > by QEMU. That would cause our internal ABI to be exposed to 3rd=
 parties
> > > > > which is highly undesirable, even if they were open source to c=
omply
> > > > > with the license needs.
> > > > >
> > > > > When the plugin is a completely isolated process communicating =
with a
> > > > > well defined protocol, it is not placing a significant burden o=
n the
> > > > > QEMU developers' ongoing maintainence, nor has problems with li=
cense
> > > > > compliance. The main problem would come from debugging the comb=
ined
> > > > > system as the external process is essentially a black box from =
QEMU's
> > > > > POV. Downstream OS vendors are free to place restrictions on wh=
ich
> > > > > backend processes they'd be willing to support with QEMU, and u=
pstream
> > > > > is under no obligation to debug stuff beyond the QEMU boundary.
> > > > >
> > > > > We have already accepted that tradeoff with networking by suppo=
rting
> > > > > vhost-user and have externals impls like DPDK, so I don't see a
> > > > > compelling reason to try to restrict it for other vhost-user ba=
ckends.
> > > >
> > > > OK seems to be more or less a rough concensus then.
> > > >
> > > > I wonder what's the approach wrt migration though.
> > >
> > > The series doesn't take care of migration.
> > >
> > > >
> > > > Even the compatibility story about vhost-user isn't
> > > > great, I would like to see something solid before
> > > > we allow that.
> > >
> > > To allow migration? vhost-user has partial support for migration
> > > (dirty memory tracking), and there is also "[PATCH v2 for-4.0 0/7]
> > > vhost-user-blk: Add support for backend reconnecting" - allowing th=
e
> > > backend to store some state, if I understand correctly, which could=
 be
> > > leveraged I guess...
> > >
> > > But I don't think we should block this series because migration isn=
't
> > > tackled here.
> > >
> > > thanks
> > >
> > >
> > > .
> >
> > How about blocking migration for now then?
>=20
> The device here (vhost-user-input) blocks migration (unmigratable =3D 1=
)

Right. But that device is just an excersize, right?
It bothers me that next device might not remember and
we will get a mess.
Could we make it somehow that if there is no vmsd
then migration is blocked?


> >
> > We need someone to work on a solution for cross version/device
> > compatibility, vhost net/blk without that is bad enough but at least =
we
> > have a feature bits, for random devices it would be very very bad.
>=20
> For now, if migration is somehow supported, it must be handled mostly
> by the qemu device, and the vhost-user backend must track dirty memory
> and be "stateless": *able to reconnect & resume where it left off).
>=20
> A backend shouldn't declare VHOST_USER_PROTOCOL_F_LOG_SHMFD if it can't=
 do that.
>=20
> When a backend will have a state to migrate, we will have to implement
> a new feature. I assume that's what you are asking.

No, I am talking about a cross version/backend migration.

And it's such a boutique problem backends do not even
understand what it's about. A way to handle it
in the frontend is needed.

We also need a way to make sure incorrect backends do not
connect to incorrect devices, and we need a mechanism
that allows cross-version migration compatibility.

There's been a long discussion about cross-version
migration for vhost-user and I think Maxime had
a plan there. Maxime could you repost the
set of issues and what the plan is maybe?


> >
> >
> > > >
> > > > Are we happy to just block live migration?
> > > > For sure that's already the case with VFIO.
> > > >
> > > >
> > > > > > > vhost-user by design
> > > > > > > is for out of tree users. It needn't be hard,
> > > > > > > maybe it's enough to just make qemu launch these processes
> > > > > > > as opposed to connecting to them on command line.
> > > > > >
> > > > > > Not sure this is a good idea, with security being one of the =
motivating
> > > > > > factors to move device emulation to other processes.  When li=
bvirt
> > > > > > launches the processes it can place them in separate sandboxe=
s ...
> > > > >
> > > > > Yep, libvirt already turns on seccomp policies which forbid QEM=
U from
> > > > > forking/execing anything, and we have no desire to go backwards=
 here.
> > > > > Any external processes have to be launched by libvirt ahead of =
time.
> > > > >
> > > > >
> > > > > Regards,
> > > > > Daniel
> > > > > --
> > > > > |: https://berrange.com      -o-    https://www.flickr.com/phot=
os/dberrange :|
> > > > > |: https://libvirt.org         -o-            https://fstop138.=
berrange.com :|
> > > > > |: https://entangle-photo.org    -o-    https://www.instagram.c=
om/dberrange :|
> > > >
> > >
> > >
> > > --
> > > Marc-Andr=E9 Lureau
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
