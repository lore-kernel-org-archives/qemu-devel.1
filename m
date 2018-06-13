Received: from eggs.gnu.org ([2001:4830:134:3::10]:52632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTAGf-0001Ar-RF
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTAGc-0004Hn-Jr
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:13:13 -0400
Received: from mail-co1nam05on0603.outbound.protection.outlook.com
	([2a01:111:f400:fe50::603]:14207
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fTAGc-0004EB-A8
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:13:10 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Wed, 13 Jun 2018 18:12:48 +0000
Message-ID: <DM5PR12MB2471F9E2D83B079FF15F60FC957E0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
	<1528498581-131037-4-git-send-email-babu.moger@amd.com>
	<20180611205030.GW7451@localhost.localdomain>
	<20180611211026.GA7451@localhost.localdomain>
	<DM5PR12MB247152846B93E574639E3AE7957F0@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180612174021.GL7451@localhost.localdomain>
	<DM5PR12MB2471F6EA1525A824A9A94545957F0@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180612190554.GO7451@localhost.localdomain>
	<39f328af-a9c1-15bb-653e-9456b045768d@amd.com>
	<DM5PR12MB2471C966B5B16FFCACDF33F3957E0@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180613171820.GC7451@localhost.localdomain>
	<DM5PR12MB2471BCEE4BD9ED0549F027E0957E0@DM5PR12MB2471.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2471BCEE4BD9ED0549F027E0957E0@DM5PR12MB2471.namprd12.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v13 3/5] i386: Enable TOPOEXT feature on
 AMD EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Moger, Babu" <Babu.Moger@amd.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>, Jiri Denemark <jdenemar@redhat.com>



> -----Original Message-----
> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org]
> On Behalf Of Moger, Babu
> Sent: Wednesday, June 13, 2018 1:11 PM
> To: Eduardo Habkost <ehabkost@redhat.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com; Jiri
> Denemark <jdenemar@redhat.com>
> Subject: RE: [PATCH v13 3/5] i386: Enable TOPOEXT feature on AMD EPYC
> CPU
>=20
>=20
> > -----Original Message-----
> > From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> > Sent: Wednesday, June 13, 2018 12:18 PM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: mst@redhat.com; marcel.apfelbaum@gmail.com;
> pbonzini@redhat.com;
> > rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> > kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com; Jiri
> > Denemark <jdenemar@redhat.com>
> > Subject: Re: [PATCH v13 3/5] i386: Enable TOPOEXT feature on AMD EPYC
> > CPU
> >
> > On Wed, Jun 13, 2018 at 04:52:18PM +0000, Moger, Babu wrote:
> > [...]
> > > > What do you think our options are here?
> > >
> > > Should we drop automatic topoext completely and move forward?
> > > What are your thoughts?
> >
> > Let's drop automatic topoext by now, and see if we find solutions
> > later.  I don't want to hold the rest of the patches because of
> > this.
>=20
> Ok. I will drop topoext.

Sorry, I mean automatic topoext.

>=20
> >
> > I'm thinking we could simply make kvm_arch_get_supported_cpuid()
> > always return TOPOEXT on AMD CPUs, because the feature flag don't
> > really depend on any KVM code to work (is that correct?).
>=20
> Yes, that is correct. I don't see any dependent code on TOPOEXT in KVM
> driver.
>=20
> Ok. Let me add TOPOEXT flag for all the AMD cpus and see how it goes.
>=20
> >
> > --
> > Eduardo
