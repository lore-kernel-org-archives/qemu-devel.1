Received: from eggs.gnu.org ([2001:4830:134:3::10]:37195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gP4Yw-0000xf-Ar
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gP4Yt-0004r6-4y
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:51:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gP4Ys-0004pw-Rn
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:51:23 -0500
Date: Tue, 20 Nov 2018 09:51:02 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181120115102.GE4755@habkost.net>
References: <20181114233831.10374-1-ehabkost@redhat.com>
	<20181115100559.GE10900@redhat.com>
	<20181115115056.65cf3659.cohuck@redhat.com>
	<20181120004454.GA4755@habkost.net>
	<20181120115227.41ad1f88.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181120115227.41ad1f88.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, Andrea Bolognani <abologna@redhat.com>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Tue, Nov 20, 2018 at 11:52:27AM +0100, Cornelia Huck wrote:
> On Mon, 19 Nov 2018 22:44:54 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Thu, Nov 15, 2018 at 11:50:56AM +0100, Cornelia Huck wrote:
> > > On Thu, 15 Nov 2018 10:05:59 +0000
> > > Daniel P. Berrang=E9 <berrange@redhat.com> wrote:
>=20
> > > > If libvirt did this compatibility approach, can you
> > > > confirm this would be live migration state compatible.
> > > >=20
> > > > ie can live migrate virtio-*-pci -> virtio-*-pci-transitional,
> > > > provided only PCI bus was used. =20
> > >=20
> > > It also needs to make sure that neither disable-legacy nor
> > > disable-modern is set. Then this would have a compatible state AFAI=
CS.
> > >  =20
> > > >  =20
> > > > > - virtio-*-pci-non-transitional: modern-only
> > > > >   - Supports both Conventional PCI and PCI Express buses   =20
> > > >=20
> > > > IIUC, libvirt can again provide compatibility with old
> > > > QEMU by simply using the existing device type and setting
> > > > disable-legacy ?  Can you confirm this would be live
> > > > migration compatible
> > > >=20
> > > >   virtio-*-pci + disable-legacy -> virtio-*pci-non-transitional =20
> > >=20
> > > I think yes. =20
> >=20
> > This is exactly how it is implemented internally, but I'm not
> > promising that this will be kept compatible forever.  And I
> > wouldn't like to make that promise unless there's an important
> > use case for that.
>=20
> Shouldn't we be able to ensure compatibility by normal virtio feature
> bit handling, as we have already done in the past?

Ensuring compatibility is possible, and even likely.  I just want
to avoid spending effort keeping such a promise unless it's
really necessary.

>=20
> >=20
> > We could easily ensure it will be compatible in pc-4.0 and older,
> > though.  Would that be enough for the use case we have in mind?
> >=20
>=20

--=20
Eduardo
