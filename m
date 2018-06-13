Received: from eggs.gnu.org ([2001:4830:134:3::10]:46944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTA96-0005Mv-Nc
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTA93-0005iJ-IR
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:05:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTA93-0005f7-AF
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:05:21 -0400
Date: Wed, 13 Jun 2018 15:05:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613180508.GD24764@localhost.localdomain>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180605084300.GF32286@redhat.com>
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

Getting back to this discussion:

On Tue, Jun 05, 2018 at 09:43:00AM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Jun 05, 2018 at 09:27:46AM +0200, Gerd Hoffmann wrote:
> >   Hi,
> >=20
> > > >   Add to that shortcuts like -cdrom
> > > > stop working,
> > >=20
> > > Maybe is fixable.
> >=20
> > Already fixed for ages.
> >=20
> > > I see marking Q35 as the default machine a first step.
> >=20
> > Maybe the better option is to go the arm route:  Just don't define a
> > default, so users have to specify pc or q35.  That will make them not=
ice
> > there is a world beside 'pc', and we also avoid breaking things
> > silently.
>=20
> If QEMU removes the default, then libvirt will have to hardcode
> 'pc' as the default to maintain back compatibility, so I don't
> think that ends up as a net win

I believe there's consensus that applications blindly relying on
the default machine-type when creating a domain is a bad idea.

That said, can we deprecate this feature in libvirt, encourage
applications to always specify an explicit machine-type, thus
making it possible to deprecate the i440fx machine-types one day?

--=20
Eduardo
