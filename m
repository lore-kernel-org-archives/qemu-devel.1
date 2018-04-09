Received: from eggs.gnu.org ([2001:4830:134:3::10]:44383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f5cpA-0008R3-Ck
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 15:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f5cp6-00072U-5y
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 15:51:32 -0400
Received: from mail-bn3nam01on0043.outbound.protection.outlook.com
	([104.47.33.43]:2209
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1f5cp5-00071F-UN
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 15:51:28 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Mon, 9 Apr 2018 19:51:24 +0000
Message-ID: <CY4PR12MB176888DEF8DDA722F1F6E64C95BF0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1522186271-27743-1-git-send-email-babu.moger@amd.com>
	<1522186271-27743-5-git-send-email-babu.moger@amd.com>
	<867epg48oh.fsf@profitbricks.com>
In-Reply-To: <867epg48oh.fsf@profitbricks.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 4/9] i386: Add new property to control
 cache info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandr Iarygin <alexandr.iarygin@profitbricks.com>, "mst@redhat.com" <mst@redhat.com>, "marcel@redhat.com" <marcel@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>

> -----Original Message-----
> From: Alexandr Iarygin <alexandr.iarygin@profitbricks.com>
> Sent: Monday, April 9, 2018 12:00 PM
> To: Moger, Babu <Babu.Moger@amd.com>; mst@redhat.com;
> marcel@redhat.com; pbonzini@redhat.com; rth@twiddle.net;
> ehabkost@redhat.com; mtosatti@redhat.com
> Cc: qemu-devel@nongnu.org; kvm@vger.kernel.org; kash@tripleback.net;
> Alexandr Iarygin <alexandr.iarygin@profitbricks.com>
> Subject: Re: [PATCH v5 4/9] i386: Add new property to control cache info
>=20
> Hello,
>=20
> Babu Moger <babu.moger@amd.com> writes:
>=20
> > This will be used to control the cache information.
> > By default new information will be displayed. If user
> > passes "-cpu legacy-cache" then older information will
> > be displayed even if the hardware supports new information.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  include/hw/i386/pc.h | 6 +++++-
> >  target/i386/cpu.c    | 1 +
> >  target/i386/cpu.h    | 5 +++++
> >  3 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index ffee841..9cda1ab 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -327,7 +327,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *,
> uint64_t *);
> >          .driver   =3D "q35-pcihost",\
> >          .property =3D "x-pci-hole64-fix",\
> >          .value    =3D "off",\
> > -    },
> > +    },{\
> > +        .driver   =3D TYPE_X86_CPU,\
> > +        .property =3D "legacy-cache",\
> > +        .value    =3D "off",\
> > +    },\
>=20
> Should be "on". Also note that this introduces extra '\' at the end.

I think, I mis-understood Eduardo's earlier comments.  It should be "on" fo=
r machine type "pc-q35-2.10".
Yes. There is an extra  '\'.  Will remove in next version. I will fix both =
of these in next version. Thanks
=20
>=20
> >
> >  #define PC_COMPAT_2_9 \
> >      HW_COMPAT_2_9 \
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 67faa53..f4fbe3a 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -5132,6 +5132,7 @@ static Property x86_cpu_properties[] =3D {
> >                       false),
> >      DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU,
> vmware_cpuid_freq, true),
> >      DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
> > +    DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, false),
>=20
> I'm wondering the reason why Intel L1 caches aren't shared per threads,
> L2 not shared per threads/cores etc? I mean, changing that will also
> require new compat flag with very similar name.

I am not an expert on this topic. But, yes, If there is any future change i=
n cache topology
then it would require similar change.=20

>=20
> >
> >      /*
> >       * From "Requirements for Implementing the Microsoft
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 806c34b..bbe13f2 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1394,6 +1394,11 @@ struct X86CPU {
> >       */
> >      bool enable_l3_cache;
> >
> > +    /* Compatibility bits for old machine types.
> > +     * If true present the old cache topology information
> > +     */
> > +    bool legacy_cache;
> > +
> >      /* Compatibility bits for old machine types: */
> >      bool enable_cpuid_0xb;
> >
> > --
> > 1.8.3.1
