Received: from eggs.gnu.org ([2001:4830:134:3::10]:49392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2wec-0002QU-TY
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2weZ-00044G-Qr
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:53:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e2weZ-00043P-Kd
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:53:15 -0400
Date: Fri, 13 Oct 2017 11:53:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171013115310.4bd17776.cohuck@redhat.com>
In-Reply-To: <20171013094400.GD20515@redhat.com>
References: <afc33ce4-c9ab-9b35-38ec-80b16642ef00@weilnetz.de>
	<20171013113708.2dd02a17.cohuck@redhat.com>
	<20171013094400.GD20515@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] German BSI analysed security of KVM / QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, QEMU Developer <qemu-devel@nongnu.org>

On Fri, 13 Oct 2017 10:44:00 +0100
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> On Fri, Oct 13, 2017 at 11:37:08AM +0200, Cornelia Huck wrote:
> > On Fri, 13 Oct 2017 11:10:05 +0200
> > Stefan Weil <sw@weilnetz.de> wrote:
> >  =20
> > > Hi,
> > >=20
> > > the German Bundesamt f=C3=BCr Sicherheit in der Informationstechnik
> > > (Federal Office for Information Security) published a study on
> > > the security of KVM and QEMU:
> > >=20
> > > https://www.bsi.bund.de/DE/Publikationen/Studien/Sicherheitsanalyse_K=
VM/sicherheitsanalyse_kvm.html
> > >=20
> > > (article only available in German) =20
> >=20
> > Thanks for posting this!
> >=20
> > I only looked at the conclusion for now. Some interesting points:
> >=20
> > - They state that QEMU's source code is well structured, readable and
> >   maintainable. I wonder what kind of source code they usually deal
> >   with ;) =20
>=20
> Most closed source apps are worse than even badly structured open
> source code IME ;-)

Ha, that's true from my experience as well ;)

>=20
> > - Most problems noted seemed to be related to signed<->unsigned
> >   conversions, but none were found to be exploitable.
> > - They liked hardening via stack protection, NX, and ASLR, as well as
> >   the mechanisms used by libvirt.
> > - They generally seemed to be happy with QEMU being deployed via
> >   libvirt.
> > - Restrictions imposed via KVM (guest access to some CPU registers)
> >   scored positive points. They did not like that Hyper-V and PMU were
> >   not deconfigurable.
> > - Lack of support for encryption/signing of network-based images was
> >   criticized. They ended up using Ceph and GlusterFS, which they were
> >   reasonably happy with. =20
>=20
> Hopefully the 'luks' driver (which can be layered over any block backend
> including network ones), and the TLS support for NBD would be considered
> to address this last point to some degree. At least from the encryption
> side.
>=20
> Signing of disk images is impractical as it would imply having to download
> the entire image contents to validate signature, rather defeating the poi=
nt
> of having a network based image. But perhaps this is lost in translation
> and they mean something else by "signing of images" ?

Could be my bad translation (they talk about "Verschl=C3=BCsselung und
Signierung"), but I haven't looked what they actually tried to
accomplish.
