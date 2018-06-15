Received: from eggs.gnu.org ([2001:4830:134:3::10]:41690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTkdd-0007Hk-KZ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTkda-0002G9-FH
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:03:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fTkda-0002Fp-9t
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:03:18 -0400
Date: Fri, 15 Jun 2018 10:03:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180615090314.GA31552@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<20180613180508.GD24764@localhost.localdomain>
	<20180614080948.GF6355@redhat.com>
	<20180615025056.GB7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615025056.GB7451@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, libvir-list@redhat.com

On Thu, Jun 14, 2018 at 11:50:56PM -0300, Eduardo Habkost wrote:
> On Thu, Jun 14, 2018 at 09:09:48AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Wed, Jun 13, 2018 at 03:05:08PM -0300, Eduardo Habkost wrote:
> > > Getting back to this discussion:
> > >=20
> > > On Tue, Jun 05, 2018 at 09:43:00AM +0100, Daniel P. Berrang=C3=A9 w=
rote:
> > > > On Tue, Jun 05, 2018 at 09:27:46AM +0200, Gerd Hoffmann wrote:
> > > > >   Hi,
> > > > >=20
> > > > > > >   Add to that shortcuts like -cdrom
> > > > > > > stop working,
> > > > > >=20
> > > > > > Maybe is fixable.
> > > > >=20
> > > > > Already fixed for ages.
> > > > >=20
> > > > > > I see marking Q35 as the default machine a first step.
> > > > >=20
> > > > > Maybe the better option is to go the arm route:  Just don't def=
ine a
> > > > > default, so users have to specify pc or q35.  That will make th=
em notice
> > > > > there is a world beside 'pc', and we also avoid breaking things
> > > > > silently.
> > > >=20
> > > > If QEMU removes the default, then libvirt will have to hardcode
> > > > 'pc' as the default to maintain back compatibility, so I don't
> > > > think that ends up as a net win
> > >=20
> > > I believe there's consensus that applications blindly relying on
> > > the default machine-type when creating a domain is a bad idea.
> > >=20
> > > That said, can we deprecate this feature in libvirt, encourage
> > > applications to always specify an explicit machine-type, thus
> > > making it possible to deprecate the i440fx machine-types one day?
> >=20
> > Well from libvirt's POV this scenario arrives if a mgmt app simply om=
its
> > the relevant element/attribute from the XML config. Deprecating somet=
hing
> > implies that in future we'd drop support for it, but we're never goin=
g
> > to make this mandatory in libvirt as that would be a regression in
> > behaviour from libvirt's POV. So I don't think it is something we wou=
ld
> > deprecate.
>=20
> Does libvirt really have an option, here?  I'm sure that sooner
> or later somebody will distribute QEMU binaries without "pc".

Sure if someone does that, we'll have no choice, but as long as 'pc' is
shipped we shouldn't gratuitously break apps by changing the default.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
