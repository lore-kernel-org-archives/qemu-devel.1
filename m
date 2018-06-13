Received: from eggs.gnu.org ([2001:4830:134:3::10]:50624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTAEA-0000GW-RK
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTAE7-00046W-IY
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:10:38 -0400
Received: from mail-eopbgr690044.outbound.protection.outlook.com
	([40.107.69.44]:14587
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fTAE6-0003zb-NJ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:10:35 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Wed, 13 Jun 2018 18:10:30 +0000
Message-ID: <DM5PR12MB2471BCEE4BD9ED0549F027E0957E0@DM5PR12MB2471.namprd12.prod.outlook.com>
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
In-Reply-To: <20180613171820.GC7451@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>, Jiri Denemark <jdenemar@redhat.com>


> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Wednesday, June 13, 2018 12:18 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com; Jiri
> Denemark <jdenemar@redhat.com>
> Subject: Re: [PATCH v13 3/5] i386: Enable TOPOEXT feature on AMD EPYC
> CPU
>=20
> On Wed, Jun 13, 2018 at 04:52:18PM +0000, Moger, Babu wrote:
> [...]
> > > What do you think our options are here?
> >
> > Should we drop automatic topoext completely and move forward?
> > What are your thoughts?
>=20
> Let's drop automatic topoext by now, and see if we find solutions
> later.  I don't want to hold the rest of the patches because of
> this.

Ok. I will drop topoext.

>=20
> I'm thinking we could simply make kvm_arch_get_supported_cpuid()
> always return TOPOEXT on AMD CPUs, because the feature flag don't
> really depend on any KVM code to work (is that correct?).

Yes, that is correct. I don't see any dependent code on TOPOEXT in KVM driv=
er.

Ok. Let me add TOPOEXT flag for all the AMD cpus and see how it goes.

>=20
> --
> Eduardo
