Received: from eggs.gnu.org ([2001:4830:134:3::10]:34628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1eyhpn-0006Dc-9P
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1eyhpj-00059y-9T
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:47:35 -0400
Received: from mail-bn3nam01on0060.outbound.protection.outlook.com
	([104.47.33.60]:53979
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1eyhpi-00059l-Qo
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:47:31 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Wed, 21 Mar 2018 17:47:28 +0000
Message-ID: <CY4PR12MB1768D466F00BF68AA552EBE195AA0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
	<1520888449-4352-3-git-send-email-babu.moger@amd.com>
	<20180316180006.GH28578@localhost.localdomain>
	<CY4PR12MB17686EB283987B8A5EDCF49295AB0@CY4PR12MB1768.namprd12.prod.outlook.com>
	<20180320175427.GU3417@localhost.localdomain>
	<CY4PR12MB1768A3CBE42AAFB03CB1081E95AA0@CY4PR12MB1768.namprd12.prod.outlook.com>
	<20180321170941.GX3417@localhost.localdomain>
In-Reply-To: <20180321170941.GX3417@localhost.localdomain>
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
> Sent: Wednesday, March 21, 2018 12:10 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; rkrcmar@redhat.com;
> Lendacky, Thomas <Thomas.Lendacky@amd.com>; Singh, Brijesh
> <brijesh.singh@amd.com>; kvm@vger.kernel.org; kash@tripleback.net;
> mtosatti@redhat.com; Hook, Gary <Gary.Hook@amd.com>; qemu-
> devel@nongnu.org
> Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AMD
> Processor Cache Information
>=20
> On Wed, Mar 21, 2018 at 03:58:41PM +0000, Moger, Babu wrote:
> > Hi Eduardo,
> >
> > > -----Original Message-----
> > > From: Eduardo Habkost <ehabkost@redhat.com>
> > > Sent: Tuesday, March 20, 2018 12:54 PM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: pbonzini@redhat.com; rth@twiddle.net; rkrcmar@redhat.com;
> > > Lendacky, Thomas <Thomas.Lendacky@amd.com>; Singh, Brijesh
> > > <brijesh.singh@amd.com>; kvm@vger.kernel.org; kash@tripleback.net;
> > > mtosatti@redhat.com; Hook, Gary <Gary.Hook@amd.com>; qemu-
> > > devel@nongnu.org
> > > Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AMD
> > > Processor Cache Information
> > >
> > > On Tue, Mar 20, 2018 at 05:25:52PM +0000, Moger, Babu wrote:
> > > > Hi Eduardo, Thanks for the comments. Please see the response inline=
.
> > > >
> > > > > -----Original Message-----
> > > > > From: Eduardo Habkost <ehabkost@redhat.com>
> > > > > Sent: Friday, March 16, 2018 1:00 PM
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
> > > > > On Mon, Mar 12, 2018 at 05:00:46PM -0400, Babu Moger wrote:
> > > > > > From: Stanislav Lanci <pixo@polepetko.eu>
> > > > > >
> > > > > > Add information for cpuid 0x8000001D leaf. Populate cache topol=
ogy
> > > > > information
> > > > > > for different cache types(Data Cache, Instruction Cache, L2 and=
 L3)
> > > > > supported
> > > > > > by 0x8000001D leaf. Please refer Processor Programming Referenc=
e
> > > (PPR)
> > > > > for AMD
> > > > > > Family 17h Model for more details.
> > > > > >
> > > > > > Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
> > > > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > >
> > > > > The new CPUID leaves don't seem to match the existing AMD cache
> > > > > information
> > > > > leaves.  Is this intentional?  Why?
> > > >
> > > > It is not intentional. These values are from older family of proces=
sors.
> > > These values have changed from Family 14  or later.
> > > > The latest one is Family 17. You can see the differences here.
> > > >  https://support.amd.com/TechDocs/41131.pdf
> > > >
> > >
> https://support.amd.com/TechDocs/55072_AMD_Family_15h_Models_70h-
> > > 7Fh_BKDG.pdf
> > > >
> > >
> https://support.amd.com/TechDocs/54945_PPR_Family_17h_Models_00h-
> > > 0Fh.pdf
> > > >
> > > > Some of these are bugs in our code. For some we need to add checks
> for
> > > the family and correct these values.
> > > > You understand the code much better than me. Correct me if I missed
> > > something.
> > > >
> > > > Note that older family of processors don't support topology extensi=
ons.
> > >
> > > If you want to make the cache size/topology look different
> > > depending on the CPU model/options, this would require more work,
> > > but it would be an interesting feature.
> > >
> > > The "i386: Helpers to encode cache information consistently"
> > > patch I sent last week might be a useful starting point for that.
> > >
> > > If you plan to implement that, please keep in mind that existing
> > > CPUID cache info needs to be kept on previous machine-types (this
> > > is implemented by adding QOM properties that can be used to
> > > enable the old behavior, and by setting them at
> > > MachineClass::compat_props).
> >
> > Wanted to get some confirmation what you meant by setting
> MachineClass::compat_props.
> > Here is the patch I created to add new property for cpu. Now, I can use
> enable_topoext to display
> > new  change properly based on family.  Is that what you meant ?
>=20
> If the only change you introduce in the defaults is enabling
> topoext but keeping the same default cache sizes, the example
> following would make sense (but see comments below about
> implementation details).
>=20
> But if you also want to change the default cache size, you will
> also need properties that control the cache size.

Yes. We will need cpu family information.  Let me see if that information i=
s
 already available or we need to add that as well.

>=20
> (In theory, you could make the "topoext" property control the
> cache size too, but I don't see why the cache size should be
> coupled to topoext)
>=20
> >
> >
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index ffee841..d1ee053 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -369,6 +369,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *,
> uint64_t *);
> >      HW_COMPAT_2_7 \
> >      {\
> >          .driver   =3D TYPE_X86_CPU,\
> > +        .property =3D "topoext",\
> > +        .value    =3D "off",\
>=20
> This makes sense if you want to change a CPU model to enable
> topoext by default.  But I suggest setting it for
> ("EPYC" "-" TYPE_X86_CPU) only, not TYPE_X86_CPU, as EPYC is the
> only CPU model affected by patch 4/5.

As Kash already mentioned, right now we have two family's  EPYC and EPYC-IB=
PB supporting=20
this new cache sizes/info. So, ("EPYC" "-" TYPE_X86_CPU) may not work. Will=
 keep it as old one.

>=20
> However, the property registration can be simpler:
>=20
> > +    },\
> > +    {\
> > +        .driver   =3D TYPE_X86_CPU,\
> >          .property =3D "l3-cache",\
> >          .value    =3D "off",\
> >      },\
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 84d64de..557a2d6 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -5080,6 +5080,7 @@ static Property x86_cpu_properties[] =3D {
> >                       false),
> >      DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU,
> vmware_cpuid_freq, true),
> >      DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
> > +    DEFINE_PROP_BOOL("topoext", X86CPU, enable_topoext, true),
>=20
> You don't need to manually add a X86CPU field + property if you
> are just controlling a CPUID feature flag.  In this case, you can
> just add "topoext" to
> feature_word_info[FEAT_8000_0001_ECX].feat_names[22], and
> a "topoext" QOM property will be available automatically.

Actually "topoext" feature is already there as cupid feature. I should have=
 not used topoext
to control the cache sizes. I will come up with a new name.=20
=20

>=20
> >
> >      /*
> >       * From "Requirements for Implementing the Microsoft
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 2e2bab5..3d3caa1 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1333,6 +1333,11 @@ struct X86CPU {
> >       */
> >      bool enable_l3_cache;
> >
> > +    /* Compatibility bits for old machine types.
> > +     * If true present the new cache topology information
> > +     */
> > +    bool enable_topoext;
> > +
> >      /* Compatibility bits for old machine types: */
> >      bool enable_cpuid_0xb;
> >
> >
> >
> > >
> > > --
> > > Eduardo
>=20
> --
> Eduardo
