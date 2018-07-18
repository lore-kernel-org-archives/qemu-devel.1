Received: from eggs.gnu.org ([2001:4830:134:3::10]:47355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffmpP-0004pE-VN
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffmpL-00067W-0x
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:49:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ffmpK-00067K-PL
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:49:10 -0400
Date: Wed, 18 Jul 2018 10:49:02 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180718134902.GY31657@localhost.localdomain>
References: <CANhJxzwZny93TOTKTpEoThN8bnw1tXENPH_S60wczUAQodBMNw@mail.gmail.com>
	<20180718095034.GJ9812@redhat.com>
	<20180718101844.GB22954@antique-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180718101844.GB22954@antique-laptop>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] CPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Hrdina <phrdina@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Hetz Ben Hamo <hetz@hetz.biz>, qemu-devel@nongnu.org, libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Babu Moger <babu.moger@amd.com>, Brijesh Singh <brijesh.singh@amd.com>

CCing the AMD people who worked on this.

On Wed, Jul 18, 2018 at 12:18:45PM +0200, Pavel Hrdina wrote:
> On Wed, Jul 18, 2018 at 10:50:34AM +0100, Daniel P. Berrang=E9 wrote:
> > On Wed, Jul 18, 2018 at 12:41:48PM +0300, Hetz Ben Hamo wrote:
> > > Hi,
> > >=20
> > > I've been looking at the CPU list and although I see lots of CPU's,=
 I
> > > cannot find 2 CPU families:
> > >=20
> > > * AMD Ryzen
> > > * AMD Threadripper
> > >=20
> > > Although EPYC has been added recently.
> > >=20
> > > Are there any missing details which preventing adding those CPU's t=
o the
> > > list?
> >=20
> > Libvirt adds CPU models based on what QEMU supports. So from libvirt =
side the
> > answer is simply that QEMU doesn't expose any models for Ryzen/Thread=
ripper,
> > but I'm not clear why it doesn't...
> >=20
> > For a while I thought Ryzen/Threadripper would have same feature set =
as
> > EPYC, but I've seen bugs recently suggesting that is not in fact the
> > case. So it does look like having those models exposed by QEMU might
> > be useful.
> >=20
> > Copy'ing QEMU devel & the CPU model maintainers for opinions.
>=20
> I think that QEMU should figure out some pattern for naming CPU models
> because it's one big mess.  EPYC and Ryzen are bad names for QEMU as
> Core/Xeon would be for Intel CPUs.  It's the name of a model families
> and it will probably remain the same but with different
> microarchitecture.
>=20
> Better name would be similarly like for the latest Inter CPUs,
> Skylake-Client and Skylake-Server.  Currently AMD has already two
> microarchitectures, Zen and Zen+ and there is third one Zen 2 planned.
>=20
> Zen has AMD Ryzen, AMD Ryzen Threadripper and AMD Epyc.
> Zen+ has AMD Ryzen, AMD Ryzen Threadripper
>=20
> And I bet that Zen 2 will follow the same model families.
>=20
> We probably cannot rename EPYC now, but before we introduce Ryzen and
> Threadripper let's thing about it and come up with better names, for
> example Zen-Client/Zen-Server Zen+-Client or something like that.
>=20
> Pavel

--=20
Eduardo
