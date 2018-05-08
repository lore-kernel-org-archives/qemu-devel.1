Received: from eggs.gnu.org ([2001:4830:134:3::10]:39374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fG66G-0006WS-Mq
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fG66D-0004D2-Ed
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:08:28 -0400
Received: from mail-by2nam03on0061.outbound.protection.outlook.com
	([104.47.42.61]:8666
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fG66D-0004BM-03
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:08:25 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Tue, 8 May 2018 17:08:20 +0000
Message-ID: <SN1PR12MB24778D8547E2551F6941BD32959A0@SN1PR12MB2477.namprd12.prod.outlook.com>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-6-git-send-email-babu.moger@amd.com>
	<20180507193732.GE13350@localhost.localdomain>
	<BL0PR12MB2468EFDC6A05DB20E253E965959B0@BL0PR12MB2468.namprd12.prod.outlook.com>
	<20180508141201.GI25013@localhost.localdomain>
In-Reply-To: <20180508141201.GI25013@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 5/9] i386: Use the statically loaded
 cache definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel@redhat.com" <marcel@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "geoff@hostfission.com" <geoff@hostfission.com>, "kash@tripleback.net" <kash@tripleback.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>



> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Tuesday, May 8, 2018 9:12 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel@redhat.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; geoff@hostfission.com;
> kash@tripleback.net; qemu-devel@nongnu.org; kvm@vger.kernel.org
> Subject: Re: [Qemu-devel] [PATCH v7 5/9] i386: Use the statically loaded
> cache definitions
>=20
> On Mon, May 07, 2018 at 11:39:45PM +0000, Moger, Babu wrote:
> >
> >
> > > -----Original Message-----
> > > From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> > > Sent: Monday, May 7, 2018 2:38 PM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: mst@redhat.com; marcel@redhat.com; pbonzini@redhat.com;
> > > rth@twiddle.net; mtosatti@redhat.com; geoff@hostfission.com;
> > > kash@tripleback.net; qemu-devel@nongnu.org; kvm@vger.kernel.org
> > > Subject: Re: [Qemu-devel] [PATCH v7 5/9] i386: Use the statically loa=
ded
> > > cache definitions
> > >
> > > On Thu, Apr 26, 2018 at 11:26:45AM -0500, Babu Moger wrote:
> > > > Use the statically loaded cache definitions if available
> > > > and legacy-cache parameter is not set.
> > > >
> > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > Tested-by: Geoffrey McRae <geoff@hostfission.com>
> > >
> > > Now that I'm looking at the rest of the code, this seems
> > > incomplete:
> > >
> > > What about CPUID[2], CPUID[4]?  They are still referring to the
> > > old legacy cache structs.
> >
> > There is no change in CPUID[2], CPUID[4] behavior. It is intel specific=
. It did
> not change. So, we don't need to change that.
> > In case it changes in future, we can add it later. AMD does not use CPU=
ID[2]
> and CPUID[4].
>=20
> Right, now I see that CPUID 2h-4h are reserved on AMD.
>=20
> However, X86CPUDefinition::cache_info is not documented as
> AMD-specific, so developers changing the code CPU model table in
> the future would expect it to affect all cache CPUID leaves.
>=20
> We could document it as AMD-specific, but it's simpler to just
> make it affect all CPUID leaves.

Ok. Will make those changes. Will check for cache_info pointer and legacy_c=
ache like we do for 0x80000005.=20
>=20
> >
> > >
> > > If their corresponding code isn't updated to use env->cache_info,
> > > those leaves will be inconsistent with CPUID[0x8000005] and
> > > CPUID[0x80000006].
> > >
> > > > ---
> > > >  target/i386/cpu.c | 22 +++++++++++++++++-----
> > > >  1 file changed, 17 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > > index a27b658..56d2f0b 100644
> > > > --- a/target/i386/cpu.c
> > > > +++ b/target/i386/cpu.c
> > > > @@ -3941,8 +3941,13 @@ void cpu_x86_cpuid(CPUX86State *env,
> > > uint32_t index, uint32_t count,
> > > >                 (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
> > > >          *ebx =3D (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES <<=
 16)
> | \
> > > >                 (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
> > > > -        *ecx =3D encode_cache_cpuid80000005(&l1d_cache_amd);
> > > > -        *edx =3D encode_cache_cpuid80000005(&l1i_cache_amd);
> > > > +        if (env->cache_info.valid && !cpu->legacy_cache) {
> > > > +            *ecx =3D encode_cache_cpuid80000005(&env-
> > > >cache_info.l1d_cache);
> > > > +            *edx =3D encode_cache_cpuid80000005(&env-
> > > >cache_info.l1i_cache);
> > > > +        } else {
> > > > +            *ecx =3D encode_cache_cpuid80000005(&l1d_cache_amd);
> > > > +            *edx =3D encode_cache_cpuid80000005(&l1i_cache_amd);
> > > > +        }
> > > >          break;
> > > >      case 0x80000006:
> > > >          /* cache info (L2 cache) */
> > > > @@ -3958,9 +3963,16 @@ void cpu_x86_cpuid(CPUX86State *env,
> > > uint32_t index, uint32_t count,
> > > >                 (L2_DTLB_4K_ENTRIES << 16) | \
> > > >                 (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) | \
> > > >                 (L2_ITLB_4K_ENTRIES);
> > > > -        encode_cache_cpuid80000006(&l2_cache_amd,
> > > > -                                   cpu->enable_l3_cache ? &l3_cach=
e : NULL,
> > > > -                                   ecx, edx);
> > > > +        if (env->cache_info.valid && !cpu->legacy_cache) {
> > > > +            encode_cache_cpuid80000006(&env->cache_info.l2_cache,
> > > > +                                       cpu->enable_l3_cache ?
> > > > +                                       &env->cache_info.l3_cache :=
 NULL,
> > > > +                                       ecx, edx);
> > > > +        } else {
> > > > +            encode_cache_cpuid80000006(&l2_cache_amd,
> > > > +                                       cpu->enable_l3_cache ? &l3_=
cache : NULL,
> > > > +                                       ecx, edx);
> > > > +        }
> > > >          break;
> > > >      case 0x80000007:
> > > >          *eax =3D 0;
> > > > --
> > > > 2.7.4
> > > >
> > > >
> > >
> > > --
> > > Eduardo
>=20
> --
> Eduardo
