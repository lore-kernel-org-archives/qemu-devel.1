Received: from eggs.gnu.org ([2001:4830:134:3::10]:46539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f0wH8-0006zT-9P
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f0wH5-0006b1-2E
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:37:02 -0400
Received: from mail-bn3nam01on0066.outbound.protection.outlook.com
	([104.47.33.66]:12448
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1f0wH4-0006aN-Qt
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:36:58 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Tue, 27 Mar 2018 21:36:55 +0000
Message-ID: <CY4PR12MB1768FDFD691988FD33BED1CF95AC0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
	<1520888449-4352-3-git-send-email-babu.moger@amd.com>
	<20180316180006.GH28578@localhost.localdomain>
	<CY4PR12MB17686EB283987B8A5EDCF49295AB0@CY4PR12MB1768.namprd12.prod.outlook.com>
	<20180320175427.GU3417@localhost.localdomain>
	<CY4PR12MB1768A3CBE42AAFB03CB1081E95AA0@CY4PR12MB1768.namprd12.prod.outlook.com>
	<20180321170941.GX3417@localhost.localdomain>
	<CY4PR12MB1768D466F00BF68AA552EBE195AA0@CY4PR12MB1768.namprd12.prod.outlook.com>
	<20180321181526.GZ3417@localhost.localdomain>
	<CY4PR12MB176862E1B2C32BA91A25660595AA0@CY4PR12MB1768.namprd12.prod.outlook.com>
	<20180321202933.GF3417@localhost.localdomain>
In-Reply-To: <20180321202933.GF3417@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AMD Processor
 Cache Information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "Lendacky,
	Thomas" <Thomas.Lendacky@amd.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "Hook,
	Gary" <Gary.Hook@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: Wednesday, March 21, 2018 3:30 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; rkrcmar@redhat.com;
> Lendacky, Thomas <Thomas.Lendacky@amd.com>; Singh, Brijesh
> <brijesh.singh@amd.com>; kvm@vger.kernel.org; kash@tripleback.net;
> mtosatti@redhat.com; Hook, Gary <Gary.Hook@amd.com>; qemu-
> devel@nongnu.org
> Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AMD
> Processor Cache Information
>=20
> On Wed, Mar 21, 2018 at 08:07:54PM +0000, Moger, Babu wrote:
> >
> > > -----Original Message-----
> > > From: Eduardo Habkost <ehabkost@redhat.com>
> > > Sent: Wednesday, March 21, 2018 1:15 PM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: pbonzini@redhat.com; rth@twiddle.net; rkrcmar@redhat.com;
> > > Lendacky, Thomas <Thomas.Lendacky@amd.com>; Singh, Brijesh
> > > <brijesh.singh@amd.com>; kvm@vger.kernel.org; kash@tripleback.net;
> > > mtosatti@redhat.com; Hook, Gary <Gary.Hook@amd.com>; qemu-
> > > devel@nongnu.org
> > > Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AMD
> > > Processor Cache Information
> > >
> > > On Wed, Mar 21, 2018 at 05:47:28PM +0000, Moger, Babu wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Eduardo Habkost <ehabkost@redhat.com>
> > > > > Sent: Wednesday, March 21, 2018 12:10 PM
> > > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > > Cc: pbonzini@redhat.com; rth@twiddle.net; rkrcmar@redhat.com;
> > > > > Lendacky, Thomas <Thomas.Lendacky@amd.com>; Singh, Brijesh
> > > > > <brijesh.singh@amd.com>; kvm@vger.kernel.org;
> kash@tripleback.net;
> > > > > mtosatti@redhat.com; Hook, Gary <Gary.Hook@amd.com>; qemu-
> > > > > devel@nongnu.org
> > > > > Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AM=
D
> > > > > Processor Cache Information
> > > > >
> > > > > On Wed, Mar 21, 2018 at 03:58:41PM +0000, Moger, Babu wrote:
> > > > > > Hi Eduardo,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Eduardo Habkost <ehabkost@redhat.com>
> > > > > > > Sent: Tuesday, March 20, 2018 12:54 PM
> > > > > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > > > > Cc: pbonzini@redhat.com; rth@twiddle.net;
> rkrcmar@redhat.com;
> > > > > > > Lendacky, Thomas <Thomas.Lendacky@amd.com>; Singh, Brijesh
> > > > > > > <brijesh.singh@amd.com>; kvm@vger.kernel.org;
> > > kash@tripleback.net;
> > > > > > > mtosatti@redhat.com; Hook, Gary <Gary.Hook@amd.com>;
> qemu-
> > > > > > > devel@nongnu.org
> > > > > > > Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populat=
e
> AMD
> > > > > > > Processor Cache Information
> > > > > > >
> > > > > > > On Tue, Mar 20, 2018 at 05:25:52PM +0000, Moger, Babu wrote:
> > > > > > > > Hi Eduardo, Thanks for the comments. Please see the respons=
e
> > > inline.
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Eduardo Habkost <ehabkost@redhat.com>
> > > > > > > > > Sent: Friday, March 16, 2018 1:00 PM
> > > > > > > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > > > > > > Cc: pbonzini@redhat.com; rth@twiddle.net;
> > > rkrcmar@redhat.com;
> > > > > > > > > Lendacky, Thomas <Thomas.Lendacky@amd.com>; Singh,
> Brijesh
> > > > > > > > > <brijesh.singh@amd.com>; kvm@vger.kernel.org;
> > > > > kash@tripleback.net;
> > > > > > > > > mtosatti@redhat.com; Hook, Gary <Gary.Hook@amd.com>;
> > > qemu-
> > > > > > > > > devel@nongnu.org
> > > > > > > > > Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386:
> Populate
> > > AMD
> > > > > > > > > Processor Cache Information
> > > > > > > > >
> > > > > > > > > On Mon, Mar 12, 2018 at 05:00:46PM -0400, Babu Moger
> wrote:
> > > > > > > > > > From: Stanislav Lanci <pixo@polepetko.eu>
> > > > > > > > > >
> > > > > > > > > > Add information for cpuid 0x8000001D leaf. Populate cac=
he
> > > topology
> > > > > > > > > information
> > > > > > > > > > for different cache types(Data Cache, Instruction Cache=
, L2
> and
> > > L3)
> > > > > > > > > supported
> > > > > > > > > > by 0x8000001D leaf. Please refer Processor Programming
> > > Reference
> > > > > > > (PPR)
> > > > > > > > > for AMD
> > > > > > > > > > Family 17h Model for more details.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
> > > > > > > > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > > > > > >
> > > > > > > > > The new CPUID leaves don't seem to match the existing AMD
> > > cache
> > > > > > > > > information
> > > > > > > > > leaves.  Is this intentional?  Why?
> > > > > > > >
> > > > > > > > It is not intentional. These values are from older family o=
f
> > > processors.
> > > > > > > These values have changed from Family 14  or later.
> > > > > > > > The latest one is Family 17. You can see the differences he=
re.
> > > > > > > >  https://support.amd.com/TechDocs/41131.pdf
> > > > > > > >
> > > > > > >
> > > > >
> > >
> https://support.amd.com/TechDocs/55072_AMD_Family_15h_Models_70h-
> > > > > > > 7Fh_BKDG.pdf
> > > > > > > >
> > > > > > >
> > > > >
> > >
> https://support.amd.com/TechDocs/54945_PPR_Family_17h_Models_00h-
> > > > > > > 0Fh.pdf
> > > > > > > >
> > > > > > > > Some of these are bugs in our code. For some we need to add
> > > checks
> > > > > for
> > > > > > > the family and correct these values.
> > > > > > > > You understand the code much better than me. Correct me if =
I
> > > missed
> > > > > > > something.
> > > > > > > >
> > > > > > > > Note that older family of processors don't support topology
> > > extensions.
> > > > > > >
> > > > > > > If you want to make the cache size/topology look different
> > > > > > > depending on the CPU model/options, this would require more
> work,
> > > > > > > but it would be an interesting feature.
> > > > > > >
> > > > > > > The "i386: Helpers to encode cache information consistently"
> > > > > > > patch I sent last week might be a useful starting point for t=
hat.
> > > > > > >
> > > > > > > If you plan to implement that, please keep in mind that exist=
ing
> > > > > > > CPUID cache info needs to be kept on previous machine-types
> (this
> > > > > > > is implemented by adding QOM properties that can be used to
> > > > > > > enable the old behavior, and by setting them at
> > > > > > > MachineClass::compat_props).
> > > > > >
> > > > > > Wanted to get some confirmation what you meant by setting
> > > > > MachineClass::compat_props.
> > > > > > Here is the patch I created to add new property for cpu. Now, I=
 can
> use
> > > > > enable_topoext to display
> > > > > > new  change properly based on family.  Is that what you meant ?
> > > > >
> > > > > If the only change you introduce in the defaults is enabling
> > > > > topoext but keeping the same default cache sizes, the example
> > > > > following would make sense (but see comments below about
> > > > > implementation details).
> > > > >
> > > > > But if you also want to change the default cache size, you will
> > > > > also need properties that control the cache size.
> > > >
> > > > Yes. We will need cpu family information.  Let me see if that
> information is
> > > >  already available or we need to add that as well.
> > >
> > > CPU family doesn't seem to be enough, if you want to keep
> > > compatibility on older machine-type versions.  e.g.:
> > >
> > > If you want to make EPYC expose a different cache size, you'd
> > > just need a new field on X86CPUDefinition.  This is the easy
> > > part.
> >
> > Actually, I already have this information.  I can just decode cpuid_ver=
sion
> information.
> > I may not need to add new field in new field on X86CPUDefinition.
>=20
> I'd prefer CPUCacheInfo* fields on X86CPUDefinition instead of
> hardcoding a cpuid_version check.  This way all
> family/model-specific information about CPU models will
> centralized in the CPU model table.

Eduardo,  Posted the v5 version. Please see if it addresses your feedback h=
ere.
Thanks.

>=20
> >
> > >
> > > But you still need "-machine pc-2.11 -cpu EPYC" to expose the old
> > > cache size, for guest ABI compatibility.
> > >
> > > This means you need an additional knob that pc-2.10 can use in
> > > compat_props, to override the new family/model-dependent cache
> > > size in EPYC, and force the old cache sizes to be used even with
> > > "-cpu EPYC".
> >
> > Ok.  Will add a new property legacy_cache(or something). I can use this=
 to
> override
> > all the new information. Will plan to send first version tomorrow.
> >
> > >
> > > --
> > > Eduardo
>=20
> --
> Eduardo
