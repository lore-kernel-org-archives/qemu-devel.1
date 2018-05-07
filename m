Received: from eggs.gnu.org ([2001:4830:134:3::10]:37666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fFpZa-0003q0-3l
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fFpZV-00063e-QV
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:29:38 -0400
Received: from mail-cys01nam02on0060.outbound.protection.outlook.com
	([104.47.37.60]:18656
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fFpZV-00063F-DF
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:29:33 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Mon, 7 May 2018 23:29:30 +0000
Message-ID: <BL0PR12MB2468AA4663C36704C0BB26B4959B0@BL0PR12MB2468.namprd12.prod.outlook.com>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-5-git-send-email-babu.moger@amd.com>
	<20180507191413.GC13350@localhost.localdomain>
In-Reply-To: <20180507191413.GC13350@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 4/9] i386: Add new property to control
 cache info
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
> Sent: Monday, May 7, 2018 2:14 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel@redhat.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; geoff@hostfission.com;
> kash@tripleback.net; qemu-devel@nongnu.org; kvm@vger.kernel.org
> Subject: Re: [Qemu-devel] [PATCH v7 4/9] i386: Add new property to contro=
l
> cache info
>=20
> On Thu, Apr 26, 2018 at 11:26:44AM -0500, Babu Moger wrote:
> > This will be used to control the cache information.
> > By default new information will be displayed. If user
> > passes "-cpu legacy-cache" then older information will
> > be displayed even if the hardware supports new information.
> > It will be "on" for machine type "pc-q35-2.10" for compatibility.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > Tested-by: Geoffrey McRae <geoff@hostfission.com>
> > ---
> >  include/hw/i386/pc.h | 4 ++++
> >  target/i386/cpu.c    | 1 +
> >  target/i386/cpu.h    | 5 +++++
> >  3 files changed, 10 insertions(+)
> >
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index ffee841..d904a3c 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -327,6 +327,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *,
> uint64_t *);
> >          .driver   =3D "q35-pcihost",\
> >          .property =3D "x-pci-hole64-fix",\
> >          .value    =3D "off",\
> > +    },{\
> > +        .driver   =3D TYPE_X86_CPU,\
> > +        .property =3D "legacy-cache",\
> > +        .value    =3D "on",\
> >      },
> >
>=20
> Looks good, except that we now need pc-*-2.13 machines, and this
> should be moved to PC_COMPAT_2_12.

Ok. Sure. There is no PC_COMPAT_2_12 definition now.  I will add it and inc=
lude this new property.

>=20
> Also, I suggest squashing this with patch 5/9, and applying it
> before patch 3/9.

Ok. Sure.

>=20
> --
> Eduardo
