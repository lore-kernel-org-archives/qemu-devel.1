Received: from eggs.gnu.org ([2001:4830:134:3::10]:51499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTApu-00023v-TZ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTApr-0007I0-JF
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:49:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTApr-0007Ey-Am
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:49:35 -0400
Date: Wed, 13 Jun 2018 15:49:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613184928.GI7451@localhost.localdomain>
References: <DM5PR12MB247152846B93E574639E3AE7957F0@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180612174021.GL7451@localhost.localdomain>
	<DM5PR12MB2471F6EA1525A824A9A94545957F0@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180612190554.GO7451@localhost.localdomain>
	<39f328af-a9c1-15bb-653e-9456b045768d@amd.com>
	<DM5PR12MB2471C966B5B16FFCACDF33F3957E0@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180613171820.GC7451@localhost.localdomain>
	<DM5PR12MB2471BCEE4BD9ED0549F027E0957E0@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180613181730.GG7451@localhost.localdomain>
	<DM5PR12MB24715894687B9D55A47422A2957E0@DM5PR12MB2471.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB24715894687B9D55A47422A2957E0@DM5PR12MB2471.namprd12.prod.outlook.com>
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
To: "Moger, Babu" <Babu.Moger@amd.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>, Jiri Denemark <jdenemar@redhat.com>

On Wed, Jun 13, 2018 at 06:21:58PM +0000, Moger, Babu wrote:
> 
> 
> > -----Original Message-----
> > From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> > Sent: Wednesday, June 13, 2018 1:18 PM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> > rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> > kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com; Jiri
> > Denemark <jdenemar@redhat.com>
> > Subject: Re: [PATCH v13 3/5] i386: Enable TOPOEXT feature on AMD EPYC
> > CPU
> > 
> > On Wed, Jun 13, 2018 at 06:10:30PM +0000, Moger, Babu wrote:
> > > > -----Original Message-----
> > > > From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> > > > Sent: Wednesday, June 13, 2018 12:18 PM
> > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > Cc: mst@redhat.com; marcel.apfelbaum@gmail.com;
> > pbonzini@redhat.com;
> > > > rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> > > > kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com; Jiri
> > > > Denemark <jdenemar@redhat.com>
> > > > Subject: Re: [PATCH v13 3/5] i386: Enable TOPOEXT feature on AMD EPYC
> > > > CPU
> > > >
> > > > On Wed, Jun 13, 2018 at 04:52:18PM +0000, Moger, Babu wrote:
> > > > [...]
> > > > > > What do you think our options are here?
> > > > >
> > > > > Should we drop automatic topoext completely and move forward?
> > > > > What are your thoughts?
> > > >
> > > > Let's drop automatic topoext by now, and see if we find solutions
> > > > later.  I don't want to hold the rest of the patches because of
> > > > this.
> > >
> > > Ok. I will drop topoext.
> > >
> > > >
> > > > I'm thinking we could simply make kvm_arch_get_supported_cpuid()
> > > > always return TOPOEXT on AMD CPUs, because the feature flag don't
> > > > really depend on any KVM code to work (is that correct?).
> > >
> > > Yes, that is correct. I don't see any dependent code on TOPOEXT in KVM
> > driver.
> > >
> > > Ok. Let me add TOPOEXT flag for all the AMD cpus and see how it goes.
> > 
> > Hmm, this could actually solve all of our problems, then:
> > 
> > We can forget about auto-topoext: just add TOPOEXT in
> > kvm_arch_get_supported_cpuid(), add TOPOEXT unconditionally to
> > the CPU models where you are interested into (EPYC only?), and
> > add topoext=off to pc-2.12 compat_props.
> > 
> 
> Ok Sure.

Sorry, I forgot we still need to decide what to do if TOPOEXT is
enabled in the CPU model (or command-line) but the -smp options
are not compatible with it.

In other words, what should guest see on CPUID if using:

"-machine pc-q35-3.0 -cpu EPYC -smp 64,cores=64"
or:
"-machine pc-q35-3.0 -cpu Opteron_G5,+topoext -smp 64,cores=64"

I wonder what would happen if we just return zeroes on
CPUID[0x800001E] if !topology_supports_topoext(), instead of
trying to clear/set TOPOEXT depending on the -smp option?  It
would make things much simpler for QEMU and libvirt.

-- 
Eduardo
