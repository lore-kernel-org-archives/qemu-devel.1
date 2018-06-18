Received: from eggs.gnu.org ([2001:4830:134:3::10]:58942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fUxjp-0001uW-BM
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fUxjl-0006kW-9o
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:14:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fUxjl-0006k6-0q
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:14:41 -0400
Date: Mon, 18 Jun 2018 14:14:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180618171431.GK7451@localhost.localdomain>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<20180613180508.GD24764@localhost.localdomain>
	<20180614080948.GF6355@redhat.com>
	<20180615025056.GB7451@localhost.localdomain>
	<20180615090314.GA31552@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180615090314.GA31552@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, libvir-list@redhat.com

On Fri, Jun 15, 2018 at 10:03:14AM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Jun 14, 2018 at 11:50:56PM -0300, Eduardo Habkost wrote:
> > On Thu, Jun 14, 2018 at 09:09:48AM +0100, Daniel P. Berrang=E9 wrote:
> > > On Wed, Jun 13, 2018 at 03:05:08PM -0300, Eduardo Habkost wrote:
> > > > Getting back to this discussion:
> > > >=20
> > > > On Tue, Jun 05, 2018 at 09:43:00AM +0100, Daniel P. Berrang=E9 wr=
ote:
> > > > > On Tue, Jun 05, 2018 at 09:27:46AM +0200, Gerd Hoffmann wrote:
> > > > > >   Hi,
> > > > > >=20
> > > > > > > >   Add to that shortcuts like -cdrom
> > > > > > > > stop working,
> > > > > > >=20
> > > > > > > Maybe is fixable.
> > > > > >=20
> > > > > > Already fixed for ages.
> > > > > >=20
> > > > > > > I see marking Q35 as the default machine a first step.
> > > > > >=20
> > > > > > Maybe the better option is to go the arm route:  Just don't d=
efine a
> > > > > > default, so users have to specify pc or q35.  That will make =
them notice
> > > > > > there is a world beside 'pc', and we also avoid breaking thin=
gs
> > > > > > silently.
> > > > >=20
> > > > > If QEMU removes the default, then libvirt will have to hardcode
> > > > > 'pc' as the default to maintain back compatibility, so I don't
> > > > > think that ends up as a net win
> > > >=20
> > > > I believe there's consensus that applications blindly relying on
> > > > the default machine-type when creating a domain is a bad idea.
> > > >=20
> > > > That said, can we deprecate this feature in libvirt, encourage
> > > > applications to always specify an explicit machine-type, thus
> > > > making it possible to deprecate the i440fx machine-types one day?
> > >=20
> > > Well from libvirt's POV this scenario arrives if a mgmt app simply =
omits
> > > the relevant element/attribute from the XML config. Deprecating som=
ething
> > > implies that in future we'd drop support for it, but we're never go=
ing
> > > to make this mandatory in libvirt as that would be a regression in
> > > behaviour from libvirt's POV. So I don't think it is something we w=
ould
> > > deprecate.
> >=20
> > Does libvirt really have an option, here?  I'm sure that sooner
> > or later somebody will distribute QEMU binaries without "pc".
>=20
> Sure if someone does that, we'll have no choice, but as long as 'pc' is
> shipped we shouldn't gratuitously break apps by changing the default.

Right.  I just want to make sure "omitting the machine-type may
stop working in the future" is documented somehow.

--=20
Eduardo
