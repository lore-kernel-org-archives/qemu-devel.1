Received: from eggs.gnu.org ([2001:4830:134:3::10]:55849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1er91h-0002cG-QU
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1er91d-0007t0-OW
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:12:37 -0500
Received: from mail-sn1nam02on0045.outbound.protection.outlook.com
	([104.47.36.45]:40416
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1er91d-0007rG-Gk
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:12:33 -0500
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Wed, 28 Feb 2018 21:12:29 +0000
Message-ID: <CY4PR12MB17686A4901388CD9C88A8D7D95C70@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
	<1519439425-27883-2-git-send-email-babu.moger@amd.com>
	<20180228173813.GA8418@flask>
In-Reply-To: <20180228173813.GA8418@flask>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/5] target/i386: Fix a minor typo found
 while reviwing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pixo@polepetko.eu" <pixo@polepetko.eu>, "Hook, Gary" <Gary.Hook@amd.com>


> -----Original Message-----
> From: Radim Kr=E8m=E1=F8 [mailto:rkrcmar@redhat.com]
> Sent: Wednesday, February 28, 2018 11:38 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> mtosatti@redhat.com; qemu-devel@nongnu.org; kvm@vger.kernel.org;
> pixo@polepetko.eu; Hook, Gary <Gary.Hook@amd.com>
> Subject: Re: [PATCH v2 1/5] target/i386: Fix a minor typo found while
> reviwing
>=20
> 2018-02-23 21:30-0500, Babu Moger:
> > Changed KVM_CPUID_FLAG_SIGNIFCANT_INDEX to
> KVM_CPUID_FLAG_SIGNIFICANT_INDEX
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  linux-headers/asm-x86/kvm.h | 2 +-
> >  target/i386/kvm.c           | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> > index f3a9604..6aec661 100644
> > --- a/linux-headers/asm-x86/kvm.h
> > +++ b/linux-headers/asm-x86/kvm.h
> > @@ -220,7 +220,7 @@ struct kvm_cpuid_entry2 {
> >  	__u32 padding[3];
> >  };
> >
> > -#define KVM_CPUID_FLAG_SIGNIFCANT_INDEX		(1 << 0)
>=20
> The typo is in the original kernel header and we periodically copy it
> over with scripts/update-linux-headers.sh, so this change would only add
> overhead in the long run.

Yes. I see that now.

>=20
> I'd keep the typo.

Sure. I will drop this patch. Let me not complicate things.

>=20
> (The alternative is to add KVM_CPUID_FLAG_SIGNIFICANT_INDEX to the
> linux
>  header, so there would be both variants and use the correct one here.)
>=20
> Thanks.
>=20
> > +#define KVM_CPUID_FLAG_SIGNIFICANT_INDEX	(1 << 0)
> >  #define KVM_CPUID_FLAG_STATEFUL_FUNC		(1 << 1)
> >  #define KVM_CPUID_FLAG_STATE_READ_NEXT		(1 << 2)
> >
> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > index ad4b159..85856b6 100644
> > --- a/target/i386/kvm.c
> > +++ b/target/i386/kvm.c
> > @@ -844,7 +844,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >                      break;
> >                  }
> >                  c->function =3D i;
> > -                c->flags =3D KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> > +                c->flags =3D KVM_CPUID_FLAG_SIGNIFICANT_INDEX;
> >                  c->index =3D j;
> >                  cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c=
->edx);
> >
> > --
> > 1.8.3.1
> >
