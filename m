Received: from eggs.gnu.org ([2001:4830:134:3::10]:59213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gOwcx-0001ZF-Se
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 22:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gOwcm-00065R-0Z
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 22:23:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gOwck-0005sj-Jq
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 22:22:51 -0500
Date: Tue, 20 Nov 2018 01:22:22 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181120032222.GC4755@habkost.net>
References: <20181114233831.10374-1-ehabkost@redhat.com>
	<c1b4a0ee39dfddeb19f1be46710c10cbefd3f07a.camel@redhat.com>
	<20181116034551.GK3807@habkost.net>
	<20181119114105.4da89f2c.cohuck@redhat.com>
	<20181119125519-mutt-send-email-mst@kernel.org>
	<20181119214740.GF3807@habkost.net>
	<20181119215822-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119215822-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Mon, Nov 19, 2018 at 10:08:42PM -0500, Michael S. Tsirkin wrote:
> On Mon, Nov 19, 2018 at 07:47:40PM -0200, Eduardo Habkost wrote:
> > On Mon, Nov 19, 2018 at 01:07:59PM -0500, Michael S. Tsirkin wrote:
> > n
> > > On Mon, Nov 19, 2018 at 11:41:05AM +0100, Cornelia Huck wrote:
> > > > On Fri, 16 Nov 2018 01:45:51 -0200
> > > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > >=20
> > > > > On Thu, Nov 15, 2018 at 05:29:24PM +0100, Andrea Bolognani wrot=
e:
> > > >=20
> > > > > > One thing that I'm very much not convinced about is the namin=
g,
> > > > > > specifically leaving the virtio revision out: I get it that w=
e
> > > > > > Should Never Need=E2=84=A2 another major version of the spec,=
 but I'm
> > > > > > afraid discounting the possibility outright might prove to be
> > > > > > shortsighted and come back to bite us later, so I'd much rath=
er
> > > > > > keep it.
> > >=20
> > > That's not the claim. In fact the reverse is true - a major revisio=
n can
> > > come at any point. The claim is that virtio compatibility is not ba=
sed
> > > on version numbers.  And another claim is that you can trust the
> > > virtio TC not to overload terminology that it put in the spec. So u=
se
> > > that and you should be fine.  Come up with your own and end up writ=
ing
> > > another spec just to document it.
> > >=20
> > > > > >=20
> > > > > > And once that's done, "non-transitional" (while matching the
> > > > > > language of the spec) starts to look a bit unnecessary when y=
ou
> > > > > > could simply have
> > > > > >=20
> > > > > >   virtio-*-pci
> > > > > >   virtio-*-pci-1
> > > > > >   virtio-*-pci-1-transitional
> > > > > >=20
> > > > > > instead. But I don't feel as strongly about this as I do abou=
t
> > > > > > keeping the virtio revision in the device name :) =20
> > > > >=20
> > > > > I like that suggestion.  Makes the device names more explicit
> > > > > _and_ shorter.  I'll do that in v3.
> > > >=20
> > > > OTOH, that would mean we'd need to introduce new device types if =
we
> > > > ever start to support a virtio 2.x standard. My understanding was=
 that
> > > > we'll want separate device types for transitional and non-transit=
ional
> > > > for two reasons: the bus which a device can be plugged into, and
> > > > changing ids. Do we really expect huge changes in a possible 2.x
> > > > standard that affect virtio-pci only, and not other virtio transp=
orts
> > > > as well?
> > >=20
> > > Yes I think adding a version there is a mistake.
> > > transitional/legacy/non-transitional are spec terms so
> > > they are unlikely to change abruptly. OTOH virtio TC can
> > > just decide next version is 2.0 on a drop of a hat.
> > >=20
> > > And I strongly believe command line users really really do not want=
 all
> > > this mess. Even adding "pci" is the name confuses people (what are =
the
> > > other options?). For command line model=3Dvirtio is pretty much per=
fect.
> > > So all these names are there primarily for libvirt's benefit.
> > > And the only input from libvirt devs so far
> > > has been that it's unclear how does cross version
> > > migration work. That needs to be addressed in some way.
> >=20
> > What still needs to be addressed?
>=20
> I don't belive you answered Daniel's question.
>=20
> >  Just keep the existing device
> > types on migration.  We could make additional promises about
> > compatibility with the disable-modern and disable-legacy
> > properties, but I don't see why we need to do it unless we start
> > deprecating the old device types.
>=20
> Then the answer seems to be in the negative?

If the question is about the current state, it's "yes".  If it's
about promises about the future, then we need to understand what
kind of promise is expected.


> > >=20
> > > So can we maybe start with a libvirt domain xml patch, with an
> > > implementation for existing QEMU, get that acked, and then just map=
 it
> > > back to qemu command line as directly as possible?
> >=20
> > I don't know what you mean here by "libvirt domain XML patch".
> >=20
> > Do you mean solving the problems only on the libvirt side,
> > keeping the existing device types?  Why would we do that?  It
> > would be a hack making the situation even messier.
> >=20
> > If libvirt needs us to provide better interfaces, let's cooperate
> > with them.  I'd like us to avoid having yet another "the problem
> > must be solved in the other layer first" deadlock here.
>=20
> I mean IIUC libvirt is the solve user that will benefit from this patch=
.
> Let's at least get an ack confirming it does make their lives easier.

I understand this as an ACK;
https://www.mail-archive.com/qemu-devel@nongnu.org/msg567161.html

Quoted below:

| I don't have a objection from libvirt side.
|=20
| Last time, I suggested/discussed this I was not convinced that the bene=
fit
| was compelling enough to justify the  work across all levels in the sta=
ck.
|=20
| Apps using the new device model names would either make themselves
| incompatible with older libvirt/QEMU, or they would increase their
| code complexity & testing matrix by having to support both old & new
| names. The usage would also harm migration to older hosts.
|=20
| This just to be able to switch from i440fx to q35 for OS which don't
| support virtio-1.0, but for such old OS, q35 isn't offering any
| compelling features, so they might as well stick with the thing that
| is known to work well.
|=20
| If QEMU supports this, we'd support it in libvirt, but my recommendatio=
n
| to apps would still likely be to not use it and simply stick with i440f=
x
| for such older OS.

Re: making their lives easier: easier than what?

--=20
Eduardo
