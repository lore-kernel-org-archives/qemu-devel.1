Received: from eggs.gnu.org ([2001:4830:134:3::10]:38698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fPsfA-0003HP-Ts
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 12:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fPsf7-0004oW-J8
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 12:48:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fPsf7-0004o8-DF
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 12:48:53 -0400
Date: Mon, 4 Jun 2018 19:48:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180604194500-mutt-send-email-mst@kernel.org>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<20180604125415.GN7451@localhost.localdomain>
	<20180604130129.GG19749@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180604130129.GG19749@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

On Mon, Jun 04, 2018 at 02:01:29PM +0100, Daniel P. Berrang=E9 wrote:
> On Mon, Jun 04, 2018 at 09:54:15AM -0300, Eduardo Habkost wrote:
> > On Mon, Jun 04, 2018 at 04:38:22AM +0300, Michael S. Tsirkin wrote:
> > > On Sun, Jun 03, 2018 at 12:27:49PM +0300, Marcel Apfelbaum wrote:
> > > > Moving to QEMU 3.0 seems like a good opportunity for such a chang=
e.
> > > >=20
> > > > I440FX is really old and does not support modern features like IO=
MMU.
> > > > Q35's SATA emulation is faster than pc's IDE, native PCI express =
hotplug
> > > > is cleaner than ACPI based one and so on...
> > > >=20
> > > > Also the libvirt guys added very good support for the Q35 machine=
 (thanks!).
> > > >=20
> > > > Management software should always specify the machine type and fo=
r the
> > > > current setups, adding '-machine pc' to the command line is not s=
uch a
> > > > big deal.
> > > >=20
> > > > In time the pc machine will fade out and we will probably stop ad=
ding
> > > > new versions at some point.
> > > >=20
> > > > Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > >=20
> > > For command line users, I think changing the default isn't nice.
> > >=20
> > > Yes it's easy to add -machine pc but there's no documentation
> > > that tells you to do so. Add to that shortcuts like -cdrom
> > > stop working, hotplug needs extra bridges to work, and one
> > > can see that while management tool users benefit from q35,
> > > command line users will suffer.
> > >=20
> > > Can't we add a tag for management without changing the command line
> > > default? How about "management-default"? "recommended"? "latest"?
> >=20
> > We could add new aliases if they are useful for management
> > software, but we would need a well-defined use case and set of
> > requirements+expectations for the new alias.
>=20
> I'm not convinced by the idea of adding a distinct default "for mgmt". =
All
> the problems described wrt 'q35' vs 'pc' apply equally to management ap=
ps
> as they do to humans. It just happens that one common mgmt layer (libvi=
rt)
> knows how to handle some of the complexity of q35. Other mgmt apps thou=
gh
> are just as likely to be hurt by the change as humans are. So effective=
ly
> the proposed "for mgmt" is actually  "for libvirt >=3D some version", w=
hich
> feels like a layering violation to me.
>=20
> Regards,
> Daniel

Is libvirt happy to just hard-code q35 for now then?

> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
