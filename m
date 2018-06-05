Received: from eggs.gnu.org ([2001:4830:134:3::10]:51341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQEPA-0006Rl-FS
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQEP7-00010n-Cl
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:01:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52654 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQEP7-000101-87
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:01:49 -0400
Date: Tue, 5 Jun 2018 17:01:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180605160145.GS32286@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<53c37321-52d2-732c-19fb-8f6a9542c714@gmail.com>
	<20180605132948.GH32286@redhat.com>
	<0952e6da-a75f-914a-857e-40a6704cad33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0952e6da-a75f-914a-857e-40a6704cad33@gmail.com>
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
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Tue, Jun 05, 2018 at 06:56:09PM +0300, Marcel Apfelbaum wrote:
>=20
>=20
> On 06/05/2018 04:29 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Jun 05, 2018 at 04:20:46PM +0300, Marcel Apfelbaum wrote:
> > >=20
> > > On 06/05/2018 11:43 AM, Daniel P. Berrang=C3=A9 wrote:
> > > > On Tue, Jun 05, 2018 at 09:27:46AM +0200, Gerd Hoffmann wrote:
> > > > >     Hi,
> > > > >=20
> > > > > > >     Add to that shortcuts like -cdrom
> > > > > > > stop working,
> > > > > > Maybe is fixable.
> > > > > Already fixed for ages.
> > > > >=20
> > > > > > I see marking Q35 as the default machine a first step.
> > > > > Maybe the better option is to go the arm route:  Just don't def=
ine a
> > > > > default, so users have to specify pc or q35.  That will make th=
em notice
> > > > > there is a world beside 'pc', and we also avoid breaking things
> > > > > silently.
> > > It can work, sure. And we can add user hints: "Use q35 for ...., se=
lect pc
> > > if..."
> > >=20
> > > > If QEMU removes the default, then libvirt will have to hardcode
> > > > 'pc' as the default to maintain back compatibility, so I don't
> > > > think that ends up as a net win
> > > Can't libvirt preserve 'pc' for existing domains, while defaulting =
to q35
> > > the creation of new domains ? This way it aligns with Gerd's propos=
al of no
> > > default x86 machine.
> > Existing domains wasn't the case I was concerned about. Consider you =
have
> > libvirt 4.4.0 intsalled and you deploy a *new* domain from a prebuilt
> > disk image "foo".
>=20
> Using Laszlo idea (I think):
> =C2=A01) disk image "foo"/no info -> use 'pc' machine.
> =C2=A02) no prebuild image (clean install?) ->=C2=A0 use q35 and add th=
is info to xml

NB there's no reliable distinction of "new" from "old" guest install
from libvirt's POV. When we receive XML from an application we've
no way of knowing if this is a brand new guest about to be installed
or a previously installed guest.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
