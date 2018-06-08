Received: from eggs.gnu.org ([2001:4830:134:3::10]:43435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fRQMB-0007cb-1v
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 18:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fRQM6-0004A2-Rs
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 18:59:43 -0400
Received: from mail-co1nam05on0607.outbound.protection.outlook.com
	([2a01:111:f400:fe50::607]:8155
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fRQM6-00049G-Ex
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 18:59:38 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Fri, 8 Jun 2018 22:59:16 +0000
Message-ID: <DM5PR12MB2471E94CE6AF7D98C862F6DC957B0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528295806-90593-1-git-send-email-babu.moger@amd.com>
	<1528295806-90593-4-git-send-email-babu.moger@amd.com>
	<20180606223956.GD7451@localhost.localdomain>
	<DM5PR12MB24717A9DD61F79F58D3E70F7957B0@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180608192300.GN7451@localhost.localdomain>
	<DM5PR12MB2471636A157F2530E972AFB6957B0@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180608195025.GB24764@localhost.localdomain>
In-Reply-To: <20180608195025.GB24764@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v12 3/4] i386: Enable TOPOEXT feature on
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
Cc: "geoff@hostfission.com" <geoff@hostfission.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "kash@tripleback.net" <kash@tripleback.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "xiaoguangrong@tencent.com" <xiaoguangrong@tencent.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>



> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Friday, June 8, 2018 2:50 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: geoff@hostfission.com; kvm@vger.kernel.org; mst@redhat.com;
> kash@tripleback.net; mtosatti@redhat.com; xiaoguangrong@tencent.com;
> qemu-devel@nongnu.org; Juan Quintela <quintela@redhat.com>;
> pbonzini@redhat.com; rth@twiddle.net
> Subject: Re: [Qemu-devel] [PATCH v12 3/4] i386: Enable TOPOEXT feature on
> AMD EPYC CPU
>=20
> On Fri, Jun 08, 2018 at 07:36:05PM +0000, Moger, Babu wrote:
> >
> > > -----Original Message-----
> > > From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> > > Sent: Friday, June 8, 2018 2:23 PM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: mst@redhat.com; marcel.apfelbaum@gmail.com;
> pbonzini@redhat.com;
> > > rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> > > kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com;
> Juan
> > > Quintela <quintela@redhat.com>; xiaoguangrong@tencent.com
> > > Subject: Re: [PATCH v12 3/4] i386: Enable TOPOEXT feature on AMD EPYC
> > > CPU
> > >
> > > On Fri, Jun 08, 2018 at 06:40:16PM +0000, Moger, Babu wrote:
> > > > Hi Eduardo,
> > > > Sorry for the late response. Got pulled into something else.
> > > >
> > > > > -----Original Message-----
> > > > > From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> > > > > Sent: Wednesday, June 6, 2018 5:40 PM
> > > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > > Cc: mst@redhat.com; marcel.apfelbaum@gmail.com;
> > > pbonzini@redhat.com;
> > > > > rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> > > > > kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com
> > > > > Subject: Re: [PATCH v12 3/4] i386: Enable TOPOEXT feature on AMD
> EPYC
> > > > > CPU
> > > > >
> > > > > On Wed, Jun 06, 2018 at 10:36:45AM -0400, Babu Moger wrote:
> > > > > > Enable TOPOEXT feature on EPYC CPU. This is required to support
> > > > > > hyperthreading on VM guests. Also extend xlevel to 0x8000001E.
> > > > > >
> > > > > > Disable TOPOEXT feature for legacy machines.
> > > > > >
> > > > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > >
> > > > > Now, I just noticed we have a problem here:
> > > > >
> > > > > "-machine pc -cpu EPYC -smp 64" works today
> > > > >
> > > > > This patch makes it stop working, but it shouldn't.
> > > >
> > > > No. It works fine. I have tested it.
> > >
> > > This doesn't sound right.  The code in this series will error out
> > > of TOPOEXT is enabled and you have more than 64 VCPUs.
> > >
> > > But I just noticed we have a bug introduced by:
> >
> > Oh.. Ok..  Let me retry again with the new patch.
> >
> > >
> > > commit f548222c24342ca74689de7794f9006b43f86a54
> > > Author: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > Date:   Thu May 3 16:06:11 2018 +0800
> > >
> > >     migration: introduce decompress-error-check
> > >
> > >     QEMU 3.0 enables strict check for compression & decompression to
> > >     make the migration more robust, that depends on the source to fix
> > >     the internal design which triggers the unexpected error condition=
s
> > >
> > >     To make it work for migrating old version QEMU to 2.13 QEMU, we
> > >     introduce this parameter to disable the error check on the
> > >     destination which is the default behavior of the machine type
> > >     which is older than 2.13, alternately, the strict check can be
> > >     enabled explicitly as followings:
> > >           -M pc-q35-2.11 -global migration.decompress-error-check=3Dt=
rue
> > >
> > >     Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> > >     Reviewed-by: Juan Quintela <quintela@redhat.com>
> > >     Signed-off-by: Juan Quintela <quintela@redhat.com>
> > >
> > > This commits added PC_COMPAT_2_12 to the 3.0 machine-types.
> > > Because of this bug, TOPOEXT is being unconditionally disabled on
> > > all machine-types, unless I apply the fix below:
> > >
> > >
> > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > index 3d81136065..b4c5b03274 100644
> > > --- a/hw/i386/pc_piix.c
> > > +++ b/hw/i386/pc_piix.c
> > > @@ -430,7 +430,6 @@ static void
> > > pc_i440fx_3_0_machine_options(MachineClass *m)
> > >      pc_i440fx_machine_options(m);
> > >      m->alias =3D "pc";
> > >      m->is_default =3D 1;
> > > -    SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
> > >  }
> > >
> > >  DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
> > > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > > index b60cbb9266..83d6d75efa 100644
> > > --- a/hw/i386/pc_q35.c
> > > +++ b/hw/i386/pc_q35.c
> > > @@ -312,7 +312,6 @@ static void
> > > pc_q35_3_0_machine_options(MachineClass *m)
> > >  {
> > >      pc_q35_machine_options(m);
> > >      m->alias =3D "q35";
> > > -    SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
> > >  }
> > >
> > >  DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
> > >
> > > >
> > > > >
> > > > > On the other hand, I believe you expect:
> > > > > * "-machine pc -cpu EPYC -smp 8" to automatically enable topoext.
> > > > Yes. Only on new machines-types
> > > > > * "-machine pc -cpu Opteron_G1 -smp 8" to not enable topoext.
> > > > Yes.
> > > > > * What about "-machine -cpu Opteron_G1 -smp 8,threads=3D2"?
> > > > No. This should not enable topoext.  Topoext is not supported by
> > > Opteron_G1.
> > > > This should warn about hyperthreading and continue.
> > >
> > > OK, makes sense to me.
> > >
> > > > >
> > > > >
> > > > > We also have other requirements, I will try to enumerate all of
> > > > > them below:
> > > > >
> > > > > 0) "-topoext" explicitly configured (any machine-type):
> > > > > * Must never enable topoext.
> > > > Yes.
> > > > >
> > > > > 1) "+topoext" explicitly configured (any machine-type):
> > > > > * Must validate topology and refuse to start if unsupported.
> > > >
> > > > Yes.
> > > >
> > > > >
> > > > > 2) Older machine-types:
> > > > > * Must never enable topoext automatically, even if using "EPYC"
> > > > >   or "threads=3D2"
> > > > >
> > > > Yes.
> > > >
> > > > > 3) "EPYC" CPU model (on new machine-types):
> > > > > * Should enable topoext automatically, but only if topology is
> > > > >   supported.
> > > > > * Must not error out if topology is not supported.
> > > > In new machine types we will enable topoext for "EPYC" CPU model.
> > > > Right now(old machine type) we can disable for all the CPU models.
> > > > So, we don't need two bits(topoext and auto-topoext)
> > >
> > > Right, so you agree that in this case we must _not_ error out if
> > > topology is unsupported, correct?  Otherwise we will break this
> > > existing use case:
> > >   "-machine pc -cpu EPYC -smp 64".
> >
> > Ok. I will test this with new fix patch.
> > >
> > > >
> > > > I thought we should error out if topology cannot be supported. But =
we
> can
> > > warn(disable topoext) and continue that is another option.
> > > >
> > > > > * Should this enable topoext automatically even if threads=3D1?
> > > >
> > > > Yes. We should enable even with threads=3D1.
> > > >
> > > > >
> > > > > 4) Other AMD CPU models with "threads=3D2" (on new machine-types)=
:
> > > > > * We might want to make this enable topoext automatically, too.
> > > > >   What do you think?
> > > >
> > > >   No. We should not enable topoext here. We should depend on CPU
> > > model table here.
> > > >
> > > > >
> > > > > Is the above description accurate?  Do you agree with these
> > > > > requirements?
> > > >
> > > > With these requirements in mind, I will send that patches. We can s=
tart
> our
> > > discussion.
> > > > We don't need one more bits. That is my opinion.
> > >
> > > Thanks for confirming the requirements above.
> > >
> > > But it doesn't seem to be possible represent these requirements
> > > with just one bit.  Otherwise you can't differentiate explicit
> > > "+topoext" (1 above) from topoext being implicitly enabled by
> > > "-cpu EPYC" (3 above).
> > >
> > > Another problem is query-cpu-model-expansion QMP command: this
> > > patch makes "topoext" appear on the output of
> > > "query-cpu-model-expansion model=3DEPYC", meaning that management
> > > software will assume everybody using the "EPYC" CPU model will
> > > require +topoext.  A separate "auto-topoext" property would avoid
> > > this issue.
> >
> > Sure.  Will work on it.  Yes, I know all these combinations make it ver=
y
> tricky.
>=20
> I will rewrite my proposal, to make sure we are on the same page:
>=20
> 0) "-topoext" explicitly configured (any machine-type):
> * Will clear TOPOEXT on env->features and set TOPOEXT on
>   env->user_features
>   (already done today)
>=20
> 1) "+topoext" explicitly configured (any machine-type):
> * Will set TOPOEXT on both env->user_features and env->features
>   (already done today)
>=20
> 2) Older machine-types:
> [CHANGED in v2]
> * Will set auto-topoext=3Doff (can be done on compat_props)
> * No need to set topoext=3Doff on compat_props (because no CPU model will
> have
>   topoext=3Don, see #3 below)
>=20
> 3) "EPYC" CPU model (on new machine-types):
> [CHANGED IN v2]
> * Will set auto-topoext=3Don (using a new field on X86CPUDefinition)
> * Will NOT set TOPOEXT on CPU model table (or it would break
>   query-cpu-model-expansion)
>=20
> 4) Other AMD CPU models (on all machine-types):
> [CHANGED IN v2]
> * auto-topoext=3Doff (the default)
> * Will keep TOPOEXT disabled on env->features (the default)
>=20
>=20
> x86_cpu_realizefn:
>=20
>   if {cpu->cpudef && cpu->cpudef->auto_topoext &&
>       TOPOEXT not in env->user_features &&
>       supported_topology) {
>       set TOPOEXT in env->features
>   }
>=20
>   if (TOPOEXT in env->features && !supported_topology)
>       error;
>   }
>=20
> I think this logic will fulfill all the requirements above.

Hi Eduardo ,
 I have sent the v13 version. I am still testing it. Wanted to get feedback=
 if I missed anything. Thanks

>=20
> --
> Eduardo
